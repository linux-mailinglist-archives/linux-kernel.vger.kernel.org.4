Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D01D5B373B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiIIMLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiIIMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA212FB9D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDl2RKgz4xcS;
        Fri,  9 Sep 2022 22:10:15 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     jk@ozlabs.org, paulus@samba.org, arnd@arndb.de,
        Liang He <windhl@126.com>, benh@kernel.crashing.org,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220619072335.4067728-1-windhl@126.com>
References: <20220619072335.4067728-1-windhl@126.com>
Subject: Re: [PATCH] powerpc/cell: Fix refcount leak bugs
Message-Id: <166272523074.2076816.5407553903697659959.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:07:10 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 15:23:35 +0800, Liang He wrote:
> We should use of_node_put() for of_find_node_by_path() and
> of_find_node_by_phandle() to keep refcount balance.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/cell: Fix refcount leak bugs
      https://git.kernel.org/powerpc/c/d9e1c6104d87d4027133b28f5ccab8f999830acd

cheers
