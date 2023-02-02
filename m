Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432466877F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBBIzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBBIzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:55:23 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71859A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:55:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675328110; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o+XvIZNAedGuJoiFqFOS8PiWzfG2Y6znBPkQ5sepnXkngV0YCCU1Fj+1vGThTSpkxY
    jhL5W7Sww8nJDWQhfr9YIY45gsKostipTWvU8+4aNa0DZeLZfRRKStDLpiUCtSugXpo7
    IBHBhuqY6zNtWCHPmET3yQ04kXbRfiwzyoZLnHhzg1egfl2FAdnk/rwnD7ZedVSFq2wu
    iSg5RZ6w3jivWZGU6adav0nZ2ZjnPH7WaQsZPcCF5DFlovlGqiHzMVU0yuTRA2AfG+6M
    2cUayyNUUi6mLjuoYyy9lnTjyIswEiZ9lTBdPh/YMBOIItjEGCXBTFy5nNtk7DtisELZ
    vjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675328110;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3qnt0EzV3GulHFz7ITUOh8AVPFokRUcMr6jPqKagQ68=;
    b=r1nlJTo2Uy23lZwdefmuDV+jPvuzeIXVVcPQr8oyw4B4TYezMv+ZI0cAt9Kr7bxuh8
    EvpNBAcw+v0MYquBi99BPxfB/79cvdvzkKVbTqGXzaIIM6g5qycsQCORo2bTA+IfEo4n
    htI/k05fT76e0Wo85Dig4MedGf92mutntkRWtIshOB6Gp6Z1XXYjywKRCLdtfJtwLE0o
    0tkLaGUCxwXPH7RnRExOtEPZdk6up98gBT1Db+ZBAG9Ws94JC1USsXJMCdygjIqoDfUH
    L0xT7hukkZCIp2k7l0TDq0dC+UuTEXffbhTTeJjjAp5A0MnZmwjkTOzCP6+NL0iObbgu
    j6TA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675328110;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=3qnt0EzV3GulHFz7ITUOh8AVPFokRUcMr6jPqKagQ68=;
    b=tb18HBOdRp1CEc8cXHWlyYRNtJR0AZvK7x9GmaUejnWk/cyOjoLBqCOHyl38EG0F9r
    mf88r0W/MpdnPx8EKVfCgNAWdJk7qSrPH8nVVCi6bm+WZHfdp2JBMWhCzBmyo2AHeP3j
    QSMn+xzT/s0giFzek9ZRaWFN4H2/d/aOHcAhyzhioX0Ti/U1P6J49eBoSJLG436dV1Hm
    EdUoUcd8XJ+Piz6lOHHWhPScJr3ZRijWQAirTYT7o3bJ9aIzYcwMDpPqlqBlspnYDKRU
    BNntbxjVWjKfq8XrjEWAz44lvXCy5YPLOblIKbGHBgWW7dAdNRYUcvcTgmjBcvS3jIc6
    XZsg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGer3Q="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.2.2 DYNA|AUTH)
    with ESMTPSA id e4ab20z128t9Yl2
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 2 Feb 2023 09:55:09 +0100 (CET)
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_A761AAEC-EE46-45A3-8631-8C49F2CD0DC3"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [BUG] Add missing <linux/string.h> include for strcmp.
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <C11D0452-926E-4F06-B45F-004091200DA2@gentoo.org>
Date:   Thu, 2 Feb 2023 09:55:08 +0100
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <F330EEDE-E908-45EB-832B-61CFB96C7B28@goldelico.com>
References: <C11D0452-926E-4F06-B45F-004091200DA2@gentoo.org>
To:     Sam James <sam@gentoo.org>
X-Mailer: Apple Mail (2.3445.104.21)
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_A761AAEC-EE46-45A3-8631-8C49F2CD0DC3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Sam,

> Am 02.02.2023 um 00:37 schrieb Sam James <sam@gentoo.org>:
>=20
> Finally getting back to this. Thanks for reporting the problem (we =
reverted it as a result, obviously).
>=20
> Would you mind sharing a preprocessed version of the failing file =
please?
>=20
> (Passing -save-temps to CC can do this, the relevant files should be =
xx.i)

Build v6.1-rc7 with ARCH=3Darm V=3D2 clean omap2plus_defconfig uImage

...
  SYSTBL  arch/arm/include/generated/calls-oabi.S - due to calls-oabi.S =
not in $(targets)
  SYSTBL  arch/arm/include/generated/calls-eabi.S - due to calls-eabi.S =
not in $(targets)
  HOSTCC  scripts/mod/mk_elfconfig - due to missing .cmd file
  CC      scripts/mod/empty.o - due to target missing
  MKELF   scripts/mod/elfconfig.h - due to: scripts/mod/empty.o =
scripts/mod/mk_elfconfig
  HOSTCC  scripts/mod/modpost.o - due to target missing
In file included from include/linux/string.h:5,
                 from scripts/mod/../../include/linux/license.h:5,
                 from scripts/mod/modpost.c:24:
include/linux/compiler.h:246:10: fatal error: asm/rwonce.h: No such file =
or directory
  246 | #include <asm/rwonce.h>
      |          ^~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.host:128: recipe for target 'scripts/mod/modpost.o' =
failed
make[2]: *** [scripts/mod/modpost.o] Error 1
Makefile:1269: recipe for target 'prepare0' failed
make[1]: *** [prepare0] Error 2
Makefile:362: recipe for target '__build_one_by_one' failed
make: *** [__build_one_by_one] Error 2

Attached is the modpost.i
After the failed #include it is apparently incomplete.

BR and thanks,
Nikolaus


--Apple-Mail=_A761AAEC-EE46-45A3-8631-8C49F2CD0DC3
Content-Disposition: attachment;
	filename=modpost.i
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="modpost.i"
Content-Transfer-Encoding: 7bit

# 1 "scripts/mod/modpost.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "scripts/mod/modpost.c"
# 15 "scripts/mod/modpost.c"
# 1 "../host/elf.h" 1
# 22 "../host/elf.h"
# 1 "../host/features.h" 1
# 346 "../host/features.h"
# 1 "../host/stdc-predef.h" 1
# 347 "../host/features.h" 2
# 368 "../host/features.h"
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 1 3 4
# 608 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_symbol_aliasing.h" 1 3 4
# 609 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 2 3 4
# 674 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_posix_availability.h" 1 3 4
# 675 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 2 3 4
# 369 "../host/features.h" 2
# 392 "../host/features.h"
# 1 "../host/gnu/stubs.h" 1






# 1 "../host/gnu/stubs-soft.h" 1
# 8 "../host/gnu/stubs.h" 2
# 393 "../host/features.h" 2
# 23 "../host/elf.h" 2





# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdint.h" 1 3 4
# 9 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdint.h" 3 4
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 1 3 4
# 27 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int8_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int8_t.h" 3 4

# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int8_t.h" 3 4
typedef signed char int8_t;
# 28 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int16_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int16_t.h" 3 4
typedef short int16_t;
# 29 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int32_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int32_t.h" 3 4
typedef int int32_t;
# 30 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int64_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int64_t.h" 3 4
typedef long long int64_t;
# 31 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint8_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint8_t.h" 3 4
typedef unsigned char uint8_t;
# 33 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint16_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint16_t.h" 3 4
typedef unsigned short uint16_t;
# 34 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint32_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint32_t.h" 3 4
typedef unsigned int uint32_t;
# 35 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint64_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint64_t.h" 3 4
typedef unsigned long long uint64_t;
# 36 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4


typedef int8_t int_least8_t;
typedef int16_t int_least16_t;
typedef int32_t int_least32_t;
typedef int64_t int_least64_t;
typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;
typedef uint32_t uint_least32_t;
typedef uint64_t uint_least64_t;



typedef int8_t int_fast8_t;
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef int64_t int_fast64_t;
typedef uint8_t uint_fast8_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
typedef uint64_t uint_fast64_t;




# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 1 3 4
# 33 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_types.h" 1 3 4
# 32 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_types.h" 1 3 4
# 37 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_types.h" 3 4
typedef signed char __int8_t;



typedef unsigned char __uint8_t;
typedef short __int16_t;
typedef unsigned short __uint16_t;
typedef int __int32_t;
typedef unsigned int __uint32_t;
typedef long long __int64_t;
typedef unsigned long long __uint64_t;

typedef long __darwin_intptr_t;
typedef unsigned int __darwin_natural_t;
# 70 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_types.h" 3 4
typedef int __darwin_ct_rune_t;





typedef union {
 char __mbstate8[128];
 long long _mbstateL;
} __mbstate_t;

typedef __mbstate_t __darwin_mbstate_t;


typedef long int __darwin_ptrdiff_t;







typedef long unsigned int __darwin_size_t;





typedef __builtin_va_list __darwin_va_list;





typedef int __darwin_wchar_t;




typedef __darwin_wchar_t __darwin_rune_t;


typedef int __darwin_wint_t;




