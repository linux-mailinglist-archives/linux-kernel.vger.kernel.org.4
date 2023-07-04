Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E235746B72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDIGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGDIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:05:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A1E6A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:05:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d5569e4d1so5002028a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688457951; x=1691049951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kE2ue8LGVuugjUiTDaUn50VTM+JPtGA4JYDXutTtpKg=;
        b=eZ00IGtMjV0y8RSQK1G+L0JHyYMiUuhSy0hbYWjiVnQLMwCWZ/IbI42ATFnlfasT06
         UEKPptczTbQ7Ntat16D4ikwpLo7FGp/AK8n1tySnfm0X+7xc+iP0AFLN2C5pOlTy5vG1
         QQ4C+QUqhLgU+bWtJqknLZSKyr7CYJJSTxOuvkYVpCQ9HEMu1iyoWvZl8r1PXPX5O5ZI
         cwdUXUGQ4csqkxt3yfQa/Jw/F2rOpj52jNlEz2gupm5UIulDa7QRluGNlBbbO0VuZFJT
         ESv5SV+AL8miTQbyxzmzwKkOIASl9povXsUxIY+lFfj+clJh/4r49dX25wlDnBq7A+lM
         bPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457951; x=1691049951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE2ue8LGVuugjUiTDaUn50VTM+JPtGA4JYDXutTtpKg=;
        b=bw+6ApSfVzwZP6ZpkFw0sfCwqrg9CCsUZE6sgCRqlPNUl1/eZAL+2Hx2HdtHnCZ/Zc
         sCNy932NuGPoObRk9yYAIQ1GfafoFukYqxbwBzIckaZjk3oKKqR8V/u+fxgAZKwnvzDi
         zwWh8kg99FkXiGdYJZcMrGOpjlqv/PvjLyoPvskviyEs4E1W2BPnjxBXRKuU7nJzyIPN
         aN+BlqLDFBXjo56Fne/viOfqCTJ+lh2ndK/W+I41PzuEQ+19G5WDH9yqmlzBY8Wa6jrx
         LrzZpYeYAGEbTCnL4Le5MogDuKiamttPQpAnRKNr1cLYa6pSVgg24g0DYDVWg2uH9PQx
         UVQQ==
X-Gm-Message-State: ABy/qLal+zwb1gDe4Qs/68grmXhRPG01r/u1ixxzqMDslvKSKue/uIVY
        L7Nqx5vOimGOwru/S8OfUTrCuA==
X-Google-Smtp-Source: APBJJlH1b2c/hQwTCfqQugMRZr6jblfjuFAZ4XD7Ctk20k2tIjH8q2+xYaNZOo4GRWIpOQ6n7g7lkQ==
X-Received: by 2002:a50:ed1a:0:b0:51d:8971:4325 with SMTP id j26-20020a50ed1a000000b0051d89714325mr6186944eds.9.1688457951360;
        Tue, 04 Jul 2023 01:05:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a17-20020a50ff11000000b0051a4fcf7187sm11269669edu.62.2023.07.04.01.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:05:50 -0700 (PDT)
Message-ID: <10027cb1-ad3e-ad19-d25d-5356ef715be2@linaro.org>
Date:   Tue, 4 Jul 2023 10:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom,sm8350-videocc: Add SC8280XP
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230703-topic-8280_videocc-v1-0-8959d4d0a93e@linaro.org>
 <20230703-topic-8280_videocc-v1-1-8959d4d0a93e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703-topic-8280_videocc-v1-1-8959d4d0a93e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 20:09, Konrad Dybcio wrote:
> SC8280XP reuses the SM8350 video clock controller block, changing just a
> couple tunables. Docuemnt it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

