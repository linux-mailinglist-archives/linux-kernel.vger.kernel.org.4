Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A96B9AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCNQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCNQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:15:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEB66D08;
        Tue, 14 Mar 2023 09:14:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b5so6640111iow.0;
        Tue, 14 Mar 2023 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678810493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7/NJFMp55FP9d4lUfA2syHfWROdB2xhss/WwEMJ0xxI=;
        b=ReS4FkoZnmEIS0BNihLjnK9REN1O1hRdyKv4YF6CvlbftQbHyPRHiazY7KguD6YL1Z
         bKfoobYN8lZrLfaOm2hhz7JiynZ5BkBFVQc1YBk5sYhQg7LziYOJrnQjpESbXVDQmWng
         c5Ha1teqwYdAiuzxOpRCbWFPTAdJ87r5l01QOChSyLdHqMl91uMd1XWJZuA+s03ds/LP
         LnVugI/vlW74kLuMhkx47JCPmY+Le/ZomaWLaEiI7JhIEJUguqzVX2CFFKbJ5rB350VJ
         qcodUHBupVcterXQgvK4IU3j9rRQFwu8UwJXPPvbwpsqNXUZU0i6y9MaI9TQIdAY7vE6
         2EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678810493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/NJFMp55FP9d4lUfA2syHfWROdB2xhss/WwEMJ0xxI=;
        b=6JIFLOAUaTLark6ybEtyprQkDXHM9og+MmBEvvSQZqljFtYeulS1191PBONAawyQdX
         uIOoPCS5TMVfXQy3LrChgCEQZhW5bhEqmfc1n9Bw89fYQhIwMGBtnLQRk1gxD6dHTbAt
         deLZ6yYnw80D8pYDIyFmPMRruX9nyZpjmEfAidsV9NLRqSjJXwHQvP1TXAffeh5yvaNI
         +iivS6GKtXcBXYZ1q81q8tF6a3IVeXSDwLthTRGmZK7i30/+rL1zjGlGEYgnDdyjGioA
         Y+03qPmmTW1zDaA1rJIz/ruYxDlkrW/vB4VEPdenGE9t71fHnjrJKUd1cQlDtrVwPlgs
         yWnQ==
X-Gm-Message-State: AO0yUKXPR/9zC4B8Z2o5yCv8QXJ0roo3qVzZiGDHHOG6Shomp6ekDpGM
        +SAddgYhyVGDlk6YuZysb3Q=
X-Google-Smtp-Source: AK7set/wzGnZZPegnybU6k9dt8ljC2I+CBFCuN+imlykWn38LOFV9u7phFJorbIH+ciPeuYmvh/Paw==
X-Received: by 2002:a5e:9e03:0:b0:74f:b453:b334 with SMTP id i3-20020a5e9e03000000b0074fb453b334mr2368824ioq.18.1678810493356;
        Tue, 14 Mar 2023 09:14:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c950000000b00403089c2a1dsm877882jao.108.2023.03.14.09.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:14:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d6401cc5-990c-e46c-2d5c-148ce76c8b79@roeck-us.net>
Date:   Tue, 14 Mar 2023 09:14:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
References: <20230314152916.185939-1-william.gray@linaro.org>
 <ZBCX0iVwYD4uVxwM@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZBCX0iVwYD4uVxwM@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 08:50, Andy Shevchenko wrote:
> On Tue, Mar 14, 2023 at 11:29:16AM -0400, William Breathitt Gray wrote:
>> The regmap API supports IO port accessors so we can take advantage of
>> regmap abstractions rather than handling access to the device registers
>> directly in the driver.
> 
> ...
> 
>>   - Utilize watchdog_set_drvdata() and watchdog_get_drvdata()
> 
> I'm wondering why you can't use dev_get_regmap() instead.
> 

That function is quite expensive to use in code that is called
for each register access. Its typical use is to get the regmap
for a driver once and store it in a local data structure, not
to use it for each access.

Guenter

>>   - Map watchdog control registers based on offset 0x1 and adjust regmap
>>     configurations accordingly; offset 0x0 is unused in this driver so we
>>     should avoid unnecessary exposure of it
> 
> I'm wondering what bad could happen if you expose it.
> 

