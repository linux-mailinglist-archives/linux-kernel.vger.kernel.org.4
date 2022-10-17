Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65C60066C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQFtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJQFtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:49:39 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5B12093
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665985774; bh=5DnQWB/mKKYLYR98YTAsbjRRrbuz/m16uNWFy217anw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EDJRFvyO9fTP9nDjAjjfr2jcnbEbqyVmzTdysIPagCekjGahSJFvzT0qgbt5RFeSI
         XiRftibviwM1BpWNgWM4pQ9g/ZneCn480XZq3ZKOi8KG7Qz9OQKe0UMNpDL1IR3njC
         8j1slnNpRjCxBNoisynUZQ+9v2eXpf/asYn5835k=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E9B72600B5;
        Mon, 17 Oct 2022 13:49:33 +0800 (CST)
Message-ID: <1df01e31-9d31-e315-4906-d7f1ff9fb6d9@xen0n.name>
Date:   Mon, 17 Oct 2022 13:49:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH] LoongArch: Add unaligned access support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
 <c1b674a37a1a04f9c84df1e9a227db68bf78e922.camel@xry111.site>
 <CAAhV-H4vGt4MTXCyiSnn7cQFrxR-amLC4nKe7-EcLyT8G-Ciqg@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H4vGt4MTXCyiSnn7cQFrxR-amLC4nKe7-EcLyT8G-Ciqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 08:16, Huacai Chen wrote:
> Hi, Ruoyao,
> 
> On Sun, Oct 16, 2022 at 11:05 PM Xi Ruoyao <xry111@xry111.site> wrote:
>>
>> On Sun, 2022-10-16 at 21:34 +0800, Huacai Chen wrote:
>>
>>> Loongson-2 series (Loongson-2K500, Loongson-2K1000)
>>
>> "2K1000LA"? "2K1000" is puzzling because of a name conflict with the
>> MIPS-based model.
> Technically this is correct, both MIPS-based and LoongArch-based
> Loongson-2K1000 have no hardware support.

Unfortunately, no, there is no "LoongArch-based" 2K1000. The Loongson 
2K1000 is a MIPS processor, and will always be; the official model name 
for the "LoongArch-based 2K1000" is 2K1000LA which is obviously distinct.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

