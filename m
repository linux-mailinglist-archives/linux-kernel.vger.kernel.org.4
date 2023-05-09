Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B866FD2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjEIWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjEIWc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:32:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D81119AC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:32:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f25d79f6bfso1155192e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683671572; x=1686263572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFW1OU15IbqXpYsuUkMH+3bP+c5PgEdgY9o9m73RVKE=;
        b=u95LiecvKtnHneogqmaoEKvmLRYm/ZKTtCQyxlXlKpbePXWSU9ea+0ME4Ob79D6xsa
         wutNTYraqc42tw46oad0QOE1ZuQswJHSdNc26KVCja8AVCk7CMQwvlxKvgp1NP9YPpDI
         3e4pd1wQ6YhlTUgb2WtFHREXS4hPqLKPENkPF3dS09cFzJgs/+rrdv3MXUS8IARt/Yka
         sr7rgrXNCvt0Migjqex2P85Fn7caFpTf/O1S7JfGQCIg1zmGU2nfUdk4fjn2lWIgruuA
         6grSd2wtPLf0m7jMjy0+mZksklHWNE7QrUA2038PqBWjieJrV8MH55sthFedG2621uAd
         uAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671572; x=1686263572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFW1OU15IbqXpYsuUkMH+3bP+c5PgEdgY9o9m73RVKE=;
        b=XASjxOYIyOzpYIGMVYgLJllWeBVEO+oPPaRnExJ+rDWi5IeNeUpD0tk2sAifuv6ZZW
         hiUsMWkMB6LHeCKBAdNQzhjLzItVYGQlVCZbpK6EXlv/TEfLsoA2ku7+9ZH4IePvI6eb
         2xmdcFaDby/8q2W+/ugqrgJS5MinB8TfQtUdkeq974N8ufHk+R5Lfpwk+IM+NqCe9g73
         ne156rhVKqiOiMegSpeMCm0SwhlN7P/e12Y4YQos4+MyaoBgrMEq44i6wOr8knrokyqb
         wbeBvLy0mb0/oY2I8YTHDrFubazTj08dZAoTfFiChRfLpp2FAIb1bbX3LPwNO/LLFg3W
         rbvw==
X-Gm-Message-State: AC+VfDy7YEJmxqt5YQhyN8cCBC3N4F4hMwIhQKwNmrGwYLxYZa2VRJoV
        mVsXASc8NzvdEg6Z7iLXjP0F4xngN6xP+7xfT0o=
X-Google-Smtp-Source: ACHHUZ54rAhXTNw+ZVnp/3LnUbR9U4Or594W+T53dvrDD5klHLA2NotZcFcbFSCllPcc3x/s49Au0A==
X-Received: by 2002:ac2:4e4e:0:b0:4f2:5393:b7c with SMTP id f14-20020ac24e4e000000b004f253930b7cmr924673lfr.67.1683671572630;
        Tue, 09 May 2023 15:32:52 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id b29-20020ac25e9d000000b004edce1d338csm483754lfq.89.2023.05.09.15.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 15:32:52 -0700 (PDT)
Message-ID: <f9cfa346-42f8-8061-3517-947440c6f860@linaro.org>
Date:   Wed, 10 May 2023 00:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] soc: qcom: ocmem: make iface clock optional
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <3479852.e9J7NaK4W3@z3ntu.xyz>
 <CAA8EJpo_x=q8yBSUV=owYvQqD30YQbhU51iKHUjr-_doLk6HPw@mail.gmail.com>
 <4094905.iIbC2pHGDl@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4094905.iIbC2pHGDl@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.05.2023 23:41, Luca Weiss wrote:
> On Dienstag, 9. Mai 2023 19:08:50 CEST Dmitry Baryshkov wrote:
>> On Tue, 9 May 2023 at 19:47, Luca Weiss <luca@z3ntu.xyz> wrote:
>>> On Montag, 8. Mai 2023 13:34:23 CEST Dmitry Baryshkov wrote:
>>>> On 07/05/2023 12:12, Luca Weiss wrote:
>>>>> Some platforms such as msm8226 do not have an iface clk. Since
>>>>> clk_bulk
>>>>> APIs don't offer to a way to treat some clocks as optional simply add
>>>>> core_clk and iface_clk members to our drvdata.
>>>>
>>>> What about using devm_clk_bulk_get_optional()? I think it would be
>>>> simpler this way.
>>>
>>> Using that function both clocks would be optional which may or may not be
>>> a
>>> bad idea. Not sure how much binding yaml and/or driver should try and
>>> catch
>>> bad usages of the driver.
>>
>> The generic rule is that we should not validate the DT unless required
>> (e.g. because of the possibility of legacy DT which used other
>> bindings or contained less information).
> 
> Got it.
> 
> But since in this driver we use one of the clocks for setting clock rate I'd
> keep using the two separate struct clk as I've done in this patch if you don't
> mind too much.
I'd also advocate for 2x struct clk, using bulk here is like trying to
spread butter with a fork, it works, but has holes..

