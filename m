Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C562F471
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiKRMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbiKRMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:18:22 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D41970BC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:18:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r12so7961920lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ww17wU4XE60JKwlSWPDqz6kaKQUbc+gNj6D8T4n4z4=;
        b=CdY/jY/lkuKG4qpVE/hau8sU8G4Fp0U67Bd1POFH63wYcEEr4QC5XOtFacbi/JmPh6
         1cyEbTu2K1gszHlDzuAmf5mzVChCUI51QLJf7ZwJNDrqI5IrpPC/GFX68kAbt+ZxYTzy
         CrZRyZ0p7SLj63O673/r6AgATQhGhfecN2iEc9INPQG1BS8jIKX3EjUJDDUrWlai8XEA
         ixl1/ONMpwZR0ys43aqa+khwmT/JNJHqIcwkJmKqkZXI2lAU/XMGhMrFEBQ6yiwoXJ8g
         kpGbBKNxVQnl68AjB8mhZrD/GIiG5YLaLd87C9P5ZMpOg5+zXFzrgNuFCI87vakJ1086
         ywhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ww17wU4XE60JKwlSWPDqz6kaKQUbc+gNj6D8T4n4z4=;
        b=Y3Z0B80hqJ67DpPcKXlaHDyfylp5+SPRnouKtD7LgLkA45TEgQuVBHjPL91d1MCsPW
         L3BpJmsLXMwRZ4mFlR2eSMTDvNKCw9W0s/DH/JH6sahA3HrODbp1fI8hse5WF8PPMa+P
         sm0nYQ6a6ZTpDKwZYIWClrfT81GfYzG9KzCUR0C/FnD3e6V7kB+IeokY41ZO1Qmo/Ruj
         xBSq0T+QQVPiFjIaLn0f9glXwQILsEAedAnF9cZMwoLam71NmqPmQJXMLzUvhn1neLM5
         0IDJJbl8cR+KfgUBQGHwn9Uc5zwPRCqTTAwzauQO1U0AFsMxZUWyS5p5sVvQ1lB8FWMJ
         KiTw==
X-Gm-Message-State: ANoB5pkowsW91x9TX2YB+8A0aVBQsRr3IXV/XgFU8AsdL6bff6jAJJY8
        M0E+7fwnMqMUpSi3Udx9LidayPJ+KfIb5Q==
X-Google-Smtp-Source: AA0mqf7CHdPGUaTnQbcS7YC27XSAfVUWm39zaCxrwZQ4k+ZwVIgfeoyEov9b5E5kvT+xXnoC7xrpjQ==
X-Received: by 2002:a19:5e58:0:b0:4a7:5a63:71e1 with SMTP id z24-20020a195e58000000b004a75a6371e1mr2441034lfi.399.1668773899111;
        Fri, 18 Nov 2022 04:18:19 -0800 (PST)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id bt26-20020a056512261a00b004ab2cb8deb5sm640880lfb.18.2022.11.18.04.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:18:18 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:18:16 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Add __init/__exit annotations OP-TEE driver for v6.2
Message-ID: <Y3d4CHWl3Ofx5OrX@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch which adds __init/__exit annotations to the
OP-TEE driver module.

Thanks,
Jens

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-for-6.2

for you to fetch changes up to bd52407221b4702af690456b2b6006fa6440e893:

  optee: Add __init/__exit annotations to module init/exit funcs (2022-10-11 11:20:16 +0200)

----------------------------------------------------------------
Add missing __init/__exit annotations to OP-TEE driver

----------------------------------------------------------------
Xiu Jianfeng (1):
      optee: Add __init/__exit annotations to module init/exit funcs

 drivers/tee/optee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
