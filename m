Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554277017E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjEMOqJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 13 May 2023 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjEMOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:46:06 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943753A9B;
        Sat, 13 May 2023 07:46:05 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pxqVR-003IIv-Jq; Sat, 13 May 2023 16:45:57 +0200
Received: from dynamic-077-013-140-028.77.13.pool.telefonica.de ([77.13.140.28] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pxqVR-000xpB-D8; Sat, 13 May 2023 16:45:57 +0200
Message-ID: <750f11848a647831ccfd1284ad0a8dd540c8f886.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Artur Rojek <contact@artur-rojek.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 May 2023 16:45:56 +0200
In-Reply-To: <309305917494c5a6c7cfb7ecb8bbf766@artur-rojek.eu>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-2-contact@artur-rojek.eu>
         <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
         <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
         <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
         <309305917494c5a6c7cfb7ecb8bbf766@artur-rojek.eu>
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

On Sat, 2023-05-13 at 13:41 +0200, Artur Rojek wrote:
> Yikes!
> If this series hasn't been merged yet, perhaps we could fix this issue
> in v2. I have something like this in mind (untested):
> (...)
> Otherwise, I'll send it in separately. Of course we'll also need to fix
> `SH_DMAC_BASE1` so that it's set only for SoCs that feature two DMAC
> modules...

No worries, nothing has been merged yet. For one, the merge windows for 6.4
has been closed and I also haven't merged your patches into my tree yet. Please
take your time to spin up a v2 of your patch set and test them properly.

Maybe you're also interested in the clean-up that Geert suggested in this
thread (ordering of the CPU subtypes and capitalization issues)?

Also, can you write "processor manual" instead of "PM" in the other patch
as well as don't use backticks for the macro names? In fact, I would suggest
retitling the subject to:

	sh: dma: Fix dmaor_read_reg() and dmaor_write_reg() macros

Oh, and I will retest your v2 patches before merging them, of course ;-).

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
