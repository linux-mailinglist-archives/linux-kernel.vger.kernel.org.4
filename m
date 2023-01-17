Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9C66D7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjAQIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjAQIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:22:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6F29E05
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:22:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b5so8554200wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cROEQBEpxEpKKdlrs6yVYznmIj77lk7XMPgisTFSYjo=;
        b=b4o4HMMGu7IbfxMJuOl6gYI5JYrYgA4xvgWi/+wFevzAt0rcbLqi5JpAW4gaar8iZc
         BuWC46sIQW6cVElyoW/MvOgbq1X3zBqRDnA+e9xt/ViJeFgMVJ/UXMdgfofCcjx9Q35H
         +jJJ2iDzrk+Umn5PzdC5RutoeelsNEHep+2MCtaLBbRcssZyTf/lvYC7JrHpKM38bu5a
         6nehA54lEgBnFCj1jsrcVIcH4L8tzVNfyji87lWLNRNPVuFzZ1Lm2sg7Z7ZUfRp/PbuV
         ikFPa9TLxUnuh6npMNoIeHgEldf8hgU27vrKVHlqTQzXRpNCg1wnjOXOLqNdlp/ZwZu2
         PzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cROEQBEpxEpKKdlrs6yVYznmIj77lk7XMPgisTFSYjo=;
        b=qu0idNfOJ9L/i0QYm5LfHxEaS3Afzn6vHXlBkFYSJMFqOOlyf8uKCzrVDe6FLUV/A4
         2YASP/3od6Q86oXG1npWprEiS9XWejQfAbKH5iiE2bPIoJs2Wy322NRPoTLNG9ghK/04
         qwhzR/TP7SDyzTGkP9OxHI/R8PWhFQ5V1TU1G9Khuk1r8je5I+oYi3YXc4rQTAXxzFEt
         tLtsPmCkYmHMwrVLMJolp9E32V7whG+coCU1Om9s9jIHOLXcVvdCbVM85FLEFkSh5Pjr
         uRcLjOXiEzyKGYcwJsowm2SrEBAygGcIfyZJ6arAOAI+dqtbqyesMS8gqWbSqyGRPbh0
         sP2g==
X-Gm-Message-State: AFqh2krXxvEzD6eZwmlQY/qT/rWKUvzq+8M0/Rxzq7N008NtxvYtNDDr
        /gvwxU1pCr+yg/oQ/UWnvxTJEA==
X-Google-Smtp-Source: AMrXdXuZrTpa4frMUO9j6FvZ5gEyTk2iwfq1ZM2sfOs9phe5WoovF4LTYOxMGVhRp1qjOD402L/qEg==
X-Received: by 2002:a5d:4574:0:b0:2bd:df33:ecc9 with SMTP id a20-20020a5d4574000000b002bddf33ecc9mr1872308wrc.46.1673943721043;
        Tue, 17 Jan 2023 00:22:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:dff1:a9dd:eccd:492d? ([2a01:e0a:982:cbb0:dff1:a9dd:eccd:492d])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm27948450wrn.111.2023.01.17.00.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:22:00 -0800 (PST)
Message-ID: <ca6ba293-9add-0986-d1b4-c28925cc3677@linaro.org>
Date:   Tue, 17 Jan 2023 09:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sm8550-mtp: enable DSI panel
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Konrad,

On 10/01/2023 20:22, Neil Armstrong wrote:
> Add device tree nodes for MDSS, DPU and DSI devices on Qualcomm SM8550
> platform. Enable these devices and add the DSI panel on the MTP device.

Gentle ping!

Are the patches 1 & 3 ok ?

Thanks,
Neil

> 
> Dependencies:
> - [1] SM8550 base DT (applied)
> - [2] MDSS/DPU/DSI bindings (applied)
> - [3] DISPCC bindings (build dependency, applied)
> - [4] VTDR6130 Panel bindings (applied)
> 
> [1] https://lore.kernel.org/all/20230106201047.337409-1-abel.vesa@linaro.org
> [2] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-mdss-dsi-v3-0-660c3bcb127f@linaro.org
> [3] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-dispcc-v3-0-8a03d348c572@linaro.org
> [4] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> Changes in v2:
> - reshuffled properties in the order konrad shared
> - updated DSI PHY compatible
> - renamed mdss@ to display-subsystem@
> - added back dispcc bindings include
> - added Reviewed-by on patch 2
> - Link to v1: https://lore.kernel.org/r/20230104-topic-sm8550-upstream-dts-display-v1-0-aeab9751928f@linaro.org
> 
> ---
> Neil Armstrong (3):
>        arm64: dts: qcom: sm8550: add display hardware devices
>        arm64: dts: qcom: sm8550-mtp: enable display hardware
>        arm64: dts: qcom: sm8550-mtp: add DSI panel
> 
>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  78 +++++++++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi    | 299 ++++++++++++++++++++++++++++++++
>   2 files changed, 377 insertions(+)
> ---
> base-commit: 813d028f81ae4e84926fbb9a499652539eb8694a
> change-id: 20230104-topic-sm8550-upstream-dts-display-aa22b568ea17
> 
> Best regards,

