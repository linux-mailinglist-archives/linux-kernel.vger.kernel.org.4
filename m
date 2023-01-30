Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29CE68039C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjA3B4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjA3B4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:56:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A781C30C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:56:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 88so9771729pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbsyZra58mEhlUtbe8XZnlvDZsRf41VN8Eh1qlolpJw=;
        b=siAqg2duF6x1nu7Ne82yLHnzy54ftgee/J/u27DyTnYMOjohYloXCpCluF3NuUv4UE
         kV234fGepbECZlclrxSYiLhLwnTQEiwdy9Bx41mdHQVNBFHfa02ZwYM1K+4rFu1P0rD0
         LIsonWH4R9xsBiGt5a6C6n8z3lZZ7N0kaaBU7pbwNBZ22SArKC8QXcRNyKDjTJSEx22x
         xqQxO+ymP1cean3JPYvrX+EvspaxtaY+38rAY8W/Iei+e2CBIZMsbet619+MA2YAIwad
         4uwL1UNF/dF/UhePiufxHH5XxYdwgKTbcc9HDORTHuOH20horeYksizV5oxpQHLZgtDz
         7mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbsyZra58mEhlUtbe8XZnlvDZsRf41VN8Eh1qlolpJw=;
        b=esvwt4T3X5zfh4ZEwv+FmVy+qhTmVNdwDWRfHeoP79szyptfokiSO4iwPcNALwgsUw
         bs+XSD3kgvhvBzMr21PJBvGRUBrKwAGwaeSOpM9oWOZBCr0Kt8J+IcwUykz6lDbbgC3m
         WXuuxaSMexW7ADol06i4yHTOW1GBis3LKoWFjMrrsRQm91bGqu7ck6DIwIYmnFJ/GdgY
         vYaaZhH+6YEcYTexOYOJKl3eQXfs49jPjXZ6qJ6APKSbWB4hfvc4KyAf0/ZLEer+lumY
         f49bMLZ5mwsKYNeCdTUwdeqxhxibLeQAMReQxdx6cleADUEUlSh/2FcozxTahEt4jgtt
         aPXA==
X-Gm-Message-State: AO0yUKWRlNtcJ4haaDSZO/WtPowI9cnK9iWiHQhvwe3e4Azj5bHi5Mfx
        Vegw1KE4UMeHv/ue7GJCJVYvAA==
X-Google-Smtp-Source: AK7set/9y3sH8nx1P8xiaK2tCoUXV6wDx3uOqU+hvAwer7AJgeZ7f/lH4Z4Q/tKK4//SuYvvID523Q==
X-Received: by 2002:a05:6a20:d496:b0:bc:36e4:494a with SMTP id im22-20020a056a20d49600b000bc36e4494amr2903790pzb.6.1675043808843;
        Sun, 29 Jan 2023 17:56:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b11-20020a6567cb000000b004e52190d5a7sm2367925pgs.11.2023.01.29.17.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 17:56:48 -0800 (PST)
Message-ID: <310efbe3-fa98-6726-4010-e7137b761647@kernel.dk>
Date:   Sun, 29 Jan 2023 18:56:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: duplicate patches in the device-mapper tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230130124143.210b5149@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230130124143.210b5149@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/23 6:41 PM, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the block tree as different commits
> (but the same patches):
> 
>   08a39c820686 ("blk-iocost: avoid 64-bit division in ioc_timer_fn")
>   11fd02522aae ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
>   204a9e1eeb4b ("blk-iocost: don't allow to configure bio based device")
>   2192a93eb4ac ("ps3vram: remove bio splitting")
>   3187f22498f6 ("drbd: remove unnecessary assignment in vli_encode_bits")
>   346122e09011 ("block, bfq: retrieve independent access ranges from request queue")
>   38d6577f1e01 ("drbd: fix DRBD_VOLUME_MAX 65535 -> 65534")
>   3b1c494c4317 ("block: add a new helper bdev_{is_zone_start, offset_from_zone_start}")
>   3bf6e7ac9a43 ("drbd: remove macros using require_context")
>   419363fec82a ("block: add a BUILD_BUG_ON() for adding more bio flags than we have space")
>   4e952a32301a ("blk-iocost: fix divide by 0 error in calc_lcoefs()")
>   51ec2387623a ("block, bfq: split sync bfq_queues on a per-actuator basis")
>   55ee20573bd6 ("drbd: make limits unsigned")
>   56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
>   5d5ce3a05940 ("block: ublk: fix doc build warning")
>   612307b9e29b ("block: make BLK_DEF_MAX_SECTORS unsigned")
>   615b51f2a7ec ("block, bfq: forbid stable merging of queues associated with dif
> ferent actuators")
>   620183fd3cda ("ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT")
>   6b5bcbd01de8 ("drbd: split off drbd_config into separate file")
>   6e45a73ca9d6 ("drbd: adjust drbd_limits license header")
>   6faa01c8bf3b ("ublk_drv: don't probe partitions if the ubq daemon isn't truste
> d")
>   707107e3c830 ("drbd: drbd_insert_interval(): Clarify comment")
>   7a5841d1701d ("block, bfq: balance I/O injection among underutilized actuators
> ")
>   7a69a19ae640 ("block, bfq: inject I/O to underutilized actuators")
>   7b6a2c89052b ("blk-iocost: check return value of match_u64()")
>   7b810b50390b ("blk-iocost: read params inside lock in sysfs apis")
>   7f0e2433880b ("block: save user max_sectors limit")
>   803e2ec47623 ("block: introduce bdev_zone_no helper")
>   8564135fe5b0 ("block: don't allow multiple bios for IOCB_NOWAIT issue")
>   934f178446b1 ("block: extend bio-cache for non-polled requests")
>   93cfbaba481c ("drbd: split off drbd_buildtag into separate file")
>   961ccca54ad5 ("ublk_drv: add module parameter of ublks_max for limiting max al
> lowed ublk dev")
>   988136a30715 ("nvme: set REQ_ALLOC_CACHE for uring-passthru request")
>   9d1d75e23110 ("drbd: drop API_VERSION define")
>   a2aea8f56f9e ("s390/dcssblk:: don't call bio_split_to_limits")
>   a5d140c503b6 ("ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
> ")
>   aa70bcb25683 ("drbd: interval tree: make removing an "empty" interval a no-op"
> )
>   abc42d89596a ("MAINTAINERS: add drbd headers")
>   ad5572498be1 ("blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_refre
> sh_params()")
>   ba0b61d03ce3 ("block: treat poll queue enter similarly to timeouts")
>   d5ff0182856b ("block, bfq: move io_cq-persistent bfqq data into a dedicated st
> ruct")
>   d66a012deb65 ("ublk_drv: remove nr_aborted_queues from ublk_device")
>   ef0e0afd782e ("block: remove superfluous check for request queue in bdev_is_zo
> ned()")
>   fd44c9c683bc ("block, bfq: split also async bfq_queues on a per-actuator basis
> ")
> 
> It looks like the block tree was rebased ...

It was, to avoid a conflict and second patch issue. Mike, let me know if
rebasing the dm tree is a concern, then we roll back and deal with the
pain instead...

-- 
Jens Axboe


