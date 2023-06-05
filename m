Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28C722107
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFEIbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFEIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:31:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15104C7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:31:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so46502575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685953898; x=1688545898;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :content-language:references:cc:to:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w33NFs9NKaKx4FHgTPgRsKul7wuRuEzUhG9qWfveVqg=;
        b=meHNHj71nk1G60egTOikZNzf9bGrnks19/urL0IAx6KDFZ7WDQNSe5z1z2c5luucvW
         mLsgV16m+mzY+jpIynxJdxNkXoVaH8pM45s3bZxOtqzPGPq3Vj6U1OpC9eeAuGM9/MFN
         iYQMg45Yhb1txDr1lFH+0Y2fREIvXsTTKrFqQ9f5QbhP94HO1jTehFE7D1bVE0m1ySo+
         KabJL6ckbF64Ms1hkYrKylRrsXN7miNeUxzsnFqgtFCtC7R6pA7MfkteYKAul853tVmn
         TdSFVMdne26vXwwSN/XvdypOJ1/+67dApglhlzQEj3CQRES5ptEm0j2iU4WhE3Mesq3t
         IG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685953898; x=1688545898;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :content-language:references:cc:to:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w33NFs9NKaKx4FHgTPgRsKul7wuRuEzUhG9qWfveVqg=;
        b=ES6oBXidUGo2KETQB01UwJyP998GCacEFsuQ+HAgR3KXtvCL1yi1aa7uhUXVmwp/SX
         wjgFmc5IxA+dg7XA4ihAOgB1r5g6sQG54xfbyWkKeQrcoOVuMfnVr+1yDsqETBEsrXXk
         mFcr5dz6T2M++RMNzpkS1EdU52EJxpwLoCwWH0S4fUj+kG2BFiotqe/8+Sz6QBJdqN0m
         8wWDFK62g9eFWe+QIAbmq7eDucOjBUJjIu3fbxkLg3F0aDNtHYtuIKsAon2zr7jIoPLl
         4Vg1ZQ4R20hiDf0haUXWoMN4gw0qnifutD0sNOFIcwbvNJlilusq9GAJZRtrFFSol9Bn
         qF7Q==
X-Gm-Message-State: AC+VfDx8nTUuZFXFZb+h4D+BUgtofFRHM+Pa049MyCf/md5RNW19fhbQ
        e/91AiMm6cweeC4OVgCCpQJv/Q==
X-Google-Smtp-Source: ACHHUZ5sBks7sH2tdACY7VhIK2H5kjcJrT+ivIsWNVtKwfHiV7wgcAqbq8su7V3Isk1sH3Mkf4lmEw==
X-Received: by 2002:a05:600c:2146:b0:3f7:3636:358c with SMTP id v6-20020a05600c214600b003f73636358cmr3253241wml.11.1685953898454;
        Mon, 05 Jun 2023 01:31:38 -0700 (PDT)
Received: from [192.168.7.188] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d6a04000000b0030aea925fbesm8969116wru.50.2023.06.05.01.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 01:31:38 -0700 (PDT)
Message-ID: <e491ac11-e21b-f737-7b4e-851b85c1408b@linaro.org>
Date:   Mon, 5 Jun 2023 10:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org>
 <20230601-topic-sm8x50-upstream-redriver-v1-2-6ad21094ff6f@linaro.org>
 <ZH2brE5oq5d7tQbO@kuha.fi.intel.com>
Content-Language: en-US
Organization: Linaro Developer Services
Subject: Re: [PATCH 2/2] usb: typec: add support for the nb7vpq904m Type-C
 Linear Redriver
In-Reply-To: <ZH2brE5oq5d7tQbO@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/06/2023 10:24, Heikki Krogerus wrote:
> Hi Neil,
> 
> On Thu, Jun 01, 2023 at 11:21:13AM +0200, neil.armstrong@linaro.org wrote:
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
>> and DisplayPort ALT Mode Linear Redriver chip found on some devices
>> with a Type-C port.
>>
>> The redriver compensates ultra High-Speeed DisplayPort and USB
>> Super Speed signal integrity losses mainly due to PCB & transmission
>> cables.
>>
>> The redriver doesn't support SuperSpeed lines swapping, but
>> can support Type-C SBU lines swapping.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/usb/typec/mux/Kconfig      |   8 +
>>   drivers/usb/typec/mux/Makefile     |   1 +
>>   drivers/usb/typec/mux/nb7vpq904m.c | 526 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 535 insertions(+)
> 
> This looks good to me, but I think you should register a retimer
> instead of a mode switch (the orientation switch is fine).

Indeed, I'm not familiar with namings but by looking around it seems that
redriver and retimers for USB-C applications are exactly the same.

> 
> Retimers are handled just like the muxes, so this patch would not need
> that many changes, but you would need to change the first patch too.
> You would need to declare a "redriver-switch" instead of "mode-switch"
> property in your DT (or perhaps make it just "redriver" instead of
> "redriver-switch"?).

So it would need some additional handling to also set the retimer state
along the mux, but I was wondering, why having a separate handling
while the retimer state struct is exactly the same as the mux ?

> 
> We just need to add a device type for redrivers to the retimer class -
> check the attached diff. Something like that.
> 
> Let me know what you guys think.

I think I'll switch to retimer, thanks for pointing it to me...

Thanks,
Neil

> 
> thanks,
> 

