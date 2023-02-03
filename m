Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD668A521
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjBCWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBCWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:01:33 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFC4A9D6B;
        Fri,  3 Feb 2023 14:01:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1F78E32002E2;
        Fri,  3 Feb 2023 17:01:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 03 Feb 2023 17:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675461688; x=1675548088; bh=6hGsQY2YE0
        YUzuNJwQtbkRiJziM8Dk9CAG6L/rxkgME=; b=mSMSVb0LRavf5lZeFq9/ZJi/H7
        aOklMU+HWrVU/k9j/mIjaThiaXv98ywddnYZ8deDuwhCXlkPylHhv/imJcRCnvnJ
        Wg2WXwQh/RoargP4fDk9chauAutyghSPEyn3PDrt+TX93mkwYhSUi9ilGqEAc3gQ
        YEjWXS6L8+9+8RaxEKbmApHZpPj/esC3ZZbwo04IXwKsCbH7hF3OfvNJGvbocR8B
        4VBSErjFDPJn3clzYIdRm/rmcSw7BPAue5r+krk6bWdWjM04yKd/7RlE/KxD+KUx
        GwPKVGuf4GFJlyq0IjOrgAb/2KSxRVrTkI4kuFoMAbbyplZW8o58icfKaSZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675461688; x=1675548088; bh=6hGsQY2YE0YUzuNJwQtbkRiJziM8
        Dk9CAG6L/rxkgME=; b=Q1IGsS7AYjA5tehO+T+paosV/APSMPBl4tAIPx2gOUQg
        MmgWZgC35L7iLy8qwVq8DgLQKJKmVle8w7nL9XtP41wqt7lmeX56QAPcneTgUZzo
        QBeW+YpS37UGzuOvjUIsbidur3WReyEZrUImdODDIDJBHe9P56E+F8IFrfDrMOSp
        RK5Lm8jVTVIrRJ7W/zfzqpA8Ovfd9z5WEfwY2wJTG5uZkwalQtfrZ3l2hUud6tXr
        ihibNqxokP9bzh7cqv4lJNpQNeTwn5nV1LMEWQa5aodLFa0wYR6y9cKJaXlhhRlR
        3Gm9ps383tlesqCjnl10V91V7kgKw69dxtJIiECLZQ==
X-ME-Sender: <xms:OITdY3W6bW_SpqlOkyJLgE03o_mL_BF8kw_yQr9H5imkUClea4BomQ>
    <xme:OITdY_mdD6lo_hsMsk2hza__gDvIDFz74jzAq4i5xPzBp6hrXzl9XI1MD5EynpL4U
    pxoYDaFn1deobgQgtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegtddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OITdYzZRgIrw_7KcqW0y2vNqNQ6QvVfbo3YC08AoTD8FOJ7HLks1Ng>
    <xmx:OITdYyWERDgHeFzMfVAj3y_NyTRkc9f1WqzinCAygtOyFbDnZ3Jpdw>
    <xmx:OITdYxlGRagRfJ_6P7lVzKMiAd7UttgsLF3nN1LlniUItZDI3PyFcA>
    <xmx:OITdY0-V7faPkTHO_T-AnpdjBHnCtiAUPDgkPyOYO5pYrhRIqGpp0Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 116ACB6044F; Fri,  3 Feb 2023 17:01:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <6a9d6c05-b232-49f2-a269-74ebe249f961@app.fastmail.com>
In-Reply-To: <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
References: <20230203193523.never.667-kees@kernel.org>
 <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
Date:   Fri, 03 Feb 2023 23:01:09 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Aleksa Sarai" <cyphar@cyphar.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Alexander Potapenko" <glider@google.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023, at 22:23, Arnd Bergmann wrote:
> On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
>> While there is logic about the difference between ksize and usize,
>> copy_struct_from_user() didn't check the size of the destination buffer
>> (when it was known) against ksize. Add this check so there is an upper
>> bounds check on the possible memset() call, otherwise lower bounds
>> checks made by callers will trigger bounds warnings under -Warray-bounds.
>> Seen under GCC 13:
>>
>> In function 'copy_struct_from_user',
>>     inlined from 'iommufd_fops_ioctl' at
>> ../drivers/iommu/iommufd/main.c:333:8:
>> ../include/linux/fortify-string.h:59:33: warning: '__builtin_memset' 
>> offset [57, 4294967294] is out of the bounds [0, 56] of object 'buf' 
>> with type 'union ucmd_buffer' [-Warray-bounds=]
>>    59 | #define __underlying_memset     __builtin_memset
>>       |                                 ^
>> ../include/linux/fortify-string.h:453:9: note: in expansion of macro 
>> '__underlying_memset'
>>   453 |         __underlying_memset(p, c, __fortify_size); \
>>       |         ^~~~~~~~~~~~~~~~~~~
>> ../include/linux/fortify-string.h:461:25: note: in expansion of macro 
>> '__fortify_memset_chk'
>>   461 | #define memset(p, c, s) __fortify_memset_chk(p, c, s, \
>>       |                         ^~~~~~~~~~~~~~~~~~~~
>> ../include/linux/uaccess.h:334:17: note: in expansion of macro 'memset'
>>   334 |                 memset(dst + size, 0, rest);
>>       |                 ^~~~~~
>> ../drivers/iommu/iommufd/main.c: In function 'iommufd_fops_ioctl':
>> ../drivers/iommu/iommufd/main.c:311:27: note: 'buf' declared here
>>   311 |         union ucmd_buffer buf;
>>       |                           ^~~
>>
>
> Hi Kees,
>
> I started building with gcc-13.0.1 myself but ran into a lot of
> other -Warray-bounds warnings in randconfig builds, so I ended up
> turning it off once more with CONFIG_CC_NO_ARRAY_BOUNDS in order
> to keep building without warnings.
>
> Is there anything else I need to do to get to the point of
> just addressing actual issues instead of false positives?
> Do you already have a patch series for fixing the others?