typedef unsigned long __darwin_clock_t;
typedef __uint32_t __darwin_socklen_t;
typedef long __darwin_ssize_t;
typedef long __darwin_time_t;
# 33 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_types.h" 2 3 4
# 34 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 2 3 4
# 55 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 3 4
typedef __int64_t __darwin_blkcnt_t;
typedef __int32_t __darwin_blksize_t;
typedef __int32_t __darwin_dev_t;
typedef unsigned int __darwin_fsblkcnt_t;
typedef unsigned int __darwin_fsfilcnt_t;
typedef __uint32_t __darwin_gid_t;
typedef __uint32_t __darwin_id_t;
typedef __uint64_t __darwin_ino64_t;

typedef __darwin_ino64_t __darwin_ino_t;



typedef __darwin_natural_t __darwin_mach_port_name_t;
typedef __darwin_mach_port_name_t __darwin_mach_port_t;
typedef __uint16_t __darwin_mode_t;
typedef __int64_t __darwin_off_t;
typedef __int32_t __darwin_pid_t;
typedef __uint32_t __darwin_sigset_t;
typedef __int32_t __darwin_suseconds_t;
typedef __uint32_t __darwin_uid_t;
typedef __uint32_t __darwin_useconds_t;
typedef unsigned char __darwin_uuid_t[16];
typedef char __darwin_uuid_string_t[37];

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_types.h" 1 3 4
# 57 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_types.h" 3 4
struct __darwin_pthread_handler_rec {
 void (*__routine)(void *);
 void *__arg;
 struct __darwin_pthread_handler_rec *__next;
};

struct _opaque_pthread_attr_t {
 long __sig;
 char __opaque[56];
};

struct _opaque_pthread_cond_t {
 long __sig;
 char __opaque[40];
};

struct _opaque_pthread_condattr_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_mutex_t {
 long __sig;
 char __opaque[56];
};

struct _opaque_pthread_mutexattr_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_once_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_rwlock_t {
 long __sig;
 char __opaque[192];
};

struct _opaque_pthread_rwlockattr_t {
 long __sig;
 char __opaque[16];
};

struct _opaque_pthread_t {
 long __sig;
 struct __darwin_pthread_handler_rec *__cleanup_stack;
 char __opaque[8176];
};

typedef struct _opaque_pthread_attr_t __darwin_pthread_attr_t;
typedef struct _opaque_pthread_cond_t __darwin_pthread_cond_t;
typedef struct _opaque_pthread_condattr_t __darwin_pthread_condattr_t;
typedef unsigned long __darwin_pthread_key_t;
typedef struct _opaque_pthread_mutex_t __darwin_pthread_mutex_t;
typedef struct _opaque_pthread_mutexattr_t __darwin_pthread_mutexattr_t;
typedef struct _opaque_pthread_once_t __darwin_pthread_once_t;
typedef struct _opaque_pthread_rwlock_t __darwin_pthread_rwlock_t;
typedef struct _opaque_pthread_rwlockattr_t __darwin_pthread_rwlockattr_t;
typedef struct _opaque_pthread_t *__darwin_pthread_t;
# 81 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 2 3 4
# 62 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 1 3 4
# 35 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 1 3 4
# 81 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int8_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int8_t.h" 3 4
typedef unsigned char u_int8_t;
# 82 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int16_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int16_t.h" 3 4
typedef unsigned short u_int16_t;
# 83 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int32_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int32_t.h" 3 4
typedef unsigned int u_int32_t;
# 84 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int64_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int64_t.h" 3 4
typedef unsigned long long u_int64_t;
# 85 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4


typedef int64_t register_t;




# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 1 3 4
# 93 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uintptr_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uintptr_t.h" 3 4
typedef unsigned long uintptr_t;
# 94 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 111 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 3 4
typedef u_int64_t syscall_arg_t;
# 36 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 2 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 2 3 4

typedef __darwin_intptr_t intptr_t;
# 63 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4




# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_intmax_t.h" 1 3 4
# 32 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_intmax_t.h" 3 4
typedef long int intmax_t;
# 68 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uintmax_t.h" 1 3 4
# 32 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types/_uintmax_t.h" 3 4
typedef long unsigned int uintmax_t;
# 69 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdint.h" 2 3 4
# 10 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdint.h" 2 3 4
# 29 "../host/elf.h" 2



# 31 "../host/elf.h"
typedef uint16_t Elf32_Half;
typedef uint16_t Elf64_Half;


typedef uint32_t Elf32_Word;
typedef int32_t Elf32_Sword;
typedef uint32_t Elf64_Word;
typedef int32_t Elf64_Sword;


typedef uint64_t Elf32_Xword;
typedef int64_t Elf32_Sxword;
typedef uint64_t Elf64_Xword;
typedef int64_t Elf64_Sxword;


typedef uint32_t Elf32_Addr;
typedef uint64_t Elf64_Addr;


typedef uint32_t Elf32_Off;
typedef uint64_t Elf64_Off;


typedef uint16_t Elf32_Section;
typedef uint16_t Elf64_Section;


typedef Elf32_Half Elf32_Versym;
typedef Elf64_Half Elf64_Versym;






typedef struct
{
  unsigned char e_ident[(16)];
  Elf32_Half e_type;
  Elf32_Half e_machine;
  Elf32_Word e_version;
  Elf32_Addr e_entry;
  Elf32_Off e_phoff;
  Elf32_Off e_shoff;
  Elf32_Word e_flags;
  Elf32_Half e_ehsize;
  Elf32_Half e_phentsize;
  Elf32_Half e_phnum;
  Elf32_Half e_shentsize;
  Elf32_Half e_shnum;
  Elf32_Half e_shstrndx;
} Elf32_Ehdr;

typedef struct
{
  unsigned char e_ident[(16)];
  Elf64_Half e_type;
  Elf64_Half e_machine;
  Elf64_Word e_version;
  Elf64_Addr e_entry;
  Elf64_Off e_phoff;
  Elf64_Off e_shoff;
  Elf64_Word e_flags;
  Elf64_Half e_ehsize;
  Elf64_Half e_phentsize;
  Elf64_Half e_phnum;
  Elf64_Half e_shentsize;
  Elf64_Half e_shnum;
  Elf64_Half e_shstrndx;
} Elf64_Ehdr;
# 384 "../host/elf.h"
typedef struct
{
  Elf32_Word sh_name;
  Elf32_Word sh_type;
  Elf32_Word sh_flags;
  Elf32_Addr sh_addr;
  Elf32_Off sh_offset;
  Elf32_Word sh_size;
  Elf32_Word sh_link;
  Elf32_Word sh_info;
  Elf32_Word sh_addralign;
  Elf32_Word sh_entsize;
} Elf32_Shdr;

typedef struct
{
  Elf64_Word sh_name;
  Elf64_Word sh_type;
  Elf64_Xword sh_flags;
  Elf64_Addr sh_addr;
  Elf64_Off sh_offset;
  Elf64_Xword sh_size;
  Elf64_Word sh_link;
  Elf64_Word sh_info;
  Elf64_Xword sh_addralign;
  Elf64_Xword sh_entsize;
} Elf64_Shdr;
# 491 "../host/elf.h"
typedef struct
{
  Elf32_Word ch_type;
  Elf32_Word ch_size;
  Elf32_Word ch_addralign;
} Elf32_Chdr;

typedef struct
{
  Elf64_Word ch_type;
  Elf64_Word ch_reserved;
  Elf64_Xword ch_size;
  Elf64_Xword ch_addralign;
} Elf64_Chdr;
# 518 "../host/elf.h"
typedef struct
{
  Elf32_Word st_name;
  Elf32_Addr st_value;
  Elf32_Word st_size;
  unsigned char st_info;
  unsigned char st_other;
  Elf32_Section st_shndx;
} Elf32_Sym;

typedef struct
{
  Elf64_Word st_name;
  unsigned char st_info;
  unsigned char st_other;
  Elf64_Section st_shndx;
  Elf64_Addr st_value;
  Elf64_Xword st_size;
} Elf64_Sym;




typedef struct
{
  Elf32_Half si_boundto;
  Elf32_Half si_flags;
} Elf32_Syminfo;

typedef struct
{
  Elf64_Half si_boundto;
  Elf64_Half si_flags;
} Elf64_Syminfo;
# 633 "../host/elf.h"
typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
} Elf32_Rel;






typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
} Elf64_Rel;



typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
  Elf32_Sword r_addend;
} Elf32_Rela;

typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
  Elf64_Sxword r_addend;
} Elf64_Rela;
# 678 "../host/elf.h"
typedef struct
{
  Elf32_Word p_type;
  Elf32_Off p_offset;
  Elf32_Addr p_vaddr;
  Elf32_Addr p_paddr;
  Elf32_Word p_filesz;
  Elf32_Word p_memsz;
  Elf32_Word p_flags;
  Elf32_Word p_align;
} Elf32_Phdr;

