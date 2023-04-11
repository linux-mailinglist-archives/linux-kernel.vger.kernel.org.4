Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F36DDE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDKOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjDKOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA25DE;
        Tue, 11 Apr 2023 07:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BAC0627DB;
        Tue, 11 Apr 2023 14:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C5AC4339B;
        Tue, 11 Apr 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681224028;
        bh=G9AYU0WN9fwVHfpl+j9W/uxt+uCAfsbXK2gGwD+3R2U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eLyIa62oV66FBuzFpuVRcHuxaVvY97n2RorioenkTNckbs6KU04LWPu5nsx3N8/mP
         o7gS3IKXUyUmbhRSpDkKFLenpQS6JcxpM/++rSjpgNU+sTJeSAa1+HdF9NfnSafeJp
         KLYyN6abjCnWVH8rO/NHiFxNjf6ve5j35i0dMcvZdZgnS27t7LR+jCeadptVqOMtla
         Y4nBnPP5EszUhCLSDXtjm9Vq2LmGUX2Kn/GolTliiz6o1oIeM06NMXa5uh+EdYwJap
         UB/vTtyiU1jM5uqZcoQTraDvHUFxnQALBQ4OkEnAcHoRg5H5WwzuIkosruBEeYF7rq
         fIdChet8zTN5w==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
In-Reply-To: <20230407155727.20615-1-quic_devipriy@quicinc.com>
References: <20230407155727.20615-1-quic_devipriy@quicinc.com>
Subject: Re: (subset) [PATCH V4 0/5] Add regulator support for IPQ9574 SoC
Message-Id: <168122402434.58187.8959222946426668128.b4-ty@kernel.org>
Date:   Tue, 11 Apr 2023 15:40:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Apr 2023 21:27:22 +0530, Devi Priya wrote:
> IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for APSS voltage scaling.
> This patch series adds support for the same and also enables the RPM
> communication over the RPMSG framework.
> 
> DTS patch depends on the below series
> https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
      commit: e953450cf0f622e3249202e985c79d3faf9a58f2
[2/5] regulator: qcom_smd: Add MP5496 S1 regulator
      commit: 60bbee7db43b97bf8c0978cc91f78d1746351871

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

