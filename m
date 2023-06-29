Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66913742AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjF2Qom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjF2Qoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:44:37 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D0930FA;
        Thu, 29 Jun 2023 09:44:36 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-78372b895d6so38036539f.2;
        Thu, 29 Jun 2023 09:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057075; x=1690649075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvv8o8lyQDs4Uqc/cTXEEqb+afkYfTSqGgHooIqCpbA=;
        b=DDuvN7GDfhtEnKDH1CR6nfsCNGPpyxNYp0KXOxiT91t4g394MiOIa1gUhQy8VG72hf
         ZYRSY6xWtzjXX6+D2aH7G+oeDLZ4FRaDsZ9n40fCmYBLQEwIns4J69I3N2YWfIIk60fO
         k1b49VFqSu2QxbW/v5x6EnEohpkdBZmvG94AX1omSwtIJq5o4iOD+DosuakHi9ncYvwa
         ZQqVCef1CPF8LDYkcLfqVaYOSqQ/1KO17ieDCTSTYNwDSk3CT1kRYaKRZ0Me2WG5lA64
         aMbaciLnWsd+RhVvqD3RYBnocnBNBqtFVTxIjPBEie0tqKIpstQQPyFjIAkKuwsQ0Uji
         tg8g==
X-Gm-Message-State: AC+VfDwUbsVk2uFQAXgNnafvM2D50KwFUfUw0d5s15xugki88X62DRhk
        uVie+xOhz1pVTxaBOq0oUg==
X-Google-Smtp-Source: ACHHUZ7Zq2rHGHa35R4f5/6RnXVSjZz6xktb2tp91v9Fy3aAm2hQ7f4Z40Tssnpm9/HIk8qiWdMP/A==
X-Received: by 2002:a5e:a717:0:b0:784:e618:e6cd with SMTP id b23-20020a5ea717000000b00784e618e6cdmr9008iod.20.1688057075474;
        Thu, 29 Jun 2023 09:44:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b8-20020a5ea708000000b0076c7a2f0f41sm1627336iod.46.2023.06.29.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:44:34 -0700 (PDT)
Received: (nullmailer pid 3171062 invoked by uid 1000);
        Thu, 29 Jun 2023 16:44:33 -0000
Date:   Thu, 29 Jun 2023 10:44:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, perex@perex.cz,
        linux-mediatek@lists.infradead.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, broonie@kernel.org
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: mediatek,mt8188-afe: add
 memory-region
Message-ID: <168805707144.3170983.17451535547887085687.robh@kernel.org>
References: <20230629074348.21670-1-trevor.wu@mediatek.com>
 <20230629074348.21670-3-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629074348.21670-3-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 15:43:48 +0800, Trevor Wu wrote:
> Add memory-region property to utilize the reserved memory region.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../devicetree/bindings/sound/mediatek,mt8188-afe.yaml     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

