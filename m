Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D7602C54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJRNFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJRNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:04:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04296F241
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:04:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o2so8513727qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVggg/zGpEgRhovjVbnJJA36oAouEK0fvptCigeAEiI=;
        b=bhqSB3ryRV8GJLGPzDnOYf8WCdBmi9ErGIC+xRFHwuHDvaU3XCja0tioOn/5XZx6gi
         pYWZtDI3kv97T/9WsyeyKT39mc08e5NjPyl64QwiqLamP5IuyKL69xSFl0o6vkgwcLLZ
         iwOIT4kZPlwA4X0i+urx0c/ziQohJgNl1AF2ZTwVucDj7Pv95pzaN4n9MHjncsve1CMQ
         +mQcn9IcYlVICCBqKCsgBLqPnxxEjDYit+tJ2jjh1bzh7QQ0iypz2Oq219OBThBhK3Bb
         DR3BXhbG/d5wkqOyViAAo+3kPxsizYejzhewL39xrAfYGdeAVpIn+0AtRz/6SJQZAIhz
         3O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVggg/zGpEgRhovjVbnJJA36oAouEK0fvptCigeAEiI=;
        b=YvxqA5D08/EyT/fTf4Cg67SvMCLB1SU+kJdxJjfKqubdAOBP95CKd+faHkgtd61qa4
         nGDXe/Uub2pJRZQ5gldFfKm+KMv9tjx7Ix9HjHWU4XZUeU8am0W4LsEsfbrhmb5JjTCc
         x3yPsaquVETNfyaKnncvoNK+BEIV62igfowea1Zg20TuhtFGYLOmSSWxmRakm4kXhUJ0
         bLOuOap7WnbvovAHyUjZsph7DFZ8hX+GpWh028n4GPvEK24F8Bgua7AkVD8yY7EzvLSK
         6G2H/0RjKzt5kjkouYkJmAOmOyRxEQwkIZSNxNAkMEn3ZNR04a9f2eNg9xO4o9mqT37U
         /+eA==
X-Gm-Message-State: ACrzQf1XAqTzsZpGYxEGQG8RnexTycVlXVozTftl3NiyhPWsp2fbq+XD
        GHR4qd+kk9DS+W260iWoljGtgEbCXSaGfg==
X-Google-Smtp-Source: AMsMyM4UKl/gZaGJ/cWVtaEPrCGXVBFGcjnNI41kh6JnRKrICOizaNxEXyI0ZVESLEsCXd1fWghhvg==
X-Received: by 2002:a05:620a:1a94:b0:6ee:d395:663e with SMTP id bl20-20020a05620a1a9400b006eed395663emr1733742qkb.632.1666098293130;
        Tue, 18 Oct 2022 06:04:53 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id bw15-20020a05622a098f00b0035d08c1da35sm1893102qtb.45.2022.10.18.06.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:04:52 -0700 (PDT)
Message-ID: <4b870c82-12cb-5e59-bbf7-4291888f9d51@linaro.org>
Date:   Tue, 18 Oct 2022 09:04:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] dt-bindings: PCI: qcom-ep: Fix PERST register description
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018093115.7537-1-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221018093115.7537-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 05:31, Johan Hovold wrote:
> The 'qcom,perst-regs' property holds a single phandle array with the
> phandle of the TCSR syscon and offsets of the two PERST registers, but
> the current schema does not capture this.
> 
> Update the binding to describe the single phandle array and its three
> elements.
> 
> Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")

It's not necessarily a fix, the original code was correct, just this one
is better. :)

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml          | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)


Best regards,
Krzysztof

