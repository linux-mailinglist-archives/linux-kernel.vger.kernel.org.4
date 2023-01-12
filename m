Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5BC667D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbjALSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbjALSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:03:49 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E26355
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:30:39 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k19so14283934pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKn6Hym6ajlamMZoC5DCVSihseHTfaqq3TeymZ2bdUk=;
        b=JKj410/Yj07UpbYbqsXy+92eveA7zkq3Ogzh3Qjymz9rfSM3e1nh2TW3cIqOXXmCM5
         UrWZ8eaTNxjfBZVW3IygWEervt5LdJjz2SpwG5d7x9Huf4z61KwSrKq7vfxwhashz9xF
         zi5Km8wpGmK3ajU6INgxlBZQ7JpJWJWj0Hv+5E1FV2L/YM0+xmsHA2B84UAMPmgaANmf
         klBvlNObWCK3kCO5p+UECZks6X37jpkUw8WpiU1wzVzJ6pNgNMtyPECSaDiY97fZL16R
         qbjbnMqXU7Yy2Omd09/6H9hl6b8UcxO/EBalkKx3LhpSSvc+n9juGgXoIE7dbnv5uZb8
         yxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKn6Hym6ajlamMZoC5DCVSihseHTfaqq3TeymZ2bdUk=;
        b=gqv1EhfINnbG3sw1UqS4HFSTbtQAptS6ZddQRZPgPklqwOjG0gDvw5DJBmzK8lKB0B
         SSBCq+hhnE3/JKYW6Zz+mVJ4uJsJsTBMoldQA+CWojCW6kEGr0ia36JezKjz7y+8kyQT
         XTpnXpz6xyelBZJFBGEhNciGwrTVEwaGG4wNbWLi8CKtLK0cZCIoUXLXtlfMb57GJhYL
         MiVXB7QCoaOHH96Itf/WsbmX16S5cyIT4OHSh54cqWYGnOUIzcot1VLBZubF0qQrkkAy
         DV46kfEc0WBn/iN1QcD3DaZZZOq325p4sPg4aBgxa38r9WzYRC0jNkKsDeKPZ9pKqb0q
         5h3Q==
X-Gm-Message-State: AFqh2krsXrWLV5X0O+HJop6pCa2ynA0VdQUZ4o4ASygKcDYAWA1b1jcf
        3CMP60HMzIniUbAkP5dYHAsb/XBdKO4=
X-Google-Smtp-Source: AMrXdXvqm9w9wTpwBU7i1Me5JtJhlEmiN/4YyhJHVDWg0coT8iJudXnO6yhpUP7k/anbcQ3zDH5a4A==
X-Received: by 2002:a62:1d96:0:b0:575:e8c5:eb14 with SMTP id d144-20020a621d96000000b00575e8c5eb14mr73004315pfd.18.1673544638878;
        Thu, 12 Jan 2023 09:30:38 -0800 (PST)
Received: from thinkstation.cmpxchg8b.net ([76.133.164.192])
        by smtp.gmail.com with ESMTPSA id b2-20020a62a102000000b00580f630a05csm3465337pff.180.2023.01.12.09.30.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 09:30:38 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:30:37 -0800
From:   Tavis Ormandy <taviso@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: x86: XSAVE flags mystery
Message-ID: <Y8BDveL74VlBFZpw@thinkstation.cmpxchg8b.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r52J3DLmI/JDCVDs"
Content-Disposition: inline
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r52J3DLmI/JDCVDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, I have a mystery and wonder if it might be a kernel bug.

I've been trying to track down why the tests in a checkpointing library
were flakey. It turns out the xstate_bv flag appears to change
non-deterministically when using AVX instructions... but why is that?

Is this a bug? Is there some state being leaked across a context switch?

Here is a reproducer:

https://godbolt.org/z/h8nY4d6c4

I would expect this to infinite loop, but if you click recompile (the
circle arrow icon at the bottom), notice the number of tests change and
it does exit the loop.

I've also attached it for reference, please compile it with gcc -mavx.

I don't know, any ideas?

Tavis.

-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso

--r52J3DLmI/JDCVDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="xsave.c"

#include <stdint.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdbool.h>
#include <x86intrin.h>
#include <immintrin.h>

#if !defined(__AVX__)
# error You must compile this with -mavx to get the needed intrinsics
#endif

struct i387_fxsave_struct {
        uint16_t cwd; /* Control Word                    */
        uint16_t swd; /* Status Word                     */
        uint16_t twd; /* Tag Word                        */
        uint16_t fop; /* Last Instruction Opcode         */
        union {
            struct {
                uint64_t rip; /* Instruction Pointer             */
                uint64_t rdp; /* Data Pointer                    */
            };
            struct {
                uint32_t fip; /* FPU IP Offset                   */
                uint32_t fcs; /* FPU IP Selector                 */
                uint32_t foo; /* FPU Operand Offset              */
                uint32_t fos; /* FPU Operand Selector            */
            };
        };
        uint32_t mxcsr;          /* MXCSR Register State */
        uint32_t mxcsr_mask;     /* MXCSR Mask           */
        uint32_t st_space[32];
        uint32_t xmm_space[64];
        uint32_t padding[12];
        union {
            uint32_t padding1[12];
            uint32_t sw_reserved[12];
        };
} __attribute__((aligned(16)));

struct ymmh_struct {
        uint32_t ymmh_space[64];
};

struct xsave_hdr_struct {
        uint64_t xstate_bv;
        uint64_t reserved1[2];
        uint64_t reserved2[5];
} __attribute__((packed));

struct xsave_struct {
        struct i387_fxsave_struct i387;
        struct xsave_hdr_struct xsave_hdr;
        struct ymmh_struct ymmh;
} __attribute__ ((packed, aligned (64)));


int main(int argc, char **argv)
{
    uint64_t count;
    static struct xsave_struct initial = {0};
    static struct xsave_struct xsave = {0};
    register __m128 a = _mm_setzero_ps();
    register __m128 b = _mm_setzero_ps();
    register __m128 c = _mm_set1_ps(2);

    // VSQRTSS followed by VZEROALL makes XSAVE non-deterministic.
    // Is this a bug?
    // Note: serializing doesn't seem to make a difference

    // Do a test execution just to record our XINUSE flags.
    asm volatile ("vsqrtss %0, %1, %2" : "=v"(c) : "v"(b), "v"(a));

    // Reset everything
    _mm256_zeroall();

    // Now fetch our XINUSE bitmap.
    _xsave(&initial, 0b11);

    fprintf(stderr, "first execution, our flags: %010lX\n",
                    initial.xsave_hdr.xstate_bv);

    for (count = 0;; count++) {
        asm volatile ("vsqrtss %0, %1, %2" : "=v"(c) : "v"(b), "v"(a));
        _mm256_zeroall();
        _xsave(&xsave, 0b11);

        if (xsave.xsave_hdr.xstate_bv != initial.xsave_hdr.xstate_bv) {
            fprintf(stderr, "After %lu tests, our XINUSE was %010lx vs %010lx\n",
                            count,
                            xsave.xsave_hdr.xstate_bv,
                            initial.xsave_hdr.xstate_bv);
            break;
        }
    }

    return 0;
}

--r52J3DLmI/JDCVDs--
