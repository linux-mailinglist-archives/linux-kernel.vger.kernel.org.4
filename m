Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8646E8607
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjDSXmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:42:06 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0730C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:42:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C0C5B32007F1;
        Wed, 19 Apr 2023 19:42:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 19 Apr 2023 19:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1681947723; x=1682034123; bh=yx1o5xrLkkfX/ayxDBgXkHp81fEFHgvVba2
        0Qzf//Xo=; b=KVjiAEoj+LbexsV2pt4zrqZre18ofcY8OP+okl5sooAoc/p3pnI
        ngbFo6Lu5fQxbwtblKxhOc30cnh8lSC2HE3in7K++gnXGodzY8grlc3m8QtwrWY3
        qFYU36XVGAPDwikfNLnbH7OAkbjGqJJgMXISMyxKV1a6aUU+wcCluLNNmvZfdz/4
        FA7KCnIC3Am+Qv27y9wJUSyxhnB3Yv668/wSUEWWKb1gRWYczN/Wsy0roifQewOz
        T8YCVPFq/v0hd7ftWRQROwua4C1/VA+tAINXXwzcbIYfXKUseGA2BCHfN1u21s6y
        QdKRGn++wF932+OQ3ZvRjuGBQY7L3tS+OyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681947723; x=1682034123; bh=yx1o5xrLkkfX/ayxDBgXkHp81fEFHgvVba2
        0Qzf//Xo=; b=FiHhMsbtNj0b0Z+/ZE0SHvPBsO+lhIeU40AfGimQ+BIaUGrZwPY
        dHrapBlki8HXH9Rakl2SqSEYYVJM3fFNmDu8RFyy2E6FgveKoEX5WixxVex/aalG
        UwCuUsy2HsAM+EWIQNVxeW48b8TABJw7osvhTvULxwhNntq0DNRGssWddCj3uQ88
        3NBg6XHno2VMXqXmtsl48RW81yqJPUUZ417OimqthwRDMWdnezgcPo90HP3wjWZT
        EDKXOVfJRaruat67D4xDm0jveP3zlisYFWQ5wo8BYZI77WfibIWcoEj4JI3/Z5pR
        tG09gds6WjwIl44abFMbjJwRnE+IaDoIShw==
X-ME-Sender: <xms:S3xAZDHx6gNScoxOvRdsBNafQS7PT6gGCrSrbNkzdPouK4gA0A4NCw>
    <xme:S3xAZAXU3N5Og9-CuUvjL2kz2ia0ks7UKF_ZjR13ue4tzRRD-gPt038AJG9p-oPPK
    C8R4WZx5HELeFsrP9M>
X-ME-Received: <xmr:S3xAZFIcfwyQzxH1P6KfhFEh4ZWCiBc4AaKpgYHl_rQ-V_IBoVk_NlIeD7R9ZWI7gDVq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvedtfeekhefgvdfgveekkeegiedvfffhgfffledvleetgeek
    vdfhfeegveekhedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpd
    hgihhthhhusgdrtghomhdpghhithhhuhgsuhhsvghrtghonhhtvghnthdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunh
    drhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:S3xAZBEnDAKlnvFsvdOmetgZ6HEATMt9_Oc9TJd5BdobA5lWNSIYew>
    <xmx:S3xAZJWsNcjqqTUdnb6ikMlvLogkaja5AyaOqw9fd58ndHKhDFhVQw>
    <xmx:S3xAZMP1KkiY_42I_0lZAQDOsNoQpy-YOX5_t5CFfQO1yBL_faYpjw>
    <xmx:S3xAZHe7YIGOiEBosuCwlQL5dS04m0YHgh8RlyGSdyRPdeTWeJ3evg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 19:42:01 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: arch/mips/include/asm/timex.h:75:10: error: instruction requires
 a CPU feature not currently enabled
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230419231834.GA1269248@dev-arch.thelio-3990X>
Date:   Thu, 20 Apr 2023 00:41:50 +0100
Cc:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6A730FC-C7B5-4A32-92CD-98FDA632782C@flygoat.com>
References: <202304170748.Fg9VIgGd-lkp@intel.com>
 <20230419223707.GAZEBtE1vZGy5B4EUR@fat_crate.local>
 <20230419231834.GA1269248@dev-arch.thelio-3990X>
