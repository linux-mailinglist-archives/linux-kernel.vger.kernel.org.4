Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F375BAAA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiIPKOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiIPKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:13:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B971ADCE8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:10:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so35187760wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eVpP3B8Yd3GGlXs2s7bOVxeOJGC3gSkrPxMOLUAsWP4=;
        b=wvLUctE9te+Df6XtYkm6JJ8C6mOGaMhUfG/JkmfPOw1XJPaOpx1wN4YYB9sfAxbIyB
         BrgUODZIsHB+9isoBcG9XjRjDCIKvfbFv3FnKYG3RbE2GF7Z6QCYCratzr6QqUo8iilf
         OZ+lli2lOFVDHcZvX5elHc+C6k53IHe3ApuIYkoBsf9/2QR/4TTAtmFQ483YTn4gA423
         JKrdGrTUyn0ZrpFfzCb4p2pSwAQeDnYIMDb2o1IvIOMki0aqUoRwH1xxDENhiqOR1rGs
         D5KoaVl0p0kfaA6qe+lnbawEnq8uc5QXsNPsQeQqw5meBaRebtsSKIU+hZJyYwQ4mB/J
         WbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eVpP3B8Yd3GGlXs2s7bOVxeOJGC3gSkrPxMOLUAsWP4=;
        b=YlRsvvSpSAeC+cQMSF0tP+Ei/vSeJiK5pU0slLgl0IUycQjJIZhazAKkknC8y0fi4+
         4XuEmk+cruUvFc9Yw/7MG0AD5cbNTluxp9MVoypAro98REAkpJysLUBkFIOMAhZeAeNi
         9brknbTmwiLMrAmIuGVjPauPXr1wMakah0TvCEI8jK+W1lGWndLBhMndYeFx/zPnzJ2G
         Et3lcSLDsnOqjQ/K609zqLyXnKafTcp4BiFvp89fzjej4EOzZM/bZSzKyZp196Syarkp
         deadtWR+AIK1Cf9OYtF9HwMfoO2QHz9Xn1Rtr7/z7/pCdetjoY4U0yk+WmH0ISZKtPBl
         NqRQ==
X-Gm-Message-State: ACrzQf1h/GymiBFncr/TmsI4sDLE2DVpV19IBOrrMJbd9LrpxqTXubJ9
        jqubosrAW+OGoRV0nrgLBVxFAA==
X-Google-Smtp-Source: AMsMyM6u2LHVqC2nJe9wN0MgBRE3VSw6iSwbOSX3d4vZDY2O2WPYHqKaSndMHVlMJGTCvTgSyitPQg==
X-Received: by 2002:adf:df82:0:b0:228:e2cf:d20f with SMTP id z2-20020adfdf82000000b00228e2cfd20fmr2522431wrl.356.1663323013991;
        Fri, 16 Sep 2022 03:10:13 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id c2-20020a1c3502000000b003b4935f04a4sm2205155wma.5.2022.09.16.03.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 03:10:13 -0700 (PDT)
Message-ID: <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
Date:   Fri, 16 Sep 2022 11:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
 <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
 <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 10:04, Michal Simek wrote:
> 
> 
> On 9/15/22 10:44, Krzysztof Kozlowski wrote:
>> On 14/09/2022 14:15, Mehta, Piyush wrote:
>>>   
>>>> Where is the user (DTS) and implementation of this change? If this is specific
>>>> to Xilinx, why you do not have device specific compatible?
>>> [Piyush]:
>>> We have dedicated irq line for hibernation feature,  "hiber" irq line triggers hibernation interrupt.
>>> DWC3 core supports the hibernation feature, we have a dedicated code which is yet to be upstreamed.
>>> As the hibernation feature provided by dwc3-core, so this will be supported by other SOC/vendors.
>>
>> But is hiber irq line present in other vendors? What confuses me is
>> adding not only "hiber" irq but also otg in completely new enum.
> 
> I will let Piyush to comment hiber IRQ. But I expect we don't have visibility 
> what others are doing but this is line is not Xilinx invention that's why I 
> expect IP from Synopsys have it by default but it is up to soc vendor if 
> hibernation feature is enabled or not.
> 
> otg is already listed in
> Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> 
> It is only about order.
> Driver is already using
> platform_get_irq_byname..() functions

Linux driver yes, but other platforms (bootloaders, operating systems)
might be doing things differently. Therefore the order and items are
usually strict. If they cannot be strict, it is nice to know why or it
is nice to restrict it to some specific variant (if it is applicable).

This is why I asked whether the line is specific to Xilinx or to others.

> 
> I think any combination should be fine. Do we need to record used order or there 
> is way in yaml to support any combination with dwc_usb3, host, peripheral, otg 
> should be working (ignoring that hiber which should be likely there too).

What confuses me here more, is having otg. I understand that dwc_usb3 is
the single interrupt for all the modes, so my naive approach would be:
oneOf:
 - dwc_usb3
 - enum [dwc_usb3, hiber]
 - enum [host, peripheral, otg]
 - enum [host, peripheral, otg, hiber]

However here Piyush adds not only hiber but also otg...

Best regards,
Krzysztof
