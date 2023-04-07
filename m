Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E26DB5E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDGVuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDGVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:50:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68AC66A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:50:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-930bc91df7bso151193166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680904215; x=1683496215;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fq8RUQdzJGvVRHtSpwTfubZBnwWXomggCH4yTMLMhUA=;
        b=YZoa6b1LgZLhTRKbgPtIevcXFYpMcLDHzfzwnFNrW73isDDqzdc5rlJPsYyZX/8Cdp
         1v4LjfMk6+ssbGWHTOo0SDXN1N3FOLF9f5rmyHmVDKuO6X27N++FQ7BZzuAOFBn/gj+c
         cuYMaEnjWHWRGBFXWA1NcKPGUdquJA4BCymYefa4NFo6mnDH5JBc0Efi9zziVB3p9npY
         LBCPNqxcXVdtAg9PPEm0KhFKHO1BbT4fdwnevZibhjkVwxyonTWhdpHxgk7QHDZ15Pfz
         beZc1hbz5yfen7oOIeq2RqTLUUq0kPyQFOfJNpFX+6Q7z6jaUxOQhCJIyquFj/on/vUb
         D75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904215; x=1683496215;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq8RUQdzJGvVRHtSpwTfubZBnwWXomggCH4yTMLMhUA=;
        b=V+mAQGrQbtOoNCd2zwtehC5va6jMe3yakqAZIMw2pwNALGm4mdn1XM8s6LTUPZiWar
         pzxEYPAS6z10/kGuwFojirDh+hwxcXdl3Al3XZWjXzjzUBVslE1wXeP/2YCnSbYqJppt
         pOYxyk7EP4pEtnHW8y5Sw+n3iim97rA97ryjI9I3alfsB9HfxzrPbu7kpx+XjKmqmvFc
         jdR9caOAAKXT/pyx66wKKwyOyEncYZ7aOXQGnFkYSrVB8tOhGPqFa7HCeHu5ifLNGi/s
         XQsrTR8NNPdqiFBS447n4BKRTof9+MdrOkj0qSYnMK5MZJJQZncOY971YRueYFyHqkV6
         vTRw==
X-Gm-Message-State: AAQBX9cpLm846dPRJe4RgzDd52kiNeVnIuWnXM419R7nMZBMoGZI2WKL
        GfbWPJ6k611rNXxAoc3+bjk=
X-Google-Smtp-Source: AKy350aRz71SCGQ3kQveFF5UROzvL+o0nTf8PrYR8yyMN4DiOl6b3SgDcbkFJvpeCSyh1uM9PqTsPQ==
X-Received: by 2002:a17:906:19c:b0:947:bff2:1c2d with SMTP id 28-20020a170906019c00b00947bff21c2dmr720729ejb.3.1680904215069;
        Fri, 07 Apr 2023 14:50:15 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090646d000b0094863433fdcsm2452572ejs.51.2023.04.07.14.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 14:50:14 -0700 (PDT)
Date:   Fri, 7 Apr 2023 23:50:12 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] staging: rtl8192e: Remove unused code for hardware
 rtl8192se
Message-ID: <cover.1680902603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro IS_HARDWARE_TYPE_8192SE and unused function
_rtl92e_dm_init_wa_broadcom_iot. Remove a double check for hardware
rtl8192se. Remove unused variable.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e
---
v1->v2: Removed patch "staging: rtl8192e: Remove unused local
        variable irq_line" as it is unclear if the pci_read is needed
        for a hidden feature.
        Checked in patch "staging: rtl8192e: Remove one of two checks
        for hardware RTL8192SE" that the pci_read does not follow a
        pci_write
        No changes to other patches.

Philipp Hortmann (4):
  staging: rtl8192e: Remove macro IS_HARDWARE_TYPE_8192SE
  staging: rtl8192e: Remove unused function
    _rtl92e_dm_init_wa_broadcom_iot
  staging: rtl8192e: Remove one of two checks for hardware RTL8192SE
  staging: rtl8192e: Remove unused variable RF_Type

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  6 ------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 18 +-----------------
 drivers/staging/rtl8192e/rtl819x_HT.h        |  3 ---
 drivers/staging/rtl8192e/rtllib.h            |  1 -
 5 files changed, 1 insertion(+), 30 deletions(-)

-- 
2.40.0

