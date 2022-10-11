Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4C5FAF67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJKJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJKJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:35:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043321EED1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:35:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MmrGv4NDMz4x1F;
        Tue, 11 Oct 2022 20:35:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1665480908;
        bh=YwJdh7W1HQe11kjs4IuDI2P8WyC3aa+tzh5fvsTHBJg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QHRdOdpL55OfQgDe93lCrQyGdvlBgT1zOJ+wbYonQwr6f9VPaZsete2c9ULsliKFp
         FCANFGKxDQTOO7TkS0Ew3NvBKyuahu5JOKM5Bda91bIip7yJMQ0cdwh6BcNeaatTSC
         fP4ZiAzrO42/pDcYy6YI1lBNJ3jYHp39RWNnySCJJVt1NhR7c5Dbh2n8dIm0y5ODD9
         OSY3WSr8PUyYWq3OdPl898wN9myovqaCvteeXbn3myg7KKeChqmht1X9TI3tf2ZZId
         TsC2PZMEDn0V213B1icKeK+SIF+KbO22/yUVkJsxwSubd/DFaEmW/zn5h+apxJYTjy
         WkXYYSnW4UVqg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>, rmclure@linux.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com,
        david@redhat.com, farosas@linux.ibm.com, geoff@infradead.org,
        gustavoars@kernel.org, haren@linux.ibm.com, hbathini@linux.ibm.com,
        joel@jms.id.au, lihuafei1@huawei.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, ruscur@russell.cc,
        windhl@126.com, wsa+renesas@sang-engineering.com,
        ye.xingchen@zte.com.cn, yuanjilin@cdjrlc.com,
        zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
In-Reply-To: <Y0TbfObFu2YRDm0I@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au> <Y0RxpSFyn9m68zIb@zx2c4.com>
 <Y0R6fcvgGA858TQA@zx2c4.com> <Y0ScAhqysKK6Hrks@zx2c4.com>
 <d402a6a0a11d84906ecba3909f4c8f880298dc0f.camel@linux.ibm.com>
 <Y0S1DxwKCm0aVQjT@zx2c4.com> <877d17nngr.fsf@mpe.ellerman.id.au>
 <Y0TbfObFu2YRDm0I@zx2c4.com>
Date:   Tue, 11 Oct 2022 20:34:56 +1100
Message-ID: <871qreog8v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> On Tue, Oct 11, 2022 at 12:44:20PM +1100, Michael Ellerman wrote:
>> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
>> > Hi Andrew,
>> >
>> > On Tue, Oct 11, 2022 at 11:00:15AM +1100, Andrew Donnellan wrote:
>> >> Thanks for bisecting, this is interesting! Could you provide your
>> >> .config and the environment you're running in? Your reproducer doesn't
>> >> seem to trigger it on my baremetal POWER8 pseries_le_defconfig.
>> >
>> > Sure.
>> >
>> > .config: https://xn--4db.cc/NemFt2Vs (change CONFIG_INITRAMFS_SOURCE)
>> > Toolchain: https://download.wireguard.com/qemu-test/toolchains/20211123/powerpc-linux-musl-cross.tgz
>> >
>> > You can also just run:
>> >
>> >   ARCH=powerpc make -C tools/testing/selftests/wireguard/qemu -j$(nproc)
>> >
>> > And that'll assemble the whole thing.
>> 
>> I tried that :)
>> 
>> What host OS are you running that on?
>> 
>> I get:
>> 
>>   mkdir -p /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc
>>   powerpc-linux-musl-gcc -o /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc/init -O3 -pipe  -std=gnu11 init.c
>>   /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc/powerpc-linux-musl-cross/bin/../lib/gcc/powerpc-linux-musl/11.2.1/../../../../powerpc-linux-musl/bin/ld: cannot find Scrt1.o: No such file or directory
>>   /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc/powerpc-linux-musl-cross/bin/../lib/gcc/powerpc-linux-musl/11.2.1/../../../../powerpc-linux-musl/bin/ld: cannot find crti.o: No such file or directory
>>   /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc/powerpc-linux-musl-cross/bin/../lib/gcc/powerpc-linux-musl/11.2.1/../../../../powerpc-linux-musl/bin/ld: cannot find crtbeginS.o: No such file or directory
>>   /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc/powerpc-linux-musl-cross/bin/../lib/gcc/powerpc-linux-musl/11.2.1/../../../../powerpc-linux-musl/bin/ld: cannot find -lgcc
>>   /scratch/michael/linus/tools/testing/selftests/wireguard/qemu/build/powerpc/powerpc-linux-musl-cross/bin/../lib/gcc/powerpc-linux-musl/11.2.1/../../../../powerpc-linux-musl/bin/ld: cannot find -lgcc
>>   collect2: error: ld returned 1 exit status
>
> Here's what happened:
>
> - You started the thing and the kernel compile complained about an
>   unclean tree.
> - You ran mrproper.
> - You tried to run the thing again.
>
> amirite?

I think so yeah. I tried it on 3 different machines so I'm not sure
exactly what I did where, but I definitely ran mrproper on one of them.

> If so, what happened is that mrproper deleted the .o files from the
> toolchain. Solution:
>
>   ARCH=powerpc make -C tools/testing/selftests/wireguard/qemu -j$(nproc) clean
>   ARCH=powerpc make -C tools/testing/selftests/wireguard/qemu -j$(nproc)
>
> Let me know how that goes.

Yep that works thanks.

And I see the iperf failure. Though I still can't see what the bug is,
but hopefully if I stare at it longer I'll work it out.

cheers
