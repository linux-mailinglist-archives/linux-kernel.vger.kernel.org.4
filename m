Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA46F63C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjEDD4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEDD4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:56:09 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090921BEB;
        Wed,  3 May 2023 20:56:04 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1puQ4E-0051rZ-Dx; Thu, 04 May 2023 11:55:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 May 2023 11:55:43 +0800
Date:   Thu, 4 May 2023 11:55:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] hwrng: virtio - Fix race on data_avail and actual data
Message-ID: <ZFMsvxW+pEZA2EZ7@gondor.apana.org.au>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
 <ede92183-bef3-78a7-abae-335c6c5cca1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede92183-bef3-78a7-abae-335c6c5cca1e@linaro.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 12:19:30PM +0100, Tudor Ambarus wrote:
>
> > Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
> 
> Link: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
> 
> Please add the dashboard link if applying as searching for the syzbot ID
> rarely gives meaningful results.

The syzbot ID is already present in the in the Reported-by tag.
There is no reason to clutter up the commit message with redundant
information.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
