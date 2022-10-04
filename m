Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5675F4463
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJDNjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJDNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2025071A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:38:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1Q5R2rz4xFv;
        Wed,  5 Oct 2022 00:38:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <92254499430d13d99e4a4d7e9ad8e8284cb35380.1662544974.git.christophe.leroy@csgroup.eu>
References: <92254499430d13d99e4a4d7e9ad8e8284cb35380.1662544974.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Reduce redundancy in pgtable.h
Message-Id: <166488985962.779920.6663157478834315854.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:24:19 +1100
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

On Wed, 7 Sep 2022 12:05:01 +0200, Christophe Leroy wrote:
> PAGE_KERNEL_TEXT, PAGE_KERNEL_EXEC and PAGE_AGP are the same
> for all powerpcs.
> 
> Remove duplicated definitions.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Reduce redundancy in pgtable.h
      https://git.kernel.org/powerpc/c/b997b2f57cae396448bb62c428efa4b112dd90ed

cheers
