Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6571D69E924
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBUUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBUUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:52:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B2BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:52:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ck15so23599142edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677012766;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME8MmTL9+xojo7h0KQk1KDfx29xTX9q7Bc+zC3HoTX4=;
        b=IAc2VZ7fVro0mazMsBITGoh0A+rYarGL+Mq/INZe/ug+CaZUIkAg1pR58RfjtzLSxb
         v4msx0AzIcb8LG9n1aTEDxzVdzKj4vZYummLfGlFgPA4NLCX70vLeYwb8s7I6jKpQgDN
         c8DlpHtR12o5K9S5sHZZ7wswSmPBP5jzPjveI0TyRnznQg5VIxT5q60PhG3taZuSVKnd
         pMxY6n/FgEnGdFAAhN6IAlorhrLS+6ti4mjZdCT4LOuVWd+r/8zfl/ZuSxbcBH3yoXrf
         Hz59dqjnD5FV8kgsErStepARRrPN09Wp7FoRvGBbnq9NDRVa+VAMDDKwCNX7QBxnlYFw
         vyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677012766;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ME8MmTL9+xojo7h0KQk1KDfx29xTX9q7Bc+zC3HoTX4=;
        b=A5N9NqwURnJ2n6a8wJ1GZeKwz9vZno4m5RH/aOhODbWH4chIteOicyEzf0n9STynIN
         Zl2TrXV0QwbDeuZ08czk/k+ESFOgaxH/7CNRrkCom2MOu2XTrcS1q7OC1GcuUjFUoG91
         nKpZq6NjXZCLAZnE2M9WvoW1k9v2wZfPgudFC3l2ugKXBHfR1hei4cekXlq3NZ2A2YOF
         ndHo2SC96OOZUS0sncIraSL7a03Std1q13hdTuFoyWXlmQ71AMPBYx5mubHz0sEDzIXy
         1XYFcxg5IwFtaoFJROarjpaLdQItUU1YXbR0ykVbIecDqJWfYyETJasKWgWjTNCpJG7m
         gTtA==
X-Gm-Message-State: AO0yUKXeu/04fSWW5dHoIpaQrPU83iuQQouJqRdeIcUZz6zfFua2ksBS
        72Gca+ubUjBjgbt/ntVktzY=
X-Google-Smtp-Source: AK7set8caNMFM8ZxDaaL67ZSIP4ulVMYEfysOtSt/1Lciwb+IbUD5p8JRlUy+A2D96xM9n+K3uqbMQ==
X-Received: by 2002:a05:6402:268e:b0:4ab:178f:e2fe with SMTP id w14-20020a056402268e00b004ab178fe2femr4989935edd.0.1677012766390;
        Tue, 21 Feb 2023 12:52:46 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906738400b008e40853a712sm496113ejl.97.2023.02.21.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:52:45 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:52:44 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8192e: Remove entries from struct
 rtl819x_ops start with .tx_enable
Message-ID: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
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

Remove unnecessary entries from rtl819x_ops and replace them with
function names when required. This increases readability of the code as
the reader does not always need to look up the corresponding function
name. One patch just removes dead code which increases also readability.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

This patch series requires the this patch series:
"[PATCH 00/11] staging: rtl8192e: Remove entries from struct rtl819x_ops
start with .get_eeprom_size"

Philipp Hortmann (7):
  staging: rtl8192e: Remove entry .tx_enable from struct rtl819x_ops
  staging: rtl8192e: Remove entry .interrupt_re.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .tx_check_stuc.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .rx_check_stuc.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove dead code from struct rtl819x_ops
  staging: rtl8192e: Remove entry .link_change from struct rtl819x_ops
  staging: rtl8192e: Remove entry .nic_type from struct rtl819x_ops

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 20 +++++---------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 12 ------------
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c  |  6 +++---
 3 files changed, 8 insertions(+), 30 deletions(-)

-- 
2.39.2

