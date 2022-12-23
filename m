Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3502F655360
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiLWR42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:56:25 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4311C1BEA9;
        Fri, 23 Dec 2022 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5tyPCZzSf4fJF+O4ymtoHkWVf8rcASMcDBrCq5a8OMQ=; b=zEDelKH6Vhu+vv0S4WXkVMCVqi
        73AmPD/hDUGQQXoPo3EbZvvu2XqCYPfaXaIys3k4qDmPfOljTx30+o2voz3zLy/bIo+S+cw13WQbC
        vgb1jRdBDv2Mq5ocaw63REvfUA5SY7ahu9lB0gRGAriIztYi4GxiG9ndT8Ey54ZrIcBg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48998 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8mHI-0003Bs-3Y; Fri, 23 Dec 2022 12:56:16 -0500
Date:   Fri, 23 Dec 2022 12:56:15 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20221223125615.4932b8ac2a8d0cf82b4807e8@hugovil.com>
In-Reply-To: <20221223140908.3b4a5458@jic23-huawei>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-4-hugo@hugovil.com>
        <01a5f912-10d2-d5fe-023e-e2e6613ac03b@linaro.org>
        <20221223140908.3b4a5458@jic23-huawei>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: add ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 14:09:08 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > 
> > > +    description:
> > > +      Child nodes needed for each channel that the platform uses.  
> > 
> > I cannot understand this sentence at all. Instead describe the hardware
> > you are here representing. What's this?
> 
> Needs rewording, but basically - "Which pins are connected to anything?"

Hi Jonathan and Krzysztof,
when writing this driver a few months ago, I used as a starting point the C source file and the YAML file of the TI ADS1015 driver.

I cannot say that I fully understand the sentence myself :) So I will reword it.

I will also take care of the other dt-bindings comments for version 2.

Thank you for your feedback.

Hugo V.

-- 
Hugo Villeneuve <hugo@hugovil.com>
