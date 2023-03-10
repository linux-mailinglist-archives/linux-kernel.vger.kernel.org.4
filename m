Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FEC6B3DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCJLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCJLcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:32:18 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D41091EC;
        Fri, 10 Mar 2023 03:32:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paayo-002YAO-QS; Fri, 10 Mar 2023 19:32:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:32:10 +0800
Date:   Fri, 10 Mar 2023 19:32:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        franck.lenormand@nxp.com, vijayb@linux.microsoft.com,
        code@tyhicks.com
Subject: Re: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Message-ID: <ZAsVOtJcwqc1qe62@gondor.apana.org.au>
References: <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
 <20230228183758.448396-1-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228183758.448396-1-meenakshi.aggarwal@nxp.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:07:58AM +0530, meenakshi.aggarwal@nxp.com wrote:
> From: Horia Geanta <horia.geanta@nxp.com>
> 
> Issues:
> - Job ring device is busy when do kexec reboot
> - Failed to flush job ring when do system suspend-resume
> 
> Fix:
> Flush the job ring to stop the running jobs.
> 
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/crypto/caam/jr.c | 55 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
