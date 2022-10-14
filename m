Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BFC5FF58A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJNVne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJNVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:43:32 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08981958C8;
        Fri, 14 Oct 2022 14:43:31 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id w196so6415292oiw.8;
        Fri, 14 Oct 2022 14:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLEy14cW5i9/ipUtCEn4NQjjaHD+mKJo+g0wR1GNmnI=;
        b=hitRZR1mS0pVr2lIiUH+IbA72GXNjA5wZq94V+dgRbLyUNmbNdlWUV3W6z5Uh8fChP
         +jN2eaeM/VPmGQYaZMSyOqclC7GE9AW8Tdrcime1uDMKadsAfkUu8n2MrGPg3IPaNlK1
         M+trdehnhN3ct9M1b6ob+sshMWCMXnPtE9ANzwFfb8r6Mn0hYst7SSiumnzXyh96hlzt
         UfTqCFGlwr03pWmpbCwO2301leOyoXqTu54XTybWtCEt+jiXWNNt7Eo/BGKO46ka9WBi
         39ChwJNJy1ttru8qJaakdfTlTE3DdEEkyR4hqnQJn0nJgwFNyXul4Mezji18uTRbSSGh
         0Gyw==
X-Gm-Message-State: ACrzQf08rbknPZJne46wbp2wVfdU38dw6GFHynyT3pbT6yCEmztuWd7j
        Tc8E1f4gMwl51hLtt2JOlUuRvYuUG5Uk
X-Google-Smtp-Source: AMsMyM5L/8nqTPGrjLkvgu4EQn0PZt8+8O6T2S6wCZgPNu8piCROxzpx88gMgxxYzXnuP7e2uiWEaQ==
X-Received: by 2002:a54:4404:0:b0:354:4ac7:45ac with SMTP id k4-20020a544404000000b003544ac745acmr8183240oiw.133.1665783811272;
        Fri, 14 Oct 2022 14:43:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be5-20020a056808218500b00354b0850fb6sm1701954oib.33.2022.10.14.14.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:43:30 -0700 (PDT)
Received: (nullmailer pid 2949248 invoked by uid 1000);
        Fri, 14 Oct 2022 21:43:32 -0000
Date:   Fri, 14 Oct 2022 16:43:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: misc: Convert IDT 89HPESx to DT schema
Message-ID: <166578381011.2949168.16656331976688179970.robh@kernel.org>
References: <20221005212631.122145-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005212631.122145-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2022 16:26:31 -0500, Rob Herring wrote:
> Convert the IDT 89HPESx device binding to DT schema format.
> 
> "onsemi,24c64" was not a documented compatible string, so update the
> example to "atmel,24c64". It's not clear what's in use here as no
> upstream dts files have the eeprom child node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Serge, Okay with dual licensing?
> ---
>  .../devicetree/bindings/misc/idt,89hpesx.yaml | 72 +++++++++++++++++++
>  .../devicetree/bindings/misc/idt_89hpesx.txt  | 44 ------------
>  2 files changed, 72 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/misc/idt_89hpesx.txt
> 

Applied, thanks!
