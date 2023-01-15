Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5B66B3C2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAOULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOULu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:11:50 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78058C656;
        Sun, 15 Jan 2023 12:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cvNXeaeCC5O59TGsImznClAMJlVEir/QjNf7tHMV21g=; b=YgDLNPNTweV8YUE1WGXn5/IyeN
        IMygWskAvoJzgyilaqSQFWoMg4WZR5uv/hmqAKWX3GyXCootyk2TqWk2feqgAUXTBUvmzdLka7gxf
        WkWrlKIM8ut8Eo3Ls9pnmPZ2Hx47oJIAANPAOrhSLO8Tnk/aIMJIbBXCvOwRDH7D68oI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47782 helo=asus64.hugovil.com)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pH9Lw-0001ge-9v; Sun, 15 Jan 2023 15:11:40 -0500
Date:   Sun, 15 Jan 2023 15:11:39 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, hvilleneuve@dimonoff.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20230115151139.4056356363b5fcff6c42f3ea@hugovil.com>
In-Reply-To: <e30a869a-5585-901b-6a56-3e327e0cf60a@linaro.org>
References: <20230113194959.3276433-1-hugo@hugovil.com>
        <20230113194959.3276433-3-hugo@hugovil.com>
        <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
        <20230115112205.e46ab8d017b99dd987d003e4@hugovil.com>
        <20230115164326.7f03f6d9@jic23-huawei>
        <20230115113250.d8a0ec5a2638e24c1208539c@hugovil.com>
        <e30a869a-5585-901b-6a56-3e327e0cf60a@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2023 20:17:24 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 15/01/2023 17:32, Hugo Villeneuve wrote:
> >>>>> +    required:
> >>>>> +      - reg
> >>>>> +
> >>>>> +    additionalProperties: false  
> >>>>
> >>>> You are not allowing anything else from adc.yaml. Is it on purpose?  
> >>>
> >>> I am really not an expert with this Yaml stuff, and reading the documentation makes me probably more confused than before reading it :)
> >>>
> >>> But one thing that is for sure is that these other properties in adc.yaml are not used in my driver:
> >>>
> >>>   bipolar
> >>>   diff-channels
> >>>   settling-time-us
> >>>   oversampling-ratio
> >>>
> >>> So is it Ok then to use "additionalProperties: false"? I think so, but what is your recommandation?
> >>
> >> Makes sense to me.  Whilst there are lots of things a channel can support, most
> >> of them are hardware related and not universal.
> > 
> > Ok, I think I am finally beginning to see the light here :)
> > 
> > So I will then leave "additionalProperties: false".
> > 
> > I will send a V4 soon with all the latest changes.
> > 
> 
> Just to clarify - we talk about hardware, not your Linux driver. What
> your driver uses or doesn't, should not matter here that much.

Hi,
the following properties are definitely not supported by the hardware:
    bipolar
    diff-channels
    oversampling-ratio

does this means that we should add these lines?
    bipolar: false
    diff-channels: false
    oversampling-ratio: false

as for settling-time-us, I am not sure of its usage and if its related to this hardware.

Hugo.


> Best regards,
> Krzysztof
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