typedef struct
{
  Elf64_Word p_type;
  Elf64_Word p_flags;
  Elf64_Off p_offset;
  Elf64_Addr p_vaddr;
  Elf64_Addr p_paddr;
  Elf64_Xword p_filesz;
  Elf64_Xword p_memsz;
  Elf64_Xword p_align;
} Elf64_Phdr;
# 790 "../host/elf.h"
typedef struct
{
  Elf32_Sword d_tag;
  union
    {
      Elf32_Word d_val;
      Elf32_Addr d_ptr;
    } d_un;
} Elf32_Dyn;

typedef struct
{
  Elf64_Sxword d_tag;
  union
    {
      Elf64_Xword d_val;
      Elf64_Addr d_ptr;
    } d_un;
} Elf64_Dyn;
# 966 "../host/elf.h"
typedef struct
{
  Elf32_Half vd_version;
  Elf32_Half vd_flags;
  Elf32_Half vd_ndx;
  Elf32_Half vd_cnt;
  Elf32_Word vd_hash;
  Elf32_Word vd_aux;
  Elf32_Word vd_next;

} Elf32_Verdef;

typedef struct
{
  Elf64_Half vd_version;
  Elf64_Half vd_flags;
  Elf64_Half vd_ndx;
  Elf64_Half vd_cnt;
  Elf64_Word vd_hash;
  Elf64_Word vd_aux;
  Elf64_Word vd_next;

} Elf64_Verdef;
# 1008 "../host/elf.h"
typedef struct
{
  Elf32_Word vda_name;
  Elf32_Word vda_next;

} Elf32_Verdaux;

typedef struct
{
  Elf64_Word vda_name;
  Elf64_Word vda_next;

} Elf64_Verdaux;




typedef struct
{
  Elf32_Half vn_version;
  Elf32_Half vn_cnt;
  Elf32_Word vn_file;

  Elf32_Word vn_aux;
  Elf32_Word vn_next;

} Elf32_Verneed;

typedef struct
{
  Elf64_Half vn_version;
  Elf64_Half vn_cnt;
  Elf64_Word vn_file;

  Elf64_Word vn_aux;
  Elf64_Word vn_next;

} Elf64_Verneed;
# 1055 "../host/elf.h"
typedef struct
{
  Elf32_Word vna_hash;
  Elf32_Half vna_flags;
  Elf32_Half vna_other;
  Elf32_Word vna_name;
  Elf32_Word vna_next;

} Elf32_Vernaux;

typedef struct
{
  Elf64_Word vna_hash;
  Elf64_Half vna_flags;
  Elf64_Half vna_other;
  Elf64_Word vna_name;
  Elf64_Word vna_next;

} Elf64_Vernaux;
# 1089 "../host/elf.h"
typedef struct
{
  uint32_t a_type;
  union
    {
      uint32_t a_val;



    } a_un;
} Elf32_auxv_t;

typedef struct
{
  uint64_t a_type;
  union
    {
      uint64_t a_val;



    } a_un;
} Elf64_auxv_t;
# 1176 "../host/elf.h"
typedef struct
{
  Elf32_Word n_namesz;
  Elf32_Word n_descsz;
  Elf32_Word n_type;
} Elf32_Nhdr;

typedef struct
{
  Elf64_Word n_namesz;
  Elf64_Word n_descsz;
  Elf64_Word n_type;
} Elf64_Nhdr;
# 1240 "../host/elf.h"
typedef struct
{
  Elf32_Xword m_value;
  Elf32_Word m_info;
  Elf32_Word m_poffset;
  Elf32_Half m_repeat;
  Elf32_Half m_stride;
} Elf32_Move;

typedef struct
{
  Elf64_Xword m_value;
  Elf64_Xword m_info;
  Elf64_Xword m_poffset;
  Elf64_Half m_repeat;
  Elf64_Half m_stride;
} Elf64_Move;
# 1629 "../host/elf.h"
typedef union
{
  struct
    {
      Elf32_Word gt_current_g_value;
      Elf32_Word gt_unused;
    } gt_header;
  struct
    {
      Elf32_Word gt_g_value;
      Elf32_Word gt_bytes;
    } gt_entry;
} Elf32_gptab;



typedef struct
{
  Elf32_Word ri_gprmask;
  Elf32_Word ri_cprmask[4];
  Elf32_Sword ri_gp_value;
} Elf32_RegInfo;



typedef struct
{
  unsigned char kind;

  unsigned char size;
  Elf32_Section section;

  Elf32_Word info;
} Elf_Options;
# 1705 "../host/elf.h"
typedef struct
{
  Elf32_Word hwp_flags1;
  Elf32_Word hwp_flags2;
} Elf_Options_Hw;
# 1871 "../host/elf.h"
typedef struct
{
  Elf32_Word l_name;
  Elf32_Word l_time_stamp;
  Elf32_Word l_checksum;
  Elf32_Word l_version;
  Elf32_Word l_flags;
} Elf32_Lib;

typedef struct
{
  Elf64_Word l_name;
  Elf64_Word l_time_stamp;
  Elf64_Word l_checksum;
  Elf64_Word l_version;
  Elf64_Word l_flags;
} Elf64_Lib;
# 1902 "../host/elf.h"
typedef Elf32_Addr Elf32_Conflict;

typedef struct
{

  Elf32_Half version;

  unsigned char isa_level;

  unsigned char isa_rev;

  unsigned char gpr_size;

  unsigned char cpr1_size;

  unsigned char cpr2_size;

  unsigned char fp_abi;

  Elf32_Word isa_ext;

  Elf32_Word ases;

  Elf32_Word flags1;
  Elf32_Word flags2;
} Elf_MIPS_ABIFlags_v0;
# 1978 "../host/elf.h"
enum
{

  Val_GNU_MIPS_ABI_FP_ANY = 0,

  Val_GNU_MIPS_ABI_FP_DOUBLE = 1,

  Val_GNU_MIPS_ABI_FP_SINGLE = 2,

  Val_GNU_MIPS_ABI_FP_SOFT = 3,

  Val_GNU_MIPS_ABI_FP_OLD_64 = 4,

  Val_GNU_MIPS_ABI_FP_XX = 5,

  Val_GNU_MIPS_ABI_FP_64 = 6,

  Val_GNU_MIPS_ABI_FP_64A = 7,

  Val_GNU_MIPS_ABI_FP_MAX = 7
};
# 3747 "../host/elf.h"

# 16 "scripts/mod/modpost.c" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/fnmatch.h" 1 3 4
# 78 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/fnmatch.h" 3 4


# 79 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/fnmatch.h" 3 4
int fnmatch(const char *, const char *, int) __asm("_" "fnmatch" );

# 17 "scripts/mod/modpost.c" 2
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 1 3 4
# 14 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdarg.h" 1 3 4
# 40 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 15 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 2 3 4
# 78 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 1 3 4
# 69 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/Availability.h" 1 3 4
# 238 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/Availability.h" 3 4
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/AvailabilityInternal.h" 1 3 4
# 239 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/Availability.h" 2 3 4
# 70 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types.h" 1 3 4
# 40 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_types.h" 3 4
typedef int __darwin_nl_item;
typedef int __darwin_wctrans_t;

typedef __uint32_t __darwin_wctype_t;
# 72 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 2 3 4



# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_va_list.h" 1 3 4
# 32 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_va_list.h" 3 4
typedef __darwin_va_list va_list;
# 76 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_size_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_size_t.h" 3 4
typedef __darwin_size_t size_t;
# 77 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_null.h" 1 3 4
# 78 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stdio.h" 1 3 4
# 37 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stdio.h" 3 4


int renameat(int, const char *, int, const char *) __attribute__((unavailable));
# 51 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stdio.h" 3 4

# 80 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 2 3 4

typedef __darwin_off_t fpos_t;
# 92 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 3 4
struct __sbuf {
 unsigned char *_base;
 int _size;
};


struct __sFILEX;
# 126 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h" 3 4
typedef struct __sFILE {
 unsigned char *_p;
 int _r;
 int _w;
 short _flags;
 short _file;
 struct __sbuf _bf;
 int _lbfsize;


 void *_cookie;
 int (* _close)(void *);
 int (* _read) (void *, char *, int);
 fpos_t (* _seek) (void *, fpos_t, int);
 int (* _write)(void *, const char *, int);


 struct __sbuf _ub;
 struct __sFILEX *_extra;
 int _ur;


 unsigned char _ubuf[3];
 unsigned char _nbuf[1];


 struct __sbuf _lb;


 int _blksize;
 fpos_t _offset;
} FILE;
# 79 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 2 3 4


extern FILE *__stdinp;
extern FILE *__stdoutp;
extern FILE *__stderrp;

# 155 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4

void clearerr(FILE *);
int fclose(FILE *);
int feof(FILE *);
int ferror(FILE *);
int fflush(FILE *);
int fgetc(FILE *);
int fgetpos(FILE * restrict, fpos_t *);
char *fgets(char * restrict, int, FILE *);



