Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707D774F9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGKVV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5986F133;
        Tue, 11 Jul 2023 14:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E79A061625;
        Tue, 11 Jul 2023 21:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516FDC433C9;
        Tue, 11 Jul 2023 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689110483;
        bh=YPSY5HUnEvTGUfr7w/tBIIh9m9ceIEnrSFhq7uRjKcY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jRIvjX4IGsggKxoSXRCirgRqmZ+47AGWe5Vqd4Uc+mv3ipYCU9NUkLnjHTiG4XV7x
         ivwAlabtQ50xEFzWz+YiffrTxoYqn2EJtRgcbiePFNi7WBmM3sMlqFJYC6yJzetkPS
         r6UOvlCxOTAWdcE0GCHOtfcyn6/g9b9e9x/VxzLu2box23nW196Rvng/QyWHkO5wJP
         ijUW1EtoHnTjeVvSTdeYTNP2p2H1qpfjxZFVi/d3Q7hhNHaJzSGnlhMawAvuPMHnJh
         aI/aUzHBilSvPB8JmsmAWnhm0W0MHdhvdWPSDurYGE+Chxujgr/zHba1tZyKX+pvB9
         jyv8urmbl9nmw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        cychiang@chromium.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rohit kumar <quic_rohkumar@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
References: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: Update maintainer email id
Message-Id: <168911048005.530041.1862565252407998007.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:21:20 +0100
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

On Fri, 07 Jul 2023 13:13:36 +0530, Rohit kumar wrote:
> Updated my mail id to latest quicinc id.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Update maintainer email id
      commit: a1ff5802da3806e916de100130a7850b3f80c377

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

