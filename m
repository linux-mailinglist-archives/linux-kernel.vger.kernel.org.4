Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59715BEF30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiITVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiITVdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB1377572
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3957962691
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF32C433D6;
        Tue, 20 Sep 2022 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663709597;
        bh=LGXHaxnsi7buEIy15UVaOL9V+aU04sDBY/+LXR8I7is=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kFq+6G9G+Cd0vK9R4fRTibMYBaWxBRWwCSip0udMyAhYYvHejOL6rsqZa7yht5itl
         KgZlIRee1A1sMOJoUS+gWolAlfuAz9pikMUNzKvIJpFlNsRLDXfE8v272a/L6mhJAL
         bZ0DS08ZKzt02FSoO9LSIKGbBTicbxPQ4nvan0+Fb+VwDQs30GO90q2ocDJDYcneH/
         QleAjVlmI1KoN7zKVqh+4uAChnO9LIPZKBwuVdYgftR24TK6Dil7npTR9BIzlrdNEK
         LpQHldiXGCoWoUupFth3lxA6iFaxeKs3giJP5QR7+7Jg2EhHEHXNsJ4p/y1G5Ei8eo
         Ro6DvnNo+SMVw==
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220920115014.952062-1-amartinz@shiftphones.com>
References: <20220920115014.952062-1-amartinz@shiftphones.com>
Subject: Re: [PATCH] ASoC: codecs: tfa989x: fix register access comments
Message-Id: <166370959271.476248.6207909034346606474.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 22:33:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 13:50:14 +0200, Alexander Martinz wrote:
> Fix comments regarding register access based on review feedback[1].
> 
> [1]: https://lore.kernel.org/all/YppQ7BiqlBDMNsuc@gerhold.net/
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tfa989x: fix register access comments
      commit: 9b9def51e1a6de6cd336ae08884f580ebab7d2b2

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
