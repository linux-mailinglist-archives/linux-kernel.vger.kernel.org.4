Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94343714A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjE2Ndu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2Ndr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:33:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C16990
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:33:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3094910b150so3232592f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685367225; x=1687959225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKjeZ9uWZpFJl50OxFn7ik8Z2szMhNLlLHOEtyPm94s=;
        b=stBNw7AltCQUYoqJgWVFrJOeaDV9maNJtPLlWQnldKrOWZv2Nxbumb7D3z/uiFonON
         wT42P6RVA4hB3o3z/GnS3v6+yfSHYrstAL+IU43EgNIef+u4eMwOf+PFk+voUkK5F5Pv
         CzuDPrPplreoX9mSgYSfOTJnMoqsnsmAW7JqCDaiZF5XpGRRLxzoh5Wdf+ZhXLZVsYcG
         dfpK58Gx5W/Ctf2MZOOyZSdTCum/gVSlCgKpasLQ/KRq0qXkuj59mWqHHy2aM/GCicqp
         tx1wpe2PuKKN10BXimDT0NR5EZumc0pOIgEiWR9d70Y/z2pq2SiUiqUMp1X3tlesJu9f
         cO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367225; x=1687959225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKjeZ9uWZpFJl50OxFn7ik8Z2szMhNLlLHOEtyPm94s=;
        b=ASVTqTDNM7+GcxZFr+w3S29uoljOvhlcMQ94jPpN12ydPQAfMIk/NTUDW0rQ4c9Sdh
         5VWoJTQIRuTUIqK6oIOOZrZ3LASrmZRlun4n1Pp2YGS21EfR28OLD54Lsilmtp3xCm4U
         64m44gRouFW0N0rcm9YsThJvByK0at5+wmEe1zl3kqvy53P3TLxlUTkUt+x0rQTnRXgD
         U05nLXnCs2MjBLUfVgLnbXNvHrww20Jqfn7Hxera+eQd2v0xjrW5hwvZKdPgj0r1OL61
         QuwyYUipK9SMd3yjP+tlpXm7OjlLLyiIBerkLUV/oUEfVdZ+XYnlS4ICDLLyPkB7Ft48
         NYEw==
X-Gm-Message-State: AC+VfDzEw9RlVRZceWocrHdUv4UzJl0uOodwjcUShgt87aJyeRUKU9se
        Z1+T86KHleUpGhar1f7DFQYS87ICT2Bee0SHdBbU4Q==
X-Google-Smtp-Source: ACHHUZ4jqVCnat5uWmipdZ8OcpOUBP/lfEJ8AQfd+QaySpUcZRhO+AFd0EEAmybM21Rr+4h+wkdiIQ==
X-Received: by 2002:adf:d086:0:b0:30a:e7b6:52d6 with SMTP id y6-20020adfd086000000b0030ae7b652d6mr4314364wrh.52.1685367224935;
        Mon, 29 May 2023 06:33:44 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y4-20020adfd084000000b0030abe7c36b1sm13780385wrh.93.2023.05.29.06.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:33:44 -0700 (PDT)
Message-ID: <6f1954e6-e98d-6911-8721-c50082bfb1d7@linaro.org>
Date:   Mon, 29 May 2023 14:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: msm8916/39: Clean up MDSS labels
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-4-bec0f5fb46fb@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230525-msm8916-labels-v1-4-bec0f5fb46fb@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 13:47, Stephan Gerhold wrote:
> Right now MDSS related definitions cannot be properly grouped together
> in board DTs because the labels do not use consistent prefixes. The DSI
> PHY label is particularly weird because the DSI number is at the end
> (&dsi_phy0) while DSI itself is called &dsi0.
> 
> Follow the example of more recent SoCs and give all the MDSS related
> nodes a consistent label that allows proper grouping.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---

You should probably churn the yaml that goes with this..

---
bod

