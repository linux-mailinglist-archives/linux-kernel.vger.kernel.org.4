Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676FF64BAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiLMRKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiLMRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:10:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CC66B10;
        Tue, 13 Dec 2022 09:10:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07392F4;
        Tue, 13 Dec 2022 09:10:45 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5B03F5A1;
        Tue, 13 Dec 2022 09:10:04 -0800 (PST)
Date:   Tue, 13 Dec 2022 17:10:02 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to e1d7dc52c3e6 ("ARM: dts: suniv:
 f1c100s: add CIR DT node")
Message-ID: <20221213171002.23c8c712@donnerap.cambridge.arm.com>
In-Reply-To: <Y5hZcmnZHsgpv3Pu@debian>
References: <Y5hZcmnZHsgpv3Pu@debian>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 10:52:34 +0000
"Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com> wrote:

Hi Sudip,

thanks for the heads up.

> The latest mainline kernel branch fails to build arm allmodconfig and
> multi_v5_defconfig with the error:
> 
> Error: arch/arm/boot/dts/suniv-f1c100s.dtsi:250.30-31 syntax error
> FATAL ERROR: Unable to parse input tree

This is because the clock patch hasn't reached Linus' tree yet, as it's
coming from a different branch:
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=sunxi/clk-for-6.2

In the original series I had it in the right order, but I guess the single
line to add the "CLK_IR" symbol should have been in a separate patch and
gone along with the DT patches.
Anyway it should magically solve itself in the next hours/days, I guess.

Cheers,
Andre


> git bisect pointed to e1d7dc52c3e6 ("ARM: dts: suniv: f1c100s: add CIR DT node")
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> 

