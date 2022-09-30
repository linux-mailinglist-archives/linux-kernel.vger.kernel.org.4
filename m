Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6862D5F03F2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiI3EyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiI3EyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:54:09 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F89120BE1;
        Thu, 29 Sep 2022 21:53:33 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oe7zt-00A3yT-LX; Fri, 30 Sep 2022 14:51:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Sep 2022 12:51:37 +0800
Date:   Fri, 30 Sep 2022 12:51:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/6] crypto: benchmark - add the crypto benchmark
Message-ID: <YzZ12Y/kEF4DrQV6@gondor.apana.org.au>
References: <20220919120537.39258-1-shenyang39@huawei.com>
 <Yyl5yKQCAgPBbFd7@gondor.apana.org.au>
 <3dd984c1-d17f-0a6a-c52e-87e161f867fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd984c1-d17f-0a6a-c52e-87e161f867fc@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:19:18PM +0800, Yang Shen wrote:
>
> I know the tcrypt.ko has the speed test cases. But the tcrypt.ko test case
> is fixed.
> If I understand correctly, the design model of tcrypt.ko is test the
> algorithms with
> determined case conditions. It can provide some standardized testing to
> ensure
> that the implementation of the algorithm meets the requirements. This is a
> reasonable developer test tool, but it is not flexible enough for testers
> and users.

How about improving tcrypt then? We're not going to have two things
in the kernel that do the same thing unless you provide a clear path
of eliminating one of them.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
