Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8513C6CC01E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjC1NGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjC1NGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:06:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758B1BDC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCC9CB8184D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1848C4339B;
        Tue, 28 Mar 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680008779;
        bh=78JRunLDvvfVdfw3wzQQtOxNldDlOvWFkPPkuRdbb0Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p95xKFBfS/+qDnMjd+QdrEATefuR2eTtIL8Jnwy3byX4noxSAHcCPYkcHUarT179r
         F4mDx5hJqi4Ikf8zhiNeROBfP9rL6VPyrXXFGmNh6+B2ZdmmdN6PvcrCjfPWw4JKFk
         p77QGkh43+kA3gXbCAX/0iOPi7tYSl+nci7eZo7BTxL5KpOw3cFjMGHzxsOI7wBhZb
         tbe3bCL82Xbn/NOaTtljCOdnC8doiRgDQzJ8Mn/WwCVNrpNGwAwNqDM4A4MZdCvwfi
         FzWqZNJXIaC5lck9KIshKIHniIb1vIOCHeKswTk0A1rMKY2oQsOdO3BZjnsVrHptyi
         0GEOcoq4ga7ig==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230327145555.19351-1-johan+linaro@kernel.org>
References: <20230327145555.19351-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: audioreach: drop stray 'get' from error
 message
Message-Id: <168000877638.3186216.17344443847618791242.b4-ty@kernel.org>
Date:   Tue, 28 Mar 2023 14:06:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 16:55:55 +0200, Johan Hovold wrote:
> Drop the stray 'get', which appears to be a copy-paste error, from the
> registration-failure error message.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: audioreach: drop stray 'get' from error message
      commit: 8908c36dabad7dd52872034f9f42c6c077bc7270

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

