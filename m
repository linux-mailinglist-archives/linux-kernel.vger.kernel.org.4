Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932C74A118
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjGFPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGFPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:35:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D112AA;
        Thu,  6 Jul 2023 08:35:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99342a599e9so107150066b.3;
        Thu, 06 Jul 2023 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688657713; x=1691249713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M/uitRjGuRmzMmSyM4ApavrZukW5U7OcNDtPTc/YVXQ=;
        b=RG65KIIJdMd1VGNtOBPcC1YQsiHPdYkjsacGTz1KP8+bNQ//MY0NPTbgpd/BxU/FLe
         aMePLDxBnVOuyjCss+cx0h6kTvC0R0aE7+Y+fmH+AJpCu2nYqTKD3DsP57vvhItwERTW
         gwcC6oN5x8JLtZQM+2DALPQDhck+ehO4lYm8TXZ++wnLp2FJcGbFol2X3GaBc97mPg1V
         14hGYKYgjIgvm2CS3tEU0nGjE3x7Cw3CsWFkoOtsGoepxT5W9zTJrL4fHWxC957XbXpx
         36gsiKoBEBclZQHB69iUZgSXQXO9UdISjdn1jo0JL+/rGzpzk+oB9lYkooI66SLUj1Kt
         V83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657713; x=1691249713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/uitRjGuRmzMmSyM4ApavrZukW5U7OcNDtPTc/YVXQ=;
        b=ct1AkE8cG4Q0eAGXES37rWckNK0d6R8qBIidR871uSe48vHkmyATSlcfF+P49KseO9
         hBppxMHtDya6e8jbebb4JcawoojMGlr5vtx2VWpNNIu2aRMVzqfMDN5nyfAl2jROtNyO
         TiXjwlE8eyOOGsma2ovl+UiHvF32H5p9eHb+zEGNSPJtldVMmMEW4t3uBxkeoRlTRP+f
         XSQxtq+zJIf2z90O++oSjI0jGQ48diGPNpmsYcGTXaZ6LTDlebwSwywWIqmlnc4iM427
         B1ZtG8sS3YI8IYyNQ22ZyCL6PhpfWH2/WRGs5uOjq1GgRaPniFz3SGfU9GvGCRHUbJMa
         IwNQ==
X-Gm-Message-State: ABy/qLblaF7+yIGgESeuZk0UcJhn4t1EEI1Pz5sn3DucdS/o+/SCWxAO
        JB3q8fPwo2H1ym3MbzW0ZfU=
X-Google-Smtp-Source: APBJJlEepcIxqRzevyC7/Pyw+Ik5jZAAdVE0xCERlU/fWyzM0CRmPaRXMW5KGqHpEwtyECqx92qWQg==
X-Received: by 2002:a17:906:74d7:b0:987:59b6:c9fa with SMTP id z23-20020a17090674d700b0098759b6c9famr2023590ejl.19.1688657712758;
        Thu, 06 Jul 2023 08:35:12 -0700 (PDT)
