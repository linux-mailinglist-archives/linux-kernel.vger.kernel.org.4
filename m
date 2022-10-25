Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A218E60C07C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJYBHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJYBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:07:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0A171CF3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:15:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j21so7123530qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMyBAadE9jT7keW2Iz84U2Ui+EeQMGMSZPVnQH8Mg94=;
        b=E89tmkbuGxzrnlxxXB5ytpm2tNdd7d2sUi6NwZwhxSgOrcmwyqqB6BPArnDWGNM7NM
         hfphQVLeRbeFieuiqvY+h3lJjIBtb9Wh0vMrbYMXblhoiezJvfph8z4+rMUIbGzobJos
         yY5dTGKtkpsVRh0u+J/ZLH7cx2RK0SBbpO6HmVKooLqt7HVfbDUN1Rxdlh4gmwNlySvG
         PJ3Fqjt4cgDy6ELwSZFYOXQd9tcFkX8pf2BSTJfs9WhYplac8nx3qvl1ZDR+LDo86nbm
         kp+80xTK4F1Qp+oQGq85legG4rAODphXrvRFPejvbgmRlwBf18IIA3vQN9JGIkUYQKs2
         V46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMyBAadE9jT7keW2Iz84U2Ui+EeQMGMSZPVnQH8Mg94=;
        b=rQv9nBrF2pjRlePuap/Z8Ipk6a2X7yM2c91OcilcPBcI4Kf4N/O07EbbMqDF0tHNLa
         4mhHojmd8OtQ7BcMZjpYfavHDQYHhIsO0ZRerLFVpL+XIJpUX+c4EjwGs13ZIUkuF4ac
         KfogktK+6cSqf5jO7b2RIm2y6pm+omd/8U8YCuezutHBGOX8/NyGIAud/6jXt8mkC1Mu
         qMhghtOKsYqhwW/MAqn6LaK2x749teq+WJZ3zvM/ZFM0t0JbzuBuEep/r/zeDBuJkTxj
         H5D8HdhcJfmlz6SRTlWKC0l6lwGJJEdiVDxd2RHEy3t05adNAssT6P7o7WlfVYFY+ZdV
         8UIQ==
X-Gm-Message-State: ACrzQf3PVnMkHHhctjlJyFnrusopmf6bW8k2WRe8i57bqyB1W74Sr8bM
        3//TnA2Lsgh8tT2aPg7kyBW5hw==
X-Google-Smtp-Source: AMsMyM46bqy32oNqEmSHpF73Fpm3i1V9sJnJPRx+HXZIVt5rGs2TVIlCc1ICUNKJBsFCfMYBbt0VEQ==
X-Received: by 2002:a05:620a:6009:b0:6ec:ed49:b93c with SMTP id dw9-20020a05620a600900b006eced49b93cmr25597569qkb.180.1666656928817;
        Mon, 24 Oct 2022 17:15:28 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dm12-20020a05620a1d4c00b006b5e296452csm1017225qkb.54.2022.10.24.17.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:15:28 -0700 (PDT)
Message-ID: <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
Date:   Mon, 24 Oct 2022 20:15:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
 <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 20:03, Hawkins, Nick wrote:
>> I don't think DT place is to describe register or memory layout, with some exceptions like MTD partitions or nvmem cells. Basically you are representing here a device register map inside DT, just because it is a CPLD.
> 
>> Every regular multi-functional device handles its register map in the driver itself and uses Linux framework to expose the internals. CPLD should not be different, except that is programmable.
> Hi Krzysztof,
> 
> Thank you for your time and feedback. We are looking for a place to describe differences within our CPLD implementation due to our memory mapping not being consistent. The idea we are pursuing is to use the device tree to serve as an input to Linux to prevent driver code fragmentation from multiple platforms needing their own specific offsets. 

I understand what you want to achieve, but Devicetree does not seem a
tool for that. DT describes the hardware characteristics, but not is
exact memory map.

Although your goal differs than for example goal of some developer of
I2C or MMIO device drivers, but essentially devices are similar. We do
not describe memory map of MMIO or register map of I2C devices in DT.


> If this is not acceptable to do through the device tree, should we rely on having an include file for each platform instead?

I would say use rather standard Linux subsystems and problem is gone.
You have fan? Sure, we have subsystem for fans. You have power supply or
battery - we have stuff for this as well.

Best regards,
Krzysztof

