Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC620632D08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKUTfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUTfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:35:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A628ECB9F5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:35:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D762B815D5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E865C433C1;
        Mon, 21 Nov 2022 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669059299;
        bh=wLnwbGHEk3iL3zygHwndj8SnNJ2TAACsLf1mS5xVblw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ch6KYSa9v3BifBwN8QVQMpid4EDWpeFAtbXwREoSdGuNtpoSBcYqKBerAFy54Es2P
         sOEBtWzbajDRUYEElnTbFTsM4FYerBPXe77fhGcF6tAIcDmywrBbQcEfARG+LOdfds
         Cd+J4rwUs+DHMB/OToOdyszVcIf5kKbKNy260ltcmBPTZzEjDFNpvAfd2Y4yLwzvMv
         7YH34R2t0mGA7hIT8L8muyRNXz8d8GLrdkIGtiS0pJ0AL5YspAQEJOX8eSapz4SQzO
         dbqXm6jT7Fntk16MTZ7y6OiYTjb6OHUT5LdWHliH8ZFvUsRfE84pMahEjHJjhLlpCS
         YW2vb4kltWBQQ==
From:   Will Deacon <will@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Qi Liu <liuqi6124@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU maintainers
Date:   Mon, 21 Nov 2022 19:34:42 +0000
Message-Id: <166903653213.1385977.2589292771485689967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
References: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
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

On Fri, 18 Nov 2022 14:54:00 +0800, Shaokun Zhang wrote:
> Now Qi Liu has left HiSilicon and will no longer access to the
> necessary hardware and document, remove the mail and thanks for
> her's work.
> While add the new maintainer Jonathan Cameron, He is skilled with
> kernel and enough knowledge of the driver.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] MAINTAINERS: Update HiSilicon PMU maintainers
      https://git.kernel.org/will/c/dcc7f001b44c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
