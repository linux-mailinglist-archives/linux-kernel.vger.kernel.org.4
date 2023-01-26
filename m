Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7D67D4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjAZStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjAZSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:49:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB751C47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E647561797
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4704CC433EF;
        Thu, 26 Jan 2023 18:49:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Kconfig: fix spelling
Date:   Thu, 26 Jan 2023 18:49:24 +0000
Message-Id: <167475894592.1012628.14001537359436762504.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124181605.14144-1-rdunlap@infradead.org>
References: <20230124181605.14144-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 10:16:05 -0800, Randy Dunlap wrote:
> Fix spelling typos in arm64: (reported by codespell)
> s/upto/up to/
> s/familly/family/
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Kconfig: fix spelling
      https://git.kernel.org/arm64/c/11fc944f7e14

-- 
Catalin

