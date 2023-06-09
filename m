Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289B72A319
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjFITa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjFITaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411030FE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8920965B55
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C24C433D2;
        Fri,  9 Jun 2023 19:30:22 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Cc:     Will Deacon <will@kernel.org>, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date:   Fri,  9 Jun 2023 20:30:19 +0100
Message-Id: <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515060259.830662-1-bhe@redhat.com>
References: <20230515060259.830662-1-bhe@redhat.com>
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

On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> In v5 patch, Catalin helped review and acked the patch. However, an
> uninitialized local varilable is warned out by static checker when Will
> tried to merge the patch. And Will complained the code flow in
> reserve_crashkernel() is hard to follow, required to refactor. While
> when I tried to do the refactory, I feel it's not easy, the existing
> several cases causes that.
> 
> [...]

Applied to arm64 (for-next/kdump).

I reworte some of the paragraphs in the documentation patch, removed
some sentences to make it easier to read (some details were pretty
obvious). Please have a look, if you think I missed something important,
just send a patch on top. Thanks.

[1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
      https://git.kernel.org/arm64/c/6c4dcaddbd36
[2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
      https://git.kernel.org/arm64/c/03dc0e05407f

-- 
Catalin

