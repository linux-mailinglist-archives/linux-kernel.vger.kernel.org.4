Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEA621AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiKHRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiKHRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:39:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760F4FF99
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E43D61702
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F364EC433B5;
        Tue,  8 Nov 2022 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667929156;
        bh=2zMjHd2tmgr2B5wmbrxASzcvKnNOl5giLWW42dM9CnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0JWiGTlgTjM7w8NHnCUdqKCq6SgHUiS8Az3ixRRkxi/G9ku6a7GwSpkB9tTGscnN
         aYFT3Fp/5FNQYswVD+Cz+8DrbmfcGs0/jh+SJisTmjMfUo7MbycWePbLNZdUa5/lbf
         BO6IrCS5oOadthkO/Mf/N2oeEnjPDRy8+C4G3d3D2LpcATrQGZiDnq4uWB69Fcp+NT
         rkfROwcfF2I5SY2wX4nOwsd1Gz3s11vk95aMwGG3E9/KML3Gq9pgZZwVEsCIvcFPci
         LTu35wrAc1KK7bj7EuLos2/wpFknJc4NUm5rak/T1VrUI8Oxarx3dhOdS2bZCWBOP5
         lUp8XuT2bI10Q==
From:   Will Deacon <will@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, mark.rutland@arm.com,
        broonie@kernel.org, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: entry: Fix typo
Date:   Tue,  8 Nov 2022 17:38:48 +0000
Message-Id: <166791620535.760416.7765170110179707651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
References: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
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

On Sat, 29 Oct 2022 12:37:48 +0530, Mukesh Ojha wrote:
> Fix the following typo in entry-common.c
> intrumentable => instrumentable
> 
> 

Applied to arm64 (for-next/trivial), thanks!

[1/1] arm64: entry: Fix typo
      https://git.kernel.org/arm64/c/59598b42eb52

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
