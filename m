Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF466C6C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjCWPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCWPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:53:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32DA1ABF1;
        Thu, 23 Mar 2023 08:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A459EB82197;
        Thu, 23 Mar 2023 15:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA58C433EF;
        Thu, 23 Mar 2023 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679586806;
        bh=tDREPBXaK0ti0eVcANz4uaiEmiQSyLL0wDgzguewic4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FEbZlfWVelo81n17h/rHSnGYvpV84bdnc08jYT204xGP63j3TdDis1tRuSloVmbSn
         4fnpOJBuGzquO0Oc7YeJ5a8A05ONvkz1U3I1g2xuV90Dg6ENt9KmeGxzV8Rmw3klmS
         eXNnRUqRT8Iv0W7hueSn8VfXKIwa/Kqv9/sSXcyz8cHHmmW6r6ViEt51Fz46vvKkQY
         4qWMRjshszKKRWfmP7q2gBsvhKZMr7K2C55n6lb5RLbwPr6wqMAvsDwS/A9PnAE0LO
         NtFjzT9ruGGP1+9pQ5WVgVP0YZyPbclwX33bn4pSz90FwjIUJe0+oj+UvVXu+jg0wI
         r9vQzqm7iK6sw==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski@linaro.org, daniel.baluta@nxp.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20230322200949.8986-1-danascape@gmail.com>
References: <d1559192-8f6d-26e0-ef19-d14ac7987a74@linaro.org>
 <20230322200949.8986-1-danascape@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: ak5558: Convert to dtschema
Message-Id: <167958680436.69273.12643001731670842652.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 15:53:24 +0000
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

On Thu, 23 Mar 2023 01:39:49 +0530, Saalim Quadri wrote:
> Convert the AK5558 ADC audio codec bindings to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: ak5558: Convert to dtschema
      commit: 829d78e3ea321eb4f4e93bc7b162b8cc6ed91ec7

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

