Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FF68AA9D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBDOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBDOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:40:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13B3345B;
        Sat,  4 Feb 2023 06:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675521648; bh=rKbHQ0P4cuSawW92l/bRnetIeGiXdJyjrDoEndx0j3U=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=iBUmbxNYfJ1CeDFsFCl84LiPU5dCD+wkbmsOTHk9t/XMwmPVbFsIi83QxdaDj4bK1
         UARPV9OCAlm6bfTizAT83xfZ4LKAPJwD2f/Gdj055+JPryElDW/2g6gHe76e8VDOV2
         XmIqq5XGGiVnDEizchyanPJAp8lBZkbp93qVzAH3QmR6Eprbi6k5UUs+J5sYu14x4A
         fqQWHRJHm3JBUfZW4uVC8ZLXWQk6kDz1Mr7NBuQ0w6uzAt5bW2E4+uQa0DK27PpxyF
         mHY0+H21JqSA34JhuQqmY3v/s8tgNh44uUWphLKr1YkHRU7ZJs6F6dYFC0BkZPwR3P
         hTs0C+9bs3yYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([92.116.151.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1pGLVA46k3-008cBt; Sat, 04
 Feb 2023 15:40:48 +0100
Date:   Sat, 4 Feb 2023 15:40:45 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.2-rc7
Message-ID: <Y95ubeJ0b96rw/rS@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:YYKsCD0udyd4IIb6VdJsl9J3YDC+zppquHu9Eyobt8BtHbj1Wh2
 murd3vSgmBd4MCysjyEqG3+SwRkCIvlXtN5Q0t1jxygKud9slyR1BklpABMtkBrVlKNHBDD
 +KJ0SRXirGX6Jm+GcFlYd/N+EiXeWEUGuOIslzbigczGgJvSkq0xkqTEj137gNpaIZe/0LW
 Q0+lcc7ejwhNfXKMN8Hlg==
UI-OutboundReport: notjunk:1;M01:P0:0doOVu1q20Y=;lB8riK390tF36iYDG6dN+g8o6Zy
 1fm8zQhVLay07RZFzEVYlP2Rsdkf9SSXqpxsJacAUl+Hdc2uSr+69OS8O+Wvp7vEVPkqFnNE7
 GtFL3I6UGEesW2cMTijWB01PNgWxSRtAmMq6fCBNouWBWyVZRgISu8e4efj+VQDY1FnBa0rU/
 4PMTMvsAq/auDelr9aEPKYxiG38Ro8/PGGZlvhgDZTACRx8CN2/sc2MPOe3ggSb4hTaChIuSH
 m3QJov0v40AdiXxc3X6H2h05Y2UYIkXFnCZwED/18dcZnDO6f9Wszbo3EIEKmRkVay913ELMs
 wyRCjucIKyTkqcxeNjjX1HYPtw5AmFicLIaTo/UC14Ub+5+YktRoxETO3RmL7V9k7pLzcGHV9
 GBDX2dwvUQW7e84QcB3dy5SinwFftuRegkmNL55ZG1LFXCTjtn3qo9GAWmsfjzyYUfCGN3E3x
 XtrH7v4MeZetJepPXuyFAn+wCSkQTfF6mc9HFuolywFPlWjPKwwKzhvOmY8afDXIAIORWpeOI
 wN/0KDOUYHgU6CTJrTRZjjDln0EqRIWn4ns2T1o4ud/gsAqScpNNqlheT9XRsR+WZpm79ffHY
 QGcO43CTaA6xUrJnYV4nkxzsZ11trQk/9u8KDDZvn8vzWCv1m+JP2Cdsfzqu2IYmo3zcJOlom
 y98sHaCTIK0M3PXVQYMyB1XaOEo/Ucs9exSUcPATweKUAD8QBx16bBoDqMy5rGj8eyZO5m46q
 aN0U/iZb3XhW2I1emc/Nut2chZmAseC6wOnpMFLotw3eGqhFMuOvfgQwiSBssyy4S3XfZ5VXQ
 3nQAjfrkpxW8VXE/MjW6BvZ2NCof/9UbaCAoP280eYvXocwfrS+kuRv5PmJM2JdAbPLJNX0uK
 M/XVrX7QLGeZEIXPOE4n86EHv6QGZeuXQV8T+dGeBurY5Zz4D4Pmx+w+AYaEMz6KIB7YX8znR
 wGK7n61UM8ZEnlEFcrCFIFj7K9A=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small fixes for the parisc architecture, 3 out of 4 are
tagged for stable series.

The most important patch fixes ptrace() for the compat case, which is
used by latest strace source which now used PTRACE_GETREGS() to get the
CPU registers.

Thanks,
Helge


The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.2-rc7

for you to fetch changes up to 316f1f42b5cc1d95124c1f0387c867c1ba7b6d0e:

  parisc: Wire up PTRACE_GETREGS/PTRACE_SETREGS for compat case (2023-02-01 21:42:37 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.2-rc7:

- Fix PTRACE_GETREGS/PTRACE_SETREGS for 32-bit userspace on 64-bit kernel
- pdc_iodc_print() dropped chars for newline in strings
- Drop constants in favour of PRIV_USER
- use safer strscpy() function in pdc_stable driver

----------------------------------------------------------------
Helge Deller (3):
      parisc: Fix return code of pdc_iodc_print()
      parisc: Replace hardcoded value with PRIV_USER constant in ptrace.c
      parisc: Wire up PTRACE_GETREGS/PTRACE_SETREGS for compat case

Xu Panda (1):
      parisc: pdc_stable: use strscpy() to instead of strncpy()

 arch/parisc/kernel/firmware.c |  5 +++--
 arch/parisc/kernel/ptrace.c   | 21 ++++++++++++++++-----
 drivers/parisc/pdc_stable.c   |  9 +++------
 3 files changed, 22 insertions(+), 13 deletions(-)
