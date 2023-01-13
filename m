Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F866A237
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjAMSjF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Jan 2023 13:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAMSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:39:02 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8695F1003;
        Fri, 13 Jan 2023 10:38:59 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pGOx5-003Fps-AY; Fri, 13 Jan 2023 19:38:55 +0100
Received: from p57ae5361.dip0.t-ipconnect.de ([87.174.83.97] helo=smtpclient.apple)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pGOx5-000ESc-2y; Fri, 13 Jan 2023 19:38:55 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] sh: avoid using IRQ0 on SH3/4
Date:   Fri, 13 Jan 2023 19:38:44 +0100
Message-Id: <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
References: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
X-Mailer: iPhone Mail (20C65)
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.174.83.97
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey!

> On Jan 13, 2023, at 7:27 PM, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> 
> ﻿Hello!
> 
>> On 5/3/22 11:42 PM, Sergey Shtylyov wrote:
>> 
>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
>> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
>> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
>> at 0 -- modify that code to start the IRQ #s from 16 instead.
>> 
>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
>> 
>> [1] https://lore.kernel.org/all/025679e1-1f0a-ae4b-4369-01164f691511@omp.ru/
>> 
>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> 
>> ---
>> The patch is against Linus Torvalds' 'linux.git' repo.
> 
>   So, this patch hasn't been merged... may I ask why? :-(

The SH maintainers have been MIA which is why the other maintainers want to kill the architecture again.

I’m seriously considering adopting the architecture.

Not sure whether Linus would grant that though.

Adrian
