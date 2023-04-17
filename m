Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0748F6E4B38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjDQORB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDQOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:16:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B77859D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:16:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so4034524a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681740990; x=1684332990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVQRzgONTjXgcIxkUzSecJIpFbUF/z8zPatZhBjABrY=;
        b=JR2AESFF0BC+QkXNEMd1fyoFzNxcA7STjpz5F0nsNpOnZo5UEei7/goAt80LRQfUYY
         1g4Hf4HFnC1gAKhYF5InoeQuYnsmsq7RSGaVS/7NaMAgGQLTSB/ROSSrbqGahMtVIgtL
         sOyapjl4n9Ob0mB1pL91p2BcKrUXfod4S5kC5MrnNEhr3W1j+vvr6xat0h60lRHxA3O7
         qiMKeFzqIl6f6B499g/4MK3g+sHkzMRybDdVgOsTnoSQZDtfDhOB2PVrqTmXC5nkNEf2
         m36JoYyw7xsdwNyYqiaUayZp839SUz3Vj7vWpBkBRvjHP6xlEbYWacpfWVeW5YXbSxI2
         0n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740990; x=1684332990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVQRzgONTjXgcIxkUzSecJIpFbUF/z8zPatZhBjABrY=;
        b=ZOG7sFLGjOXMyy1MUz6ttjqRiAs+v0Q2doEL/YT4r1refgfwGRCzCm3EHdMcdPNWri
         Dz0Y0HwI4pIGwXFZfpyoyPkXeF1WeOClixNkQC9iw2jgdN0aoYZhPTsve1r8Ivl/ZLBs
         fzk9F8QSCIgFTZCSmGg5vo/6yB63n65IdkohFVPi/chX5wfy6BNAgGDFmqP5EGL/NMzf
         XdS+C/sZAW1f4BI47KEbdHwxn0EJExhhlaYutLjAMpHbzvw9UNpzNHOJwJEwh0R1PVUK
         P300AFczywZncc+A92JjE3WSZUEjUUBSUiqAr/Ta2ADDzFBcwch5OMED3KVp3pFQT1l9
         scaA==
X-Gm-Message-State: AAQBX9ddr66I/NqgRCozpVrlPUrZ2RtOenyuBvSjqXBj5Dwn6a7++HUY
        GqNvZFCuXhGEmmrQZgSR7YKpjg==
X-Google-Smtp-Source: AKy350aZvD7dqPSR14EhguXP0BaRVtu68WfxF+4FDPU3OJWaId59qnrxRKHVkTGD2yDgSTgenaausA==
X-Received: by 2002:a50:ef10:0:b0:506:b88a:cab4 with SMTP id m16-20020a50ef10000000b00506b88acab4mr209225eds.3.1681740990555;
        Mon, 17 Apr 2023 07:16:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7c906000000b0050687dbb5dasm4025762edt.31.2023.04.17.07.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:16:30 -0700 (PDT)
Message-ID: <dccd1951-9fbe-272b-541d-72446ea892e6@linaro.org>
Date:   Mon, 17 Apr 2023 16:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 6/7] soundwire: qcom: add support for v2.0.0 controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-7-krzysztof.kozlowski@linaro.org>
 <f2f1871c-38f1-52b0-d90d-d1f263048606@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f2f1871c-38f1-52b0-d90d-d1f263048606@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 13:27, Srinivas Kandagatla wrote:
RM_INTERRUPT_STATUS_RMSK);
>>   
>>   	/* Configure No pings */
>>   	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
>>   	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>>   	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>>   
>> -	if (ctrl->version >= SWRM_VERSION_1_7_0) {
>> +	if (ctrl->version == SWRM_VERSION_1_7_0) {
>>   		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>>   		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>>   				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
>> +	} else if (ctrl->version >= SWRM_VERSION_2_0_0) {
> 
> we can move this to a proper switch case rather than if else's

OK

Best regards,
Krzysztof

