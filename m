Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51D5F4467
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJDNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJDNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E368250539;
        Tue,  4 Oct 2022 06:38:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1R664Kz4xH2;
        Wed,  5 Oct 2022 00:38:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Baoquan He <bhe@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>, linux-mm@kvack.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20220920122302.99195-1-david@redhat.com>
References: <20220920122302.99195-1-david@redhat.com>
Subject: Re: (subset) [PATCH v1 0/3] coding-style.rst: document BUG() and WARN() rules
Message-Id: <166488986181.779920.10714540040506715558.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:24:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 14:22:59 +0200, David Hildenbrand wrote:
> As it seems to be rather unclear if/when to use BUG(), BUG_ON(),
> VM_BUG_ON(), WARN_ON_ONCE(), ... let's try to document the result of a
> recent discussion.
> 
> Details can be found in patch #1.
> 
> RFC -> v1:
> * "coding-style.rst: document BUG() and WARN() rules ("do not crash the
>    kernel")"
>  -> Rephrase/extend according to John
>  -> Add some details regarding the use of panic()
> * powerpc/prom_init: drop PROM_BUG()
>  -> Added
> * "checkpatch: warn on usage of VM_BUG_ON() and other BUG variants"
>  -> Warn on more variants
> 
> [...]

Patch 2 applied to powerpc/next.

[2/3] powerpc/prom_init: drop PROM_BUG()
      https://git.kernel.org/powerpc/c/c4167aec98524fa4511b3222303a758b532b6009

cheers
