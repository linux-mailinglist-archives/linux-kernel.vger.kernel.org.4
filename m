Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37827748F13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjGEUk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjGEUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:40:54 -0400
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1851819A3;
        Wed,  5 Jul 2023 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Message-Id:
        To:From:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fwgkD+l/wKF+0W7lw6F3W01TP++bGxB20+3iUOcYWz0=; b=iAqmbQbTpdWxduFtrUHR0hfMSy
        j2HFv1KI0MhPxOOBXI32IAdUmY5+US5owdiWS8qhMPJc17FWHUbWXN9Qg9fC3x+eAwYBaDEnIXUNa
        Ds4GbcMbdPsuuJa/LiUL2YZcQne2tiHzGK78BKSYiBWcqpYLDhzgRMmLddDC/rfi9IaHwOgotB9qp
        rx6VXFmFVak8iqeP7s/U6jkQC9pjlrj1CPHSQOt3qzdxlliXF2xOy1SCs7IX3O0ukSyzcYrk3N/R4
        YThX6eJCKWjURp6+MopvdVuON9zeCaT/lFPkIYqHR6trXl7K7CRLojWTooRjn89jX1OPqKP8QhTz2
        3LYTTfxg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qH9B4-0003aR-7T; Wed, 05 Jul 2023 22:32:42 +0200
Received: from [80.88.20.1] (helo=localhost)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qH9B3-0004zD-F9; Wed, 05 Jul 2023 22:32:41 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 05 Jul 2023 20:32:40 +0000
Subject: Re: [PATCH v1 0/2] Disable HS400 for eMMC on Radxa ROCK 4 SBCs
Cc:     <kernel@collabora.com>, "Akash Gajjar" <Akash_Gajjar@mentor.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "FUKAUMI Naoki" <naoki@radxa.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Jagan Teki" <jagan@amarulasolutions.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Manoj Sai" <abbaraju.manojsai@amarulasolutions.com>,
        "Pragnesh Patel" <Pragnesh_Patel@mentor.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Stephen Chen" <stephen@radxa.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   "Folker Schwesinger" <dev@folker-schwesinger.de>
To:     "Christopher Obbard" <chris.obbard@collabora.com>,
        <linux-rockchip@lists.infradead.org>
Message-Id: <CTUIBFDTG9O8.1XKGSAIMSH7LR@homedev>
X-Mailer: aerc 0.15.2-76-g69094e332779
References: <20230705144255.115299-1-chris.obbard@collabora.com>
In-Reply-To: <20230705144255.115299-1-chris.obbard@collabora.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed Jul 5, 2023 at 4:42 PM CEST, Christopher Obbard wrote:
> There is some instablity with some eMMC modules on ROCK Pi 4 SBCs running
> in HS400 mode. This ends up resulting in some block errors after a while
> or after a "heavy" operation utilising the eMMC (e.g. resizing a
> filesystem). An example of these errors is as follows:
>
>     [  289.171014] mmc1: running CQE recovery
>     [  290.048972] mmc1: running CQE recovery
>     [  290.054834] mmc1: running CQE recovery
>     [  290.060817] mmc1: running CQE recovery
>     [  290.061337] blk_update_request: I/O error, dev mmcblk1, sector 141=
1072 op 0x1:(WRITE) flags 0x800 phys_seg 36 prio class 0
>     [  290.061370] EXT4-fs warning (device mmcblk1p1): ext4_end_bio:348: =
I/O error 10 writing to inode 29547 starting block 176466)
>     [  290.061484] Buffer I/O error on device mmcblk1p1, logical block 17=
2288
>     [  290.061531] Buffer I/O error on device mmcblk1p1, logical block 17=
2289
>     [  290.061551] Buffer I/O error on device mmcblk1p1, logical block 17=
2290
>     [  290.061574] Buffer I/O error on device mmcblk1p1, logical block 17=
2291
>     [  290.061592] Buffer I/O error on device mmcblk1p1, logical block 17=
2292
>     [  290.061615] Buffer I/O error on device mmcblk1p1, logical block 17=
2293
>     [  290.061632] Buffer I/O error on device mmcblk1p1, logical block 17=
2294
>     [  290.061654] Buffer I/O error on device mmcblk1p1, logical block 17=
2295
>     [  290.061673] Buffer I/O error on device mmcblk1p1, logical block 17=
2296
>     [  290.061695] Buffer I/O error on device mmcblk1p1, logical block 17=
2297
>
> Disabling the Command Queue seems to stop the CQE recovery from running,
> but doesn't seem to improve the I/O errors. Until this can be investigate=
d
> further, disable HS400 mode on the ROCK Pi 4 SBCs to at least stop I/O
> errors from occurring.

Thanks for the patches! This issue lately got some attention on the
Radxa forums so thanks for bringing it to the kernel lists.

As a user who was hitting this issue some time ago I'd like to share the
observations I made during my testing:

I've seen these EMMC issues on several RockPi4 boards (4b v1.4, 4b v1.5,
4SE and 4b+ v1.73), with different EMMC modules (3 Foresee, 1 Samsung)
and throughout different kernels (v6.1.8 through 6.1.37, 6.3,
6.3.0-rc7-next-20230421).

However, with this vendor image [1] that uses kernel
4.4.154-116-rockchip-g86a614bc15b3 all of the EMMC modules work just fine.
The same holds true for another vendor image with kernel
4.4.154-00039-g00fccd37c63c-dirty.

The interesting thing here is, that both 4.4 kernels have HS400 enabled
(and max-frequency=3D<150000000> set) in their respective device-trees.
This can be checked in the vendor kernel repo for
4.4.154-116-rockchip-g86a614bc15b3 [2] and for
4.4.154-00039-g00fccd37c63c [3].

Kind regards

Folker


[1]: https://github.com/radxa-build/rock-pi-4b/releases/download/main-df04b=
3af/rockpi-4b-debian-buster-xfce4-arm64-20220401-0335-gpt.img.xz
[2]: https://github.com/radxa/kernel/blob/86a614bc15b3b1aeb3a9a9e395aedd088=
c70e35e/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
[3]: https://github.com/radxa/kernel/blob/00fccd37c63cd51b2ae9b3af965f975c5=
61674b1/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi

>
> Christopher Obbard (2):
>   arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
>   arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+
>
>  arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts | 3 +--
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

