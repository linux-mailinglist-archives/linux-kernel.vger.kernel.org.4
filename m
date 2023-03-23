Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37D6C6B27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjCWOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCWOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:36:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4F269F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:36:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso1340251wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679582179;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rEhytZxehTs3+RJ5GfT9s2lxvfEx0RYE515lvUYjdJ0=;
        b=V5SDWIsRwgNllTO/1dZ8+2BeK8fbUIMrxlRp8YqiPNgzroz2Wbf42M22zyEjpuE2bY
         qgqp/Io2hGg1kuOh6iNwhebtRd73evLzKIpwIV2tQVpC7RdEvmN59f6Ne5BM1a9AisYl
         neiJw5JYJv3H2VxgaKHAVI6d/r+7tUHQh5i6jEiKm/quY1AMvH2/bNAG2s/oDxIQx74N
         0R1yDBwYe8r+SVMvEtW21TLR03uQlcqzpGXVVQqbW4lde1BiTLehpjaH2zD+wVrDvolC
         GfZ9Hf4iWQl5qSQc8JudkWgWuRZBt0PUJB0ngMPpmcuynMFqDC7PXWD8ICpDVXxTyaQZ
         QrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582179;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEhytZxehTs3+RJ5GfT9s2lxvfEx0RYE515lvUYjdJ0=;
        b=h6yUyk42r6L8LN9UvOjL2S+tnnbsSzvWTBYp1C4l/wl6yMivDKt4sSZHCmzsQLkA5r
         g0Z59Cbtsc8qedgIpiSQREUgwN+3/nXrEeUR9lYMITuRK+ATWMT3/xxhwkLjDpNRtgUv
         do3HfKkDC6VvAtSyVYAj7z/TOy4ltnmuFoeLD1zOvlP25G02ZaQUw6OQZWxpSGWZl2a8
         +4bh88123QwzrSbFeCeW79ag1Rf2vFjFPvqCqabhDvaE6TyjU9euHVcXptK+g0SQ6zdz
         6wvaiNjLv8HtGwVH0xrsnupLPKP0a24l0ErpFKcypj/1k/QP8SFCTOI4ug9r/rnQLCQ/
         vQEg==
X-Gm-Message-State: AO0yUKVy8K1XJnch0Aya3iazpErdkCjZPdhjTOTDNRJiTdfiou9OGL5e
        fG0/onPayYUuM9HOTmcr7Nhtaw==
X-Google-Smtp-Source: AK7set+24+OLG2+h3jPdMAyZlS0SXJwCzS2t+JZk67f0y0qT5SVukxMnGLO7PUFJy2j1bri6RObmeg==
X-Received: by 2002:a05:600c:365a:b0:3ee:5754:f139 with SMTP id y26-20020a05600c365a00b003ee5754f139mr2585793wmq.13.1679582179009;
        Thu, 23 Mar 2023 07:36:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e25a:65de:379a:3899? ([2a01:e0a:982:cbb0:e25a:65de:379a:3899])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b003edd2ec9f85sm2247944wms.6.2023.03.23.07.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:36:18 -0700 (PDT)
Message-ID: <5ab0601c-5acd-ef49-419b-36f5a7679758@linaro.org>
Date:   Thu, 23 Mar 2023 15:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 5/5] arm64: dts: qcom: sm8450: add dp controller
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v6-5-d78313cbc41d@linaro.org>
 <b1e6ca00-348b-4d61-6e90-30bef756732c@linaro.org>
 <20230323143814.cdfbgzlnlbnocx5z@ripper>
Organization: Linaro Developer Services
In-Reply-To: <20230323143814.cdfbgzlnlbnocx5z@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/03/2023 15:38, Bjorn Andersson wrote:
> On Tue, Mar 21, 2023 at 09:51:34PM +0100, Konrad Dybcio wrote:
>> On 17.03.2023 16:06, Neil Armstrong wrote:
>>> @@ -2783,6 +2790,78 @@ opp-500000000 {
>>>   				};
>>>   			};
>>>   
>>> +			mdss_dp0: displayport-controller@ae90000 {
>>> +				compatible = "qcom,sm8450-dp", "qcom,sm8350-dp";
>>> +				reg = <0 0xae90000 0 0x200>,
>>> +				      <0 0xae90200 0 0x200>,
>>> +				      <0 0xae90400 0 0xc00>,
>>> +				      <0 0xae91000 0 0x400>,
>>> +				      <0 0xae91400 0 0x400>;
>>> +				interrupt-parent = <&mdss>;
>>> +				interrupts = <12>;
>>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
>>> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
>>> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
>>> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
>>> +				clock-names = "core_iface",
>>> +					      "core_aux",
>>> +					      "ctrl_link",
>>> +			                      "ctrl_link_iface",
>> I applied this locally and noticed line has 2x 8 spaces.. Bjorn, could
>> you please take care of that when applying?
>>
> 
> Thanks for pointing it out. I did correct it, and I had to do the same
> in sm8350.dtsi.
> 
> @Neil, please run checkpatch --strict, it will highlight these errors.

Thx, sorry... usually I don't miss such errors, won't happen again.

Neil

> 
> Thanks,
> Bjorn

