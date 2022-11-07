Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B961F734
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiKGPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiKGPKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:10:00 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF11DDE0;
        Mon,  7 Nov 2022 07:09:58 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id c8so8251102qvn.10;
        Mon, 07 Nov 2022 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xcR9lfWxQYYggutBYXX8jFDllzL5dvH/OMCsAac2+rw=;
        b=AcAy4kj7xO7cxMUOheawQ40hciY65r2N0nwsNhsKmei8MAsBW05Y2mZXSzvF3iKLTL
         RZPpjGzhVEJXVKYELaR499rXN4uWVp7jKPzuSgHdhLTKb4ZGgHZ38+K5TOe6DXywhqfB
         kkagoojERWS6DOKPTyUYlBhXDi8wK3ZSStt6DnDL1n745Ky+gE64pzVvaNahmgECY+eM
         sc8FRKWkwH1Yzfh33NBpVz4R3hMefG5ax+XM1wHJkydVlnpe/p26SnOXEGVt072V0Icf
         ib3Egmk6Hhq9CYGt3+o7RFiN68F/upDfNYSxSPJp5wihuo9BRZSzLZAXWGySTIjuJ3Eo
         xD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcR9lfWxQYYggutBYXX8jFDllzL5dvH/OMCsAac2+rw=;
        b=rIQFpb+7JyRhlSZ6t8M3NFOY+8XVbL9f2XDgD6fbT9Z3NShyJtjfTwnGSFnStf/vHO
         WHoC11FRkqAUuFyLrZ5nUcfxVg7a4/tXnFOA+g2uT22o3bMhN5ISVoCr4xNb+qpzROa/
         NNnXQIURoVek/hCPvbZ2oWLSIELOsW2GPbFJcCwj3GRTT28PxzylttP+l3IZ7bvwN7QU
         +QhoSK7y1bQW2jSivEpc9t+5UkUgVhdEN6tUHerlTV0ZOcydhGADQvudHoGf0LR2OnGt
         6xZHGCOT5N4LZ1tD287G9A8dYmZYqyUs4CWODWQ7+9CkFOd9GyvjWeC+fHG2q8iAR8X9
         aeAQ==
X-Gm-Message-State: ACrzQf3vBmpeyMS+0t5+gSvoXnFeBvIFxgcD12x4PmMrQb+I+Mbfu+Qm
        gW23gdtYN3VVBiip3AWmmWQ=
X-Google-Smtp-Source: AMsMyM6aAFJE1en6KQCXeSWQDoqCPBynXxktK9qfeKbN5Zs3+uBYUavcNlBG6peXGVBkshXgPkVDlg==
X-Received: by 2002:a05:6214:19ea:b0:4bc:1388:8d7c with SMTP id q10-20020a05621419ea00b004bc13888d7cmr30781708qvc.84.1667833797183;
        Mon, 07 Nov 2022 07:09:57 -0800 (PST)
Received: from [10.248.12.149] ([129.63.248.1])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a441600b006eeaf9160d6sm7169680qkp.24.2022.11.07.07.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:09:56 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
Message-ID: <ef5d4f48-71b9-2d5c-37f4-7a029a32a41b@gmail.com>
Date:   Mon, 7 Nov 2022 10:09:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 7/7] ARM: dts: imx: Update i.MXRT1050.dtsi compatibles
To:     Arnd Bergmann <arnd@arndb.de>, NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, aisheng.dong@nxp.com,
        stefan@agner.ch, Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>, abel.vesa@nxp.com,
        dev@lynxeye.de, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
 <20221107071511.2764628-8-Mr.Bossman075@gmail.com>
 <d293e410-223d-4baa-ba6d-65bc11ab1e55@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <d293e410-223d-4baa-ba6d-65bc11ab1e55@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/22 02:44, Arnd Bergmann wrote:
> On Mon, Nov 7, 2022, at 08:15, Jesse Taube wrote:
>> Remove unused compatibles from i.MXRT1050.dtsi.
>> Change GPT clock-names to match documentation.
>>
>> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> 
> Can you make sure your changelog texts explain why you do this?
Yes, sorry I wasn't clear.
> Are they fundamentally different from the devices you had
> claimed to be compatible with that need a different driver,
UART and SDHC had drivers added which are better fit.
The GPT binds to imx6dl which is also the same as imx6sl.
> or are there drivers in the field that bind to the wrong
> string first?
I don't understand?

Thanks,
Jesse Taube
> 
>        Arnd
