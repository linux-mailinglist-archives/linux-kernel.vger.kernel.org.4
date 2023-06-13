Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA172DC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbjFMI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbjFMI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:27:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6141F184
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:27:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso5957455e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686644820; x=1689236820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=da3bgPD4DJTBCKREar0ISk+ABrs/ASSLdPpdegj702A=;
        b=eJ+yj9xotMTyCTu4fQ6/BApJrjFpKtY9tvNZonrimOg1+iBm0tLeg112KLAfb2MRoQ
         5Q9bnf3E3KU9H2WAEx7DIs9SgIpTB0b/POe8zb2inOi5W2ebkNOnqFxt0POFDwnfCL3d
         EZ3J3yKDd2EcyqU/n0Gn5xVBW1eu/RMpRyReq5EJkh/fbnDCAkbzJP1MMbvetOLD4Jw2
         MlnuTMTpJKUUQYoAXeDBSRRl1RGYID9sQ9mjTZdDc6CKSLpLA9tucUGq/ax5DKFL5wQ5
         Pd+NcZowrkVpA277naB0U8sxpe05tdm9ua3SvBTCmiFOTJReU1Fftkr8pLUSjDR+QdvR
         iqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644820; x=1689236820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da3bgPD4DJTBCKREar0ISk+ABrs/ASSLdPpdegj702A=;
        b=KiY6LhlKSqINOjLsKT2BpBqc4cgD+pyuL8pQWI1s0OxRbEkjnTaC3qAJ+SAuxXQR6N
         WqW3QJdTOXo/4Jzy25sqBize3WkzqIslVwllN4XUMmVskUpn/0cwoh1Gq2eGy1Nt9igL
         m/kgrXK358XpoU1gqzHQD+ajMTB+qEYG3vwdK9QjzRm/fbYy8NQiu9YanjXZBea7u2rx
         MqrwNaR+V3hVOMNgjGUj4PGNjUZBMWTBWMKcKSFMflvqCbkzP4RWps4Me17yf2ap37SS
         OTdDWTwLoqB9HqqtsDoBcurSwpslCQlljZwTlrU4I567f9TfxJdGaGXa3S72Fs37LDfU
         VYQg==
X-Gm-Message-State: AC+VfDzy7gpaHuWc6yO/4qXZ8ttmU52eDkYt2azXJAm5U0chDvezH64F
        XN3h8/Atvm2oNd/MfUQoXsls7w==
X-Google-Smtp-Source: ACHHUZ6OdD09MvuXiLFW+4rUzx57nh/y+qj7XtYRckeDHcgQKo6PdnIDayymg983alXnt/w00XBAbQ==
X-Received: by 2002:a1c:ed15:0:b0:3f6:da2:bc86 with SMTP id l21-20020a1ced15000000b003f60da2bc86mr8772098wmh.7.1686644819811;
        Tue, 13 Jun 2023 01:26:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id 10-20020a05600c22ca00b003f427687ba7sm13597209wmg.41.2023.06.13.01.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:26:59 -0700 (PDT)
Message-ID: <d86addcf-0f3b-935c-41af-568deb79db13@linaro.org>
Date:   Tue, 13 Jun 2023 10:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/3] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1686125196.git.quic_varada@quicinc.com>
 <ec9799504fe5a141e107bb78955d8d427f00553f.1686125196.git.quic_varada@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ec9799504fe5a141e107bb78955d8d427f00553f.1686125196.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 10:53, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Applied patch 1, thank

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

