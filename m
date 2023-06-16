Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C606A73309B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbjFPMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjFPL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2482695;
        Fri, 16 Jun 2023 04:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C2E60DFF;
        Fri, 16 Jun 2023 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD10BC433C8;
        Fri, 16 Jun 2023 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686916794;
        bh=B6Rr5OWK6EHnl9zJOJIISz+kUh6ZRV5eZSzSl1yUNh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZHzKmshlSIPcpErot5jXxWE3JoJci/pQqWmfpbg1U7Y2ocb1+n5C78xMHgZqUMPI
         En7/vNpZ/YoysZArZ+VAstSN6cQte+dFSZOF5YaD9TmNiyMvHh7tC/apXD2tHKInrh
         Y7UxUys6DVqVv/qTftrJPgUqYVUoBmkjcUYfMdquTU00Gaf6074GRzsI2oLBC6Ocu7
         l4/ygmcDe5s61apfPkSDAKIldl7KR47S3TPy/Gaq2H7JUR0VpRJcL3YfBZmL5ebZsd
         Zz0eK3Z//T8wU4vJ1uuwcw2v2Rx/dJ/EgELPYf+ANZE+C/unn5GC0vxjl5auoOPBet
         t9q6XEJmeXnWg==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Junhao He <hejunhao3@huawei.com>,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, yangyicong@huawei.com,
        linux-arm-kernel@lists.infradead.org, prime.zeng@hisilicon.com,
        linux-doc@vger.kernel.org, shenyang39@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v5 0/3] Add support for HiSilicon SoC uncore PMU
Date:   Fri, 16 Jun 2023 12:59:47 +0100
Message-Id: <168691485865.2084286.3095107717244593062.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230615125926.29832-1-hejunhao3@huawei.com>
References: <20230615125926.29832-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 20:59:23 +0800, Junhao He wrote:
> Add support for HiSilicon UC/H60PA/PAv3 PMU driver.
> 
> PAv3 PMU: Compared with the PAv2 PMU, the PAv3 PMU has different event.
> The PAv3 PMU removed some events which are supported by PAv2 PMU. The
> older PA PMU driver will probe v3 as v2. Add the HISI0275 HID for PAv3
> PMU to distinguish different.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] drivers/perf: hisi: Add support for HiSilicon H60PA and PAv3 PMU driver
      https://git.kernel.org/will/c/1a51688474c0
[2/3] drivers/perf: hisi: Add support for HiSilicon UC PMU driver
      https://git.kernel.org/will/c/312eca95e28d
[3/3] docs: perf: Add new description for HiSilicon UC PMU
      https://git.kernel.org/will/c/ea8d1c062a0e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
