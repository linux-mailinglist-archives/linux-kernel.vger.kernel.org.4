Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286535ECE05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiI0UL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiI0ULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:11:35 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E33AB30
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309450; bh=rYxxCr1vY4SS1ZjcTEiLgKsS7D/yNtgX53qXB2wQNf4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r6NEBmSelYdXqWHpNna0y3jPLZUR474cRsEx92IGBZ99KcwkeEymTRq6r2RVzxdENRSWEfm95VZ2HozTA0NYPBnZe6upWD9xJPjjVofE+aC+D0zenzs03XqM2XrAFUTK0wdAjrS+BvpuRwBPJwP9GIS4a2bPcHjZmz6iIBPQ1N9Tam5yJfsM4pmY2MqDJieoSSbQcj+fHDbgAap/tVTDfqtNDuK3GHk3/goWnHfXU1b5hVTQbN3dTOlEL/g500TqJZv1dNSxG83pae84LwSSXglDJ9fQgFi6rTWglHszvN8BeI+VcQEiFndT7yMmU/BS/9KdhfPzMFeu6KY+Rfbygg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309450; bh=Pm78uT9GOCBV/z8p/R0bTSuyKxTpmx6NZc1YqKL+qrm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FlX25q0yk+u5QLzXqlpB5jE9/pFfL/8XM/+rCZzsz2GBdD2KfYUwm0g2crqv4F8my2dqI4AHasU6+WUClxyFw894Jpevqn5JZx+L/6kP9Vuq4tIXIFTp99UJ+HNvF+YeYeXRWxTUKD403K2K5UCz0WUCHmqzb5awJ3cpP1q04V9CIHN2usuRK6XWbdjA7uL8i+QElZXPHaWq9EwGjgf4MjQWbqlDY9/y/cgsuszuyne2pqX0okb7EXRWmes/kUY1BfvDk2DH19XKSyc+XqYO6fPZNRHzqKjnQMgtO+BMGZycE/exnEvPnimSIYvMO+J2R0A1rkJTJrtzjy4iu2SqFQ==
X-YMail-OSG: H8mhBNUVM1lTvWe4r3SvyNsoU1BebnK8RaDhI96IPcxJQuWqz37MOitw0oxocmP
 e6hbrbAC_jZna61CsFeOavOPI5.Nd1pV.v9zKyUW6QKZhfOF6HHxxO0Ckq7CE7MYyHKmkjC0Hsw2
 YQZtJhvsaVtfysq7rNJKuVHqmwfgC.RiLvpuFXxSyvkAFxg5KY.uKcmpe8bQAGyDdTZGH_1aeo3g
 .F.AXojkw5quiihBdEdLck9yvowXgBQceh3sKlsDvp8r8ZgmzwId_nWixfF9b0icLqRYPc6md_xn
 VNieAYfyo.OWHsF5NnSelDXJR84dE_zRRukfm0J2R5bEucugy5gufmCQiwXxdKFIvjFXvpg4bQLq
 1zdRQXK78uLYOP78hQPrwbXd3S0uJ5uE9D7EVUJQOBkLazkpTC5JscfJAN6vcWeUl487Fzk0eXeZ
 b46.FTm1HJJhHYn9twcu9s4AS17SnKy7PilcqC._8oWMk6Le3so1TzoWW2YmdCBlNsp6qDZmyug4
 Dx4rvb9W8WNDz4Iycf5pAUPRMp1SIai8pBGHHML76GkHCuWXYmCu8IaRPKwiQFwkNvtBJYqutx3Y
 Yi0.uzGGpclotN_y9HBEAK.5hKhVIrUh65rdH.SoKHDdiOKUiBlQUOd.PxSuDKIqzW0oz96DpJpN
 b1AfP97NtuO2pacNMoueRHpYSjEWjh4oD_p38c4uykwgaJFK_o6ExfEndDUTDd8LI8ESL43cTzxq
 ElGbRINbczYlOzy8pEFdRIbp6i8HxQTYsxvJjRGXgUpsienDsTDx5xr.SH_seBe.bap9rnFfkpEt
 RGdh_kM7RtueBuaeffcuMuBZbLYRWF0YkjgX993XqH159n1Bvy9xeRjOQqkDAfMqYb.JALHo0DoP
 p0Q4Qz4QBSqdxWXDwV5R9grYEbeRl1dEQm0oFbzpfx6ets1FxooMsanLAddbPahqumCUKxdrXwCB
 BFRfKvB0FKbyFG2u0DIvq3GfacCUCoc0GvOAukRIzk_6daIHiANKEiE0rWmT5CV7CN5Wifkg9e2d
 62gwU5DtZHrfKG_nKy3N7rp4cb0eFOlPzexbMEE8fCIdg6gn_JGxzf.B41RvUvJ513s3KzsoDkv9
 BcMng4mAduDSYvDOym45C8Q3lZQ6KehtRGXggG5PXFxc3pc7HFeG_OQ9HXsADtLunBHYSE82EmdX
 AkL_embOUypl7wArD4MtHe45pbU8V6gH4h0xDCTkzl5QXZGXl7LXQmyI9yY_gOWORzqeOTwsfJDx
 9UFPwg_h929iGOtUI1ZNrRatcTUfX3CFrqQ.R4E5AnkZGzUalPXsYV0BtfQizN5u1_6g7WAzQCR5
 ed_lwf3sAFkpKZiuWBMr7IzLuXjlXrvBnEnUQ2RCNGT6vGKbEy5nV7LGumXXTP7_SdY.tfq1lq1G
 gi78Lb4IWNWmJSLevVHkt.EwKTRcjOGnJRVp0FdKBv0xOHvVZoZHOipNvp2spCqfhCFHD7pl5ZTo
 JF78QUfB1_NbNadNW6L2DTaI5mYoyZqI69VqI2qYod4gR2llhbl3AygwCs9a85Iq9kyV4ZX4yYO5
 HzjcvwNumXHF93v9nMndax00azk3bbsfTAmdbMI6p6NsGccERS76W256VIWBOT85EeMGioDBMApP
 saA98ScQMcVk3zUtrPApQKgrFcj6sL0JUSdXhtyCJ3YoIFcVyT6.mMVOv3_gGhNBAXTh95od.isw
 Me9Gyan_OX6ZKWXtnSxfzHSxoLIMLBj4edIuouYd4Cs7yLrA84GivYksKA6UvWXTTYmqSWhgun8d
 jSPUhY488l.hwDiBpQNHy0emgQiBzCR1iNlrRjBevbqxA_ERRZ66Vc6qLgqvjC_nzSKwO_6SBHN9
 ocvBSPkorV4jiX2GyyjEkzSDO1Is8LSDtoaeY2625JkxlR9IOdacEa17ydt7Ky2EJihu._3auH.d
 iVDZ9CFTmF4wpjsLgWPb_W2C.7zwBKqTXPcpAU4Cf_Ti8fbS5EZ4qyNLw5YheJh7iq_ixJPcCcim
 CnY0hJpCh5UmEDvINyIbro5LiQM7XSk2c06f7GwaVpSjBVst_W.to1eE7JgLhd7GrBxfYecJ49Ic
 dGkLsEWz8krDlaFBqdLJcxZQ4StyRjUBpb7Vvww1IqpOJIKbBEfbP8A3lbUurBdsPwSo1EKaw8ki
 sTteO1guSVv_rBJv56Hz47Kw61OK3PhXytihZv6K9ac4v9Qa9kZq16Hozfxu2BsEZ02MBZtY0Ewm
 32fZC.COspaDjBBYWVWvw_pTXLT6jcL._n5N1V4QsCUMibAwYYZaJTCE1X0lHOc7.3iGlywbPzxx
 5tEEvm5T.uc5wwCk57LRhmrsqSXU9m2mdFbPOZ.M-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:10:50 +0000
Received: by hermes--production-gq1-7dfd88c84d-nvfk6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55a7229bea084bb6b28fa3beefd2f4cd;
          Tue, 27 Sep 2022 20:10:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 31/39] LSM: Add a function to report multiple LSMs
Date:   Tue, 27 Sep 2022 12:54:13 -0700
Message-Id: <20220927195421.14713-32-casey@schaufler-ca.com>
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

Add a new boolean function lsm_multiple_contexts() to
identify when multiple security modules provide security
context strings.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/security.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 170b303e9122..c190b9189287 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -262,6 +262,15 @@ static inline const char *lsm_slot_to_name(int slot)
 }
 #endif
 
+static inline bool lsm_multiple_contexts(void)
+{
+#ifdef CONFIG_SECURITY
+	return lsm_slot_to_name(1) != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * lsmblob_value - find the first non-zero value in an lsmblob structure.
  * @blob: Pointer to the data
-- 
2.37.3

