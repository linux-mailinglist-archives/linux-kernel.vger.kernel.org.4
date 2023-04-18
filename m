Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B16E6D93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjDRUjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDRUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:39:17 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D8BAF21;
        Tue, 18 Apr 2023 13:39:01 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6a5f21a0604so834774a34.2;
        Tue, 18 Apr 2023 13:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850341; x=1684442341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNSKwxiPaQemfObF2ul/VmxpdAbWAVyWKmOYQFhwC18=;
        b=k29casrYJSRJaGIBsKZX+T0XfntqWm+tWwWu7Cg3gEx6VF2hHo18xia2fEZCBsW47c
         MrGfY7Ih27F70pJNRUXnSlo/SksSjxVhbvZLKzerSU+X/ToE+wcQ6FgdZD9F/pOm4Cb3
         HJw7IB3ko0/+zxc3NBfhc2+Al7WRm7Vz5KAAjynJQAVEXbwhZ/3/Z+XgZ5s/UPEhK1Qy
         xFTbz9/y1C/BrKW83kPtLU8JFJy3pGKNOC/GGk05+zfH+SXe+Vl9u7W7BCxiuDS4yG6m
         90lg7w/qGMBMEwMdv6j1ziR0hCXz4JKUQtSPbsDpFTXWMrFyw7eOnCkk8xLrkMIkkNM5
         6uEQ==
X-Gm-Message-State: AAQBX9cIjw/zkY6yIpAEaRhY/iOfPYaASoNwg06evwELLR2Fwy8w9trL
        8mSra6ZmdQsHEWUIDEwGEQ==
X-Google-Smtp-Source: AKy350aBCV4+vKm8iqRCNAc3k5H1+1Pir8HI4UDk6/fvkmSCmn8oAzXILt4B8baAlNK5aU9QQmB7EQ==
X-Received: by 2002:a05:6830:3a16:b0:694:38e2:c5f8 with SMTP id di22-20020a0568303a1600b0069438e2c5f8mr1401525otb.30.1681850340940;
        Tue, 18 Apr 2023 13:39:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f24-20020a9d7b58000000b006a5e0165d3esm2861011oto.19.2023.04.18.13.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:39:00 -0700 (PDT)
Received: (nullmailer pid 2298906 invoked by uid 1000);
        Tue, 18 Apr 2023 20:38:59 -0000
Date:   Tue, 18 Apr 2023 15:38:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCHv1 1/5] dt-bindings: soc: rockchip: add rk3588 pipe-phy
 syscon
Message-ID: <168185033918.2298851.7201086421225409224.robh@kernel.org>
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
 <20230413182345.92557-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413182345.92557-2-sebastian.reichel@collabora.com>
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


On Thu, 13 Apr 2023 20:23:41 +0200, Sebastian Reichel wrote:
> The pipe-phy syscon is used by rockchip,rk3588-naneng-combphy,
> which in turn is the PHY for USB3, PCIe and SATA.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

