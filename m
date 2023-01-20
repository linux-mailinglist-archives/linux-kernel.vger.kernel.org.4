Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5343D675E17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjATT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjATT3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:29:45 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BAB40CB;
        Fri, 20 Jan 2023 11:29:44 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1pIx54-002uuw-Fd; Fri, 20 Jan 2023 20:29:42 +0100
Received: from pd9f631ca.dip0.t-ipconnect.de ([217.246.49.202] helo=[192.168.144.87])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1pIx54-002Kos-8o; Fri, 20 Jan 2023 20:29:42 +0100
Content-Type: multipart/mixed; boundary="------------noR0LwKfcoz0L7zbRzJSPHS4"
Message-ID: <def16c9b-7bb1-a454-0896-b063a9e85964@fu-berlin.de>
Date:   Fri, 20 Jan 2023 20:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Calculating array sizes in C - was: Re: Build
 regressions/improvements in v6.2-rc1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
 <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
 <CAMuHMdWbBRkhecrqcir92TgZnffMe8ku2t7PcVLqA6e6F-j=iw@mail.gmail.com>
 <429140e0-72fe-c91c-53bc-124d33ab5ffa@physik.fu-berlin.de>
 <CAMuHMdWpHSsAB3WosyCVgS6+t4pU35Xfj3tjmdCDoyS2QkS7iw@mail.gmail.com>
 <0d238f02-4d78-6f14-1b1b-f53f0317a910@physik.fu-berlin.de>
 <1732342f-49fe-c20e-b877-bc0a340e1a50@fu-berlin.de>
 <c1d233b9-bc85-dce9-ffa0-eb3170602c6c@physik.fu-berlin.de>
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <c1d233b9-bc85-dce9-ffa0-eb3170602c6c@physik.fu-berlin.de>
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-Originating-IP: 217.246.49.202
X-ZEDAT-Hint: A
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------noR0LwKfcoz0L7zbRzJSPHS4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Adrian,
> Could you post a kernel patch for that? I would be happy to test it on my
> SH-7785CLR board. Also, I'm going to file a bug report against GCC.

I filed the bug already. It's 
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483.

The diff is attached. It's published as CC0 in case anyone considers 
this trivial change copyrightable. This patch prevents this one specific 
warning from being upgraded to "error" even if you configure the kernel 
to use "-Werror". It still keeps it active as warning, though.

Kind regards,
   Michael Karcher

--------------noR0LwKfcoz0L7zbRzJSPHS4
Content-Type: text/plain; charset=UTF-8; name="werror.diff"
Content-Disposition: attachment; filename="werror.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggZTA5ZmUxMDBlZmIyLi5i
NGNkMDc1YzZhMTkgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC04
NzAsNyArODcwLDcgQEAgc3RhY2twLWZsYWdzLSQoQ09ORklHX1NUQUNLUFJPVEVDVE9SX1NU
Uk9ORykgICAgICA6PSAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcKIAogS0JVSUxEX0NGTEFH
UyArPSAkKHN0YWNrcC1mbGFncy15KQogCi1LQlVJTERfQ1BQRkxBR1MtJChDT05GSUdfV0VS
Uk9SKSArPSAtV2Vycm9yCitLQlVJTERfQ1BQRkxBR1MtJChDT05GSUdfV0VSUk9SKSArPSAt
V2Vycm9yIC1Xbm8tZXJyb3I9c2l6ZW9mLXBvaW50ZXItZGl2CiBLQlVJTERfQ1BQRkxBR1Mg
Kz0gJChLQlVJTERfQ1BQRkxBR1MteSkKIEtCVUlMRF9DRkxBR1MtJChDT05GSUdfQ0NfTk9f
QVJSQVlfQk9VTkRTKSArPSAtV25vLWFycmF5LWJvdW5kcwogCg==

--------------noR0LwKfcoz0L7zbRzJSPHS4--
