Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF53E745870
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGCJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGCJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:32:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B64E5F;
        Mon,  3 Jul 2023 02:32:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99357737980so132666466b.2;
        Mon, 03 Jul 2023 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688376733; x=1690968733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvMYtyGoPKg6lXYME5kTaweQWa3SmJSNHqMo+u8KFsU=;
        b=dIkHXlNBrl4QT1Wq6cGx2O//dXR7xrTSUmMrvX72UYDHrGSXH+hGFGyzM12EV538BJ
         MmIE+ct0EyhP7rgDy3/GYe4Js4gZS7OIr41Xx/uW+Pdfx77qJe69vtLFJh8Yd9PbZiFC
         2Khse9xxeDcRj3nkPidkIoXgPqgO+z+TO93jY9E/1A3pTuoBEyEV8+pJoVSgtBGi9182
         WMrpsRtfhBkFV3tlpKXwCcM66Fy7Ol0j7ilCZwvRwDsTZia+kqDzs3jtvQyLn4GPXE7h
         qTn6vk0s0RErUej4Lax0zL1OBfwZRy6BpDKa8CXE/F9L0wg1JIm/cMekD+l49Pv53bms
         6byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376733; x=1690968733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvMYtyGoPKg6lXYME5kTaweQWa3SmJSNHqMo+u8KFsU=;
        b=bEbCex0vb+p4Qr/c50LCdfqsy5DjhvIzAFuZIt8+IAOXYbdAYnty6GUybNTlEIHHKG
         3VNs6WgBLwzYH5QanSSH3dpdE74fLnDm/PlPzVlVkRZo76RetdEYcN3kQAk8c+wPdhF5
         x9i9g5s2wSsTbrtZ7sCv5NhPXGRbwiQ6acP8/kEjbV0eAIYyIeWLeqftdCC1zzr4SXa+
         Z2forRxYSn/bNSND6Zot75ZO80nVI0YLJja3wIotX+fVC1tdgaowSllVfh+a+Xq9Jz5Z
         Jhym6dPFyIqhufv5Lw8dx5qYBp5CHoFL0q7LplyvQe5UeahMuyfub3t2R+wpXqEUQSoZ
         IlxA==
X-Gm-Message-State: AC+VfDzuYRKUyGnJolP3JYCPNAceetl1beso2Jo1/1Lz8gJb9fBwk/V2
        GKQOLs15r6Mw+hQepBWTBHY=
X-Google-Smtp-Source: APBJJlEcBKQ92RfoGW7SIFH16Jl0HjbFTc0Yq5AAdkQl1oFPhntKF1P0GT311c3u4jAVA5XnVGeSYw==
X-Received: by 2002:a17:907:766c:b0:982:ab8d:1e08 with SMTP id kk12-20020a170907766c00b00982ab8d1e08mr7027164ejc.59.1688376732881;
        Mon, 03 Jul 2023 02:32:12 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906859a00b0099304c10fd3sm3709091ejx.196.2023.07.03.02.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:32:12 -0700 (PDT)
Message-ID: <0d2dcb62-8475-8b2a-7ba9-bdabab3d0aa4@gmail.com>
Date:   Mon, 3 Jul 2023 11:32:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] led: led-class: Read max-brightness from
 devicetree
To:     Astrid Rost <astridr@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     kernel@axis.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230630092248.4146169-1-astrid.rost@axis.com>
 <20230630092248.4146169-2-astrid.rost@axis.com>
 <3e8e7834-fe0e-7e92-5472-cb9fd223980e@gmail.com>
 <abcfb68b-b631-8a7b-e7cb-daefc58f3dde@axis.com>
Content-Language: en-US
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <abcfb68b-b631-8a7b-e7cb-daefc58f3dde@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Astrid,

On 7/3/23 09:53, Astrid Rost wrote:
> Hello Jacek,
> 
> I am having problems with the PWM controller LP5024.
> 
> https://www.ti.com/product/LP5024
> 
> There is no such a calculation in the data-sheet like:
> max_brightness = max_current / constant.
> 
> I also assume it is depending on the type of LEDs and circuit, which are 
> connected.
> 
> It supports two current modes: 25,5 mA and and 35 mA, both is to high 
> for the LEDs I have.
> 
> For max_brightness seems to be everything inside the kernel, but reading 
> the value from devicetree. I first thought I could add it in the lp50xx
> driver, but Andy and Rob thought that I better put it into the general 
> parts. And of course drivers having led-max-microamp should better use it.
> 
> Please, let me know if you have a better suggestion.

OK, since this LED controller is PWM-driven then there is no current per
brightness level granulation. Bindings of leds-pwm driver also use
max-brightness DT property. So, yeah, let's make it a common property,
but state clearly that it is mainly for drivers like PWM ones, where it
is not possible to map brightness level to the amount of current.

-- 
Best regards,
Jacek Anaszewski
