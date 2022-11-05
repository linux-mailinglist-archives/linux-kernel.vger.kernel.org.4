Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96461A6FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKECpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKECpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:45:52 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB3BC11;
        Fri,  4 Nov 2022 19:45:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1or9BG-00AM47-Ol; Sat, 05 Nov 2022 10:45:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Nov 2022 10:45:47 +0800
Date:   Sat, 5 Nov 2022 10:45:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "yekai (A)" <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: hisilicon/qm - modify the process of regs dfx
Message-ID: <Y2XOW9vBOtZZu4Vf@gondor.apana.org.au>
References: <20221029094801.43843-1-yekai13@huawei.com>
 <20221029094801.43843-2-yekai13@huawei.com>
 <Y2TV6Cz7XPYj4SZO@gondor.apana.org.au>
 <851c1b30-ee30-145b-c77c-17166cd6e426@huawei.com>
 <63b64287-b402-c4c9-c977-e8d76dcbe686@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b64287-b402-c4c9-c977-e8d76dcbe686@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 09:39:10AM +0800, yekai (A) wrote:
>
> This patch-set does not modify the logic. Can i add an extra patch to delete this redundant line next version?

Please resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
