Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681E86EF14E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjDZJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbjDZJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:41:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ABC30F3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:41:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso4332620f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682502060; x=1685094060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0HlQKjtrCG4t9Laax1peHQBsnSB+6tL9WVEGAE+OOs=;
        b=Si4R0bqGw8ryba+H6HT8knchCr77SaIdAb1m/MtVBv/Fd+tICJCDpE4t+cqU09xzAK
         yLW8ykbiYvfhm5sAX+B+Pf2w/bd12eINgi1PWoHvf27VnXcP1i4+FYpfThzhZU6RpvUX
         EwE1TjjFkP1MRWyWX7ClhkveQcmsryL+UO5JOmsrVwx4jWv8gXMs9w+3QOzHdIVIIjjy
         F+h1m7GqMMBthqylt/t75oqK5Pv5fIuTO6gIpUuiD1qMF7Q5YkA0Bfb2bv5twdG0M3W6
         dvpWEZxsAVZcqj6pMGNpNEY8w6q2CihkoclGJVJKFD9YBw8iWD7vqVT1TnWiNU04xQ5X
         c5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682502060; x=1685094060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0HlQKjtrCG4t9Laax1peHQBsnSB+6tL9WVEGAE+OOs=;
        b=BwbG+TEcYI1PZRKIx3phCNuFWfA2I9CWgpY1KKuZHsAPiWwUnv9xbrHALmgDCkdQbO
         aPavkqS80frh5QFM5pt8Of2fwgJRJIn7iDW6SJIUHFQ3am6HDyUuHg3+yB+qSo237kHa
         hBMzC9gHJdNwD6boE3LMXsZGqUTtublLlGH+dFFRxGP43aTH2PfMiOC4I1oKu6JXnnwt
         Ku93gprXOoYWjLEj16zq/pSlOa7EpeBhbP/grhEJRdn6SC2i3ylfD04qPpppPjt3heHE
         Cghw7wAJP+cCxBWLSBaiA82HxjLdZQVd7cuVvkJNiaKcwBnHpiN5bx/zYlpS0ucOHeG6
         QiSg==
X-Gm-Message-State: AAQBX9e1caCbX3q68ZswLFfr+r8q04Z73AYKe/JuYv8CyOevOquzQ/rU
        PIWtxaHytM+SKGy+oYNP/RkIag==
X-Google-Smtp-Source: AKy350b3pW/HrOu6B4SVq8LWVFzfaVnCkwPhUMbhB9f70EUAFLTokPNEavFCe/OBiIEfyBTbB5aMfg==
X-Received: by 2002:a5d:6808:0:b0:2f5:d0f:744a with SMTP id w8-20020a5d6808000000b002f50d0f744amr14025047wru.12.1682502060232;
        Wed, 26 Apr 2023 02:41:00 -0700 (PDT)
Received: from [172.23.2.152] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b002e4cd2ec5c7sm15255929wrw.86.2023.04.26.02.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 02:40:59 -0700 (PDT)
Message-ID: <3040c836-4db8-7e7b-3ed4-6d71f0496cc5@linaro.org>
Date:   Wed, 26 Apr 2023 10:40:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFT v2 00/14] SMD RPMCC sleep preparations
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <e3bd41d8-f0c5-6756-13bf-bf29c786ab5c@linaro.org>
 <c7802799ab91eb0a0862a934d3d35879.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c7802799ab91eb0a0862a934d3d35879.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 4/25/23 20:35, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2023-04-20 08:57:53)
>>
>>> Konrad Dybcio (11):
>>>        dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock cleanup
>>>        clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
>>>        clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
>>>        clk: qcom: smd-rpm: Make BI_TCXO_AO critical
>> Stephen, parallel to all of the discussions, would you be willing to
>> take patches 4-6 as they are? XO_A being critical is something that
>> won't hurt without the rest.
> Sure, can you resend just those in a series?

Thanks, I'll do that after Connect!


Konrad


