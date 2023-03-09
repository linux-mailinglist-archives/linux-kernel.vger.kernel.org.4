Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A516B234B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCILoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCILoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:44:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4A09CBE6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:44:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j3so937470wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678362254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cB9x4ZljJMjizQbiracn+TG6QtgEI/5W2g7XyKO1No=;
        b=VHotFGHdkdCyfKGH2Ph5IP6gbmV+M84RQQgtVA0fgpSqci2ku1YxobhBlPanByZ1uv
         ZZfqaFOK0uqLqwP2tGMwG69Cvv7s73cHJkTT9CWiWuOYj47pFoNL+odWRPuxzRzKTkBn
         OtQrXgPTvV0rDc8dBX/z4ZkYFhLM/o8lQXhkcw88yS1RPqIoq6KrhDFQCJIftKhY/o3E
         m/v9mrQAjVOQ3izdrVocyB8LHhmsNsI4v1K84LkR7oXx8JCivvVNy1xCJmYgKdtXrjcf
         bZM/5FiTjrn6IbWWuZ5Ek64SxRBSYomg4XNVT8lvoBHgjwN5tlmGI7KnyU/rd4WspuT9
         vlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678362254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cB9x4ZljJMjizQbiracn+TG6QtgEI/5W2g7XyKO1No=;
        b=qpWddU5Z+V0J8MuUIPx2ccA4ix7JGIrPRImJDaYbEHzIQ8s27svUv5zZ7Tc6vBPXYB
         ctMNvt3lNCJeuQGhZnVfvAYm8IRAw06k4eSXrllbNmx7y1qfw00JCERuuBr9iK35d0pl
         CcvtdkSIdiuSIA7ZHRSrue0WqSSky1J46WRfUzvXG7HA1EIpfg96GEXCowVMMLJkDJ2W
         oIM/9Q327VknbD/LsMuue2Ne+iMSk+73g+vdpHIPQOoo2pn75XgDF6te2zkb28R1TVPt
         eVeJgkBodXOIK6AY8UqGl24BCGaFTKfhGMVbfsdWitANv7h2M4LDUoqbL1njD7VciDmS
         fdhA==
X-Gm-Message-State: AO0yUKV0m52ylpRMra1ETDFl0gpW40qAEI9giqhVREvF41tS84H4KJZN
        6O9Mc/kRa/ZAyQtgrk4XzsDt1Q==
X-Google-Smtp-Source: AK7set8pbUjmh2HDihqNwWBHGvWjbLhc97YyUsAX8/OodjtKkjrmc6aZaZWKSsvaHznNhHhi3VhD0w==
X-Received: by 2002:a05:600c:3b97:b0:3dc:557f:6129 with SMTP id n23-20020a05600c3b9700b003dc557f6129mr19178271wms.2.1678362254451;
        Thu, 09 Mar 2023 03:44:14 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m5-20020a5d56c5000000b002be505ab59asm17517012wrw.97.2023.03.09.03.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 03:44:13 -0800 (PST)
Message-ID: <fb6d7c76-d3d3-b8a0-46f9-dc2eb76ae91a@linaro.org>
Date:   Thu, 9 Mar 2023 11:44:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t
 callbacks to adjust buffer
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230222172245.6313-1-zajec5@gmail.com>
 <20230222172245.6313-3-zajec5@gmail.com>
 <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
 <20230309113211.6321ce3d@xps-13>
 <2dc096f5-f5ce-f99b-42ac-0fb24682239a@linaro.org>
 <20230309122324.4b012a58@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230309122324.4b012a58@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 11:23, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:53:07 +0000:
> 
>> On 09/03/2023 10:32, Miquel Raynal wrote:
>>> Hi Srinivas,
>>>
>>> srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:12:24 +0000:
>>>    
>>>> On 22/02/2023 17:22, Rafał Miłecki wrote:
>>>>> @@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
>>>>>     	if (!nvmem)
>>>>>     		return -EINVAL;
>>>>>     > +	/* Cells with read_post_process hook may realloc buffer we can't allow here */
>>>>> +	if (info->read_post_process)
>>>>> +		return -EINVAL;
>>>> This should probably go in 1/4 patch. Other than that series looks good to me.
>>>
>>> FYI patch 1/4 is also carried by the nvmem-layouts series, so it's
>>> probably best to keep these 2 patches separated to simplify the merging.
>> that is intermediate thing, but Ideally this change belongs to 1/4 patch, so once I apply these patches then we can always rebase layout series on top of nvmem-next
> 
> Well, I still don't see the need for this patch because we have no use
> for it *after* the introduction of layouts. Yes in some cases changing
> the size of a cell might maybe be needed, but right now the use case is
> to provide a MAC address, we know beforehand the size of the cell, so
> there is no need, currently, for this hack.
> 
Am confused, should I ignore this series ?

> Whatever. If you want it, just merge it. But *please*, I would like

:-)

> to see these layouts in, so what's the plan?

Am on it, you sent v3 just 24hrs ago :-)


--srini
> 
> Thanks,
> Miquèl
