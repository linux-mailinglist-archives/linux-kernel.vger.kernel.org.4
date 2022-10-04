Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752735F4987
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJDS4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJDS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:56:41 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 11:56:39 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1721A6A49B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:56:38 -0700 (PDT)
X-KPN-MessageId: ec6384b7-4415-11ed-888a-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id ec6384b7-4415-11ed-888a-005056992ed3;
        Tue, 04 Oct 2022 20:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tiscali.nl; s=tiscali01;
        h=mime-version:content-type:date:to:from:subject:message-id;
        bh=uPVJh2Y0Am8PpgAyH+6+EzhxKQXMgkc/6Cq+tBZ5NWQ=;
        b=Myyg1SvTvX3L/n3oKyOgIDlA8OVFkkXG6/5gVMBkBybrNuGSUSitU7cbgoF/HAT4LI2K5fH9l+nOw
         BNnbyfWoHxHW7qG2R5c7PBEeSykwZwc8A88u7QhnLUYqrNMmZwRYnPjuPnDH4fwCCqPLcVq8Kxl3Uf
         VMxQ0r52SuJKCBXk=
X-KPN-MID: 33|1Is3ZhbN5r/n/oP2HInmpr0aXKlgN27nH8OPxxdtbYWeMrKVWUU/zxW9zL7yQyd
 PJbgLqnBXaKd1LEb9hxQy361DOCSwzOOtl6cI1AdZEtk=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|emuCCWis9m3zeVZylh5X/UGmPefdqhHVMisE/ZBZIzMHNCquUjw57ikTf3HpjVA
 j2k34gbdmDYkJRk/Vr0I2vg==
X-Originating-IP: 195.240.113.187
Received: from [192.168.178.46] (195-240-113-187.fixed.kpn.net [195.240.113.187])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 1fbc439c-4416-11ed-9b28-00505699d6e5;
        Tue, 04 Oct 2022 20:55:34 +0200 (CEST)
Message-ID: <084a7aec62c8e1dc24633848d7114b45df785ea9.camel@tiscali.nl>
Subject: Re: [PATCH] ARM: remove check for CONFIG_DEBUG_LL_SER3
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Oct 2022 20:55:33 +0200
In-Reply-To: <CAMuHMdVwnJ-dG7eBY-BnH1aZQVxknnzr+zvoDr+53U8CE=NRiw@mail.gmail.com>
References: <e8b573d81168c33ed4f3d5e5e2d3b951c323fc23.1664347239.git.geert+renesas@glider.be>
         <CACRpkdbLDi9vE-Y14j+Tk7Gm+Tbft+C+R4wtPe-Gr7jLeEe7Og@mail.gmail.com>
         <CAMuHMdVwnJ-dG7eBY-BnH1aZQVxknnzr+zvoDr+53U8CE=NRiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven schreef op di 04-10-2022 om 09:48 [+0200]:
> Arnd took it into soc/for-next as commit 4413794917ba3ff4 ("ARM:
> remove check for CONFIG_DEBUG_LL_SER3").

This is really nice!

One of the few of the commits that I'm actually proud of is e5a7286b5f1b
("x86, boot: Remove ancient, unconditionally #ifdef'd out dead code"). That
commit removed code that was dead for sixteen years. This patch - if it
crosses the finish line - will remove code that's been dead for twenty year=
s.
Yay Geert! I'm so glad this patch was hibernated for eight years, promoting
code dead for twelve years to code dead for twenty years.

But there must be even older dead code in the tree. So let's make this a
contest! I'll ship some Dutch treats to the author of a patch that removes
code that has been dead for the longest time when committed by Linus no lat=
er
than December 5th, 2022. (Wikipedia can explain this odd deadline.)

Grave diggers: on your mark!


Paul Bolle
