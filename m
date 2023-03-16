Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155D6BD2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCPOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCPOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:55:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD0C97FD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:55:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32GEt4Al021811
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 10:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678978507; bh=yhm5b9mPFSKMOcDgABpZ+qzHWLja8JAG7RVsNaKkefU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YQ8egNPLdVqlLZ77H2rkpBvA2nj67hh5Teyl6FjnMo4/7ASY4BGgn+yM/BGbIm6AI
         DLjbh7NgHioTrS83WSaXaRnxKMFvzxfuliUhwo7f1GqHupvR5vGdeIJheizTQ+BSaa
         Sc7LddU3a366oWKJxzld0h9v2r1Oqki0i53vMVFXZettnWnulPrYy3Y40HYkZ++1Rq
         5VfZWUFLSfOjen4XXLYacw0sm2RkJMlCwoYsJvw9+nj1HbroDBZSOdbnfbeGcIk7oK
         PfNsmajaCok+qZTp1io6rus/hQxWa4sMtoLeEU5tyNeTuFvIT07pW5uCUrdnL5psS7
         OMIk8Z4Whz1pw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F16D815C33A7; Thu, 16 Mar 2023 10:55:03 -0400 (EDT)
Date:   Thu, 16 Mar 2023 10:55:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] Documentation: submitting-patches: Disqualify style
 fixes from Fixes: tag
Message-ID: <20230316145503.GN860405@mit.edu>
References: <20230316082034.14191-1-bagasdotme@gmail.com>
 <fe15da9c-d03f-ccc3-ea6a-2b6401496aad@linaro.org>
 <ZBLSrXrxrV4dRjak@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBLSrXrxrV4dRjak@kroah.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:26:21AM +0100, Greg KH wrote:
> > Coding style is not a bug, but that's obvious.
> 
> I agree, let's not make this file even longer than it is if at all
> possible.
>

I've actually been wondering if there is some way to split the file
since it's quite large already.  It's been unclear to me whether that
would make it easier or harder to find stuff though.  :-/

      	      	     	       	  - Ted
