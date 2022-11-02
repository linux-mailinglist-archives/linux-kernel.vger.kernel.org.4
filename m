Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E1616DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKBT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBT0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:26:03 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E32BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:26:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e15so13167296qvo.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZ0c9n3S/7R/juAKL/MuQmyZ52QEpr04qFxA/MunVX4=;
        b=MY+dEW0wPbHYY6f/JC/JnMp+6uroYZomjMRscKoUq6BxwMFbFjj+DOp2TcG48TQidw
         ++iqOOnhC5OtFyrEjofDZKkOqYkoP8GaxYNkpxR48rDubtqxit4hIpQsEy3pjeFVVBqx
         DoGJgbrM0Y3zd9UoHaLDbeCzblFurOhmg0UXnUiYYjRCp/6alURNVgqkxPG/wmIu00Dh
         mdbyaTI05vnqPLZuyw3IiBslvc2GcBUjLsIq0oIa/f8A3TcrOhhi3mzl5Gg6rdqlX1KG
         aTKuu+l0MZ3yvNtvgN0RQKvPpndgwPRyNv3/MQMN4BbEE0OjX72E5QRvXygjJ0OFNkM/
         edMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ0c9n3S/7R/juAKL/MuQmyZ52QEpr04qFxA/MunVX4=;
        b=fjTYLWXg7l7zLF35aHm36F4NJGjzNETwqhLqxQCUKeJmmSeElxFeGg8IkldOusTg23
         SwTF3g2ysm39LA+n3D8HS2GUKKSJm6k6v+8uJex6dr3PHwwGYws0SgR7J+tqZs1iPHeI
         iD1K+53HAnhEg79ZleCT1G9c8Sf5cexmdkPCmxPv5fXcrlnbYobpiuY/WGb/mfTe74Pk
         XeooE+fy8LWP5RIqVKDYgCUL1jxXqzty7pUrzrbG4rKLdwW6L6dJZjuCqN5x846jx47j
         uycz3Y95F4RD+QlmA1Bg/1MK4PtDLeVL0qGm4BblCL13UhxRCDE27KfaqQadKfephQxe
         VylQ==
X-Gm-Message-State: ACrzQf32mTyv0JL96BBUgPGSW4/laHDVHCd7QhOt/wDWSWK1tLaGs3ek
        FTBg4mQJ97uk11KazEQlKjgzuQ==
X-Google-Smtp-Source: AMsMyM5vSN7AXGv7p2SjYikwAFRsnviWIYWPLTa+O5bLfxdrMR2RwAa4LE6i3kp35nDNdEbhEELSiQ==
X-Received: by 2002:a05:6214:d6e:b0:4b9:692d:c486 with SMTP id 14-20020a0562140d6e00b004b9692dc486mr23080087qvs.104.1667417161687;
        Wed, 02 Nov 2022 12:26:01 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a03d100b006eee3a09ff3sm8872607qkm.69.2022.11.02.12.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:26:00 -0700 (PDT)
Message-ID: <e1233b16-4289-f193-2084-40ea0e587ef8@linaro.org>
Date:   Wed, 2 Nov 2022 15:25:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: qcom,gcc-ipq8074: Use common
 GCC schema
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Taniya Das <tdas@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20221102163153.55460-1-krzysztof.kozlowski@linaro.org>
 <20221102191441.5EE6EC433D6@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102191441.5EE6EC433D6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 15:14, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-11-02 09:31:52)
>> Reference common Qualcomm GCC schema to remove common pieces.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> I figure Bjorn will apply them with other qcom clk patches.

Bjorn,

I think you need to update your scripts:
https://patchwork.ozlabs.org/project/devicetree-bindings/list/?series=325924

Best regards,
Krzysztof

