Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0357F6EB282
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjDUTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjDUTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB4E2719;
        Fri, 21 Apr 2023 12:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 197D46528E;
        Fri, 21 Apr 2023 19:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B092C4339B;
        Fri, 21 Apr 2023 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682106503;
        bh=afKwtupox0lmyEy2Q4gdOb5TNtE8aabXgXrDrNzqgjQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mdShRbtnkd/NaU6+i82tMehIvpm1rVTs3gyCvTnZwKWAzBQO1Mdg9IhK2dMTlGr99
         Sr84VNiUE+nowtLw3xsskiisShEYl+3hUtFymkKi54c1AijWx5ZBidEFzr4znzPEoJ
         KwHYIyA9AXh9hig99chq6vnql+dz/rgrHFTnwteeLMU1fauiWySB8gUgm2SCzcStZa
         esGsaO8Nas7PpjHBcUxkxUXGBbmj7jMSbkEIP7XN0zXY/V+mJtjT5sLDaikO0rP3ul
         ZCacfQ+ROZUliQZm3NzaeEUWtisSD0CUzMDxEKfkQve68qw9Ue+HT1lTbaEIE0+8cx
         AVEs4kPnfifhg==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b992ed878ebso3921738276.0;
        Fri, 21 Apr 2023 12:48:23 -0700 (PDT)
X-Gm-Message-State: AAQBX9fK935b0YH9ndOqVnIqpJ12OWi2u7P2xzeVeNsg6QxQEHhbY1iI
        Kviv7m0OGZda0ORpbVhuZkmA8qehGgsTIsrklA==
X-Google-Smtp-Source: AKy350YsYIfzI0RqjqJqRB+28l3TKuZ1sA2+QHyWG7L8jHA86q5CcPNymknn2wyoh/hlD3nM3IPV82X+5dRu/2FsZsM=
X-Received: by 2002:a81:8415:0:b0:54f:64d8:9c9 with SMTP id
 u21-20020a818415000000b0054f64d809c9mr2826788ywf.21.1682106502454; Fri, 21
 Apr 2023 12:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230418150606.1528107-1-robh@kernel.org> <9543f619-88fa-8e54-6e9a-4334750e51b4@linaro.org>
In-Reply-To: <9543f619-88fa-8e54-6e9a-4334750e51b4@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 Apr 2023 14:48:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ZVAZc1nYJVLPQt=KM1qOZrZCrRC4q_o8XQjDdo_NuKA@mail.gmail.com>
Message-ID: <CAL_Jsq+ZVAZc1nYJVLPQt=KM1qOZrZCrRC4q_o8XQjDdo_NuKA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

On Wed, Apr 19, 2023 at 2:56=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/04/2023 17:06, Rob Herring wrote:
> > The "qcom,paired" schema is all wrong. First, it's a list rather than a=
n
> > object(dictionary). Second, it is missing a required type. The meta-sch=
ema
> > normally catches this, but schemas under "$defs" was not getting checke=
d.
> > A fix for that is pending.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.ya=
ml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> > index 9412b9362328..4c3e9ff82105 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> > @@ -144,8 +144,9 @@ $defs:
> >          enum: [0, 1, 2, 3, 4, 5, 6, 7]
> >
> >        qcom,paired:
> > -        - description:
> > -            Indicates that the pin should be operating in paired mode.
> > +        type: boolean
> > +        description:
> > +          Indicates that the pin should be operating in paired mode.
>
> Current Linux implementation uses it as a generic pinconf param
> pinconf_generic_params which is parsed by:
>
> pinconf_generic_parse_dt_config() -> parse_dt_cfg() ->
> of_property_read_u32()
>
>
> The pinctrl-spmi-mpp.c driver, using this schema, treat it as a bool,
> but I still wonder how the code will parse bool with
> of_property_read_u32(). Maybe it should be uint32 with value of 0 and 1?

That should be an error because the length is too short so it should
go with some default from the code.

Looks like there is no user, though no property could mean keep the
default/bootloader setting. Can you sort out which type is really
desired here and hopefully we can get rid of the other type. It's not
the first case of pinctrl properties with multiple types, but we don't
really need more.

Rob
