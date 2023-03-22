Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C626C5231
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVRTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:18:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0D12048;
        Wed, 22 Mar 2023 10:18:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 59so6704688qva.11;
        Wed, 22 Mar 2023 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505506;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRTvs40VdXDncOuhkXyv5eYNQBnzAzdM6lr9TY/as18=;
        b=ZUgFFDe0ehLKesB9SUDFEl9uZROHGbPT7Y2FXa/bn3dq6jfDiSD/zCmJRBYY+ApX/N
         dZNbK+CrjOp7CboTGl22bqzs001lX3iL69gvl7TnF3adZOxV6R3FjpJdGLkerPuTZZZe
         hSyshBbRFkPJO6rI8sHiVIS/WUIrWIzZf8lnWUiy3Z9TeLBVQUL8zN1uFmN1VkYynJAl
         o+zzWxojSqQ/4hIB2vXZVBQNvl+ycLg8BYblhp5qZELx2SXKbFNOg5QSvETM75GmijsU
         PM6k0+AhxtqAj2/XBg/pthPoFUaQ5ZO7qzLDbnYVC+GyKzL4k8GfGqQ/XVf+Eg7Xex2W
         qB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505506;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRTvs40VdXDncOuhkXyv5eYNQBnzAzdM6lr9TY/as18=;
        b=AHUTsVrK+oURQYHawqXXhYVnzN2omsXZrf1PWQmpU7e7WYPENF3U67vzmWZdOjhM+U
         OVg2vQpj3Hvld3M4wdQKRPMLdtXBg2psIVNS+IU+iei2IsCP4fMKhCxhvtx27XmOM0ju
         nlCJShDAF+S3GZUnlCPSGfURDFWPxIgHNfl6c8Z5IkhzqDyXF3gD/XbV1P8fHbsQOlVF
         MBn8Jc0ic3qojHciqjHea2z17JtQ1b8t0wozlmmoveF5+UELGsIwXH1SZ5e2IveLUHj8
         a+bG/zJ5OjPoOOUeKS9/CusYz1jCLO3gOaa4XN7WLNt8ekg4ctNuIsDviNf7/+sy2SKN
         ZP9g==
X-Gm-Message-State: AO0yUKU5WXjfYLzlTctKLdqV8o0qt5xRNKOMeea5khJlewU8N/0CU8Em
        +CY3cFw+j4gCGs6HY2IfZK8=
X-Google-Smtp-Source: AK7set8j8oLgm00l5AmFzb6jpLprx4l21D23G4FUkEfNrIT4nqIcuu/yPG+xQnOPkJVC6MOEe4bwvg==
X-Received: by 2002:a05:6214:2025:b0:5a7:e9e4:5010 with SMTP id 5-20020a056214202500b005a7e9e45010mr9000518qvf.14.1679505505905;
        Wed, 22 Mar 2023 10:18:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e11-20020a05620a014b00b0074669eddb05sm2982212qkn.68.2023.03.22.10.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:18:24 -0700 (PDT)
Message-ID: <d84a84d7-f065-8ac6-fb21-20a0c9af6c14@gmail.com>
Date:   Wed, 22 Mar 2023 10:18:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset
 driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, william.zhang@broadcom.com,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
 <20230321201022.1052743-1-noltari@gmail.com>
 <20230321201022.1052743-5-noltari@gmail.com>
 <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org>
 <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com>
 <d06781c905adb23089a85a8d54b94461.sboyd@kernel.org>
 <302bb0c4-a31e-7025-26d6-21c8d473f370@gmail.com>
 <896d16997cf3d308eff0cb8ce8596fc3.sboyd@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <896d16997cf3d308eff0cb8ce8596fc3.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 16:23, Stephen Boyd wrote:
> Quoting Florian Fainelli (2023-03-21 16:09:54)
>> On 3/21/23 16:06, Stephen Boyd wrote:
>>> Quoting Florian Fainelli (2023-03-21 16:00:29)
>>>>
>>>> These SoCs are big-endian, require native endian register access and
>>>> have no posted writes within their bus logic (UBUS) and require no
>>>> barriers, hence the use of __raw_readl() and __raw_writel() is adequate.
>>>>
>>>
>>> Use ioread32be() then?
>>
>> BCM63xx drivers tend to use __raw_{read,write}l for consistency and to
>> make it clear that no barriers, no endian swapping is necessary, I would
>> prefer to remain consistent with that convention.
> 
> Ok.
> 
> Is the clk device big-endian? Or the CPU is big-endian? SoC being
> big-endian sounds like the devices in the SoC are big-endian. I hope we
> never plop this device down with a CPU that's litle-endian.

The CPU is big endian and the peripheral and bus to access the 
peripheral are native endian, so also big endian in that case.

The newer SoCs are ARM-based and are little endian, but we already have 
a clock driver for those.
-- 
Florian

