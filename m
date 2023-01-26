Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9F67D053
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjAZPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjAZPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:34:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3646813B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:34:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mg12so6059739ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGnF5JEUOP/9Gz3yuVHJBVOWbau8dZyNvnJs2NiL0u4=;
        b=NwuiyYDUtEwQCcuGPxk9KjHLPcMW+cTgBiZjcYxdH4oiTXPzoQRy91ITgCnC9ir6e9
         E+rmVlzFsIAOKew/6XY2u/b7FzNOAJT8DT7D16fLKVztpfN+2LxUYDpnGweM80UTy/Gb
         pzH15Qliv1ND84wou0xqg6Mlr/9GClRCq2SOt+8GtkqgQVbUPWdIbu2T0UUmrLzesBPH
         ZKzlyczwCf35+GeJnlhEMDW6l8BdBjwmcIlmLx3j9anfntZc2b8BW0BaGowVlXxIgE5M
         8887efSQyqQU8dKUdvFdJOW2/8aNC+Jz2fLDVLm9+jmgeWPgFhdqazVgjhsHopBYRynP
         ROWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGnF5JEUOP/9Gz3yuVHJBVOWbau8dZyNvnJs2NiL0u4=;
        b=C3sq/LXrDqPGJThJH7X6nl4Fg8MuIqs+i33GA8yIclchjh7iMXnxcX1HLkx1SilAly
         yJRYlzaT/WU0vRmFRzMejq6jnGauWNrHPr0q+ko7Bzh1/8d7AZ8FKBEJPiEl1ggQvhSB
         PyI9nJQBr1lgt+rT6d1oA+h8nqKuCPTYG313b+mNfeaDJ5XTYN++zBNBA3LVfmhpfTMJ
         gI9wZFaVqXmqUZbsDCUT/5dPFtLN07ZPRdY9KXskYb4H9Oy7lRr4OupQEROSWwuGMptC
         B8uKCpHQOsooeQiEUXZ3nbS2Y3HpMDgSONJDTGIro0ePpJVIzoiATQRUKRH7M4zeWgGI
         TbJg==
X-Gm-Message-State: AO0yUKWkGa2O64Yn4phPBZdwj3qizEHzB8qclywuqERXIEWoVcIBIZ2b
        JWAFs4M+xTTZV4icygM8GZbXlg==
X-Google-Smtp-Source: AK7set+IK5iXu+sQ3ynJ6pEMSmqCZn6CKH9DbV/Ba01kpOWJqVxjsZEWLpCsrKKoWkFYIoI5dWp/Tg==
X-Received: by 2002:a17:906:bc51:b0:878:673f:5492 with SMTP id s17-20020a170906bc5100b00878673f5492mr2180594ejv.40.1674747255668;
        Thu, 26 Jan 2023 07:34:15 -0800 (PST)
Received: from [192.168.1.101] (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id ck7-20020a170906c44700b007c0fd177c0bsm752292ejb.46.2023.01.26.07.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:34:15 -0800 (PST)
Message-ID: <df4c76eb-aec7-823e-28f9-5ba96cc200c6@linaro.org>
Date:   Thu, 26 Jan 2023 16:34:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
 <87192098-b7f4-060f-9274-933d974c0a7d@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <87192098-b7f4-060f-9274-933d974c0a7d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.01.2023 16:29, Bryan O'Donoghue wrote:
> On 23/01/2023 12:49, Stephan Gerhold wrote:
>>> - Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
>>>    Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
>>>    GCC_BYTE1_CFG_RCGR : SRC_SEL
>>>    Root Source Select
>>>    000 : cxo
>>>    001 : dsi0_phy_pll_out_byteclk
>>>    010 : GPLL0_OUT_AUX
>>>    011 : gnd
>>>    100 : gnd
>>>    101 : gnd
>>>    110 : gnd
>>>    111 : reserved - Stephan/Bryan
>>>
>> I'm confused. Are you not contradicting yourself here? You say that
>> dsi0_phy_pll (dsi ZERO) is used to clock GCC_BYTE1_CFG_RCGR. Then why
>> do you add dsi1_phy_pll (dsi ONE) to the gcc clock list?
> 
> So my understanding of the clock tree here is that dsi0_phy_pll_out_byteclk is a legacy name.
> 
> Its perfectly possible to have DSI0 and DSI0_PHY switched off and to have DSI1/DSI1_PHY operable.
> 
> dsi0_phy_pll_out_byteclk is perhaps an unfortunate name and probably should have been renamed.
> 
>> To me this looks like a confirmation of what downstream does, that both
>> DSI byte clocks are actually sourced from the dsi0_phy and the PLL of
> 
> A better name would have been dsiX_phy_pll_out_byteclk.
I believe Stephan is just confused what the clock source of both
pairs of GCC DSI clocks are, as you're suggesting that:

phy_clock0
  |_gcc_clock0

and

phy_clock0 (yes, zero)
  |_gcc_clock1

whereas on most other SoCs the following is true:

phy_clock0
  |_gcc_clock0

phy_clock1
  |_gcc_clock_1

Konrad
> 
> ---
> bod
