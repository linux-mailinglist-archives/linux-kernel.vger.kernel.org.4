Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC29715A35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjE3JbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjE3JbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:31:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEAEF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:29:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af29b37bd7so44718161fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685438993; x=1688030993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FDuYrgA2PtZhvkKUmkAEjPi6ir414k8/3mt89BWyiw=;
        b=x06FtjeWv+gNlvPJF9/0GVmIyBvjBmyC/YQtxyXBxngdzlXpbHWMTGDxkkC8PQaRxz
         1x+clY8tlQ0rMz3KHsSRBR239hakwjeVv7hzKxYBA5xkasPLhencN7Rb4bQjC6QNtYSx
         aVcq7WXp8e7s4jl13HZrd/JoVmYpgt/dG5xrCAdCHLZB0Fu533+RLvYxFUzniC7ATXBM
         Xwn4kXnU6lKPV8mfoUjJSwz981VpxUVw6vUlo9VQrODKHkAacmGJlv1AzUqGnPHmZv1A
         b+cB3hZ8mkub2LWflET7w6zGPUGS8zeMEb99gY1Qj7iesrCyzabXiB5m1iSnOlRcSpMk
         H7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685438993; x=1688030993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FDuYrgA2PtZhvkKUmkAEjPi6ir414k8/3mt89BWyiw=;
        b=SaDrJp9H7VDr3ClV/XiTbOwy64+//RK9OFExU88fTi4wJM+N2i3nwZ7H/3ZxKrsxdV
         1tC1ZPpVkOA6QGM9pPGCwO+LpEKpBE/8+XBc/y8wrrp1jAaRvzz1/NU3HfF0KmB00Rsq
         LNFwIqYCtLUUbnKDSPVKZSBl3dJv6x5vjP9OaUQXhkZhYsgfhMEEOpdzzsB1BtDpupPN
         o0L+mGe2wclal26pN1efty/8OLq6cYyhpTD/YlrsDY4N+0t3ZK6aenCAP0McLzbEph1V
         i1To8jLF/Q/THZm3Ze32Wx7qONjgLmxjQK0UckUmdfbXMrUgKCDvn/MJtmNUYWSnQoU6
         aCdA==
X-Gm-Message-State: AC+VfDwseOcj8Mj0ir92/El/fUsHlxypocvXPOC+Jvxn65mXHeLupSSz
        YYZ4GfP3DBM2SEjIcoq7sAqTUINwW8ivAq19JSo=
X-Google-Smtp-Source: ACHHUZ7Sl60OmxrIrASOSmvDJ8xnwip2lAGckE0thy0BWsF8hbdqJvsbE55ayVqgf0SrvMUbKi8X2Q==
X-Received: by 2002:a2e:9c83:0:b0:2a8:eae2:d55c with SMTP id x3-20020a2e9c83000000b002a8eae2d55cmr496806lji.15.1685438993387;
        Tue, 30 May 2023 02:29:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q10-20020a2e968a000000b002ab2184a9basm2731045lji.109.2023.05.30.02.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 02:29:53 -0700 (PDT)
Message-ID: <29888a4c-b745-3975-f330-d3a4033cd2a4@linaro.org>
Date:   Tue, 30 May 2023 11:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony Xperia
 XZ3
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
 <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
 <brmrqeajbq3oyp3jjwmc6tuhiftz764u6az444xw6g7pwf5fr3@5tlp375qwhed>
 <617c8f8a-1fc7-c6a0-eaa5-ce75ff2adc1b@linaro.org>
 <63qt5jmdi5qg7tvhbb7vk75kz53wmygc7iubwprfhcc3hvgwuv@ildrzq32ese3>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <63qt5jmdi5qg7tvhbb7vk75kz53wmygc7iubwprfhcc3hvgwuv@ildrzq32ese3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 10:41, Marijn Suijten wrote:
> On 2023-05-30 09:24:24, Neil Armstrong wrote:
>> Hi Marijn, Dmitry, Caleb, Jessica,
>>
>> On 29/05/2023 23:11, Marijn Suijten wrote:
>>> On 2023-05-22 04:16:20, Dmitry Baryshkov wrote:
>>> <snip>
>>>>> +	if (ctx->dsi->dsc) {
>>>>
>>>> dsi->dsc is always set, thus this condition can be dropped.
>>>
>>> I want to leave room for possibly running the panel without DSC (at a
>>> lower resolution/refresh rate, or at higher power consumption if there
>>> is enough BW) by not assigning the pointer, if we get access to panel
>>> documentation: probably one of the magic commands sent in this driver
>>> controls it but we don't know which.
>>
>> I'd like to investigate if DSC should perhaps only be enabled if we
>> run non certain platforms/socs ?
>>
>> I mean, we don't know if the controller supports DSC and those particular
>> DSC parameters so we should probably start adding something like :
>>
>> static drm_dsc_config dsc_params_qcom = {}
>>
>> static const struct of_device_id panel_of_dsc_params[] = {
>> 	{ .compatible = "qcom,sm8150", , .data = &dsc_params_qcom },
>> 	{ .compatible = "qcom,sm8250", , .data = &dsc_params_qcom },
>> 	{ .compatible = "qcom,sm8350", , .data = &dsc_params_qcom },
>> 	{ .compatible = "qcom,sm8450", , .data = &dsc_params_qcom },
>> };
> 
> I'd absolutely hate hardcoding a list of compatible SoC names in a panel
> driver.  For one these lists will fall out of date really soon even if
> we store this list in a generic place: even the current DPU catalog and
> new entries floating on the lists weren't faithfully representing DSC
> capabilities (but that's all being / been fixed now).
Yes, a driver should behave predictably, regardless of the platform.

> 
> What's more, most of these panel drivers are "hardcoded" for a specific
> (smartphone) device (and SoC...) since we don't (usually) have the
> DrIC/panel name nor documentation to make the commands generic enough.
> I don't think we should be specific on that end, while being generic on
> the DSC side.
> 
> That does mean I'll remove the if (dsc) here, as Dmitry noted most of
> this driver expects/requires it is enabled.
I'd say we could assume it's mandatory as of today.

Konrad
> 
>> ...
>> static int sony_akatsuki_lgd_probe(struct mipi_dsi_device *dsi)
>> ...
>> 	const struct of_device_id *match;
>>
>> ...
>> 	match = of_match_node(panel_of_dsc_params, of_root);
>> 	if (match && match->data) {
>> 		dsi->dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), GFP_KERNEL);
>> 		memcpy(dsi->dsc, match->data, sizeof(*dsc));
>> 	} else {
>> 		dev_warn(&dsi->dev, "DSI controller is not marked as supporting DSC\n");
>> 	}
>> ...
>> }
>>
>> and probably bail out if it's a DSC only panel.
>>
>> We could alternatively match on the DSI controller's dsi->host->dev instead of the SoC root compatible.
> 
> I'd much rather have the DSI host/controller state whether it is capable
> of DSC (likely allowing us to expose different modes for panels that
> support toggling DSC), but for starters also validate (in DPU?) that the
> pointer is NULL when the hardware does not support it (but maybe that
> already happens implicitly somewhere in e.g.
> dpu_encoder_virt_atomic_mode_set when finding the DSC blocks).
> 
> - Marijn
