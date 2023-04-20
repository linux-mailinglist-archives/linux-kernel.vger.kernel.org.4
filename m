Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21426E9A40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjDTRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjDTRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DEE50
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B4864AE2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DE2C433A0;
        Thu, 20 Apr 2023 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682010303;
        bh=r2eeQ0iXJ7ydhiOTGTE/GvYZEnWak6zfob+C7cJ437E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfwBrO2q65C1eHTXV61cIp+2gCUDaNTYjaefe5ZlK43MNJTNn2QhvXosXRSQDXKvl
         44tTliWSTD04CErcAswnGbaj8TP1m90CGal6nnJ2NTglMORS6Z9i2VtffJ31e5ozwL
         mkwpj5AYKb4E/IpQw21iOit2kyeQdnsCiKTdTV4IurRsRWjKgZmnTced7HKTJvv4Ae
         k1OXunaTz2jTHeMpwbtZlST4rjX+yw2irETHgmhe08apfNGJf17MRT24FTn8ObbXoL
         ZkBL3cUoFFfxSY5iDALaaIdadWUUOtxwegLYrZzwhwDU9R8lCzIPH1vjqdPqr/a+1s
         8AdnkcueFWDag==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Simon Horman <horms@kernel.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] arm64: kexec: include reboot.h
Date:   Thu, 20 Apr 2023 18:04:53 +0100
Message-Id: <168198392367.147167.8214312015996528355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230418-arm64-kexec-include-reboot-v1-1-8453fd4fb3fb@kernel.org>
References: <20230418-arm64-kexec-include-reboot-v1-1-8453fd4fb3fb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 13:54:00 +0200, Simon Horman wrote:
> Include reboot.h in machine_kexec.c for declaration of
> machine_crash_shutdown.
> 
> gcc-12 with W=1 reports:
> 
>  arch/arm64/kernel/machine_kexec.c:257:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
>    257 | void machine_crash_shutdown(struct pt_regs *regs)
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: kexec: include reboot.h
      https://git.kernel.org/arm64/c/b7b4ce84c830

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
