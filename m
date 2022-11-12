Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3D6267FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiKLIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:17:13 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 00:17:08 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B56213E38
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 00:17:08 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.85]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsqIi-1p9F821Z16-00t8xn; Sat, 12 Nov 2022 09:07:26 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id B005D3C09F;
        Sat, 12 Nov 2022 09:07:23 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 1B0866F8; Sat, 12 Nov 2022 09:07:22 +0100 (CET)
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/3] MAINTAINERS: Update Kbuild and Kconfig entries
Date:   Sat, 12 Nov 2022 09:07:14 +0100
Message-Id: <20221112080717.17914-1-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XN7bIIK1QwtfwAfOknQCosHUGYmdYxSObGJU2rlPyjVwZn/nhwJ
 0lAoLnH+Ja7HvMom0ZmaWo3w2swkvXTKD9PEinX6UmVKzKL6nRM2SslLVMOjn7uIAqCAjTR
 GWNgdpon4BeHUtZTxhnMjQNJ1vivJ4fsqbQGgzTIJ39W8ME4upJKqCFJyj0ZCA2VTpEH13s
 SEbEszgM87APzMU4ThpxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i3ydBKVno/k=:5mbUXiV2nCAHwOE4iBMXoo
 iOY2mH5kikwMgSUQ1Fuf54jphpOwnYs9HQUFnMdPfsC7wX1ZRbfI0ENBmIfyPVFCQEqENh9U/
 z++pe0e9JhdeuCNVmMEKRJ6Yx4nweG/xnHNy/tEWPzyRjSFLwA7MHV3N59wNr1s21KnxJB4Q/
 K806arM8GeeX30lZaftMuAUpM2ukAUvViG5Me22wD9s8xJK8CB7sU5GM/pDnPV3FGgG5l+mJt
 zOMHDT8jHvuJe9NUCWqwRc+21CwE6N1jjfBbr/KBnZlDgcIkAdvsfZ5hBTLQs7IYaGAQtN4Si
 ovzTXtNkU9E9avbFmBEmWMt0iw5cahVf6GwYeAPvKSxXBf2sjDC4Lu4ZofLkV5xv+/V1LPgQX
 1o+VF2wqbr8nrxty7rrKAQB1fVdz7LWHbMZvbxZgx1/faPi892cxEnvuE3mGcr6bWZhKpgt7d
 ordtZ1h/qLI9j/AujfkS8xkSVV4Jx6ciwVUaaUnwNqF9NzmjIjTWSEH8ipH6V3l9dzRreIejT
 oIqHuYq5J0jsjLek/0QYiJGZhmVG3Cp9U1lwy91CHNwyDnMLDpSgyYnXLauHtKENVWcgvE62Z
 vmlxt+S38gMRsFq1rn5byQ6C1IuXxAAKOJkgmhf/SpKN4iVo5IBffIcLmWcvTlVIYM0m/CmZu
 MVFwHpAjhx8KUpkY4uy3yA1Ous112hjbRPuFcwobYfGrS72n1txJc8oPPD9tVnNWcvDVb4mZY
 9gAldS7enmz8Ambgptb/yNHP5pBYScE3ezaNSBq/0S788P3ysxq/TGYCsDBzqriOI73QEST3M
 OXUbJ1VmGPZz0MOoLI+YuD/u9mInVguwHEEC7f2jhnPp3O8kRnTO8EEJbFPOT2E1bIaNPxZkB
 gBmXnrQtV7YCItLNwlVC1bXwKrqsfEbhVKQJ+qS3686onNGkuXLzcDIDmggueIybLzAUC05BB
 p0X32etJRGLdBfq7vIJIA3O5WC2Wyp0v3Eo2ep2eQWPq/uVVd6hQX6vSvpszEMLrQxBvb6xuJ
 4g3ymVrdNxeq9q/vMFDnjoB2pVWwSO05GnHRCeYy7HzdYCa+FLDdGb4IvzhVLJkuzOuwBQYPb
 lkOoq5r+2HeiMMhGzwAzjjV90ln9gr3oXsTbf/gnrCGeUO9S0YCmKkbSZErbwvtgU9ExyFQhI
 9y8IThi3jEBFVltqqgT46XwaU0SOysAj7AWtXYM58q+cJZ17ECbOPJes97PtrO3eTX1Oa6OGR
 AXH0VfBWaD3ttLNacvLBXV47pYdT3D1RT7dNrH7GAMHIQi3+D/n+iStfqt0UlydkDEwCdAJmi
 iCmRwiaeATht0XDtEhcLUZFebFXfZQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MAINTAINERS by adding Nathan and myself to Kbuild reviewers and moving
