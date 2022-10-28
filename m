Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD50B6107E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiJ1CUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiJ1CUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:20:03 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B0B4C2F9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:20:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l28so2748427qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cykFnUK9bm/0PhHnZ0sXhtZ2At3ENMM99eYPdegdYSI=;
        b=AQJVYjKsyiTsjDySzOp48brbJiygd9QBWnj3eqx4ycythFdyul1dAGKYj+uTuabOYd
         R4JA8+FlW70IhjEgqggL9QziGlh7/l3LTgAYQkrzZHeF84hiTphL3mIzJP+Ji1/7KXk6
         Zxyk/yTJFtxODuiIdNpR1v4Tb/IHo1msssbiT/8gEcpo6dnsy/bBr5SicRVWQ/SYvoGw
         f6qwZB0YLz/+nKEAZgio2FOp3UFjxD0tDnV+/H+L80njN6vGAonlJVvXHAc6ao7Baxs6
         mKQQt1FP4htijiDoRDbs8D8DIX0D0JRqct708dGH7QvXcVsbvRvpY6AjgWqW0/q+3mAs
         VJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cykFnUK9bm/0PhHnZ0sXhtZ2At3ENMM99eYPdegdYSI=;
        b=hZ1UefTgymOddM0JtduSNFQMDATG3TZz1e+IHZFq73WtoH0+YqBClTwPo+LwPqGAZi
         ozl8sJHr0Nvh/8RslvU7fC+loH3LPClD40BzKjrUt8I+V8rSNCs3Pq+oWU7CGw7/DeSB
         0ugso3qJTzyefHRPmVjfXpthikSqaPHxZDT1fH4bhguOtwz8ZzXwe2ZPmTQP78unBJ8H
         hE0FinchWEt4MyqrXMIbZccKM6v0ZAfwvZ9xNRmAdbLX+uCSAbQUsJfaW/VFVSd9afmo
         vmFNDos1FKJ4IWqvFAJAnUKoYpSm+7cr51+ffQV6kYI5vZVPQpTobkEPYtMEnTXyTEcn
         8wdg==
X-Gm-Message-State: ACrzQf3+Xmvbvw7+W6X+bQRUoK9VTTu/bdn3D3SlHLmqoUwcdSO418Ol
        YHc6tis9C83TC3bDO3PsqmafdA==
X-Google-Smtp-Source: AMsMyM4nFrse7LOawN/dKiRc/aj8ygVoOp4zOOXiLSE5lagp50tusE21h1qz86DoB8x3z2sSytqEbA==
X-Received: by 2002:ac8:7d94:0:b0:39c:ed3c:98a3 with SMTP id c20-20020ac87d94000000b0039ced3c98a3mr45065437qtd.628.1666923600693;
        Thu, 27 Oct 2022 19:20:00 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id a24-20020ac86118000000b0039ee562799csm1760187qtm.59.2022.10.27.19.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 19:19:59 -0700 (PDT)
Message-ID: <f5d2c979-a61c-e0d4-7a08-5b6f5b38dffb@linaro.org>
Date:   Thu, 27 Oct 2022 22:19:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 02/11] dt-bindings: usb: Add NVIDIA Tegra XUSB host
 controller binding
Content-Language: en-US
To:     Wayne Chang <waynec@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Ajay Gupta <ajayg@nvidia.com>, "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sing-Han Chen <singhanc@nvidia.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20221024074128.1113554-1-waynec@nvidia.com>
 <20221024074128.1113554-3-waynec@nvidia.com>
 <20221024145446.GA1763588-robh@kernel.org>
 <52ae737e-eb4f-9eb7-8b79-d58251062276@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <52ae737e-eb4f-9eb7-8b79-d58251062276@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 04:02, Wayne Chang wrote:
> 
>>> +  power-domain-names:
>>> +    items:
>>> +      - const: xusb_host
>>> +      - const: xusb_ss
>>
>> Drop 'xusb_'.
> 
> The properties are constant and we use the name to get the power domain.
> 
> 	tegra->genpd_dev_host = dev_pm_domain_attach_by_name(dev, "xusb_host");
> 	
> 	tegra->genpd_dev_ss = dev_pm_domain_attach_by_name(dev, "xusb_ss");
> 	
> we might not be able to drop the xusb_

These are new bindings, so why do say they are "constant"? New bindings
means you did not use them. If you used them before bindings... what can
we say? Don't?

Best regards,
Krzysztof

