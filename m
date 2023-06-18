Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4227344F5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjFRFQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFRFQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:16:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A5FE49;
        Sat, 17 Jun 2023 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687065362; x=1687670162; i=deller@gmx.de;
 bh=EUaQIqD/ZsW66UMROAlu4iCbxsjI+oeUTCmLgbKJ/4g=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=SHPJMH7tnBwIf4Bt7I1opP5D3dQJQjD07wM03mpq+0tXA8pMRcX2dIUY050piuW+Kjx5mQK
 pViVWlMSHu1BGsLjaeGIlkiAuk6Yjh/T1faaxfz0fC8H+WRBISuIsT5BSgJBbIGyVEB0hNF/j
 Gr2MEhl0GAZrGE+2Cur7cqM+EyRVavov4Fd5KGbMas2VOFL9elBgPvTopxM/1FyRdxFTZScTu
 s6a1TMoGKjDLeB3ANdpzu5+B/rCposqOzHh0j21rCkfO3iopjzc+YUkZNkE/0q+OHxqGv2Ol9
 dRkAPtavYui6Nkf/m/DOtov4DHUhTYPFl7K95CElSQkfibVIunNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.148.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1pnXVO0u7Y-00nhW5; Sun, 18
 Jun 2023 07:16:02 +0200
Date:   Sun, 18 Jun 2023 07:16:00 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Ben Hutchings <benh@debian.org>
Subject: [GIT PULL] parisc architecture fix for v6.4-rc7
Message-ID: <ZI6TEDXhJKW3l3XF@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:TdNWjSBn5PpPAdht8GFwkkEPO6SEFbE+bQm0ulkmMLPtB5nIlbT
 kZaSqsxQSk7H13sjxncc3qUfcI+M6Tv8wGKunZ0+nOf/ysUfsbjg+NHsDBFlDGOtPn/ZS63
 6iBMcd7FHq0F+bVK28VD8ykhpOwhAdkw6D85jjQ1bvbinxzrbXuYNQFiBkFeNXZNoBt6UJm
 +hReJiUtwuPtf+oko7J4w==
UI-OutboundReport: notjunk:1;M01:P0:VsjydBoPoyY=;G1ArkVU6Ab4XJ9SGWJk5ATXU0yV
 bUQrehVA8jd5u+P5k94XS5HbGpryBP1M8jbbtIpawk9Xxz84s7oW5asNlWAfxf80SNyM1unGl
 /v5S6MwDxGtLFyPCzNhE7+GFxwX0XHdrOH4U50wPHDWM1mVRDhXSxt74wNGc2ZoaGrFNTiziA
 fVZLbl76b1kvTot1ljD4CMVlHMOhuNTB1QSzAT+w6YI8XP0CiZgS75bDLFrhKcpM2xTCT0TSy
 ndrunTSXnhQ5MUXKHYRozx1TzOUF/0Xj1NFGxBXV497gqn5WSygzS0cZfJNMIY4pgqNHdo9D/
 Hr1LmqsN/HqWLNJ4qH5vjwjzSwaE3afcQRaCVuAPwK0wwyKQpwwb61jHQL8IsIvVB38gQiBHN
 1EDUWkGP1uKZvl5VfH77kFl+dgefZTAibdc5v1cU1I3+G/3fBSbtPj7on8zg8VRs5V9+rXeYy
 2N/kKn9Fgpsd/ZcB/S+4EzBS7E1Du6VSixqzIguMUEOyOb/PTO08q1+txTh0YShOB8wuZQURK
 mgRYpJGoJVa+4Za85OkzDE4+uuJUtr3YpR+Fqn2/zF2s5XEr2DEOONGiELt2+9KsxroKz7nQI
 C2Quz5EqokZ7b7+9MvbUxktjiNSjTXMQXmaM0vdFVwAindPz2C5nKm6rBZXQWUy+wTIHTM0Ty
 Kt5WQgnuV1yYjWnKACYfmE9R9ToXoaccuzU0RfXXHcGqkkb0C/14Uea6Z9Cj0g/ZfxoLBl1i/
 G2fln+mm7a+sddYgxh60/Elxxa1d9eOwiRSqXlA7NSuje+6SyqJP272K05HeTst/Vi7ZTCUv1
 t2o8mkXErlg+eUey/MIgu8aF2nhkuErPyOZbH1qIQaTP4yvCz4Na/lTYfV1frFOc4gqmhMqCu
 1eQ/zDfW/ND41u4poboQqEmQU1aW77EUDN3UCVXLEIHvmxNl28v7A/9QaGYTH4EIBDWCm131g
 BMUB5oYCUoCtE5gRWj1ugdLGcYo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

please pull one small patch for parisc. It fixes a build error
with the latest binutils.

Thanks,
Helge

---


The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.4-4

for you to fetch changes up to b5b2a02bcaac7c287694aa0db4837a07bf178626:

  parisc: Delete redundant register definitions in <asm/assembly.h> (2023-06-17 06:48:11 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.4-rc7:

- Drop redundant register definitions to fix build with latest binutils

----------------------------------------------------------------
Ben Hutchings (1):
      parisc: Delete redundant register definitions in <asm/assembly.h>

 arch/parisc/include/asm/assembly.h | 4 ----
 1 file changed, 4 deletions(-)
