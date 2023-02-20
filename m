Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47A69D65F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjBTWi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBTWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:38:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A029748
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:38:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso3271916pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HcOfL4aYmBkL+o95ZvGhn5IwC7jQ4ODD/q3vrS89doQ=;
        b=JW9ucggILFSXW3GTFj/aWzK4DqktqbN2h8a+bmIapidLMRSaV9gZ6jR5n9P6vQ2nRp
         lh3Mu461X6YpT8JA8Max/pe69hTozz9tdpMmN1Km+CP0r2sAVMj6pxkr7XVrj/F7FkSn
         jNnhHVP6tE3vz6Q5BLiVtBaajhAEAvAeRptQt3HUl9rYyLMlieZ5IxlDHEI5UNdJMegC
         gQyDAH4INueyGJzBAmXBflU9pFc7Yj2cVC/f2YSxZOD3ADSH/Vr/BbAYCuroS5clMtip
         07Ip8LhV9nl7k98mdKlD5/yc5NDrnzEGlzaVCEtBiz0546/+qKmsBPKw439si+DlwXoT
         +YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcOfL4aYmBkL+o95ZvGhn5IwC7jQ4ODD/q3vrS89doQ=;
        b=TrZDOZfTvAzJK0hZP/TCO2dYUA9eFG/yxJ+1aKWV4bttWTk3q/EtmS5+99G3fLABia
         7fr9fOwlG/u2Bx5l8V/079EVBYC+VwAjqtZ/NTxhDUJl9vHnjl1MgTlpZ1eS9h9usK24
         uQrd5wI1BHs3mH1lL2TttvXZKKG6FuCokSOuFxismeheUSsfSnEP2ppd8mT7pyciMS41
         it9DuZFTE3JlWxV3cAQdTtPt8Jxu+f5/AxJJYjH1tyUs71xuLx2+kI0OBGyFte7cW0qM
         cRCwl+kUZjE09C9w/nkkJ2npMiAhLfD/lLjpSDgLKyEmGqmaRa8J7KiI8psV/FqXOTXA
         BwkQ==
X-Gm-Message-State: AO0yUKWJY7E4x3vOaqIcuczGwRjKtNQOAsSGMS+OWmvDbmP8sOqozb3j
        yf99cmz+hLO2zOzAudxoMhLwZ8UbhIrIki8zXr0t
X-Google-Smtp-Source: AK7set+YBBEPo07oh9X4FmcFRuQXpwUI5AOZoglJ0szpj6YQCxZpVfmiLg5bRIIgfIy/FRn0BPJN82jQtUCeE3sGbak=
X-Received: by 2002:a17:90b:4d09:b0:233:c521:271f with SMTP id
 mw9-20020a17090b4d0900b00233c521271fmr1113714pjb.139.1676932703585; Mon, 20
 Feb 2023 14:38:23 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Feb 2023 17:38:12 -0500
Message-ID: <CAHC9VhT7aw1tGB2fqQMcoCFpwdvC2xfsUbgU0vaTiY_jRk+K9w@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Just a single audit patch for the v6.3 merge window, and even that
patch is pretty trivial as it only updates the mailing list entry in
the MAINTAINERS file.  Please merge for Linux v6.3.

Thanks,
-Paul
--
The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

 Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20230220

for you to fetch changes up to 6c6cd913accd77008f74a1a9d57b816db3651daa:

 audit: update the mailing list in MAINTAINERS (2023-02-07 10:22:29 -0500)

----------------------------------------------------------------
audit/stable-6.3 PR 20230220

----------------------------------------------------------------
Paul Moore (1):
     audit: update the mailing list in MAINTAINERS

MAINTAINERS | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul-moore.com
