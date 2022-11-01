Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEE61520F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKATPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKATPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:15:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE90167F6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:15:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f27so39543477eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/oBXqxDLFWq3xQv029eFhBNmCMw5i5DAryxQ4apvwg=;
        b=OZv+ITK/ZUL27cndkP0A26xz4Q7jyC4NJwrQeMhoFL3e9xZ5ctFxL520vVXl2y+hS3
         jSQ6By4kG2U7FjQczlJmpsLLv7CsHs3bbqiJfmBQ4PCY7VLDCEMx7FFFm43UVGpG/49W
         3WMd48nfmsSB09LTfSabYekkuyr3LwVlyn5Z7Qqzest2+o0T4pzXeyVs5YacocWckmT3
         p/NYCy1ZhxAggbwp/qHj+ZK/97YXkBpp6gHU3gpeApNmor6B6/kaHJUtyueOUvYM4lQ2
         TwqrTo8zrMz289HvYWmaC65eI6fauNUSJcsb7cTykQVz6lFeCfsTuDx41lfyVqezPbj0
         s+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/oBXqxDLFWq3xQv029eFhBNmCMw5i5DAryxQ4apvwg=;
        b=hF+HRasF+hC/h7OCskmb1RP6E+ZXoGoCoc15WwAARKM4lNepxrGOU4sfFcROIBNRNu
         fiwmC2qDTIF6kUkK50cPBmzUj6gOUYsxwcGIcJFHRCq1pwNOFZcSawf9Fp0rzkuljbXx
         M6CCUepxnYEurGuf0WtNCoAbTR48+Zdn1UYrtyu+lUJw6/8V86UIiB/ZAMwbyF7FUfNK
         gXqJYwuA6tEg878DBpWZFFbaYk6Qy84tv1ArE9Hesqu6qp3eEFaD4/Ebma/6xrTBiPTU
         Yd+v8WO0ifD5kIFkKXXYaTu7PFVIce1FmT7CwpYLPISTZZzyqJTgE0MeC5EN7NXzYIsf
         6LnA==
X-Gm-Message-State: ACrzQf27f86/RYP6FXa2/4BMwlcS+Z9MJr46AqbAETdsJj6jXZKx1Rt3
        4EiGLP56SDYsVQNzs9XwoZU=
X-Google-Smtp-Source: AMsMyM4GO/oQ6X+UJVquAq+E2CgDpiAEIZAGsQH3VAdG+7fTqvJq9zzGBB7QDRashLoOud2lpcqHYg==
X-Received: by 2002:a17:906:5dda:b0:78d:ed96:2127 with SMTP id p26-20020a1709065dda00b0078ded962127mr19010501ejv.373.1667330104094;
        Tue, 01 Nov 2022 12:15:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb7a.dynamic.kabel-deutschland.de. [95.90.187.122])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b007ade5cc6e7asm1643853ejc.39.2022.11.01.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:15:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove extern from function prototypes
Date:   Tue,  1 Nov 2022 20:14:57 +0100
Message-Id: <20221101191458.8619-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221101191458.8619-1-straube.linux@gmail.com>
References: <20221101191458.8619-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declaring function prototypes extern is redundant and triggers
checkpatch warnings. Remove all extern from function prototypes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/osdep_service.h    |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  4 ++--
 drivers/staging/r8188eu/include/sta_info.h     | 18 +++++++++---------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index ec2631455f08..f8ed04f32cae 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -66,7 +66,7 @@ static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
 		netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 3));
 }
 
-extern int RTW_STATUS_CODE(int error_code);
+int RTW_STATUS_CODE(int error_code);
 
 void *rtw_malloc2d(int h, int w, int size);
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index ce5b57e23e53..e234a3b9af6f 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -388,7 +388,7 @@ struct mlme_ext_priv {
 void init_mlme_ext_priv(struct adapter *adapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
-extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
+struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
 unsigned char networktype_to_raid(unsigned char network_type);
 u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int len);
@@ -483,7 +483,7 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *addr,
 			  int cam_idx);
 
 void beacon_timing_control(struct adapter *padapter);
-extern u8 set_tx_beacon_cmd(struct adapter *padapter);
+u8 set_tx_beacon_cmd(struct adapter *padapter);
 unsigned int setup_beacon_frame(struct adapter *padapter,
 				unsigned char *beacon_frame);
 void update_mgnt_tx_rate(struct adapter *padapter, u8 rate);
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index f76e086b5701..55ea5edc2914 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -295,19 +295,19 @@ static inline u32 wifi_mac_hash(u8 *mac)
 	return x;
 }
 
-extern int _rtw_init_sta_priv(struct sta_priv *pstapriv);
-extern void _rtw_free_sta_priv(struct sta_priv *pstapriv);
+int _rtw_init_sta_priv(struct sta_priv *pstapriv);
+void _rtw_free_sta_priv(struct sta_priv *pstapriv);
 
 #define stainfo_offset_valid(offset) (offset < NUM_STA && offset >= 0)
 int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta);
 struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int off);
 
-extern struct sta_info *rtw_alloc_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
-extern u32	rtw_free_stainfo(struct adapter *adapt, struct sta_info *psta);
-extern void rtw_free_all_stainfo(struct adapter *adapt);
-extern struct sta_info *rtw_get_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
-extern u32 rtw_init_bcmc_stainfo(struct adapter *adapt);
-extern struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter);
-extern u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr);
+struct sta_info *rtw_alloc_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
+u32	rtw_free_stainfo(struct adapter *adapt, struct sta_info *psta);
+void rtw_free_all_stainfo(struct adapter *adapt);
+struct sta_info *rtw_get_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
+u32 rtw_init_bcmc_stainfo(struct adapter *adapt);
+struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter);
+u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr);
 
 #endif /* _STA_INFO_H_ */
-- 
2.38.0