To:     Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8820=E6=97=A5 00:18=EF=BC=8CNathan Chancellor =
<nathan@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> + Jiaxun, who has been looking into MIPS + LLVM issues recently and =
has
> been a big help :)

I think this patch[1] may fix the problem.

Thanks
- Jiaxun

[1]: =
https://patchwork.kernel.org/project/linux-mips/patch/20230411111225.55725=
-2-jiaxun.yang@flygoat.com/

>=20
> On Thu, Apr 20, 2023 at 12:37:07AM +0200, Borislav Petkov wrote:
>> + Thomas.
>>=20
>> On Mon, Apr 17, 2023 at 07:57:04AM +0800, kernel test robot wrote:
>>> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
>>> head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
>>> commit: aba5b397cad7d398b385aaf5029f99f41b690466 hamradio: =
baycom_epp: Do not use x86-specific rdtsc()
>>> date:   4 months ago
>>> config: mips-buildonly-randconfig-r001-20230417 =
(https://download.01.org/0day-ci/archive/20230417/202304170748.Fg9VIgGd-lk=
p@intel.com/config)
>>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project =
9638da200e00bd069e6dd63604e14cbafede9324)
>>=20
>> Where do I get clang 17?
>=20
> I think they intend for you to get it via their make.cross script but
> this issue reproduces with clang 16.0.2 from
> https://mirrors.edge.kernel.org/pub/tools/llvm/ for me locally.
>=20
>> In any case, this
>>=20
>> "error: instruction requires a CPU feature not currently enabled"
>>=20
>> sounds like clang is trying to generate invalid code for the wrong
>> target. .config issue?
>=20
> I am far from a MIPS expert but this usually means that there is some
> assembler directive that we are missing to allow access to certain
> instructions in newer ISA versions than the one specified via =
'-march'.
> I have no idea if that is the case here or not but I do see the =
correct
> target flags when building with V=3D1, so it is not something obvious =
like
> that. I can double back to this later this week or next week if nobody
> else is able to.
>=20
> Regardless, this seems like a pre-existing issue that was just exposed
> by your patch, not the root cause of it.
>=20
> Cheers,
> Nathan
>=20
>>> reproduce (this is a W=3D1 build):
>>>        wget =
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross =
-O ~/bin/make.cross
>>>        chmod +x ~/bin/make.cross
>>>        # install mips cross compiling tool for clang build
>>>        # apt-get install binutils-mipsel-linux-gnu
>>>        # =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Daba5b397cad7d398b385aaf5029f99f41b690466
>>>        git remote add linus =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>        git fetch --no-tags linus master
>>>        git checkout aba5b397cad7d398b385aaf5029f99f41b690466
>>>        # save the config file
>>>        mkdir build_dir && cp config build_dir/.config
>>>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang =
make.cross W=3D1 O=3Dbuild_dir ARCH=3Dmips olddefconfig
>>>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang =
make.cross W=3D1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash =
drivers/net/hamradio/
>>>=20
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Link: =
https://lore.kernel.org/oe-kbuild-all/202304170748.Fg9VIgGd-lkp@intel.com/=

>>>=20
>>> All errors (new ones prefixed by >>):
>>>=20
>>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
>>>   In file included from include/linux/module.h:13:
>>>   In file included from include/linux/stat.h:19:
>>>   In file included from include/linux/time.h:60:
>>>   In file included from include/linux/time32.h:13:
>>>   In file included from include/linux/timex.h:67:
>>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a =
CPU feature not currently enabled
>>>                   return read_c0_count();
>>>                          ^
>>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from =
macro 'read_c0_count'
>>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
>>>                                   ^
>>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro =
'__read_32bit_c0_register'
>>>           ___read_32bit_c0_register(source, sel, __volatile__)
>>>           ^
>>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro =
'___read_32bit_c0_register'
>>>                           "mfc0\t%0, " #source "\n\t"                =
     \
