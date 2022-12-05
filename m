Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC16437B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiLEWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiLEWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:09:00 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B860DAE7A;
        Mon,  5 Dec 2022 14:08:59 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id p24-20020a0568301d5800b0066e6dc09be5so8163407oth.8;
        Mon, 05 Dec 2022 14:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LQdRCww/Rg/AOLkILYCm3JXOohNFYX1TuLwdpyUTQY=;
        b=nea+QPhaVQnEdNtgdHB0pR4mESFcoGn3HDEmMaZHbOWL6s0zw5rsRrjP2mlFqn6JeD
         RrvF24ILOYuV8oLjlDkjwreG5R/bnWp/bQb4PhQ3g3xQDPwVjggCRQvOACfCSqfhan6p
         FWTUwzlSob+LDrfbXm5rdAbnRnh87/l1u3kEr8saREJsy5R5REjjGTIUCdbDNyrw3U+W
         QgmaAUL1OnUMXjjZMuN7Z/Ml9egb20g4Z1BCx5HKwUXrxnd2V7llECe63DqZuN1Ef9lU
         aLP1lEZBXe1G8y95iAgqT5VvBO8Snp37eTNiNS4NNKgOaQwuUMZpwVy8xY5au7aClJ0n
         YuoQ==
X-Gm-Message-State: ANoB5pkf4iWPw+2WWatBQ/qR6sDSPDsrqQRfeqBYGo8pikCCeG5p1Ziy
        TacbjuYnUKLMMs14Vn2OUQ==
X-Google-Smtp-Source: AA0mqf68ifmQv9TjVRYjLw5r0xhWVBMcmSQfycK6nc31ntJ9+mBn/3zLW7t5RQ/fGi/YRALjbYYU6Q==
X-Received: by 2002:a9d:22e9:0:b0:670:453b:e8aa with SMTP id y96-20020a9d22e9000000b00670453be8aamr2154300ota.29.1670278138981;
        Mon, 05 Dec 2022 14:08:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a056870a44700b00130d060ce80sm9874902oal.31.2022.12.05.14.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:08:58 -0800 (PST)
Received: (nullmailer pid 2747615 invoked by uid 1000);
        Mon, 05 Dec 2022 22:08:58 -0000
Date:   Mon, 5 Dec 2022 16:08:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, abel.vesa@linaro.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/5] dt-bindings: mmc: sdhci-am654: cleanup style
Message-ID: <167027813719.2747317.364464091380990346.robh@kernel.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
 <20221204094717.74016-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204094717.74016-2-krzysztof.kozlowski@linaro.org>
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


On Sun, 04 Dec 2022 10:47:14 +0100, Krzysztof Kozlowski wrote:
> Cleanup coding style without functional changes:
> 1. Drop unnecessary quotes from $ref.
> 2. Use simple enum for compatible enumeration and sort entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  | 61 ++++++++++---------
>  1 file changed, 31 insertions(+), 30 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