Received: from [10.0.0.98] (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id gz2-20020a170906f2c200b0098d2d219649sm964147ejb.174.2023.07.06.08.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 08:35:12 -0700 (PDT)
Message-ID: <d4576e776d49498dcc1f82ddf2b81b415e0c6e4b.camel@gmail.com>
Subject: Re: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
From:   Jakub =?iso-8859-2?Q?Van=ECk?= <linuxtardis@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Thu, 06 Jul 2023 17:35:11 +0200
In-Reply-To: <20230705224754.zmffebz2geg3bclh@synopsys.com>
References: <20230630223638.2250-1-linuxtardis@gmail.com>
         <20230705224754.zmffebz2geg3bclh@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-05 at 22:47 +0000, Thinh Nguyen wrote:
> Hi,
>=20
> On Sat, Jul 01, 2023, Jakub Vanek wrote:
> > AutoRetry has been found to cause issues in this controller revision.
> > This feature allows the controller to send non-terminating/burst retry
> > ACKs (Retry=3D1 and Nump!=3D0) as opposed to terminating retry ACKs
> > (Retry=3D1 and Nump=3D0) to devices when a transaction error occurs.
> >=20
> > Unfortunately, some USB devices do not retry transfers when
> > the controller sends them a non-terminating retry ACK. After the transf=
er
> > times out, the xHCI driver tries to resume normal operation of the
> > controller by sending a Stop Endpoint command to it. However, this
> > revision of the controller fails to respond to that command in this
> > state and the xHCI driver therefore gives up. This is reported via dmes=
g:
> >=20
> > [sda] tag#29 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
> > [sda] tag#29 CDB: opcode=3D0x28 28 00 00 69 42 80 00 00 48 00
> > xhci-hcd: xHCI host not responding to stop endpoint command
> > xhci-hcd: xHCI host controller not responding, assume dead
> > xhci-hcd: HC died; cleaning up
> >=20
> > This problem has been observed on Odroid HC2. This board has
> > an integrated JMS578 USB3-to-SATA bridge. The above problem could be
> > triggered by starting a read-heavy workload on an attached SSD.
> > After a while, the host controller would die and the SSD would disappea=
r
> > from the system.
> >=20
> > Reverting b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in
> > the controller") stopped the issue from occurring on Odroid HC2.
> > As this problem hasn't been reported on other devices, disable
> > AutoRetry just for the dwc_usb3 revision v2.00a that the board SoC
> > (Exynos 5422) uses.
> >=20
> > Fixes: b138e23d3dff ("usb: dwc3: core: Enable AutoRetry feature in the =
controller")
> > Link: https://urldefense.com/v3/__https://lore.kernel.org/r/a21f34c0463=
2d250cd0a78c7c6f4a1c9c7a43142.camel@gmail.com/__;!!A4F2R9G_pg!YWgF6oqfuVY6x=
stZmroukjlrwAFEYEQE8uj_iUu4fd10mnJxEPG345k75dMLLdNFP8rT1leok-aPNkz_FuAJ1zxn=
mw$=C2=A0
> > Link: https://urldefense.com/v3/__https://forum.odroid.com/viewtopic.ph=
p?t=3D42630__;!!A4F2R9G_pg!YWgF6oqfuVY6xstZmroukjlrwAFEYEQE8uj_iUu4fd10mnJx=
EPG345k75dMLLdNFP8rT1leok-aPNkz_FuCzOGIVPA$=C2=A0
> > Cc: stable@vger.kernel.org
> > Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > Signed-off-by: Jakub Vanek <linuxtardis@gmail.com>
> > ---
> > =C2=A0drivers/usb/dwc3/core.c | 10 ++++++++--
> > =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index d68958e151a7..d742fc882d7e 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1218,9 +1218,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Host mode on seeing transaction errors(CRC er=
rors or internal
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * overrun scenerios) on IN transfers to reply t=
o the device
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with a non-terminating retry ACK (i.e, an ACK=
 transcation
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * packet with Retry=3D1 & Nump !=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * packet with Retry=3D1 & Nump !=3D 0).
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * Do not enable this for DWC_usb3 v2.00a. This contro=
ller
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * revision stops responding to Stop Endpoint commands=
 if
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * a USB device does not retry after a non-terminating=
 retry
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * ACK is sent to it.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0reg |=3D DWC3_GUCTL_HSTINAUTORETRY;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!DWC3_VER_IS(DWC3, 200A))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg |=
=3D DWC3_GUCTL_HSTINAUTORETRY;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > --=20
> > 2.25.1
> >=20
>=20
> I brought up this inquiry internally. Please wait as I need to review
> this further. The handling for this may be different depending on the
> team's feedback.
>=20

OK; feel free to contact me if I could be of any help.

> Thanks,
> Thinh

Thank you,
Jakub
