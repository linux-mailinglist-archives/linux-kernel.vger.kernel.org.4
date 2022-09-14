Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507055B8B47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiINPGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiINPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:23 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502F74DF6;
        Wed, 14 Sep 2022 08:06:22 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id k10-20020a4ad10a000000b004756ab911f8so1597732oor.2;
        Wed, 14 Sep 2022 08:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DG8jK2VGVF6CoXW6DXySelXNuunB85oFke/oAJQGn7M=;
        b=wVOliwZVEQI9pO23PMCDUuiPMOrSfmsFpFylZNZhzpR9IDQf3FSXZ5sLXeTbj50fzt
         3EYUeFnvjlXkRcZToVcNYrtSZV4DAt9ND34Bu2AVK4y1P1x75A0Kqz4ureK45fDLytzx
         5qhJG8yxhwD8zVZx/EGaCOZRi5KhV2/+2UPZcxCRqHVmKsz1qYGhbwsxdTOXBEcButud
         F6VSik//BR5lG1Mpg5nGBJReABciRjR5q5r8EsilBb7gsT6KtLpaP2Q7rm/RKeIt9aZF
         wThNAHZzLiHI90FTHRpcS313T+Dj61vGW46Xvf2y3azu9mqvRUPSqpAgvsa30Q2x20JV
         JYIw==
X-Gm-Message-State: ACgBeo3XV5xuCXpaxURU9E37svEj+1TVXikjtv4kQVsxhBO0NNPsPb1j
        Ex786d2kc9kOeE7RhLG95w==
X-Google-Smtp-Source: AA6agR77S+W1uvRmgcKfkwfbm9OYUUZIqqBM8PBzfVvughcMQPv55SChHWRW8CTOWrpBRsoJZsZ3vg==
X-Received: by 2002:a4a:d41:0:b0:44a:8081:733c with SMTP id 62-20020a4a0d41000000b0044a8081733cmr12883364oob.71.1663167981347;
        Wed, 14 Sep 2022 08:06:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u22-20020a056871009600b0012b342d1125sm7788150oaa.13.2022.09.14.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:20 -0700 (PDT)
Received: (nullmailer pid 2221684 invoked by uid 1000);
        Wed, 14 Sep 2022 15:06:20 -0000
Date:   Wed, 14 Sep 2022 10:06:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     cy_huang@richtek.com, robh+dt@kernel.org, chiaen_wu@richtek.com,
        linux-mediatek@lists.infradead.org, alice_chen@richtek.com,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: mt6370: fix the indentation in the
 example
Message-ID: <20220914150620.GA2221443-robh@kernel.org>
References: <1663143803-28660-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663143803-28660-1-git-send-email-u0084500@gmail.com>
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

On Wed, 14 Sep 2022 16:23:23 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix the indentation in the binding example. There're two redudant space
> charactors need to be removed.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
