Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288835E5BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiIVGwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIVGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:52:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB5B2DB7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:52:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so13125932lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=R4By1A4vsqkhsX1zQ9Pp9D5cDY7oXVIoxYX95+DT5PE=;
        b=tTATpAtRVwjlDYTCT7pL1pRJbq5m1acku+1Ba7Zt53sySs6UkSNrUaB0GLEOrrFETm
         9G+iZtHyPR6SvFXlXV2hcpvCw5gr9fSriZL7EMWe9I5UyUJ4cHdctXvAQHMWiwYS6uEk
         Qxel41eu2KSTH4QJp9KIBjN6mZz8rZYGYZxRNlURYri7cxs4SptLwa7H2ncezI86NorG
         wrAWseYtHfxWGryE/asWzRiw8bohgI3b3IRIAch0x6RE4u4C1c5u3TX2ZAr8s1rreqrG
         cET7sqTGbNafXUKexSsxYPGdCVE8O1ZtqH79YslvG1W5Jj+aDQcuBnB+eJ3VpzbGAQQ5
         w85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R4By1A4vsqkhsX1zQ9Pp9D5cDY7oXVIoxYX95+DT5PE=;
        b=yzlNROcnY1YBqUz13YitVf8pmRr35O2s316EBjI1k52CDkzPaJem0+hC/xNTIEf7hF
         NhWnwYrrExja5lF/ZBS+PcEQ4/iLnFqcUe0NwpxV9DusyaR+WQKzKMsMCVTIFVP7LMX9
         3BcEKx9POknnxh8BlMVT/QOsDdLorjkJK8/SNiumi9ApCAF6E3vFbVGqvuKuMW2ROee5
         gHkmX6L17+7XWkiCGZ91+eZAkgi4shOTrG10Z0DJsmEv5zVQR1trhuTwxJxyIKsRQjA/
         OjS9T6QofOhQvHgvJqqsAxB0V3Sb/tS+ArOOqwqzTxpoMK7fU/uEFqNNoVhLnCCDMlaV
         xo0w==
X-Gm-Message-State: ACrzQf2EFLEGdPhfiD8rlPNPr5mj8m9u2GVoFnk4EqawDBckci6uxRNw
        TmVu/6HAwAY7z/T43FZgE3qWbw==
X-Google-Smtp-Source: AMsMyM44wyfp1zLUX8FNiyQhFVz7FEelPJEjwbKiOGbAcJVd0bCqI3GEzVjpnk4pR++aYr0d+UdfqA==
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id i3-20020a056512318300b00498fa2935femr645077lfe.523.1663829531533;
        Wed, 21 Sep 2022 23:52:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 1-20020ac25f01000000b0049f5358062dsm786705lfq.98.2022.09.21.23.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:52:11 -0700 (PDT)
Message-ID: <6f727f9b-aa1a-3eba-87ec-3e36eeb15351@linaro.org>
Date:   Thu, 22 Sep 2022 08:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add AMD DaytonaX BMC
Content-Language: en-US
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-3-aladyshev22@gmail.com>
 <CACSj6VWg+QfSYqeeUR5vtgJFLJg5us5-=D_Esj5NK-uvtH2B3g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACSj6VWg+QfSYqeeUR5vtgJFLJg5us5-=D_Esj5NK-uvtH2B3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 23:15, Konstantin Aladyshev wrote:
> Sorry, I still have some questions, can you please help me?
> 
> I work with kernel in the context of the OpenBMC project, and it is
> not possible to run 'make dtbs_check' in the linux kernel devshell
> (Yocto). So I've tried to download upstream kernel and have performed
> the following commands to make the dtbs_check:
> ```
> $ make ARCH=arm aspeed_g5_defconfig && make ARCH=arm dtbs_check
> ```
> This gave me a ton of output regarding all the problems in all of the
> aspeed boards. 'wc -l' says that the log file is about 7080 lines
> long. Is it possible to get the output only for my target DTS? The
> article that you've referred to
> (https://www.kernel.org/doc/Documentation/devicetree/writing-schema.rst)
> only have the information about how to run checks against one schema
> (DT_SCHEMA_FILES), but it is not the same thing.

You can limit it per target. See slide 11:
https://osseu2022.sched.com/event/15z0W

This might miss some warnings, so better way is to:
make ARCH=arm dtbs_check
touch your-dts
make ARCH=arm dtbs_check

You will get only your errors.

> 
> I've manually tried to split the output regarding my DTS file, but
> even so the output is overwhelming - https://pastebin.com/b92rnBt0. I
> just don't understand if the mentioned things are about the common
> "aspeed-g5.dtsi" file that I should ignore or the things regarding
> errors in my submitted DTS file. Can you give me some advice on that?

Yes, you can ignore errors from dtsi.

Best regards,
Krzysztof

