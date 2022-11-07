Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3061E93A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKGDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKGDN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4EE005;
        Sun,  6 Nov 2022 19:13:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF5C6B80D8E;
        Mon,  7 Nov 2022 03:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF9EC433D7;
        Mon,  7 Nov 2022 03:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790778;
        bh=Qah0whnzhKRR+5zIkalD8yxsxK5W+yVims7NAkUtsec=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VvqQFs//v2UHevZNdFnbUW7g+y4BSxZuGQdiZAti/fTw7gPjmSwg6aS4gr7ypfd07
         600EHrbufl0rwG0vp2QzKRYckiJQQ6tr1ungzK8EGO62oPTA2L0D3D7cs9A6a2p5sg
         +KQVerdnXPNZ4jnWjz0OjsMgN8jUctzAnSV/dq7r0nSbeDQvcUhOxnKGILw8+oIZ2S
         Cs0mTGp9GpBKm7V5ZnyieE9OKKso4aGvjrIyTLzWNrg48qCrncSV7FCsRrUOM/RdsW
         9vgJMDHA3kFDx5FJnOhT0JGLIh+QErpyAe7alzA5Z6r0Pf1G9Z4DarKwrEP8aUhHFy
         kt8vqEvJ6ZfbQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: build-in Qualcomm SC7180 and SM8450 interconnects
Date:   Sun,  6 Nov 2022 21:12:16 -0600
Message-Id: <166779074260.500303.2176480239018682712.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221021032702.1340963-1-krzysztof.kozlowski@linaro.org>
References: <20221021032702.1340963-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 20 Oct 2022 23:27:02 -0400, Krzysztof Kozlowski wrote:
> On Qualcomm SC7180 and SM8450 SocS, the typical debug console serial
> port is part of GENI Serial Engine QUP Wrapper Controller which uses
> interconnects.  This means that without interconnect drivers, the serial
> might not probe.  Without serial console, the root might not be mounted
> by initramfs:
> 
>   + REASON=No init found. Try passing init= bootarg. PS1=(initramfs
>   ...
>   (initramfs) run-init -c /dev/console -n /root /sbin/init
>   run-init: opening console: No such file or directory
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: build-in Qualcomm SC7180 and SM8450 interconnects
      commit: c03fa428ac6e439afa1d437776365a632ce24262

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
