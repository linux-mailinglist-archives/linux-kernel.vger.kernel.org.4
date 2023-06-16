Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF32733797
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjFPRpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD42D4C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1C062526
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1576C433C0;
        Fri, 16 Jun 2023 17:45:10 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] arm64/fpsimd: Exit streaming mode when flushing tasks
Date:   Fri, 16 Jun 2023 18:45:08 +0100
Message-Id: <168693750644.2414106.2496939341668921695.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607-arm64-flush-svcr-v2-1-827306001841@kernel.org>
References: <20230607-arm64-flush-svcr-v2-1-827306001841@kernel.org>
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

On Fri, 09 Jun 2023 23:43:41 +0100, Mark Brown wrote:
> Ensure there is no path where we might attempt to save SME state after we
> flush a task by updating the SVCR register state as well as updating our
> in memory state. I haven't seen a specific case where this is happening or
> seen a path where it might happen but for the cost of a single low overhead
> instruction it seems sensible to close the potential gap.
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/fpsimd: Exit streaming mode when flushing tasks
      https://git.kernel.org/arm64/c/af3215fd0230

-- 
Catalin

