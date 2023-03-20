Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF176C1476
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCTOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCTOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:12:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6711ADF9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:12:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so47337452edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679321563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dK2MAyLuCPlT9bihWVJaLt1UKGVXwplMktCHcbhdemo=;
        b=sKhOnZ7exS206JUl6LhXyyEdxlDCBOVR424VFOx1mbYbmunR4tSa639aKm87Zs69jz
         cHzizdq+A5fAJlQDUKA2tEp8UVc2LqtOJmNjsLO+/tdU8BilWgePVDvsD8WXPLhYJeUE
         d23h4Q5PrLrSuivpBcqIwZz9KEiq5QvXg0RGVbTXIb3Z7zqrTc49SpI/HPPI7FBrkZGP
         O9pS3Va+H1kDMruwcxOaWwCGI9WmxzROJ25hncFG9WVCaCLePGJsosgODfeZTLiLuVT0
         yZNGXXAg6lAzoX+51ABOT1uM2Y9sdNREw65vrn2vo4kS1Is2WHWbSx1EKNAoG/1V1VPk
         BCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dK2MAyLuCPlT9bihWVJaLt1UKGVXwplMktCHcbhdemo=;
        b=VquULMdwOwOB5sl3w0qMyz7n9P2RqGaKj2KLy92KH13l5Zqh8FrgdCRBNkTLTnItJR
         io0PQepUeOIiNVP+mJd/jg2gc/J+dZO6Z8hUlSaXhsb0euhJFujprrx4Sodit48fiOGU
         TPv9GWG6yETY2Z0JT0OdntvNqWo4Rs2ChCXtWelOxS1ELxkPoCmGxnrJ3hYZppclsCbL
         oYd4HM/hsYl8Vabez41oVJyXL81y7qkLG5Lqg7q7pqz8vav8FibXxk2B8df2U69djF6D
         oum808Q7Yft4/3N8qlqLJIvAkFHRONbIh7nOXA5z7yoWlFYQtgqyFn2iioBDOZo51eeH
         +b7w==
X-Gm-Message-State: AO0yUKWjrCXZiJ52g3qZWcTnRvHv599rv2iwWJrCIoCHxepXHcnBaBF9
        mm0IRpRa60NSGVuPaZLtJJQa6A==
X-Google-Smtp-Source: AK7set/V4bwREHn2modMximaNeeAuaCA22rmL3fOs5w0Kxpcp55OZ9uXu/6F5/kMHmGidCVuyNNqbg==
X-Received: by 2002:a17:906:960a:b0:92f:f2cc:93 with SMTP id s10-20020a170906960a00b0092ff2cc0093mr9331191ejx.22.1679321562761;
        Mon, 20 Mar 2023 07:12:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906825600b00925ce7c7705sm4450809ejx.162.2023.03.20.07.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:12:42 -0700 (PDT)
Message-ID: <136736ef-2502-0f09-1c09-02fbf155ae4e@linaro.org>
Date:   Mon, 20 Mar 2023 15:12:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg'
 property
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-2-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320135710.1989-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 14:57, Johan Hovold wrote:
> The SPMI PMIC register region width is fixed and should not be encoded
> in the devicetree.
> 
> Amend the example with a parent pmic node with the expected
> '#address-cells' and '#size-cells' and fix up the 'reg' property.
> 
> Fixes: 9664a6b54c57 ("dt-bindings: nvmem: add binding for QTI SPMI SDAM")

I would argue there is nothing to fix - the original example in that
context was correct, because examples have size-cells=1.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Best regards,
Krzysztof

