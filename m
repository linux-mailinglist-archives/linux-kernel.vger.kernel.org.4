Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EB6E4791
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDQMXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDQMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:23:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333CA24D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:22:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id he13so18687140wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681734148; x=1684326148;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GpPv8TbW/XqQuqppUwW1L792LLCC3Tsu8M2+sdbbC7s=;
        b=vpSs4v+IA0RiYibodoWmmDArq/vqtfaPxJ4BDYmNiGZ/DyU1/jQtU2MIudsgjEbpkP
         vmm5p38CVTb1XujeTL10+G2LSP47XQwPQ1fMNYGRMu35oty5IGAyKxsTJBMp2oB1Om0t
         3CuQD2RuHjIFUvXTz4xWfLg+Z2KqbKNfirW9rebsKzYIwyR+ef4zZIAxM+jcLnDEVLze
         MfL31J4IQYwXj5VjLppcu2K/eamStsfbhu60trHQHvXEYPm02W/2cQSP19+P+L06CcYh
         dR+kVPqcZBcWgX/0dpuAY1gYFP7JOpx/ghcd/ofoKnOB6UxO0QehB1b67g2bubMajjgJ
         7GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734148; x=1684326148;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpPv8TbW/XqQuqppUwW1L792LLCC3Tsu8M2+sdbbC7s=;
        b=EM7Qq0anqtKfnQQ3UHtWY0wJmjI4R8F4nOPPvVY2Twyzo2N2NW3oFRGV2EbLya1djn
         /kQHFztKZ728umTNlYeC9MKlgNG0+Ih9LxZnBuOj/emtMWGw8GlUZUFVpin+6MhHbTmJ
         S+7tOcDk9juc7n0afZcnJlatiGifaMiapbjI0V5qFXBLNZfnFczlRJQ46+q+RufpIqsV
         hfPCym/0l3CNQ/LZvNP6afpJjEQFCbsXSZttAUoCNEF/fXDSuYerCkKA+fpE5y8+GFIA
         0XNvPpZsXCoPxlL0SUTpxyFvR9dOc/udYi2AKvQld/fyEFog0GuysUgilMPgu6pkinRJ
         mk2Q==
X-Gm-Message-State: AAQBX9dqPU8qdA8sf7Dp1vYGPidCzT3OAdIzK+a0VOiFdBp1YBXiIb1j
        TWXCNjdTZr39bdIZkLv75zxe0w==
X-Google-Smtp-Source: AKy350YXplpLiXH1U/KWH1eLlC26VmSY78UY7wMpyE9cn9n4QPI+RTov28Xcm2JKaX4/y00ORb3uQw==
X-Received: by 2002:a7b:c5c8:0:b0:3f1:6b26:68b7 with SMTP id n8-20020a7bc5c8000000b003f16b2668b7mr4938232wmk.4.1681734148630;
        Mon, 17 Apr 2023 05:22:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a1e1:81a8:1acc:2b91? ([2a01:e0a:982:cbb0:a1e1:81a8:1acc:2b91])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b003f092f0e0a0sm19645415wmo.3.2023.04.17.05.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 05:22:28 -0700 (PDT)
Message-ID: <3381d124-1049-16da-bcdb-1cbbec379154@linaro.org>
Date:   Mon, 17 Apr 2023 14:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/5] usb: dwc3-meson-g12a: support OTG switch
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, mturquette@baylibre.com, vkoul@kernel.org,
        kishon@kernel.org, hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
 <20230414152423.19842-5-ddrokosov@sberdevices.ru>
 <CAFBinCDyUBWd-V0mDy_edzH=3JM5SAuX=vtT4MG9Fb62Rcv=mA@mail.gmail.com>
 <20230417114739.r7aoiodqybalbn4o@CAB-WSD-L081021>
Organization: Linaro Developer Services
In-Reply-To: <20230417114739.r7aoiodqybalbn4o@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 13:47, Dmitry Rokosov wrote:
> Hello Martin,
> 
> Thank you for quick review, appreciate it!
> Please find my comments below and in the other replies.
> 
> On Sun, Apr 16, 2023 at 10:56:36PM +0200, Martin Blumenstingl wrote:
>> On Fri, Apr 14, 2023 at 5:24 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>> [...]
>>>   static const struct dwc3_meson_g12a_drvdata a1_drvdata = {
>>> -       .otg_switch_supported = false,
>>> +       .otg_switch_supported = true,
>> it would be great if you could also follow up with a patch that
>> removes otg_switch_supported.
>> A1 was the only variant that needed it and after this patch it's just dead code.
> 
> It makes sense. I thought about it before sending the first version, but
> I found a counter-argument: future SoCs may use this parameter.
> But if you ask, I will remove 'otg_switch_supported' in the next version
> 

Please remove it, it's easy to add it again if needed.

Neil
