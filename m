Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09F633F08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiKVOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiKVOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:35:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F340937;
        Tue, 22 Nov 2022 06:35:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 929B8B81985;
        Tue, 22 Nov 2022 14:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B25FC433D6;
        Tue, 22 Nov 2022 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669127736;
        bh=idT7Duah9n5dfy7C5Y9Z/wnjPjKyXBy9xQUKoFfCt/I=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Hh3YTjsEnwXdIj8hP7rBW82DTNH21cI/tpTUBwydrbEgts5SLs/pSwkoEMuuJYJlS
         cjDgH3YV3vPV6sn+8zTI1by/qan6LILG/k4c7uFIUjlpFTuvQTecHv2dCOFHKm2TGd
         Lp6E97js0jd8ElUs4J93HYKDLfswC5kXyycnfPzqeYeTTbZFJhNv4RRQ8SweTmgZ4O
         6JUVfpDjLJ/DWjXZRJYriMIgA9cUmadjeuIT4IUug5Wu/K/46xLnDgH9BJShuw+L7s
         pwlvGuVt+bz0TpttVV9Y0DM6mQFXCV4ZY9XGlOrzDOg37s+1U/GscxU91jbPgI3jr5
         451oSxA8GU1zQ==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org,
        perex@perex.cz, lgirdwood@gmail.co, andersson@kernel.org,
        bgoswami@quicinc.com, quic_plai@quicinc.com,
        quic_rohkumar@quicinc.com, swboyd@chromium.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org, tiwai@suse.com,
        judyhsiao@chromium.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1669098673-29703-1-git-send-email-quic_srivasam@quicinc.com>
References: <1669098673-29703-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v2] ASoC: soc-pcm: Add NULL check in BE reparenting
Message-Id: <166912773193.193495.10138627098068902263.b4-ty@kernel.org>
Date:   Tue, 22 Nov 2022 14:35:31 +0000
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

On Tue, 22 Nov 2022 12:01:13 +0530, Srinivasa Rao Mandadapu wrote:
> Add NULL check in dpcm_be_reparent API, to handle
> kernel NULL pointer dereference error.
> The issue occurred in fuzzing test.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: Add NULL check in BE reparenting
      commit: db8f91d424fe0ea6db337aca8bc05908bbce1498

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
