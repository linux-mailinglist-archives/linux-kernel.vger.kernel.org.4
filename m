Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E27017F7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 17:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbjEMPCT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 13 May 2023 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 11:02:17 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9B213C;
        Sat, 13 May 2023 08:02:16 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pxql8-003KcP-I7; Sat, 13 May 2023 17:02:10 +0200
Received: from dynamic-077-013-140-028.77.13.pool.telefonica.de ([77.13.140.28] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pxql8-000zVB-BP; Sat, 13 May 2023 17:02:10 +0200
Message-ID: <6977d52a797af5dfa3a863ac32bee8a9553bf86a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 May 2023 17:02:09 +0200
In-Reply-To: <0ea0b05e99f63edf05ef9a0afe410fc1@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-2-contact@artur-rojek.eu>
         <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
         <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
         <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
         <309305917494c5a6c7cfb7ecb8bbf766@artur-rojek.eu>
         <750f11848a647831ccfd1284ad0a8dd540c8f886.camel@physik.fu-berlin.de>
         <0ea0b05e99f63edf05ef9a0afe410fc1@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.13.140.28
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur!

On Sat, 2023-05-13 at 16:57 +0200, Artur Rojek wrote:
> > Maybe you're also interested in the clean-up that Geert suggested in 
> > this
> > thread (ordering of the CPU subtypes and capitalization issues)?
> 
> Sure, why not - the more clean-up we do, the better :)

Great, thanks a lot!

> > Also, can you write "processor manual" instead of "PM" in the other 
> > patch
> > as well as don't use backticks for the macro names? In fact, I would 
> > suggest
> > retitling the subject to:
> > 
> > 	sh: dma: Fix dmaor_read_reg() and dmaor_write_reg() macros
> > 
> 
> Of course.
> On a side note, it was supposed to be "programming manual", however I
> now see that Renesas named that document as "hardware manual", so that's
> what I'll put into the commit description, if you don't mind.

Absolutely not! Looking forward to your v2 series and please take your time!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
