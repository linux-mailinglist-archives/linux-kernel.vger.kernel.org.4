Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408666A7FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCBKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCBKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:35:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93F32ED71
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:35:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f11so4123377wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C52m1tVljJD1+vZ8f1h3Rfg+EcUxCxDMLMwQrEVeskg=;
        b=Y4uGA2YtfxC/k4u+qAD3ZoxcQBK4FrMcGo8flvdcH8rOao2YVEz+Cwg6D0vYcIJfzH
         GyC6r/kvfqUYWXNAn3c+En32gETcOv/1pqo7w9pysC6LjcOfkPtBW+QsbdEadZe2OUsw
         tV4XisRy7HsMC/O5VVRaUDeto5Ul5aV3FkU7k/xLMhtWlpiyPltMCNyDz/DXMOvDaoBQ
         2xAJFOK2e5Ru2Grpdf4wmjiufWmWYWMWeK+zATAmWyb7QBD7AWyaW1w2WHok8AyDruOK
         zc9SYdG110FZnQXTkJWXAme8hVl7LFAU3h8bdmqfqsctAykwLBSZJKa9myYvcKLZInLQ
         kdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C52m1tVljJD1+vZ8f1h3Rfg+EcUxCxDMLMwQrEVeskg=;
        b=hDzDFJGeKS9VmJblyQUde1FOWXldpDWJ/DBjdYZK8qzaU8J/PHPlWvri02urtU5/jc
         cDRP57m3gBzyv+PEZucc+ebcO72zhFEDlFdKQIZ5NKXAofpoS/TgB2fdmokmPpqe422p
         Sw+WAUv+JBHLPCIh6t022ri7gVJ1wdELc6IOHotkyKwsDsjAJGS0Ddnl/ILhK19vCUwT
         YJPCqrbMznc5a8MoaUun5om5M/XbwMUGsNnWgyp49TazsVRpnjlHZlsc7gGw8Hzl9SwV
         62D41RhN4o1O7m7gZEIpXgM7gzLS7JFzyr1TiLcpqhkXhpx0NRJJJPqPXmstj+l9Nm+k
         f7vg==
X-Gm-Message-State: AO0yUKViajdky/3gYl6FfYn2lw/XxgMPc1U3VKwJaipUZ39owy6/3fkv
        TRUIWk2WOpXgLkd4qTachfePiQ==
X-Google-Smtp-Source: AK7set8TgU9pB6ImsSse7I0wmVLMeTLVWQIMctXtF6Tm7YmwMYVIjoe1hdG/Rszo0Ql6qKWL9efJUQ==
X-Received: by 2002:a5d:6084:0:b0:2ca:e856:5a4 with SMTP id w4-20020a5d6084000000b002cae85605a4mr1112818wrt.26.1677753312359;
        Thu, 02 Mar 2023 02:35:12 -0800 (PST)
Received: from localhost ([165.225.194.195])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b002c53cc7504csm15329231wru.78.2023.03.02.02.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 02:35:11 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590> <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590> <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Thu, 02 Mar 2023 11:07:15 +0100
In-reply-to: <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
Message-ID: <87h6v3l9up.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Mar 2, 2023 at 5:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>>
>> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
>> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
>> > >
>>
>> ...
>>
>> > >
>> > > I agree about fetching more zones. However, it is no good to fetch u=
p to
>> > > a max, since the requested zone report may less than max. I was
>> >
>> > Short read should always be supported, so the interface may need to
>> > return how many zones in single command, please refer to nvme_ns_repor=
t_zones().
>>
>> blk_zone is part of uapi, maybe the short read can be figured out by
>> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
>> reporting zones.
>
> oops, we have blk_zone_report data for reporting zones to userspace alrea=
dy,
> see blkdev_report_zones_ioctl(), then this way can be re-used for getting=
 zone
> report from ublk server too, right?

Yes that would be nice. But I did the report_zone command like a read
operation, so we are not currently copying any buffers to user space
when issuing the command, we just rely on the iod. I think it would be
better to use the start_sectors and nr_sectors of the iod instead. Then
we don't have to copy the blk_zone_report. What do you think?

BR Andreas
