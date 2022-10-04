Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0400D5F445F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJDNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJDNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF054CA0F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:38:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1M6kBdz4xGw;
        Wed,  5 Oct 2022 00:38:47 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ae6aa7fce84f7abcbf67f534271a4a6dd7949b0d.1662543243.git.christophe.leroy@csgroup.eu>
References: <ae6aa7fce84f7abcbf67f534271a4a6dd7949b0d.1662543243.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/nohash: Remove pgd_huge() stub
Message-Id: <166488985737.779920.8762393003008837052.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:24:17 +1100
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

On Wed, 7 Sep 2022 11:34:44 +0200, Christophe Leroy wrote:
> linux/hugetlb.h has a fallback pgd_huge() macro for when
> pgd_huge is not defined.
> 
> Remove the powerpc redundant definitions.
> 
> 

Applied to powerpc/next.

[1/2] powerpc/nohash: Remove pgd_huge() stub
      https://git.kernel.org/powerpc/c/a26494cf4aeb8e9888428a43f55cc486f06f1334
[2/2] powerpc: Rely on generic definition of hugepd_t and is_hugepd when unused
      https://git.kernel.org/powerpc/c/691cdf016d3be6f66a3ea384809be229e0f9c590

cheers
