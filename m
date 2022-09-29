Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DB95EFE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiI2UQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiI2UQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:16:53 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78C14C065;
        Thu, 29 Sep 2022 13:16:51 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1280590722dso3163365fac.1;
        Thu, 29 Sep 2022 13:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=U7x0dTEdReoW/5vdcZ8kIgGdD/0AVnT6gEHCMo+tgBs=;
        b=oVtOk5DOoRE9uPT8TKrDfivBu2EBZl60E6OSTOeH4R/u9cMj36hgadJsDk45AsLmSY
         /QjzNtRPQePq3cWgeuhJkkG/IXxRkMuF6m+G/FVrjzrHmLMxMqDwjrt4MITYjXl1bkP6
         ZdRkm7fQlxYTXK2L+cpsvebYDSrow5ws5uHIBuznH3116Ok9z7lGe9UbMhsma5jYufOA
         94Jcc/iBhNh4m9xTQBFLBjtMv4IcZrZT83NVY0ercjqt7nQlsKWZYno496KsiWUMFyiz
         ZutxIZq9VTnFgY95B/iWni/JJXOVwgk2RN0k0lUAP5OkTTafpmFfaDCHeMgA0vGc7WhU
         gF1Q==
X-Gm-Message-State: ACrzQf2I8IKJQS4ViOiksOa+Mp2S6wJEHJuAu/O7GAQ2f1bAbZWwVkvJ
        qStkkzb5wsMivL66OzoqBA==
X-Google-Smtp-Source: AMsMyM47CrUwHaKmDibuKVhc1zrJI2gAoToJz34OWllqSZAF3awe2rQtiA0UD2IrbrXxPqis3ZY98A==
X-Received: by 2002:a05:6870:1711:b0:131:cc05:d883 with SMTP id h17-20020a056870171100b00131cc05d883mr2616388oae.32.1664482611103;
        Thu, 29 Sep 2022 13:16:51 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ep31-20020a056870a99f00b0011bde9f5745sm180512oab.23.2022.09.29.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:16:50 -0700 (PDT)
Received: (nullmailer pid 2667200 invoked by uid 1000);
        Thu, 29 Sep 2022 20:16:49 -0000
Date:   Thu, 29 Sep 2022 15:16:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 13/15] dt-bindings: pinctrl: qcom,sm8250: add input-enable
Message-ID: <166448259524.2666801.17782295189774776164.robh@kernel.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925110608.145728-14-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022 13:06:06 +0200, Krzysztof Kozlowski wrote:
> The SM8250 pinctrl driver supports input-enable and DTS already use it
> (sm8250-sony-xperia-edo-pdx203).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
