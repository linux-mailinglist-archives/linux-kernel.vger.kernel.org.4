Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35E70729D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjEQTyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjEQTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:53:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE8D053
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:53:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9661047f8b8so210059566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684353211; x=1686945211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYlk1Cq1dHZUtz0xi4VmV/0/KIacvW797So5fRhrj5k=;
        b=sXie76Lc9RCKTC3k/IuvnlsFS98agub3SS30rKtS0w4jS8mDpReuoM3UTTf6/4pPhe
         PrgdXq6sEu9I2M/srWoirq5yJBxEdhk9clJbefXvX1iWhsoiQZwQ9rHTLdoNF7F+Pfmp
         G+cIeAZtcTp/PBvvz2vPbFlPQ4dXPsZ/tNgGy6zHoMVFVzKJrVeZzGzHpL6B1Pbc2sws
         Z+tqaA6ihRZxq4ZSGVy8bZhFdmwKlJODChy/z92WB4PT+Uczl6nEtuGB9kS7vZuqPnue
         tiS7nPvuPlv+roEFPfeiBHfOAtW8V8yW1Oh7PEchlyQ09zKyXhhl2IgLHKSg8GlRQKa9
         uEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684353211; x=1686945211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYlk1Cq1dHZUtz0xi4VmV/0/KIacvW797So5fRhrj5k=;
        b=QiwRgkzaphFEIk1OoMLeK1Qhq5w11iyz49fFjj12pdyd3DPned0KFHofjOIN/f3a4X
         GToqE2B3ixLd64AJS7UZancy2L5FmznmeuLtfgRn0Bit+9e/ios47E+6n4DpEyU16SJM
         wWGCV16xOQYXgferATS3y6RkcRGNm86FBfXUEUsspTTzD0q7HDbQlCWkGxonHD3uBdI4
         aWxTJYwmooIda76YvPTE3ylHw8Dz5jTooiGg+7DtfmN+6S/Tz2B6G/l1MhZwPS6E9hdc
         Dq++sQg5cgHJq3lGqypDq3nzZ74U8PUorUK1au8jlZCvuhAXFV/d23T3WmnY7nBNiFFZ
         U5xA==
X-Gm-Message-State: AC+VfDy55X9OU5jI1OYQ2f2poW2FZ25M3u/1bCv/ZzBvf7M+rrcXMxjt
        DSLorFlCVoLn9QjwZGgpfeGLgw==
X-Google-Smtp-Source: ACHHUZ7Fh5eSe8ZQ46UdOQaApozjJHU9FJn0F4jS4HdTk3pIliJ7h8deq7WtOt6rWCg2O6pLX5BiIg==
X-Received: by 2002:a17:906:ef0e:b0:965:c2ab:7014 with SMTP id f14-20020a170906ef0e00b00965c2ab7014mr37811291ejs.35.1684353210741;
        Wed, 17 May 2023 12:53:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d7a:e7cc:21b3:c435? ([2a02:810d:15c0:828:d7a:e7cc:21b3:c435])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906268e00b0096aae0b36a1sm7982814ejc.33.2023.05.17.12.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:53:30 -0700 (PDT)
Message-ID: <f2efab1c-7083-c164-883c-4a5f2b1caeb4@linaro.org>
Date:   Wed, 17 May 2023 21:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: add missing RPMH
 levels
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
 <20230517-topic-kailua-rpmhpd-v1-1-cd3013d051a6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517-topic-kailua-rpmhpd-v1-1-cd3013d051a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 15:19, Konrad Dybcio wrote:
> There are a lot of RPMh levels that we haven't included yet.. some
> sadly turned out to be necessary, add them!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

