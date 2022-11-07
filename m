Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA25620361
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiKGXKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiKGXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:28 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B18221255
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:10:26 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so1429936oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C/L1wjrOu2FXdc85i7dLzQ2WP8XFJpr05YEP11uQNCw=;
        b=goTdSvag9G3aQdgw9zMKqsP5NJRaWurzjcdBlKCEvVm1UmcGaVxCHMhIkqDbITekyO
         5vpYUUYpm8XwV/hQGsHPO7RmHSv6VRLsSWKNh9QI7pPkkvjPVmqiHurgXYTZYUzPAjnK
         v8O4feF6wRRUkUj7hS4rpHbP6qlJQr/FE+8dk9IRi1hSqXvoFo4bnFemkq9xeBu+tTmn
         4IlV9pRnE7bWbcJofk+iI2RN+6lZvNTYr11IMn9wvpikUJAUEgeBNKyzhYjw/arSxDlS
         uNGg50FpIA5JKl7kE9t+TNojwRKamWN4ECMeKoCKbpd9lE0pFM/H6TUuS4mr/vYlRrGG
         HSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/L1wjrOu2FXdc85i7dLzQ2WP8XFJpr05YEP11uQNCw=;
        b=ePwNxLEHUnphASmUhn/2oWBn74p8LcLfF6xxSdjigHaX0IZ0/ySio5si2sHkF8oBG6
         PNJtXVEynzIUoehpzSuhaPmAbIjLxm/Ayi9VpO/oEidtLNpu2g/OaO933F7WLthiClWB
         p4+rUYW8C1Jelha0MZXaheYALec+yZa70XdqxuboitI+wwOn9g29nij7L0senld6LIFI
         zH+FAWQ6UC9t77IkTdgHE6j5DL5xC4EEnfc60/zqAysPG+BDj0IuzzPXsby+jrpyg+HF
         d1xbyTqW8a52cu4xj4HMR+RqtZm57llgv2pNro49K0A9lJOsV8yx6EvsMw2Q2l2UZhOH
         mAWw==
X-Gm-Message-State: ACrzQf0F18eyJsUCY1YK+JD+y4Bn9CXbwqRtALXjxlA88WOCs8vQ106x
        SxH4abhmag2u/SmbX0/yYWvjvejcXMsDGLOzV8X7
X-Google-Smtp-Source: AMsMyM6eWqBRHLpEf8bQJwHdJItEPT5MOsGSoS2ENjJ9mNLglMPqZx9GXKemOe3oFQum55dZh8oMmgrz4ga9a617v8Y=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr14935862oiv.172.1667862625908; Mon, 07
 Nov 2022 15:10:25 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Nov 2022 18:10:15 -0500
Message-ID: <CAHC9VhTv96BsOTQyyBTWSJ80fDuiniacDUhfz1GJrP-huWxJzg@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v6.1 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small audit patch to fix an instance of undefined behavior in a
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
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

 Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20221107

for you to fetch changes up to 986d93f55bdeab1cac858d1e47b41fac10b2d7f6:

 audit: fix undefined behavior in bit shift for AUDIT_BIT
   (2022-10-31 07:29:47 -0400)

----------------------------------------------------------------
audit/stable-6.1 PR 20221107

----------------------------------------------------------------
Gaosheng Cui (1):
     audit: fix undefined behavior in bit shift for AUDIT_BIT

include/uapi/linux/audit.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul-moore.com
