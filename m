Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5173B65C646
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjACS30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbjACS2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:28:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626825B;
        Tue,  3 Jan 2023 10:28:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D42B1B81058;
        Tue,  3 Jan 2023 18:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E88C433EF;
        Tue,  3 Jan 2023 18:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672770525;
        bh=yhswg3DShTdTcWnmXNM9VSuwY/yXouAAY5fuapScc/I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Jex4+kY08rBDVb/HQ02/dUHIbmGrMVG8VrcMFegVyuKKM+M323VHMAiwu3OSDdirC
         fuHEb401IdRPNtDTImDcqB14hUxWYEa1WMdwRMUj4OEaZaLl+LBo9HMag0V1Xy8Ne/
         p0eNc/uLSjEBGbdMZdIfCQdUATpEB+yEo4AiIDym2LmDLCmS35sVy3C1J/4r3BuQ17
         2hEW5s2m6pA3fFK7DJI75J+oq/7Z8DMtlYPAJuDX9y+JAJUHHWCdN74JP5GaFDNgWg
         yHB25m064ndkQnW+OqGYhhd/a+kQjSa+AVlHYmv18QCrePFKPkGyt/4PGdP7fO3W5z
         9OoeK7TCzEDmQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20230102-topic-sm8550-upstream-fixes-reg-l11b-nldo?=
 =?utf-8?q?-v1-1-d97def246338=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3C20230102-topic-sm8550-upstream-fixes-reg-l11b-nldo-?=
 =?utf-8?q?v1-1-d97def246338=40linaro=2Eorg=3E?=
Subject: Re: [PATCH] regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo
Message-Id: <167277052358.294777.11750956760229160176.b4-ty@kernel.org>
Date:   Tue, 03 Jan 2023 18:28:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023 12:23:20 +0100, Neil Armstrong wrote:
> This fixes the definition of the PM8550 ldo11 regulator matching it's
> capabilities since this LDO is designed to work between 1,2V and 1,5V.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-rpmh: PM8550 ldo11 regulator is an nldo
      commit: f528fe213a6ad21a6e8644dbd5de10dc264a89fd

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
