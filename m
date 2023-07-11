Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352DE74F9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGKVVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGKVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427B133;
        Tue, 11 Jul 2023 14:21:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD27F6160E;
        Tue, 11 Jul 2023 21:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A1C433C7;
        Tue, 11 Jul 2023 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689110487;
        bh=6Ah7bT014+0EnYhqIBI4z9U9khMOfEK4P7UjUPWCSxU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CsB5o/cj4RYIp4U7s5184O6v2lgE1SjlMobgfQJrlU0f+U7X1uYbfw16uCX10JyPa
         g2AjVuf+P02lxL7Ba0tfPbxIzzbW1jG4BtFFX1oiF6Y0qjMer7eKpO3OJk2UiZSxfp
         xTioBe/+6hDAml8RQ94yNjBMJp+CKdamWHIhmB645xYBbxpi94Ws8T+Yo3y6XSkvqZ
         LfN0b4p8RSk8/WhX68UPsRFSoR3CdOFKJY7cWo7LnICjCxfF+NGkz/55IZnvTtNiGS
         UV2NVOajHThFAXvZz7A7uEhzHd+m/AJ4ZOcx15w2/lQByutD6j88ZQzJ0262Pa5LOP
         T4U87uMo2U0eQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230707221725.1071292-1-robh@kernel.org>
References: <20230707221725.1071292-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: audio-graph-card2: Drop incomplete
 example
Message-Id: <168911048524.530041.17659227550480230737.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:21:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2023 16:17:25 -0600, Rob Herring wrote:
> The example in audio-graph-card2 binding is incomplete, uses
> undocumented compatibles strings, and doesn't follow typical .dts
> formatting. Rather than try to fix with what would probably be a lengthy
> example, just drop the example.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: audio-graph-card2: Drop incomplete example
      commit: c65b21f8aeac86768d387a86dfcbec5980480b6a

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

