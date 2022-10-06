Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E105F634C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiJFJID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJFJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:08:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80897EC5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:07:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u10so1690689wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1aJ5REXRMTq1sh1mUk4G4sr0eg6/nM0EyPCJJ1eSDvw=;
        b=oj64Vi+eOZpuQI+htjvWY8sZHF5q7NbF+S/U6svj8thZ8X+Vg61vlsVc/qwgGMjZPa
         VXvzaKeVOCf0sB0AzJGjZIAqfcpn0ScowzTj6E2p3tNJjjJFXlcuAxAxwbmYjy2X4PxD
         p5817amn3pGou9aDw3/3LN7zIHRtbNzeztLeODaCwncXV9oP4atBx6VB6dzF8F3BKapK
         8eq4LlFlCBqQ4Cc07YqQahf8C0LJxg4oWEy3v3wrV+QakfsJ2mtsguJXew72RomAcHro
         r2hI6ZgNVmzk3lDJEllh7IW2xAz8etTQX5Bo6N2ds44bV2iJpDX7XuEyc+8VFIfw5J7M
         vpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1aJ5REXRMTq1sh1mUk4G4sr0eg6/nM0EyPCJJ1eSDvw=;
        b=vIWO8c4ObeEQ14z38U+je+2aYw8AaD7I+WCE3rt4sL0LVBeN0ersva5JS4W1cIDtyw
         VEmkeb4j9HLn854clN4k7B8gXB2NEKBFzeKZYz6/nDP/x9iszXuibWKG/KsnBJu6lUdO
         gotzkcXTQxd4xC+zyWZ5OtyQhFcWZy5s7VDDVGtUpVqB0L8xb6ayawk9zAG+2cl/Sn92
         hIIYr7aJXAIt9sQD6jUxKrCdsZb26A4i/0hLg+1uPYspPwonzLmzmTec+DSFRqA/TPcp
         UgRDCS/EUE9VVsHxMh3BCtnxLgqO/4WotVuAkDaDKBKnxR0kgbPLjo4NTDd+zvF8HoOW
         v+tg==
X-Gm-Message-State: ACrzQf2QZSWG7EFdOKiNBszmw0KRRQbqFiznEs8zeuUswnq3rpGcMPYJ
        pGZWfZHJO2QnTRUzG/GtfvpDhDFAMl3UpXe6
X-Google-Smtp-Source: AMsMyM4T3aR66ySnGUYOn1F8FVH43uhaw24LlS828ZglEOXX6NaXvHYdoyqonBfmR2ibWCuDf+ldjg==
X-Received: by 2002:a5d:4889:0:b0:22b:214:38dd with SMTP id g9-20020a5d4889000000b0022b021438ddmr2603126wrq.32.1665047276144;
        Thu, 06 Oct 2022 02:07:56 -0700 (PDT)
Received: from [10.43.66.1] (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id l20-20020a1c7914000000b003b47ff307e1sm873687wme.31.2022.10.06.02.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:07:55 -0700 (PDT)
Message-ID: <892bcf4d-70d9-8833-9449-c55fa719158e@linbit.com>
Date:   Thu, 6 Oct 2022 11:07:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/5] treewide: use prandom_u32_max() when possible
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
References: <20221005214844.2699-1-Jason@zx2c4.com>
 <20221005214844.2699-2-Jason@zx2c4.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221005214844.2699-2-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.22 23:48, Jason A. Donenfeld wrote:
> Rather than incurring a division or requesting too many random bytes for
> the given range, use the prandom_u32_max() function, which only takes
> the minimum required bytes from the RNG and avoids divisions.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/mm/pat/cpa-test.c                    |  4 +-
>  crypto/testmgr.c                              | 86 +++++++++----------
>  drivers/block/drbd/drbd_receiver.c            |  4 +-

For the drbd part:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

