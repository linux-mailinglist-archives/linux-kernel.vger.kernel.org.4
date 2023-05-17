Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE447062BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjEQI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEQI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:26:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6412D3AB0;
        Wed, 17 May 2023 01:26:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso554840a91.2;
        Wed, 17 May 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684311979; x=1686903979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTc75nBooVuD86e3sizZpv99O1kaziV5RzesGn9lJ30=;
        b=fN7P3xozEcsdZ4tKVtucSdhKOuWQ/7nxXF++xcFuu9tZMOCdXRPPK29xCPtANLYhw3
         L1xJlALCPenPxQeO6DFFYCvvaak4kjFAMGJiniyPGzO2WIN5i+jEERe0QQmMr0EquT9x
         IFlLbuGe3SEu4WtHB1MbPEBglsjbPoP4EQF5VcP40O37Mct922mgznPv9TmSdkPwQXZJ
         vmkjadqcPkQ3/K7ubFULfg0Fsxv4Gykav5nopIE5b0J+KYbFMEImZRI4C2zJCHePcC4n
         n4kXPIz1s6OEIRrQYAt+Xp5Z2gomExmQZ+MrV1QfwCORNM/DglZ3Q7KOgYzJ7vuz65Fb
         Wk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684311979; x=1686903979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTc75nBooVuD86e3sizZpv99O1kaziV5RzesGn9lJ30=;
        b=FUjy4CsQMyOAXqbALrfeFWSUOw6fKZhceps8aHb1QtrXlHPbXCq25ZMhOKpB/T4dAx
         htQj5NlpvXwmfKwME9XWA/WQJCmk0QZO7DCte2hD0FJOZZpxruvQ1MscjDi0n0ouLrGL
         d2dBB/vwF5q9Lsq/EgSwf2MXOTndVU+1HavB8EbZe8uZVvHfx+k5ddFXeIY/JaEePz4D
         Z0w9bf4frMbKjQDjN4kjGEnkhLQyErdXuTQGl17LeLLfYULaqF68bNkwx+OMuUDlXc4X
         9mWzENYtXoJTeXdkC5Zz8PIx/zU3y+uNTLsu5a0CxqVnyz1qb9GUfif4q4FDrxJvJtad
         YAoA==
X-Gm-Message-State: AC+VfDxyyQ/wIfTh1nJi3F89u6LFQXUwAmcHcmb53Wded1jIRFm/cDrH
        tWijPdXIU7yMSHUF0CK32JzOxhsL7Hlf3zqjAyg=
X-Google-Smtp-Source: ACHHUZ6bgofSXXBFEOG6jSKDxllcNZzxOXpx6wxTEuak6lNpoNIQxC2rjFfGBur9TQ5JF9psG0xbQnXhKF31UrkSD4g=
X-Received: by 2002:a17:90b:3a8e:b0:247:6ead:d0ed with SMTP id
 om14-20020a17090b3a8e00b002476eadd0edmr40836957pjb.28.1684311978781; Wed, 17
 May 2023 01:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de> <20230511231317.158214-2-bstruempfel@ultratronik.de>
 <ZF2y1YNkSbXzRm4V@finisterre.sirena.org.uk> <CAEktqcthEG=AWTk9VcVkwexH6xV_xHw1hqxkkPkD=d1NqPKqSg@mail.gmail.com>
 <ZGF+Ei5sn4ci41LU@finisterre.sirena.org.uk>
In-Reply-To: <ZGF+Ei5sn4ci41LU@finisterre.sirena.org.uk>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Wed, 17 May 2023 10:26:07 +0200
Message-ID: <CAEktqcsYDn8Gncf8Mk-7dCX+qA=ZTAu_JFTNi-KL0UjPnmG=pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: Introduce spi-mosi-idle-low flag
To:     Mark Brown <broonie@kernel.org>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feedback

Am Mo., 15. Mai 2023 um 02:34 Uhr schrieb Mark Brown <broonie@kernel.org>:
>
> On Fri, May 12, 2023 at 08:54:19AM +0200, B=C3=B6rge Str=C3=BCmpfel wrote=
:
> > Am Fr., 12. Mai 2023 um 05:30 Uhr schrieb Mark Brown <broonie@kernel.or=
g>:
>
> > > If this is always required for a given device (which I'd expect to be
> > > the case) why configure it through DT?  I know we've got some legacy
> > > stuff like that but not all legacy DT choices were good and no need t=
o
> > > continue the pattern.
>
> > Yes this will always be the case for specific spi-device, spi-controlle=
r
> > combinations. Just to make sure, that I understand your suggestion
> > correctly: You propose to check from the specific spi-device-driver, if
> > the spi-controller supports this particular mode-bit, and then set it i=
f
> > it does and thereby loose the need for the DT entry completely?
>
> Yes, we shouldn't need DT here.  Though the device should just be
> setting this unconditionally if it's always required.

I agree with you, that we should not need DT here. I will remove the
dt-binding in the next patch version.

However I am not so sure about setting it unconditionally, since this
is dependent on the spi-controller. Not all spi-controller show this
behavior, that they use a high mosi line in idle mode and have the
ability to change this. As far as I know, another common behavior
is that the mosi just keeps the last state which it transmitted. In this
case, devices like Neopixel would still work without this mode bit.
