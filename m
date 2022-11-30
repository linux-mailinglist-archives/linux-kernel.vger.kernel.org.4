Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423BF63D1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiK3Jbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiK3Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F354C51C23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqd3FGjz4xND;
        Wed, 30 Nov 2022 20:31:25 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Chen Lifu <chenlifu@huawei.com>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, zhengzucheng@huawei.com,
        christophe.leroy@csgroup.eu, nick.child@ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20221103070122.340773-1-chenlifu@huawei.com>
References: <20221103070122.340773-1-chenlifu@huawei.com>
Subject: Re: [PATCH v3 -next] powerpc/powermac: Fix symbol not declared warnings
Message-Id: <166980025492.3017288.18013184822257737231.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:14 +1100
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

On Thu, 3 Nov 2022 15:01:22 +0800, Chen Lifu wrote:
> 1. ppc_override_l2cr and ppc_override_l2cr_value are only used in
>     l2cr_init() function, remove them and used *l2cr directly.
> 2. has_l2cache is not used outside of the file, so mark it static and
>     do not initialise statics to 0.
> 
> Fixes the following warning:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powermac: Fix symbol not declared warnings
      https://git.kernel.org/powerpc/c/59dc2d94bc12dac53a5d2368ad97ca24e7cc5682

cheers
