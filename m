Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ED85BE016
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiITI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiITI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:29:03 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4B6559A;
        Tue, 20 Sep 2022 01:28:39 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oaYc5-006W38-7B; Tue, 20 Sep 2022 18:28:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Sep 2022 16:28:17 +0800
Date:   Tue, 20 Sep 2022 16:28:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        "Muszynski, Damian" <damian.muszynski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <Yyl5oVDm18JL7/0v@gondor.apana.org.au>
References: <20220919081259.714b81f8@canb.auug.org.au>
 <CY5PR11MB6366B542EEDCEFCC97F00D2C824D9@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366B542EEDCEFCC97F00D2C824D9@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:38:44AM +0000, Cabiddu, Giovanni wrote:
> My bad. Apologies.
> 
> @Herbert, can this be replaced in your history? The correct tag is
>     Fixes: d370cec32194 ("crypto: qat - Intel(R) QAT crypto interface")

Hi Giovanni:

Please take this into consideration for future submissions.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
