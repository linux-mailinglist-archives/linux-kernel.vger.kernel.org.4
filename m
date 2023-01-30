Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD717681B62
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjA3U03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjA3U0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:26:24 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45939B92
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:26:08 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id m15so1028295ilh.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It6Oq5pLM+aYPgdws8NN7/dLOshj19Aw4otSeEUQkUo=;
        b=fo8+vUJ7lUeKYM4EhAIwtXwWs2gG9RGhyDQtbxB0IAiXXeF1h1tUfuMoQ8kzeGJDv6
         mParRK3k0Ru2DlC9Db6RaqQpdjMnOVYODS+xBAwKS5BJbrxyzpNxKSdk7UPRlsg6wJGj
         FbvPMFerPQDTqYjIBoMTlO9XZWIG6XoW7d/9ED05aFwi1zzk0BD27aasy9NdD/INiCKF
         aWrXN7KdAigojxVTLjnltyDoel8zupA9rlt4MQw0Xz7ziZxfDl3qfpLRdou+Pb2wzfxb
         nP4S5TlqIK8t9AdBIReo+FT0pT8CqgijROzj5wIVAlvHuRtEOwxmjnqq1jJvAZp0rddc
         2U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It6Oq5pLM+aYPgdws8NN7/dLOshj19Aw4otSeEUQkUo=;
        b=5LG8xGmzITxYYp6blo3EriTOSOJ6/79oCuQ0sJJlitbe1rqWXXUiiW+ZCXW0Z+kXPc
         sNZiMEaO42FSyeJCRTL3QiOoc0frskAOh2Zdwg1ZX6Eab/AieB5JdMPfh68Aozgh76hV
         H/5TwYqknS8zTnKwvV0/Bgq4C5lZHAr4FavX1vaBU0+zOkcx6S/dAwWOz92JBZVZ95k+
         3Dj7OLfa0nELYQb5KFG+c+WqXxHpKhfrAO4z8geKQl5E2NCvhz9YRnXndZwsruv9zDZF
         F8ifuFePuDDxTpk4AwnCfUaC31mG38JM203FkGCkl3t7pNIi/pfHnpOqhPtXEW7UfRxV
         scLQ==
X-Gm-Message-State: AFqh2kobI+FRnbNrKe/b8l822+vqDvFAs7Z+gp7Kl7Ilh1W6IGHypT47
        PUUqjfFBa+fdmTlx3IeDGkNsXBrHlph+LdMm
X-Google-Smtp-Source: AMrXdXu05NXk+8jPyf4RabrY5Z13PbpNa9lvST/N3+FN9aZVi/QDcSuRy7h8R+L/6gg1Jf6JM8IVUA==
X-Received: by 2002:a92:2a07:0:b0:30c:1dda:42dd with SMTP id r7-20020a922a07000000b0030c1dda42ddmr7331087ile.1.1675110368255;
        Mon, 30 Jan 2023 12:26:08 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a056e02130100b0031097a03904sm4317979ilr.32.2023.01.30.12.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 12:26:07 -0800 (PST)
Message-ID: <bf71a111-21b6-e8b2-9a77-147b74f41b0f@kernel.dk>
Date:   Mon, 30 Jan 2023 13:26:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: duplicate patches in the device-mapper tree
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230130124143.210b5149@canb.auug.org.au>
 <310efbe3-fa98-6726-4010-e7137b761647@kernel.dk>
 <Y9ggLAqnncDMDX+q@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9ggLAqnncDMDX+q@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 12:53 PM, Mike Snitzer wrote:
