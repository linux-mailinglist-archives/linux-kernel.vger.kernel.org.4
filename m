Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C38644D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLFUj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLFUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:39:52 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA05140CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:39:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 77BAE20100;
        Tue,  6 Dec 2022 21:39:47 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HrqFwejXt_gf; Tue,  6 Dec 2022 21:39:47 +0100 (CET)
Received: from begin (unknown [46.231.241.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 361E3200FB;
        Tue,  6 Dec 2022 21:39:47 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1p2ejD-009Hcj-0v;
        Tue, 06 Dec 2022 21:39:47 +0100
Date:   Tue, 6 Dec 2022 21:39:47 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] VT: Add height parameter to con_font_get/set consw
 operations
Message-ID: <20221206203947.5yifmkntf4uy7lt6@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org, linux-kernel@vger.kernel.org
References: <20221205000739.583233140@ens-lyon.org>
 <20221205000807.751605665@ens-lyon.org>
 <27ade063-79df-dad9-0427-e16f1ddb43ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27ade063-79df-dad9-0427-e16f1ddb43ef@kernel.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby, le mar. 06 déc. 2022 07:40:30 +0100, a ecrit:
> On 05. 12. 22, 1:07, Samuel Thibault wrote:
> > --- linux-6.0.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
> > +++ linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
> ...
> > @@ -1268,7 +1271,7 @@ sisusbcon_font_get(struct vc_data *c, st
> >   	}
> >   	/* Copy 256 chars only, like vgacon */
> > -	memcpy(font->data, sisusb->font_backup, 256 * 32);
> > +	memcpy(font->data, sisusb->font_backup, 256 * height);
> 
> Have you tested this?

Ah, no, I had assumed that this was for a specific arch. But actually I
wasn't getting it because it depends on BROKEN.

> What does this 'height' refer to?

It was meant to be vpitch actually, I will fix it.

Samuel
