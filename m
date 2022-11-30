Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDEF63D21F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiK3JiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiK3JhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A16DFF6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtp3ymsz4xTy;
        Wed, 30 Nov 2022 20:34:10 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Xiu Jianfeng <xiujianfeng@huawei.com>, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220911084344.196353-1-xiujianfeng@huawei.com>
References: <20220911084344.196353-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH] powerpc: pasemi: add __init/__exit annotations to module init/exit funcs
Message-Id: <166980023346.3017288.17763205017508366460.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:53 +1100
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

On Sun, 11 Sep 2022 16:43:44 +0800, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: pasemi: add __init/__exit annotations to module init/exit funcs
      https://git.kernel.org/powerpc/c/d87a233717da400792fa601b29fa74a7d28e03c2

cheers
