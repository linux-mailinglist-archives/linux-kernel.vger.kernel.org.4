Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB262FE17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiKRTlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiKRTk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:40:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B5C22B2D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:40:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9998B82504
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FCBC433C1;
        Fri, 18 Nov 2022 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668800453;
        bh=H/1xi2Oo5asaFnMBfBWWh8eGSBtUkjNsibfaJnXgLoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVFZsyPWFLBOmG+qgF1b3FdeJt4Iw6Dug9ZdF1mV43OXlMHRyLEsxCRgcXi8ksXWs
         d7kU2R8HQ4GgNNgOrfpQS7kC1fcdTdTFa6WW+A/8MpljcPY1QMhzxdWYwEQfW4zmwp
         4yFUBRpDG9Ecj23NrSjpVLFBLEA7DAZ0h3UY/NASoVHACUtOFsE1FwSDTh2vPkG20M
         EAHXdBGGKmn+dfezuiMD6Axe/hS6KGW6NN9i4Fh57dXmx2IoCoejpX70PCpG6/BNQ5
         Z508yErjW5xGW1+lVuhMyiDtl/tiosmMqKqYg4kmXu64TiktsSjyq/ozHVYqB1SxiI
         NV8AyqwC7Tgbg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64/mm: Drop idmap_pg_end[] declaration
Date:   Fri, 18 Nov 2022 19:40:37 +0000
Message-Id: <166878081548.1782798.8465276983252414917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116084302.320685-1-anshuman.khandual@arm.com>
References: <20221116084302.320685-1-anshuman.khandual@arm.com>
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

On Wed, 16 Nov 2022 14:13:02 +0530, Anshuman Khandual wrote:
> idmap_pg_end[] is not used anywhere, hence just drop its declaration.
> 
> 

Applied to arm64 (for-next/trivial), thanks!

[1/1] arm64/mm: Drop idmap_pg_end[] declaration
      https://git.kernel.org/arm64/c/d3d10f0d370c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
