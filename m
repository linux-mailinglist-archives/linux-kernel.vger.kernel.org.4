Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77406C6226
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCWIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjCWIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:43:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BE193CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:43:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so83124431edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679560999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80xGh8CPsTSG4O1k35DjXgkYHJO15o/aXD74g8k9KT4=;
        b=H5ZjWr+Y/eQr8NXNdXFnZw/mW6qz5fNCexQiiFujBefVxv4IYoY7xplelWUQEvEFT/
         hEYmseGUaz4AFV2eh2tmpwuNDpBZeH+Xv2j4l+1M0SgW+qoRODc1Av5Jsu7fp77SLke0
         2oEk2OoSz4UcONJclTzUxDtUora/rGwlxa1lc4Na01ShAswXyKiiR38Vhpn7hldLqkHN
         rgKT04cgQvShtbF05f2mO7ur652+8GjzS2xK8+iul7q0hRYjUA9HEqHm04u2XNVlrfUK
         5mT0fYHCvBXBJ3neV4OMkfSOeZhDhj5gU4QQ6/w/NnnXsQq5LrLPbNOyEStB+GqI49I+
         vacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80xGh8CPsTSG4O1k35DjXgkYHJO15o/aXD74g8k9KT4=;
        b=loENPwx6yz5U1+Xf7DrH1AAH7Pe9fahbZb/zVhENwcf5MsWNvlfJHpho8ZJ5MGBRMI
         e/CMQld4JXXffRZ1eaQEgBTex7vWVCsDSHKOlv2VS3z3pvun3uJ8VbUhS/HqJ0XYm5N0
         x3tCYuOQ00SOrWkLrfkxVl6UltWMj3C4Ni3BRAJpfDHt+EOwzuvjfW91MbrnEpB5ue+n
         uqD/1YTGBzzKoPGiDGxreCPEmYjzBVdO6KjmRGgdKg+zyQUjky1RZx+hye9DFcEAdIEG
         Z9pBS/bazE3vyLW/odEH/wmQQlo6G1OSEv4NYQy+T0nT2kO3PNR9SRU/l7gtNVd92yY0
         ezfw==
X-Gm-Message-State: AO0yUKUd5llFk1BnFECnkzbKgTIrWo87qo70hIxWkPWO99f4diAhh+zN
        cp3R+Gt/GwuWbHQVSeC9d5QF0A==
X-Google-Smtp-Source: AK7set8k+NnbvppyjVpAPFfMW6LLIyShuJzalFo9pGveOIFJX9+HpY/8/7BJ2GyvXyffzaOrfucbSw==
X-Received: by 2002:a17:906:2711:b0:92f:13b9:d498 with SMTP id z17-20020a170906271100b0092f13b9d498mr9311459ejc.36.1679560999200;
        Thu, 23 Mar 2023 01:43:19 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id cd11-20020a170906b34b00b0093009bc5825sm8387342ejb.2.2023.03.23.01.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:43:18 -0700 (PDT)
Message-ID: <f01fc758-93a5-6f43-4575-11f08adcc553@linaro.org>
Date:   Thu, 23 Mar 2023 08:43:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/4] nvmem: layouts: Create a macro to register drivers
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2023 16:58, Miquel Raynal wrote:
> Hello Srinivas,
> 
> Following your former review, here are a few changes creating and using
> a macro to simplify nvmem layout driver registration.
> 
> While doing that I figured out the MODULE_ALIAS() macro in the Onie TLV
> driver was useless and wrong, so there is a patch to drop it, but if you
> wish you can also squash it with:
> "nvmem: layouts: onie-tlv: Add new layout driver".
> 
> Thanks!
> Miquèl
> 
> Changes in v2:
> * First patch now includes driver.h as reported by Rafal.
> 
> Miquel Raynal (4):
>    nvmem: Add macro to register nvmem layout drivers
>    nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
>    nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
>    nvmem: layouts: onie-tlv: Drop wrong module alias

Applied thanks,

--srini

> 
>   drivers/nvmem/layouts/onie-tlv.c | 15 +--------------
>   drivers/nvmem/layouts/sl28vpd.c  | 14 +-------------
>   include/linux/nvmem-provider.h   |  6 ++++++
>   3 files changed, 8 insertions(+), 27 deletions(-)
> 
