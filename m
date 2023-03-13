Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D366B851D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCMWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCMWru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:47:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC71164C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:47:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd5so21040096edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747581; x=1681339581;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47X2EKjMMA636t88pLDlxyLev9K8VQs9ssTsZmf02sY=;
        b=eAzvYazXSWovL7Mb9yNKn0qGvam3k6FYzSa5czH0RlfUO37WzySSSqAJJ3EeWzc9d1
         /ISwPc3hMa9ZVeaRhvD6djscLJxGCIDTUPOYyk3nNSXQreT89ZMDYIsKRs4wafCMAZQN
         D5VWy52E3pTl14UXIMI8BnBpLcZbgPHV7jaxuwraIKdU8wH+XfU3IklJCJw4Ikv2ehB9
         tmKYdFVT1Dg5YVnc2oa5qcCqiZ/MknnPfroBd+rDKvgMlFbe2XhTcoRaZBn+ntjv0aUi
         mT6H05VVO9sdl9gjfu/xVxzCt3uc5p6qmnHYoARHhCz6ulSVL3s9FX/XXw6INQvHzFaF
         rlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747581; x=1681339581;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47X2EKjMMA636t88pLDlxyLev9K8VQs9ssTsZmf02sY=;
        b=22Xux57QxVoVFf0FakNkOYOFSi8UPBqtHw7N8AwWNunSATmwZPnpJY3XGg5BqOqUaL
         m6HbqrydpKdGuQF0A6T9VWK9FTucZ/OGk43eLVtALS/alhU3+6JU2c6f+b6ukXJS+bAm
         OVli2qFxMEayZJxUZ7w6xYqtwvWuTXD1PsLWaGK62ITalyIah6IUffYnebZR39VKFwnz
         z02jGs2mJMjZdjKbrxssIINrRRMWOjqEmVWQkFBz+uuqKfvilniRt9fF9sYb85Gx8L5z
         Koy6u3nchVqkDokaj7t8V6GNAUhNRV/FIm5FONNL8NNHNwcv0qi2eNLumhIt3cu3SZHn
         ySXw==
X-Gm-Message-State: AO0yUKWUT12Q5dz/UAIt2jKKJaJztfcntGLwVMjVOi/ZNe6MbrFxWado
        k42WPvgwObVC8tg3kB929UI=
X-Google-Smtp-Source: AK7set9a02G10VT3epJzDUC4nOr7vJEIsy5pPNgtD4A+8wNIKvk5wpfxZ3ZBqQwOusDVSEk1MlrbHg==
X-Received: by 2002:a05:6402:5207:b0:4fb:c8b4:698d with SMTP id s7-20020a056402520700b004fbc8b4698dmr7785989edd.4.1678747581369;
        Mon, 13 Mar 2023 15:46:21 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y97-20020a50bb6a000000b004c19f1891fasm279887ede.59.2023.03.13.15.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:46:20 -0700 (PDT)
Date:   Mon, 13 Mar 2023 23:46:19 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192e: Remove unused RF90_PATH_C and ..D
Message-ID: <cover.1678740713.git.philipp.g.hortmann@gmail.com>
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
complex.

The following code lines are mandatory to keep in mind when reading the
patches:
enum rf90_radio_path {
	RF90_PATH_A = 0,
	RF90_PATH_B = 1,
	RF90_PATH_C = 2,
	RF90_PATH_D = 3,
	RF90_PATH_MAX
};

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (2):
  staging: rtl8192e: Replace RF90_PATH_C in test expression of for loop
  staging: rtl8192e: Remove function rtl92e_is_legal_rf_path

 .../staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  6 ------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 +---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 18 ------------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h |  1 -
 4 files changed, 1 insertion(+), 28 deletions(-)

-- 
2.39.2

