Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5912691058
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBISgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBISgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:36:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014045AB3B;
        Thu,  9 Feb 2023 10:36:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F37F61B80;
        Thu,  9 Feb 2023 18:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6F5C433D2;
        Thu,  9 Feb 2023 18:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675967780;
        bh=PYzwfwbt25AUIPUiQXcfnToLFsGRS71rob+5nQm8OG0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=TJlLYevrQyb2Tdd1yL0Ev60Lni+wpyJG39vDWW1WjG7Rer1/Of9l4pAKwsQtZd3dR
         mY5XL7sc3bMKuTyOd+XT1rWtb61xAcgnm5ukOxQb27rqx48akqZVr16xjrXIgDj989
         ZoHlUn8Bo0xqk7TgIXDpx5LLkTHJIpTP7vqGkP0CX3x3kdaW1murrDOqWNwwlM3mnX
         BgNri4bmCk/QHQZ4E77NlTkzLfJWEHywccGrGHOjzWZ2Z3PiQRL5T2sDPnIc8b6WTu
         //GVfBxIcLIqLUe2ltcn/cgEF9GL+iZE4DmE8SHu/0Teudsm1C+JV+tiMnh9vkQKuR
         jqM5lKfty3lww==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206150532.513468-1-krzysztof.kozlowski@linaro.org>
References: <20230206150532.513468-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,q6apm-dai: adjust iommus for
 SM8550 ADSP
Message-Id: <167596777728.879652.15119522144585944550.b4-ty@kernel.org>
Date:   Thu, 09 Feb 2023 18:36:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 16:05:32 +0100, Krzysztof Kozlowski wrote:
> It seems that SM8550 ADSP remote processor uses two IOMMUs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,q6apm-dai: adjust iommus for SM8550 ADSP
      commit: b2c0c45d9255b4444df65c5f69b4939835fee019

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

