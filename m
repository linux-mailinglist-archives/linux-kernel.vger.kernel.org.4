Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A745D638BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKYOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKYOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:12:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0EBD4F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:12:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m19so5325743edj.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm7cR6ae+qOInD+66DgxiENpanQtPaQwJadOEH3Sp+I=;
        b=nVWakQVqW5tEZpFHHiKt0Psz1twbLwXTUSuYUj0W6+XMkAH0yLZYOcNvKrUcqZro0h
         acVL/kmiLOek1ZtQC+e1XVOLM9jJwQsPxhdyWJRVMa6JwI0n1TrMMcEXTeSbL3j5JsD+
         3NnSLoa1bjJG0cf7NrxG0WrhZ55LUKll9/IMgc+7oU9LDA1oG2CsbmAbuynewWZsePr5
         htR95SphAqEHdAGqWKnoGeFCR6p1D23GCh4eZvG9stI85P+p49y0q3XIg/1e4KoKZ7Y/
         exd9y9pBkr+QT7lYMOnjfv/IdIM6f5O+fgzrw+z6qx0TWK3dj4ZhTRjdyHCOHZkOK51u
         XS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rm7cR6ae+qOInD+66DgxiENpanQtPaQwJadOEH3Sp+I=;
        b=oUMglIsyvtTyIXLvv3QwILsOP87Dt3LKXQltn4db4z+PQA7tUDlGUTVZOlJi5cLDgI
         ClnU401bsBbHfwfCvqwo8ihLTZqRdXKLR/XJRoAwO2FfG2+DNcx5aK1eviyBM8pqDFur
         0OrD4ggPSPNtBEeyTSgHABOycHKNCbmTSo536TXn1K3vydU4a8yN4tbx8iyhs63lkWi2
         Fb4BQyDJ4SfEeS1HOOtpCjbBbiORj3zeoklprZGLGZh0QU9zt/ZB+w3c6cVGwhghnrlB
         yH9HT3oRpqimo+D3zyQ45G6MUWuo1SsMUPyznlQk462ll9ZMt9UGg0EuRbLKMeAtAstx
         VlVA==
X-Gm-Message-State: ANoB5pk4HEpns/mgvrb6x9gpt4sYG9l0Vt86cT+iWtk5LU5GWu9nJ3Q+
        Jt/ywcAVgsiCgt24fdDDy9ClHOIFyPdqSQ==
X-Google-Smtp-Source: AA0mqf7x6SFiLyww87SyC8IGDI3uH4romvj+1/ZEa3aKkBGiDIMGQ9K99FuPICtZ1IRErGGVVqPvIw==
X-Received: by 2002:a05:6402:5011:b0:469:9c84:3bdd with SMTP id p17-20020a056402501100b004699c843bddmr22477624eda.302.1669385545972;
        Fri, 25 Nov 2022 06:12:25 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id p35-20020a056402502300b00463b9d47e1fsm1805512eda.71.2022.11.25.06.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 06:12:25 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 15:12:24 +0100
Message-Id: <COLFSBYDJQVH.1Q9V9ISPWR6ZX@otso>
To:     "Johan Hovold" <johan@kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add
 sm6350 compatible
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.13.0
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
 <Y4CP9fwhDXsLu57Q@hovoldconsulting.com> <COLABNHBQ1DG.1PB8SDY3FW1YY@otso>
 <Y4CWoT52Q8jnm/dF@hovoldconsulting.com> <COLE3UWQCQ8R.XY36EY07DDDK@otso>
 <Y4DImjwHQNlWPEKh@hovoldconsulting.com>
In-Reply-To: <Y4DImjwHQNlWPEKh@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 25, 2022 at 2:52 PM CET, Johan Hovold wrote:
> On Fri, Nov 25, 2022 at 01:53:25PM +0100, Luca Weiss wrote:
> > > Parent clocks (ref_clk_src) should not be included in the binding, bu=
t
> > > rather be handled by the clock driver. For example, see:
> > >
> > > 	https://lore.kernel.org/all/20221121085058.31213-4-johan+linaro@kern=
el.org/
> > > 	https://lore.kernel.org/all/20221115152956.21677-1-quic_shazhuss@qui=
cinc.com/
> >=20
> > So I assume you mean that I shouldn't do this:
> >=20
> > clocks =3D <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> >      <&rpmhcc RPMH_QLINK_CLK>,
> >      <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> >      <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> > clock-names =3D "aux", "ref", "com_aux", "usb3_pipe";
> >=20
> > But for "ref" use GCC_USB3_PRIM_CLKREF_CLK? That also seems to work
> > fine, also if RPMH_QLINK_CLK is not used from Linux-side (checked in
> > debugfs).
>
> Exactly. Since the vendor dts describes RPMH_QLINK_CLK as parent of ref,
> I'd suggest modelling that in the clock driver. Perhaps it has just been
> left on by the boot firmware. Someone with access to docs may be able
> explain how it is supposed to be used.

RPMH_QLINK_CLK is also in msm-4.19 ref_clk_src for
GCC_UFS_MEM_CLKREF_CLK (ufsphy_mem) and also ref_clk (ufshc_mem).

Honestly since it works fine without adding this to gcc driver and I
don't really know much about clk (and have no docs for this) would it be
okay to just ignore RPMH_QLINK_CLK?

>
> > And for the driver patch, I've discovered that this phy doesn't have
> > separate txa/tbx region, so dts was also wrong there. Do you know if
> > there's a way to test DP phy initialization without having all the USB-=
C
> > plumbing in place? Might be good to validate at least phy init works if
> > we're already touching all of this.
>
> Do you mean that it appears to work as sc8280xp with txa/txb shared by
> both the USB and DP parts?

Yes, looks like it. Can't find any evidence pointing in any other
direction at least, everything I've seen shows .txa =3D 0x1200 & .txb =3D
0x1600.

>
> I guess you need a proper setup to test it properly. Not sure what
> you'll be able to learn otherwise, apart from whether it passes basic
> smoke testing.

Currently it's not even smoke testing because dp phy is never getting
enabled because there's no consumer. That's why I guess it was never
noticed it's wrongly described in dts.

Regards
Luca

>
> Johan

