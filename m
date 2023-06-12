Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC272CC81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbjFLR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjFLR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DE8130;
        Mon, 12 Jun 2023 10:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0721615A9;
        Mon, 12 Jun 2023 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AC2C4339B;
        Mon, 12 Jun 2023 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590818;
        bh=VUk6jAV2ZmWBvmJdiUOnmOQgHuM9loH0DtxACEg8dHo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HfhcEvn06g9KDXJodkGT35AKIvXxDFE6+LTTf2dmZ3rsDZ6Coy6/xrgv/NnljQpXE
         jjN4cx1wW6MaKRMjjNKkZj2aKkJvcI0yM6fDzqu9vMu5Q3C2jv3by8Veo0HT1gsTZx
         twysmZi1dcLKfdB2ux4z5xsnNJrHoEonam1U98zbKE7KPVWtPzOgnSfQ6NEvSsOjsu
         7lpMGpzRQf1NMj2iOjge55Zr5eo7TIWY2PXbx+eHtdB256+LPt8wgJJrqbX/DmETsi
         JLTa1odyMSdiqffkGArngboKXqOB8TKB1gRfTPozQCrSwIk4AZwqTdMPqDxU0vJh3/
         IexXsC9ttKhiQ==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609140658.64557-1-krzysztof.kozlowski@linaro.org>
References: <20230609140658.64557-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: cirrus,cs35l45: drop unneeded
 quotes
Message-Id: <168659081532.87413.3101629850429696766.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:26:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023 16:06:58 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: cirrus,cs35l45: drop unneeded quotes
      commit: 374b54532b1c94076799518cad5c33536eaf0c1b

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