For reference, I just tried it out again and within half an hour I found
about 30 unique warnings, which is way less than I had remembered,
though some of these just show up a lot:

arch/arm/include/asm/io.h:113:9: error: array subscript 0 is outside array bounds of 'void[0]' [-Werror=array-bounds=]
arch/arm/include/asm/io.h:95:9: error: array subscript 0 is outside array bounds of 'void[0]' [-Werror=array-bounds=]
arch/arm/include/asm/memory.h:311:22: error: array subscript -1 is outside array bounds of 'char[2147483647]' [-Werror=array-bounds=]
arch/arm64/kernel/setup.c:228:56: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds=]
arch/x86/include/asm/io.h:56:3: error: array subscript 0 is outside array bounds of 'void[0]' [-Werror=array-bounds=]
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: error: array subscript 5 is outside array bounds of 'void[60]' [-Werror=array-bounds=]
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:329:46: error: array subscript 0 is outside array bounds of 'struct virt_dma_desc[24403223]' [-Werror=array-bounds=]
drivers/gpu/drm/nouveau/nvif/outp.c:140:9: error: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Werror=array-bounds=]
drivers/hwmon/lm85.c:1110:26: error: array subscript [0, 31] is outside array bounds of 'struct lm85_autofan[3]' [-Werror=array-bounds=]
drivers/infiniband/core/user_mad.c:564:50: error: array subscript 'struct ib_rmpp_mad[0]' is partly outside array bounds of 'unsigned char[140]' [-Werror=array-bounds=]
drivers/infiniband/core/user_mad.c:566:42: error: array subscript 'struct ib_rmpp_mad[0]' is partly outside array bounds of 'unsigned char[140]' [-Werror=array-bounds=]
drivers/infiniband/core/user_mad.c:618:25: error: array subscript 'struct ib_rmpp_mad[0]' is partly outside array bounds of 'unsigned char[140]' [-Werror=array-bounds=]
drivers/infiniband/core/user_mad.c:622:44: error: array subscript 'struct ib_rmpp_mad[0]' is partly outside array bounds of 'unsigned char[140]' [-Werror=array-bounds=]
drivers/media/tuners/mxl5005s.c:3429:72: error: array subscript 32 is above array bounds of 'u16[25]' {aka 'short unsigned int[25]'} [-Werror=array-bounds=]
drivers/media/tuners/mxl5005s.c:3448:70: error: array subscript 32 is above array bounds of 'u16[25]' {aka 'short unsigned int[25]'} [-Werror=array-bounds=]
drivers/spi/spi-imx.c:1687:34: error: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Werror=array-bounds=]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: error: array subscript 4 is outside array bounds of 'void[448]' [-Werror=array-bounds=]
drivers/staging/rtl8712/rtl871x_xmit.c:950:39: error: array subscript 4 is outside array bounds of 'void[448]' [-Werror=array-bounds=]
drivers/thermal/hisi_thermal.c:430:21: error: array subscript 1 is outside array bounds of 'void[20]' [-Werror=array-bounds=]
drivers/thermal/hisi_thermal.c:431:21: error: array subscript 1 is outside array bounds of 'void[20]' [-Werror=array-bounds=]
drivers/thermal/hisi_thermal.c:432:21: error: array subscript 1 is outside array bounds of 'void[20]' [-Werror=array-bounds=]
drivers/usb/host/xhci-mvebu.c:37:28: error: array subscript [0, 89478485] is outside array bounds of 'const struct mbus_dram_window[0]' [-Werror=array-bounds=]
drivers/usb/storage/ene_ub6250.c:1050:44: error: array subscript 'struct ms_bootblock_idi[0]' is partly outside array bounds of 'unsigned char[512]' [-Werror=array-bounds=]
fs/btrfs/sysfs.c:636:13: error: array subscript -18 is outside array bounds of 'struct kobject[59652323]' [-Werror=array-bounds=]
fs/crypto/fname.c:506:33: error: array subscript 'struct fscrypt_nokey_name[0]' is partly outside array bounds of 'unsigned char[189]' [-Werror=array-bounds=]
include/linux/fortify-string.h:25:34: error: array subscript 0 is outside array bounds of 'const char[0]' [-Werror=array-bounds=]
include/linux/fortify-string.h:57:33: error: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Werror=array-bounds=]
net/socket.c:651:21: error: array subscript -1 is outside array bounds of 'struct inode[3016128]' [-Werror=array-bounds=]
net/socket.c:652:26: error: array subscript -1 is outside array bounds of 'struct inode[3016128]' [-Werror=array-bounds=]

If you like, I can run this for a while longer to get to something close to
a complete list.

      Arnd
