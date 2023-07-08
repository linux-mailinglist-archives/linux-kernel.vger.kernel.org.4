Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A302374BF65
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGHV6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHV6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 17:58:38 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247DE4A;
        Sat,  8 Jul 2023 14:58:36 -0700 (PDT)
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPA id 97CD4240002;
        Sat,  8 Jul 2023 21:58:30 +0000 (UTC)
MIME-Version: 1.0
Date:   Sat, 08 Jul 2023 23:58:30 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sh updates for v6.5
In-Reply-To: <62d9d61e7d085840161c06f08b7aebfd734663fa.camel@physik.fu-berlin.de>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
 <ZKba4SLzjjhHgOEs@infradead.org>
 <5c612d0b293082352df6640ac951918bfa458181.camel@physik.fu-berlin.de>
 <45f9efa9-9341-e7e4-fbe4-ec7689c714aa@omp.ru>
 <62d9d61e7d085840161c06f08b7aebfd734663fa.camel@physik.fu-berlin.de>
Message-ID: <efaf034aaea3a5f7459b3c9081dc0665@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-08 23:49, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On Sun, 2023-07-09 at 00:25 +0300, Sergey Shtylyov wrote:
>> > However, since I am still new to kernel development, it will certainly take
>> > me a little more time until we're there. However, there is some interest
>> > in the community such as the J-Core people and Artur Rojek, so there are people
>> > who are willing to help me.
>> 
>>    Maybe we could start using the #linux-sh channel (again?) -- it's 
>> there, on
>> Libera.chat, with couple persons hanging around... :-)
> 
> Most SuperH/J-Core people meet in #jcore on libera these days.
> 
> Adrian
I am not sure if they welcome generic SuperH chat there, but I'm lurking
in both channels already.

Cheers,
Artur
