Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7887435B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjF3HXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3HW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:22:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A329D10EC;
        Fri, 30 Jun 2023 00:22:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1B0A380FE;
        Fri, 30 Jun 2023 07:22:56 +0000 (UTC)
Date:   Fri, 30 Jun 2023 10:22:54 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
Message-ID: <20230630072254.GL14287@atomide.com>
References: <20230624121211.19711-1-mans@mansr.com>
 <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
 <yw1x352h3plc.fsf@mansr.com>
 <457ae95b-8838-4c10-821c-379ed622ef41@lunn.ch>
 <yw1xy1k92ahj.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xy1k92ahj.fsf@mansr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Måns Rullgård <mans@mansr.com> [230624 14:36]:
> Andrew Lunn <andrew@lunn.ch> writes:
> > I assume you also want this back ported to stable? Please add a Fixed:
> > tag, and a Cc: stable@vger.kernel.org tag. And set the patch subject
> > to [PATCH net v3] to indicate this is for the net tree, not net-next.
> 
> I give up.  It's not worth my time.  This is why people hoard patches
> rather than sending them upstream.

Maybe just give it one more go filing the proper paperwork :) It would be
nice to have it in stable too so IMO it's worth the few more hoops to
addthe tags for automating picking it to stable kernels.

Regards,

Tony
