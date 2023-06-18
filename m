Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D728E734635
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 15:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFRNDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFRNDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:03:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF61AB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:03:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ecf9a081so1624254b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687093390; x=1689685390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+3L0ggJSfWU7Zuqsbvu6xk0bd4fTGwDV0IPuzKiTyQ=;
        b=Azw0dRnsLrFwP4gVr4y9n+Yg7DuW/gctTRllmlendUKySevHv2a/ZO0ik9ygWV+AdE
         2Fjtsbb7RvxCB0XZI+LgW9p6Oi5X54ClLosqQaRIxO4eHoz+nCDtL4WSVV1xaRkj/Tqe
         0oysrWpvd5/69PqrMbL0JAxcH/xW1S/O3pZSQqPXNjjxHZjGxaBun671IVaSShlxw+0s
         IWz16xDcTMvcRr3T/bcQfbtncS08I3A1xqviCFHX3+n7WUbG/I7WejP+UtZ/2vMQCtBD
         PaUESH4cwO8eqkaFih2Pfc7eNW6+kCxj+XTMVPzfbhefyXqYTPz0Jl1LHR3MPEIICFrl
         taXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687093390; x=1689685390;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+3L0ggJSfWU7Zuqsbvu6xk0bd4fTGwDV0IPuzKiTyQ=;
        b=lxJoLXJ/NCE8/zmB/0B1qudrLnjexakC4v2h1Zec83RmSmcIQvlEmI6+ZFKJO4RzbF
         YlGraEAG+GDSWCXukOyUxqJRsApv0na5r8PBGIiDpi7W0Tg9FlFkOAhMrBT/bdAzkzOS
         OGFcbYB0INAQQpRwzBTuesko04490YsfMAETap8iGyPvRfOKN4rCJ8AFU3Mft6/d4KrV
         Dp5lL1hS6ioDDVMVF1z/hplfiFXRSPEs7kXaZho45P46ZKsT36c9ITCV5uu7etJduXai
         GnnRL9OdAup+bF6+/5E0yw7hOl89ToSQY9vCNTmH6ENq9J1dBhi9etvV9KVSKTCg71vd
         vA6w==
X-Gm-Message-State: AC+VfDyTScKTWJE8hz7RsS6FySeB28f2irKD/FZ9eCVyjObiRXI7CopP
        /jqsmL//ztalqi11guXBX1E=
X-Google-Smtp-Source: ACHHUZ5PjksCNEFS21LbW7ZuJxv1PpDu7JK/ObVYUqOBKaf4J8GApVfQj7aqK3IM4tdHcguY+XlVAg==
X-Received: by 2002:a05:6a00:1891:b0:666:b0fb:fa8c with SMTP id x17-20020a056a00189100b00666b0fbfa8cmr11485609pfh.3.1687093390292;
        Sun, 18 Jun 2023 06:03:10 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id r3-20020a635d03000000b005533dcb7586sm3241005pgb.20.2023.06.18.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 06:03:09 -0700 (PDT)
Date:   Sun, 18 Jun 2023 18:33:04 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v3 0/4] Trivial code cleanup patches
Message-ID: <cover.1687092111.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables in struct rtllib_device to avoid CamelCase which is not
accepted by checkpatch.

---
v3: The driver is split into 2 modules, calling the functions directly which 
    the v2 of the patchset does breaks compile. So reverting back to v1 of 
    the patch as suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>.

v2: Removed the variable and called the function directly instead of
    just renaming the variable as suggested by Greg Kroah-Hartman
    <gregkh@linuxfoundation.org>.



Yogesh Hegde (4):
  staging: rtl8192e: Rename variable SetWirelessMode
  staging: rtl8192e: Rename variable SetBWModeHandler
  staging: rtl8192e: Rename variable LeisurePSLeave
  staging: rtl8192e: Rename variable InitialGainHandler

 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  8 ++++----
 drivers/staging/rtl8192e/rtl819x_HTProc.c      |  4 ++--
 drivers/staging/rtl8192e/rtllib.h              | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_rx.c           |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      | 12 ++++++------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  6 +++---
 7 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.34.1

