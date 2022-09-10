Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5925B47D2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIJSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIJSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 14:02:54 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA83AE5E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 11:02:52 -0700 (PDT)
Received: from ipservice-092-217-076-063.092.217.pools.vodafone-ip.de ([92.217.76.63] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oX4oa-0000f7-QL; Sat, 10 Sep 2022 20:02:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] staging: r8188eu: remove rtw_set_scan_deny_timer_hdl
Date:   Sat, 10 Sep 2022 20:02:34 +0200
Message-Id: <20220910180236.489808-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220910180236.489808-1-martin@kaiser.cx>
References: <20220910180236.489808-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rtw_set_scan_deny_timer_hdl macro, it's not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_mlme.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 30fb9b7d7ad2..e000f0565458 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -539,7 +539,6 @@ void rtw_scan_timeout_handler(struct adapter *adapter);
  void rtw_dynamic_check_timer_handlder(struct adapter *adapter);
 #define rtw_is_scan_deny(adapter) false
 #define rtw_clear_scan_deny(adapter) do {} while (0)
-#define rtw_set_scan_deny_timer_hdl(adapter) do {} while (0)
 
 void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
 
-- 
2.30.2

