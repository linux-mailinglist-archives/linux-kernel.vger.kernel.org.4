Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1058C6D7DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbjDENnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjDENnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37E44699;
        Wed,  5 Apr 2023 06:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 923C26260F;
        Wed,  5 Apr 2023 13:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6B1C433EF;
        Wed,  5 Apr 2023 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702211;
        bh=66WtRJVBgcndw1X53yD7mbIb93NFJaPfjwFfW1Jzaec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kSrHf+oMNhRpMaRoILocRLSB5DUxRVKpEpsXPbvh2UeeJGbjxUPo0FSaCPZeZjxud
         L19fNrgfLiBJbkYC5UBNuvxIv/gFA3p0BH5tiud+4Rjw1eq+YYXZhPY71tiFphmvJx
         dvorwpmXKhk30jMYZimDOhSfSrcboIBA6r7LaH/vbeDkdiOA2gixx+m+hxUF9nUtBx
         BjpRqolhyRULqgv+PwvKeZY6vsKaCueqz+y4vZfruAL7LgQdCcBWigzrZfb5uYMJcr
         HOF72wtelKKTVkxax1j6hFiUmbMvJ5avK7shSzcSyF8zy24+OYQFq+MS3pu3jF9B3z
         upJ7gegSF3P6A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        Saalim Quadri <danascape@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230405111605.5250-1-danascape@gmail.com>
References: <20230405111605.5250-1-danascape@gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: wm8510: Convert to dtschema
Message-Id: <168070220896.64778.12812091773442756153.b4-ty@kernel.org>
Date:   Wed, 05 Apr 2023 14:43:28 +0100
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

On Wed, 05 Apr 2023 16:46:05 +0530, Saalim Quadri wrote:
> Convert the WM8510 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8510: Convert to dtschema
      commit: 72456c24c8357793bacf5e67549db1f8c3fafe11

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

