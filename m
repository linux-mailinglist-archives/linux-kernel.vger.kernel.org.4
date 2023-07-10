Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECC74D0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGJIxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjGJIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25193C9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7DB860F1E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7594DC433C7;
        Mon, 10 Jul 2023 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688979186;
        bh=IyGeX+4Mek0f3BfYdTx991s5C8rgTlIRvC3CEb5c4S0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gEzQ20OLO14A9adWb31gkzx7g9ccFD0U9Cl1FK3UlRwys/JjYPnAShm6yu1y3BBok
         cdz7W1ZiWBYtTeNTGnnU1hG+iOrWPJHxu6Mn3UEYdRBFcKFiLB+pot8vIUVJYAXCjz
         U4RjKnd3myCuGLDpzlEpNwlrIiO06Xq0hg/3tiTC1fjR2o3W/+F6T+lJ5PbREgbk25
         BeKq9gz73Ey0x0n2CeiFSmpOax+ke2Cibmba6dCWeLsVIHZiaXqFGyLjQ8EBLuiTVr
         3n4fLyKrnvsJSPLG8y3Qg4jgwHUUKzBQoL5+b/RBG2Fd+EHE0XHbuGVKOh02jopVNA
         KATH7SXbM2ofg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705123018.30903-1-johan+linaro@kernel.org>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/8] ASoC/soundwire/qdsp6/wcd: fix leaks and
 probe deferral
Message-Id: <168897918178.162250.6567156759422885843.b4-ty@kernel.org>
Date:   Mon, 10 Jul 2023 14:23:01 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 14:30:10 +0200, Johan Hovold wrote:
> I've been hitting a race during boot which breaks probe of the sound
> card on the Lenovo ThinkPad X13s as I've previously reported here:
> 
> 	https://lore.kernel.org/all/ZIHMMFtuDtvdpFAZ@hovoldconsulting.com/
> 
> The immediate issue appeared to be a probe deferral that was turned into
> a hard failure, but addressing that in itself only made things worse as
> it exposed further bugs.
> 
> [...]

Applied, thanks!

[1/8] soundwire: fix enumeration completion
      commit: 27e0c9f08ac622db7b907c126249dd23367867ab

Best regards,
-- 
~Vinod


