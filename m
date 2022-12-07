Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329464615D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLGTBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLGTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB035D6AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:01:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABB6AB82051
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 19:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D80C433D7;
        Wed,  7 Dec 2022 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670439692;
        bh=2vhrKfL5f5Th8736PXYY9evBIgWxXb6E39AhM7EvysA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sq0zbvj1RpcD2DkI+5o/yE00jR1KMvYaD0n2qpFbzwiVT40gHWm3lfwW6dm2QdNqZ
         fiUAczDpUN/AcVcacvuwCIVH9euRhN3h7T5xZlKdvOB56/avUOM+9PgcYH0WExIdbD
         E4Wq+c3tsvjVrBdZPxQScukgUEbd+LbiOZOKEuQUS735lK3DvNaz8NVBqBAVjTpYFa
         yN7lCkvi35HX4ek9YdHGcQb4sP2s1j0QZzvVuiMDakp2aGib/TeaG+jAHqxWgTNTuU
         sMmvlK3O+2nDYauJv5WAl0e39VkL1kJPD1sH+NlDgxPt2g7mxNp7Lu1axTL3PCAtmI
         sJx3KwPMHOTJA==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bgoswami@quicinc.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20221205073507.36071-1-jiapeng.chong@linux.alibaba.com>
References: <20221205073507.36071-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: codecs: wcd-clsh: Remove the unused function
Message-Id: <167043969025.414898.9604459872443283940.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 19:01:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022 15:35:07 +0800, Jiapeng Chong wrote:
> The function wcd_clsh_set_buck_mode() is defined in the wcd-clsh-v2.c
> file, but not called elsewhere, so remove this unused function.
> 
> sound/soc/codecs/wcd-clsh-v2.c:133:20: warning: unused function 'wcd_clsh_enable_status'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd-clsh: Remove the unused function
      commit: 81ed7d9de18768fe0cb3d74a7a163a8c082e1346

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
