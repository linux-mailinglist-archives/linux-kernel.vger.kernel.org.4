Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96759681E66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjA3Wug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjA3Wuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:50:35 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0870A25E24;
        Mon, 30 Jan 2023 14:50:34 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id r17-20020a056830449100b0068bb088317aso3175876otv.12;
        Mon, 30 Jan 2023 14:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNYhsjqG2sWgs2gWLKftBwFAL6CYNRc5b+6o4KuBP3k=;
        b=FSA25EKiJmehxFpIsAQvR1cYPTZBggsifXBZJBnGhw7XKOvL43Vx9g05ZLOwglp2gj
         vJZ3aoqliyvOwkQ/poCzYc6t+7URu6ZbGF8LE6w9CXCypiQDBnzcOp5WHRBsGyh7y1M7
         4HGMrjlhUYu82o7hZTable/5PRljQ5AQr+wXGTXUf2fAih2ujgXg52L1OETIutcoRWjw
         7EPORUbXNFEgdsVgs0cDMeYPwH6OYirRdRr4idnwk6DOSArs1gBUp2143dgEPbWEMEMR
         EqeciYlA6zq19F/J2EmZ0Dz4eknUWl3QOqqrAOk+XbIvzOWUkmWL+OVz9vk2k7diZKMR
         hkAQ==
X-Gm-Message-State: AFqh2kqLVuPHgDxYFNzR7vo8hMcnRJI4T0tMJvlT46sgrb39n16q63og
        Tpp+YtmDIF4t72UkSLy/lA==
X-Google-Smtp-Source: AMrXdXtNhfsgDIvcAEdKu4kp+ybHhn5D1DqJVvcgUAHM5OWYY9UuqtZ807Orrl5sp6zWPu6BiNyBAg==
X-Received: by 2002:a9d:7614:0:b0:66e:c863:ea94 with SMTP id k20-20020a9d7614000000b0066ec863ea94mr21399528otl.27.1675119033197;
        Mon, 30 Jan 2023 14:50:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a056830311100b006863ccbf067sm5954261ots.74.2023.01.30.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:50:32 -0800 (PST)
Received: (nullmailer pid 3670295 invoked by uid 1000);
        Mon, 30 Jan 2023 22:50:32 -0000
Date:   Mon, 30 Jan 2023 16:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski@linaro.org, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iommu: memory: Use unmanaged iommu
 domain for the APU
Message-ID: <20230130225032.GA3667757-robh@kernel.org>
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-4-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130102722.133271-4-abailon@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:27:22AM +0100, Alexandre Bailon wrote:
> This updates the iommu id to use unmanaged iommu domain for the APU.
> This is required by remoteproc to use the iommu.

Explain how a mixture of DTs with or without this value changed would 
work with kernels with or without support for unmanaged domains? Looks 
like a compatibility problem to me.

> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  include/dt-bindings/memory/mediatek,mt8365-larb-port.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
> index 56d5a5dd519e7..86d82a8f6017d 100644
> --- a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
> +++ b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
> @@ -24,8 +24,8 @@
>  #define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
>  #define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
>  #define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
> -#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
> -#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
> +#define M4U_PORT_APU_READ		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 10)
> +#define M4U_PORT_APU_WRITE		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 11)
>  
>  /* larb1 */
>  #define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
> -- 
> 2.38.2
> 
