Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27018738730
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFUOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFUOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F63F19B7;
        Wed, 21 Jun 2023 07:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EFAD61568;
        Wed, 21 Jun 2023 14:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB120C433C8;
        Wed, 21 Jun 2023 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358226;
        bh=Qq2KHkcMJKRKaKjKmOwJn99Gn1sK4YSpy6al5GmhGps=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mco0oP7hIYN5nOEGv1m+pjXJQf6U5ZskFQY94jgtjWzHGVX/Pr+OuVIGya7vKKky3
         99PvIohOx1GpNymZ3myOYmG4HMt4jvK4aYz/3KfnedQbdeDoqTteQsNHnvrBg+mbyK
         yhWkK14QjbuNLOuhGuJP4nYuTxdVPf4arPXMoa5cvvAptDLAnGYZlxpnLIF/ZAdpu/
         C/6rZxgM07sv+dYRihDvtQL4vWL0uv5tjztbSfQlE6ghl07ZxRyltYYdQNfLbj+i55
         D3MGRwpQ5n4p32SFc5U78+5bI9GWT/eJtm+7D88cD+11dsWOMdFQb1Xs6S8zIs3j7k
         uTBFALAWMUC+g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Patrick Lai <quic_plai@quicinc.com>
In-Reply-To: <20230616115751.392886-1-krzysztof.kozlowski@linaro.org>
References: <20230616115751.392886-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: qcom,wsa8840: Add WSA884x
 family of speakers
Message-Id: <168735822238.116117.14550188364140535964.b4-ty@kernel.org>
Date:   Wed, 21 Jun 2023 15:37:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 13:57:50 +0200, Krzysztof Kozlowski wrote:
> Add binding for WSA8840/WSA8845/WSA8845H smart speaker amplifiers used
> in Qualcomm QRD8550 board with SM8550 SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,wsa8840: Add WSA884x family of speakers
      commit: 97ae6f4e5dd3bc7873ee70c864ab2ba2e8bff0c3
[2/2] ASoC: codecs: wsa884x: Add WSA884x family of speakers
      commit: aa21a7d4f68a0a5067578cbb93c136ab5ac09cfa

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