FILE *fopen(const char * restrict __filename, const char * restrict __mode) __asm("_" "fopen" );

int fprintf(FILE * restrict, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3)));
int fputc(int, FILE *);
int fputs(const char * restrict, FILE * restrict) __asm("_" "fputs" );
size_t fread(void * restrict __ptr, size_t __size, size_t __nitems, FILE * restrict __stream);
FILE *freopen(const char * restrict, const char * restrict,
                 FILE * restrict) __asm("_" "freopen" );
int fscanf(FILE * restrict, const char * restrict, ...) __attribute__((__format__ (__scanf__, 2, 3)));
int fseek(FILE *, long, int);
int fsetpos(FILE *, const fpos_t *);
long ftell(FILE *);
size_t fwrite(const void * restrict __ptr, size_t __size, size_t __nitems, FILE * restrict __stream) __asm("_" "fwrite" );
int getc(FILE *);
int getchar(void);
char *gets(char *);
void perror(const char *);
int printf(const char * restrict, ...) __attribute__((__format__ (__printf__, 1, 2)));
int putc(int, FILE *);
int putchar(int);
int puts(const char *);
int remove(const char *);
int rename (const char *__old, const char *__new);
void rewind(FILE *);
int scanf(const char * restrict, ...) __attribute__((__format__ (__scanf__, 1, 2)));
void setbuf(FILE * restrict, char * restrict);
int setvbuf(FILE * restrict, char * restrict, int, size_t);
int sprintf(char * restrict, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3))) ;
int sscanf(const char * restrict, const char * restrict, ...) __attribute__((__format__ (__scanf__, 2, 3)));
FILE *tmpfile(void);





char *tmpnam(char *);
int ungetc(int, FILE *);
int vfprintf(FILE * restrict, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0)));
int vprintf(const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 1, 0)));
int vsprintf(char * restrict, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0))) ;

# 218 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4




char *ctermid(char *);





FILE *fdopen(int, const char *) __asm("_" "fdopen" );

int fileno(FILE *);

# 245 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4

int pclose(FILE *) ;



FILE *popen(const char *, const char *) __asm("_" "popen" ) ;


# 266 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4

int __srget(FILE *);
int __svfscanf(FILE *, const char *, __gnuc_va_list) __attribute__((__format__ (__scanf__, 2, 0)));
int __swbuf(int, FILE *);








extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __sputc(int _c, FILE *_p) {
 if (--_p->_w >= 0 || (_p->_w >= _p->_lbfsize && (char)_c != '\n'))
  return (*_p->_p++ = _c);
 else
  return (__swbuf(_c, _p));
}
# 303 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4

void flockfile(FILE *);
int ftrylockfile(FILE *);
void funlockfile(FILE *);
int getc_unlocked(FILE *);
int getchar_unlocked(void);
int putc_unlocked(int, FILE *);
int putchar_unlocked(int);











char *tempnam(const char *__dir, const char *__prefix) __asm("_" "tempnam" );

# 342 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_off_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_off_t.h" 3 4
typedef __darwin_off_t off_t;
# 343 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 2 3 4


int fseeko(FILE * __stream, off_t __offset, int __whence);
off_t ftello(FILE * __stream);





int snprintf(char * restrict __str, size_t __size, const char * restrict __format, ...) __attribute__((__format__ (__printf__, 3, 4)));
int vfscanf(FILE * restrict __stream, const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__scanf__, 2, 0)));
int vscanf(const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__scanf__, 1, 0)));
int vsnprintf(char * restrict __str, size_t __size, const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__printf__, 3, 0)));
int vsscanf(const char * restrict __str, const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__scanf__, 2, 0)));

# 367 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ssize_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ssize_t.h" 3 4
typedef __darwin_ssize_t ssize_t;
# 368 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/stdio.h" 2 3 4


int dprintf(int, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3))) __attribute__((unavailable));
int vdprintf(int, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0))) __attribute__((unavailable));
ssize_t getdelim(char ** restrict __linep, size_t * restrict __linecapp, int __delimiter, FILE * restrict __stream) __attribute__((unavailable));
ssize_t getline(char ** restrict __linep, size_t * restrict __linecapp, FILE * restrict __stream) __attribute__((unavailable));
FILE *fmemopen(void * restrict __buf, size_t __size, const char * restrict __mode) ;
FILE *open_memstream(char **__bufp, size_t *__sizep) ;

# 18 "scripts/mod/modpost.c" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/ctype.h" 1 3 4
# 69 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/ctype.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_ctype.h" 1 3 4
# 70 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_ctype.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/runetype.h" 1 3 4
# 60 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/runetype.h" 3 4
typedef struct {
 __darwin_rune_t __min;
 __darwin_rune_t __max;
 __darwin_rune_t __map;
 __uint32_t *__types;
} _RuneEntry;

typedef struct {
 int __nranges;
 _RuneEntry *__ranges;
} _RuneRange;

typedef struct {
 char __name[14];
 __uint32_t __mask;
} _RuneCharClass;

typedef struct {
 char __magic[8];
 char __encoding[32];

 __darwin_rune_t (*__sgetrune)(const char *, __darwin_size_t, char const **);
 int (*__sputrune)(__darwin_rune_t, char *, __darwin_size_t, char **);
 __darwin_rune_t __invalid_rune;

 __uint32_t __runetype[(1 <<8 )];
 __darwin_rune_t __maplower[(1 <<8 )];
 __darwin_rune_t __mapupper[(1 <<8 )];






 _RuneRange __runetype_ext;
 _RuneRange __maplower_ext;
 _RuneRange __mapupper_ext;

 void *__variable;
 int __variable_len;




 int __ncharclasses;
 _RuneCharClass *__charclasses;
} _RuneLocale;




extern _RuneLocale _DefaultRuneLocale;
extern _RuneLocale *_CurrentRuneLocale;

# 71 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_ctype.h" 2 3 4
# 128 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_ctype.h" 3 4

unsigned long ___runetype(__darwin_ct_rune_t);
__darwin_ct_rune_t ___tolower(__darwin_ct_rune_t);
__darwin_ct_rune_t ___toupper(__darwin_ct_rune_t);


extern __inline __attribute__((__gnu_inline__)) int
isascii(int _c)
{
 return ((_c & ~0x7F) == 0);
}
# 147 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_ctype.h" 3 4

int __maskrune(__darwin_ct_rune_t, unsigned long);



extern __inline __attribute__((__gnu_inline__)) int
__istype(__darwin_ct_rune_t _c, unsigned long _f)
{



 return (isascii(_c) ? !!(_DefaultRuneLocale.__runetype[_c] & _f)
  : !!__maskrune(_c, _f));

}

extern __inline __attribute__((__gnu_inline__)) __darwin_ct_rune_t
__isctype(__darwin_ct_rune_t _c, unsigned long _f)
{



 return (_c < 0 || _c >= (1 <<8 )) ? 0 :
  !!(_DefaultRuneLocale.__runetype[_c] & _f);

}
# 187 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_ctype.h" 3 4

__darwin_ct_rune_t __toupper(__darwin_ct_rune_t);
__darwin_ct_rune_t __tolower(__darwin_ct_rune_t);



extern __inline __attribute__((__gnu_inline__)) int
__wcwidth(__darwin_ct_rune_t _c)
{
 unsigned int _x;

 if (_c == 0)
  return (0);
 _x = (unsigned int)__maskrune(_c, 0xe0000000L|0x00040000L);
 if ((_x & 0xe0000000L) != 0)
  return ((_x & 0xe0000000L) >> 30);
 return ((_x & 0x00040000L) != 0 ? 1 : -1);
}






extern __inline __attribute__((__gnu_inline__)) int
isalnum(int _c)
{
 return (__istype(_c, 0x00000100L|0x00000400L));
}

extern __inline __attribute__((__gnu_inline__)) int
isalpha(int _c)
{
 return (__istype(_c, 0x00000100L));
}

extern __inline __attribute__((__gnu_inline__)) int
isblank(int _c)
{
 return (__istype(_c, 0x00020000L));
}

extern __inline __attribute__((__gnu_inline__)) int
iscntrl(int _c)
{
 return (__istype(_c, 0x00000200L));
}


extern __inline __attribute__((__gnu_inline__)) int
isdigit(int _c)
{
 return (__isctype(_c, 0x00000400L));
}

extern __inline __attribute__((__gnu_inline__)) int
isgraph(int _c)
{
 return (__istype(_c, 0x00000800L));
}

extern __inline __attribute__((__gnu_inline__)) int
islower(int _c)
{
 return (__istype(_c, 0x00001000L));
}

extern __inline __attribute__((__gnu_inline__)) int
isprint(int _c)
{
 return (__istype(_c, 0x00040000L));
}

extern __inline __attribute__((__gnu_inline__)) int
ispunct(int _c)
{
 return (__istype(_c, 0x00002000L));
}

