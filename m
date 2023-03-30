Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3AF6D06B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC3N2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjC3N2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59D1987;
        Thu, 30 Mar 2023 06:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E1260A2A;
        Thu, 30 Mar 2023 13:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D0FC4339C;
        Thu, 30 Mar 2023 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680182910;
        bh=UYwcFtjiNWcrI1M33VyMuYU2JXa6OsSD4SbVHSzlB6c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AUZ41RVyL3525/NLbs2wSb0dW6c2MYwBuNbxTZQ3IPg7K5uo9HDsjRqO5f3pSWw+x
         CPDay3CChMD3y0vGPlj9Z8CptQ63vlzyMbuxqk5UzQ0k09BkZuOz0wdkY2V7iJmec2
         oy6RURAa0bpnnhUFnZBJd8uoBGk6L/EqBWhuJrtuqez/Uk7JA8h6YYD5+2Ht9F2Yi+
         6pI6SdZ/dgbrXgwwe3mMS21/SynKtg2MolCwiJGhbJ2BTd/oVr3uhyjVB77SFGPZJl
         urOoZQfFT30QBK3hIf2q5W7rMuCby6qPODGU+CQ9DmYxhTf6A2wzUY50GJzYlTbQq5
         NxP2+LlVcvEzg==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski@linaro.org, daniel.baluta@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230327211629.28643-1-danascape@gmail.com>
References: <20230327211629.28643-1-danascape@gmail.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: alc5632: Convert to dtschema
Message-Id: <168018290732.3345013.248666317288313324.b4-ty@kernel.org>
Date:   Thu, 30 Mar 2023 14:28:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 02:46:29 +0530, Saalim Quadri wrote:
> Convert the ALC5632 audio codec bindings to DT schema.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: alc5632: Convert to dtschema
      commit: 0b57a2d87b4de2a1f01edaf3b00b3d1939792948

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

