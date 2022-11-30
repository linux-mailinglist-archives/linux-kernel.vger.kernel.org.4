Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBA63D1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiK3JcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiK3Jbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A05B85B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYql064Fz4x1R;
        Wed, 30 Nov 2022 20:31:30 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ec79f462a3bfa8365b7df505e574d5d85246bc68.1646818177.git.christophe.leroy@csgroup.eu>
References: <ec79f462a3bfa8365b7df505e574d5d85246bc68.1646818177.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove find_current_mm_pte()
Message-Id: <166980022119.3017288.6532732356016650095.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 10:29:50 +0100, Christophe Leroy wrote:
> Last usage of find_current_mm_pte() was removed by
> commit 15759cb054ef ("powerpc/perf/callchain: Use
> __get_user_pages_fast in read_user_stack_slow")
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Remove find_current_mm_pte()
      https://git.kernel.org/powerpc/c/e75d07bd8303588c33e6f1f180a9081fb58c872e

cheers
