Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73C7277DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjFHGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjFHGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331CD198C;
        Wed,  7 Jun 2023 23:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D0B63FCB;
        Thu,  8 Jun 2023 06:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6545C433EF;
        Thu,  8 Jun 2023 06:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686207259;
        bh=PCwkSliYcR8EwEi5YD7rPecyA6buMZZEPx4FRd2SB8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvylF1doXzbz6mkc2jQMb384NyStymmrCjH+0mKi9ZOEqhr56H09fNhM7o31f/Yds
         X8aQgdACyPmf8UvLoUSqGBXjlIDqnfRiiOlHyHW4fYNfchq2JkTqiX1tevtY1vKgi9
         4w52LjOxAN57yHtb8lYR1sSJdzSaEIhFwbePAMtw=
Date:   Thu, 8 Jun 2023 08:54:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Richard Fontana <rfontana@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 8/8] crypto: cts: Convert MIT boilerplate to
 corresponding SPDX license identifier
Message-ID: <2023060832-celtic-compost-ff48@gregkh>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
 <20230607053940.39078-18-bagasdotme@gmail.com>
 <CAC1cPGx-mD0DAEanCFtoxoGRyHkcu-GTTNX=ePzjhb8XM+73mg@mail.gmail.com>
 <ZIFn8mNXVcI0SGTR@debian.me>
 <2023060839-limpness-vessel-ccc7@gregkh>
 <bb4060b4-47b6-a7ba-af73-8509241ee2cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4060b4-47b6-a7ba-af73-8509241ee2cc@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:49:32PM +0700, Bagas Sanjaya wrote:
> On 6/8/23 12:40, Greg Kroah-Hartman wrote:
> >> Greg, is Richard's comment right? If so, I'll drop this patch.
> > 
> > Yes it is, please ask for all of these to not be applied.
> > 
> 
> Did you mean this whole series? Other patches have not been reviewed
> yet. Maybe Herbert can apply these rest of patches if there is
> no objection.

Based on the review of these, I would drop them all until you can get a
review from someone with lots of license experience to add their
reviewed-by to them.

thanks,

greg k-h
