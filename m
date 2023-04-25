Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF66EE7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjDYTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjDYTC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:02:26 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03902E43;
        Tue, 25 Apr 2023 12:02:19 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-547299bf5d8so3581163eaf.3;
        Tue, 25 Apr 2023 12:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449338; x=1685041338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq/YohFvUXaLobjRGfG20kM6z4VVLoR6JmhP/GiUz7o=;
        b=Dh8Frb6u2qUH/tS/M1ZhCtlFILfdGngISqCBZFOdoN8dfcAt7OuCd4Ifm2sWRQ4gfq
         s88S47BMawQt2zBFbaOhvGYAEm0fsomXQMiplI1A5G6Ygu4sQLQB3jl3MLXcr7ljft/6
         nw0oooB8/1t9HujlrU3UFPVveGxvbaj4m3b/ft00n61vkixV7kvyOkpIXBFYAu0esTna
         F9P7pn5euhQYYPZgRC7dctKae1QLyFLDowTpcLDRpH4mCrkvZ6s4Z3o+xwdCNijrYzwv
         /GDo0asGTeSTneHIt7/JYi5JJ5kP28KOgbcPPUTX5v+/fU1P4Q7g75UD5WAdZ5NW4MII
         Ojqw==
X-Gm-Message-State: AAQBX9dFVGkSalI6JAGZBJz8uvE2AU9iVOZ/qr+ILmkS/zdRkAQ421iz
        ENgr+F/mIsyENx9PMQ9kxw==
X-Google-Smtp-Source: AKy350ZxCF6ig24oz6aLoJegxsBErmc0e9oNlI+GuvtJzx6Pl7Yu08cAbpjPbTWmKvawYn7RgITdew==
X-Received: by 2002:a4a:a3c3:0:b0:547:7574:b89a with SMTP id t3-20020a4aa3c3000000b005477574b89amr5706123ool.1.1682449338115;
        Tue, 25 Apr 2023 12:02:18 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v6-20020a056870e28600b0017e0c13b29asm5849893oad.36.2023.04.25.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 12:02:17 -0700 (PDT)
Received: (nullmailer pid 2091228 invoked by uid 1000);
        Tue, 25 Apr 2023 19:02:16 -0000
Date:   Tue, 25 Apr 2023 14:02:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     tmaimon77@gmail.com, mturquette@baylibre.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        jirislaby@kernel.org, sboyd@kernel.org,
        Jacky Huang <ychuang3@nuvoton.com>,
        linux-kernel@vger.kernel.org, lee@kernel.org, arnd@arndb.de,
        mjchen@nuvoton.com, linux-clk@vger.kernel.org,
        p.zabel@pengutronix.de, schung@nuvoton.com
Subject: Re: [PATCH v8 05/11] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Message-ID: <168244933613.2091189.18016207568464601422.robh@kernel.org>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-6-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425102418.185783-6-ychuang570808@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Apr 2023 10:24:12 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Move 'nuvoton,npcm-gcr.yaml' from 'arm/npcm' to 'soc/nuvoton'.
> Rename the '/arm/npcm' directory to 'arm/nuvoton'. Additionally, add
> bindings for ARMv8-based Nuvoton SoCs and platform boards, and include
> the initial bindings for ma35d1 series development boards.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
>  .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |  2 +-
>  .../nuvoton/nuvoton,npcm-gcr.yaml}            |  2 +-
>  3 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
>  rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
>  rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

