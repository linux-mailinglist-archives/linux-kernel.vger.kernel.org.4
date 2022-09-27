Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A565EC72E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiI0PEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiI0PE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:04:26 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE33E7E33;
        Tue, 27 Sep 2022 08:04:23 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4McNFK30KPzvjfm; Tue, 27 Sep 2022 17:04:21 +0200 (CEST)
Date:   Tue, 27 Sep 2022 17:04:21 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: unify TX space reads under
 altera_jtaguart_tx_space()
Message-ID: <20220927150420.nqzvgbs43etwpuxd@distanz.ch>
References: <20220927111819.18516-1-jslaby@suse.cz>
 <20220927111819.18516-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927111819.18516-3-jslaby@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 at 13:18:18 +0200, Jiri Slaby <jslaby@suse.cz> wrote:
> TX space reads from the control register are performed in various forms
> on 4 places in altera_jtaguart. Unify all those and do the read and
> masking on a single place.
> 
> The new helper altera_jtaguart_tx_space() uses FIELD_GET(), so we can
> drop ALTERA_JTAGUART_CONTROL_WSPACE_OFF now.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
