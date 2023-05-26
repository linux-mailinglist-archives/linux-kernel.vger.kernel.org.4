Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C597123CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242645AbjEZJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEZJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2567F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 811DE64E9F
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC933C433D2;
        Fri, 26 May 2023 09:37:31 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: Add decode of ISS2 to data abort reports
Date:   Fri, 26 May 2023 10:37:29 +0100
Message-Id: <168509384592.1547825.15647313372998051132.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
References: <20230417-arm64-iss2-dabt-decode-v3-0-c1fa503e503a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 15:05:13 +0900, Mark Brown wrote:
> We provide fairly detailed decode of ESR for data aborts but do not
> currently cover the information reported in ISS2 which has had quite a
> bit of additional information added to it by recent architecture
> extensions.  Add decode for this information to aid in debugging, for
> completeness including features we don't actually use yet.
> 
> 
> [...]

Applied to arm64 (for-next/iss2-decode), thanks!

[1/2] arm64/esr: Use GENMASK() for the ISS mask
      https://git.kernel.org/arm64/c/de847275449a
[2/2] arm64/esr: Add decode of ISS2 to data abort reporting
      https://git.kernel.org/arm64/c/1f9d4ba6839c

-- 
Catalin

