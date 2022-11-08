Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9696620852
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiKHEg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiKHEgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:36:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DC27908;
        Mon,  7 Nov 2022 20:36:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CF26146A;
        Tue,  8 Nov 2022 04:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363FBC433C1;
        Tue,  8 Nov 2022 04:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667882195;
        bh=OG44KWmZaIEMvgjyKsQDKtAHHYFHCw8JOB7XLYtFQz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4CW+C6G+WsNwVA7W/x/7fuvoirJpjyOHlxfvLJfTQhf/DnKaoflzf2G0ahPdC1Ya
         6HpXg3sr1w5969R9mNAdgoptDYAhyqbOlFbOlfrB384V8v1Wa9qcWYj0xRS1FKNkCr
         E9NZZGnuARFGVT5Sd170I15w3eJxPtbD/SOgo4fD2uiYgPtrOF7RjgI2MSHUYPHq3A
         rmcbvKv5dCr3O1kc9JHzIS6SBRebp4/ZHYmb++MNxaF+VD63QAnFwfp0AgLGD7HwFn
         XkxMUvgZ+WQ2D83Qmc6DfPfTwxs0o1AT1xSuar4Y/XBFCm0+//IfMWMHzRZ1ll4Tse
         UjJOIYlWDU0bw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     swboyd@chromium.org, agross@kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        dianders@chromium.org, amstan@chromium.org,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Subject: Re: (subset) [PATCH v2 0/2] Update fingerprint node on herobrine/trogdor
Date:   Mon,  7 Nov 2022 22:36:29 -0600
Message-Id: <166788218318.625965.10548024842918828007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107191535.624371-1-swboyd@chromium.org>
References: <20221107191535.624371-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 11:15:33 -0800, Stephen Boyd wrote:
> This patch series updates the binding for the Trogdor and Herobrine
> boards' fingerprint node. Now that the binding has been accepted[1]
> we're ready to merge this in the qcom tree.
> 
> Changes from v1 (https://lore.kernel.org/r/20220317010640.2498502-1-swboyd@chromium.org):
>  * New patch for trogdor
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: Fully describe fingerprint node on Herobrine
      commit: aefd5370ab5e55a18c94573b9602083132e24601
[2/2] arm64: dts: qcom: Fully describe fingerprint node on Trogdor
      commit: 9ec68fea9e53d25177618d2ce1bc4a1b1b724938

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
