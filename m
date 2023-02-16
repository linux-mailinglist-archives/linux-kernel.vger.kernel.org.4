Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D700698F19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:55:03 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C5E3B3E7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:55:01 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DDACE2402CD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1676537699; bh=CdZyo6JjpXiyHzEMPe2wM0kSGNglA5FAaZGZKnEZChU=;
        h=Date:From:To:Cc:Subject:From;
        b=akvlP+baPY54hFTe8mhaLsQDpW7Q0HkLtOhiZUwaqOd5CffXSBd/wBAWdbY4tTjUn
         Wg/KgfJ404RrC3YrPy6XwgjoIx2jMysE+GhJ1BBb/RSBYFH5czIwxDhwkOrZ50yL7W
         CG4VQrswEwREMDPI+c0/j67huYtAAjqMyMBDCiKlcyjw7d1h5iYi79wJlAVd9CziZ+
         cUHwSnFRFBSfShfvkxN6hQsE6mX5SHFNlq0Sek7g3i5PonEmfK8kUbCXVP74OqL0af
         YJ8pmWwLvXsVtqUZUe4QwvMQc25zjJg2rQlxRLL7m3RV6UQZrP61jPmJ21ywADTFAB
         fX8/Mwc7NWEyg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PHTKW4zcRz6tm5;
        Thu, 16 Feb 2023 09:54:55 +0100 (CET)
Date:   Thu, 16 Feb 2023 08:54:54 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: hwlock: sun6i: Add missing names
Message-ID: <20230216095454.54f4d5ca@posteo.net>
In-Reply-To: <a2d10295-d9eb-cd1f-8f48-b61f97487208@linaro.org>
References: <20230215203711.6293-1-bage@debian.org>
        <20230215203711.6293-4-bage@debian.org>
        <a2d10295-d9eb-cd1f-8f48-b61f97487208@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 09:36:08 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 15/02/2023 21:37, Bastian Germann wrote:
> > The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names and
> > reset-names set to "ahb" as required by the Linux driver.
> > 
> > Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock") 
> > Signed-off-by: Bastian Germann <bage@debian.org>
> 
> With new data, I changed my opinion and NAKed this. Still NAK, sorry.
> Please drop the clock/reset-names from the driver (use indices) and DTS.

I won't be able to fix this in the next time. I'm currently in the state of
moving and can't set up my hardware to test the changes. And I'm not willing
to submit changes without testing. And with testing I really mean testing it
against a running Crust firmware which touches the hwspinlock unit.

If someone wants to change that, I'm happy to see it working out, but please
do it properly. Just testing the locks in Linux only is not sufficient. If
some directions are required, I still have my working repo up at Github:
https://github.com/wgottwalt/sunxi_hwspinlock
It may be a bit dated, but should be a good start.

Greetings,
Will
