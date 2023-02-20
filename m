Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6169C49C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBTDvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjBTDvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:51:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA71CA36
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:51:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKpPq0f4Hz4x8b;
        Mon, 20 Feb 2023 14:51:43 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Chancellor <nathan@kernel.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@lists.linux.dev
In-Reply-To: <20230215-windfarm-wsingle-bit-bitfield-constant-conversion-v1-1-26415072e855@kernel.org>
References: <20230215-windfarm-wsingle-bit-bitfield-constant-conversion-v1-1-26415072e855@kernel.org>
Subject: Re: [PATCH] macintosh: windfarm: Use unsigned type for 1-bit bitfields
Message-Id: <167686495882.2406274.8062976789775517076.b4-ty@ellerman.id.au>
Date:   Mon, 20 Feb 2023 14:49:18 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 10:12:12 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/macintosh/windfarm_lm75_sensor.c:63:14: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                   lm->inited = 1;
>                              ^ ~
> 
>   drivers/macintosh/windfarm_smu_sensors.c:356:19: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                   pow->fake_volts = 1;
>                                   ^ ~
>   drivers/macintosh/windfarm_smu_sensors.c:368:18: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                   pow->quadratic = 1;
>                                  ^ ~
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh: windfarm: Use unsigned type for 1-bit bitfields
      https://git.kernel.org/powerpc/c/748ea32d2dbd813d3bd958117bde5191182f909a

cheers
