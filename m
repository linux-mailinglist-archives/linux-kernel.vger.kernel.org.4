Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5C61ECEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKGIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKGIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:31:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35691400D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EBD360F2F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29537C433D7;
        Mon,  7 Nov 2022 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809871;
        bh=SXaMq7XgLY8aBlYPIo1uopSs8Oc3lioDXEO/2P56rXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ziz8TJBpB/oa0/Tlj1HshNIu5rZ4O8sY+k6G4qRPSeUxDM2KKp+fzkWD4YEpVnznv
         QcYwzzj+/CF7og0CTg8XRtkz8LYKTIr2LpDWCRRqyUApoJpPT8uruJg6D5QZ6qYVpB
         dj0wKtmCmyTISL36Sbymk+RsAd7pjzDVG3diob9h6uiORkzRoZcv0o0mev7Dg/hbbw
         04HRyJ9IXkhJe25ut6n9ySZR3j7XZSGqBMlAuCHMIHezAoEkbfOuqXa2uL/Mvkbc8J
         ZwV4LKmkM4yBcRsaaQLWBCJ3Yd9Sbjba+ccv38end6W+hwsqRgstIRro//TAzE43tc
         hjqrYmT9MPDhQ==
Date:   Mon, 7 Nov 2022 08:31:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mfd: intel_soc_pmic: allow COMPILE_TEST or
 I2C_DESIGNWARE_PLATFORM
Message-ID: <Y2jCS/qfYibpOlG9@google.com>
References: <20221101055433.16891-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101055433.16891-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Randy Dunlap wrote:

> Linus expressed a desire to have intel_soc_pmic_crc.o (INTEL_SOC_PMIC,
> for Crystal Cove) be built on an "allmodconfig" build, when
> I2C_DESIGNWARE_PLATFORM=m, to enhance build test coverage.
> 
> The PMIC driver won't work in this case since it requires
> I2C_DESIGNWARE_PLATFORM=y to operate properly, but adding
> "|| COMPILE_TEST" does improve the build test coverage.
> 
> Link: https://lore.kernel.org/all/CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com/
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  drivers/mfd/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