extern __inline __attribute__((__gnu_inline__)) int
isspace(int _c)
{
 return (__istype(_c, 0x00004000L));
}

extern __inline __attribute__((__gnu_inline__)) int
isupper(int _c)
{
 return (__istype(_c, 0x00008000L));
}


extern __inline __attribute__((__gnu_inline__)) int
isxdigit(int _c)
{
 return (__isctype(_c, 0x00010000L));
}

extern __inline __attribute__((__gnu_inline__)) int
toascii(int _c)
{
 return (_c & 0x7F);
}

extern __inline __attribute__((__gnu_inline__)) int
tolower(int _c)
{
        return (__tolower(_c));
}

extern __inline __attribute__((__gnu_inline__)) int
toupper(int _c)
{
        return (__toupper(_c));
}
# 70 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/ctype.h" 2 3 4
# 19 "scripts/mod/modpost.c" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/string.h" 1 3 4
# 69 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/string.h" 3 4

void *memchr(const void *__s, int __c, size_t __n);
int memcmp(const void *__s1, const void *__s2, size_t __n);
void *memcpy(void *__dst, const void *__src, size_t __n);
void *memmove(void *__dst, const void *__src, size_t __len);
void *memset(void *__b, int __c, size_t __len);
char *strcat(char *__s1, const char *__s2);
char *strchr(const char *__s, int __c);
int strcmp(const char *__s1, const char *__s2);
int strcoll(const char *__s1, const char *__s2);
char *strcpy(char *__dst, const char *__src);
size_t strcspn(const char *__s, const char *__charset);
char *strerror(int __errnum) __asm("_" "strerror" );
size_t strlen(const char *__s);
char *strncat(char *__s1, const char *__s2, size_t __n);
int strncmp(const char *__s1, const char *__s2, size_t __n);
char *strncpy(char *__dst, const char *__src, size_t __n);
char *strpbrk(const char *__s, const char *__charset);
char *strrchr(const char *__s, int __c);
size_t strspn(const char *__s, const char *__charset);
char *strstr(const char *__big, const char *__little);
char *strtok(char *__str, const char *__sep);
size_t strxfrm(char *__s1, const char *__s2, size_t __n);

# 103 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/string.h" 3 4

char *strtok_r(char *__str, const char *__sep, char **__lasts);

# 115 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/string.h" 3 4

int strerror_r(int __errnum, char *__strerrbuf, size_t __buflen);
char *strdup(const char *__s1);
void *memccpy(void *__dst, const void *__src, int __c, size_t __n);

# 129 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/string.h" 3 4

char *stpcpy(char *__dst, const char *__src);
char *stpncpy(char *__dst, const char *__src, size_t __n) __attribute__((unavailable));
char *strndup(const char *__s1, size_t __n) __attribute__((unavailable));
size_t strnlen(const char *__s1, size_t __n) __attribute__((unavailable));
char *strsignal(int __sig);

# 20 "scripts/mod/modpost.c" 2
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/limits.h" 1 3 4
# 34 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/limits.h" 3 4
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/syslimits.h" 1 3 4






# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/limits.h" 1 3 4
# 195 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/limits.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/limits.h" 1 3 4
# 64 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/limits.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/limits.h" 1 3 4





# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/limits.h" 1 3 4
# 40 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/limits.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_limits.h" 1 3 4
# 41 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/limits.h" 2 3 4
# 7 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/limits.h" 2 3 4
# 65 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/limits.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/syslimits.h" 1 3 4
# 66 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/limits.h" 2 3 4
# 196 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/limits.h" 2 3 4
# 8 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/syslimits.h" 2 3 4
# 35 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include-fixed/limits.h" 2 3 4
# 21 "scripts/mod/modpost.c" 2
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdbool.h" 1 3 4
# 22 "scripts/mod/modpost.c" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/errno.h" 1 3 4
# 23 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/errno.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/errno.h" 1 3 4
# 79 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/errno.h" 3 4

extern int * __error(void);


# 24 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/errno.h" 2 3 4
# 23 "scripts/mod/modpost.c" 2
# 1 "scripts/mod/modpost.h" 1



# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 1 3 4
# 66 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 1 3 4
# 79 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4
typedef enum {
 P_ALL,
 P_PID,
 P_PGID
} idtype_t;





# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_pid_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_pid_t.h" 3 4
typedef __darwin_pid_t pid_t;
# 90 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_id_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_id_t.h" 3 4
typedef __darwin_id_t id_t;
# 91 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 109 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 1 3 4
# 73 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/appleapiopts.h" 1 3 4
# 74 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 82 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/signal.h" 1 3 4
# 32 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/signal.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/signal.h" 1 3 4
# 39 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/signal.h" 3 4
typedef int sig_atomic_t;
# 33 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/signal.h" 2 3 4
# 83 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 146 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 1 3 4
# 29 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 1 3 4
# 34 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/machine/_structs.h" 1 3 4
# 33 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/machine/_structs.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 1 3 4
# 46 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_i386_thread_state
{
    unsigned int __eax;
    unsigned int __ebx;
    unsigned int __ecx;
    unsigned int __edx;
    unsigned int __edi;
    unsigned int __esi;
    unsigned int __ebp;
    unsigned int __esp;
    unsigned int __ss;
    unsigned int __eflags;
    unsigned int __eip;
    unsigned int __cs;
    unsigned int __ds;
    unsigned int __es;
    unsigned int __fs;
    unsigned int __gs;
};
# 92 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_fp_control
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
      :2,
    __pc :2,





    __rc :2,






             :1,
      :3;
};
typedef struct __darwin_fp_control __darwin_fp_control_t;
# 150 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_fp_status
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
    __stkflt :1,
    __errsumm :1,
    __c0 :1,
    __c1 :1,
    __c2 :1,
    __tos :3,
    __c3 :1,
    __busy :1;
};
typedef struct __darwin_fp_status __darwin_fp_status_t;
# 194 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_mmst_reg
{
 char __mmst_reg[10];
 char __mmst_rsrv[6];
};
# 213 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_xmm_reg
{
 char __xmm_reg[16];
};
# 229 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_ymm_reg
{
 char __ymm_reg[32];
};
# 245 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_zmm_reg
{
 char __zmm_reg[64];
};
# 259 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_opmask_reg
{
 char __opmask_reg[8];
};
# 281 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_i386_float_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
};


struct __darwin_i386_avx_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
};


struct __darwin_i386_avx512_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
};
# 575 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_i386_exception_state
{
 __uint16_t __trapno;
 __uint16_t __cpu;
 __uint32_t __err;
 __uint32_t __faultvaddr;
};
# 595 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_debug_state32
{
 unsigned int __dr0;
 unsigned int __dr1;
 unsigned int __dr2;
 unsigned int __dr3;
 unsigned int __dr4;
 unsigned int __dr5;
 unsigned int __dr6;
 unsigned int __dr7;
};
# 627 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_thread_state64
{
 __uint64_t __rax;
 __uint64_t __rbx;
 __uint64_t __rcx;
 __uint64_t __rdx;
 __uint64_t __rdi;
 __uint64_t __rsi;
 __uint64_t __rbp;
 __uint64_t __rsp;
 __uint64_t __r8;
 __uint64_t __r9;
 __uint64_t __r10;
 __uint64_t __r11;
 __uint64_t __r12;
 __uint64_t __r13;
 __uint64_t __r14;
 __uint64_t __r15;
 __uint64_t __rip;
 __uint64_t __rflags;
 __uint64_t __cs;
 __uint64_t __fs;
 __uint64_t __gs;
};
# 685 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_thread_full_state64
{
 struct __darwin_x86_thread_state64 ss64;
 __uint64_t __ds;
 __uint64_t __es;
 __uint64_t __ss;
};
# 706 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_float_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
};


struct __darwin_x86_avx_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
};


struct __darwin_x86_avx512_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
 struct __darwin_ymm_reg __fpu_zmmh8;
 struct __darwin_ymm_reg __fpu_zmmh9;
 struct __darwin_ymm_reg __fpu_zmmh10;
 struct __darwin_ymm_reg __fpu_zmmh11;
 struct __darwin_ymm_reg __fpu_zmmh12;
 struct __darwin_ymm_reg __fpu_zmmh13;
 struct __darwin_ymm_reg __fpu_zmmh14;
 struct __darwin_ymm_reg __fpu_zmmh15;
 struct __darwin_zmm_reg __fpu_zmm16;
 struct __darwin_zmm_reg __fpu_zmm17;
 struct __darwin_zmm_reg __fpu_zmm18;
 struct __darwin_zmm_reg __fpu_zmm19;
 struct __darwin_zmm_reg __fpu_zmm20;
 struct __darwin_zmm_reg __fpu_zmm21;
 struct __darwin_zmm_reg __fpu_zmm22;
 struct __darwin_zmm_reg __fpu_zmm23;
 struct __darwin_zmm_reg __fpu_zmm24;
 struct __darwin_zmm_reg __fpu_zmm25;
 struct __darwin_zmm_reg __fpu_zmm26;
 struct __darwin_zmm_reg __fpu_zmm27;
 struct __darwin_zmm_reg __fpu_zmm28;
 struct __darwin_zmm_reg __fpu_zmm29;
 struct __darwin_zmm_reg __fpu_zmm30;
 struct __darwin_zmm_reg __fpu_zmm31;
};
# 1164 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_exception_state64
{
    __uint16_t __trapno;
    __uint16_t __cpu;
    __uint32_t __err;
    __uint64_t __faultvaddr;
};
# 1184 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_debug_state64
{
 __uint64_t __dr0;
 __uint64_t __dr1;
 __uint64_t __dr2;
 __uint64_t __dr3;
 __uint64_t __dr4;
 __uint64_t __dr5;
 __uint64_t __dr6;
 __uint64_t __dr7;
};
# 1212 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_cpmu_state64
{
 __uint64_t __ctrs[16];
};
# 34 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/mach/machine/_structs.h" 2 3 4
# 35 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 2 3 4




