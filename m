Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BB72A569
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFIVee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjFIVeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACA03A82;
        Fri,  9 Jun 2023 14:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDF661152;
        Fri,  9 Jun 2023 21:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB97C433EF;
        Fri,  9 Jun 2023 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686346465;
        bh=wvXsR8YYzupk8QUsKM9+U5BzFl/Mjd2yhSrjz7bgQiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZtEGLpd0MdzhXbqB+JPymo/6uJHdLjNcnqgs8Iznb2MQtONrGx3vo+N9ubCPrCuql
         tPrnFetQfSVGdIkOuAo+4FIxcfpA00VqzyFCKCRz1SzvmZP5wVca8ZZvJqaJlNAyDu
         xma4qYH4ZPY5gbNvY1v0PgAejAu3+b1ijOsHGdeh3GXH6kE1zkYK3LnRdM9KzYG+P3
         W2xbKDNIWdtOtjq3AfzOX2uW/6WHqf4cvtTUGd9gafhnLB/ZTYVOYwAo7hgT/UhuZX
         nfETW8N6N+HHB8ivgVFYWnuhfddV9ij1Vlwxc0MKMvUyBGW97fsXbITJPZNGSAiMA+
         eKuPQKh2qqXqA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b219ed9915so24917361fa.3;
        Fri, 09 Jun 2023 14:34:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDzrwPa+3J8Tt7wxSX+qCQfJwW1Kv42xwKekWfuBDzvvc/i+7a6H
        SGtUon9/SXKxA4syE3NJIeVIGrxcB2oW76q4dQ==
X-Google-Smtp-Source: ACHHUZ7/YFvr2vQobTtmfQT0oSRk3YiQczXyx7x0ELd+xNr3yIUtzF53BXzTULyGxFje82VegTxIYmK9TO41ea233kE=
X-Received: by 2002:a2e:b0cc:0:b0:2ac:8262:322a with SMTP id
 g12-20020a2eb0cc000000b002ac8262322amr20945ljl.13.1686346463631; Fri, 09 Jun
 2023 14:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230418150606.1528107-1-robh@kernel.org> <9543f619-88fa-8e54-6e9a-4334750e51b4@linaro.org>
 <CAL_Jsq+ZVAZc1nYJVLPQt=KM1qOZrZCrRC4q_o8XQjDdo_NuKA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+ZVAZc1nYJVLPQt=KM1qOZrZCrRC4q_o8XQjDdo_NuKA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 9 Jun 2023 15:34:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMpjW6a4Q6xUX6TEZ+vyLJJn5bDtwEdf_-E=BeA-Z_tA@mail.gmail.com>
Message-ID: <CAL_JsqJMpjW6a4Q6xUX6TEZ+vyLJJn5bDtwEdf_-E=BeA-Z_tA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 1:48=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Apr 19, 2023 at 2:56=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 18/04/2023 17:06, Rob Herring wrote:
> > > The "qcom,paired" schema is all wrong. First, it's a list rather than=
 an
> > > object(dictionary). Second, it is missing a required type. The meta-s=
chema
> > > normally catches this, but schemas under "$defs" was not getting chec=
ked.
> > > A fix for that is pending.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 5 +++=
--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.=
yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> > > index 9412b9362328..4c3e9ff82105 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> > > @@ -144,8 +144,9 @@ $defs:
> > >          enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > >
> > >        qcom,paired:
> > > -        - description:
> > > -            Indicates that the pin should be operating in paired mod=
e.
> > > +        type: boolean
> > > +        description:
> > > +          Indicates that the pin should be operating in paired mode.
> >
> > Current Linux implementation uses it as a generic pinconf param
> > pinconf_generic_params which is parsed by:
> >
> > pinconf_generic_parse_dt_config() -> parse_dt_cfg() ->
> > of_property_read_u32()
> >
> >
> > The pinctrl-spmi-mpp.c driver, using this schema, treat it as a bool,
> > but I still wonder how the code will parse bool with
> > of_property_read_u32(). Maybe it should be uint32 with value of 0 and 1=
?
>
> That should be an error because the length is too short so it should
> go with some default from the code.
>
> Looks like there is no user, though no property could mean keep the
> default/bootloader setting. Can you sort out which type is really
> desired here and hopefully we can get rid of the other type. It's not
> the first case of pinctrl properties with multiple types, but we don't
> really need more.

Still an issue here. Please sort out what functionality QCom wants here.

dtschema (main br) will now throw a warning on it.

Rob
