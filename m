Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF90A6BF182
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCQTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCQTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:13:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878CACE22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er8so12527830edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679080395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKzOWshBPa05sAfciXrKvOW4wl1rl1vuNJiyeVc0GTM=;
        b=g62TFrehsNWj46XzWopy/vG91KbP9iseFu9asa7oEBELOPeEhPkTWdw1bNPo1Jj3KU
         ld2WGBlrCFpEcZghiSkrvH/IMlG+cdq3XdAI2eozvqqg2R0iv/2r2RP7zQABWqLHRaVh
         0/CUz4Awh+OK8d1Je9sBZvKSACUkqnCIJSqnr8fOhGM4MZ5ZFDOPzmRC8ki3yBTEZrxS
         4FRd5KK3lVICHBBSSYqZNFqxyaS8xl4g8on9sf/LvUrJ3shnTy4IJL+iw8VFPQEdtkl7
         Zx+AxM7X8PlBANtP4M2b8sgiWbWbNDKvsn/KLvjPd994U+KhDrP2XqqD6fDcc/8RF576
         4jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679080395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKzOWshBPa05sAfciXrKvOW4wl1rl1vuNJiyeVc0GTM=;
        b=q/E1cIcXD2ixLgE7K1aHnsEoVBeMgftCQ0UtSYiBQEr+l1/dukqUgxKFS7JjAoef7X
         6rLfOeMHWYwOYw5n4+kiZj6Hz6yrmRw31ZRfVheXJHBs99U8R2o/1ylcOr8jrDxrvVIe
         Gh/Hz4Vl5aCacHHVKn4oJKW+OvZFlrCuwhthmP+KvpWixjwRjo1TZuTREVzCJkayoB1Z
         uk2Q1P1pflGiy/Bd6n7gS8ebeWDtFJAoM5rXteHkIcldNbaM7+VewLX28elzLaVEzNFV
         Rwytfado0n89QxVG+C8bQzOA8DrsPOpYmN18Y1WgZWkYqsnsDIs05l3O5muADPxeetDi
         vjpA==
X-Gm-Message-State: AO0yUKU7lnTKKbdeWjJbTVDi6XR950AVQWyE3te4zepstJMFZ8rP/i3/
        30yD68NLcdi4yy2sHSe2tnw=
X-Google-Smtp-Source: AK7set/Z9+Om3DT9CgVQJbSu9C/o4KcLpjmlPrzxTsYMNEDJhB3lQ/AGLj1ie1bzM5ex5RHVuj5d6g==
X-Received: by 2002:a17:906:1016:b0:931:5145:c51d with SMTP id 22-20020a170906101600b009315145c51dmr4697756ejm.0.1679080395458;
        Fri, 17 Mar 2023 12:13:15 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm1280097ejc.197.2023.03.17.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:13:14 -0700 (PDT)
Date:   Fri, 17 Mar 2023 20:13:13 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] staging: rtl8192e: Remove unused variable
 rtl819XAGCTAB_Array
Message-ID: <0733800b195d4f63cce2ef2ac114943c8c30f587.1679077522.git.philipp.g.hortmann@gmail.com>
References: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679077522.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable rtl819XAGCTAB_Array.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 6723fcce8954..fd34756e450f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,8 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-extern u32 rtl819XAGCTAB_Array[];
-
 enum hw90_block {
 	HW90_BLOCK_MAC = 0,
 	HW90_BLOCK_PHY0 = 1,
-- 
2.39.2

