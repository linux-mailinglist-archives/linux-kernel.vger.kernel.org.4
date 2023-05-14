Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71AD701E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjENQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjENQwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:52:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493F271E;
        Sun, 14 May 2023 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684083115; i=deller@gmx.de;
        bh=NYdzANhdv5BBLf5RtYD2CTwHtFaSt5mvBTNZdOOnbHo=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=GZqehjTMlgIxEy3T0CfeA/4tRDk2YpnrEiEwU1mXQov8ZtUN/LBgSQUQqs/lJoEKk
         Wo8RkXItba1glhe+KhF7i+FfEPXgkUsra+p4AN8wepoX9jLyD8/vsT4Nbew7J+kCw3
         P+sbkE4u3CxHSWXPdz1Zb4K4U4JhEyy7tWfuZmyF29zq6V1C7J2euCRNOqTxJaDeJt
         /ygKwe3ifhYQjKDFqVt/VgruMapN4dbVCnPlscU1NOxaHzDCWC7SLORfoVpYrpjCoy
         BMnD+yaWRcQ+4TDzSf/HHfoX6LjnvB76+hTe8LhWE8ebJEZqrSA7UvbDZTD6GIZ2wv
         KNVKpbs42b5EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.155.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1pfMe73Xnp-00YR92; Sun, 14
 May 2023 18:51:54 +0200
Date:   Sun, 14 May 2023 18:51:52 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.4-rc2
Message-ID: <ZGERqF1P4VlazwPG@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:GQWN2sGTb1ChSM2ogQQMsGLBY9jvky5S/AY/9dz8B4hADEWwjRE
 G5JiGPv9tyMVaEHXbyNoTqLX0YwHzm55w23lPvkcEJIm5ANrd3uczmnH4sYywatd6aUXsjg
 3ua3nRy8GDCAhFprO+IOz7kWFPefUTDhkM8vo+r7i3t6SqHbp5iM/0BXMBZHMMHL0x17Dih
 1YEopunguCvo1Wa00etVQ==
UI-OutboundReport: notjunk:1;M01:P0:lb8dOl++ufk=;x6FFGw4a8xWUqosE7dR+hZTkiwb
 Y5hQGM5rFOv54mUHM0AtRTuMFPgNDjZRtU2UOHl5K1xRl7tf5ZvHvdMkvf6virqJcIA+7a0iD
 LKwo5vH9Qmk6/yEQojrcBmUs3IVWbXGoR7MDJZ8p4TMllHF6yDMSyyQZmN084gIjn8tB1Cgp4
 U+OGgBXcqabPXydQyKgVp++wTtlTLQKzxlelhmxC0Z8CiOBbekV1aqEMGCBWPQDcTPKlk9vOw
 DVDUFiKQOttwnmZkMz20NLuPtYoxPE3TXaoDAp9F+InNfxqm9ogxW10oV2O4xQcqY854SswbI
 pSXTpp2Oq9wXfMbSEotTDyKS3jIXQOvl/27Y+Ed55KE5l7zJm6yTh8ONtDT4hY1rbQHy1zxhd
 UURqp5M87s6AdrQ/gmVUqIPAV5JKoj1UbjzxvkOETDIr+zDYGvjcZsEcyOAvHk3eY32aCQRBA
 dJY8jnYey7zX/pKSkv8FF2b8e9AtrpPccyNWbeelFRTEJNQw369qi4WrfVzsiz4dMd1fj91VT
 8s44WdFArk/dwIdTayMVTa35FXQpxZLpkBRZOJmL3Atob5fhFc+N0rY8qc167dfweKXuWLOE1
 lRpEIyejOhIwjEwdVffkuVS74kvfF1rSh8UAiHX9YmdNVn3svi507Oros33k8+bXAVfrUIJxO
 uLpH/4Wx0Zcia2q0HkQLHkkO16DLLIMMcKPeJ3xTHVn3MfAKOvyguEUjMf0gmPH+vHOAwni/Y
 LTp1TZ9zCiIQwBZ6TErPEi0VvwiAHpqAobBwFZ1a3/xAZJYCGUAoNh2hhu2EOzb6N72Uuhaih
 rcvu/wNeudlwO3msbZp85hE4zxiIBMespOHoNGHh5WYncjHPFQVg2G8v6CsWzEqrhjNGvW5x+
 oNPXQA7/R25FEyIvq4y9/ulI+vFeyNDd50uTT0SLl3PAbxo7OJT3u8il7YvfBF4OJudb4rNmw
 GEEzwg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two small fixes for the parisc architecture for 6.4-rc2.

Fix the swap entry encoding calculation (tagged for backport) and avoid a
gcc-12 warning.

Thanks,
Helge

=2D--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1=
b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git ta=
gs/parisc-for-6.4-2

for you to fetch changes up to 6f9e98849edaa8aefc4030ff3500e41556e83ff7:

  parisc: Fix encoding of swp_entry due to added SWP_EXCLUSIVE flag (2023-=
05-14 02:04:27 +0200)

=2D---------------------------------------------------------------
parisc architecture fixes for kernel v6.4-rc2:

- Fix encoding of swp_entry due to added SWP_EXCLUSIVE flag
- Include reboot.h to avoid gcc-12 compiler warning

=2D---------------------------------------------------------------
Helge Deller (1):
      parisc: Fix encoding of swp_entry due to added SWP_EXCLUSIVE flag

Simon Horman (1):
      parisc: kexec: include reboot.h

 arch/parisc/include/asm/pgtable.h | 8 ++++----
 arch/parisc/kernel/kexec.c        | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)
