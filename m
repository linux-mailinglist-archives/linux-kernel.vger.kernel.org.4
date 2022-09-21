Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434F45C0475
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIUQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiIUQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:41:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E819AFB6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF7AB8312D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9983C433D6;
        Wed, 21 Sep 2022 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663777745;
        bh=7kgl3djZh5Ukp8fvVJOXIPsXSTMOiScsoj5xfm/EVqo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oN7ekmxIAQJRnB0TY9KCgLZRzCIsUggmu34F7hSZRLTSTSgM3gAj33zK6qKqxQjz8
         ojwsbTu6YypGWXzHBYRBJ6mdnMiKSvC+/kUscqiGqP+MRSJf2alzGXhZPCW1cKvSOj
         6YOWzuJd7NbbBmlpuxj6NFOaS1iRtX0msyzfP3TgStGbCJBBsSrYdcsLeY4pDepI6b
         pHjqrFLgE4k4Pq8MRDfDkiFztPXr6DCS6TZaNrSvxVu/CmfKujxbTdnVnESXsir8KE
         r30h3YcbuUgtzAhm8/WWtoBwAsNdPGdz82g+u8vn1kdorD0fvnfYFq97UM/tQypHj3
         vlA0fmOefu9aA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Astrid Rost <astrid.rost@axis.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Astrid Rost <astridr@axis.com>, kernel@axis.com
In-Reply-To: <20220921081834.22009-1-astrid.rost@axis.com>
References: <20220921081834.22009-1-astrid.rost@axis.com>
Subject: Re: [PATCH v4 0/3] ASoC: ts3a227e control debounce times
Message-Id: <166377773859.591459.5595500353811129379.b4-ty@kernel.org>
Date:   Wed, 21 Sep 2022 17:28:58 +0100
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

On Wed, 21 Sep 2022 10:18:31 +0200, Astrid Rost wrote:
> From: Astrid Rost <astridr@axis.com>
> 
> PATCH 1 - convert ts3a227e bindings to yaml.
> PATCH 2 - add ts3a227e bindings to support debounce times.
> PATCH 3 - add ts3a227e driver to support debounce times.
> 
> v3 -> v4
> Removed the comments on enums in Patch2.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: sound: ti,ts3a227e: convert to yaml
      commit: be541bd473618f64fa14138dc7f63b0643363f7b
[2/3] dt-bindings: sound: ti,ts3a227e: add control of debounce
      commit: 6a47412d0798735b0715d224574d216dba9e630c
[3/3] ASoC: ts3a227e: add parameters to control debounce times
      commit: d20fa87e80c363a1c9534afb31df2fa90087e51d

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
