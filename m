Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75119717A03
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjEaIZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjEaIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:25:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB697132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:24:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f7bf29550so843732666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521496; x=1688113496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2k5vPCSYnWtSGTIXwcTXsVrzq1qAVk456v6qUvHjn4=;
        b=evFEiVsObtTsguxnNCAgyFMiGaOcl5N3jPA/b1dfzzxdmr7Jy0JqbFOtG2iwISFbS5
         UEScpDBWrQehDu+E77miJNaj7IJiJ/gHMPqivRaB/AVpYU/XdIE0zaZ+KdVno278w/EL
         UoaqPfOwM0/W7ZT4h7OoNrQrUS5y9W2NvFTCOdAaewnMQr0FbXPNCZMxsJX6E+nPUciG
         AA06h/GhdDjbP8r6eSLS3IQQ8aq3NIcnBuiKQDXl42pQzt04pKyROvbY+jGZ8wmYMQmw
         eGVosKJhlHHYCwvon/4xQJdyJ4zQ0qz2tytSHxRpt/Wndqpeu/NIyr+MbP28zYqFzPsj
         vSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521496; x=1688113496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2k5vPCSYnWtSGTIXwcTXsVrzq1qAVk456v6qUvHjn4=;
        b=SkAUbIYdNxkYu6kTdbAd1yodY2W/aBoWVxq3V7o+YQxNV1+cyKqKl7NlQYW3TTffvx
         NylEawWdEiqiV1hP+SKaOtQlR7olCkYx/p3Ud2TLXnjVd0g1PfXxsp9GlSKpWie7jLAa
         e6+hU/0tpR/SqmBWEXOVWCONkKa+5G0wcJkSUhPYQ+4CxQSzOeFLMGXEJTzNS6ZDJsz3
         P9uRr3tX13Qp0oA0RVsYhg1gKzcvupiTi6duEmkK0Zw9SiG1ln6w1m7OiPkniAkyuFqe
         2PhdmnCiTXHRfC6ae97+MMJX53NHiAqtssGu4lDRZ/7GxKnYYANE5E6GRAY3hZjRaItD
         6AeA==
X-Gm-Message-State: AC+VfDwpCpp5Hcf+/D8xds0TBYOAzRxKW/mK5sX9YzHwMkUj1QL3K1QE
        NKcE7iMTuiT3ykD0PKGXOLWsCQ==
X-Google-Smtp-Source: ACHHUZ4jvJs4A1incMCwVveO7FKis59XsoCRL227C6H8yFSlGVdTx0axv0RDEFwrhmF1WeUbCpAmtg==
X-Received: by 2002:a17:907:2d08:b0:96f:f807:6af5 with SMTP id gs8-20020a1709072d0800b0096ff8076af5mr4841959ejc.39.1685521496172;
        Wed, 31 May 2023 01:24:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id si16-20020a170906ced000b0094f1b8901e1sm8531239ejb.68.2023.05.31.01.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:24:55 -0700 (PDT)
Message-ID: <8f915d90-c67a-430a-7539-4887cde37345@linaro.org>
Date:   Wed, 31 May 2023 10:24:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 05/15] dt-bindings: qcom,pdc: Add SC8180x compatible
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-6-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-6-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 18:24, Vinod Koul wrote:
> Document the compatible for pdc in SC8180X SoC
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

