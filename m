Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA09634A32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiKVWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiKVWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:45:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED99AC78DA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:45:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bs21so27008104wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwnAmAjAMwtjZoPh/wvNWfHfRdEY7FzZJcayQD/cYNo=;
        b=dVQCNhCbERZyTd+bv2KF63naFelmgh73AJnR5uDLCAAkpNf2Fy7unE4i3UpRBOiHdv
         XWv+eqY4Qc/5Z57DPvm2ZeUiLOFji+aYkh9ylayw1bhkVOD6RA5CRa/jnd5QX9xtoMxz
         kRkAHtZu7XFIPFThpSJtufFIFYa12IOOJWIaK3lB3P+yUcRcqlUriymVpsuIFeLH3oI6
         PbwmfJNeWhMWqs5d8pLXXtJaZD/+wB2Ni1DcBSLljjPzKmNYMtbbewWiCE8qqO9WNGSF
         VfvqGZa+GYnMDlw47ox1IrBX6pr6lynk7PK+A51udtddGGKdAtRx7fe7YWzXOh9XaItH
         pVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwnAmAjAMwtjZoPh/wvNWfHfRdEY7FzZJcayQD/cYNo=;
        b=Dc41Z/KQ3DVZs+sNL2YLx4P/R6la7qwqJZqhqBNv+0YvY/TfqmZ8W+WC33/N36zG1M
         dX8EUM3COH2EAhV1T1rML5vdhVxBSyvLii1elKj0Q4XFdQ6LZLVwH6wtS7OL5lVT6DZy
         5Vn7DFntn7PC6dfdC2ZLqU7Qx1MmeKaFgyGN3Jk0GkmlOWVHqY+0jC1roHVNU5A+maRF
         Z4QiDfESb+jEgspQSNpmLHv3TCjs5A85X9fjQASj39fpsycV8JsUcJwH3MGLbYM60fE+
         eH5zLfpzFzLf5dIMuQs8xj6MD1rxVI45CgNHOgU3bQki4nNePiFkjv6qVxLd2DiV2jzz
         NU7A==
X-Gm-Message-State: ANoB5pkR+Y+cAxbW+d+7s/l+BeMAnYrkmjkyG2TmzRK+Dm2CWli203GB
        Dw/6ucQfqEhwlZ9T94pVnvkDpB9RXmY=
X-Google-Smtp-Source: AA0mqf7KDia5bRWua40jNjtBWXuw+NCBaVXTq+aJZMnz/ReWXZpoAKjGKkJo+38DQk0JPtmYWDT+Sg==
X-Received: by 2002:a5d:6b84:0:b0:236:6fb2:ff91 with SMTP id n4-20020a5d6b84000000b002366fb2ff91mr15066595wrx.520.1669157151478;
        Tue, 22 Nov 2022 14:45:51 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003c71358a42dsm231159wmb.18.2022.11.22.14.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:45:50 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:45:48 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: rtl8192e: Remove unused variables in rtl_core.h
Message-ID: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
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

Remove unchanged and unused CamelCase variables that lead to dead code.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (5):
  staging: rtl8192e: Remove unchanged variable AcmMethod
  staging: rtl8192e: Remove unused variable skb_aggQ
  staging: rtl8192e: Remove unused variable initialized_at_probe
  staging: rtl8192e: Remove unused variable ChannelAccessSetting
  staging: rtl8192e: Remove unused variable int_log

 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 15 ---------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  7 -------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 17 -----------------
 drivers/staging/rtl8192e/rtl819x_Qos.h         |  7 -------
 drivers/staging/rtl8192e/rtllib.h              |  1 -
 6 files changed, 51 deletions(-)

-- 
2.37.3

