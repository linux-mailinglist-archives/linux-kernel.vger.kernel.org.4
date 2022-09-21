Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC59E5BFD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIUMEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A2C3D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03BD6B82668
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636A0C433D6;
        Wed, 21 Sep 2022 12:04:26 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/sysreg: Fix a few missed conversions
Date:   Wed, 21 Sep 2022 13:04:23 +0100
Message-Id: <166376185932.3535484.17336911929648447686.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220919160928.3905780-1-nathan@kernel.org>
References: <20220919160928.3905780-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 09:09:28 -0700, Nathan Chancellor wrote:
> After the conversion to automatically generating the ID_AA64DFR0_EL1
> definition names, the build fails in a few different places because some
> of the definitions were not changed to their new names along the way.
> Update the names to resolve the build errors.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Fix a few missed conversions
      https://git.kernel.org/arm64/c/db74cd6337d2

-- 
Catalin

