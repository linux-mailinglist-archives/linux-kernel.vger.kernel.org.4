Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5156FCEDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEIT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEITz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:55:59 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9F3AA4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:55:58 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 70DFB60005;
        Tue,  9 May 2023 19:55:53 +0000 (UTC)
Message-ID: <4adb27d2-325d-3ce0-23b1-ec69a973b4bf@ghiti.fr>
Date:   Tue, 9 May 2023 21:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
 <20230215143626.453491-2-alexghiti@rivosinc.com> <87wn1h5nne.fsf@igel.home>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <87wn1h5nne.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 21:07, Andreas Schwab wrote:
> That does not work with UEFI booting:
>
> Loading Linux 6.4.0-rc1-1.g668187d-default ...
> Loading initial ramdisk ...
> Unhandled exception: Instruction access fault
> EPC: ffffffff80016d56 RA: 000000008020334e TVAL: 0000007f80016d56
> EPC: ffffffff002d1d56 RA: 00000000004be34e reloc adjusted
> Unhandled exception: Load access fault
> EPC: 00000000fff462d4 RA: 00000000fff462d0 TVAL: ffffffff80016d56
> EPC: 00000000802012d4 RA: 00000000802012d0 reloc adjusted
>
> Code: c825 8e0d 05b3 40b4 d0ef 0636 7493 ffe4 (d783 0004)
> UEFI image [0x00000000fe65e000:0x00000000fe6e3fff] '/efi\boot\bootriscv64.efi'
> UEFI image [0x00000000daa82000:0x00000000dcc2afff]
>

I need more details please, as I have a UEFI bootflow and it works great 
(KASLR is based on a relocatable kernel and works fine in UEFI too).

Thanks,

Alex