>  drivers/infiniband/core/cma.c                 |  2 +-
>  drivers/infiniband/hw/cxgb4/id_table.c        |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_ah.c       |  5 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  3 +-
>  drivers/mmc/core/core.c                       |  4 +-
>  drivers/mmc/host/dw_mmc.c                     |  2 +-
>  drivers/mtd/nand/raw/nandsim.c                |  4 +-
>  drivers/mtd/tests/mtd_nandecctest.c           | 10 +--
>  drivers/mtd/tests/stresstest.c                | 17 +---
>  drivers/mtd/ubi/debug.c                       |  2 +-
>  drivers/mtd/ubi/debug.h                       |  6 +-
>  drivers/net/ethernet/broadcom/cnic.c          |  3 +-
>  .../chelsio/inline_crypto/chtls/chtls_io.c    |  4 +-
>  drivers/net/hamradio/baycom_epp.c             |  2 +-
>  drivers/net/hamradio/hdlcdrv.c                |  2 +-
>  drivers/net/hamradio/yam.c                    |  2 +-
>  drivers/net/phy/at803x.c                      |  2 +-
>  .../broadcom/brcm80211/brcmfmac/p2p.c         |  2 +-
>  .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
>  drivers/scsi/fcoe/fcoe_ctlr.c                 |  4 +-
>  drivers/scsi/qedi/qedi_main.c                 |  2 +-
>  fs/ceph/inode.c                               |  2 +-
>  fs/ceph/mdsmap.c                              |  2 +-
>  fs/ext4/super.c                               |  7 +-
>  fs/f2fs/gc.c                                  |  2 +-
>  fs/f2fs/segment.c                             |  8 +-
>  fs/ubifs/debug.c                              |  8 +-
>  fs/ubifs/lpt_commit.c                         | 14 +--
>  fs/ubifs/tnc_commit.c                         |  2 +-
>  fs/xfs/libxfs/xfs_alloc.c                     |  2 +-
>  fs/xfs/libxfs/xfs_ialloc.c                    |  2 +-
>  fs/xfs/xfs_error.c                            |  2 +-
>  kernel/time/clocksource.c                     |  2 +-
>  lib/fault-inject.c                            |  2 +-
>  lib/find_bit_benchmark.c                      |  4 +-
>  lib/reed_solomon/test_rslib.c                 |  6 +-
>  lib/sbitmap.c                                 |  4 +-
>  lib/test_list_sort.c                          |  2 +-
>  lib/test_vmalloc.c                            | 17 +---
>  net/ceph/mon_client.c                         |  2 +-
>  net/ceph/osd_client.c                         |  2 +-
>  net/core/neighbour.c                          |  2 +-
>  net/core/pktgen.c                             | 43 +++++-----
>  net/core/stream.c                             |  2 +-
>  net/ipv4/igmp.c                               |  6 +-
>  net/ipv4/inet_connection_sock.c               |  2 +-
>  net/ipv4/inet_hashtables.c                    |  2 +-
>  net/ipv6/addrconf.c                           |  8 +-
>  net/ipv6/mcast.c                              | 10 +--
>  net/netfilter/ipvs/ip_vs_twos.c               |  4 +-
>  net/packet/af_packet.c                        |  2 +-
>  net/sched/act_gact.c                          |  2 +-
>  net/sched/act_sample.c                        |  2 +-
>  net/sched/sch_netem.c                         |  4 +-
>  net/sctp/socket.c                             |  2 +-
>  net/sunrpc/cache.c                            |  2 +-
>  net/sunrpc/xprtsock.c                         |  2 +-
>  net/tipc/socket.c                             |  2 +-
>  net/xfrm/xfrm_state.c                         |  2 +-
>  62 files changed, 173 insertions(+), 196 deletions(-)
> 
[...]
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index af4c7d65490b..d8b1417dc503 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -781,7 +781,7 @@ static struct socket *drbd_wait_for_connect(struct drbd_connection *connection,
>  
>  	timeo = connect_int * HZ;
>  	/* 28.5% random jitter */
> -	timeo += (prandom_u32() & 1) ? timeo / 7 : -timeo / 7;
> +	timeo += prandom_u32_max(2) ? timeo / 7 : -timeo / 7;
>  
>  	err = wait_for_completion_interruptible_timeout(&ad->door_bell, timeo);
>  	if (err <= 0)
> @@ -1004,7 +1004,7 @@ static int conn_connect(struct drbd_connection *connection)
>  				drbd_warn(connection, "Error receiving initial packet\n");
>  				sock_release(s);
>  randomize:
> -				if (prandom_u32() & 1)
> +				if (prandom_u32_max(2))
>  					goto retry;
>  			}
>  		}[...]

(Had to cut out most of the CC list because Google complains about "too many
recipients").

--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
