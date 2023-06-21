Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB8738643
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFUOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjFUOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:08:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FD4A107;
        Wed, 21 Jun 2023 07:08:52 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qByVq-0004An-00; Wed, 21 Jun 2023 16:08:46 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CA5D2C0301; Wed, 21 Jun 2023 16:07:56 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:07:56 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] mips: pci-mt7620: reduce unnecessary error logs
Message-ID: <20230621140756.GB7206@alpha.franken.de>
References: <TYAP286MB0315B9598EC3BBB0783203CBBC5CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315B9598EC3BBB0783203CBBC5CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 06:43:21PM +0800, Shiji Yang wrote:
> These patches silence some mt7620 PCIe driver error messeges by
> removing the useless debugging codes and replacing incorrectly
> used 'dev_err()' with 'dev_info()'. 
> 
> Shiji Yang (2):
>   mips: pci-mt7620: do not print NFTS register value as error log
>   mips: pci-mt7620: use dev_info() to log PCIe device detection result
> 
>  arch/mips/pci/pci-mt7620.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
