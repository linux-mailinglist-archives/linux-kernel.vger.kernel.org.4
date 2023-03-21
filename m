Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A46C2B18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCUHM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCUHM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:12:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D863A4C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:12:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so55953868edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679382753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQDpM642Q7hh+JU6LrA9OjsR/cxj5kDzAwWOZcWdIbA=;
        b=aQrcQgyo11wxnnw3d2eAgZ89uaAIlZ++7g1L/eFVF190EH3F4piD9wWL7Vb2XIroHC
         41XYuHVmRxEODlVYCa+JlRTPAY8Q59zt7FmDTd6/h6gGueI3F0ZpxNyhfrVw/1Uo5s3b
         NEW/cocSysXhyWTk6bGvZ9W6lRpM0gPDY47WSdvhV4LPAQ/4s+X9UDoV0IAokhpp9MGB
         DrLonGdwBkY+qJiRkwhMZPzdW4y5Lu3WC/YqKDyG75YhPK+RYFJvyZoOYuCNazsKVXjO
         kWBegtKb7SbKDZl3n5EBwSPz6/fhA8/RGgfnMKQWtgjtXnqzID3u42bh4hxwuheuY1pk
         kbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQDpM642Q7hh+JU6LrA9OjsR/cxj5kDzAwWOZcWdIbA=;
        b=1k+TZOaJiFu9mpMWAiAIXp6MPUzxCUb5umrqu29YNxUH5WANHQ3oNMuerPTXc1vg7h
         mjEYhOz10fMELRmtYUGXaxL2m7N/DE1w5qcmni1PrzF8iGY0u4bNOrbqyDUP56aMrEJF
         Esr85yC8f7q2TkWWUmXzZhQah786+d69n5Lh/gv8WjG3BYxwKZM/rJ8uGrxEhFR4lhDL
         6rxLdXtIwhpEINRotjTUhRyQp92hLXt9KzD/2ISDJDau68NbCyvL4JukZqS8aQO2ykpd
         AK+fkuOEV4UGEpDIc/vvlV+yWXKHgiWHOSUGIBKWmbV8kbVeBnZXVQgA/s7pxHzDSHyP
         F2ew==
X-Gm-Message-State: AO0yUKU8T9RJa1umgRv+i+gXi8pVTuLXbg4yxbslX9NRtMCHgXuOi3RJ
        UoQkMAhK3TPOQz9b1Wy2n/coFw==
X-Google-Smtp-Source: AK7set/PS7SqaShaVg8CYnFcSB8qQVtfJLlDmBlSv3yu/1LJQBxNneLuUdR681oROTjjAhpE4BSueA==
X-Received: by 2002:a17:906:5d0d:b0:931:9cd2:c214 with SMTP id g13-20020a1709065d0d00b009319cd2c214mr2276084ejt.66.1679382753642;
        Tue, 21 Mar 2023 00:12:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906c20800b0093a2160168esm282129ejz.35.2023.03.21.00.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 00:12:33 -0700 (PDT)
Message-ID: <8569e185-f49f-5095-ad87-f09c0a5719e2@linaro.org>
Date:   Tue, 21 Mar 2023 08:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] dt-bindings: timer: Add timer for StarFive JH7110
 SoC
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20230320135433.144832-1-xingyu.wu@starfivetech.com>
 <20230320135433.144832-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320135433.144832-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 14:54, Xingyu Wu wrote:
> Add bindings for the timer on the JH7110 RISC-V SoC
> by StarFive Technology Ltd.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