struct __darwin_mcontext32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_float_state __fs;
};


struct __darwin_mcontext_avx32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx_state __fs;
};



struct __darwin_mcontext_avx512_32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx512_state __fs;
};
# 97 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 3 4
struct __darwin_mcontext64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_float_state64 __fs;
};


struct __darwin_mcontext_avx64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx_state64 __fs;
};



struct __darwin_mcontext_avx512_64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx512_state64 __fs;
};
# 156 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 3 4
typedef struct __darwin_mcontext64 *mcontext_t;
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 2 3 4
# 147 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_attr_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_attr_t.h" 3 4
typedef __darwin_pthread_attr_t pthread_attr_t;
# 149 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigaltstack.h" 1 3 4
# 42 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigaltstack.h" 3 4
struct __darwin_sigaltstack
{
 void *ss_sp;
 __darwin_size_t ss_size;
 int ss_flags;
};
typedef struct __darwin_sigaltstack stack_t;
# 151 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ucontext.h" 1 3 4
# 39 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ucontext.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 1 3 4
# 40 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ucontext.h" 2 3 4


struct __darwin_ucontext
{
 int uc_onstack;
 __darwin_sigset_t uc_sigmask;
 struct __darwin_sigaltstack uc_stack;
 struct __darwin_ucontext *uc_link;
 __darwin_size_t uc_mcsize;
 struct __darwin_mcontext64 *uc_mcontext;

 struct __darwin_mcontext64 __mcontext_data;

};


typedef struct __darwin_ucontext ucontext_t;
# 152 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4


# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigset_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigset_t.h" 3 4
typedef __darwin_sigset_t sigset_t;
# 155 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uid_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uid_t.h" 3 4
typedef __darwin_uid_t uid_t;
# 157 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

union sigval {

 int sival_int;
 void *sival_ptr;
};





struct sigevent {
 int sigev_notify;
 int sigev_signo;
 union sigval sigev_value;
 void (*sigev_notify_function)(union sigval);
 pthread_attr_t *sigev_notify_attributes;
};


typedef struct __siginfo {
 int si_signo;
 int si_errno;
 int si_code;
 pid_t si_pid;
 uid_t si_uid;
 int si_status;
 void *si_addr;
 union sigval si_value;
 long si_band;
 unsigned long __pad[7];
} siginfo_t;
# 269 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
union __sigaction_u {
 void (*__sa_handler)(int);
 void (*__sa_sigaction)(int, struct __siginfo *,
     void *);
};


struct __sigaction {
 union __sigaction_u __sigaction_u;
 void (*sa_tramp)(void *, int, int, siginfo_t *, void *);
 sigset_t sa_mask;
 int sa_flags;
};




struct sigaction {
 union __sigaction_u __sigaction_u;
 sigset_t sa_mask;
 int sa_flags;
};
# 367 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
struct sigstack {
 char *ss_sp;
 int ss_onstack;
};
# 389 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4

    void(*signal(int, void (*)(int)))(int);

# 110 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 1 3 4
# 80 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_timeval.h" 1 3 4
# 34 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_timeval.h" 3 4
struct timeval
{
 __darwin_time_t tv_sec;
 __darwin_suseconds_t tv_usec;
};
# 81 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 2 3 4
# 89 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
typedef __uint64_t rlim_t;
# 152 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
struct rusage {
 struct timeval ru_utime;
 struct timeval ru_stime;

 long ru_opaque[14];
# 180 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
};
# 366 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
struct rlimit {
 rlim_t rlim_cur;
 rlim_t rlim_max;
};
# 436 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4

int getpriority(int, id_t);



int getrlimit(int, struct rlimit *) __asm("_" "getrlimit" );
int getrusage(int, struct rusage *);
int setpriority(int, id_t, int);



int setrlimit(int, const struct rlimit *) __asm("_" "setrlimit" );

# 111 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 247 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4

pid_t wait(int *) __asm("_" "wait" );
pid_t waitpid(pid_t, int *, int) __asm("_" "waitpid" );

int waitid(idtype_t, id_t, siginfo_t *, int) __asm("_" "waitid" );






# 67 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4
# 81 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_wchar_t.h" 1 3 4
# 34 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_wchar_t.h" 3 4
typedef __darwin_wchar_t wchar_t;
# 82 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4

typedef struct {
 int quot;
 int rem;
} div_t;

typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef struct {
 long long quot;
 long long rem;
} lldiv_t;
# 118 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
extern int __mb_cur_max;
# 128 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/malloc/_malloc.h" 1 3 4
# 38 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/malloc/_malloc.h" 3 4


void *malloc(size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(1)));
void *calloc(size_t __count, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(1,2)));
void free(void *);
void *realloc(void *__ptr, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(2)));



int posix_memalign(void **__memptr, size_t __alignment, size_t __size) __attribute__((unavailable));


# 129 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4


void abort(void) __attribute__((noreturn));
int abs(int) __attribute__((const));
int atexit(void (* )(void));
double atof(const char *);
int atoi(const char *);
long atol(const char *);

long long
  atoll(const char *);

void *bsearch(const void *__key, const void *__base, size_t __nel,
     size_t __width, int (* __compar)(const void *, const void *));

div_t div(int, int) __attribute__((const));
void exit(int) __attribute__((noreturn));

char *getenv(const char *);
long labs(long) __attribute__((const));
ldiv_t ldiv(long, long) __attribute__((const));

long long
  llabs(long long);
lldiv_t lldiv(long long, long long);


int mblen(const char *__s, size_t __n);
size_t mbstowcs(wchar_t * restrict , const char * restrict, size_t);
int mbtowc(wchar_t * restrict, const char * restrict, size_t);

void qsort(void *__base, size_t __nel, size_t __width,
     int (* __compar)(const void *, const void *));
int rand(void) ;

void srand(unsigned) ;
double strtod(const char *, char **) __asm("_" "strtod" );
float strtof(const char *, char **) __asm("_" "strtof" );
long strtol(const char *__str, char **__endptr, int __base);
long double
  strtold(const char *, char **);

long long
  strtoll(const char *__str, char **__endptr, int __base);

unsigned long
  strtoul(const char *__str, char **__endptr, int __base);

unsigned long long
  strtoull(const char *__str, char **__endptr, int __base);
# 187 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4



int system(const char *) __asm("_" "system" );



size_t wcstombs(char * restrict, const wchar_t * restrict, size_t);
int wctomb(char *, wchar_t);


void _Exit(int) __attribute__((noreturn));
long a64l(const char *);
double drand48(void);
char *ecvt(double, int, int *restrict, int *restrict);
double erand48(unsigned short[3]);
char *fcvt(double, int, int *restrict, int *restrict);
char *gcvt(double, int, char *);
int getsubopt(char **, char * const *, char **);
int grantpt(int);

char *initstate(unsigned, char *, size_t);



long jrand48(unsigned short[3]) ;
char *l64a(long);
void lcong48(unsigned short[7]);
long lrand48(void) ;
char *mktemp(char *);
int mkstemp(char *);
long mrand48(void) ;
long nrand48(unsigned short[3]) ;
int posix_openpt(int);
char *ptsname(int);





int putenv(char *) __asm("_" "putenv" );
long random(void) ;
int rand_r(unsigned *) ;



char *realpath(const char * restrict, char * restrict) __asm("_" "realpath" );

unsigned short
 *seed48(unsigned short[3]);
int setenv(const char * __name, const char * __value, int __overwrite) __asm("_" "setenv" );

void setkey(const char *) __asm("_" "setkey" );



char *setstate(const char *);
void srand48(long);

void srandom(unsigned);



int unlockpt(int);

int unsetenv(const char *) __asm("_" "unsetenv" );
# 349 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4

