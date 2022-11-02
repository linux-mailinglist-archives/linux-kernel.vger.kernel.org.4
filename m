Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8927616E53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKBUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiKBUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:08:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B501642E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:08:28 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so13243772qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tD7wPlnyItajlROgfyUnM7qPmpQhM623Azd//U6VBnc=;
        b=JQTRRqKDuF5ZJTqMn0D4/9Clc3M/jdsw4CCGpzv4esXGlUFJlQTBiyLOZTMP0zBi3y
         V66CoXp8NkBC5cqXkz/c9GV8YTxWOW72bSLu6TCsEMEKXsdOndc1JIWg+XRzKYy2SM4+
         CHkpjo+N+1iUF66J16juQPDRHTE91jnECioaqb3Zn8wirpHyLc99Uu1I53jVySRb9Q4N
         /ni+jqLKATb0W1WBqokMrfRrGIqKCTwZO02zgYwIOuFRob4rHLoWYFgtduyVPzgch5pp
         2xXMZsFK3VPttQiVe5mIqhzbw7RG2JuqamxbautsYOwyAYdTQP1oLiyIHg0O5SUF05Na
         eBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tD7wPlnyItajlROgfyUnM7qPmpQhM623Azd//U6VBnc=;
        b=ZT8jMdnG0X8CFQ6FbAVfo1UP2wwW6t5AFusg+7CT6O3QuOdhJ5RTot/ay6brQp6Kr3
         I2BUIuiVGP1vybxtEw0BVx3pmTobc8OIlA5pEeNHyzE7RfscJ6EYMm4wgpjFfu3FAXpL
         G+WRDR1sO0FD0xNs/w2rdke5cODYm1RUkFvOpmVh4A5njvYY3Z/MoXLAwgfR6t7UAZL/
         lOVX352sdYrFPiHvyGdFrM/Nqm8OexAzkprVHYBJG7//vlTOFyeFVjpnsJedZJ78wHWv
         U4lwJ3s6c6+U/Fx2CCQIx4U2yCmPZHHkU/LztR87GgfwKNCynXN5mTBOqx6haiTq72ft
         0+Gw==
X-Gm-Message-State: ACrzQf1K5YqOv1C+nGq+W/fmbBrNQGXoxagcWuThh3Y1RQ37dBmYpd2R
        8godJzkK1xmwAfl26aNuxC9gJg==
X-Google-Smtp-Source: AMsMyM7IEULWef3jhRetyYeISOvL873bwbY7VnTC9PA59W9TVsocedPRx+XeTjE98FvHzLgZBE6Hjg==
X-Received: by 2002:a05:6214:2625:b0:4bb:fa37:86a with SMTP id gv5-20020a056214262500b004bbfa37086amr15365793qvb.19.1667419707782;
        Wed, 02 Nov 2022 13:08:27 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a400600b006ee8874f5fasm8579604qko.53.2022.11.02.13.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:08:27 -0700 (PDT)
Message-ID: <77af1524-ddd9-6b66-16bc-195ee425b365@linaro.org>
Date:   Wed, 2 Nov 2022 16:08:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: sc8280xp-x13s: Add PMR735A
 VADC channel
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-11-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221029051449.30678-11-manivannan.sadhasivam@linaro.org>
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

On 29/10/2022 01:14, Manivannan Sadhasivam wrote:
> Add VADC channel of PMR735A for measuring the on-chip die temperature.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

