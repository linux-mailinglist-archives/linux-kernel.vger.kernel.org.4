Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBB6EFDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjDZXXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDZXXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874433A90;
        Wed, 26 Apr 2023 16:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 240B96308C;
        Wed, 26 Apr 2023 23:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A4CC4339B;
        Wed, 26 Apr 2023 23:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682551413;
        bh=ljfhtZUXSaQHweOFdXEqbHy6V/WG7H3gj8DTqCSLU4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7ysqy1cyC5qk+5uCIMUWE4azLykmQqFV/eT3GtTTFLLHrGb2LGy2Cw1aSYvgGsiU
         jC4bTHSc4HZBA12fBSlPObnA++Kr+Y0C8JZ2y0Mkc7DW2vj+pymGJRh5vh27NRt9sQ
         X3zYYFbvGBwpmqA6SV7V/vJj5f2LucE8QPlWw3M1z9rrNZX9wKyepUbxQb4YOi9OlX
         FIZDy1mFIyqkDRVUK59+RfzdjIjDJoZMBEVi+76sBwdUeYw/e+F0hjD3/4sw8vxXpU
         GiT1+6oB8BDn+qMZEBqaEBlW5vgD44v8CzHLdhVcTOIklj9ZdV/ZwjDD4oDNfDyiEZ
         i8+WC/yAE9uvQ==
Date:   Wed, 26 Apr 2023 16:23:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Message-ID: <20230426232331.GB65659@sol.localdomain>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
 <20230426225550.GA65659@sol.localdomain>
 <7664296.GXAFRqVoOG@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7664296.GXAFRqVoOG@diego>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 01:20:31AM +0200, Heiko Stübner wrote:
> But for me, this small bit of scalar crypto is also sort of a stepping
> stone :-). Previous versions [0] already included patches using the
> vector crypto extensions too, I just split that into a separate thing,
> as _this_ series actually uses ratified extensions :-)
> 
> 
> Heiko
> 
> 
> 
> [0] https://lore.kernel.org/lkml/20230313191302.580787-12-heiko.stuebner@vrull.eu/T/

That patchset wasn't sent to linux-crypto.  Can you make sure to include
linux-crypto@vger.kernel.org on any subsequent patchsets?  Thanks!

- Eric
