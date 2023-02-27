Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9416A4632
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjB0Pjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjB0Pjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:39:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B853018B02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:39:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ee7so27634125edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rJXB+iEam6DW138ELfP7qcmmpR4Y/Uxd0mnWuUGBS30=;
        b=QK2uT+9EbblWEV1f/7DsHEsS5gtxZBG7/6IeI5NzEyhRJHS8OfYacsvQzq/JTeQ9m9
         Ze9UUkQgx2b3SKq4WOcRLKZ8L03yoVs2k0CV4OsSihxCLcXbypv7uX29Ib0JVX/ekqQU
         1Uh6a4pYkCHeexzbuHkPuhArNDzWD28yatc60oZ/gV0a/NmQCdmB0ho30dmJnFQY+A/5
         foU0t3Oan12SF1dIDb03xbKLin7eg9yWGXmFdGwpUBAJgNN0aV2tHkJA+duGC+iqw/2X
         97q5Kf+A/Mrqzzi/6zRiu/lmhg2j7B9zZIaLZqTBcJw2bM6qzBCyXYNldqNuPRsbWjWU
         kEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJXB+iEam6DW138ELfP7qcmmpR4Y/Uxd0mnWuUGBS30=;
        b=uaF0qicyioT+nfgFmEd0eu7GKho1+ycDYAkMKrIOLpSUauh3ZXcWCN/n1RMom7vUUI
         524YCAbEa2Bp4KjvLuHuIrqEsuWhCzLyFzJPIHYp5x2sEaM6NIbtiD5UH/qQzKQpyATM
         1Up9OFeigFGuKPcozc81sE47ksUhZAiksf4nVEOYfm7TMnmMdRbGxVRjGAia3+YCeMPo
         PyV7kv4Sxj9XZHDWy5gmOg7N5j5oIMqez2uCh7d4gXaL85Qaaut9rIIBWj7RGHOE1gjJ
         spzSqceJEjkVwg/TJZmT8oIc0q6+dLiTKkfxMlIsTfQpmpNBH6Twvyb3/8eR75c2e+qM
         bGLw==
X-Gm-Message-State: AO0yUKUz/ZPkvxfAlN66EEdg2MSKlQdrnuPShccrNFhPmYb8mbOvgp0F
        P+eQCHQT9uVELs/ArXiYLS0eEg==
X-Google-Smtp-Source: AK7set/Gmh6PCn5iZtjvDOdCbd5sn0yjN5JRBObxoLJxNyLI85wyrGw/Kw3riG+LciljWDq6SM0RBw==
X-Received: by 2002:a17:906:d90:b0:7d3:c516:6ef4 with SMTP id m16-20020a1709060d9000b007d3c5166ef4mr33269330eji.20.1677512365237;
        Mon, 27 Feb 2023 07:39:25 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090619ce00b008f14cc5f2e4sm3357822ejd.68.2023.02.27.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:39:24 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <Y/zKQx6IRirQpoIf@minwoo-desktop>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Mon, 27 Feb 2023 16:36:15 +0100
In-reply-to: <Y/zKQx6IRirQpoIf@minwoo-desktop>
Message-ID: <87wn4386dw.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Minwoo Im <minwoo.im.dev@gmail.com> writes:

> On 23-02-24 21:05:01, Andreas Hindborg wrote:
>> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +			     unsigned int nr_zones, report_zones_cb cb,
>> +			     void *data)
>> +{
>> +	struct ublk_device *ub;
>> +	unsigned int zone_size;
>> +	unsigned int first_zone;
>> +	int ret = 0;
>> +
>> +	ub = disk->private_data;
>> +
>> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
>> +		return -EINVAL;
>> +
>> +	zone_size = disk->queue->limits.chunk_sectors;
>> +	first_zone = sector >> ilog2(zone_size);
>> +	nr_zones = min(ub->ub_disk->nr_zones - first_zone, nr_zones);
>> +
>> +	for (unsigned int i = 0; i < nr_zones; i++) {
>> +		struct request *req;
>> +		blk_status_t status;
>> +		struct blk_zone info = {0};
>> +
>> +		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
>> +
>> +		if (IS_ERR(req)) {
>> +			ret = PTR_ERR(req);
>> +			goto out;
>> +		}
>
> Can we just return directly just like above (-EINVAL)?
>
> if (IS_ERR(req))
> 	return PTR_ERR(req);

Yes, I agree.

>
>> +
>> +		req->__sector = sector;
>> +
>> +		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
>> +				      GFP_KERNEL);
>> +
>> +		if (ret)
>> +			goto out;
>
> If we really have to use goto here, then I think we have choices:
> put blk_mq_free_request(req); here or put it to the out: area.

Lets free here and drop the goto.

Thanks,
Andreas

>> +
>> +		status = blk_execute_rq(req, 0);
>> +		ret = blk_status_to_errno(status);
>> +		if (ret)
>> +			goto out;
>> +
>> +		blk_mq_free_request(req);
>> +
>> +		ret = cb(&info, i, data);
>> +		if (ret)
>> +			goto out;
>> +
>> +		/* A zero length zone means don't ask for more zones */
>> +		if (!info.len) {
>> +			nr_zones = i;
>> +			break;
>> +		}
>> +
>> +		sector += zone_size;
>> +	}
>> +	ret = nr_zones;
>> +
>> + out:
>> +	return ret;
>> +}

