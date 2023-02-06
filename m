Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5268C96C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjBFW3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBFW2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E50113F7;
        Mon,  6 Feb 2023 14:28:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 974CFB8165B;
        Mon,  6 Feb 2023 22:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E32C433A7;
        Mon,  6 Feb 2023 22:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722511;
        bh=LnS3RLxon9gQ/YttfT5ZYdobqpfQma2EEkoraZrnk8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rymJT/9/wV3+N0i3TixFLyizvmO/ShkSNPOGN6Pk4wiJPP/oFb06t/FVi/uSSfuQH
         cFbvmL4r9ZfxXDnl6D7Wx2FjbX3wqwtC9BUncvPkIf0gjm9A5zaFR1flxNKr/pwDe1
         bTR8Agf99V1JqHxQzvymSiN7qsXgg18dQhG2P1F+7BeiVkGId5jEe9PbJTuPzPZW/O
         qPiKh4+fCAiPtaPxf7Cd7V8zj2mX0dXUtRnNzI6F+HX1vXKgK+lir2wEsu3z0zM2Q6
         XhgAVDy2dVptFVBlDwuWghWek74naPgyqCGBVEkqo2IejLeg0LlE+gVG9R/FTzN9a/
         SXf8jRfbW9p/A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, patches@lists.linux.dev,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: stats: Populate all subsystem debugfs files
Date:   Mon,  6 Feb 2023 14:30:38 -0800
Message-Id: <167572263441.3569822.17857027363435426191.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119032329.2909383-1-swboyd@chromium.org>
References: <20230119032329.2909383-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 19:23:29 -0800, Stephen Boyd wrote:
> This driver relies on SMEM to populate items for each subsystem before
> the device probes. The items in SMEM that are being looked for are
> populated by the subsystems lazily, and therefore may not exist until
> the device has booted. For example, if I build this driver into the
> kernel on Trogdor Lazor and boot up, I don't see a 'modem' debugfs file
> populated, because the modem boots and populates the SMEM item after
> this driver probes.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: stats: Populate all subsystem debugfs files
      commit: acdbf5f9b2c492505145f6e50c65418521a547c4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
