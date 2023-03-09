Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC56B30D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCIWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCIWhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:37:23 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46957104617
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:37:22 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id k14so4256013lfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678401440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFWvVfxVAn0JYy2RvVNotdBgoXVzu6+UA0ROvn+lkig=;
        b=gPKCt6kGrGzWI6Z5cmQ5vHx43shhCsJljJrTbLgeXdksKonaADCLSAKdrC4gArTmQx
         IA6JqX5Y9IIJOtFcV9Th5ilQfOR6I7QPGxvbO43xgKVVrte/3fvf5gP4QaXLz9QJlt0g
         9Yk0q6DzxvPFAjlIWnujD4SLdF4FGEKThIdvn9/zaQVv4Ceb0PTXwZt73TVCIxfPjFwg
         2cVz99dHc93rjymJr9jCtdOGLeZKIeMqGqLa4pTZK73SyuztsFW9Uua3KCihyF2/70Sg
         qE6ALe6EPjavtaUOYPzbYgy9aqXw1+Ec1Mwb+xf+MhmxrxNCxch7HW6WnAyw+G8s7j3d
         hkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFWvVfxVAn0JYy2RvVNotdBgoXVzu6+UA0ROvn+lkig=;
        b=2V3uw9xcqymNvCYUPqKnaC8y2NnSY5xLkU8pEZe1sSUNB1Vw9o6759zufAdiVN5vbF
         0soA3XUGJ/T46fh5TiSeYW6EVKi9AygQIROUkIjBjmb7arxwj3okcUnFYgm3QIRZ8Zv1
         833caBEE35YP3fXYJL7HI2fH+MeogzYPp+86AA3jC2nJdDEgt3Dqoa2g2qHThCrXsusX
         IrMF04ytv/MFZDpvQ93QpWawKk1P6r7kslxVniTyx6XJo5bceKIjILdOfj6r+DDsJHBZ
         XsNi3cHyw9M5Eqiiw3HD8yHS0ut/WFOSwPnVufbzC2kpVSXTxkyMJsaH7MwSOyKRY5CF
         vuZw==
X-Gm-Message-State: AO0yUKXiFtFCOdn7ND4GV9R5TQCV+IJCbidAhq2trPqkyHlrpPowvPvz
        qwFPLomLjyw24y4BK57s4w0IJw==
X-Google-Smtp-Source: AK7set9NFAA7v78zu5aKYNTQcuPQtA5qn6A3AwSO27Qt8087MIkK12e2UayAT0g7EVrmj6Jhuti/2w==
X-Received: by 2002:ac2:4c09:0:b0:4b4:6490:cbf1 with SMTP id t9-20020ac24c09000000b004b46490cbf1mr7060611lfq.15.1678401440025;
        Thu, 09 Mar 2023 14:37:20 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a8-20020a2e9808000000b002934a7c04efsm42146ljj.98.2023.03.09.14.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 14:37:19 -0800 (PST)
Message-ID: <aac6ba9c-4230-aff7-c93d-23eaf6895464@linaro.org>
Date:   Thu, 9 Mar 2023 23:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Novatek NT36523
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230308043706.16318-1-lujianhua000@gmail.com>
 <20230308043706.16318-2-lujianhua000@gmail.com>
 <66d293a8-f850-cb80-0c83-2ebf7e29d0c2@linaro.org> <ZAh3MSpQ30YyPAVe@Gentoo>
 <1cbe9e29-13a4-574e-6d8c-b2506e7a36b3@linaro.org> <ZAiPTat/kmLyaJmA@Gentoo>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZAiPTat/kmLyaJmA@Gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]
= of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
>>>>> +		if (!dsi1) {
>>>>> +			dev_err(dev, "cannot get secondary DSI node.\n");
>>>>> +			return -ENODEV;
>>>>> +		}
>>>>> +
>>>>> +		dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
>>>>> +		of_node_put(dsi1);
>>>> Shouldn't you put the reference only if it's found?
>>> thanks for spot it.
Apparently not.. please don't change this

Konrad
>>>>
>>>>> +		if (!dsi1_host) {
>>>>> +			dev_err(dev, "cannot get secondary DSI host\n");
>>>>> +			return -EPROBE_DEFER;
>>>> dev_err_probe, here and in neighbouring exit return paths?
>>> Acked.
>>>>
>>>>
>>>> Konrad
