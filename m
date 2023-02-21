Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC57969E581
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjBUREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjBUREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:04:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DA326A3;
        Tue, 21 Feb 2023 09:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DBF8B80F9E;
        Tue, 21 Feb 2023 17:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B04C433EF;
        Tue, 21 Feb 2023 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999067;
        bh=9GGa3LfIZFLMfyC93YamuPJ+m0MPY0JXS8yoYYlRNcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oj40XnSwOXRCPsxVHExRWHuzJ0nTqBUJid+xyEKffs5V5m4NV6yX0jdysXLJ5tbo1
         HS3alv74qAEOVzlOjPSzhL72l34bSyJBt3VYCkYhTUpfe+trW4VhZrszS78SIAmbjj
         GNiyhXbANzSUOZubhVyfS2NCDQgn3IoV9VC89hDwe1dQt2ii+0obXC5/Vfu61NMkeM
         on10EQXMnq63fTaxFXMD92am7fCY2O2zJw974K59P8Vkz1tF01dqqvwKGy2iJ60u4r
         aVkua3U3foDPH0AsWmC5eRGC/3aL+8zqmAAkGkmtS08fO4w2uGZr3wWyJQ9BgSryoM
         HEAr+BDPN9rRA==
Received: by mail-vs1-f45.google.com with SMTP id v3so4998773vse.0;
        Tue, 21 Feb 2023 09:04:27 -0800 (PST)
X-Gm-Message-State: AO0yUKVrtW3Sk52LIOYzAhN/Yn/M07No8m7DyxcZMxIphWGFDvpqc7L6
        N5GAdyXmzTi3hp9IaaSHqOwikLQ3746yirz5pw==
X-Google-Smtp-Source: AK7set8RExnAumdfrmnLc73JH0r49w5gketyb+VaMFd10K+FqxZ4TgZPrnaat/PrIDrRENGFveQK8OSCvev++hvJ4Ag=
X-Received: by 2002:a05:6102:1270:b0:414:cd37:4da8 with SMTP id
 q16-20020a056102127000b00414cd374da8mr952787vsg.83.1676999066215; Tue, 21 Feb
 2023 09:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20230221120612.27366-1-r-gunasekaran@ti.com> <20230221120612.27366-2-r-gunasekaran@ti.com>
 <fa789c44-d9b9-92a6-00f4-7bc2410c7642@ti.com>
In-Reply-To: <fa789c44-d9b9-92a6-00f4-7bc2410c7642@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Feb 2023 11:04:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKcktHkexxPaneZjaUt=XwLA_5ypZxSZKnX5TozdgJ+Kg@mail.gmail.com>
Message-ID: <CAL_JsqKcktHkexxPaneZjaUt=XwLA_5ypZxSZKnX5TozdgJ+Kg@mail.gmail.com>
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: ti,j721e-system-controller: Fix
 mux node regex
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     nm@ti.com, afd@ti.com, kristo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-vadapalli@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 8:00 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> On 21/02/23 5:36 pm, Ravi Gunasekaran wrote:
> > mux-controller nodes may not have "reg" property. Update the regex
> > for such nodes to resolve the dtbs warnings
> >
> > Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> > ---

Where's the change history? I doubt I ignored the last 9 versions...

> >  .../bindings/mfd/ti,j721e-system-controller.yaml          | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > index 76ef4352e13c..532bfa45e6a0 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> > @@ -45,7 +45,7 @@ properties:
> >
> >  patternProperties:
> >    # Optional children
> > -  "^mux-controller@[0-9a-f]+$":
> > +  "^mux-controller(@|-)[0-9a-f]+$":
>
> Hmm. mmio-mux bindings allow reg property. Why can't we add the same to
> mux-controller node in 2/9 ?

Yes, do that.

Rob
