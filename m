Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34763ADED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiK1QjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiK1QjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:39:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59824F2B;
        Mon, 28 Nov 2022 08:39:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 955BCB80E1B;
        Mon, 28 Nov 2022 16:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD5DC433D6;
        Mon, 28 Nov 2022 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669653550;
        bh=NAGBW7jVQtQ3XhXFNz8vKgIt9eWnUGvhfyXZ1qUgZnE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ccc1tr191aYCv4ZgyhVSrKD1blmbGU6ZtK0HpoY++V/fovAJ3SIxnZtpIYvumwjeo
         +dJPMxmL+6BNVvwMnwx+pLJbUTuPiRVGoTudnOXhHYfhfP2JJ/Rd3l6KJqIuy4ulgO
         qq7ULwboAKe/MkUx47L0IcIo2/Ug+vjb5/RMQIutzlfoajZrsKtPEJEeBzpWq0hjwx
         0gRJ/3N2jJwDKqyri3mmlIK0K/FSv5ectpmXZs1TgNBn40JbXn2ccf4LnRmX3Sds0W
         e9XewrNdHEhJUFsbWgoUUAq8fhdBDT08Ld29I/0cwcR1xzFiOQCdjpZwW1H7Fz168P
         I0wtHr3BabEng==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     quic_srivasam@quicinc.com, quic_plai@quicinc.com
In-Reply-To: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 00/11] ASoC: dt-bindings: Rework Qualcomm APR/GPR Sound nodes for SM8450
Message-Id: <166965354669.629583.1450673554092513884.b4-ty@kernel.org>
Date:   Mon, 28 Nov 2022 16:39:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 13:02:24 +0100, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Patch 2: Keep compatibles in qcom,apr.yaml.
> 2. Patch 3: New patch.
> 
> Description
> ===========
> Adding sound support for Qualcomm SM8450 SoC (and later for SC8280XP) brought
> some changes to APR/GPR services bindings.  These bindings are part of
> qcom,apr.yaml:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: dt-bindings: qcom,apr: Add GLINK channel name for SM8450
        commit: 0dd3618e06f86bbdacad3a40b25bf79b8917000c
[02/11] ASoC: dt-bindings: qcom,apr: Split services to shared schema
        commit: 41288c30583646e2b4158c75ccdbddc62597e1fa
[03/11] ASoC: dt-bindings: qcom,apr: Correct and extend example
        commit: cd9ba3d065bb94f3c20e36ed400269a285bfa46d
[04/11] ASoC: dt-bindings: qcom,q6afe: Split to separate schema
        commit: 3e9c0c86267377f1404bc55051f476a0456dcced
[05/11] ASoC: dt-bindings: qcom,q6apm: Split to separate schema
        commit: 6180b3252010f7cccdef896faf305456df4c45cf
[06/11] ASoC: dt-bindings: qcom,q6adm: Split to separate schema
        commit: f26a776ea5ea22b5a92b0619af54d202e4027524
[07/11] ASoC: dt-bindings: qcom,q6asm: Split to separate schema
        commit: 83c8fa5e85e556e6aa3e95e7070ef738964ebd17
[08/11] ASoC: dt-bindings: qcom,q6prm: Split to separate schema
        commit: 8009abe0f14052bbfadcdaba7887226b40dfdb51
[09/11] ASoC: dt-bindings: qcom,q6core: Split to separate schema
        commit: 7eea2bed3602a2b2e71146e0110d42f6edf917f5
[10/11] ASoC: dt-bindings: qcom,q6apm-lpass-dais: Split to separate schema
        commit: 8c7ac825481602e356d96db9424b4d4e23a6a1d3
[11/11] ASoC: dt-bindings: qcom,q6apm: Add SM8450 bedais node
        commit: b386acc043f44a730d5117b71b75e818cede21cc

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
