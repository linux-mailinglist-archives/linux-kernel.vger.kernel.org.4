Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7337017F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjEMO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:57:25 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3245C1FC6;
        Sat, 13 May 2023 07:57:22 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id B56DB1BF204;
        Sat, 13 May 2023 14:57:19 +0000 (UTC)
MIME-Version: 1.0
Date:   Sat, 13 May 2023 16:57:19 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: dma: fix `dmaor_read_reg`/`dmaor_write_reg`
 macros
In-Reply-To: <750f11848a647831ccfd1284ad0a8dd540c8f886.camel@physik.fu-berlin.de>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <20230506141703.65605-2-contact@artur-rojek.eu>
 <65f873585db0cd9f79a84eb48707413775a9ba5b.camel@physik.fu-berlin.de>
 <2f73b2ac1ec15a6b0f78d8d3a7f12266@artur-rojek.eu>
 <CAMuHMdXFFaRqPxvUqgJCtZG1B5gpULL-N4VpNPyPF=_+mtn7Dg@mail.gmail.com>
 <309305917494c5a6c7cfb7ecb8bbf766@artur-rojek.eu>
 <750f11848a647831ccfd1284ad0a8dd540c8f886.camel@physik.fu-berlin.de>
Message-ID: <0ea0b05e99f63edf05ef9a0afe410fc1@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-13 16:45, John Paul Adrian Glaubitz wrote:
> Hi Artur!
> 
> On Sat, 2023-05-13 at 13:41 +0200, Artur Rojek wrote:
>> Yikes!
>> If this series hasn't been merged yet, perhaps we could fix this issue
>> in v2. I have something like this in mind (untested):
>> (...)
>> Otherwise, I'll send it in separately. Of course we'll also need to 
>> fix
>> `SH_DMAC_BASE1` so that it's set only for SoCs that feature two DMAC
>> modules...
> 
> No worries, nothing has been merged yet. For one, the merge windows for 
> 6.4
> has been closed and I also haven't merged your patches into my tree 
> yet. Please
> take your time to spin up a v2 of your patch set and test them 
> properly.

Great!

> 
> Maybe you're also interested in the clean-up that Geert suggested in 
> this
> thread (ordering of the CPU subtypes and capitalization issues)?

Sure, why not - the more clean-up we do, the better :)

> 
> Also, can you write "processor manual" instead of "PM" in the other 
> patch
> as well as don't use backticks for the macro names? In fact, I would 
> suggest
> retitling the subject to:
> 
> 	sh: dma: Fix dmaor_read_reg() and dmaor_write_reg() macros
> 

Of course.
On a side note, it was supposed to be "programming manual", however I
now see that Renesas named that document as "hardware manual", so that's
what I'll put into the commit description, if you don't mind.

cheers,
Artur

> Oh, and I will retest your v2 patches before merging them, of course 
> ;-).
> 
> Thanks,
> Adrian