>>>                           ^
>>>   <inline asm>:1:2: note: instantiated into assembly here
>>>           mfc0    $4, $9
>>>           ^
>>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
>>>   In file included from include/linux/module.h:13:
>>>   In file included from include/linux/stat.h:19:
>>>   In file included from include/linux/time.h:60:
>>>   In file included from include/linux/time32.h:13:
>>>   In file included from include/linux/timex.h:67:
>>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a =
CPU feature not currently enabled
>>>                   return read_c0_count();
>>>                          ^
>>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from =
macro 'read_c0_count'
>>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
>>>                                   ^
>>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro =
'__read_32bit_c0_register'
>>>           ___read_32bit_c0_register(source, sel, __volatile__)
>>>           ^
>>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro =
'___read_32bit_c0_register'
>>>                           "mfc0\t%0, " #source "\n\t"                =
     \
>>>                           ^
>>>   <inline asm>:1:2: note: instantiated into assembly here
>>>           mfc0    $2, $9
>>>           ^
>>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
>>>   In file included from include/linux/module.h:13:
>>>   In file included from include/linux/stat.h:19:
>>>   In file included from include/linux/time.h:60:
>>>   In file included from include/linux/time32.h:13:
>>>   In file included from include/linux/timex.h:67:
>>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a =
CPU feature not currently enabled
>>>                   return read_c0_count();
>>>                          ^
>>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from =
macro 'read_c0_count'
>>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
>>>                                   ^
>>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro =
'__read_32bit_c0_register'
>>>           ___read_32bit_c0_register(source, sel, __volatile__)
>>>           ^
>>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro =
'___read_32bit_c0_register'
>>>                           "mfc0\t%0, " #source "\n\t"                =
     \
>>>                           ^
>>>   <inline asm>:1:2: note: instantiated into assembly here
>>>           mfc0    $2, $9
>>>           ^
>>>   In file included from drivers/net/hamradio/baycom_epp.c:29:
>>>   In file included from include/linux/module.h:13:
>>>   In file included from include/linux/stat.h:19:
>>>   In file included from include/linux/time.h:60:
>>>   In file included from include/linux/time32.h:13:
>>>   In file included from include/linux/timex.h:67:
>>>>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a =
CPU feature not currently enabled
>>>                   return read_c0_count();
>>>                          ^
>>>   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from =
macro 'read_c0_count'
>>>   #define read_c0_count()         __read_32bit_c0_register($9, 0)
>>>                                   ^
>>>   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro =
'__read_32bit_c0_register'
>>>           ___read_32bit_c0_register(source, sel, __volatile__)
>>>           ^
>>>   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro =
'___read_32bit_c0_register'
>>>                           "mfc0\t%0, " #source "\n\t"                =
     \
>>>                           ^
>>>   <inline asm>:1:2: note: instantiated into assembly here
>>>           mfc0    $2, $9
>>>           ^
>>>   4 errors generated.
>>>=20
>>>=20
>>> vim +75 arch/mips/include/asm/timex.h
>>>=20
>>> 9c9b415c50bc29 Ralf Baechle       2013-09-12  71 =20
>>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  72  static inline =
cycles_t get_cycles(void)
>>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  73  {
>>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  74   if =
(can_use_mips_counter(read_c0_prid()))
>>> 9c9b415c50bc29 Ralf Baechle       2013-09-12 @75   return =
read_c0_count();
>>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  76   else
>>> 06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  77   return 0; /* no =
usable counter */
>>> 9c9b415c50bc29 Ralf Baechle       2013-09-12  78  }
>>> 1c99c6a7c3c599 Jason A. Donenfeld 2022-04-08  79  #define get_cycles =
get_cycles
>>> 9c9b415c50bc29 Ralf Baechle       2013-09-12  80 =20
>>>=20
>>> :::::: The code at line 75 was first introduced by commit
>>> :::::: 9c9b415c50bc298ac61412dff856eae2f54889ee MIPS: Reimplement =
get_cycles().
>>>=20
>>> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
>>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>>>=20
>>> --=20
>>> 0-DAY CI Kernel Test Service
>>> https://github.com/intel/lkp-tests
>>=20
>> --=20
>> Regards/Gruss,
>>    Boris.
>>=20
>> https://people.kernel.org/tglx/notes-about-netiquette

