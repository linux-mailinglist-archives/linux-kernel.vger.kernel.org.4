Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED386E25FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjDNOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC2EBBB6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79CE3643D2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4DDC4339C;
        Fri, 14 Apr 2023 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681483296;
        bh=nfeOIgbWifwrcLlF/ULbFbyWrBPwPRsfTeMepM7hA5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2yCZTkknz2hb5kH/8LePXua3eR2XL1gFXknMKIH1d1JMROKP2ZzAToiA5KQJwUPA
         yAwtMynPFtooZoEShQMzsjxbuMgAkJwHHsyegZsPMtajIzvsQFLoHGC25V/eEFwDwF
         zoiZbmDCRsNG+ZfgQOv8mZDhw7+rWuKHOuZkkiXDzWTt0KRQC+zq7avBQuiJilh7zI
         fQJRb0i3lL0S165vn4Jtl5vN/R1UEMomQAZt77U9alHR2zaiN7ACTWaCaiSFdK8Ne/
         Um0rVSpm7u4pLY4i81mzGxZxGig61drUgillRbPs43S4xlU833Yn2w3OMaecJvLLSw
         kvh3qyp5rTYEg==
From:   Will Deacon <will@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        liwei391@huawei.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ardb@kernel.org, dianders@chromium.org, maz@kernel.org
Subject: Re: [PATCH v6 0/2] arm64: Fix pending single-step debugging issues
Date:   Fri, 14 Apr 2023 15:38:39 +0100
Message-Id: <168147598830.2391666.1506104508286330232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230202073148.657746-1-sumit.garg@linaro.org>
References: <20230202073148.657746-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 13:01:46 +0530, Sumit Garg wrote:
> This patch-set reworks pending fixes from Wei's series [1] to make
> single-step debugging via kgdb/kdb on arm64 work as expected. There was
> a prior discussion on ML [2] regarding if we should keep the interrupts
> enabled during single-stepping. So patch #1 follows suggestion from Will
> [3] to not disable interrupts during single stepping but rather skip
> single stepping within interrupt handler.
> 
> [...]

Applied second patch to arm64 (for-next/misc), thanks!

[2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
      https://git.kernel.org/arm64/c/af6c0bd59f4f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
