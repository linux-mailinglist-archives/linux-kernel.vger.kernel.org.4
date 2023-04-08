Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4311A6DBA8B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDHLs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjDHLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:48:21 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07474EFB3;
        Sat,  8 Apr 2023 04:48:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1FD19403F0;
        Sat,  8 Apr 2023 13:48:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GKDU6M2RlR7I; Sat,  8 Apr 2023 13:48:14 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 235583F602;
        Sat,  8 Apr 2023 13:48:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 064CB95F7B;
        Sat,  8 Apr 2023 11:48:13 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UDX3bIRx1dzy; Sat,  8 Apr 2023 11:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 3A4AA95F76;
        Sat,  8 Apr 2023 11:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 3A4AA95F76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954490;
        bh=1Xfs4QuNk7u1JxFK8khGp6dL+3lELpSbAKZZs5QjY3A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LPPEtJE/IBcdbYgyuq/Bt0NKaZo743fmotlz7zEtnyNSr5gx5Amz/rwxo26q+6fdC
         2G18bgha6xSnvp1gk87GGePhsEpDNJ2bC+xuvxO16mljojVYU6GZKEwA8VoUeyUKmj
         F9cHGlrDPUEBWH/+6YZvlIW69WfyFVPFVTF8ymdaoB98U7W7jrU7ozDax41IpAXFmy
         /tDQhC4XsQwhZ+UIvxPni2cLc2bKVcawVtzhMAmohVHD6dHGBZtIUE2+tBwd95Ns/7
         d4eiV6FrQJbhD0PP4Q0W55ml+Xvp6oQEGMwPZfYYxL7oQJUP+QRNXuCG1hGUa+Fd6u
         +rD4Q5B8LtXfg==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 60b1eQ-IxT-5; Sat,  8 Apr 2023 11:48:10 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 03E6695F72;
        Sat,  8 Apr 2023 11:48:10 +0000 (UTC)
Date:   Sat, 8 Apr 2023 13:48:08 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iio: adc: palmas_gpadc: add iio events
Message-ID: <20230408114808.GC141200@dalakolonin.se>
References: <20230408114624.824144-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230408114624.824144-1-risca@dalakolonin.se>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please dis-regard this. I sent the wrong version :/


On Sat, Apr 08, 2023 at 01:46:17PM +0200, Patrik Dahlstr=F6m wrote:
> This series is based on linux-next/master [1] and [2].
>=20
> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. This can be
> configured statically with device tree today, but it only gets enabled
> when reaching sleep mode. Also, it doesn't look like anyone is using it=
.
>=20
> Instead of this one special case, change the code so userspace can
> configure the ADC channels to their own needs through the iio events
> subsystem. The high and low threshold values can be set for every
> channel, but only 2 thresholds can be enabled at a time. Trying to
> enable more than 2 thresholds will result in an error.
>=20
> The configured thresholds will wake up the system from sleep mode if
> wakeup is enabled in /sys/devices/.../power/wakeup.
>=20
> The old platform data was removed.
>=20
> Thresholds, events, and wakeup were tested on omap5-uevm board. It wake=
s
> up from sleep mode when wakeup is enabled and a threshold is passed. A
> userspace tool for monitoring events and adjusting thresholds can be
> found at [3].
>=20
> V2 -> V3:
> * Rebased to linux-next.
> * Avoid reconfiguring events on error and when old =3D=3D new value.
> V1 -> V2:
> * Begin by removing adc_wakeupX_data instead of doing it last.
> * Split changes in smaller patches
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> [2] https://lore.kernel.org/linux-iio/20230318163039.56115-1-jic23@kern=
el.org/
> [3] https://github.com/Risca/pyra_vol_mon
>=20
> Patrik Dahlstr=F6m (7):
>   iio: adc: palmas: remove adc_wakeupX_data
>   iio: adc: palmas: replace "wakeup" with "event"
>   iio: adc: palmas: use iio_event_direction for threshold polarity
>   iio: adc: palmas: move eventX_enable into palmas_adc_event
>   iio: adc: palmas: always reset events on unload
>   iio: adc: palmas: add support for iio threshold events
>   iio: adc: palmas: don't alter event config on suspend/resume
>=20
>  drivers/iio/adc/palmas_gpadc.c | 559 +++++++++++++++++++++++++++------
>  include/linux/mfd/palmas.h     |   8 -
>  2 files changed, 464 insertions(+), 103 deletions(-)
>=20
>=20
> base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
> prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0
> --=20
> 2.25.1
>=20
