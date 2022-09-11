Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0C5B4F29
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiIKNjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIKNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:39:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9DE2EF30
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:38:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z20so7637345ljq.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=byDoEC5c96PKF/XCpwCssrTaiIUZpq7t1dBkW6DDvOI=;
        b=EDxmFX0aXLLqtay8aHXtdtQFX1R+h0YxS2HUjABJXc3pRNsHs0QTRvmGkg6pbUpFYc
         0kARHVhKsY30imN1VNmY4pbW3cQIm5sbkJaOKVYlv6yRfoWiJh1xEyZVT7txaJj9+VEn
         gnzcdRGmZRph8EotCRB7Oj5QHRkhFORzZll8RJkepQilubALxKrGEdunSg3fpVHbFPA1
         scGuf/w1nhnyVwR4T6+V3cfvcS47pYvqHftyFTxoB0aUjvyNUQ0zi+IHUgsLxNB0/izK
         kuDtYXdqJo/RRP2I/A+iEnkV7QokMjwb7uaBb95T0yVPsVP5Xq5vRXDFj1R+imki6ehu
         b2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=byDoEC5c96PKF/XCpwCssrTaiIUZpq7t1dBkW6DDvOI=;
        b=iOTP44SnmKy5M0r7+3yuFc4IHlDpP70jYH6QctWouXezykYegE6Oq+rly67d3vuz5l
         /GB/gLxcoNKRuy6XdJMuFtb4GbUAamkUTMf5KueeCLVIZ0kK+OVsrn6lM8vNvJQp142q
         Ijnl6+vcPgGygvL/9rtorCOs3zvIGvEso0dIc4/xVwUrZBhCbTKcnKSduMYxhIG+CpcG
         5k4EojDI6qJVZ7auuyNAyBVlfX84n8lRK08pTmOh1KXHvmhInNkwmOQPJVu+zf/aaPJK
         oin3+7p9aygD0D5MMCNho0iBLOteg5jxpTI0f2D6IC/AnWT0626HQ9ZPSA6skw9FugEL
         HrGw==
X-Gm-Message-State: ACgBeo0RgSAOWCrFsYbYrEuwwOlh3iWG2jRzRq3w/O0V/MoGgvz71M7U
        d7jp9F8AL1KcEjxcGxSz0hdltg==
X-Google-Smtp-Source: AA6agR4fLp2WzkQVw6qAg8wHdybfJTr4eKnFEPkRlmI7lukKgwOozcaG1ZnhY1ALW6WWkLoCcJMRRA==
X-Received: by 2002:a2e:80c8:0:b0:26b:fbc2:350c with SMTP id r8-20020a2e80c8000000b0026bfbc2350cmr1450892ljg.508.1662903535802;
        Sun, 11 Sep 2022 06:38:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o5-20020ac25e25000000b00492b0d23d24sm610632lfg.247.2022.09.11.06.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:38:55 -0700 (PDT)
Message-ID: <7f132784-a324-c9d0-f22b-1d18ef1894ce@linaro.org>
Date:   Sun, 11 Sep 2022 15:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 10/12] dt-bindings: PCI: qcom-ep: Define clocks per
 platform
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
 <20220910063045.16648-11-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220910063045.16648-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2022 08:30, Manivannan Sadhasivam wrote:
> In preparation of adding the bindings for future SoCs, let's define the
> clocks per platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
