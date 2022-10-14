Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30665FEA82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJNI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJNI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:26:12 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7741C208B;
        Fri, 14 Oct 2022 01:26:07 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ojG0z-00EdPa-VO; Fri, 14 Oct 2022 19:25:59 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Oct 2022 16:25:57 +0800
Date:   Fri, 14 Oct 2022 16:25:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/6] crypto: benchmark - add the crypto benchmark
Message-ID: <Y0kdFaXQtsJxgrC0@gondor.apana.org.au>
References: <20220919120537.39258-1-shenyang39@huawei.com>
 <Yyl5yKQCAgPBbFd7@gondor.apana.org.au>
 <3dd984c1-d17f-0a6a-c52e-87e161f867fc@huawei.com>
 <YzZ12Y/kEF4DrQV6@gondor.apana.org.au>
 <09d0686b-1955-c63d-c02d-fb0d2db42672@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d0686b-1955-c63d-c02d-fb0d2db42672@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 09:43:40AM +0800, Yang Shen wrote:
>
> Got it. I'll try to support this on the tcrypt.

Before you get too far into this, please note that I have no
preference as to whether you go with tcrypt or your new benchmark
code.

My only requirement is that we pick one mechanism.

But obivously others might have a preference so you should try
to produce RFCs as early as possible.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
