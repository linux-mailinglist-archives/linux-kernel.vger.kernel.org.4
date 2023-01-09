Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816D4662941
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjAIPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjAIPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:03:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA41EAC3;
        Mon,  9 Jan 2023 07:03:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A132661158;
        Mon,  9 Jan 2023 15:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D6C433EF;
        Mon,  9 Jan 2023 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673276591;
        bh=eqspIp8DuB38ba++6GsDkOao4Lq7XrLjjTS1VgCoAsU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D1Xg1FUruiOJO9uwnD/wJSFbhNe3jv6o6Nk+Sx/GZABLCxkb519RZiIx0lu0SjhAN
         qs+RQXLqRo+IOFpBcfWY5pxjhfmgOIoiNxcOwiMoBt76gD8hkg/dfRxJejtyxS+a0K
         hs57vTuyUhy+gqmf8A+41BOq67QCIYeu/CDIxTqsBVCYwfx51fTnxFkBM5WHVpDtCC
         Z4Wur6YFje3O7WcUR9awPn01wB/btd+wR29UZIy3wwUauPLqAFfiFls8q77YqVITOH
         bqVYQ7x4l3JvRNbHRhNyLB46kGxCfyqWjL2rOVe2UzHCx43P5Bqn+qdonLog79LygD
         eKuJJ7qmw4GUA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221219191125.1974879-1-robh@kernel.org>
References: <20221219191125.1974879-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: Convert Fairchild FAN53555 to DT schema
Message-Id: <167327658893.217427.12495185483455805011.b4-ty@kernel.org>
Date:   Mon, 09 Jan 2023 15:03:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 13:11:25 -0600, Rob Herring wrote:
> Convert the Fairchild FAN53555 and compatible variants binding to DT
> schema format.
> 
> The example was missing 'reg', so add it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Convert Fairchild FAN53555 to DT schema
      commit: 6cea468b680e1254c7e8f95b70f4c3798985f05a

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
