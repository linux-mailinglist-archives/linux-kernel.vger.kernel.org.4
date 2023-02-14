Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7312F695B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBNH5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBNH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:57:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978B920066
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:57:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m10so5783482wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r08Y9PyPMDpyrszLAyVhH3DCk6hbIyWyHI7hIZi6JC8=;
        b=k3iYbHKTZy22RV65FMmoOUYsQvB7jUKc+RFnRdCrNJ0hD0dQCFxxJhvlwXIKnUZ30F
         XoolrOnceiRllR+QctKu3DReXUoJvOlt5lfDnq+t0nnP9r7nkX9KURQqzGWL3UnLDsY+
         b2D4KrkP/hInJrLC2awtrYyPA9qwKauEo0vmwGoBkxvn1od2gGsZ3oUyjXZPXFejjioT
         ci5kbA8EZvUnGed1DQ5mmOaNgTVgCrrfuViZVSksZwxS6nH5NAI5nUxNNiXWGU11mSul
         kqK8dQnDKRH2RUtqGz5y2n4Sk+aWE5EsNkO6pjKOmWKtPCQmrWH7Sb98aFC7Ai18vdaM
         xCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r08Y9PyPMDpyrszLAyVhH3DCk6hbIyWyHI7hIZi6JC8=;
        b=Y2swEZntH0x52/IBwKXfAyQRHccdocceXiRE1fycF+LxadJnUhbGWqo3ur+e/ow85V
         NCRO91wWQ9WKvNPSeVpx9e+0b3Dqr2GpSfJ4oUJcdoKdRBSOSDP+WIMEKKRyAZmm+4Qy
         zcF9tPkQlzP1M3EkHcyPUXy8dY3Nea2kputFcvYjv3TxQzhGa8SYCCjekvmjZPWMhtsH
         LusxAQxV3rJbOPm5MPwEnE73yE1syKoHxuujLe6EQQu13DnYkgT+dvA0U12lbMmf+3hX
         G4ZmR/IashAseL8ePGWl+I8HorXV1IpA/NTL5eP2S+s4/gQcwY+jXupctkbSAObT2TYq
         7I9A==
X-Gm-Message-State: AO0yUKW4L67VGLz+KnzNoaoib8j3W/yE/oHJ+kXp+OAw+wIs8zKgz+5K
        nWgND5RFaGAHsi+AnZ9TtY13zw==
X-Google-Smtp-Source: AK7set9SSOrmFJOMfw/vnUHn1Oe8daTUi3aLoP0X/GtU2m7SEk8hV08UuG8m4jKf4JHzbAA86+NQug==
X-Received: by 2002:a05:6000:124b:b0:2bf:942b:ddc with SMTP id j11-20020a056000124b00b002bf942b0ddcmr1244093wrx.55.1676361443203;
        Mon, 13 Feb 2023 23:57:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b002c54bf0e9f7sm9538094wrr.117.2023.02.13.23.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:57:22 -0800 (PST)
Message-ID: <ea71351a-c87f-13f2-e1e8-1d7c5a3838cd@linaro.org>
Date:   Tue, 14 Feb 2023 08:57:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: pm8941-coincell: Add
 PM8998 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 21:49, Konrad Dybcio wrote:
> Add a specific compatible for the coincell charger present on PM8998.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

