Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E9705F99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjEQFvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjEQFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:51:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF4D11BE3;
        Tue, 16 May 2023 22:51:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 99E798108;
        Wed, 17 May 2023 05:51:28 +0000 (UTC)
Date:   Wed, 17 May 2023 08:51:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: Tree for May 15 (drivers/tty/serial/8250/8250_omap.c)
Message-ID: <20230517055127.GJ14287@atomide.com>
References: <20230515141235.0777c631@canb.auug.org.au>
 <db4d4826-93ad-d5c7-372a-82818b1ebe9a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db4d4826-93ad-d5c7-372a-82818b1ebe9a@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [230516 02:40]:
> 
> 
> On 5/14/23 21:12, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230512:
> > 
> 
> # CONFIG_PM is not set
> 
> 
> ../drivers/tty/serial/8250/8250_omap.c:169:13: warning: 'uart_write' defined but not used [-Wunused-function]
>   169 | static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
>       |             ^~~~~~~~~~

Thanks Geert has posted a fix for it:

https://lore.kernel.org/linux-serial/20230515122356.GI14287@atomide.com/T/#t

Regards,

Tony
