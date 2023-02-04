Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7C68A8F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 09:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBDIa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 03:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjBDIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 03:30:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432392B0AB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 00:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=JTCZHXV+s4OD939rIaoVv+s6pEWFUbOEql1NUxVw+Xw=; b=pIZNspfUELJsBHH8Hqqv1hlxEl
        1NrRI8h14L+z3/0qmVW9a79jy4eN3Zo6Uv0h1eWPM0xhncNHrUa6d9V+tFTp57oyzvtV1tA4Owipw
        P2oshvh2lTSsTIrVtu0i6YJBeBAOl2vI8WS75YMgoffXwwmrnAok8zRWQmZorKNnYcump54ue+a/J
        YfwzV4+I4EdlkdDAuICyjpIr6aYEvNBDPC2FF0mlPsxsu5DVo+q1XhnlzEeK1l1wjM0fwtsfY2u1i
        t4wB36QFPtM0FUSP1ghLuLRzPoRzkA2cQL/YmMWuFd4+cHLY/3gS8WgeusBVyHQGckDtaMiyiGEnf
        Yx1XrhSQ==;
Received: from [2601:1c2:d00:6a60::9526]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pODw8-004jTH-SL; Sat, 04 Feb 2023 08:30:16 +0000
Message-ID: <b212bec9-27c5-6be0-d33e-e23978a322a2@infradead.org>
Date:   Sat, 4 Feb 2023 00:30:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on
 ppc
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-16-sv@linux.ibm.com>
 <33924523-5437-eb9a-116a-8e249ce99bd2@csgroup.eu>
 <b1079e99-c7ae-71f1-d578-80270adf44e7@infradead.org>
 <756321f5-9417-2d78-679a-1847fa18ff8a@infradead.org>
In-Reply-To: <756321f5-9417-2d78-679a-1847fa18ff8a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/23 00:21, Randy Dunlap wrote:
> 
> 
> On 2/4/23 00:19, Randy Dunlap wrote:
>> Hi--
>>
>> On 8/29/22 23:41, Christophe Leroy wrote:
>>>
>>>
>>> Le 29/08/2022 à 07:52, Sathvika Vasireddy a écrit :
>>>> This patch adds [stub] implementations for required
>>>> functions, inorder to enable objtool build on powerpc.
>>>
>>> Not all powerpc it seems, see below
>>>
>>
>> When cross-compiling PPC32 (on x86_64), I get 3600+ of these:
>>
>> /bin/sh: line 1: ./tools/objtool/objtool: No such file or directory
>> /bin/sh: line 1: ./tools/objtool/objtool: No such file or directory
>> /bin/sh: line 1: ./tools/objtool/objtool: No such file or directory
>>
>> Is there some way that objtool should work when cross-compiling?
>>
> 
> Oops. Its build failed. I seem to be missing header file(s)
> and possibly a library.
> I'll check on those...
> 

It's complaining about libelf.h but I have that, so I don't know where
it is looking other than /usr/include/libelf.h, which exists.
Maybe the tool isn't setup (ready) for cross-compiling?


Here's the build output for objtool:

<stdin>:1:10: fatal error: libelf.h: No such file or directory
compilation terminated.
elf.c: In function ‘read_sections’:
elf.c:273:9: error: ‘elf_getshnum’ is deprecated [-Werror=deprecated-declarations]
  273 |         if (elf_getshdrnum(elf->elf, &sections_nr)) {
      |         ^~
In file included from /usr/include/gelf.h:32,
                 from /work/lnx/next/linux-next-20230203/tools/objtool/include/objtool/elf.h:10,
                 from elf.c:22:
/usr/include/libelf.h:310:12: note: declared here
  310 | extern int elf_getshnum (Elf *__elf, size_t *__dst)
      |            ^~~~~~~~~~~~
elf.c:278:9: error: ‘elf_getshstrndx’ is deprecated [-Werror=deprecated-declarations]
  278 |         if (elf_getshdrstrndx(elf->elf, &shstrndx)) {
      |         ^~
/usr/include/libelf.h:322:12: note: declared here
  322 | extern int elf_getshstrndx (Elf *__elf, size_t *__dst)
      |            ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/work/lnx/next/linux-next-20230203/tools/build/Makefile.build:96: /work/lnx/next/linux-next-20230203/PPC32/tools/objtool/elf.o] Error 1

make[3]: *** [Makefile:66: /work/lnx/next/linux-next-20230203/PPC32/tools/objtool/objtool-in.o] Error 2


Thanks.
-- 
~Randy
