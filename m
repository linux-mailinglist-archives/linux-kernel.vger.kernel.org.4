Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEEF6D5AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDDIWq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjDDIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:22:44 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940DA193;
        Tue,  4 Apr 2023 01:22:41 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 5F46710000C;
        Tue,  4 Apr 2023 08:22:35 +0000 (UTC)
Message-ID: <e1eb90db85ed7adad08bb99054f5cda3cb626794.camel@hadess.net>
Subject: Re: linux-next: build warning after merge of the hid tree
From:   Bastien Nocera <hadess@hadess.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 04 Apr 2023 10:22:35 +0200
In-Reply-To: <20230404154254.6c3be26b@canb.auug.org.au>
References: <20230404154005.449800c3@canb.auug.org.au>
         <20230404154254.6c3be26b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-04 at 15:42 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 4 Apr 2023 15:40:05 +1000 Stephen Rothwell
> <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the hid tree, today's linux-next build (htmldocs)
> > produced
> > this warning:
> > 
> > drivers/usb/core/message.c:1939: warning: Function parameter or
> > member 'iface' not described in 'usb_set_wireless_status'
> > drivers/usb/core/message.c:1939: warning: Excess function parameter
> > 'dev' description in 'usb_set_wireless_status'
> > 
> > Introduced by commit
> > 
> >   0a4db185f078 ("USB: core: Add API to change the wireless_status")
> 
> Also this:
> 
> include/linux/usb.h:270: warning: Function parameter or member
> 'wireless_status_work' not described in 'usb_interface'
> 

How does one reproduce those warnings?
