Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA7732FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjFPLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345031AbjFPLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17030EA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0855062A49
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA7CC433C9;
        Fri, 16 Jun 2023 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686914626;
        bh=PWWGLuOKsOYFe8snB/LmQXIUw6Fv8YmBQrBiadFRE/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KO74mTPJp1j+0ktjfSJMUnTRU6ChrjJYsUsirZtsnEcoWv+KuvtaejzY0fv6G5R5b
         XjDKhxYWsCiWJ2nEU+rfJ+kYhN1+QBq3z1prPHTrQvVlPH6tw0YbR5aI2IYFB6GJwz
         M/jTQfGV07hj55MFqZVMOOAGUl3wYw3o4Nsxsl7q7Wdjnxn2kKf+UHJe5bae8p5mUz
         9tJs+NZiSr5myBDdeLCa0OS0lUUwA+mx6MuunQw0nP1LIFZz9FNjh333H4z5H4DI6E
         Nr3s8gDY7P8/xmQTbJTiQIaKnA3JCPZabhNqrdnvKfkwQOYfn05zYcLZHdubl1xxQh
         CVKUGxrL1h+kw==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Add missing MODULE_DEVICE_TABLE
Date:   Fri, 16 Jun 2023 12:23:38 +0100
Message-Id: <168690795268.3932384.14110372820959992926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230615232630.304870-1-ilkka@os.amperecomputing.com>
References: <20230615232630.304870-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 16:26:30 -0700, Ilkka Koskinen wrote:
> Add missing MODULE_DEVICE_TABLE definition to generate modalias, which
> enables module autoloading.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: Add missing MODULE_DEVICE_TABLE
      https://git.kernel.org/will/c/7e51d05e43f1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
