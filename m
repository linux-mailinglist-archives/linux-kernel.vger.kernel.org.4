Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B06F32C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjEAPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjEAPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:21:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F110C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:21:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so15360285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1682954506; x=1685546506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKiWqYh9XO5qAQM1s+Ma3p+jBCI9gPE5d3tSqh6MCa0=;
        b=1wg14JkhVroeNJwAGykMLmL84VsdXQW2riCt13yjf5fCspUhukwPLkrLeWvZtdx6Y+
         hzIgqfTops1iGoSXM1ALRKuqLRRUDF8Sfcxi/Wd1lPYJGiPyf2pDKBGPbKg3I5/oYPsV
         soWnBr0Eh9Zw/BnzhUsBOJThdpVjOmwraxZJkeiEi52n/EY8zScjjgAaHhLsN7b/jjLL
         HDby8pTefmIN2AXWePyjq6rWKEB5n8W/XOKGsy4XJPG5ruR/L8qg5iI97t+o6TRAga5u
         R5iBRhDsidLv15aQkVC7qdNs1BCDdBhJCjcVDGB98uLleP/UDJa274sJfdnnueTsd/Mj
         FUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682954506; x=1685546506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKiWqYh9XO5qAQM1s+Ma3p+jBCI9gPE5d3tSqh6MCa0=;
        b=Wd51yokDwZESEUIjeNUHK754/rWD3OFypkudVDFB+O8kHTmo2ne92qwgmEweWu6Oxx
         nWofoA5bC09tP65YLK/f6HowIJ9QwOmA1uqYLPOHHCiWfyVnVxfUaAQDIj4K3YnT6Ydr
         BPp+8bAkL+sL4A30nkGixnSD4ZcKVCt1vD0om9jxKUMpPXK3wCLvhjjlsqlEyH5XYLnw
         Tv2fY1GAUTlh+PDlIb4vmfLsJQ6zptZ6nF+L2bdOlTmZc9ZBwgFC/RWIZPai8jLR8QpU
         LROxlyz72chY05w7Jscq4Necy9JliN4kYNg5cLH+PdrbxzDKPliIRrhlmPtDPsZDfCRZ
         nAlw==
X-Gm-Message-State: AC+VfDyDGabIej0MFxg48+ITXbc6hkAS1UCnHta85m1MIifQI/Bjsprp
        cFu3kKXk/izV7Wam5zK3aPSO7w==
X-Google-Smtp-Source: ACHHUZ4exJkxnm7bFLNwMG7ossO2cAt9qLl8HLKC4o6ACSLrL7hVkj+nwqOwptyhBk9cG5GIKSEGpA==
X-Received: by 2002:a7b:cd09:0:b0:3f2:507f:25a4 with SMTP id f9-20020a7bcd09000000b003f2507f25a4mr10024730wmj.30.1682954506144;
        Mon, 01 May 2023 08:21:46 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm32626835wmj.35.2023.05.01.08.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 08:21:45 -0700 (PDT)
Message-ID: <b22d9fe0-b39e-75e4-fb1d-a74d45d667b8@nexus-software.ie>
Date:   Mon, 1 May 2023 16:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] clk: qcom: camcc-sc7180: Add parent dependency to all
 camera GDSCs
Content-Language: en-US
To:     Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_skakitap@quicinc.com,
        quic_cponnapa@quicinc.com
References: <20230501142932.13049-1-quic_tdas@quicinc.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20230501142932.13049-1-quic_tdas@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 15:29, Taniya Das wrote:
> Camera titan top GDSC is a parent supply to all other camera GDSCs. Titan
> top GDSC is required to be enabled before enabling any other camera GDSCs
> and it should be disabled only after all other camera GDSCs are disabled.
> Ensure this behavior by marking titan top GDSC as parent of all other
> camera GDSCs.
> 
> Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>


Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

