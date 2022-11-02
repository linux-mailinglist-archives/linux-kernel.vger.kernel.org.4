Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35D8616E55
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKBUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKBUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:09:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DFDEDC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:08:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so13244285qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gp2bm2snYyZrDLYIPx7MjAauVR3GWwgc7AUFVNlTMaQ=;
        b=edY/GKXLoiz60oas48tPOnNodgxbKoAqsoNFGiDIfjI+TK6iB7i7c8ciiX7RV70T0v
         ZGNzvMW2mUFcDHDLl36ZLKlwDT9LqHpyaVz9fdzaCmqwMBqPm+yxUituHGUwZTne/RLI
         hD1cHHLwfl6Jd3Yl4oOVCByscE4kM7g2i8K0gslAUAEY53uhIiqKWOBQ8KGm8waFn4iJ
         wAFKxFRwXmT9VMZpsfGonPAFgg/7gct72NkKT5+JqtteocvU5BU9LJZ25O6RoN1T+JjL
         SfzQt0l8qXKdkrPZDRqWltQg4NX16TPC6lQf7VCbZC+y+aomfITHunPa30L4nGvBpjOf
         o82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gp2bm2snYyZrDLYIPx7MjAauVR3GWwgc7AUFVNlTMaQ=;
        b=RmHGi7j7SopM487UQwQuz05NpRj+MDlR0qcDlGU7aCeSj815AK61SYnPoVzq2i/Wq+
         z8OY1+qErj8pPjdzYeeHYIC8Su1S+LlPB94vvY5fsoXH+V4qUGCx1vzF8+KvnTYXQPJq
         Wcab70BwdBr9DB7INaCFQlizIce2EmasC1RIt1veSOTb16htwPHgWw11oVgYSx+eqvE6
         5PT2oSgGHU9DfxZKfQ/o1C+H98KhfNv6VTBD4iVGb/LIeg++T12fIiaJe7I9JoWalkaX
         0WHF8PW3NI2UmkH4OzCdw+ck2cyqbjSrAskkBgg4nUK81Azxme7YiTJExyuR2jn1J7as
         3fpg==
X-Gm-Message-State: ACrzQf2CLo4SLY48BJ9ATLTeqb3SDcNjRUFUGAZ6YUx9qhucMffmCPYe
        3rY+cwBqlJOwjfbxDx7dnPNaMt+fJwfSfA==
X-Google-Smtp-Source: AMsMyM7S/SZg7E79z2pIK6TZEBR7PJcdFq4iwCCt4Ah6wA1qmGEN+vlgOkkqT41AwzPXWYDk04hSmg==
X-Received: by 2002:a05:6214:2467:b0:4ba:f07c:d9f7 with SMTP id im7-20020a056214246700b004baf07cd9f7mr23211434qvb.24.1667419723966;
        Wed, 02 Nov 2022 13:08:43 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id x2-20020ac87a82000000b003a5416da03csm1886261qtr.96.2022.11.02.13.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:08:43 -0700 (PDT)
Message-ID: <b4239515-5d39-1f23-d937-a1e3ea64f91e@linaro.org>
Date:   Wed, 2 Nov 2022 16:08:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sc8280xp-x13s: Add
 PM8280_{1/2} ADC_TM5 channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-12-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221029051449.30678-12-manivannan.sadhasivam@linaro.org>
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

On 29/10/2022 01:14, Manivannan Sadhasivam wrote:
> Add ADC_TM5 channels of PM8280_{1/2} for monitoring the temperature from
> external thermistors connected to AMUX pins. The temperture measurements
> are collected from the PMK8280's VADC channels that expose the
> measurements from secondary PMICs PM8280_{1/2}.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

