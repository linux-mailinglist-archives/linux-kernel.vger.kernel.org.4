Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DED620360
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiKGXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiKGXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:25 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7EA23164
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:10:24 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so7446854oti.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3/fVZYQ2JVpTiGx6skt/0tkMTqCCwQ5hILAeoHIzSs=;
        b=J23GC8EYhjiHcauLwHf3AkHmpNjY+UGFWDCJ575jzVT/d14snbPbn+Vgxzh3MLJCi2
         H0Fc2LrcQtdGr+3N+jICTx3q3HLad5BGDFRmXZNJ84dVJBseNtE+f+SHdfG5T18xg/77
         sgFNoNw0X7whV+ZxFfD+4x8/6UFiCefWYtqkcfrZivAfydaRlpfB1OrDuFq8IAz6NsYU
         VvMR3RnGsDcb6QYap/zqk9xl7M1XwonqFizZ6/oMx+8LQdSYve7DQRvaMJWewOLni+8u
         pQzpCwVmDTSUENjmAhAs6QMoRn9EKRaWHywGyv3sIB10roPMW0hbW4LtRwcbdpFHAolz
         Vt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3/fVZYQ2JVpTiGx6skt/0tkMTqCCwQ5hILAeoHIzSs=;
        b=41rvoh1+3LB/zvq1/mJhAjeiqbD8mNvGKuYmfYcJFwgIKv/Imjn98z2AuTrBOPNb0a
         VbwKxBgiQ+eW7Fj7HZEczFfADHBgUit7xFXRyteTuQn3c0YJa0idRHREhj+IcK5/vhDU
         AO3hte7GBWcyeceo3Etv4zoP35urIF1qTZ/s3NKy9JG3wQyKZwv2CIspUPgvtNJMdjYJ
         RBLK9yVWrLwMKMcLAyJ9QbcPMVUV5ldvYko8jFru4SUvuE6/9eJeQ0w4ScIUAwSFLDDU
         GYQ9E8BhAWoPfoWRQidTOHthtMPjoxbSSry/4NsoK44utxE/znH71/QisV1J52bJkuPY
         E8aw==
X-Gm-Message-State: ACrzQf07hgGOW0xtKpQ7f63htY3fJ81kqxCQBKoQYTFFImz4FeQ8/O3C
        KSYUeW4SAZA0fieFbDvnnAkCyCTMM+oTxue0GaAGCJDFrYDU
X-Google-Smtp-Source: AMsMyM4W/0y9JtQ3t/NY6zug1jyXjavMlNOeuLnGr2315i/UdxHomZ2WOKbgdifWVTbkNUq/EgTXbb0flGJ6KKpEOK8=
X-Received: by 2002:a9d:7f84:0:b0:66c:53ef:e555 with SMTP id
 t4-20020a9d7f84000000b0066c53efe555mr20871959otp.34.1667862624045; Mon, 07
 Nov 2022 15:10:24 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Nov 2022 18:10:13 -0500
Message-ID: <CAHC9VhSbLE-Uw7X9oYpqewgVWLsqBE0xeRPgwvE=0B4O6Yne_A@mail.gmail.com>
Subject: [GIT PULL] LSM fixes for v6.1 (#2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small capability patch to fix an instance of undefined behavior in a
shift operator caused when shifting a signed value too far.  While the
fix is trivial and I can't imagine it causing a problem in a backport,
I'm not explicitly marking it for stable on the off chance that there
is some system out there which is relying on some wonky unexpected
behavior which this patch could break; *if* it does break, IMO it's
better that to happen in a minor or -rcX release and not in a stable
backport.

Please merge for v6.1-rcX.

-Paul

--
The following changes since commit 8cf0a1bc12870d148ae830a4ba88cfdf0e879cee:

 capabilities: fix potential memleak on error path from vfs_getxattr_alloc()
   (2022-10-28 06:44:33 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20221107

for you to fetch changes up to 46653972e3ea64f79e7f8ae3aa41a4d3fdb70a13:

 capabilities: fix undefined behavior in bit shift for CAP_TO_MASK
   (2022-11-0501:25:57 -0400)

----------------------------------------------------------------
lsm/stable-6.1 PR 20221107

----------------------------------------------------------------
Gaosheng Cui (1):
     capabilities: fix undefined behavior in bit shift for CAP_TO_MASK

include/uapi/linux/capability.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul-moore.com