emeritus maintainer Marek to CREDITS.  Further, add the missing patchwork URLs
for Kconfig and Kbuild.

Nicolas Schier (3):
  MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
  MAINTAINERS: Remove Michal Marek from Kbuild maintainers
  MAINTAINERS: Add linux-kbuild's patchwork

 CREDITS     | 4 ++++
 MAINTAINERS | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

Changes v1 -> v2:
  * patch1: Also add Nathan to Kbuild reviewers (Nick, Nathan), and update commit msg
  * patch2: Add missing 'no' to commit msg (Randy)
  * patch2: Add CREDITS entry for Michal (Nick)


Range-diff against v1:
1:  e827247c902b ! 1:  efd3cbed0d42 MAINTAINERS: Add Nicolas Schier to Kbuild reviewers
    @@ Metadata
     Author: Nicolas Schier <nicolas@fjasle.eu>
     
      ## Commit message ##
    -    MAINTAINERS: Add Nicolas Schier to Kbuild reviewers
    +    MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
     
    -    As suggested by Nick, add myself to Kbuild reviewers since I have been
    -    reviewing patches for some time.  Citing from Nick's commit 36f1386d34120:
    -    "I still have a long way to go in terms of mastery of GNU make, but at the
    -    least I can help with more code review."
    +    As suggested by Nick, add Nathan and myself to Kbuild reviewers to share more
    +    review responsibilities.
     
         Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
    +    Acked-by: Nick Desaulniers <ndesaulniers@google.com>
    +    Acked-by: Nathan Chancellor <nathan@kernel.org>
     
      ## MAINTAINERS ##
    -@@ MAINTAINERS: KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
    +@@ MAINTAINERS: F:	fs/autofs/
    + KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
      M:	Masahiro Yamada <masahiroy@kernel.org>
      M:	Michal Marek <michal.lkml@markovi.net>
    ++R:	Nathan Chancellor <nathan@kernel.org>
      R:	Nick Desaulniers <ndesaulniers@google.com>
     +R:	Nicolas Schier <nicolas@fjasle.eu>
      L:	linux-kbuild@vger.kernel.org
2:  88524e0789c3 ! 2:  c31750a47b44 MAINTAINERS: Remove Michal Marek from Kbuild maintainers
    @@ Metadata
      ## Commit message ##
         MAINTAINERS: Remove Michal Marek from Kbuild maintainers
     
    -    Remove Michal Marek from Kbuild maintainers as there is response since
    -    October 2017.
    +    Remove Michal Marek from Kbuild maintainers as there is no response from him
    +    since October 2017.  Add an entry for Michal in CREDITS.
    +
    +    Michal, thanks for maintaining Kbuild for almost eight years!
     
         Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
    +    Cc: Michal Marek <michal.lkml@markovi.net>
         Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
     
    + ## CREDITS ##
    +@@ CREDITS: S: 482 Shadowgraph Dr.
    + S: San Jose, CA  95110
    + S: USA
    + 
    ++N: Michal Marek
    ++E: michal.lkml@markovi.net
    ++D: Kbuild Maintainer 2009-2017
    ++
    + N: Martin Mares
    + E: mj@ucw.cz
    + W: http://www.ucw.cz/~mj/
    +
      ## MAINTAINERS ##
     @@ MAINTAINERS: F:	fs/autofs/
      
      KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
      M:	Masahiro Yamada <masahiroy@kernel.org>
     -M:	Michal Marek <michal.lkml@markovi.net>
    + R:	Nathan Chancellor <nathan@kernel.org>
      R:	Nick Desaulniers <ndesaulniers@google.com>
      R:	Nicolas Schier <nicolas@fjasle.eu>
    - L:	linux-kbuild@vger.kernel.org
3:  0e05c2d815d2 ! 3:  59eeba8ee2b7 MAINTAINERS: Add linux-kbuild's patchwork
    @@ Commit message
         Add patchwork URL for Kconfig and Kbuild.
     
         Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
    +    Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: KCONFIG
-- 
2.37.2

