Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AC6E9A41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDTRFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjDTRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF9D2;
        Thu, 20 Apr 2023 10:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE45F60EDF;
        Thu, 20 Apr 2023 17:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DACC433D2;
        Thu, 20 Apr 2023 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682010301;
        bh=l1TvL8OQdBavurwxDnbzlunPMrvFhKPpWvlZWHCIJ1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+QMus2rDlnVPcrRRoWKNDM+23YVIIkNirhXKyPWUiSxOiyWJjMr08ficsZIv1zYE
         yf7aeyhUZ4g+W8Fcnjy10lKAp88V8ZefY9TJnqRzm9VEAYesehjYylC7bLq+fHzRct
         x4DlX0ehxz50yhw0AZVg5s6wSCF2drrVPqX9WP5BEZvbjuVOpXXJcXrk3DZmS/NmrC
         1jufINtZhfAAudfIP2VlqulP0U6Mw8nnMcTxv+AbP+hKiOcu5kLObQro7mddVCVGG4
         1b21tflgrhXmwaA4h3Lusm3HmuylI1IzVOmJXkBrAyNcuzSItdU8aWcdz+BNsDcUWa
         UgbnI4W2CPQrQ==
From:   Will Deacon <will@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: delete dead code in this_cpu_set_vectors()
Date:   Thu, 20 Apr 2023 18:04:52 +0100
Message-Id: <168198389444.147011.7790274772825720678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <73859c9e-dea0-4764-bf01-7ae694fa2e37@kili.mountain>
References: <73859c9e-dea0-4764-bf01-7ae694fa2e37@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 10:58:43 +0300, Dan Carpenter wrote:
> The "slot" variable is an enum, and in this context it is an unsigned
> int.  So the type means it can never be negative and also we never pass
> invalid data to this function.  If something did pass invalid data then
> this check would be insufficient protection.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: delete dead code in this_cpu_set_vectors()
      https://git.kernel.org/arm64/c/460e70e2dc9a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