# 5 "scripts/mod/modpost.h" 2
# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdarg.h" 1 3 4
# 99 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 6 "scripts/mod/modpost.h" 2

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 1 3 4
# 81 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/endian.h" 1 3 4
# 35 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/endian.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/i386/endian.h" 1 3 4
# 36 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/machine/endian.h" 2 3 4
# 82 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 95 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 3 4
typedef u_int64_t u_quad_t;
typedef int64_t quad_t;
typedef quad_t * qaddr_t;

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_caddr_t.h" 1 3 4
# 30 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_caddr_t.h" 3 4
typedef char * caddr_t;
# 100 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4

typedef int32_t daddr_t;

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_dev_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_dev_t.h" 3 4
typedef __darwin_dev_t dev_t;
# 104 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4

typedef u_int32_t fixpt_t;

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_blkcnt_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_blkcnt_t.h" 3 4
typedef __darwin_blkcnt_t blkcnt_t;
# 108 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_blksize_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_blksize_t.h" 3 4
typedef __darwin_blksize_t blksize_t;
# 109 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_gid_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_gid_t.h" 3 4
typedef __darwin_gid_t gid_t;
# 110 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_in_addr_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_in_addr_t.h" 3 4
typedef __uint32_t in_addr_t;
# 111 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_in_port_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_in_port_t.h" 3 4
typedef __uint16_t in_port_t;
# 112 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ino_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ino_t.h" 3 4
typedef __darwin_ino_t ino_t;
# 113 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4





# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_key_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_key_t.h" 3 4
typedef __int32_t key_t;
# 119 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_mode_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_mode_t.h" 3 4
typedef __darwin_mode_t mode_t;
# 120 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_nlink_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_nlink_t.h" 3 4
typedef __uint16_t nlink_t;
# 121 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4




typedef int32_t segsz_t;
typedef int32_t swblk_t;
# 165 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_clock_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_clock_t.h" 3 4
typedef __darwin_clock_t clock_t;
# 166 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4


# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_time_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_time_t.h" 3 4
typedef __darwin_time_t time_t;
# 169 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4

# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_useconds_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_useconds_t.h" 3 4
typedef __darwin_useconds_t useconds_t;
# 171 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_suseconds_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_suseconds_t.h" 3 4
typedef __darwin_suseconds_t suseconds_t;
# 172 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 216 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_cond_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_cond_t.h" 3 4
typedef __darwin_pthread_cond_t pthread_cond_t;
# 217 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_condattr_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_condattr_t.h" 3 4
typedef __darwin_pthread_condattr_t pthread_condattr_t;
# 218 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_mutex_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_mutex_t.h" 3 4
typedef __darwin_pthread_mutex_t pthread_mutex_t;
# 219 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_mutexattr_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_mutexattr_t.h" 3 4
typedef __darwin_pthread_mutexattr_t pthread_mutexattr_t;
# 220 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_once_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_once_t.h" 3 4
typedef __darwin_pthread_once_t pthread_once_t;
# 221 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_rwlock_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_rwlock_t.h" 3 4
typedef __darwin_pthread_rwlock_t pthread_rwlock_t;
# 222 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_rwlockattr_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_rwlockattr_t.h" 3 4
typedef __darwin_pthread_rwlockattr_t pthread_rwlockattr_t;
# 223 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_t.h" 3 4
typedef __darwin_pthread_t pthread_t;
# 224 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4



# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_key_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_key_t.h" 3 4
typedef __darwin_pthread_key_t pthread_key_t;
# 228 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4




# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_fsblkcnt_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_fsblkcnt_t.h" 3 4
typedef __darwin_fsblkcnt_t fsblkcnt_t;
# 233 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_fsfilcnt_t.h" 1 3 4
# 31 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_fsfilcnt_t.h" 3 4
typedef __darwin_fsfilcnt_t fsfilcnt_t;
# 234 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/types.h" 2 3 4
# 8 "scripts/mod/modpost.h" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 1 3 4
# 78 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_timespec.h" 1 3 4
# 33 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_timespec.h" 3 4
struct timespec
{
 __darwin_time_t tv_sec;
 long tv_nsec;
};
# 79 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 2 3 4
# 182 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 3 4
struct stat { dev_t st_dev; mode_t st_mode; nlink_t st_nlink; __darwin_ino64_t st_ino; uid_t st_uid; gid_t st_gid; dev_t st_rdev; time_t st_atime; long st_atimensec; time_t st_mtime; long st_mtimensec; time_t st_ctime; long st_ctimensec; time_t st_birthtime; long st_birthtimensec; off_t st_size; blkcnt_t st_blocks; blksize_t st_blksize; __uint32_t st_flags; __uint32_t st_gen; __int32_t st_lspare; __int64_t st_qspare[2]; };
# 241 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_s_ifmt.h" 1 3 4
# 242 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 2 3 4
# 353 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 3 4


int chmod(const char *, mode_t) __asm("_" "chmod" );
int fchmod(int, mode_t) __asm("_" "fchmod" );
int fstat(int, struct stat *) __asm("_" "fstat" "$INODE64");
int lstat(const char *, struct stat *) __asm("_" "lstat" "$INODE64");
int mkdir(const char *, mode_t);
int mkfifo(const char *, mode_t);
int stat(const char *, struct stat *) __asm("_" "stat" "$INODE64");
int mknod(const char *, mode_t, dev_t);
mode_t umask(mode_t);


int fchmodat(int, const char *, mode_t, int) __attribute__((unavailable));
int fstatat(int, const char *, struct stat *, int) __asm("_" "fstatat" "$INODE64") __attribute__((unavailable));
int mkdirat(int, const char *, mode_t) __attribute__((unavailable));




int futimens(int __fd, const struct timespec __times[2]) ;
int utimensat(int __fd, const char *__path, const struct timespec __times[2],
    int __flag) ;
# 406 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/stat.h" 3 4

# 9 "scripts/mod/modpost.h" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/mman.h" 1 3 4
# 212 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/mman.h" 3 4


int mlockall(int);
int munlockall(void);

int mlock(const void *, size_t);



void * mmap(void *, size_t, int, int, int, off_t) __asm("_" "mmap" );


int mprotect(void *, size_t, int) __asm("_" "mprotect" );

int msync(void *, size_t, int) __asm("_" "msync" );

int munlock(const void *, size_t);

int munmap(void *, size_t) __asm("_" "munmap" );

int shm_open(const char *, int, ...);
int shm_unlink(const char *);

int posix_madvise(void *, size_t, int);
# 244 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/mman.h" 3 4

# 10 "scripts/mod/modpost.h" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/fcntl.h" 1 3 4
# 23 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/fcntl.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 1 3 4
# 116 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_o_sync.h" 1 3 4
# 117 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 2 3 4
# 157 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_o_dsync.h" 1 3 4
# 158 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 2 3 4
# 310 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_seek_set.h" 1 3 4
# 311 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 2 3 4
# 335 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 3 4
struct flock {
 off_t l_start;
 off_t l_len;
 pid_t l_pid;
 short l_type;
 short l_whence;
};
# 513 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 3 4

int open(const char *, int, ...) __asm("_" "open" );

int openat(int, const char *, int, ...) __asm("_" "openat" ) __attribute__((unavailable));

int creat(const char *, mode_t) __asm("_" "creat" );
int fcntl(int, int, ...) __asm("_" "fcntl" );
# 539 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/fcntl.h" 3 4

# 24 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/fcntl.h" 2 3 4
# 11 "scripts/mod/modpost.h" 2
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 1 3 4
# 72 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/unistd.h" 1 3 4
# 84 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/unistd.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_posix_vdisable.h" 1 3 4
# 85 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/unistd.h" 2 3 4
# 122 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/unistd.h" 3 4
# 1 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_seek_set.h" 1 3 4
# 123 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/unistd.h" 2 3 4
# 205 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/unistd.h" 3 4


int faccessat(int, const char *, int, int) __attribute__((unavailable));
int fchownat(int, const char *, uid_t, gid_t, int) __attribute__((unavailable));
int linkat(int, const char *, int, const char *, int) __attribute__((unavailable));
ssize_t readlinkat(int, const char *, char *, size_t) __attribute__((unavailable));
int symlinkat(const char *, int, const char *) __attribute__((unavailable));
int unlinkat(int, const char *, int) __attribute__((unavailable));


# 73 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 2 3 4
# 428 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4

void _exit(int) __attribute__((noreturn));
int access(const char *, int);
unsigned int
  alarm(unsigned int);
int chdir(const char *);
int chown(const char *, uid_t, gid_t);

int close(int) __asm("_" "close" );

int dup(int);
int dup2(int, int);
int execl(const char * __path, const char * __arg0, ...) ;
int execle(const char * __path, const char * __arg0, ...) ;
int execlp(const char * __file, const char * __arg0, ...) ;
int execv(const char * __path, char * const * __argv) ;
int execve(const char * __file, char * const * __argv, char * const * __envp) ;
int execvp(const char * __file, char * const * __argv) ;
pid_t fork(void) ;
long fpathconf(int, int);
char *getcwd(char *, size_t);
gid_t getegid(void);
uid_t geteuid(void);
gid_t getgid(void);



