Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA04674257
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjASTLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:10:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268C966D2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:10:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9164661D60
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B26CC43392;
        Thu, 19 Jan 2023 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155334;
        bh=JiiTdE/SZKB5X2R6ZYYRgDPsFwdRH3aHT/cX37jvu2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0G88PcYjk6WbMhYeKq4YBM/GXNYylAn7cu5Vemds5nd6iTlo1UzXqIaXxgeadqRN
         HVnaxpEGCcqQxOFQ+TMR5jCNxmC8nevKZfrdBFONequUTNRcI42Oj1OT2GB5KVLQNZ
         YOPyWHO6/Qnsd/RcnWlz8qFnhLavG4Sw1yLh0cRk2FT1kydhcKb1tlcIzEvtatw8oY
         AuCfvBo87LVboMxBri7oeQKGPsn1KsmRTO3tYfkdVX2d67EJuhSi05ion+HnFAS0d2
         aRMjAITVyPG288fVwzxZ4A8K7rGo/OUbz/6csF7OLpzf3GguXNrosoaAXr3cP5Kcsx
         gPlz6ldbWcYVA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, gcherian@marvell.com,
        sgoutham@marvell.com, bbhushan2@marvell.com
Subject: Re: [PATCH] perf/marvell: Add ACPI support to DDR uncore driver
Date:   Thu, 19 Jan 2023 19:08:32 +0000
Message-Id: <167415193338.3429171.11801813891493600460.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209053607.3929964-1-gthiagarajan@marvell.com>
References: <20221209053607.3929964-1-gthiagarajan@marvell.com>
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

On Fri, 9 Dec 2022 11:06:07 +0530, Gowthami Thiagarajan wrote:
> Add support for ACPI based device registration so that the driver
> can be also enabled through ACPI table.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/marvell: Add ACPI support to DDR uncore driver
      https://git.kernel.org/will/c/e85930f06f0e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
