Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC06C3C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCUUkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCUUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:40:54 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1F4BE96;
        Tue, 21 Mar 2023 13:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679431205; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eMebHPc2LM8xLDphDTnocKP/1MSh5YMUKpgh2LpPy+0SQbkQhZZOMyaI11u04XLNRQ
    YvnfgUsj96ZolsoonZ8HQFZlPPx8yIwshH8Wd4nEvpgNPHCyvfSgCCjlSyTb2Dm9/lW2
    Bi/xB47V0aFw5BGatndWJAhnCuIi1b2WqE6p6E2/ML8e5oKCIp0pKsHB/wt9wQwPwx0c
    3cHbg3Y+lGUgIh8yw3PJuMi1vr5FWbQRWIkqPiDD4LBRHlNEKYPY4hLdattGC+uHtjRJ
    EfAmyuHkXNUlG4qOOuTGDQ0eU9J6JRurbV/s6Tg8tgQMCNjcvwrI3hox1+UlSuPQZ2kb
    K+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679431205;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=aWh6UiNnEOLFV3DhyGT5cz+fAZfvHObUYCvhvU5nNCs=;
    b=P/cBCT9KxxSIwrPo4wL+vHRmMXcLDCcoOynVUGH0OItJVGC5qdwT8lSwTaqyM7KrC4
    TX5z/Lceojvg3dXbZzkWyVI7xHe4z7HRxAHx4BmuZkgYH66kfwJX4F3GXjc543deQsc9
    /y6Pc2bUFTM6+5p77CZYHluJRZ8HxIwr4k++5nCaPsHHzkzVfCV0FB7RnmAMVG6hBnKW
    T1ig1MshtQWrDGpjqBq/fvOVXiV42sbGuz05cZ1qwO7Js4SpfPK+SPzXVtXeOQI1kf7D
    Dg6PsOH4UD4xuFqk6po6i4lEQdsEEuO8LMA+X5fbDoEWrsYegLd/GnCiKVKydB3JWgTT
    2Baw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679431205;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=aWh6UiNnEOLFV3DhyGT5cz+fAZfvHObUYCvhvU5nNCs=;
    b=i+5sjO8a9NUr5DUdmLImFHImwjzjUx8cOSGObfGbyQurtv1r6FLtd893HAHGBhm5YA
    T86aHGPmtg6GJ8zzaIlLHVNXxMepKo3KY5Ke+cVubkt9MupEXE3/uEtbAbk80b0E0t2c
    IZ4cFSbhTDhMyG5l83ifFewck3k2wWEEM5IIXe4kv8r7ZHSePQ0KUMiVVRFD05YDrOUA
    lXoRk6T1+pkJEWBGQL0AT2sXEYkmNxxGVV6/1LGMFILHXJhrkMnPwuHb+MIANxPUKFFz
    ZCSQXx1GNrm3REEK0s3EhBS3qLjJqBxDdDLYBhTLZzMHhb4ouXI6BP+Yb4107FC0EG0S
    8bjw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZizY="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.1 DYNA|AUTH)
    with ESMTPSA id R24ce1z2LKe5KrW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 21 Mar 2023 21:40:05 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 0/3] iio: adc: palmas_gpadc: add iio events
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230319223908.108540-1-risca@dalakolonin.se>
Date:   Tue, 21 Mar 2023 21:40:04 +0100
Cc:     linux-iio@vger.kernel.org,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, jic23@kernel.org, lars@metafoo.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <F099D3A8-5A60-47F4-A329-3AE6CF82848A@goldelico.com>
References: <20230319223908.108540-1-risca@dalakolonin.se>
To:     =?utf-8?Q?Patrik_Dahlstr=C3=B6m?= <risca@dalakolonin.se>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrik,

> Am 19.03.2023 um 23:39 schrieb Patrik Dahlstr=C3=B6m =
<risca@dalakolonin.se>:
>=20
> These changes are based on [1] and [2].
>=20
> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. This can be
> configured statically with device tree todayi, but it only gets =
enabled
> when reaching sleep mode. Also, it doesn't look like anyone is using =
it.
>=20
> Instead of this one special case, change the code so userspace can
> configure the ADC channels to their own needs through the iio events
> subsystem.
>=20
> Thresholds and events were tested on omap5-uevm board. It should still
> be possible to wake up from sleep mode on events, but my board don't
> like sleep. A userspace tool for monitoring events and adjusting
> thresholds can be found at [3].
>=20
> [1] =
https://patchwork.kernel.org/project/linux-iio/patch/20230318163039.56115-=
1-jic23@kernel.org/
> [2] =
https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.188174=
5-1-risca@dalakolonin.se/
> [3] https://github.com/Risca/pyra_vol_mon

nice to see the code here!

I haven't tested it yet and will just comment from code inspection.

Maybe it could be good to add linux-omap@vger.kernel.org because the =
Palmas is mostly used for OMAP devices.

BR,
Nikolaus

>=20
>=20
> Patrik Dahlstr=C3=B6m (3):
>  iio: adc: palmas_gpadc: add support for iio threshold events
>  iio: adc: palmas_gpadc: remove adc_wakeupX_data
>  iio: adc: palmas_gpadc: remove palmas_adc_wakeup_property
>=20
> drivers/iio/adc/palmas_gpadc.c | 527 +++++++++++++++++++++++++++------
> include/linux/mfd/palmas.h     |   8 -
> 2 files changed, 434 insertions(+), 101 deletions(-)
>=20
>=20
> base-commit: 37fd83916da2e4cae03d350015c82a67b1b334c4
> prerequisite-patch-id: 9b1f55610800b91b721d042bf7f33b58179237d1
> prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0
> --=20
> 2.25.1
>=20

