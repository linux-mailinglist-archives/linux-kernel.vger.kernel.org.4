Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1167425A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjASTLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjASTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:10:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C23966FF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E9A61D5E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B16C433D2;
        Thu, 19 Jan 2023 19:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155336;
        bh=3cUhLzXxcWpiBOISDIy7rTTm1YsCJJKlzEBoXxcxHKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dL+SFNlGoMnFnn7bVlR4s++fdCk533/L8Rae99pMjozeAhwrXYkMivmpkb/pAaI/2
         SPaemJxhJ2r78xKj8pzY6sKEgaoF9MuWOG8L/DxTDXP2d4lR8Ml2OMjpPJyThHhnh9
         /X+Sl8hhCARKYVDLY4XWqRdnpM7AM3cc6rcObeHVB24d0LFfI1GNHPg6JMqUxopXQO
         apRtbp/Grsy+kXrhPI4JVZwRZ4hbD6jLLtlKDfkpRhneH7joWu9q5emkRS9pIpesI+
         uOVFmppCVvv4d7HkNsFkCElDrrBN8RzFs4Z48/b+vzK2nXntRKDvxZEk5Xa2gstzf0
         3Ou+4VkBF0CtA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, bbhushan2@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com
Subject: Re: [PATCH] perf/marvell: Add ACPI support to TAD uncore driver
Date:   Thu, 19 Jan 2023 19:08:33 +0000
Message-Id: <167415195853.3429321.6100368201120973057.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221209053715.3930071-1-gthiagarajan@marvell.com>
References: <20221209053715.3930071-1-gthiagarajan@marvell.com>
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

On Fri, 9 Dec 2022 11:07:15 +0530, Gowthami Thiagarajan wrote:
> Add support for ACPI based device registration so that the driver
> can be also enabled through ACPI table.
> While at that change the DT specific API's to device_* API's so that
> both DT based and ACPI based probing works.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/marvell: Add ACPI support to TAD uncore driver
      https://git.kernel.org/will/c/093cf1f62fe8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
