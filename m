Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CF7229F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjFEOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjFEOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59B3F4;
        Mon,  5 Jun 2023 07:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3677862672;
        Mon,  5 Jun 2023 14:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A3C433D2;
        Mon,  5 Jun 2023 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976940;
        bh=owVqIJcvv2ZqL/eS/5evrVaFvRAojhfCvGlWzeVYaBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oOkkbsfMlf8I8dusuqB0/yuYd68++W9bH9V5WFUtgGUjDnG5wJHMIjSrS4ypus3ya
         DdlBcxLDq7HsWzqe+yGv+saq9EQzu6X/YkhUVYR45Kj2wqsj/zAoQ3Iyvc2oWez9Xt
         4YrAG/Nm58htPQp3rb+SgUveGJr4zKTVQy6g4uHWtovAYnSuhiVnxdk14AwG/izrIN
         lB3qOAmXvTaCya9/Nqy+YGoGz38upbuKRdq7RkDJAOdPBa6J2Sty6RmAQAEYOCeheE
         EV0k+62D6rqbKmf5RMhGr4QL/QwA0GMSGwk1/bt2VGipkEzp0rkh4yDIeGnMSzQmWv
         Qb+4yIOgtYAvw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20230602-pl022-defer-fix-v2-1-383f6bc2293a@axis.com>
References: <20230602-pl022-defer-fix-v2-1-383f6bc2293a@axis.com>
Subject: Re: [PATCH v2] spi: spl022: Probe defer is no error
Message-Id: <168597693914.38297.2144180817294753536.b4-ty@kernel.org>
Date:   Mon, 05 Jun 2023 15:55:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 20:12:54 +0200, Mårten Lindahl wrote:
> When the spi controller is registered and the cs_gpiods cannot be
> assigned, causing a defer of the probe, there is an error print saying:
> "probe - problem registering spi master"
> 
> This should not be announced as an error. Print this message for all
> errors except for the probe defer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spl022: Probe defer is no error
      commit: 8098a931c080d32687aee72a1dfac98507a6034b

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

