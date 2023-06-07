Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F3726615
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFGQfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFGQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:35:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BFD11F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:35:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b2a2cba31eso359830a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1686155722; x=1688747722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMrFVIrD87+YmHza3/ad/xmyTl0CWoopOL5lZLVffkg=;
        b=YL+ZOlLuh1QwHdONfePG0Pc261M7VTfob0HkvLQFX2rwlJ9QYuwXeynWkBg5OHbwrX
         PWwWJ2uGDJQq1ODl7DAb8o6vOAMQuzd19w1ifmxHYqH914oSCZDz8t0U4FCb9RFsdPxd
         4EWa+VM41XjeKtUgKOPE1mRdxRCq4JXiSTyqlk3MnlPTF3lpish/wa+SnEtwr2nwJ/ek
         gQHDQrLEIFjycCkynooUQhnEpc/JtaZVZ2p44mHea+RkEhuYKHXoDfDX30hN2RxxDN1U
         3CSPFYWm99uX7/GGgw8KSqVUHRZypmA8sShTsyHdKcAH2GNSWw2HISzlYmKUrkN9IoYV
         Usag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686155722; x=1688747722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMrFVIrD87+YmHza3/ad/xmyTl0CWoopOL5lZLVffkg=;
        b=ZxDpRgnxme4xpr/xCKKIIJDJVfztYmTnXBIrQUWtM2q8wXTYMGJ3dATjlht2xFZRtD
         NnnT43xgBKDheU29MTVZ6vtgsn7AJlewIMWJudzULRo6REr4Jcbkh1kL8TYUkPdMGiqJ
         dBzujs+qjH/imA0k5Tq4YssS6VlgIiUkh9MKx+9ANI4OiE7bDwe4x3QpnrBQJHf2JJWM
         3RGH5nW6C7oukXmWw3ACC/u4s5QFJpR8yRMKi2I1QM6w/EVssD/ThP7K9uC0dkBQCq2N
         No9MET9WcY4JeGZaq3GOgO0bRjuk9fOjkV4dp2s/gHGfbtwqrdaXIhU5mJS4I0Ommgoo
         BYWw==
X-Gm-Message-State: AC+VfDyhJXGB2dpTTjVqlXxiot9HlXFEEAVClUjh8iEskifA+FgG9I+a
        bsHAAkIVw4OG2bnoqPhU+jbiFL6JluPmwRt3XT0Aqw==
X-Google-Smtp-Source: ACHHUZ5txOkS2bCOcCUliKdknm78gQawzIksPAegofbAayd9ohoHue7+lFR4WVQhjmRkQOYi7jXvkGrpyKdIcMTeqxI=
X-Received: by 2002:a05:6358:e95:b0:129:ccaf:c6c1 with SMTP id
 21-20020a0563580e9500b00129ccafc6c1mr531212rwg.17.1686155722294; Wed, 07 Jun
 2023 09:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162438.2009738-1-tharvey@gateworks.com>
 <4bee93d7-0613-3b15-d34d-c62cbb367547@linaro.org> <20230607-decorator-cage-a823b3a0e2f7@spud>
In-Reply-To: <20230607-decorator-cage-a823b3a0e2f7@spud>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 7 Jun 2023 09:35:10 -0700
Message-ID: <CAJ+vNU2UCmqjUKVczsJVnJv=8FJFBeO4Wom8bK3mf0JDWszLjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Gateworks i.MX8M Mini GW7905-0x board
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 9:31=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Jun 07, 2023 at 06:27:28PM +0200, Krzysztof Kozlowski wrote:
> > On 07/06/2023 18:24, Tim Harvey wrote:
> > > Add DT compatible string for a Gateworks GW7905-0x board based on
> > > the i.MX8M Mini from NXP.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documen=
tation/devicetree/bindings/arm/fsl.yaml
> > > index 2510eaa8906d..b19444dc23da 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -915,6 +915,7 @@ properties:
> > >                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
> > >                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
> > >                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
> > > +              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
> >
> > Are you sure you are using correct prefix? Anyway, keep alphabetical
> > order, so before "gw".
>
>   "^gw,.*":
>     description: Gateworks Corporation
>                  use "gateworks" vendor prefix
>     deprecated: true
>
>  ;)
>
>  I'd be more interested in whether that -0x is a wildcard!

The 0x has to do with our part numbering scheme. The gw7905 is the
baseboard and the 0x is the SOM and we have SOM's with part loading
options that do not affect device-tree as reserved for 00 to 09.

I'll fix the sorting for v2.

Thanks,

Tim
