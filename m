Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1585B67D2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAZRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjAZRJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:09:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAC5728D;
        Thu, 26 Jan 2023 09:09:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC75618F8;
        Thu, 26 Jan 2023 17:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661DDC433EF;
        Thu, 26 Jan 2023 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674752990;
        bh=YQHLBU7Aivmn9WcnpQM380Yt0zjC5w1aDhENH54PYoM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=r+e7VK9GhAWdoai6a4dQ+hIx/vGneah7AOXGXBJJsLAX8gnP+7gSJ/J2PumsnF8BT
         mrQxqzbtj/bUwSeCizoBGXqEzizrhsr5Sno/lJElFpgw7FIEi9LbBVotgadNYZdnUl
         fiNMXhAYhQWBMeoU7CPJBaZxv7nhwxZbEHwWAbKTS7E4fAUUFow1IFffpzUF8A86oC
         YX+LHOWrOk+etv6P1z0G3+ltRSl4huGNuFutDcaKPe2GbdvmSXD8AUXA3e+S2Dy+sf
         tBqDmckx5txXlmHhL0Ntqvag9YRoyU0DS5U4lU5eHuvZ+U8Q+Z7K+hzsWoLum9C6Iz
         +bYmAVabkDmpw==
From:   Mark Brown <broonie@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        quic_plai@quicinc.com, bgoswami@quicinc.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
In-Reply-To: <1674468802-14834-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674468802-14834-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v3 0/2] Update lpass dt-bindings
Message-Id: <167475298607.4003145.11363897170835254190.b4-ty@kernel.org>
Date:   Thu, 26 Jan 2023 17:09:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 15:43:20 +0530, Srinivasa Rao Mandadapu wrote:
> Update va-macro driver dt-bindings and add missing properties in sc7280
> machine driver dt-bindings.
> 
> Changes since v2:
>     -- Update commit message and example in "Add platform property" patch.
>     -- Update commit message in "Update clock name" patch.
> Changes since v1:
>     -- Remove sound-dai cells property patch.
>     -- Update example in clock name change patch.
>     -- Update commit message and add maxItems in platform proerty patch.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: dt-bindings: lpass-va-macro: Update clock name
      commit: 7a35498982e84e4d39e8c259f251dfa588f0f039
[2/2] ASoC: dt-bindings: google,sc7280-herobrine: Add platform property
      commit: ec9009724027b6599ee79a8ac6c97de442ad6f6d

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

