Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F785E6D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIVUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIVUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3007210952A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C64CFB8228B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA38AC433C1;
        Thu, 22 Sep 2022 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663878792;
        bh=2EsR6y0kd2zPXCurtKzqwwpUTH7RYpYFxsD98hPfHPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFggxwcff4X5OOTDZQKAledAe3uQe57zK3FO/FDYWQSFLjst25oCL2qKOYjW/i+dq
         /wXlr8fQn0M2kCMzZJMhAli135kdXdfwdaBIzLo0MCMiA4x2CIxJfwA14xaQ2Soy+J
         GnYnd+cxSHzp61B7W3XscFs8p0PIpjvQSrJGpLn1lKeSNZnkisYLxFQUsVMoeQmRfU
         QFspcPOsUfaIDD1i0Wxa5lVnnkf59mI12FDnqBuKfH/wUfazxpTg21M3SeVBasmT7c
         U7mntXHzN1/ngj5cyjR4KhjdFQAj2s6Dx95xa7d/OyJdltQbn065AnyFtwuIHH/PuI
         Ybc+xFMfmFQgw==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, patches@amperecomputing.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] perf/arm-cmn: Add more bits to child node address offset field
Date:   Thu, 22 Sep 2022 21:33:03 +0100
Message-Id: <166385340032.184614.10425827109590080389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
References: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
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

On Mon, 8 Aug 2022 12:54:55 -0700, Ilkka Koskinen wrote:
> CMN-600 uses bits [27:0] for child node address offset while bits [30:28]
> are required to be zero.
> 
> For CMN-650, the child node address offset field has been increased
> to include bits [29:0] while leaving only bit 30 set to zero.
> 
> Let's include the missing two bits and assume older implementations
> comply with the spec and set bits [29:28] to 0.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Add more bits to child node address offset field
      https://git.kernel.org/arm64/c/05d6f6d346fe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