> On Sun, Jan 29 2023 at  8:56P -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 1/29/23 6:41 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> The following commits are also in the block tree as different commits
>>> (but the same patches):
>>>
>>>   08a39c820686 ("blk-iocost: avoid 64-bit division in ioc_timer_fn")
>>>   11fd02522aae ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
>>>   204a9e1eeb4b ("blk-iocost: don't allow to configure bio based device")
>>>   2192a93eb4ac ("ps3vram: remove bio splitting")
>>>   3187f22498f6 ("drbd: remove unnecessary assignment in vli_encode_bits")
>>>   346122e09011 ("block, bfq: retrieve independent access ranges from request queue")
>>>   38d6577f1e01 ("drbd: fix DRBD_VOLUME_MAX 65535 -> 65534")
>>>   3b1c494c4317 ("block: add a new helper bdev_{is_zone_start, offset_from_zone_start}")
>>>   3bf6e7ac9a43 ("drbd: remove macros using require_context")
>>>   419363fec82a ("block: add a BUILD_BUG_ON() for adding more bio flags than we have space")
>>>   4e952a32301a ("blk-iocost: fix divide by 0 error in calc_lcoefs()")
>>>   51ec2387623a ("block, bfq: split sync bfq_queues on a per-actuator basis")
>>>   55ee20573bd6 ("drbd: make limits unsigned")
>>>   56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
>>>   5d5ce3a05940 ("block: ublk: fix doc build warning")
>>>   612307b9e29b ("block: make BLK_DEF_MAX_SECTORS unsigned")
>>>   615b51f2a7ec ("block, bfq: forbid stable merging of queues associated with dif
>>> ferent actuators")
>>>   620183fd3cda ("ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT")
>>>   6b5bcbd01de8 ("drbd: split off drbd_config into separate file")
>>>   6e45a73ca9d6 ("drbd: adjust drbd_limits license header")
>>>   6faa01c8bf3b ("ublk_drv: don't probe partitions if the ubq daemon isn't truste
>>> d")
>>>   707107e3c830 ("drbd: drbd_insert_interval(): Clarify comment")
>>>   7a5841d1701d ("block, bfq: balance I/O injection among underutilized actuators
>>> ")
>>>   7a69a19ae640 ("block, bfq: inject I/O to underutilized actuators")
>>>   7b6a2c89052b ("blk-iocost: check return value of match_u64()")
>>>   7b810b50390b ("blk-iocost: read params inside lock in sysfs apis")
>>>   7f0e2433880b ("block: save user max_sectors limit")
>>>   803e2ec47623 ("block: introduce bdev_zone_no helper")
>>>   8564135fe5b0 ("block: don't allow multiple bios for IOCB_NOWAIT issue")
>>>   934f178446b1 ("block: extend bio-cache for non-polled requests")
>>>   93cfbaba481c ("drbd: split off drbd_buildtag into separate file")
>>>   961ccca54ad5 ("ublk_drv: add module parameter of ublks_max for limiting max al
>>> lowed ublk dev")
>>>   988136a30715 ("nvme: set REQ_ALLOC_CACHE for uring-passthru request")
>>>   9d1d75e23110 ("drbd: drop API_VERSION define")
>>>   a2aea8f56f9e ("s390/dcssblk:: don't call bio_split_to_limits")
>>>   a5d140c503b6 ("ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
>>> ")
>>>   aa70bcb25683 ("drbd: interval tree: make removing an "empty" interval a no-op"
>>> )
>>>   abc42d89596a ("MAINTAINERS: add drbd headers")
>>>   ad5572498be1 ("blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_refre
>>> sh_params()")
>>>   ba0b61d03ce3 ("block: treat poll queue enter similarly to timeouts")
>>>   d5ff0182856b ("block, bfq: move io_cq-persistent bfqq data into a dedicated st
>>> ruct")
>>>   d66a012deb65 ("ublk_drv: remove nr_aborted_queues from ublk_device")
>>>   ef0e0afd782e ("block: remove superfluous check for request queue in bdev_is_zo
>>> ned()")
>>>   fd44c9c683bc ("block, bfq: split also async bfq_queues on a per-actuator basis
>>> ")
>>>
>>> It looks like the block tree was rebased ...
>>
>> It was, to avoid a conflict and second patch issue. Mike, let me know if
>> rebasing the dm tree is a concern, then we roll back and deal with the
>> pain instead...
> 
> No problem, I rebased DM.

Great, thanks Mike.

-- 
Jens Axboe


