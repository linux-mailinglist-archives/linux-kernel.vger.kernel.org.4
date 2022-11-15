Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E7629CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiKOPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKOPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:08:24 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 07:08:22 PST
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30D1838B;
        Tue, 15 Nov 2022 07:08:22 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4NBTpW4Ds9zvjfp; Tue, 15 Nov 2022 15:58:59 +0100 (CET)
Date:   Tue, 15 Nov 2022 15:58:59 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: altera_jtaguart: use
 uart_port::read_status_mask
Message-ID: <20221115145859.kk2ygswlsqth6nqq@distanz.ch>
References: <20221115071724.5185-1-jirislaby@kernel.org>
 <20221115071724.5185-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115071724.5185-3-jirislaby@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-15 at 08:17:23 +0100, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> Instead of self-defined struct altera_jtaguart::imr, use preexisting
> uart_port::read_status_mask.
> 
> Note that imr was ulong. But there is no reason for that, its values are
> uints. And readl/writel's are used to read it/write to it.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
