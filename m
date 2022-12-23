Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279765511D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiLWN4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:56:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934901CB08;
        Fri, 23 Dec 2022 05:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55CE261159;
        Fri, 23 Dec 2022 13:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F27C433EF;
        Fri, 23 Dec 2022 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671803759;
        bh=673eVZdC/GfX58ysM7w07tKQFUlrVkDiUm1PIYoKdyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/BSCjqu7hg/K4pc9tGtSy5rj1eAsp/A0zlbfM9o2MyP0/KjV/BX9Im2n+dPMwVJI
         P+49aq0ThJXmB5B43mx8ze3bxvF9GLLmLdX3PJeuzUCCf5+mhh2THbUGg3b3zoZfhG
         wTm2ri9pZx1bQ7SHg1YXk5H1CB7zrQF+HoaMHUPr26/bfIYO80ZmKCXYHkFKqbhJm4
         s/GvZBtSO+ABiMus38wuIwBr4rvfKcPkZTbPhaAQS8zX2htjOtDc9P/8w8RByM577/
         LdRoBUmKQyYRwvygeLXJLRFyQGQAssqss7TBNBmfCx+VeQ04oHqnnfFcgccQL5udVy
         Z53SN6+oTXJoQ==
Date:   Fri, 23 Dec 2022 14:09:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: add ADS7924
Message-ID: <20221223140908.3b4a5458@jic23-huawei>
In-Reply-To: <01a5f912-10d2-d5fe-023e-e2e6613ac03b@linaro.org>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-4-hugo@hugovil.com>
        <01a5f912-10d2-d5fe-023e-e2e6613ac03b@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > +    description:
> > +      Child nodes needed for each channel that the platform uses.  
> 
> I cannot understand this sentence at all. Instead describe the hardware
> you are here representing. What's this?

Needs rewording, but basically - "Which pins are connected to anything?"


