Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3626748EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjGEUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGEUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:36:25 -0400
X-Greylist: delayed 218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 13:36:23 PDT
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14619198E;
        Wed,  5 Jul 2023 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Message-Id:
        To:From:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ch8QsoZ57xKqhInAucg2KEU9iJc99iTHFEjakBXMmHY=; b=IqBwySTu/tbgQgnJb9pBqztjly
        F8VPltD6kza90+kMqoMxI0ocizwBeP9Y85eIlboyp/1swhBPEDhndWcbz0WEiuw3uRLBEFbYCRMsX
        Gjs1seNVkG/b6npi5V+aZ7VkuH4pxppr+MX0zQfMPL3jAN99lI6/YRdK2RPsUuKbHRsuszVPXEsfZ
        a9jYxjoQI8+zpgUUyFJYGcjI7R5QROlhd4/xyLtYr129N6rmc99v5UitklD4OHLmElCs/3sA3havr
        k6VcFMDsm4Tduupae9V4GbGNhrbcsejnDMxRpmnKKyttAce7LgYdZkz1TF18xek0raB8mipmV8DHq
        1EnLMEEg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qH9Eb-0003s3-1g; Wed, 05 Jul 2023 22:36:21 +0200
Received: from [80.88.20.1] (helo=localhost)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qH9Ea-0001Sb-EV; Wed, 05 Jul 2023 22:36:20 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 05 Jul 2023 20:36:19 +0000
Subject: Re: [PATCH v1 1/2] arm64: dts: rockchip: Disable HS400 for eMMC on
 ROCK Pi 4
Cc:     <kernel@collabora.com>, "Akash Gajjar" <Akash_Gajjar@mentor.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "FUKAUMI Naoki" <naoki@radxa.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Jagan Teki" <jagan@amarulasolutions.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Pragnesh Patel" <Pragnesh_Patel@mentor.com>,
        "Rob Herring" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   "Folker Schwesinger" <dev@folker-schwesinger.de>
To:     "Christopher Obbard" <chris.obbard@collabora.com>,
        <linux-rockchip@lists.infradead.org>
Message-Id: <CTUIWUIPVCMZ.17974ZYUS1D93@homedev>
X-Mailer: aerc 0.15.2-76-g69094e332779
References: <20230705144255.115299-1-chris.obbard@collabora.com>
 <20230705144255.115299-2-chris.obbard@collabora.com>
In-Reply-To: <20230705144255.115299-2-chris.obbard@collabora.com>
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
>
> While we are here, set the eMMC maximum clock frequency to 1.5MHz to
> follow the ROCK 4C+.
>
> Fixes: 1b5715c602fd ("arm64: dts: rockchip: add ROCK Pi 4 DTS support")
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 907071d4fe80..95efee311ece 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -645,9 +645,9 @@ &saradc {
>  };
> =20
>  &sdhci {
> +	max-frequency =3D <150000000>;
>  	bus-width =3D <8>;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> +	mmc-hs200-1_8v;
>  	non-removable;
>  	status =3D "okay";
>  };

Works as advertised on a RockPi 4b v1.3 with kernel 6.1.37.

Tested-By: Folker Schwesinger <dev@folker-schwesinger.de>

Folker
