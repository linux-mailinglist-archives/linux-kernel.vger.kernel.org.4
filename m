Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590FA6A2B46
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBYSUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:20:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B39EB5C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so4490929wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 10:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677349217;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttL7bgAKkimESUSg8lrqpEXaEc6mFGIu/p94BALCC84=;
        b=QYbLU95BiQMPQCnYSF6BJa3l6wGsNwmTAnJH6xdMAvB7LEAQJiz06uclR+rhkYeN7M
         fh3WifeHJ+5dAXJRp+Lp/YJRpf/R+ePhfe+T2FxIq9B0PnxDAVhR1KgD2YM0w4lpggy/
         lPfAvFI0X75T4P5pju7CPKP+koZMg/0Mkapyml/rAnjC9OGE54X5oMBNAs5cVzD1fTNu
         dd3Jdcub6C6KjMgOpKD8t4J28bbnc9j5DSF0SaPX5rM/VqEkuZPVFrVq1hT4AYk27nar
         u6ysFfZeBCAIG0ZjXakJbRGdF0JKIAe3bC50dh1IE3M1MI8cIdDYJ3mPI3zudeVlEspv
         VQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677349217;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttL7bgAKkimESUSg8lrqpEXaEc6mFGIu/p94BALCC84=;
        b=xvCbHFMY+Te9wE2w8Oq2gJ6KCMsYPo5Z7EtNAwdOjYnmXJhe+jOxgm+amS+2iTYN6v
         z0H/UNxD3PzTQ3GF01gmbKjcTinjOkJFmIz9Aku5Atyp/34gaOjiD/PlsCUTobwCHDu8
         j5ZeG9Ulk/pvxVUxl9F4XCacrQnHkz1KS+OWBPG7jo+Y22rKkbt5jgQZhdRB16t/WrVr
         NkCkzxEb1Yfm8uS87NZjN/cwjixAnwgq7sV0cGZulzkA02xCuQ6HB7djsd91VPk4JZ4U
         ofqCFMURoEd6J9vfn+ly2XbVy9xfnWPfHLJRxMQbCtPoOusibPm03zt1zUq1t0QSzlrh
         ktmQ==
X-Gm-Message-State: AO0yUKVAIrTSPKnECtTvtWIBz6sZ/+dfZ/vDoT/6MStyRsMDxtWGnCA3
        ryXNIsW/FD+vPqXCM1axFTCgELc7+Yk=
X-Google-Smtp-Source: AK7set+RtCfbk4VjUMDkjOPwOW0sgAhnhpm1abdqWOm1IOU/uYyvjIwW1rgZ/rd+LLEPRM45N8DQVw==
X-Received: by 2002:a05:600c:3b8c:b0:3ea:c86e:4377 with SMTP id n12-20020a05600c3b8c00b003eac86e4377mr7381893wms.0.1677349217279;
        Sat, 25 Feb 2023 10:20:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003e2096da239sm7072561wmq.7.2023.02.25.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:20:16 -0800 (PST)
Date:   Sat, 25 Feb 2023 19:20:14 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8192e: Remove NULL checks of function
 pointers - struct rtllib_device
Message-ID: <cover.1677345331.git.philipp.g.hortmann@gmail.com>
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

Remove NULL checks of function pointers from struct rtllib_device. This
checks are unnecessary because the function pointers are set right when
the driver is loaded.

Here the flow when function pointers are set: 
.probe	= _rtl92e_pci_probe
In _rtl92e_pci_probe the function _rtl92e_init is called. In the second
line of _rtl92e_init is _rtl92e_init_priv_handler called that sets all
the required function calls.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

This patch series requires the patch series:
"[PATCH 0/2] staging: rtl8192e: Remove struct rtl819x_ops that has no entries"

Philipp Hortmann (4):
  staging: rtl8192e: Remove checks of pointer to handle_a.. and
    handle_b..
  staging: rtl8192e: Remove checks of pointer to LeisureP.. and
    start_se..
  staging: rtl8192e: Remove checks of pointer to stop_send.. and
    rtllib_..
  staging: rtl8192e: Remove checks of pointer to rtllib.. and
    ScanOpera..

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  8 ++-----
 drivers/staging/rtl8192e/rtllib_rx.c         |  7 ++----
 drivers/staging/rtl8192e/rtllib_softmac.c    | 24 +++++++-------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  9 +++-----
 5 files changed, 16 insertions(+), 35 deletions(-)

-- 
2.39.2

