Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBF71292D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243624AbjEZPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjEZPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:12:57 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76077F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:12:54 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0217DC0007;
        Fri, 26 May 2023 15:12:46 +0000 (UTC)
Message-ID: <f82e7d3d-a16d-593e-7513-753b5cbf28af@ghiti.fr>
Date:   Fri, 26 May 2023 17:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Bug report: kernel paniced when system hibernates
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>, robh@kernel.org,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
References: <20230525-shrapnel-precut-26500fca4a48@wendy>
 <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy>
 <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud>
 <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud>
 <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
 <20230525-batting-botch-7e03393a2d97@spud>
 <CAHVXubiDezbwZO6X2btvgpq-XqHnxZjXzaMnSK2YrHc_ioLx8Q@mail.gmail.com>
 <20230526-steep-omen-a5a46a1086bf@spud>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230526-steep-omen-a5a46a1086bf@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/05/2023 16:59, Conor Dooley wrote:
> On Fri, May 26, 2023 at 03:14:33PM +0200, Alexandre Ghiti wrote:
>> Hi everyone,
>>
>> On Thu, May 25, 2023 at 11:24 PM Conor Dooley <conor@kernel.org> wrote:
>>> On Thu, May 25, 2023 at 01:06:04PM -0700, Atish Patra wrote:
>>>> On Thu, May 25, 2023 at 11:39 AM Conor Dooley <conor@kernel.org> wrote:
>>>>> On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
>>>>>
>>>>>> Any testing of hibernation still needs to revert the patch until we
>>>>>> have the proper fix.
>>>>> "the patch" is what exactly? I assume you don't mean depending on
>>>>> NONPORTABLE, since that is a Kconfig option.
>>>> Nope. Sorry I meant the commit
>>>>
>>>> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
>>> Ah, if your SBI implementation is one of the affected ones, yeah.
>>> If not, you can just set NONPORTABLE :)
>> @Björn Töpel emitted the idea of excluding from the hibernation all
>> the memory nodes in the "/reserved-memory" node
>> (https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml):
>> I have to admit that I don't see why it is not done by default by the
>> kernel.
> My understanding was that it was perfectly fine to use reserved memory
> nodes to fence off some memory to use in device drivers etc, which then
> may need to be saved/restored.


Agreed, but I would say that it's up to the driver then to take care of 
that, see https://docs.kernel.org/driver-api/pm/notifiers.html


>> Unless there is stuff in this node that needs to be "hibernated", I
>> think that would be a very good solution since we would not rely on
>> the name of the "internal" nodes of "/reserved-memory" (i.e.
>> "mmode_resv").
>>
>> I'm digging into why it is not done by default, just wanted to have
>> your feedback before the week-end :)
