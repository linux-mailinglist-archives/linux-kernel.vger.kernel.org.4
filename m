Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3D6D7DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjDENnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbjDENna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3864699;
        Wed,  5 Apr 2023 06:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D4E627FC;
        Wed,  5 Apr 2023 13:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79C3C433D2;
        Wed,  5 Apr 2023 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702208;
        bh=9n1hEIpzbcKxhbvQM0j1MI8RHChB+66O0uFRPDpYl60=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WC07jQRKNgcoSIm0NgnOqAFywHCc0Qem4pPUVa1QeHf42I2jf2SNb2yf17XX6A5wg
         lr5eZ1Jb6l1DmGIda4dCUcBw+8ORBZWA0cTMrHJDnhnTj7m7YzDRCKX/SCcXybDeg0
         43nnoGkXe6bMDq5TMEd4v/rUuhXwuIqTzPU8OuW0v00FYxlqYhZHEN5l9cZpaIoi5/
         DceX0uDZdp4QYvhMpyi4nQsmwKYWHKp/1lWvbHfZ7gYhg09TUh07sUOK8dXKQiSyLa
         BVetF8SG9CIu8w6DU0Y+HnfWlGgzOboD8bOWJOa3GhOcb6FSL5anmphgsv8v7/DFER
         xRd0a21W4GwgA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230403105237.3854-1-danascape@gmail.com>
References: <20230403105237.3854-1-danascape@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: wm8510: Convert to dtschema
Message-Id: <168070220664.64778.8309966966059306320.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 14:43:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023 16:22:37 +0530, Saalim Quadri wrote:
> Convert the WM8510 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8510: Convert to dtschema
      commit: 72456c24c8357793bacf5e67549db1f8c3fafe11

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

