Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454C6C3B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCUT73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCUT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:59:27 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA08A46;
        Tue, 21 Mar 2023 12:59:26 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so9208465otj.2;
        Tue, 21 Mar 2023 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROP4DRR/+tYjzmqeO5vCsVTkmmIBiGALSgi3SPQadn4=;
        b=8ANzfsYIQO9Igtwf43WaeERobPPQ5+55j2XroazxWsQB8LPmCkHK5D5sZw5Uahh7cn
         2v9vsouag/vlTo1BFRYt1kdGOL+4qcgdPxwOTWitqjDH9WglkDrPp+cDGOSErEKERlHq
         M2tJS74U18E4O3AP4UcESqHCMoOSp+yh7zfhn94WeeS4Hjnr/bUMbAFBYDiFSXubw+hG
         mHfQNC85aJFJIdauCB+ZarN0chBVWTAUc+qj5jJipryF8906PEkZPvlX+QWe2jU5n7fX
         Qz6iB8l9OM2KhUmMu4PTM6c1Rj40QXSdhv5UJZon2g0ksDlKosHY6S11O4T/KF372W7R
         JLKQ==
X-Gm-Message-State: AO0yUKUZVd8Dyu8g3yy6RuSmH1iY1wIiC2KlHah0GmLYoDOdO6b3G49B
        xd/iLf91eJZnEqCn+DqogQ==
X-Google-Smtp-Source: AK7set+H+vIh3Lr0z8ak+Tuxg2q8VFXzxPrPC9CkKAfZfFwsF3osaXyOzEeU8ueS/6FbBgFaRAghwg==
X-Received: by 2002:a9d:7d16:0:b0:69c:639b:330e with SMTP id v22-20020a9d7d16000000b0069c639b330emr252747otn.3.1679428765524;
        Tue, 21 Mar 2023 12:59:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t2-20020a9d7482000000b00690f6d9a737sm5488723otk.8.2023.03.21.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:59:25 -0700 (PDT)
Received: (nullmailer pid 1351594 invoked by uid 1000);
        Tue, 21 Mar 2023 19:59:24 -0000
Date:   Tue, 21 Mar 2023 14:59:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-usb@vger.kernel.org, xu.yang_2@nxp.com, linux-imx@nxp.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        s.hauer@pengutronix.de, jun.li@nxp.com, festevam@gmail.com,
        robh+dt@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 01/10] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Message-ID: <167942876351.1351542.3404764451729965603.robh@kernel.org>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
 <20230321085213.1624216-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321085213.1624216-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2023 16:52:04 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert usbmisc-imx to DT schema format, add missing compatibles
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 68 +++++++++++++++++++
>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 19 ------
>  2 files changed, 68 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

