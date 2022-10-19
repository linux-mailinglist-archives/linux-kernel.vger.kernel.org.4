Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A539B604E47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJSRNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJSRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:13:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0B1BE932;
        Wed, 19 Oct 2022 10:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4341AB82571;
        Wed, 19 Oct 2022 17:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6B1C433C1;
        Wed, 19 Oct 2022 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199622;
        bh=NyNZ+inQk271m+JIba1TXYMkNOx6yVUC2InlpmkUhuw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rytKq5vvUUyE8N8WZpL8iJdwJIevzOag8iHOLHERt4UdcmgEFyf+H/s9hkM7k2QUr
         3r79IG9Brh31vXxj+jupWhf3dDZTZMWzryGltHKNAH+8NZXlI1V4vqKw6QWsftLfVp
         +iLqUmHDnOP86FGJH1JcITGZDqwhtYtsoQTD99U4QG+cOxa1r7eJiDGWmp78wJiYjL
         mjYPeY154KNQVchRPInrM1TKq27rKr/WeaxPoe9lovc4WU+lN9D1D6gBnCxCbcGQXg
         R3YOOEGLQhlzSHgjUxkF7AZbveFF5vRuPEDvtbhHuiwCBVjHext3ryNzQNw3GO0eWN
         TFf4Sy7F+dCyQ==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, bgoswami@quicinc.com,
        judyhsiao@chromium.org, alsa-devel@alsa-project.org,
        andersson@kernel.org, srinivas.kandagatla@linaro.org,
        lgirdwood@gmail.com, quic_plai@quicinc.com, agross@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        perex@perex.cz
In-Reply-To: <1665825530-7593-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665825530-7593-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [RESEND] Asoc: qcom: lpass-cpu: Mark HDMI TX parity register as volatile
Message-Id: <166619961841.1416660.6646939908532904224.b4-ty@kernel.org>
Date:   Wed, 19 Oct 2022 18:13:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2022 14:48:50 +0530, Srinivasa Rao Mandadapu wrote:
> Update LPASS_HDMI_TX_PARITY_ADDR register as volatile, to fix
> dp audio failures observed with some of external monitors.
> 
> Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Asoc: qcom: lpass-cpu: Mark HDMI TX parity register as volatile
      commit: 1dd5166102e7ca91e8c5d833110333835e147ddb

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
