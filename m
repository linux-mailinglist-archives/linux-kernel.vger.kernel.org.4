Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F496A4194
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB0MTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjB0MS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:18:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704361A4AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:18:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id eg37so24793875edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=JSA9KUyVZjxitTYC4MLG6GFtKgoRKHH9dmJLjfhJi8Q=;
        b=q37SPi07Qltcfa0dYF3AfeDGE6xDhyOo+/JOI8tLXuo/CI+oLdtAkbP4clLPKlbeIx
         ErszWDYhezgPDgGjoAhsT2AWxohg7CAk2l79caNgI1pxYxMaxKLD0F9YHaLvbNsKBUzm
         3f4oIi8+qyks3H5Md/zg61cWlat56IX95qu8MIii3fImQePisC87hlYuadCDlZaCjdI+
         lLJ9qduixwcB8j0FSdQpabamlIfX9IOUbuey4DKIsepjW5MsCDn3BzFQm4yobjvClYCg
         aZjBOo22Agx5avZQttv6guMHrArn8ENpqg+58TgfmvNWOtSwgaU+Da4OJkymqoceeYA4
         asQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSA9KUyVZjxitTYC4MLG6GFtKgoRKHH9dmJLjfhJi8Q=;
        b=hU6aG3NYe/NQXKrh8wjnPbalLgiSazIwKapb33zDCQaFrXytMLrWsR0rVWMu9Q0ib5
         XAd9zmCuqlLfjePjyW/hbslBntGHkHuYNuEUVy958fcQQfLFf1IvOz5AuOfsr2uoxCfQ
         dBAYt9+LBruiL5JPB4oIe39xFBJ35KuwGH5IFNGtcAGns/2lDE5YIvYiZdgeRA4EJsbc
         OF4ThMBB/DqhVSSMDYE5u6wI1arDmEn1SPanPIFscUECFCLAk1RoTLp6OKLyl4XXtIUE
         cxokJygmIeFvQbgPEnqSvMZvwzPYK60W04AScxyvGRHf8iCEa//kLcIIL/IWsgVId+bX
         eQ8g==
X-Gm-Message-State: AO0yUKXrek5TcTcsdeXKT84t6rxur8cVGV9rAfeO1grUM32twD2ivGqy
        EgEyaefDJ/2UM4TGVX8BoMCvcg==
X-Google-Smtp-Source: AK7set/YWThg4XJ194JAlQCwHXk4IRMYlMPcxKBQycRw8MHKqoIe68lHh5W4UkwdNiO87ZozM8/u/w==
X-Received: by 2002:a17:906:2b14:b0:878:72f7:bd87 with SMTP id a20-20020a1709062b1400b0087872f7bd87mr29642944ejg.6.1677500327980;
        Mon, 27 Feb 2023 04:18:47 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170907984900b008df7d2e122dsm3111486ejc.45.2023.02.27.04.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:18:47 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <Y/yD1WMJ5zc7KkBz@x1-carbon>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Mon, 27 Feb 2023 12:59:45 +0100
In-reply-to: <Y/yD1WMJ5zc7KkBz@x1-carbon>
Message-ID: <87ttz79u8p.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Fri, Feb 24, 2023 at 09:05:01PM +0100, Andreas Hindborg wrote:
>> Add zoned storage support to ublk: report_zones and operations:
>>  - REQ_OP_ZONE_OPEN
>>  - REQ_OP_ZONE_CLOSE
>>  - REQ_OP_ZONE_FINISH
>>  - REQ_OP_ZONE_RESET
>> 
>> This allows implementation of zoned storage devices in user space. An
>> example user space implementation based on ubdsrv is available [1].
>> 
>> [1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d92e680dc718cc1f6d
>> 
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>> Changes since v1:
>>  - Fixed conditional compilation bug
>>  - Refactored to collect conditional code additions together
>>  - Fixed style errors
>>  - Zero stack allocated value used for zone report
>> 
>> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202302250222.XOrw9j6z-lkp@intel.com/
>> v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metaspace.dk/
>> 
>>  drivers/block/ublk_drv.c      | 150 ++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/ublk_cmd.h |  18 ++++
>>  2 files changed, 162 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 6368b56eacf1..37e516903867 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/major.h>
>>  #include <linux/wait.h>
>>  #include <linux/blkdev.h>
>> +#include <linux/blkzoned.h>
>>  #include <linux/init.h>
>>  #include <linux/swap.h>
>>  #include <linux/slab.h>
>> @@ -51,10 +52,12 @@
>>  		| UBLK_F_URING_CMD_COMP_IN_TASK \
>>  		| UBLK_F_NEED_GET_DATA \
>>  		| UBLK_F_USER_RECOVERY \
>> -		| UBLK_F_USER_RECOVERY_REISSUE)
>> +		| UBLK_F_USER_RECOVERY_REISSUE \
>> +		| UBLK_F_ZONED)
>>  
>>  /* All UBLK_PARAM_TYPE_* should be included here */
>> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
>> +#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD \
>> +			     | UBLK_PARAM_TYPE_ZONED)
>>  
>>  struct ublk_rq_data {
>>  	struct llist_node node;
>> @@ -187,6 +190,98 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>>  
>>  static struct miscdevice ublk_misc;
>>  
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +static void ublk_set_nr_zones(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_basic *p = &ub->params.basic;
>> +
>> +	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
>> +		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
>> +}
>> +
>> +static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p = &ub->params.zoned;
>> +
>> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
>> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>> +	}
>> +}
>> +
>> +static int ublk_revalidate_disk_zones(struct gendisk *disk)
>> +{
>> +	return blk_revalidate_disk_zones(disk, NULL);
>> +}
>> +
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
>> +
>> +		req->__sector = sector;
>> +
>> +		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
>> +				      GFP_KERNEL);
>> +
>> +		if (ret)
>> +			goto out;
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
>> +#else
>> +void ublk_set_nr_zones(struct ublk_device *ub);
>> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
>> +int ublk_revalidate_disk_zones(struct gendisk *disk);
>
> These are declarations, shouldn't they be dummy definitions instead?

I looked at how nvme host defines nvme_revalidate_zones() when I did
this. The functions become undefined symbols but because the call sites
are optimized out they go away.

>
> e.g.
> static int ublk_revalidate_disk_zones(struct gendisk *disk) { return -EOPNOTSUPP; };

Not sure how this is better?

>
>
> It would be nice if they could be avoided altogether.
>
> Looking how e.g. null-blk and btrfs has solved this:
> https://github.com/torvalds/linux/blob/v6.2/fs/btrfs/Makefile#L39
> https://github.com/torvalds/linux/blob/v6.2/drivers/block/null_blk/Makefile#L11
>
> They have put the zoned stuff in a separate C file that is only compiled
> when CONFIG_BLK_DEV_ZONED is set.
>
> I'm not sure if a similar design is desired for ublk or not.
>
> However, if a similar design pattern was used, it could probably avoid
> some of these unpleasant dummy definitions altogether.

This is the same as I do here, except I put the declarations in the c
file instead of a header. I did this for two reasons 1) there is no ublk
header besides the uapi header (I would add a header just for this), 2)
the declarations need only exist inside ublk_drv.c. For btrfs, null_blk,
nvme, the declarations go in a header file and the functions in question
do not have static linkage.

I could move the function declarations out of the #else block, but then
they would need to be declared static and that gives a compiler warning
when the implementation is not present.

BR Andreas
