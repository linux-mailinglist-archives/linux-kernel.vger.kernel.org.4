Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90803687CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjBBMLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBBMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:11:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF78DAC4;
        Thu,  2 Feb 2023 04:11:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t7so1514682wrp.5;
        Thu, 02 Feb 2023 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3h/Avsg9llMSmsRpRzQZ6gQ0I+FoXYp7Hs1A3gdTcCk=;
        b=RmJpNrOke90Ddh0UWKiW/Ud5p61eVG4CIFb35LnraOEhz5hFrTo2ehKglhvbEBWuSK
         ZQQD9jtI02WcPqK1tpfd2zg/7oOi1qUEaChq9CIcypf2Hnd2HHl122xDmkulva/BYlqX
         ZsrobUEmwCN5FS0mZO2XnEllvvwlYDVOATtKJkbzn+UA/9OZnaO5AUXpYZbBz2H/fmeU
         QZT/EMIJF9zBJoiTSw0AjhaFOwmxGAZv3tliaZ+YqlNG9KI7ZMY4vf587OxW7JwfRE6a
         w5XYEuJtNHXlMrW24mlINiXdlBOOKCplTcauVR5x2M+Dy4rG0lQXC/Qs+E6TL80XiaNk
         w0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3h/Avsg9llMSmsRpRzQZ6gQ0I+FoXYp7Hs1A3gdTcCk=;
        b=MZuEatMJZtYOhj7227bbQTB5Hirb+ArYHRgSK3qH0fOVCOWkxuKFViiHf900WyuTRs
         a9PNYmwQa8yXOkdjmx7VPSreuOlZ2+B6mWizibmpaSAdhKkswBG1a+nP9Pwg3HF4DJcj
         PbDl2fC6EDErzTIw3x9gPbYQyuiJ82VVH0UVWr5gLkJ30P2UzfO+vhJO9ikgCIfPaRmD
         Tyco09OACvN8Psy7gbhAX2LZmMHzX9WZjTvHg8HVjNKeQSmLCcK+B2xjjENCDnSHOmVJ
         9/Q+zajKdper2DOCHnDNabQfj+2d/qAyIFK9HBUofu6AUAOnFVTcqlCB79uOda3wFbwE
         doqg==
X-Gm-Message-State: AO0yUKUSR3B8IdUQHB2lN23KPtNq0fc1mPXebfoAYldeMC3OJ7ilM35O
        gr9s8Zh1J7buBoMCv/kVyRI=
X-Google-Smtp-Source: AK7set+pEZ+QehHTxPElQjCjON39TU8ocN2F4pODbB0/6N2B4QRQrMY7lHY3S4O1WG8urzJYrCZG9Q==
X-Received: by 2002:a5d:514d:0:b0:2bf:ae1e:84d2 with SMTP id u13-20020a5d514d000000b002bfae1e84d2mr5295276wrt.12.1675339883470;
        Thu, 02 Feb 2023 04:11:23 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:d12e:7ef:c89a:f600? ([2a02:ab88:368f:2080:d12e:7ef:c89a:f600])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d610c000000b0028965dc7c6bsm19484295wrt.73.2023.02.02.04.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:11:23 -0800 (PST)
Message-ID: <4c95d12d5d4c423adf78c2c859c09ea7dfe98740.camel@gmail.com>
Subject: Re: [PATCH 1/2] mfd: sec: Remove PMICs without compatibles
From:   David Virag <virag.david003@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Date:   Thu, 02 Feb 2023 13:11:22 +0100
In-Reply-To: <35911bc7-6973-d4b0-18d4-22e93962f3c5@linaro.org>
References: <20230131183008.4451-1-virag.david003@gmail.com>
         <20230131183008.4451-2-virag.david003@gmail.com>
         <35911bc7-6973-d4b0-18d4-22e93962f3c5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-02 at 12:24 +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 19:30, David Virag wrote:
> > The S5M8751 and S5M8763 PMIC chips have no corresponding compatible
> > values, so since board file support was removed for this driver,
> > there
> > is no way to specify these PMICs as present in boards anymore.
> > Remove leftovers of these chips since it's dead code.
> >=20
> > Signed-off-by: David Virag <virag.david003@gmail.com>
> > ---
>=20
> Thank you for your patch. There is something to discuss/improve.
>=20
> > =C2=A0int sec_irq_init(struct sec_pmic_dev *sec_pmic)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
> > @@ -448,9 +362,6 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (type) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case S5M8763X:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0sec_irq_chip =3D &s5m8763_irq_chip;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case S5M8767X:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0sec_irq_chip =3D &s5m8767_irq_chip;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > diff --git a/include/linux/mfd/samsung/core.h
> > b/include/linux/mfd/samsung/core.h
> > index f92fe090473d..07aae649a86f 100644
> > --- a/include/linux/mfd/samsung/core.h
> > +++ b/include/linux/mfd/samsung/core.h
> > @@ -36,7 +36,6 @@
> > =C2=A0struct gpio_desc;
> > =C2=A0
> > =C2=A0enum sec_device_type {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0S5M8751X,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0S5M8763X,
>=20
> Drop also S5M8763X

Dropping it in the first patch would lead to build errors in the RTC
driver, so I do it in the second patch, but I see that you already
realized this in the 2nd reply.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0S5M8767X,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0S2MPA01,
> > diff --git a/include/linux/mfd/samsung/s5m8763.h
> > b/include/linux/mfd/samsung/s5m8763.h
> > deleted file mode 100644
>=20
>=20
> Best regards,
> Krzysztof
>=20

Best regards,
David
