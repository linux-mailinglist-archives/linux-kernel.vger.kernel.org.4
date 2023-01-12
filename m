Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D297F667DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbjALSTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbjALSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7300BFE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4161A62096
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA7C433D2;
        Thu, 12 Jan 2023 17:49:22 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Don't use streaming mode to probe the maximum SME VL
Date:   Thu, 12 Jan 2023 17:49:20 +0000
Message-Id: <167354575614.3644139.5289750028744899336.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223-arm64-sme-probe-max-v1-1-cbde68f67ad0@kernel.org>
References: <20221223-arm64-sme-probe-max-v1-1-cbde68f67ad0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 13:04:35 +0000, Mark Brown wrote:
> During development the architecture added the RDSVL instruction which means
> we do not need to enter streaming mode to enumerate the SME VLs, use it
> when we probe the maximum supported VL. Other users were already updated.
> 
> No functional change.
> 
> 
> [...]

Applied to arm64 (for-next/sme), thanks!

[1/1] arm64/sme: Don't use streaming mode to probe the maximum SME VL
      https://git.kernel.org/arm64/c/fcd3d2c082b2

-- 
Catalin

