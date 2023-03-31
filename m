Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A26D1AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCaIrS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:47:16 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFE468B;
        Fri, 31 Mar 2023 01:47:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BB2B061989EA;
        Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JxIpvu6PJe5z; Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27F0961989E6;
        Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GaVCXV-EezY9; Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E485264548AA;
        Fri, 31 Mar 2023 10:37:31 +0200 (CEST)
Date:   Fri, 31 Mar 2023 10:37:31 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     davidgow <davidgow@google.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>,
        llvm@lists.linux.dev,
        Rust for Linux Kernel <rust-for-linux@vger.kernel.org>,
        kunit-dev <kunit-dev@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        mingo <mingo@redhat.com>, tglx <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <2128345299.463203.1680251851757.JavaMail.zimbra@nod.at>
In-Reply-To: <CABVgOS=pr=jXq4qRrKaCy47xczDaFXFKCPanVvaZ+MfQmtwK8A@mail.gmail.com>
References: <20230318041555.4192172-1-davidgow@google.com> <CABVgOS=pr=jXq4qRrKaCy47xczDaFXFKCPanVvaZ+MfQmtwK8A@mail.gmail.com>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old
 GCC bugs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch:um: Only disable SSE on clang to work around old GCC bugs
Thread-Index: KRbe3B8OBuNHdw1xcXwa3ZqHhmy+Sw==
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "davidgow" <davidgow@google.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
> Any chance we could get this picked up as a fix for 6.3? The UML build
> is still broken with older gcc versions.

Sure. Just got flooded with other stuff. :-S

Thanks,
//richard
