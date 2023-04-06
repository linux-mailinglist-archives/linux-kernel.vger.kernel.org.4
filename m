Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBC6D9E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbjDFREU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673ED8688
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04753649B3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8612C433D2;
        Thu,  6 Apr 2023 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680800657;
        bh=S25Cn7Ez0gk3IjAsgs0lYU5PY3NSakxpn1wMdYhpQ1M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AEgj4RM3UCv+x/0THOLTJVEjuSm+LLYInLMh3Mpbk8NHb3IlCnRVCT55kBDcFeEEM
         LcTdoBIcr02aOnyBNXr/7uF1pfrYnbhpmhAdd5Rd/7+6wGrgBBI7JaoT9sDXRb7n/+
         qvxd/jNUrzNbFiB9gEILPk6oZ+KR4h3/RddUxq0D0+OKP1+ily4vOi1sZ0y8T0Jx5y
         e3stkzvd+EYq+X5txlKsVJJEK8LsXxL5qCcop0igaAyhIp/UGufnOtV4ZMGyh7WG7K
         sEivnbKG++Vxs3Aj0Etx5VSJdgBOnK9u6Sn+2agGszBhY3h36nnvTBj3aSG5mx1nID
         yZ4pengdzID+Q==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ryans.lee@analog.com, pierre-louis.bossart@linux.intel.com,
        Tom Rix <trix@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230406152300.1954292-1-trix@redhat.com>
References: <20230406152300.1954292-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: max98363: set varaiable soc_codec_dev_max98363
 storage-class-specifier to static
Message-Id: <168080065551.124805.6391471744469575073.b4-ty@kernel.org>
Date:   Thu, 06 Apr 2023 18:04:15 +0100
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

On Thu, 06 Apr 2023 11:23:00 -0400, Tom Rix wrote:
> smatch reports
> sound/soc/codecs/max98363.c:392:39: warning: symbol
>   'soc_codec_dev_max98363' was not declared. Should it be static?
> 
> This variable is only used in one file so should be static.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98363: set varaiable soc_codec_dev_max98363 storage-class-specifier to static
      commit: 80a4623eb1910d099e3d3de1564a6dfe16750e60

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

