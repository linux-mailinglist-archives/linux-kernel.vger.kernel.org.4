Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5695A720EC2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjFCIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjFCIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 04:25:46 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913CE58;
        Sat,  3 Jun 2023 01:25:44 -0700 (PDT)
Received: from g550jk.localnet (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3B308CFC2A;
        Sat,  3 Jun 2023 08:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685780712; bh=NwmIoq/BviZL8sy63sRYrGyMTJQYkX5Kw2FgJgZF01s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YMkrvc9tWXOzWyX+8ewERFWrN8YH2eLM2UmtB0do+Afqtcn2RuULZlHtFNx17SDrI
         XjhtAlCOw7wGLhACERpIx/v+4AsQ9Y8dVQ8LXlyIaLH9/BVK2Y5uKGyaEWRf9lfo35
         A9yCHkTSWqErRHwYE5Ww4m0uIO3ZcSKm9A2Gl+jw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     open list <linux-kernel@vger.kernel.org>,
        Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list : LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list : OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [RESEND PATCH 0/2] leds: sgm3140: Add richtek,rt5033-led compatible
Date:   Sat, 03 Jun 2023 10:25:10 +0200
Message-ID: <5422230.31r3eYUQgx@z3ntu.xyz>
In-Reply-To: <20230602133533.260502-1-raymondhackley@protonmail.com>
References: <20230602133533.260502-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raymond,

On Freitag, 2. Juni 2023 15:36:16 CEST Raymond Hackley wrote:
> Richtek's rt5033-led has pin configurations similar to sgm3140.
> Add it to the compatible list.

please fix your email setup so that patches also sent to public mailing lists 
don't get *encrypted*. This is completely pointless and just makes everything 
more difficult.

Regards
Luca


