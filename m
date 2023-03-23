Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5316C69EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjCWNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCWNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:50:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EF829E21;
        Thu, 23 Mar 2023 06:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E92AB8212B;
        Thu, 23 Mar 2023 13:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0733C433EF;
        Thu, 23 Mar 2023 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679579400;
        bh=iTF8QMNjZfwL3yp5STtTB2+dQNdjRqGW/9sPIDhN2T8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PgM/UvqpKkNgPsO7ItksVVcUhCt9ab5qSoXtylpv45OqkwSgqDdMi2TdMARlWonuy
         3Rh5RBFe3chDR6jAAv61aG4r8juhN2xOjLN1wYEOui//jG7+XtVU/3WIaeYFAJLQ21
         qVe/kmyT25ylK/Q1Uo/FR5PdZo5BlO/HDuRTxEYnDYvTeHTCX0hckuPcVo92GPIg3v
         7SG3brq917Njc65EIioSUatqyrDd+0IXFwG2EhFSpgOhrXbMbWFKapGw7cAjg3MEhG
         8rqaSoXe5Kw6YN8K1117ZMpInAXl+eepPKEKWkyUz6/1J0YUhB/S3KEv3VDpM3Jy6l
         8Gf5ZrmCcuVcw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        patches@opensource.cirrus.com
In-Reply-To: <20230323083312.199189-1-m.szyprowski@samsung.com>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-Id: <167957939870.27497.6638413163110785234.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 13:49:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 09:33:12 +0100, Marek Szyprowski wrote:
> Restore synchronous probing for wm8994 regulators because otherwise the
> sound device is never initialized on Exynos5250-based Arndale board.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
      commit: eef644d3802e7d5b899514dc9c3663a692817162

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