Konrad
> 
> Regards
> Luca
> 
>>
>>> But honestly the current usage of the bulk API seems a bit clunky, we have
>>> a static array of clocks that we use (not in struct ocmem for some
>>> reason) and then we refer to the core clock by index? Feels better to
>>> just have the two clock references in the device struct and then we're
>>> good.
>>>
>>> Let me know.
>>>
>>> Regards
>>> Luca
>>>
>>>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>>>> ---
>>>>>
>>>>>   drivers/soc/qcom/ocmem.c | 42
>>>>>   ++++++++++++++++++++++++------------------
>>>>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
>>>>> index a11a955a1327..6235065d3bc9 100644
>>>>> --- a/drivers/soc/qcom/ocmem.c
>>>>> +++ b/drivers/soc/qcom/ocmem.c
>>>>> @@ -54,6 +54,8 @@ struct ocmem {
>>>>>
>>>>>     const struct ocmem_config *config;
>>>>>     struct resource *memory;
>>>>>     void __iomem *mmio;
>>>>>
>>>>> +   struct clk *core_clk;
>>>>> +   struct clk *iface_clk;
>>>>>
>>>>>     unsigned int num_ports;
>>>>>     unsigned int num_macros;
>>>>>     bool interleaved;
>>>>>
>>>>> @@ -91,16 +93,6 @@ struct ocmem {
>>>>>
>>>>>   #define OCMEM_PSGSC_CTL_MACRO2_MODE(val)  FIELD_PREP(0x00000700,
>>>
>>> (val))
>>>
>>>>>   #define OCMEM_PSGSC_CTL_MACRO3_MODE(val)  FIELD_PREP(0x00007000,
>>>
>>> (val))
>>>
>>>>> -#define OCMEM_CLK_CORE_IDX                 0
>>>>> -static struct clk_bulk_data ocmem_clks[] = {
>>>>> -   {
>>>>> -           .id = "core",
>>>>> -   },
>>>>> -   {
>>>>> -           .id = "iface",
>>>>> -   },
>>>>> -};
>>>>> -
>>>>>
>>>>>   static inline void ocmem_write(struct ocmem *ocmem, u32 reg, u32
>>>>>   data)
>>>>>   {
>>>>>   
>>>>>     writel(data, ocmem->mmio + reg);
>>>>>
>>>>> @@ -316,9 +308,15 @@ static int ocmem_dev_probe(struct platform_device
>>>>> *pdev)>
>>>>>
>>>>>     ocmem->dev = dev;
>>>>>     ocmem->config = device_get_match_data(dev);
>>>>>
>>>>> -   ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ocmem_clks), ocmem_clks);
>>>>> -   if (ret)
>>>>> -           return dev_err_probe(dev, ret, "Unable to get clocks\n");
>>>>> +   ocmem->core_clk = devm_clk_get(dev, "core");
>>>>> +   if (IS_ERR(ocmem->core_clk))
>>>>> +           return dev_err_probe(dev, PTR_ERR(ocmem->core_clk),
>>>>> +                                "Unable to get core clock\n");
>>>>> +
>>>>> +   ocmem->iface_clk = devm_clk_get_optional(dev, "iface");
>>>>> +   if (IS_ERR(ocmem->iface_clk))
>>>>> +           return dev_err_probe(dev, PTR_ERR(ocmem->iface_clk),
>>>>> +                                "Unable to get iface clock\n");
>>>>>
>>>>>     ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
>>>>>     if (IS_ERR(ocmem->mmio))
>>>>>
>>>>> @@ -333,11 +331,15 @@ static int ocmem_dev_probe(struct
>>>>> platform_device
>>>>> *pdev)>
>>>>>
>>>>>     }
>>>>>     
>>>>>     /* The core clock is synchronous with graphics */
>>>>>
>>>>> -   WARN_ON(clk_set_rate(ocmem_clks[OCMEM_CLK_CORE_IDX].clk, 1000) <
>>>>> 0);
>>>>> +   WARN_ON(clk_set_rate(ocmem->core_clk, 1000) < 0);
>>>>> +
>>>>> +   ret = clk_prepare_enable(ocmem->core_clk);
>>>>> +   if (ret)
>>>>> +           return dev_err_probe(ocmem->dev, ret, "Failed to enable
>>>
>>> core clock\n");
>>>
>>>>> -   ret = clk_bulk_prepare_enable(ARRAY_SIZE(ocmem_clks), ocmem_clks);
>>>>> +   ret = clk_prepare_enable(ocmem->iface_clk);
>>>>>
>>>>>     if (ret)
>>>>>
>>>>> -           return dev_err_probe(ocmem->dev, ret, "Failed to enable
>>>
>>> clocks\n");
>>>
>>>>> +           return dev_err_probe(ocmem->dev, ret, "Failed to enable
>>>
>>> iface
>>>
>>>>> clock\n");
>>>>>
>>>>>     if (qcom_scm_restore_sec_cfg_available()) {
>>>>>     
>>>>>             dev_dbg(dev, "configuring scm\n");
>>>>>
>>>>> @@ -396,13 +398,17 @@ static int ocmem_dev_probe(struct
>>>>> platform_device
>>>>> *pdev)>
>>>>>
>>>>>     return 0;
>>>>>   
>>>>>   err_clk_disable:
>>>>> -   clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
>>>>> +   clk_disable_unprepare(ocmem->core_clk);
>>>>> +   clk_disable_unprepare(ocmem->iface_clk);
>>>>>
>>>>>     return ret;
>>>>>   
>>>>>   }
>>>>>   
>>>>>   static int ocmem_dev_remove(struct platform_device *pdev)
>>>>>   {
>>>>>
>>>>> -   clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
>>>>> +   struct ocmem *ocmem = platform_get_drvdata(pdev);
>>>>> +
>>>>> +   clk_disable_unprepare(ocmem->core_clk);
>>>>> +   clk_disable_unprepare(ocmem->iface_clk);
>>>>>
>>>>>     return 0;
>>>>>   
>>>>>   }
> 
> 
> 
> 
