Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B9731AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjFON6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbjFON63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461B2943
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B64C5638EE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA14C433C9;
        Thu, 15 Jun 2023 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686837504;
        bh=VjrxKNUyqqwfgs3hDcEiMErb77PH5mLOvHSL73d2Y5E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V1NmSeYQXyDn8JX9Jp6wW564xLTgGZTxqBQAilml//XfEd2bfLiadeT81HcJdIDLP
         vJk4hiheeqlaIN5zIl8QjM6dgjr4RpFbZzaVUf8vMLYTMKdSmTyf3o2rCVWIjYlm6V
         gHQEXpmXX3ucAZ4cBveVspOXrjXEZOql/MtBjV73JMC+dSMUT3NHsavWzcJ2yT67s4
         ACJdt8BlkZVMTNBAzuHtq7ccQMJx9aNYsme2C5/fewP4e6zf9Osmj5Q72Qol3p4POj
         WQXrHyuANYmYP6o4fnUmDt5HjlvlXl/kNW2fFfFGf+tsP3FiYauhekRMyHNTfcfd7f
         TRzPIeS4RBqcg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, YingKun Meng <mengyingkun@loongson.cn>
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
In-Reply-To: <20230614122240.3402762-1-mengyingkun@loongson.cn>
References: <20230614122240.3402762-1-mengyingkun@loongson.cn>
Subject: Re: [PATCH v3 2/3] ASoC: loongson: Add Loongson ASoC Sound Card
 Support
Message-Id: <168683750214.557448.6898111686510406347.b4-ty@kernel.org>
Date:   Thu, 15 Jun 2023 14:58:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 20:22:40 +0800, YingKun Meng wrote:
> The Loongson ASoC Sound Card is a general ASoC DAI Link driver that
> can be used for Loongson CPU DAI drivers and external CODECs.
> 
> The driver supports the use of ACPI table to describe device resources.
> On loongson 7axxx platforms, the audio device is an ACPI device.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/3] ASoC: loongson: Add Loongson ASoC Sound Card Support
      commit: d24028606e7642261d33ad2a50aed940d35cfb66

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

