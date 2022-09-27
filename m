Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A995ECE28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiI0UO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiI0UOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:14:10 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5011EC1C2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309646; bh=pyVdgpytY464Wwac1wj/JuFEtrZAsdpLfTn1Ux1Va7c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZE05lJwW5SIZZSP6A3K45xP+KXwC2U+itygbuPi3VcES1eqS45DMbchmVohy7eaieQNm8VU8Po821VplWTy00IHQu2HU20JNqQ6Zc4Hz4EK8+tvo2CyrHFbGjWxm08+1gRncLLkxvviMZ82SmJrjd6JaruBGOHhZchIXFf7ggChwTn7Uu4DYNtj3y9PLQGTw1KCUMIdpWZe5VMTIRCFg1BALD+WBxshW1Zumpot8zl6H3Kzu/0Vih/6zG/S5VGEZdddQ5Xi7Qo2v8nA4mvPak4eHcY4xiJjeKskgyBofKHf+L3TeH+rism2oolI+VtH/XfBB7Tnka77nspQHQUjNGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309646; bh=eeFCjkCXqLM2LATQYYTIdyEAeEA7gIccLl/7eHQRyik=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hUPZDbuMncWQD5jn3bklChMSaM+vdOmDk3IeuksoedQzFTe6M+E8/cF+FbW00LT14+CCQTj/kfBgfc85bplsfR991kaSIgSFN4bWDM1aCgnnO+DKG74vd7vi1ObN0ko2VoAbpFoZpGrULsEY8qcQLFreU/BGVnj+ZGEjk1F+thdxcZs+LX0NQhd2y/8ga2Gd+ZNRp/AizeMy+yqtbDrLv50x4MRvOgNPj6AaO+9kuuUTXgmgNwLmXK/xRb9pj73qw3B7VSBSj7N1Zfef7BwsLWurO61mNUUXdEy/QVYMG2GsPRsSJqN9UK36/EmFVIkv5b7JyJLxONKrexulhi2x3Q==
X-YMail-OSG: xKwM1XMVM1mvm3mTPp958fYdRWQATey1DJdhfnAM9S3Ne1W5Cki.Ltfd5k3mctN
 AgwV8jfKha6pLcx.XgrW2iyrRv0q.0fxISZxL.TZLHsnPYOoOeNvcF9Fivn_E_Y1gNkhHrGEymsA
 93lYjjjJIJxPmswan76ZnzegBihMVpu35uiW795WpqIjlc7365zy0A02uT5RQHKPv8lz31sidPgs
 dCuMv__Rq3M_0MdWhPwPjNAugeFg4QRGul.7HR3j6jrHF830Lqbntk1y8c5v93HH0FPP2GWCAUpO
 YkxtEj9zAHkfCHV0Nj0JceRZ5XD3Is0Q7PBvOkJttv1ucyeviy7KUN7U5RKs9xvMIw_xOTVDvZ8u
 4dd70Ec3wg1z_WHkPwuJFyt2L9murSPW6MOGVjmHpSqPlRlAyI3QBIoL8tfN6uH9LYNE6_ZfV0gL
 4DeGYI.yFtX6NUMbJWbRO8C.ZroMFILpoWDdZ9Tx.i4TfSxxQOu_hM5iuP8sAbDmUNhOM7nKYWkW
 PmxWxYJbCHWtpebgx8UY0DZ84CWx3GnrPFRgPEBy4orp2ycRsKZwe1jnRGy4j7nGEF23lx0_pIfq
 4WWDEodKG_zAXpgVpFIpiqaWnc1Q.R6HgMkY1drN78gt7Tdjgh.biLz4iwoF3pRt5aUmhNlNkmWr
 SJ5ojkO13mDAAy40sE7x5Lwmr6u_p_JnTxzCiv4lp8pOTDnPi4SEABerGa_ZUtXzZcMMSexiQU.K
 hXV3kZgGk5MpBPV57xtRz2sy6h3GGe2rb4nyCpXWfSuA_hBDItLc9xI60g5dCiTr0Yo7iqqIWouu
 Be2TIzEPKX3KyhoeNvunQbostKBsTq7HF3PofoaBt_fUdxOc1S2kwl2bJPRgkRyNcGwU7Pb3.84r
 U5uYIMGYcSdR0hZPaYOdacKwvQlUVso0cwC1ajdk7JuiPayeHXNDabJ9GCK42Bh9IonUhq2elpUh
 4Tls1t6E0mL2BAgetKFSIgoQhE0S_vl7EHbabzBigAbLB.4zludxv_47V4HAEKXOwHh4cqYA3BWh
 UcpnWeH.IiI70ayDVLd9v2Y201gsGUq0DII7OcfRd4gPzi4iczUrhPax_srsDUnQK7d3dneMePT1
 5D9rzvgrH8Lf1oc0hcs8zbSciSSQj1VrIGAN53g0nbx8YJAqmcJsQDDa4v5IKfGmuv_5sbRuTLL4
 76ZcfV0zPwgcwJaKa05kd8Ii1UD6us3CYLbwPQlRMP55jpsFve3Cdd5xcyt_S1Y8hv38.596zDR6
 2CWvGummUUtSgNt2BgVCbW6ueUWM9oKwHLmO_2C_XCw8QR_g6G0e7hTsbdcJh8vhjsHngLnUQ0Am
 GokFa3ucNLvbfQx.tZFfyuDEkDlFxfNUosNH05IwaAwNmcl8ofiQ2Qd39CB77Nw34uZf4s2HcmCP
 udFhsHxEHgvX6QSp.9Z8U05BB1eDKuM4xHS9kKfAtxNVa0uzYkpRZIiES9c9uC3FpITYnLrhcuXP
 zPdvtbFSstnABRFPIc3J.VlGQp0aPJ644rvf.UhUmubnml25V2M_5j5_S13jwrOwqLHEe3kIfszN
 .kXE5CJ_vHL_AIKwnZAaGvjdzE7aTOOprKJN2Hhv07fl89i4wFRnsu3xB4K5ezKyOpphnOgabO.4
 eV.5znkC1ZPyTnA49LWaKZnA7h8SoMzJuEFVx4tV15ohjxENxHhN1.SJ8RSsLFX.fccNVLtgh3HG
 sIiDSad5Pel_y.rEqOu_5fk6WYEd4JhWHfK61kMSBcnKlmqKoDbrYzCqlQM9FGBihG2gpFM3h8JW
 xGCPQuxms.GxJUcgFSH5sUaoTn2DkVc3LAEd8stEj9xHt_wgPbTA1DrtH1m3dSiXSledhHp4UfsS
 Asp7VcpWGXLocZs6E3KiOpeqQoiQd6Rbhi48TMDACHwxGDp3qBMEWC0muP0o5yCfO5XL47AY31Et
 Q5h1Cjq1AIy9cg6d9dBVpbccflbO.Hhx_D2zoWU5CWdujqBIK8fJgssnFyrXl_kAozPSK3RDkPOq
 mnzQso6aYV3JAN_624c6r1qHPfTnqk0RIU0fBoCAET_K94ioWgtvkN6WNChWfN4gg5EQ9Lix3AXv
 lHBjmvAn3Nc09jzsa2pWd2k84kpqNt10nS6uOdhPEwFCi3y0jVgbPYleQhwz1ss3XTu938YWp4Xa
 iGxRE3JqK1s897gXb8cEv.uTvLrlqZ6QOHsw88HerbE_1uaCzPKdpA92R.QG0b.nwspZQtiMRxiI
 wbQAwwwJ1LagmbA7fEqWxBGuwSrCaUQ0Ka7OK7GvT2WRoSmSL6Gsj5XRXpQo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:14:06 +0000
Received: by hermes--production-gq1-7dfd88c84d-65ptt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 395ac973b3706d14ddbf652d9544c668;
          Tue, 27 Sep 2022 20:14:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 37/39] LSM: Removed scaffolding function lsmcontext_init
Date:   Tue, 27 Sep 2022 12:54:19 -0700
Message-Id: <20220927195421.14713-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scaffolding function lsmcontext_init() is no longer used.
Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c190b9189287..f6a247033556 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -166,25 +166,6 @@ struct lsmcontext {
 	int	slot;		/* Identifies the module */
 };
 
-/**
- * lsmcontext_init - initialize an lsmcontext structure.
- * @cp: Pointer to the context to initialize
- * @context: Initial context, or NULL
- * @size: Size of context, or 0
- * @slot: Which LSM provided the context
- *
- * Fill in the lsmcontext from the provided information.
- * This is a scaffolding function that will be removed when
- * lsmcontext integration is complete.
- */
-static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
-				   u32 size, int slot)
-{
-	cp->slot = slot;
-	cp->context = context;
-	cp->len = size;
-}
-
 /*
  * Data exported by the security modules
  *
-- 
2.37.3

