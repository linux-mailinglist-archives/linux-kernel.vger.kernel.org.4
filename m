Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550775BBC94
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIRItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:49:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFD23BD1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:49:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k10so42151896lfm.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZwZOJe+FeJxtg/aH4rA88K+jC4BSJwI/ocMiCdlkcF4=;
        b=kUjG8tiF4DOfsJ0yJkFeQNvYX8SQhVCHXi4eNw8XMHJSr47dTMRvT7KeIZmgNvmntK
         pNROOHFTGL0H9Lt6Hu0c3rpka9USx5IarPwMf99T6QAGBePksYVpfBpHlU1/UOHkCT/Q
         Yyb3MyZftJrrGNF854cy0oPR5vLLcRffyRxOL0vMn1OM1idEo2mgu07pd3LgNwzUS+wf
         QA+UKOG2kEiBSrmmew8A5IgQ9WtMWAerjIuQ5kkfuBjzSD6eKLwq4zYJn1goQq792F7P
         CnFZun00GqK8tw8HtZEnQMoL+X/W+dP4T+z5nrBDwLDfZnTp7m455wgC/tKB4+AEIWs6
         f5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZwZOJe+FeJxtg/aH4rA88K+jC4BSJwI/ocMiCdlkcF4=;
        b=TAAqLG3NjruW7bJD16oL60pGaOTgvPEwYp9kjS9ZvBPd4GuQYg8w/NEzhD72QdCEHa
         ced8KIy1WVlc5uoeimYYuB9RhctTQLjyeDbi6uQIPP8u1k4CsDNKLbzfvmN4QqLTE4vc
         QIri9QWoTRrSEI3OVTvEfiAMjBFq+AGbJK8csdpnePNy50wvD634DhaSqGopYYfF/jJK
         MAJhOeV34Kcwp+7eM9YJDVHJq20OW5KTOfxdwdcHvbGAYtogE8RMMhiR/yxSFjRAN70Q
         0T8ujPNEehg4BqouzSbDxRKIGTERkDube4WR0Fsxx9b1QWcqbXCUjWVdiqwOXTJiOdCX
         v20Q==
X-Gm-Message-State: ACrzQf3IdNOvGu8vDZecQ9iQgvTr+Ped+x4K+4PmQtUQQ7/6ZpBgCW3L
        CBiLFCCN/xnlrF6NsvlEJ+gTlA==
X-Google-Smtp-Source: AMsMyM4yl2AEVfWW9ArVGX0h5XMxSuG5pI1ClU8XUcTQBDMci5kCqO/xui6FIfPjoE7bJwhMzj8jxA==
X-Received: by 2002:a05:6512:3b85:b0:499:183:d5f1 with SMTP id g5-20020a0565123b8500b004990183d5f1mr3962466lfv.659.1663490958946;
        Sun, 18 Sep 2022 01:49:18 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o27-20020ac25e3b000000b00494935ddb88sm4570516lfg.240.2022.09.18.01.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 01:49:18 -0700 (PDT)
Message-ID: <d7507d61-9d16-c2d3-2066-5e2f9afd6eb9@linaro.org>
Date:   Sun, 18 Sep 2022 09:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: dma: Make minor fixes to qcom,bam-dma
 binding doc
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, agross@kernel.org,
        dmaengine@vger.kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, andersson@kernel.org
References: <20220918081119.295364-1-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220918081119.295364-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2022 09:11, Bhupesh Sharma wrote:
> As a user recently noted, the qcom,bam-dma binding document
> describes the BAM DMA node incorrectly. 

It's a bit confusing - what is exactly incorrectly described by binding?
You did not make any changes to the binding itself...


Best regards,
Krzysztof
