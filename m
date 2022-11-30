Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8463D1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiK3Jcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiK3Jbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3DB5915A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqq5gTcz4xZl;
        Wed, 30 Nov 2022 20:31:35 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <YzKSLcrYmV5kjyeX@google.com>
References: <YzKSLcrYmV5kjyeX@google.com>
Subject: Re: [PATCH] powerpc/warp: switch to using gpiod API
Message-Id: <166980023651.3017288.11616818512076872736.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 23:03:25 -0700, Dmitry Torokhov wrote:
> This switches PIKA Warp away from legacy gpio API and to newer gpiod
> API, so that we can eventually deprecate the former.
> 
> Because LEDs are normally driven by leds-gpio driver, but the
> platform code also wants to access the LEDs during thermal shutdown,
> and gpiod API does not allow locating GPIO without requesting it,
> the platform code is now responsible for locating GPIOs through device
> tree and requesting them. It then constructs platform data for
> leds-gpio platform device and registers it. This allows platform
> code to retain access to LED GPIO descriptors and use them when needed.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/warp: switch to using gpiod API
      https://git.kernel.org/powerpc/c/1892e87a3e9170146549779622cb844582f1e2bb

cheers
