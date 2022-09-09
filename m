Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF25B30FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiIIHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:52:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957C4100437
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:48:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i26so1289085lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XitIxUHJGo2f9DX5GRhObqjIng6zVOJXz69iBessMFU=;
        b=L97CZRY06nPAVO2OfaqkDh7hDE69MN1yhfPKrXfcLG29+BwLuBPS89NmTsFcq6BkLM
         10kLmFCJchZbP8QD9J7ylceXflafN8M9uNcjDdQDeaeGDuuqbr4UYLEupTrQh2Svb2vg
         wVxaRisZMr/mLbhD8iisCVPxegfHisS9A3NKxtEOa6B23egfycllvL0ipWU/G33fUUkm
         ZbUfmgUWVuglkQ3BT3qcWnYj5wudUnSbZhAYGlBOL/2iAn3/rnTOPKjcrylT8jiGl6bM
         xnlt33Fb3mMA+ueFAHPm7sOqrKj0xvajGQqeapg93ftiY7FnZSnJ1FjYzPmmrxK9U4G1
         CIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XitIxUHJGo2f9DX5GRhObqjIng6zVOJXz69iBessMFU=;
        b=1q7Z59RJdcxoj/CzF3KvbT/fintcLQrdncFXnCDSKJtncjOV1n54Rn+fKQlTwgtpXe
         qnVBMtgS/94FAg841oar7LAD2BFNI8C3uFjQajR4PJbPumBAd0h6YO+34aq8FRjYZZmd
         E2POvsHClQhsIwgnXsnENSzL18x6C7ZH9prHqxNLGh8DKh57cFk6MV9ITs63xJfjK/1l
         3XkKzYnUOc8HKuMC3XHu+X4Y4pCa+BXy/elGqdOExBQapbE7qPqU6rXX8QvhR8quvD66
         4WGl55gUHJsDRgGvphQCUfkyOU5jkCEY1FOFGO8OrmEOILNBuC5rSYHMSiy0zmSR91O/
         r2mA==
X-Gm-Message-State: ACgBeo3q7ZhfzDUmxI7V5Iktx8ZqejmocpvpqC9lKRkgc+E99cERQfsj
        jDUxrljkQYSRfwyc7PRyANtBUw==
X-Google-Smtp-Source: AA6agR6oWc/M0ekNF99Kob9d7A0SBRRl/ljeBywJjwfhhHE1nNwdPQYLTS2m9TW6Fz/bTnAm7lNFuQ==
X-Received: by 2002:a05:6512:b96:b0:497:9dac:cc22 with SMTP id b22-20020a0565120b9600b004979daccc22mr3678335lfv.687.1662709699352;
        Fri, 09 Sep 2022 00:48:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s3-20020a2e1503000000b00261aecd1c53sm177646ljd.71.2022.09.09.00.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:48:18 -0700 (PDT)
Message-ID: <6ddc3644-ae8b-38bf-346b-1262063ef20c@linaro.org>
Date:   Fri, 9 Sep 2022 09:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] clk: qcom: gcc-sdm845: add sdm670 global clock
 data
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>
References: <20220908231224.209020-1-mailingradian@gmail.com>
 <20220908231224.209020-4-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908231224.209020-4-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 01:12, Richard Acayan wrote:
> The Snapdragon 670 adds and removes some clocks, adds new frequencies, and
> adds a new GPLL (Global Phase-Locked Loop) in reference to SDM845, while
> also removing some GDSCs. Despite these differences, there are many
> similarities with SDM670. Add data for SDM670 in the driver for SDM845 to
> reuse the most of the clock data.
> 
> Advantages and disadvantages of this approach:
>  + maintenance applies to both sdm670 and sdm845 by default
>  + less duplicate code (clocks) means smaller distro/pre-built kernels
>    with all drivers enabled
>  - clocks for both SoC's must be compiled if the user wants clocks for one
>    specific SoC (both or none)
>  - additional testing needed for sdm845 devices
> 
> Link: https://android.googlesource.com/kernel/msm/+/443bd8d6e2cf54698234c752e6de97b4b8a528bd%5E%21/#F10
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Best regards,
Krzysztof
