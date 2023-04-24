Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC76ED410
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjDXSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDXSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:03:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840275258
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:03:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b7b54642cso3565592b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359433; x=1684951433;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1NUtVt3knB/HcXq8IIUhsyBrwMDib57ziNBiOWDoTI=;
        b=CkeLkg5KKm0VfGJuk5lq/38olMkTW7PTeFFmDiDckPTrlzJgywQfut52O+UPNqV1A9
         K5KaXcu5BLzfG9x1VwslhDrA989OPGEx4MvEcr8joRS7ofdpZUuViB0NlLjWps00q/9I
         a6f77xX+CHYg0L5KwLa/L6MNUI6c3mYdjBVQnrxHNiI15oM5yo81MsoyIZ8OVsmWgR+G
         yquL/JyhEvfFifD1iLb4KPUDtf8ntADaWP2l8YJ8bj5T4MZSg0Vihn6RuBY4AysV6Yw/
         qnPzWbTQpjrRHhm1Mqt6+BDa23GOZlx2fGdXSXuglm+76iqK9TQ0HMhY47FLZCD4oTLF
         XOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359433; x=1684951433;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1NUtVt3knB/HcXq8IIUhsyBrwMDib57ziNBiOWDoTI=;
        b=Oml5WAfSLDzH5MTlr5MzHX5Yh5NV65rMGtvjGDlnq5VRFxAL7cup/D8wc+K3g/R6hl
         LUPfRoiVvV7oVWsIm2s68C4zp1YIjZVghHRaCmpt8Xrnn8QX1E3vyXneFTnCELFK2zQ1
         0pc0OExKE6WGQXeAt2zQlFF+qpcfAC6DWwtbT4YJFers6dgSnofR4M2tRYUCDfRQglx9
         9T3KcaVWF7NS3hHP46mwAELcRsYB4RyatrimFak9Yf7XeC57oS98kxAND7opa8ewZvY7
         AVbj+6zkNFgFU5SCSTmYvoKId9NJOf8sCoIfqMPo5lr/Mq6usxVw3+qd9bHe9uSZ3lKy
         BWzw==
X-Gm-Message-State: AAQBX9fNBStchgAGhScZhWPuCclWDO23oCe/iJtJo1ikVqngBW/VIg2h
        3NR50aL4/9r9eJ4au6MoVt92PFg7t2w=
X-Google-Smtp-Source: AKy350ZA91Hw7jALmRYigNL9sAR+S2RLG796GhOl37Oju8SnrS+eaj2ZhA4j9lhMUwSNn+CXqlijYQ==
X-Received: by 2002:a05:6a20:1449:b0:d6:91f5:2b10 with SMTP id a9-20020a056a20144900b000d691f52b10mr17617976pzi.58.1682359432995;
        Mon, 24 Apr 2023 11:03:52 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id x185-20020a6286c2000000b0063f00898245sm7948417pfd.146.2023.04.24.11.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:03:52 -0700 (PDT)
Date:   Mon, 24 Apr 2023 23:33:48 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Remove unused rf_set_sens variable
Message-ID: <cover.1682358035.git.yogi.kernel@gmail.com>
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

Changes in v5:
    1. Rebased onto latest staging-testing branch per feedback from
       philipp.g.hortmann@gmail.com

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

