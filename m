Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37D5E9C88
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiIZIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiIZIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:53:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A313CBEB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:53:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a10so6695212ljq.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pWOHmZ8E2Cu1dLgJ7asOhy3zHG160ayaZ2FbZvz261c=;
        b=aNc4BJHhjnh1fR9WCl0peylVqakw6v+i/Oi7ZTYVB/d+XvbWtMG5TqnVnE4QVvhpaL
         jasloUKpm1elTA15qfaHEXtHZADJ/EcfnLB/jkbCPRcf9Ys0qt5VfuQ/1FvblhKOjCAj
         pSUcK8qbU8CmFq+G0o8lt7H2mIg7kjgPR0/4Oe7FCdn5ALBUJl1c/Kiqx5Zc2UvLm8Vy
         cQEldEhSy0IWUtmHMdEf3LIhM773EDtXda8jXHxX+6uB9U/cj4QoOsibWjwf0Q+kjkt8
         D6/R/hnNtyD1QNtDHnxfzgoorhQl6LtUR4MeuOBL6rfhZMnRePdfidFlEgjX5qgOG4P+
         tLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pWOHmZ8E2Cu1dLgJ7asOhy3zHG160ayaZ2FbZvz261c=;
        b=c1gZdGNsaEsKXlMtAHkfPoQLgpmheJ+89SdNGnNrinoBI7xXEM3D3DH0QgYQ786DEW
         5wKRqvHDbRg7EPaeIcB+k92gfnA36TXu0GO5icl0Z+T1Jo93Sxg0LnNjW7q29zrZV6kt
         b2aaVHeAwK5g88kf56fbgrBwgorPnuy5LtWzBG5yU9H2DPSLCX1Tf58qU8i9Mtj600ux
         TDSUvS8L+Jdojn+WNFYvKdGVEkG4JY8raefCvnQq/PQwmvoe3rlAe+K68tGpq1lST6EO
         mOCam0v5JbU8bjdQsfQiOSsgwzGXhaGZ8H98hO8LgDN/u8jyUJ9IfcazejqTH5wQ9x3v
         YSig==
X-Gm-Message-State: ACrzQf1x48Mm0Gs/huuAxRF2ib//9T0HeHXWdw6yAwImMBwvU0k9lSla
        M6t5Zx+BD36OWuUHPoDxIWoKIA==
X-Google-Smtp-Source: AMsMyM6VuOH6igw6JziYly4OClY40KRp0xPRhIeOGJFZvE/PKxRm5TWnlRfvp6nk78lUnYxK4fBNgA==
X-Received: by 2002:a2e:818f:0:b0:26b:e97e:d830 with SMTP id e15-20020a2e818f000000b0026be97ed830mr6970676ljg.420.1664182385656;
        Mon, 26 Sep 2022 01:53:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651234ce00b00492d064e8f8sm2467982lfr.263.2022.09.26.01.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:53:05 -0700 (PDT)
Message-ID: <205a80be-de12-b610-eef2-e9e42179cf02@linaro.org>
Date:   Mon, 26 Sep 2022 10:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8916: Align dsi phy-names with
 schema
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925172443.92900-1-luca@z3ntu.xyz>
 <20220925172443.92900-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220925172443.92900-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 19:24, Luca Weiss wrote:
> Use dsi instead of dsi-phy as required by the binding.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Already sent:

https://lore.kernel.org/all/20220924090108.166934-4-dmitry.baryshkov@linaro.org/

Best regards,
Krzysztof

