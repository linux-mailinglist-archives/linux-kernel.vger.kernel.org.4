Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFB6E8E18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjDTJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjDTJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:30:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2E1270E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:30:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f0a0c4e505so3351635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681983053; x=1684575053;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJasTvAcPZpWbq9JNTQ2VqxZ4zHS2XJZmrHpLxOmkQc=;
        b=jIfusFf2HqrSTuL87+CELYhCA+JFUVc4Czwt2r16AzzEc7P8GfXDV+vvK2mpSP3/xH
         C0viR/hEHXg/PmqCg55y93ADyYqpXowJ19lFcWIHt/P3VgrszLZE+RBEhEtyQLtnkQUz
         uRZlZz1oqZmUBHaazs7cz/4NcukPD4cftlCwE2nF45/8v9oR/JBxawlyEpZtlPLOT+9g
         taXkXivEPJ9+voOintsMKe+04Zwio6DrM1nozjqJvpRp0GuUH/D+rlr9+tEB+Enrl7Gz
         77jRvOpPtmnNhG9arQDQIDgl5oLb3JGTvVTRoYvgZi8o8fGDtidS4aCuey6XNyMbegU5
         xk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983053; x=1684575053;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJasTvAcPZpWbq9JNTQ2VqxZ4zHS2XJZmrHpLxOmkQc=;
        b=kfEaBYsEvMUtGAVXhVHMIVkkWxm/KJzRz+y+YIn2AwtdS8rvOa0cAfc5NDyWKcz2J3
         hKhRz8b8bEAFfnjzM0VI8wNwjwSp7lQBeW5LuYJPEB1iBbLGlodGqMfpgQA6vLP0wQQx
         IrV4OJS3ow+sp5E57wtQ6f+Qg21zmpKDzg7X5ZcVfJ4rQvnpaLwPvuooAI1QCXfgM43p
         aQ8ll+x+Q+xg/MCLF6O0dmECr3UK7+7o5FAZJHVhSq78sBxUpJ4qedrxF2JEpWSbDTNC
         p97kNPbOaydnAcQd+HGxBLO3uiZkM8ozpk21gon0CD4lQOzlCBJgn40HYGXV/PYQLUuV
         nQzA==
X-Gm-Message-State: AAQBX9cEwo0QtWa8Bu01b9Hoh1WCg0Yf7jEarWpHH0pRIi/Mi0wbtXzs
        AvIsMvs4NEQ8WDdc3vcbjm9nOkiyJKQJVG6f+IY=
X-Google-Smtp-Source: AKy350Z6A2EaVwWFJQRezHo7tTFtyB+KRDV/NyuM7EHBwxbwKzGciwnvTAcBAS+l4KmQZJze3Qsdag==
X-Received: by 2002:a5d:484b:0:b0:2f2:a6e0:b2c with SMTP id n11-20020a5d484b000000b002f2a6e00b2cmr918515wrs.7.1681983053126;
        Thu, 20 Apr 2023 02:30:53 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b002fddcb73162sm1447889wri.71.2023.04.20.02.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 02:30:52 -0700 (PDT)
Message-ID: <978f953c-4c00-6cfb-0955-b13114936541@linaro.org>
Date:   Thu, 20 Apr 2023 10:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: dt-bindings: qcom: camss: correct unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 08:24, Krzysztof Kozlowski wrote:
> Match unit-address to first reg entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