int getgroups(int, gid_t []);

char *getlogin(void);
pid_t getpgrp(void);
pid_t getpid(void);
pid_t getppid(void);
uid_t getuid(void);
int isatty(int);
int link(const char *, const char *);
off_t lseek(int, off_t, int);
long pathconf(const char *, int);

int pause(void) __asm("_" "pause" );

int pipe(int [2]);

ssize_t read(int, void *, size_t) __asm("_" "read" );

int rmdir(const char *);
int setgid(gid_t);
int setpgid(pid_t, pid_t);
pid_t setsid(void);
int setuid(uid_t);

unsigned int
  sleep(unsigned int) __asm("_" "sleep" );

long sysconf(int);
pid_t tcgetpgrp(int);
int tcsetpgrp(int, pid_t);
char *ttyname(int);


int ttyname_r(int, char *, size_t) __asm("_" "ttyname_r" );




int unlink(const char *);

ssize_t write(int __fd, const void * __buf, size_t __nbyte) __asm("_" "write" );

# 505 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4

size_t confstr(int, char *, size_t) __asm("_" "confstr" );

int getopt(int, char * const [], const char *) __asm("_" "getopt" );

extern char *optarg;
extern int optind, opterr, optopt;

# 530 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4

# 542 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4
char *crypt(const char *, const char *);






void encrypt(char *, int) __asm("_" "encrypt" );



int fchdir(int);
long gethostid(void);
pid_t getpgid(pid_t);
pid_t getsid(pid_t);
# 570 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4
int lchown(const char *, uid_t, gid_t) __asm("_" "lchown" );

int lockf(int, int, off_t) __asm("_" "lockf" );

int nice(int) __asm("_" "nice" );

ssize_t pread(int __fd, void * __buf, size_t __nbyte, off_t __offset) __asm("_" "pread" );

ssize_t pwrite(int __fd, const void * __buf, size_t __nbyte, off_t __offset) __asm("_" "pwrite" );
# 591 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4
pid_t setpgrp(void) __asm("_" "setpgrp" );




int setregid(gid_t, gid_t) __asm("_" "setregid" );

int setreuid(uid_t, uid_t) __asm("_" "setreuid" );

void swab(const void * restrict, void * restrict, ssize_t);
void sync(void);
int truncate(const char *, off_t);
useconds_t ualarm(useconds_t, useconds_t);
int usleep(useconds_t) __asm("_" "usleep" );
pid_t vfork(void) ;


int fsync(int) __asm("_" "fsync" );

int ftruncate(int, off_t);
int getlogin_r(char *, size_t);

# 623 "/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/unistd.h" 3 4

int fchown(int, uid_t, gid_t);
int gethostname(char *, size_t);
ssize_t readlink(const char * restrict, char * restrict, size_t);
int setegid(gid_t);
int seteuid(uid_t);
int symlink(const char *, const char *);

# 12 "scripts/mod/modpost.h" 2


# 1 "scripts/mod/list.h" 1





# 1 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stddef.h" 1 3 4
# 143 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stddef.h" 3 4
typedef long int ptrdiff_t;
# 415 "/opt/local/lib/gcc10/gcc/x86_64-apple-darwin18/10.4.0/include/stddef.h" 3 4
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));







} max_align_t;
# 7 "scripts/mod/list.h" 2
# 38 "scripts/mod/list.h"

# 38 "scripts/mod/list.h"
struct list_head {
 struct list_head *next, *prev;
};
# 54 "scripts/mod/list.h"
static inline void INIT_LIST_HEAD(struct list_head *list)
{
 list->next = list;
 list->prev = list;
}







static inline void __list_add(struct list_head *new,
         struct list_head *prev,
         struct list_head *next)
{
 next->prev = new;
 new->next = next;
 new->prev = prev;
 prev->next = new;
}
# 84 "scripts/mod/list.h"
static inline void list_add(struct list_head *new, struct list_head *head)
{
 __list_add(new, head, head->next);
}
# 97 "scripts/mod/list.h"
static inline void list_add_tail(struct list_head *new, struct list_head *head)
{
 __list_add(new, head->prev, head);
}
# 109 "scripts/mod/list.h"
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
 next->prev = prev;
 prev->next = next;
}

static inline void __list_del_entry(struct list_head *entry)
{
 __list_del(entry->prev, entry->next);
}







static inline void list_del(struct list_head *entry)
{
 __list_del_entry(entry);
 entry->next = ((void *) 0x100);
 entry->prev = ((void *) 0x122);
}






static inline int list_is_head(const struct list_head *list, const struct list_head *head)
{
 return list == head;
}





static inline int list_empty(const struct list_head *head)
{
 return head->next == head;
}
# 15 "scripts/mod/modpost.h" 2
# 1 "scripts/mod/elfconfig.h" 1
# 16 "scripts/mod/modpost.h" 2
# 54 "scripts/mod/modpost.h"
typedef struct
{
 Elf32_Word r_sym;
 unsigned char r_ssym;
 unsigned char r_type3;
 unsigned char r_type2;
 unsigned char r_type1;
} _Elf64_Mips_R_Info;

typedef union
{
 Elf64_Xword r_info_number;
 _Elf64_Mips_R_Info r_info_fields;
} _Elf64_Mips_R_Info_union;
# 101 "scripts/mod/modpost.h"
void *do_nofail(void *ptr, const char *expr);

struct buffer {
 char *p;
 int pos;
 int size;
};

void __attribute__((format(printf, 2, 3)))
buf_printf(struct buffer *buf, const char *fmt, ...);

void
buf_write(struct buffer *buf, const char *s, int len);

struct module {
 struct list_head list;
 struct list_head exported_symbols;
 struct list_head unresolved_symbols;
 
# 119 "scripts/mod/modpost.h" 3 4
_Bool 
# 119 "scripts/mod/modpost.h"
     is_gpl_compatible;
 
# 120 "scripts/mod/modpost.h" 3 4
_Bool 
# 120 "scripts/mod/modpost.h"
     from_dump;
 
# 121 "scripts/mod/modpost.h" 3 4
_Bool 
# 121 "scripts/mod/modpost.h"
     is_vmlinux;
 
# 122 "scripts/mod/modpost.h" 3 4
_Bool 
# 122 "scripts/mod/modpost.h"
     seen;
 
# 123 "scripts/mod/modpost.h" 3 4
_Bool 
# 123 "scripts/mod/modpost.h"
     has_init;
 
# 124 "scripts/mod/modpost.h" 3 4
_Bool 
# 124 "scripts/mod/modpost.h"
     has_cleanup;
 struct buffer dev_table_buf;
 char srcversion[25];

 struct list_head missing_namespaces;

 struct list_head imported_namespaces;
 char name[];
};

struct elf_info {
 size_t size;
 Elf32_Ehdr *hdr;
 Elf32_Shdr *sechdrs;
 Elf32_Sym *symtab_start;
 Elf32_Sym *symtab_stop;
 char *strtab;
 char *modinfo;
 unsigned int modinfo_len;



 unsigned int num_sections;
 unsigned int secindex_strings;


 Elf32_Word *symtab_shndx_start;
 Elf32_Word *symtab_shndx_stop;
};

static inline int is_shndx_special(unsigned int i)
{
 return i != 0xffff && i >= 0xff00 && i <= 0xffff;
}


static inline unsigned int get_secindex(const struct elf_info *info,
     const Elf32_Sym *sym)
{
 unsigned int index = sym->st_shndx;





 if (index == 0xffff)
  return info->symtab_shndx_start[sym - info->symtab_start];






 if (index >= 0xff00 && index <= 0xffff)
  return index - 0xffff - 1;

 return index;
}


void handle_moddevtable(struct module *mod, struct elf_info *info,
   Elf32_Sym *sym, const char *symname);
void add_moddevtable(struct buffer *buf, struct module *mod);


void get_src_version(const char *modname, char sum[], unsigned sumlen);


char *read_text_file(const char *filename);
char *get_line(char **stringp);
void *sym_get_data(const struct elf_info *info, const Elf32_Sym *sym);

enum loglevel {
 LOG_WARN,
 LOG_ERROR,
 LOG_FATAL
};

void modpost_log(enum loglevel loglevel, const char *fmt, ...);
# 24 "scripts/mod/modpost.c" 2
# 1 "scripts/mod/../../include/linux/license.h" 1




# 1 "include/linux/string.h" 1 3 4




# 1 "include/linux/compiler.h" 1 3 4




# 1 "include/linux/compiler_types.h" 1 3 4
# 6 "include/linux/compiler.h" 2 3 4
# 224 "include/linux/compiler.h" 3 4

# 224 "include/linux/compiler.h" 3 4
static inline void *offset_to_ptr(const int *off)
{
 return (void *)((unsigned long)off + *off);
}
--Apple-Mail=_A761AAEC-EE46-45A3-8631-8C49F2CD0DC3--
