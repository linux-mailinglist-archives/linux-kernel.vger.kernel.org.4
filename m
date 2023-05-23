Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741E570E963
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEWXMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03980DA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA7460E9D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F5C433D2;
        Tue, 23 May 2023 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684883571;
        bh=Yk6ohM0+0C0f//78Ndc/qWNk7Gzg1jlQjvY3wzS6MIA=;
        h=Date:From:To:Subject:From;
        b=ODOxj25PloBnZ5bxJdiQ7Kmw/7j7pZjDykNK8L9yi3IoTV093U4ViN7xQUaa9ricv
         jAZXypgIE44pdOKfRpR/2slEq+NfzFvucb9GKVkAYobiQK4/hYVEupyKUr3144MKHh
         X3a2/CP9oRGZbY9i6JvflBlWJ1BJ8j0ZM6rUyWazJ3KD6jS2lFlJY/N2mKQJHRGNhp
         5wnetxVc/oQ+gDb8V78t++BzzjqnTVBvTeaCLXH9YbPD2g4G8fyHUqFOpYwPrwOjZe
         r5ev7Q6qALHF0mrojAHsgP+irTVvFk+F5vBAAnZZY1K6aidEiGWbdTAmp+v88odTck
         FEntY4iOYoXmw==
Date:   Tue, 23 May 2023 16:12:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 16.0.4 uploaded
Message-ID: <20230523231250.GA894339@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have built and uploaded LLVM 16.0.4 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

As far as I am aware, there are no changes in this release that strictly
affect the kernel. If there are any issues found, please let us know via
email or https://github.com/ClangBuiltLinux/linux/issues/new, as we only
have two more releases in the 16.x cycle to get regressions fixed.

Cheers,
Nathan
