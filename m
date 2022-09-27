Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE35EC710
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiI0O7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiI0O7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:59:33 -0400
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC514F6A6;
        Tue, 27 Sep 2022 07:59:29 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4McN7g3kfyzvjfm; Tue, 27 Sep 2022 16:59:27 +0200 (CEST)
Date:   Tue, 27 Sep 2022 16:59:27 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tty: serial: do unlock on a common path in
 altera_jtaguart_console_putc()
Message-ID: <20220927145926.o7j5ga5u3tq7hlxg@distanz.ch>
References: <20220927111819.18516-1-jslaby@suse.cz>
 <20220927111819.18516-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927111819.18516-4-jslaby@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 at 13:18:19 +0200, Jiri Slaby <jslaby@suse.cz> wrote:
> port->lock is unlocked in each branch in altera_jtaguart_console_putc(),
> so do it before the "if". "status" needs not be under the lock, as the
> register was already read.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
