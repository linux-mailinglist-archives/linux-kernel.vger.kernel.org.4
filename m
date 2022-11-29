Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDD63C8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbiK2TxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiK2Twz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:52:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580713DD5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC682618CF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC333C433D6;
        Tue, 29 Nov 2022 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669751573;
        bh=uUwCDFh6hHmw6wVeCsasDlZgCvsubbQSyCtq/S0iuxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJ6Y/jntq4e6lAUThR+vQCykuFS1lLBp8oxzWTB4O+EZTgG2A0C0Xj8Yn4OXlaTjf
         ++ywL2ITQ9pybHLeA5beIxnNDKUm4VloSn5J9h1GEf8ELmM+5atVAzXWHZi50ribHd
         J3/gC51Hw/KFVOhZDooxq3KOadAiOeZrk7CRv2Ve5L7SqH4w9DtblbO6hY9KBMcdBi
         KSwm6doGNtVS/O7izfWRB8Y81Nfry6dsBV8TV4vMa22WYRB4L5GVK/k6inC8/lT+YM
         wcomDxZeX/EzuxOWt0hXjRex3dI8+2cwTG69EwChYNcMrp0QqN4cQpN9HERUWpg46Y
         NgT7BesAxxz6Q==
From:   Will Deacon <will@kernel.org>
To:     Geoff Blake <blakgeof@amazon.com>, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: Add shutdown routine
Date:   Tue, 29 Nov 2022 19:52:44 +0000
Message-Id: <166973320082.112522.10687339610259452670.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221125230153.49468-1-blakgeof@amazon.com>
References: <20221125230153.49468-1-blakgeof@amazon.com>
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

On Fri, 25 Nov 2022 17:01:53 -0600, Geoff Blake wrote:
> The CMN driver does not gracefully handle all
> restart cases, such as kexec.  On a kexec if the
> arm-cmn driver is in use it can be left in a state
> with still active  events that can cause spurious and/or
> unhandled interrupts that appear as non-fatal kernel errors
> like below, that can be confusing and misleading:
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Add shutdown routine
      https://git.kernel.org/will/c/316f862a787c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
