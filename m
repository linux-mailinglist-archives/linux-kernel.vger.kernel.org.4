Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFC6D5283
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjDCUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjDCUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:33:53 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEEDE5C;
        Mon,  3 Apr 2023 13:33:51 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id r40-20020a05683044a800b006a14270bc7eso12976696otv.6;
        Mon, 03 Apr 2023 13:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3C4JihcH4XmAQpVSh8OElVY6IOaw4kS9WRJhi0vlAA=;
        b=RAaU9upaVJP5U6hLmG/ta7smotBVOy33MHzH51sqBaJ2D8f+R6Ci3yoJpGv4+uU0Pl
         DdqyRu51Y2X8tvIFghu5h9pTINSg6GHRZ52jvhh94GH2ED5pndJzr9BE+/aJ56aHYcbl
         R+Pzp3xMGKkSWrkYy27M9qu4iThx68OOeFBxm8hnMVf1vHW8TIYvMb+gbJuWsNUdBJXt
         BalQBUyeCOVyIggb4H035mX9G/dxQ9ZeIki1Cc9ePiHDvQUf/Yqly5Ybsxz2ZLfqjDSJ
         SyMpFL3MqEbXAZCQzfpwF8xuDWEHzNSRLFWrRSiDPWOej8alge6SkJrBpzAWQ11O1TZL
         NDFQ==
X-Gm-Message-State: AAQBX9ebmp6iAVKeHoL3nrmUFwAL4NFCgF5eZn8iKOIPxsOtkJpknnVh
        pEboMZz5Zl2A5dyrWl81VQ==
X-Google-Smtp-Source: AKy350bBXrNMR6/Kktx4TnFXtFl5xlFjp4aGv2j9w0eC+FhMWK7fokPOVWHCmb1CspD//eEUjPn/RA==
X-Received: by 2002:a05:6830:10cc:b0:69f:174a:3587 with SMTP id z12-20020a05683010cc00b0069f174a3587mr261557oto.22.1680554030982;
        Mon, 03 Apr 2023 13:33:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d6e9a000000b0069f85f0a1b7sm4624694otr.33.2023.04.03.13.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:33:50 -0700 (PDT)
Received: (nullmailer pid 1700083 invoked by uid 1000);
        Mon, 03 Apr 2023 20:33:49 -0000
Date:   Mon, 3 Apr 2023 15:33:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Message-ID: <20230403203349.GA1692472-robh@kernel.org>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
 <CAL_JsqKrrWyOKGUAaT-8r-nKvtS5f_gHAhE5=XaXuGtuYC2gCw@mail.gmail.com>
 <a497eb9c-8279-d4e9-3b8d-537ffa1f7522@gmail.com>
 <cfa5904e-8ae4-6d39-ed4e-35d1b55e2b04@linaro.org>
 <f39edbfe-75bd-3b39-e325-8d24673a4501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f39edbfe-75bd-3b39-e325-8d24673a4501@gmail.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 10:15:16AM +0800, Jacky Huang wrote:
> 
> 
> On 2023/3/30 下午 09:25, Krzysztof Kozlowski wrote:
> > On 30/03/2023 12:41, Jacky Huang wrote:
> > > Dear Rob,
> > > 
> > > 
> > > On 2023/3/29 下午 09:07, Rob Herring wrote:
> > > > On Mon, Mar 27, 2023 at 9:19 PM Jacky Huang <ychuang570808@gmail.com> wrote:
> > > > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > > > 
> > > > > Rename the bindings/arm/npcm directory as nuvoton.
> > > > > Add binding for ARMv8 based Nuvotn SoCs and platform boards.
> > > > > Add initial bindings for ma35d1 series development boards.
> > > > > 
> > > > > Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> > > > > ---
> > > > >    .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
> > > > >    .../nuvoton,npcm-gcr.yaml}                    |  2 +-
> > > > >    .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
> > > > >    3 files changed, 32 insertions(+), 2 deletions(-)
> > > > >    create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
> > > > >    rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
> > > > Since you are moving it, this one should be moved to bindings/soc/nuvoton/
> > > > 
> > > > >    rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
> > > OK, I will move "Documentation/devicetree/bindings/arm/npcm" to
> > > "Documentation/devicetree/bindings/soc/nuvoton".
> > To clarify - Rob asked *this one*. Not all.

nuvoton,gcr.yaml is what should be moved to bindings/soc/... The rest 
are the correct locations.

> > 
> > 
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Dear Krzysztof,
> 
> I am sorry that still cannot get it exactly.
> 
> 1. Just only submit  the nuvoton,ma35d1.yaml to
> Documentation/devicetree/bindings/soc/nuvoton/nuvoton,ma35d1.yaml
>     and keep Documentation/devicetree/bindings/arm/npcm unchanged
> 
> 2. Move the directory "Documentation/devicetree/bindings/arm/npcm" to
> "Documentation/devicetree/bindings/soc/nuvoton"
>    and submit  the nuvoton,ma35d1.yaml to
> "Documentation/devicetree/bindings/soc/nuvoton"
> 
> I should do 1 or 2?  Thank you very much.

Neither.

Arm board and soc root node bindings go in bindings/arm/...

Miscellaneous system registers that don't fit into any other bindings/* 
subsystem directory go in bindings/soc/

Rob
