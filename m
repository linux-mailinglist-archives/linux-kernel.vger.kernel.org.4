Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947A6D7462
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjDEGaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDEGaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:30:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3CD30ED
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:30:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j13so32976604pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680676209;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0bB1kYFHG3GuFXYutZKTFfpB+QkP/nts/ZTV0mtgBE=;
        b=auOVV7VQXJSNoNNBvTbjiavaFkV3WknqhzofEtv2ACoEhbOL2uu30NVuIRhaYgGJKI
         jDrsP4r7IdfLvQ8uJ0R3ItpSxMtxZeNIU1GzRzur1iwpDXYopg1aLHnAF1QeJJvSkSeM
         kexTEI0yr8J9hEQJQJTMat1p2t8gUE5uhpxjeT/PVbFQ+DGqAeBAlOnfErzltzVFL2cy
         XCpBnQXigzs7t3HvnFUiTOYaTmbinNAO+FkXkJlMFWIzPeyoIYfZeoR4KFBMSQT96FBp
         8mY6495899c1m2rPn4Bq6Q/wEFmpnGLR9NCCGjsfuRNOgdEkmmIrsistArj7YCePbohQ
         wXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680676209;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0bB1kYFHG3GuFXYutZKTFfpB+QkP/nts/ZTV0mtgBE=;
        b=45bf61gElfBAk+BKTh7F/E+nnlDfPkEPgY15MEOHZ6DY+tlJVcWVXJWpzT8Ht88CoS
         aqvyfyD+czX//e94INDc2/2Vq46Nsk6ea0EVbTlHYdg9KPDkfvkeCwEU8sT7mUg+c8VZ
         4mhC86v8mY0ibjjtsxj0xUYjwyxyQ2de9fsR4ekG6aXxoEVRycWtpRQ8EAIedZsB4igy
         Qkxzvo1k4G9dP8E8DO+A1aWhfld/wgH82a3NIqcfoQ1hv70DOyVPiNFfxrN1P/Ykd2wK
         B7J6hE0KnEF0YqcYXaeSOkTOwKpDCOiuGkdDxdYmRQwpkLFOIj20Mdb6a/lCUQllRfjR
         HeWg==
X-Gm-Message-State: AAQBX9fX/LGzDQDuoiRo8vmur2vXrJqh4rT+gfnveAQWDFzUivd3hnjs
        MtHzdS+vRUnkztkGXtj7+24=
X-Google-Smtp-Source: AKy350ZynztHKjqCYj14bywgk6tbPxWzAGEesedIFyacNQtfSioA+6xNWQhzJCSPte+y4yJ5xc15SQ==
X-Received: by 2002:a17:903:11c6:b0:1a2:7afc:7cd with SMTP id q6-20020a17090311c600b001a27afc07cdmr6425985plh.22.1680676209470;
        Tue, 04 Apr 2023 23:30:09 -0700 (PDT)
Received: from sumitra.com ([117.199.165.210])
        by smtp.gmail.com with ESMTPSA id jf2-20020a170903268200b001a27e5ee634sm9369061plb.33.2023.04.04.23.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:30:08 -0700 (PDT)
Date:   Tue, 4 Apr 2023 23:30:03 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Add blank lines after declarations
Message-ID: <20230405063003.GA218972@sumitra.com>
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

Add blank lines after declarations to adhere to the Linux kernel
coding-style. Check reported by checkpatch.pl

"CHECK: Please use a blank line after function/struct/union/enum
declarations"

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 197c0a44ebd6..9f8f97776dd3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -971,6 +971,7 @@ static inline const char *eap_get_type(int type)
 	return ((u32)type >= ARRAY_SIZE(eap_types)) ? "Unknown" :
 		 eap_types[type];
 }
+
 static inline u8 Frame_QoSTID(u8 *buf)
 {
 	struct rtllib_hdr_3addr *hdr;
@@ -1203,6 +1204,7 @@ struct rx_reorder_entry {
 	u16			SeqNum;
 	struct rtllib_rxb *prxb;
 };
+
 enum fsync_state {
 	Default_Fsync,
 	HW_Fsync,
@@ -1329,6 +1331,7 @@ struct sw_cam_table {
 	u8				key_index;
 
 };
+
 #define   TOTAL_CAM_ENTRY				32
 struct rate_adaptive {
 	u8				rate_adaptive_disabled;
-- 
2.25.1

