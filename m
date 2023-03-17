Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC896BF01C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCQRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCQRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EFAC8319;
        Fri, 17 Mar 2023 10:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD7760F85;
        Fri, 17 Mar 2023 17:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DFFC433EF;
        Fri, 17 Mar 2023 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075277;
        bh=+kGC7FbC9kl4Uk9kpXxBRDWJCgeiHeBHPRPimywbtMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0/kQS9q37VRCcmxsnhRngTuthe7jfLxnqAZEsV0LTiuO7b73aKJZECZL+Z0+r507
         dOyKg3KaMlPWglXDtmmkTaPR/xhKYBl1OWOPNU2rJUFe7pBj4y81pymOMpHAXBoa/z
         sURuYsc+LWxQzwbroiWOfKkWpmEatH2noS/sR3sym6cb3ENQY2Kdxy0iZG1R+b4zdB
         pjLbJn4yRhA+t25iQwuzt3ngqb2XryPpzw+c58pd7hAg92kFNLUZYnyO006cjdfLG+
         piBnpSnnWSXgWTRx4cvbGf8b0/+RBkEqj+a6kjZwjRN6wBy3V2LVhbs3iUefHSl9Mr
         LCOX7Ixh/Dg5g==
Date:   Fri, 17 Mar 2023 23:17:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 13/15] dt-bindings: dma: apple,admac: Add t8112-admac
 compatible
Message-ID: <ZBSnybiX5c9oWe7X@matsya>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
 <20230202-asahi-t8112-dt-v3-13-d1a5f6383d95@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-asahi-t8112-dt-v3-13-d1a5f6383d95@jannau.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-23, 13:10, Janne Grunau wrote:
> The block found on Apple's M2 SoC is compatible with the existing driver
> so add its per-SoC compatible.

Applied, thanks

-- 
~Vinod
