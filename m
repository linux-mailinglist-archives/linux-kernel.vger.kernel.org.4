Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BDA6D88DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjDEUll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjDEUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:41:25 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95683D3;
        Wed,  5 Apr 2023 13:40:34 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id bi31so27581270oib.9;
        Wed, 05 Apr 2023 13:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTTlu131iIVKU0jAW/sAwqi/zzN6v7hMGFbCm6sx0Zk=;
        b=aSFgxAYC1vgH24n9/ZizJqptgSSgm9WtSgh0TzTRrr4BO54yKD3x+hlebwFzWWlKCn
         l3BbNNO8IMwOJl9Jhmb/mdq53PGibLTgPDHry4f8j2wfC3jdVv2/C+Y4PXWPegfk6lSJ
         YUfr8oQugZF8xL+bxEhxaOXy1ENTGO0cA8/IqXuebDwwR/0bGCIGf542J2rQINra/lla
         7hiJIlozEcLrD+hbAXursBuGs/S3ZOUtVUdYk8KC0ix7SpRzGTHuSep6uRpGw7sDYpa7
         dof9tWy8l96lCm0O3FVbCLBI5yHbcptxEcmmoDGLrWuLRlxVenjJzYGjtEyDBbOYesF3
         +fEw==
X-Gm-Message-State: AAQBX9ceyHHSTSygeXpA5FgxeNGiBsOsjUtrsocO8ZUtq+XYvxpVA4k/
        IQuViDUYBJRZYfQrKJuF6w==
X-Google-Smtp-Source: AKy350anY8XAUl300crTRGIlMaGnmPL/aZzCFVpb2qa417Z6woPIjy/2yk9QobYjQ8wFYrr1qy99DQ==
X-Received: by 2002:a05:6808:652:b0:389:7c1e:3b83 with SMTP id z18-20020a056808065200b003897c1e3b83mr3070885oih.32.1680727195592;
        Wed, 05 Apr 2023 13:39:55 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h4-20020aca1804000000b003896fc34eddsm6617205oih.52.2023.04.05.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:39:55 -0700 (PDT)
Received: (nullmailer pid 443548 invoked by uid 1000);
        Wed, 05 Apr 2023 20:39:54 -0000
Date:   Wed, 5 Apr 2023 15:39:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liu Peibao <liupeibao@loongson.cn>
Cc:     wanghongliang <wanghongliang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongarch: Fix
 mismathed compatible
Message-ID: <168072719318.443485.10404612854321369787.robh@kernel.org>
References: <20230401091304.12633-1-liupeibao@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401091304.12633-1-liupeibao@loongson.cn>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 01 Apr 2023 17:13:04 +0800, Liu Peibao wrote:
> The "compatible" doesn't match what the kernel is using. Fix it as
> kernel using.
> 
> Fixes: 6b2748ada244 ("dt-bindings: interrupt-controller: add yaml for LoongArch CPU interrupt controller")
> Reported-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/all/20221208020954.GA3368836-robh@kernel.org/
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> ---
> V1 -> V2: Correct the commit ID in commit log.
> 
>  .../loongarch,cpu-interrupt-controller.yaml                   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

