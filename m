Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A86B74A7E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjGFXke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGFXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:40:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9CE1BE9;
        Thu,  6 Jul 2023 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SQYcFwTiudtZjAvMujA95gdCYG3kX4Nfn4lSoqD3G9I=; b=dXXNMcpdwdwW5/LbL8yapIpCqz
        kagP3FMVUW4fdRj8aTgHN/TyjVqozqUgDa1yhEhOaTa/8ZWbUu/JH8sIlNIulDRwSKcjbIeyJ4ye8
        9aw3ZifW9Ekwu1TAXQy2MnLOdajkiBYKEs3gG3umaumGMxxYSRA0a/PnicYoLw6DhWz/btrgCl4Dq
        8VGzPZhbzI3M0EnGg1TvpNeYvZp5Z2+/czQGDqPgYPMJwaqlyWO7dfU88R2DUSCC3xyvI6LIOzPy7
        57ufaBByratMtAXwEpwtnULC28yYaWRoZqtt04eYhDptdH57dVj/lXm0OktO8yNw0fXOhR1HTFS6l
        b1RHx7QA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHYaL-002ypQ-03;
        Thu, 06 Jul 2023 23:40:29 +0000
Message-ID: <278886bf-f469-a8cc-130a-f3e4614e7e1f@infradead.org>
Date:   Thu, 6 Jul 2023 16:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jul 6 (arch/riscv/)
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>
References: <mhng-6e5d4a84-8aef-406d-b0cd-8f195f531354@palmer-ri-x1c9a>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <mhng-6e5d4a84-8aef-406d-b0cd-8f195f531354@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 7/6/23 14:46, Palmer Dabbelt wrote:
> On Thu, 06 Jul 2023 14:36:05 PDT (-0700), rdunlap@infradead.org wrote:
>>
>>
>> On 7/6/23 14:32, Palmer Dabbelt wrote:
>>> On Thu, 06 Jul 2023 14:27:53 PDT (-0700), rdunlap@infradead.org wrote:
>>>>
>>>>
>>>> On 7/5/23 18:57, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Please do *not* add any v6.6 related stuff to your linux-next included
>>>>> branches until after v6.5-rc1 has been released.
>>>>>
>>>>> Changes since 20230705:
>>>>>
>>>>
>>>> on riscv64:
>>>>
>>>> WARNING: modpost: vmlinux: section mismatch in reference: $xrv64i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x14 (section: .text.unlikely.set_bit.constprop.0) -> numa_nodes_parsed (section: .init.data)
>>>>
>>>>
>>>> Full randconfig file is attached.
>>>
>>> Thanks, I'm giving it a look.  Do you happen to also have your toolchain version easily availiable?  The mapping symbols are new and we've seen some odd stuff happen, something is likely broken somewhere...
>>
>> I'm using gcc-13.1.0 from  https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> Cool, those are pretty easy to run.  I've yet to actually reproduce the
> failures, but I'd guess we just want to ignore the mapping symbols with
> something like
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index b29b29707f10..2f801469301d 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -614,6 +614,18 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
>         /* Expoline thunks are linked on all kernel modules during final link of .ko */
>         if (strstarts(symname, "__s390_indirect_jump_r"))
>             return 1;
> +
> +    /*
> +     * RISC-V defines various special symbols that start with "$".  The
> +     * mapping symbols, which exist to differentiate between incompatible
> +     * instruction encodings when disassembling, show up all over the place
> +     * and are generally not meant to be treated like other symbols.  So
> +     * just ignore any of the special symbols.
> +     */
> +    if (info->hdr->e_machine == EM_RISCV)
> +        if (symname[0] == '$')
> +            return 1;
> +
>     /* Do not ignore this symbol */
>     return 0;
> }
> 
> I haven't even built that, though...

That builds without any errors or warnings, but it doesn't fix the section mismatch
warning.

> These also trip up backtraces, so we probably need something over there as
> well.

-- 
~Randy
