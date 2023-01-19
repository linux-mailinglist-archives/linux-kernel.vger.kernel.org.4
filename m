Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBC673D59
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjASPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjASPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:20:46 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501984570
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:20:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 09E3F200FB;
        Thu, 19 Jan 2023 16:20:36 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N25Q-_HdXcOS; Thu, 19 Jan 2023 16:20:35 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 390602010A;
        Thu, 19 Jan 2023 16:20:35 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pIWiQ-008cJU-30;
        Thu, 19 Jan 2023 16:20:34 +0100
Date:   Thu, 19 Jan 2023 16:20:34 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patchv2 1/3] VT: Add height parameter to con_font_get/set consw
 operations
Message-ID: <20230119152034.ebx4eppde5ouwwbc@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.350270019@ens-lyon.org>
 <Y8ldFjz7d6/CMA0w@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ldFjz7d6/CMA0w@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le jeu. 19 janv. 2023 16:09:10 +0100, a ecrit:
> On Sun, Dec 18, 2022 at 01:32:10AM +0100, Samuel Thibault wrote:
> > Index: linux-6.0/drivers/tty/vt/vt.c
> 
> 6.0 was really old when you sent this, and because of that:
> 
> > Index: linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
> > ===================================================================
> 
> This file is not even in the tree anymore.
> 
> Can you rebase this against 6.2-rc4 and resubmit it so that I can apply
> it?  As-is, it will not apply at all :(

Right, I have rebased on top of Linus' tree, v3 should now apply fine.

Thanks,
Samuel
