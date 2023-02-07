Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC84F68D6EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBGMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGMj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:39:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A6B305CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 04:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C390861380
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE063C433D2;
        Tue,  7 Feb 2023 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675773594;
        bh=shwmzpSjNG7te1HT/ha5TN+AkB8+ZJq41og2PAt7eeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+49oXPx6412nBS3HDBhzINwPyeYnavo8GvG8VBcY/sbXKMxNg42jM2R5LGat/6u/
         Cw1Wo6nDCp205Xuvq2eUeeyotTCdHi1DjENlvgmQTllRlpHc/yAK9X7E5zGZkuNGuN
         +1Hm+6fbQ+uBdgKbI7jAYHpu1OfJFC/mzGYM6LLD41Zpsve5KkSO0caB1zR8DWpP4H
         i0s2PHHgCNzjfpiRwV3DNXiVrPkyzzbX7oe8BY2GLGb6IKix7DcNAHrJoWm0FbWVtM
         Ik3oe24uWNXAJk1smNkfmAQJNrw8FQ6IG8Y0c5pi5R7pRit/9rpY6GX72hfB4RHmQP
         DcoxEAsIBpBsw==
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: arm_spe: Print the version of SPE detected
Date:   Tue,  7 Feb 2023 12:39:42 +0000
Message-Id: <167577074147.365063.9628389846826575015.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230206204746.1452942-1-robh@kernel.org>
References: <20230206204746.1452942-1-robh@kernel.org>
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

On Mon, 6 Feb 2023 14:47:46 -0600, Rob Herring wrote:
> There's up to 4 versions of SPE now. Let's add the version that's been
> detected to the driver's informational print out.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_spe: Print the version of SPE detected
      https://git.kernel.org/will/c/e8a709dc2a91

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
