Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABC675DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjATTL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjATTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:11:26 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B95DBCB;
        Fri, 20 Jan 2023 11:11:25 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id p185so5252093oif.2;
        Fri, 20 Jan 2023 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BFyYTpVG5ZzCzfnTs8oNkGAEsfN9nPz+uDFLXCK3bOc=;
        b=Ztw6p5ICi2lkwk8EqwAPw3IqQfXkqMLi7SBoOL1bqe8ExOT/EUCaUmLjxV3oPBf4yY
         3FNRQEnf3v+ILni/t00bpVIOe+kXTAzEDqZKOVRQrzNNlaiDzcCtWazBZ42hlzH/Xpn2
         MxTQr7zrtOgFN7yuR283M6S33WxgpVGggsdSvspaAYjemSUBozC9Crfg+MRkBI6xKCbJ
         +E90pozRoRwAr6CWiPMp8WgFowZMjqEJyvNwjArvdgYACf/sEtEEIBwq58397t1VbtPd
         6uMMBFrYnNsepKWCFajpnQfEkk8k/D11hzsT8RP2pt5l0lxvPeBNob+LADz81R35e8BE
         S21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFyYTpVG5ZzCzfnTs8oNkGAEsfN9nPz+uDFLXCK3bOc=;
        b=DSsNwT/cSHm74I/fOi0+7VCpcJ2zy2gt7nKlFw29ui1+06SKnna3ZR2tIi0T9k5GIM
         EnMbzcqC7zzH07uthjQE0EGUsnGCXwYjZZ0T96SN5S60LZRuidQs76+5wpNcTUak/+Br
         6YXmiWqM4Ug/z3IMvv8nd1GDTXcXU5l7kyBl1mEVGs0/ZLoUbi06ztB9uUs8AAFVucfQ
         CbGpXVTu9QI32kTlMxR5loaHcFwewoY0xt0I/iYw07zprp2JveQLEXr4CDBVa2lQBnGm
         B5OENUZ4exOCogt3SSyr6152kwywdD9hBJEgJH0jF4bNqZ+uG3SiQtFZantxnEOD4Jxe
         5+Nw==
X-Gm-Message-State: AFqh2kpyFXi5kqMxSjv+EnyxRlnWykron2ZplneOeesoGWewtkEsh8Uq
        RTjI4e/6SECpcHfIEce1xOqfgpg4gcg=
X-Google-Smtp-Source: AMrXdXtXTrCPMZlTu+cC+8XlgcCVVJtyBbU5CtrCwyWsvX0/7hB7Rmtd51lEkRZkJOuLQ+8i+4g/Sg==
X-Received: by 2002:a05:6808:3b0:b0:35e:2b7f:daa6 with SMTP id n16-20020a05680803b000b0035e2b7fdaa6mr6789297oie.28.1674241884248;
        Fri, 20 Jan 2023 11:11:24 -0800 (PST)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id c6-20020aca1c06000000b0035763a9a36csm3684463oic.44.2023.01.20.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:11:23 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: [PATCH V2] staging: r8188eu: Fix some endian problems
Date:   Fri, 20 Jan 2023 13:11:19 -0600
Message-Id: <20230120191119.13163-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse lists the following warnings:

  CHECK   drivers/staging/r8188eu/core/rtw_mlme.c
drivers/staging/r8188eu/core/rtw_mlme.c:1197:49: warning: incorrect type in
					 argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    expected restricted
					 __le16 [usertype] mstatus_rpt
drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    got unsigned short
					 [assigned] [usertype] media_status_rpt
drivers/staging/r8188eu/core/rtw_mlme.c:1275:57: warning: incorrect type in
					 argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    expected restricted
					 __le16 [usertype] mstatus_rpt
drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    got unsigned short
					 [assigned] [usertype] media_status
  CHECK   drivers/staging/r8188eu/core/rtw_mlme_ext.c
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58: warning: incorrect type
					 in argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    expected restricted
					 __le16 [usertype] mstatus_rpt
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    got unsigned short
					 [assigned] [usertype] media_status

The second argument of rtl8188e_set_FwMediaStatus_cmd() needs to be in CPU
order, not little-endian; however, when it uses that value to call
FillH2CCmd_88E() the parameter must be in little-endian order as that
value will be sent to the firmware. Note that the conversion from LE to CPU
order was le16_to_cpu() rather than the correct cpu_to_le16.

The definition of FillH2CCmd_88E() is revised, and the proper conversion
routine is used.

Note that the original code performed one byte swap on the secong argument
of FillH2CCmd_88E(), and got the correct answer even though the semantics
were very wrong.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
Reviewed-by: Dan Carpenter <error27@gmail.com>
Reported-by: Gaurav Pathak <gauravpathak129@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v1 -> v2: Fixed typo in the Reported line.
---
Greg,

I intended this patch as an example for Gaurav, but as it has not been
resubmitted, I am sending it to you. If you thing he deserves to be the
author, then please edit the patch before applying. Thanks, Larry
---

 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 4 ++--
 drivers/staging/r8188eu/include/rtl8188e_cmd.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 8310d7f53982..788904d4655c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -193,9 +193,9 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 
 }
 
-void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
+void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, u16 mstatus_rpt)
 {
-	u16 mst_rpt = le16_to_cpu(mstatus_rpt);
+	__le16 mst_rpt = cpu_to_le16(mstatus_rpt);
 
 	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
index 1e01c1662f9a..c785cf8ed683 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -85,6 +85,6 @@ void rtl8188e_Add_RateATid(struct adapter *padapter, u32 bitmap, u8 arg,
 void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state);
 
 void CheckFwRsvdPageContent(struct adapter *adapt);
-void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt);
+void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, u16 mstatus_rpt);
 
 #endif/* __RTL8188E_CMD_H__ */
-- 
2.39.0

