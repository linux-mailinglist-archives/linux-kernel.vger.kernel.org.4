Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E86B6133
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCKVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCKVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:50:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3164FABD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy23so34338262edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678571407;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9dlfB5JbVu/U11Cp+nQwAL8qvcirLFzR8pf4WiBE+k8=;
        b=ScEFLFjkZ1gjXw9Gna6siYpeeSjllKpiE7BmMib3pkK+9DpPlyUQC1O+pBzCJa9bJP
         aP2+sr3hcOahGYs1FHbkBl6nNtywTQ9sVbhedpA2sxalKydU77zf+uwYgjzVrywW8hwR
         dMzjKmh49bTRfceAIhvxz5D5nbzk/wvmmnJY4H+LWAbQ9YCdUYdRw43mAnep9CX2K4vn
         +67s1G9A0YFgPQovftdvUv2eFLcBYB1yZrLwWoUmeY/AkdIp8a6j/470LDXhz6KBmbrv
         lFUMraDTmGkJ8yPLGA26P1Xk5KSwmPc/YdXd48wKPg7ovIXodcozYWro/XJsI926+uOs
         BnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571407;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dlfB5JbVu/U11Cp+nQwAL8qvcirLFzR8pf4WiBE+k8=;
        b=hrFFKQSLXOyRf9u5lqdq7+yUvvLGHkw6yYs8ub+VVFsGeODI8/p35rjvZgr5R8B5zV
         HylNKhK0tRrFazogpCllB4nOngGYiw5QB3tX0w7FWr17BblCuKfPI34MiQ2x8iWyxy7l
         Bx8SSUcV5pKSBL3vToYKRPa2DuZO7+jdNyPXPwV7xUeXgxsRrsU6ZotW+FRrKUXX+KF1
         yuSsElkiD0Eiq4BwhDw4NA6AhfJukZlYAHC8KHD1Sf4QJoEau3dY5U0z7elZTpe36K8q
         CRAnuLzAHX77jBCH9u++dIyZaEZ6oAsZxxBll9xob2oPUKcaPCx3M7hMSI7Bbe/mE7W7
         fbcA==
X-Gm-Message-State: AO0yUKXoD1fq7UxPccv1haDLaa85qq2sobm49ueaQ5pThefC8zvDqTIe
        nQ1TFg+vU8qw5aRDfec19s6FjSwftm4=
X-Google-Smtp-Source: AK7set+XthPov3/TN8NFgrA1vj+sTF4ZWxHctnskm4C99VcbJM+r2VmVIo5zqaqd/J1u80TezNcQTA==
X-Received: by 2002:a17:906:d4:b0:878:5fa4:7443 with SMTP id 20-20020a17090600d400b008785fa47443mr5802283eji.3.1678571406766;
        Sat, 11 Mar 2023 13:50:06 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b008d53ea69227sm1497680ejc.224.2023.03.11.13.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 13:50:06 -0800 (PST)
Date:   Sat, 11 Mar 2023 22:50:04 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
 starting .._phyreg.h
Message-ID: <cover.1678569965.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused RF90_PATH_C and RF90_PATH_D. Justification can be quite
complex. Some variables are unused then those are completely removed. 

The following code lines are mandatory:
enum rf90_radio_path {
	RF90_PATH_A = 0,
	RF90_PATH_B = 1,
	RF90_PATH_C = 2,
	RF90_PATH_D = 3,
	RF90_PATH_MAX
};

Index is saved in variable name: eRFPath

Code likes to shorten variable name to the array with this line:
pPhyReg = &priv->phy_reg_def[eRFPath];

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (12):
  staging: rtl8192e: Remove unused RF90_PATH_C and ..D in
    rtl92e_config_rf
  staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfintfs
  staging: rtl8192e: Remove unused variable rfintfi
  staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfintfo and
    ..fe
  staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rf3wireOffset
  staging: rtl8192e: Remove unused variable rfLSSI_Select and
    rfTxGainStage
  staging: rtl8192e: Remove unused variable rfHSSIPara1 and
    rfSwitchControl
  staging: rtl8192e: Remove unused variable rfAGCControl1 and
    rfAGCControl2
  staging: rtl8192e: Remove unused variable rfRxIQImbalance and rfRxAFE
  staging: rtl8192e: Remove unused variable rfTxIQImbalance and rfTxAFE
  staging: rtl8192e: Remove unused RF90_PATH_C and ..D for
    rfLSSIReadBack
  staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfHSSIPara2

 .../staging/rtl8192e/rtl8192e/r8190P_def.h    | 11 ---
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  4 --
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 68 -------------------
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h | 37 ----------
 4 files changed, 120 deletions(-)

-- 
2.39.2

