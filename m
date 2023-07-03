Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82D2745B50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGCLiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGCLiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:38:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09816118
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:38:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so5653673a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688384287; x=1690976287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5HPd4zFbQ0E8syfNvWoZd2Jd08kmy2oDhqKMHkzCzU=;
        b=WTSAIu0maOXQvTMLW5soPiv4CB8m8rJXos+Ot/4WhoAT3QcoySeaG03E3s4qyOsLAE
         Fti+Zr+2ygJOfVCoGWf6TlPthhRoXpzr9z1/jgRcGtrGllnYf7UxA8w8Bs17b0pQZEW5
         tvmISmZINVUix2PAApU6Osun8dVCilkx/R5h/GnAeZs1US2IfXem9jb1iEC+UzK7RTkg
         Fa4TqSjhPZVbAQlznOuPTyNAlqvYzttRsp/lsMgeItRybVTA4RvQ34EpHtHgAxPlSVJh
         nFb/hPJCev99wQuTGYl4XRx/TOKxJ9WppJPRuUH+ChxHLvd0uAGickcRDP7CWstI7fPj
         4NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688384287; x=1690976287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5HPd4zFbQ0E8syfNvWoZd2Jd08kmy2oDhqKMHkzCzU=;
        b=foqpm3TFyFJijdqPt1Bsgwhy/QgimHqMMibvDetJ00T7xikTF49K8WFo0m2qD4rNnv
         aGdDgajmHXpIeD8+JMtZUk2wcFGzcMsmWCSNB/xvqfDYU4igvbYg6Xsx76XLhUbmeXWD
         5eONUueAyBzwHDk5cVd0eqB7j9ToyvaV1oxE2WZJ8OFhmJMwYzAsWyH30RiFexwJ6RWM
         mwPdqd8gV7DkgHO23eF2sn0LdXXPIhdYczStjeEk+L4Pg/BFkS6y18OXTSCwxaI03ClR
         NBiuTLp7Rtz/OUcUAaZGt6D8DQvtGuh61F9fB1S/smIPgdPD2Kr2LeFQpdF/olO1FWEf
         5Ksg==
X-Gm-Message-State: ABy/qLZxCO/caoWl9zNurHpX2/rhKjTFYreSo46h151n2Rob5vMxfrZu
        qUk4KDxl57UdiAeofwaMqA2xJg==
X-Google-Smtp-Source: APBJJlFffSttED6PPzA0GMbvALnbcSFZlcl8peWg26b+PFdzfiWaPZ5DZ6BTAp/RMGL8Hcmd6Pnyng==
X-Received: by 2002:a50:ff0d:0:b0:51b:df1d:ebc3 with SMTP id a13-20020a50ff0d000000b0051bdf1debc3mr6968185edu.25.1688384287387;
        Mon, 03 Jul 2023 04:38:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n22-20020a056402515600b0051e0f100c48sm1412583edd.22.2023.07.03.04.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:38:06 -0700 (PDT)
Message-ID: <20873d35-86f6-70e7-ed19-efaffb9eb25b@linaro.org>
Date:   Mon, 3 Jul 2023 13:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/15] genirq/devres: Add error information printing for
 devm_request_threaded_irq()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230627071707.77659-1-frank.li@vivo.com>
 <82dc5efc-35fe-15ff-d0ea-e1a19da71c5c@linaro.org>
 <db14ea3c-c224-e263-e134-70e9acc5008a@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <db14ea3c-c224-e263-e134-70e9acc5008a@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 11:10, Yangtao Li wrote:
> On 2023/6/27 15:43, Krzysztof Kozlowski wrote:
> 
>> On 27/06/2023 09:16, Yangtao Li wrote:
>>> Ensure that all error handling branches print error information. In this
>>> way, when this function fails, the upper-layer functions can directly
>>> return an error code without missing debugging information. Otherwise,
>>> the error message will be printed redundantly or missing.
>>>
>>> There are more than 700 calls to the devm_request_threaded_irq method.
>>> If error messages are printed everywhere, more than 1000 lines of code
>>> can be saved by removing the msg in the driver.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>   kernel/irq/devres.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
>>> index f6e5515ee077..94039a915218 100644
>>> --- a/kernel/irq/devres.c
>>> +++ b/kernel/irq/devres.c
>>> @@ -58,8 +58,10 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>>>   
>>>   	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
>>>   			  GFP_KERNEL);
>>> -	if (!dr)
>>> +	if (!dr) {
>>> +		dev_err(dev, "Failed to allocate device resource data\n");
>> Just like any memory allocation, I don't think we print anything for
>> devres failures. Why do you think we should start doing it?
> 
> 
> And tglx point out that:
> 
> Having proper and consistent information why the device cannot be used 
> _is_ useful.

Where did tglx suggest printing devres allocation ENOMEM errors?

Best regards,
Krzysztof

