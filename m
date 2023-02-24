Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611D6A02E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjBWGnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBWGnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:43:18 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77461E1D2;
        Wed, 22 Feb 2023 22:43:17 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 383881A00AA3;
        Thu, 23 Feb 2023 14:43:57 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U1hmD38rH2CL; Thu, 23 Feb 2023 14:43:56 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4E8CE1A0088E;
        Thu, 23 Feb 2023 14:43:56 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, kunyu@nfschina.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH] stm32: stm32-hash: Add kmalloc_array allocation check
Date:   Sat, 25 Feb 2023 07:14:29 +0800
Message-Id: <20230224231430.2948-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au>
References: <Y/cBB+q0Ono9j2Jy@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hello senior:
  'rctx->hw_context' is a member of the rctx pointer array object and will pass 'memcpy(out, rctx, sizeof(*rctx)) at the end of the function;  ', copied to the out pointer memory, it cannot be released, I think this patch does an allocation check on the 'rctx->hw_context' pointer should help a bit.


