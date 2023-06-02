Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16657208C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjFBSFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjFBSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E679F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DDB964F54
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34B4C4339B;
        Fri,  2 Jun 2023 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685729101;
        bh=5soD935rIUEaVUUyAuaL2xfQUYxGKk9PRg0iyd9bILM=;
        h=Date:From:To:Subject:From;
        b=c8iT3i6TA0OQU1sd6K6H/Pjm0hnN6t7H/PKIXQWwHjiFrVFv/JAKtAOITtD/JLE8R
         WOPQpA3i5BAnEo0m/wRhVvfsLQEfolnbCEA/F9b3gBqshhyw+ntSfoZX0Zbdb3q7/a
         D+W9jvn8xcA2u7AlnKEhMlgaVpiXwXh5oTfZ8vqhQxBE41TWrOAEsOL7zzGeSFrH6S
         ek5/STn9w5B/j/KlFsYc7f1EoYWx9Jc+/V6QLbyfZadIiOKNyyGsAqIOqfH1i2QAVN
         YzzJ/3mTP2DfkJnBo2JPmz1tfENBLIaQRQkgkysGVysyxKBwwVOmUYwE9wFDYlb5BB
         IDDL5dF/jAYPQ==
Date:   Fri, 2 Jun 2023 11:04:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 16.0.5 uploaded
Message-ID: <20230602180459.GA574022@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 16.0.5 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

As far as I am aware, there are no changes in this release that strictly
affect the kernel. If there are any issues found, please let us know via
email or https://github.com/ClangBuiltLinux/linux/issues/new, as we only
have one more release in the 16.x cycle to get regressions fixed.

Cheers,
Nathan
