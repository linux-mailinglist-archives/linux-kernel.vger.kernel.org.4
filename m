Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87066629D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAIPYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjAIPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:23:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7FF1D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:23:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so8536198wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mwDtK5SOlKp9s6llajUedXIC1HMAZ5M22CTtekH3LV8=;
        b=S6ySBI7uqigQXENnTykYBBbp14SKe41Pt2NWwDA1dxeXXL2HK40XJbP1xs2Ik0w3Cp
         a0KdEICHraIPQUO/98sNK3gWydNFLPlGJqDuhNWk+JBS5GD3la9ERT0jAp/ecgXXQOQ6
         gijfZqFWEJ0wCcNygOL//+hNYl49FywqUK0DFHdeP0wy4WS8pt+VQhpftkaWg1yi1TGL
         4TDZrUMk4gHiN1Rn3Oc9R9JeJhcax7llDqj0la+kcFJFt/bTur4WKKeo8lkPIc2/Vn18
         TMeN54nHffkkBJlb726WhnqINHNoAoyNvM2+c0Q+68Jo6htDrYM+Zaj3YOUmL068HsJR
         AMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwDtK5SOlKp9s6llajUedXIC1HMAZ5M22CTtekH3LV8=;
        b=qi8UGKpYGXPprLvGRi5jcI5c8FNKRvsnsIlOCHUKxSAtdFY0U8samSh1LB61/JSH63
         tedhuXWL662JljCcIeoBqgvMxrL/PWL1LXoFBu9nL/JvscCf/feBEBMLQ1rSHQYU5o89
         WbiDWMrWS9glfd4CScXp9dxOKfBkGnw1XaNvxfJZstV9IBx+SIvrhtqeSq/E6/zBCR6a
         mgDy9acmiJLpZDWIOWUS9802qlogIN4mVLeLGGZH0kxHxFl98sMPYF4EmeRUH0R6faXc
         oktbBF/kAfVpsgAIYGYvPgPOqtQZkaP6OSNCmG+dHQABvVXKAOjohcuTpI+KKD6XqZWv
         45aw==
X-Gm-Message-State: AFqh2krAlO3OXaWwuFQTMxX8E/oQ+BsNBRqr3s5qZ5P/o7XMIlcqE5zy
        jtLPLsZIxpn30x7hSQGopJuDMErVpfMfEqPp
X-Google-Smtp-Source: AMrXdXt+xgkeF/UUCTq0onixJ8Cw93/KniYtVUfF/Twv6688WJirU19TWN8EERjKQcTBYsklqsP3Tg==
X-Received: by 2002:adf:cf11:0:b0:24d:5866:fadf with SMTP id o17-20020adfcf11000000b0024d5866fadfmr51172294wrj.3.1673277832796;
        Mon, 09 Jan 2023 07:23:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a010:fe57:993c:4842? ([2a01:e0a:982:cbb0:a010:fe57:993c:4842])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm5844384wrv.113.2023.01.09.07.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 07:23:52 -0800 (PST)
Message-ID: <0ef85cba-fa9b-6d72-ca44-48c4d6cf2752@linaro.org>
Date:   Mon, 9 Jan 2023 16:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RESEND2,v4,2/2] drm/meson: dw-hdmi: Use
 devm_regulator_*get_enable*()
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
References: <df0096b5aea2a18d1540cde379c5abf589ccd7c4.1669799805.git.mazziesaccount@gmail.com>
 <CGME20230109134646eucas1p17c7fbd379b0301b8429278ff289f2e83@eucas1p1.samsung.com>
 <6c865dd8-b6c3-4491-48ca-df3e3fa45a2d@samsung.com>
Organization: Linaro Developer Services
In-Reply-To: <6c865dd8-b6c3-4491-48ca-df3e3fa45a2d@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 14:46, Marek Szyprowski wrote:
> Hi Matti,
> 
> On 30.11.2022 10:23, Matti Vaittinen wrote:
>> Simplify using the devm_regulator_get_enable_optional(). Also drop the
>> now unused struct member 'hdmi_supply'.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>> v4 resend 2:
>> Respinning unchanged code with the commit title changed as wa suggested
>> by Robert Foss and commit message changed as was suggested by Martin.
>>
>> I am doing a clean-up for my local git and encountered this one.
>> Respinning as it seems this one fell through the cracks.
>> ---
>>    drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
>>    1 file changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> index 5cd2b2ebbbd3..7642f740272b 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> @@ -140,7 +140,6 @@ struct meson_dw_hdmi {
>>    	struct reset_control *hdmitx_apb;
>>    	struct reset_control *hdmitx_ctrl;
>>    	struct reset_control *hdmitx_phy;
>> -	struct regulator *hdmi_supply;
>>    	u32 irq_stat;
>>    	struct dw_hdmi *hdmi;
>>    	struct drm_bridge *bridge;
>> @@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>>    
>>    }
>>    
>> -static void meson_disable_regulator(void *data)
>> -{
>> -	regulator_disable(data);
>> -}
>> -
>>    static void meson_disable_clk(void *data)
>>    {
>>    	clk_disable_unprepare(data);
>> @@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>>    	meson_dw_hdmi->data = match;
>>    	dw_plat_data = &meson_dw_hdmi->dw_plat_data;
>>    
>> -	meson_dw_hdmi->hdmi_supply = devm_regulator_get_optional(dev, "hdmi");
>> -	if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
>> -		if (PTR_ERR(meson_dw_hdmi->hdmi_supply) == -EPROBE_DEFER)
>> -			return -EPROBE_DEFER;
>> -		meson_dw_hdmi->hdmi_supply = NULL;
>> -	} else {
>> -		ret = regulator_enable(meson_dw_hdmi->hdmi_supply);
>> -		if (ret)
>> -			return ret;
>> -		ret = devm_add_action_or_reset(dev, meson_disable_regulator,
>> -					       meson_dw_hdmi->hdmi_supply);
>> -		if (ret)
>> -			return ret;
>> -	}
>> +	ret = devm_regulator_get_enable_optional(dev, "hdmi");
>> +	if (ret != -ENODEV)
> 
> The above line should be "if (ret < 0)", otherwise it breaks hdmi support.
> 
> I've noticed this once this change has been merged to linux-next and all
> my Amlogic Meson based boards failed to initialize HDMI. Is it possible
> to fix this in drm tree or do I need to send the incremental fixup?

Nop, please send an incremental fix and I'll apply it asap.

Thanks,
Neil


> 
>> +		return ret;
>>    
>>    	meson_dw_hdmi->hdmitx_apb = devm_reset_control_get_exclusive(dev,
>>    						"hdmitx_apb");
> 
> Best regards

