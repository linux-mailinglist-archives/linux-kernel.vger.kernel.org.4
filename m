Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B015B968E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIOIpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIOIo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:44:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D1E65817
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:44:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso13315418wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dH3Xddf4i5wgA75cL5yNqkffds3UMT4VE2SGxW8RhZ0=;
        b=w3JmFD3guZo7MocNtVx9G7wa+lRT/sZ8vNA5Uk1hmDctwgD4yofQefYoX8F9daHJgw
         /0mT5QAI3kVtnkM2mfOod90kPojQvCiejX5Hxg7lMTT44u2XJt7koTpLZocfyObv/O4X
         mmC3zcZdT+vnVMIwHNHDmIu1tLDpT8rHjxk84pHQGBZDamxaPRMdMzMd2h1NiJaFSman
         lJqbLD4q6jUAR6ZGnZvJ4/YNPZEQyreaj6OM1fN/Xijpj5Tz6fXxilW+yv2+tuF+yVX5
         1Vg8a7Y3pe2aH1P07gTISmTQZGZwkbxOHrmeW9Kekcbk91Zi1mtZZPKEyxY0uWcMyasu
         +5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dH3Xddf4i5wgA75cL5yNqkffds3UMT4VE2SGxW8RhZ0=;
        b=ZTASVj3/ZdEef8f3WzKH5ywWqJe0X1s8AhWxad1EdOrNwLAII2ENmdwkVGg00UlHCv
         /Zh6eocW+9oeY0dBgKKPthz9NrS1xksgkHtOOzmBW6xyKKeRzGQnn3pbg+qGl5z4MowI
         ceu7JCp3CjY2EaBWsyFLcXHdEJuWfZr52OV3H8mX21dp2fHD+oCpZFch7T0A0lt83CDF
         USy3nlM+Jn+Bn2hGYkJAk6tAvPOP/Y7eOrVyCWoPJMF+sT37Q1GuCCrzy+x43w1OVba4
         jfmyNUaONwH480MTHRa3HI9czI47R+mCTxtHLWqsgvTzSUFg57+C2XLVPEfKwW8b0DKO
         YOkg==
X-Gm-Message-State: ACgBeo2Ox2TkueOKBWvv8jLP0SVosm3Jkd6kw0X7G/8ZhYGjiDH9UB61
        DHpUlwQS+Aj0OvxLkn9l+q2v6oMZvuu/HQYN
X-Google-Smtp-Source: AA6agR6g3+PdSE1eWZLnJptiRikw1dAQOcBMC54WBw3sZVuwHijTXaUiB7oVB1SdslSnYh68ync4Sw==
X-Received: by 2002:a05:600c:2e15:b0:3b4:9c95:2871 with SMTP id o21-20020a05600c2e1500b003b49c952871mr5852312wmf.133.1663231496194;
        Thu, 15 Sep 2022 01:44:56 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b003a1980d55c4sm2080912wmb.47.2022.09.15.01.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 01:44:55 -0700 (PDT)
Message-ID: <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
Date:   Thu, 15 Sep 2022 09:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Content-Language: en-US
To:     "Mehta, Piyush" <piyush.mehta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 14:15, Mehta, Piyush wrote:
>  
>> Where is the user (DTS) and implementation of this change? If this is specific
>> to Xilinx, why you do not have device specific compatible?
> [Piyush]:
> We have dedicated irq line for hibernation feature,  "hiber" irq line triggers hibernation interrupt.
> DWC3 core supports the hibernation feature, we have a dedicated code which is yet to be upstreamed.
> As the hibernation feature provided by dwc3-core, so this will be supported by other SOC/vendors.

But is hiber irq line present in other vendors? What confuses me is
adding not only "hiber" irq but also otg in completely new enum.


Best regards,
Krzysztof
