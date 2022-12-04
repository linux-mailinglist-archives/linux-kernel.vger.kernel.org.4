Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B392641DFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLDQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiLDQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:43:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9C15710
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 08:43:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so15329918wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gT/B/EAWvvQ3x+0gmDPuocEhB6PCpHAkErzF+d1wppY=;
        b=GZ1kDmpbbIPKd0G/oggHqKbaOzNeRecnfrW9VNrGs/KovxgXNa2vcg/54YMCTO2Xai
         pI96qy/5HEI/+1OEPKKQPGrTKkCuPipVBy5gMXKeI9K5J2f/Jyo6G1p1U2O9QOKG7wKE
         P4XqqO4dkq8KBeql5lJa1NWUBNZl+mQCWqbc1whrC5nA4giONxRyIzIUuYx7VnCnrboJ
         Sm93EcBT7B8RCSH5v+IZF5Bwfa4yfnD4UsK7QCI/W0B/KOqU0pNcJFtl6iuyjx5T7B8V
         fKPy5ReHyk9AAFDcx9/CMoGJ1XKEImc0Rc8SlYM61N9nEIE0IyDRCwR9fMbI6nVQ9nX8
         JFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gT/B/EAWvvQ3x+0gmDPuocEhB6PCpHAkErzF+d1wppY=;
        b=FLMostMaRq9QzVxriPVBh7+pQO4gdyvSpvQsExwsuSRmqOCWwDFykzIKAna3uP0er1
         jiacuYPvGyKpKmvC1gYQOTo8yXgbz3o7jS5NVJDQnE/9FCC7d4XbpWYmyLFtNZLtTHbJ
         GiZIYBel9XFLroKxP1qoLxkUcYrG74EZXdAGR7pKMlGvGo8918Ysr/yzKsoqFdsaKSZF
         zIBzaH9Mm+uZ+BDhSbS1MkkYLhDB/SfhHVuj9bqeAXYgLCxlHr8rVbjNOAbNig72iUvr
         D9AXqXZ6aFz+h8LrXVCyajCYtJg4LSCj3fB/XUtznGBOFZMZW75PgbkvC5VhpmUvi4pN
         Bc1g==
X-Gm-Message-State: ANoB5pnWBLucwUX+RdS8pH3ssGucj6SzwWtDBJ4t9iq83nOe+CnSqPTu
        3qy+8cWgWLW0NmO5M9xGfjnaAQ==
X-Google-Smtp-Source: AA0mqf4sAuxjvaOBDZhtrGGYt7BstKJKEBiKdUr3ZkgAhbTJspC6aS7UljKY//5yJR5pedqGj15Pqw==
X-Received: by 2002:adf:f5c9:0:b0:242:10ac:e8c with SMTP id k9-20020adff5c9000000b0024210ac0e8cmr22318955wrp.67.1670172207444;
        Sun, 04 Dec 2022 08:43:27 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bs4-20020a056000070400b0023677081f3asm12202573wrb.42.2022.12.04.08.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 08:43:26 -0800 (PST)
Message-ID: <0a91ac56-f888-8127-8a1e-69519223177c@linaro.org>
Date:   Sun, 4 Dec 2022 17:43:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: narrow interrupts for
 SC8280XP, SM6350 and SM8450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
References: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221116113140.69587-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 12:31, Krzysztof Kozlowski wrote:
> Narrow number of interrupts per variants: SC8280XP, SM6350 and SM8450.
> The compatibles are already used and described.  They only missed the
> constraints of number of interrupts.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

