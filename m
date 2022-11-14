Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6C628975
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiKNTew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:34:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92483E1F;
        Mon, 14 Nov 2022 11:34:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFE461407;
        Mon, 14 Nov 2022 19:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76103C433B5;
        Mon, 14 Nov 2022 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454489;
        bh=3gsXi8WoJjuGq99Xc/lPhUN4i2m7uDZIanUmarE0J6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tf+akrDFrRb8Bj+dSLsU4YQJSKZdUcav41hNYcAETjZ+5103BhqPijGDbHH8wW0RZ
         W5qe5zMZuxVZlECwC+uJscNvo9G73Qx6PzFThn/Pur/PyHkBf7uY6rADnZQB5zMuye
         uFgxQHD8q4SdCb39aPIuIjhF3ivKb50O42LE5qMg3URBuEHOhl2HBICOjCsj3pWfzQ
         8stz5fxrKB2PWaWYDo612kC8jtexkzDMO4wF2EwDUbH3CJ50gjbpv+ZBpyaQznWnZ2
         LiXGxoZd3ubrk9wwAtqCfWwGVmVPlLV4jvKIl6nem3Bt5+3QWku7znbV9UKKQgYMbC
         5eJX9WFGhGhJA==
From:   Will Deacon <will@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        lenb@kernel.org, linux-doc@vger.kernel.org, rafael@kernel.org,
        corbet@lwn.net, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ACPI: Enable FPDT on arm64
Date:   Mon, 14 Nov 2022 19:34:32 +0000
Message-Id: <166844898013.2567037.14312654652103426744.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221109174720.203723-1-jeremy.linton@arm.com>
References: <20221109174720.203723-1-jeremy.linton@arm.com>
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

On Wed, 9 Nov 2022 11:47:20 -0600, Jeremy Linton wrote:
> FPDT provides some boot timing records useful for analyzing
> parts of the UEFI boot stack. Given the existing code works
> on arm64, and allows reading the values without utilizing
> /dev/mem it seems like a good idea to turn it on.
> 
> 

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: Enable FPDT on arm64
      https://git.kernel.org/arm64/c/c2465f95c4e7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
