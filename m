Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153AE6B6218
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCKXgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKXgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:36:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888194AFED;
        Sat, 11 Mar 2023 15:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+49ZcP/t+Js5dyABFHzBzJUKP+6GT+GDUK2GR7gQnBY=; b=oXTIR1hNjYXwpXnXSm5cx4727P
        XqqRNhs4xWwX7E5JlOimxG11egAIA97xrwzeYSp4fsBy4wZweyu4RWWLmhvipY6sg/OZ1468NQNc5
        xXEZUOfVyI5R8BD7rQ9DdCCN1sZyGNWLgK+gw3iWLth0ijMVg4qpVSjGW7PFkf0zaxoLCkuCeasg6
        iHrmJGU5tBzqzQVTDJZEQbUp19RBtFO4sBKKYKVaZp7KfQfszr6cvhUAWAddbhZ21zaRzBBMYxYBn
        +1Pj+lkkQbrEi9Ea5OdNAYq19zoPAcmzVRPPDNxreqnrMNJa/sNZpapmQdRc55ZFtUj8m1kPHUpBl
        xCqy7HVA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pb8l2-001TzM-IY; Sat, 11 Mar 2023 23:36:12 +0000
Message-ID: <ed382974-1613-8a60-913c-60cfc27f8ab3@infradead.org>
Date:   Sat, 11 Mar 2023 15:36:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: linux-next: Tree for Mar 10 (drivers/spi/spi-mpc512x-psc.c:)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230310124850.245ba584@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230310124850.245ba584@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/23 17:48, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230309:
> 
> Non-merge commits (relative to Linus' tree): 2087
>  2412 files changed, 75248 insertions(+), 89600 deletions(-)
> 
> ----------------------------------------------------------------------------

on ppc32:

drivers/spi/spi-mpc512x-psc.c: In function 'mpc512x_psc_spi_of_probe':
drivers/spi/spi-mpc512x-psc.c:518:17: error: label 'free_ipg_clock' used but not defined
  518 |                 goto free_ipg_clock;
      |                 ^~~~


on allmodconfig.


-- 
~Randy
