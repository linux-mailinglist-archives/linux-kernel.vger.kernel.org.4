Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDC63F02F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiLAMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLAMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:10:23 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B294568;
        Thu,  1 Dec 2022 04:10:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p0iOF-002pZT-AB; Thu, 01 Dec 2022 20:10:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 Dec 2022 20:10:07 +0800
Date:   Thu, 1 Dec 2022 20:10:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Message-ID: <Y4iZn9jC3VqBHEtU@gondor.apana.org.au>
References: <20221028210527.never.934-kees@kernel.org>
 <Y2TVXDfQUwlYFv9S@gondor.apana.org.au>
 <20221201115244.GC69385@mutt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201115244.GC69385@mutt>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:52:44PM +0100, Anders Roxell wrote:
.
> I think that was fixed in sparse release v0.5.1 [1]. The workaround 'if
> (len)' was introduced back in 2011, and the sparse release v0.5.1 was
> done in 2017. So it should probably be safe to remove the 'if (len)'  or
> what do you think?

Could you please send a patch? :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
