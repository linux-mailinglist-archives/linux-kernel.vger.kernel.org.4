Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10386F199C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbjD1Ncs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbjD1Ncp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:32:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B6346BB;
        Fri, 28 Apr 2023 06:32:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a6f0d8cdfeso75793425ad.2;
        Fri, 28 Apr 2023 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682688763; x=1685280763;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ecf3y//8as8pmNBqc+FV/KL+yi6EQ2HAAYSLWqdkKMY=;
        b=S8lRCV5XNase7pRtd37xsGAZzTDD6LYZluEpOiqWveUN07ffsE754Ypw1bTZS8+Ri3
         iNhAND76FztYXHLw8cHxo3ZFPtOanPUx2/7cmTo1PIjXf3kFnF3wetAybVUNKAXg6mss
         nGJ8yinhECeQ0K0ehiocBmq9TSphAmxKsis/LJw7K1wKm4Kph/pweqWndZ15sk9oE6G6
         IFbL5zqrXNU6KQtDAOuPZ7X+qFAVE/uhXDcV9lNvwlv+RLTNtw+Toz7AbI9Q6aoQorDt
         nx9g+PL/PTf1t4Yy8SZwi1BCl+aAgxQnJgjlkNiVsyOwYt9WYWHtnY7xO+RDEE/HtGo2
         mQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688763; x=1685280763;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecf3y//8as8pmNBqc+FV/KL+yi6EQ2HAAYSLWqdkKMY=;
        b=grLy7fcAEBOhv79yQC1iwDj0+XZMGx4PeoWfYZBHDL0pJw1fzYZjHhV2USi7yvEc6O
         IO21u7rQ4s89i79lWaru48mm8iOLGFMlOmdhnJg8CzJWXudVc8aK02FaTMNgt0ZbvHGA
         PKwjNLxGawf2wOmyfAWdJH0MOhA/OYc4DVQ/NHmtln5vS7OzzNanBe84HAgKMjFGde/o
         D8j6ZuFZNdMZ2JreLO/pEvUJtJc3Qzg+Gy/ccKyFtYHtPta7c1NcYfgj26H5sp4n2M/U
         emaNQuv4oe2JipqApsyuq4UN8VNjlRv/n+l/3z6A9iu+7ytxQ5V+vE2lNqYzixIjDd2i
         Sgjw==
X-Gm-Message-State: AC+VfDygc2jNwMu8TIFdZSBIaIbFixSJeOvBnLCNGi0DirbIfWiYsXlZ
        T+6rV35YwPVYHlfBYVFlgHw=
X-Google-Smtp-Source: ACHHUZ6MuvKOGxaqrdszoikil1JyMqWsmcNZ0YJGxut2ugRIYmruVervYbpv5rJ01rxEqUYJPDjMrA==
X-Received: by 2002:a17:902:ec83:b0:1a6:f93a:a135 with SMTP id x3-20020a170902ec8300b001a6f93aa135mr5944888plg.61.1682688763155;
        Fri, 28 Apr 2023 06:32:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ab8500b001991f3d85acsm13241904plr.299.2023.04.28.06.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:32:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b0bbd842-2262-8979-d8f8-ec611310c44f@roeck-us.net>
Date:   Fri, 28 Apr 2023 06:32:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com>
 <c27e07d2-8eb1-16a8-4619-280967fc0de9@roeck-us.net>
 <DM4PR84MB1927C9D3C5CC5B001713CE57886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
In-Reply-To: <DM4PR84MB1927C9D3C5CC5B001713CE57886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 07:53, Hawkins, Nick wrote:
> 
> 
> 
>> This is not information which should be reported through a gpio driver.
>> Besides, the functions don't exist at this point in the series,
>> and there should be no extern declarations in source files.
> 
>> If you want to model fan or psu information through gpio, drop
>> the hwmon drivers and implement reading the status here, then use
>> the existing gpio-fan hwmon driver to report it in the hwmon subsystem.
> 
> Thank you for the feedback Guenter,
> 
> I see how it is possible to use gpio-fan for the fan. As for the gxp-psu
> Hwmon driver can I model the gpio-fan driver to get the necessary
> gpio information for power supplies?
> 

Sorry, I don't understand. Looking into the code again, the major problem
I see is that you want to model fan install status and fan fault
status as gpio pins. The same is true for psu information (installed,
ac, dc flags).

If you want to do this, fine, but then get the status from the gpio
driver and don't export anything to the gpio driver. The kernel supports
means to do that (look at gpiod_get and similar functions). It makes the
code more complex, but I assume you know what you are doing.

Guenter

