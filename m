Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2766947DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBMOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBMOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:21:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DEBBA0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:21:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C93B8119D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06114C433EF;
        Mon, 13 Feb 2023 14:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676298059;
        bh=2HdoCw5LWWFEg7QZgNLiYHqruwMpKEQrn5vOmtnuD/0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MA08mx8VVfI0Vt2FLoaFk/B8N/5b7vaDs5hKcHC+QpzRJvTN5QrHVIhWPT0nFyZbR
         PLXJr/PcsZmdo2syRDPn3Cur3d1dqv21gKKlD1KGGhbDiH+vVMTW4zeOly4yvz5S72
         hP5sHwE5ew1lefm5DzAYLJZnZsXZmdc69fSYQ3GbA0qADpx9/2SHMW6f5mCqbOFfKy
         cqJLWRw6FtiiunKRuk7tt5r8YENPr4tVDKxYH46TmDuszZnldnyRMsZueoRZt3tY1K
         91T808yKl1qhMTl8sh+R4lMjK8zZZG+2IQWGElZp0T41nOesUI9SNOlQWywRKTMF96
         PpBbnDBwmyTfA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230211150019.1545542-1-axel.lin@ingics.com>
References: <20230211150019.1545542-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: max20411: Fix off-by-one for n_voltages
 setting
Message-Id: <167629805871.2700597.4585542846053690884.b4-ty@kernel.org>
Date:   Mon, 13 Feb 2023 14:20:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2023 23:00:19 +0800, Axel Lin wrote:
> Otherwise regulator_list_voltage returns -EINVAL for MAX20411_MAX_SEL.
> 
> 

Applied to

   broonie/regulator.git for-next

Thanks!

[1/1] regulator: max20411: Fix off-by-one for n_voltages setting
      commit: 9d1c73191f94c79076b5f46a31b8a1e12b18bc79

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

