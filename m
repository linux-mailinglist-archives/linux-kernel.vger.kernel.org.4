Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F372B060
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 07:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjFKF25 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 11 Jun 2023 01:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKF2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 01:28:55 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16922E6;
        Sat, 10 Jun 2023 22:28:54 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q8Dd8-003JdR-F6; Sun, 11 Jun 2023 07:28:46 +0200
Received: from dynamic-077-191-185-170.77.191.pool.telefonica.de ([77.191.185.170] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q8Dd8-000T1b-8H; Sun, 11 Jun 2023 07:28:46 +0200
Message-ID: <3fff103bcea3874cc7fd93c3a765ca642aa7f632.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v6] sh: avoid using IRQ0 on SH3/4
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org
Date:   Sun, 11 Jun 2023 07:28:45 +0200
In-Reply-To: <837a586e-5e76-7a5b-a890-403ce26ea51b@gmail.com>
References: <71105dbf-cdb0-72e1-f9eb-eeda8e321696@omp.ru>
         <983d701befce7fc0010c53d09be84f5c330bdf45.camel@physik.fu-berlin.de>
         <837a586e-5e76-7a5b-a890-403ce26ea51b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.185.170
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-06-10 at 13:24 +0300, Sergei Shtylyov wrote:
> On 6/10/23 7:32 AM, John Paul Adrian Glaubitz wrote:
> 
> > > IRQ0 is no longer returned by platform_get_irq() and its ilk -- they now
> > > return -EINVAL instead.  However, the kernel code supporting SH3/4 based
> > > SoCs still maps the IRQ #s starting at 0 -- modify that code to start the
> > > IRQ #s from 16 instead.
> > > 
> > > The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
> > > indeed are using IRQ0 for the SMSC911x compatible Ethernet chip...
> > 
> > Do you mind if I remove the ellipsis at the end of this sentence when I merge
> > this later today? I think it makes no sense from a grammatical point of view.
> 
>    No, I don't mind. :-)

Applied to my for-next branch.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
