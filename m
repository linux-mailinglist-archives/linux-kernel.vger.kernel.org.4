Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD476CA585
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjC0NXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjC0NXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F34206
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CB09B8149C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F3C433EF;
        Mon, 27 Mar 2023 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679923378;
        bh=QgUVVYzJJ3uUruFy++SwT8IQrl1CAOdmbIEiShUAQqE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=GpspOCfogN8poKDJSLZftRxMT+k8HDoK2fOAfdAVeBcCDMhNb2FnqGQyp3Zb4Hz2t
         kdU8bg/pXlEL0M5WT0fKMWQ6qhIT/ZsbfxrFfPVm+6NOubfcm6n0v6rPInymxD4NA3
         obAMFf5BSjfOPM5XT7wClx8DM7hPka7EsVZrLgySPY8yfY+c9/E4GiR1ZnCGviHQmS
         yxfTZkcPDwKXIaIqmOCDlg1yc7yMqpCix2DOt87JwelLKoj/ilgE1L0vy8a268dSqS
         SwY6t3JyKlhMN/vSLzLWQJrBkKQQlarftxGD4lIIzAu2sGfpOLLbPNxV86gaSytm36
         N4n4noi5BvyzA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20230324-regmap-reg-read-write-page-v1-1-1fbc0dac67ae@kernel.org>
References: <20230324-regmap-reg-read-write-page-v1-1-1fbc0dac67ae@kernel.org>
Subject: Re: [PATCH] regmap: Support paging for buses with
 reg_read()/reg_write()
Message-Id: <167992337653.3162264.89513525626078905.b4-ty@kernel.org>
Date:   Mon, 27 Mar 2023 14:22:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 22:58:42 +0000, Mark Brown wrote:
> We don't currently support paging for regmaps where the I/O happens through
> bus provided reg_read() and reg_write() operatons, we simply ignore the
> range since nothing is wired up properly. Wire things up.
> 
> 

Applied to

   broonie/regmap.git for-next

Thanks!

[1/1] regmap: Support paging for buses with reg_read()/reg_write()
      commit: f18ee501e233a2b830a0c84a2e780ab02d946c04

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

