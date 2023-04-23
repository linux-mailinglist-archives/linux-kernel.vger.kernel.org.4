Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FCE6EC056
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDWOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDWOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:22:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D012B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:22:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-247122e9845so2500109a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682259727; x=1684851727;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVt7yDbi/0+T9A3kskBIqFMz5JWCsfF4sEoLpMEoXSs=;
        b=gZeRNCEboFtFuzswRDftVtw5ef6noYVrDAGPpESkhflCUZOvCQ67A/ZnG00pPh9w/h
         hHPyJyKBnzwFTSmK4Rcbsj5tKGudkYoq3cg4RXZ/a5ApjmhuM6vaoV2jbO9mNPkEcmX/
         KKGX1x+ol2BZRH+nAMsFrocqHw7ArIZMJDjQboPTkMvfaX128ThcQWa+3kA+4GBFRnlW
         jz95jh73NVmasYVkE1nEm8ubnPV3LKe9E0lg210IWfMeG9w5bFtDzOuZcCZX1n6dVyhD
         rQAPw/eDYMPBvbLe4L/FXcJ53XLs4zmreonjyXe7N7e7qTiRiDobq+ZR1ZmNqVO84tkF
         n/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259727; x=1684851727;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVt7yDbi/0+T9A3kskBIqFMz5JWCsfF4sEoLpMEoXSs=;
        b=ZK+Jt2uaPyVPYJ+q2Qph2EhH8biDFzy36rr6SkfI67mleynVhjynDU41ggSxTPoPDG
         AIbuZ3b5gNoy/TUYfsry3GtFqqsCYusY56A5ifkb/9wSI098w4S3xUdW11Cqa7cLX7IU
         YJ8CxhrPOBXHyg5qCdTV0LoCSdhoXyQTxVgokkrXqEQ2x2avGa5p1SRHJHiV3LVSPNtI
         MwEpqBVYGUi2WEsWri5aTRk3auj8ExzrDY3gN9Xjpyh1ITzRZ5PoYaoPPUHpw+n27ww8
         aMASX0HBnV/htvP198PTh3alwE8+TiqISTueQVhCZNqqy2rvPKyhHfwC2ih10dvvIjxK
         lZxw==
X-Gm-Message-State: AAQBX9fzeMudkVoeRRcRoLzG5+MWg/GqhUF15ZBo1N4qV3kjDqlpg7H3
        gy8vRaGTD5Qx02bU1+8i7aNx4Q8y1X8=
X-Google-Smtp-Source: AKy350ZL6PsANWh7JqFcxX+XhAOLY9xBXDIz+XG6HwbghAwtgd0H1ZXYmW8NIIz2+O5syNTA2Vny9g==
X-Received: by 2002:a17:90b:4acc:b0:24b:8b39:cd7f with SMTP id mh12-20020a17090b4acc00b0024b8b39cd7fmr5213575pjb.41.1682259727343;
        Sun, 23 Apr 2023 07:22:07 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a9b0300b0024b960de793sm1716290pjp.40.2023.04.23.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:22:07 -0700 (PDT)
Date:   Sun, 23 Apr 2023 19:52:02 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Remove unused rf_set_sens variable
Message-ID: <cover.1682257566.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rf_set_sens variable is declared but never set, so it is always NULL.
Cleanup the unused rf_set_sens variable. Remove functions
_rtl92e_wx_get_sens and _rtl92e_wx_set_sens which always returned 
error code after removal of rf_set_sens variable. 
Cleanup unused max_sens and sens variable.
The patches are required to be applied in sequence.

Changes in v4:
    1. Split changes into patch series per feedback from
       gregkh@linuxfoundation.org

Changes in v3:
    1. Fixed description to fit within 75 chars
    2. Added suggested tags
    per feedback from philipp.g.hortmann@gmail.com

Changes in v2:
    1. Removed function definition rf_set_sens
    2. Removed usage of variable priv->rf_set_sens
    3. Removed functions _rtl92e_wx_get_sens and _rtl92e_wx_set_sens
    4. Cleaned up the variables sens and max_sens used in these functions

Changes in v1:
    1. Fix comparison to NULL of variable rf_set_sens

Yogesh Hegde (4):
  staging: rtl8192e: Remove unused rf_set_sens variable
  staging: rtl8192e: Remove unused _rtl92e_wx_get_sens function
  staging: rtl8192e: Remove unused _rtl92e_wx_set_sens function
  staging: rtl8192e: Remove unused sens and max_sens from r8192_priv
    struct

 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  3 --
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   | 45 --------------------
 2 files changed, 48 deletions(-)

-- 
2.34.1

