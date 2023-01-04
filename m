Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E165D62C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbjADOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjADOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:40:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5AAE6E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:40:31 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z26so50667546lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7COyuGFa8puGN4hHGdXVhEeO8dZ9H0YPzp0d+LJYE8=;
        b=ImdfTnvx3mLW3FELaaTZudIVpTyirpQHI5OJOxeh2m4h+wAqoRwNaDsaoLxTdqsb3b
         aRfkHg3WKtgcVyVJx+QhaZtJGyfaIIvUHtVb9x23uaOwtFjvQvJETyt/SP5C5b3FxASt
         4tU65h8DpGRGxypYFIBvrSEZLXR01BjNHnUCf9EnCNSGJIiJKk1TyGbCEn0oBrJGlqo5
         sEBq90W8ZyMXQwWbxvB0fQSDPn1pvi6ABrxOKBDBEAIOwcahvcDyRMXl7vX7XUfXlLG+
         HNhRx1TVNiFDhP+C8+tMXYIdI+QeeUpVkJs7xwT+U25sVMtoZ4C4thGi6YolvE0yHXhx
         TiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7COyuGFa8puGN4hHGdXVhEeO8dZ9H0YPzp0d+LJYE8=;
        b=bnodNc1VOiroX6y5JGChcsFY2Gjwg8aT9VJi9NijIvi2g4kCs5LwN1j3k6LIdwuk+u
         x/MuCNhe0Y+kxiGKnJBXvtLzpet5wBpzUuIWoDGARNOFx5WS+VtILEHLhauHO0UZV7Iu
         qCxZMaSYHLAXlJzTFW5YRJPhDUqUwLJEDLgWU+0t09Iyblsqg65y89AOx0Z7JOygMcOB
         6EnufYMP53Lco8artjtoSOZdJPdlLdZf8RuUam1yeEjKAmQQ3DI/w/SQSc5wddXCFjVr
         PdZRL6nj/zvU7VphBZlm7mcmPbAyQffnILBRib7X0Ge7cQC6eOg95XTeslgv6HyQblsR
         FXFg==
X-Gm-Message-State: AFqh2koDc4pFeYd2Su0HMUjT0QgZipudPqgd1DcgTLihRlatrywbBHWO
        W+wY+BMfSs2/Vi5OJnhumVPCJg==
X-Google-Smtp-Source: AMrXdXvcDU9IVMakA31Z/Q2KEc6zPD8IYA6jFRDNOEz+Qt0RVjADy8JjyKjCNMGrdC4r2kC7pyXAyg==
X-Received: by 2002:a05:6512:3b87:b0:4a4:68b7:d623 with SMTP id g7-20020a0565123b8700b004a468b7d623mr15491527lfv.10.1672843229979;
        Wed, 04 Jan 2023 06:40:29 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b0048a8c907fe9sm5059843lfi.167.2023.01.04.06.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 06:40:29 -0800 (PST)
Message-ID: <1d3b7744-4e1c-b2c7-c6e4-87c256ee137a@linaro.org>
Date:   Wed, 4 Jan 2023 16:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 3/4] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230104093450.3150578-1-abel.vesa@linaro.org>
 <20230104093450.3150578-4-abel.vesa@linaro.org>
 <07a849a9-03dc-f3af-1d3f-2369cb71451e@linaro.org>
 <Y7V00JiPAYfqF4wH@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y7V00JiPAYfqF4wH@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 14:45, Abel Vesa wrote:
> On 23-01-04 12:46:55, Dmitry Baryshkov wrote:
>> On 04/01/2023 11:34, Abel Vesa wrote:
>>> Adds the RPMH clocks present in SM8550 SoC.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/clk/qcom/clk-rpmh.c | 36 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 36 insertions(+)
>>
>> I think the plan was to have the _PAD clock as a child node of the rpmcc. Is
>> it still the planned implementation?
> 
> Yes. Here is how the dts rpmhcc node will look like:
> 
>           rpmhcc: clock-controller {
>                   compatible = "qcom,sm8550-rpmh-clk";
>                   #clock-cells = <1>;
>                   clock-names = "xo";
>                   clocks = <&xo_board>;
> 
>                   bi_tcxo_div2: bi-tcxo-div2-clk {
>                           #clock-cells = <0>;
>                           compatible = "fixed-factor-clock";
>                           clocks = <&rpmhcc RPMH_CXO_CLK>;
>                           clock-mult = <1>;
>                           clock-div = <2>;
>                   };
> 
>                   bi_tcxo_ao_div2: bi-tcxo-div2-ao-clk {
>                           #clock-cells = <0>;
>                           compatible = "fixed-factor-clock";
>                           clocks = <&rpmhcc RPMH_CXO_CLK_A>;
>                           clock-mult = <1>;
>                           clock-div = <2>;
>                   };
>           };

Does this snippet pass bindings validation?

> 
> The clock nodes will be probed on of_clk_init.

Ah, I see. of_clk_init() will initialize clocks even if the parent 
device is not fully probed. Thank you for the explanation!


-- 
With best wishes
Dmitry

