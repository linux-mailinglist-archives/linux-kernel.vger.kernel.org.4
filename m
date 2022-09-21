Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2F5BF759
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIUHOg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Sep 2022 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIUHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:14:30 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6882D10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:14:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 452E0615C9E8;
        Wed, 21 Sep 2022 09:14:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uqfChHppESoA; Wed, 21 Sep 2022 09:14:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CD736615C9E5;
        Wed, 21 Sep 2022 09:14:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sKKJxMACFNv4; Wed, 21 Sep 2022 09:14:23 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A28C861418B6;
        Wed, 21 Sep 2022 09:14:23 +0200 (CEST)
Date:   Wed, 21 Sep 2022 09:14:23 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     davidgow <davidgow@google.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        dave hansen <dave.hansen@linux.intel.com>,
        torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kunit-dev <kunit-dev@googlegroups.com>, x86 <x86@kernel.org>,
        Lukas Straub <lukasstraub2@web.de>,
        Randy Dunlap <rdunlap@infradead.org>
Message-ID: <290835862.246902.1663744463482.JavaMail.zimbra@nod.at>
In-Reply-To: <20220921064855.2841607-1-davidgow@google.com>
References: <20220921064855.2841607-1-davidgow@google.com>
Subject: Re: [PATCH v2] arch: um: Mark the stack non-executable to fix a
 binutils warning
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch: um: Mark the stack non-executable to fix a binutils warning
Thread-Index: yN/1TZSRNS5/MluFQBII4RZMgomCPA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "davidgow" <davidgow@google.com>
> 
> Changes since v1:
> http://lists.infradead.org/pipermail/linux-um/2022-August/004234.html
> - Pass the -z noexecstack and --no-warn-rwx-segments flags as LDFLAGS,
>  rather than as CFLAGS via -Wl
> - Check that --no-warn-rwx-segments exists with the ld-option function
>  (Thanks Richard)
> - Add Lukas and Randy's tags.

Now it passes the test. :)
Applied.

Thanks,
//richard
