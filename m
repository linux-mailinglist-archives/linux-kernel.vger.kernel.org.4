Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A95ECE29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiI0UPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiI0UOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:14:14 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3A1EAD73
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309651; bh=679JJeCWRl08iYpbPXnnSN3ttJ/KDmIiDeSJeelJiow=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WYtfXFWIM82h6KHPBYUOPw+f53z6MqAiK/X8Yf4VoFeK+cUWcjvylz5YRy8x28Z0RHDRltPBSHCJOji1rrkINTvb0RTtOMEQ1dvkCjiPi9Ip5JZCHEhouShp+uOC2KbF4bvWtaUokO8fEAfktpqoHUoOFPzEI0mICDWMmmNRWuCoutCDTwXJKTqtezt9tgWOzRdUyE+0QlS/PkqOPvk4ILHorvk/4Rx6JHKJ1CnznFztVwmMaIyh0rNSCXelevM0H1vYsam5Gx0D/duoPzWbNrlgxZUi+Bpm8asJYlhdVJQUdJa1jShuXBlzVPYM1CEkbwGdEa4LxK7oWIRUcZ2ZTA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664309651; bh=+8ohEcMls+wtK4Yy6rdUGFCUpXdLAWwUUIIhQpKrGqt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=g0hBr2ix4bP9vaKBJA3j8zAf+/AAlO5cOXbqtM+h4QLueHW2KOHuywDlRF54KW+iRy60u8X/phYLVNTYQsPMPpqoFoOJDGVjUwj/QAdd4syonIThoAcOxPVWzkykX5XkpMFQQ5WzzA+o6orbOtUTZUUapDLo/GHXLHVk1E25ukyovtobnu0uan6Kr5mXSRa7FbUuyxcHPDF/azuHmA9P6d4pLrbMsi6x3aWW3seTkl9vV8GU6/GemFBVzm5I9DyohoTmUGeKK7wxPseKhq11Q3vBzzbLPdpN1NT5JfksuUJSqavh6SO4UweZV/rOq74Twk4Ac0knTczwhweCFTqbhg==
X-YMail-OSG: D93IfIsVM1mKDwmH5sDPe_DoR1M.QM2jMmOBnb5BdsuWh7gd.crNxrkGivuNGUH
 P3HBfc4Qep8E.knDCnbSHzDY3wVx547vwVnL1BRCY6TTLWKM9LWoyBPA9G9jNfHJ_d51r_CvubgR
 3QRELIzDoqKF.cfgnJ3XOHApzFvIAynVK3n714C0_eNeH5lVB7zEbEPkwsH8sgLSU30vQKB_lMJb
 FI.zuRSH.PUQy95ODejHz9D40FQdX5wpgu.NpyLCFt_qUBdJuiIkGrdi5hZv5euonEQF8erK3P12
 yQvZuYyAqkmEl2__8BKQwC1es5O5TsvI.tTRNNuqIvpjF5GcdZfcbvxPVCaU0RVNwMSwrWG2Ho8j
 3Qtfsgc8lkaeomhJ7B7QA0kjDVaZITCGUAz4oGPKZjcIXhvxHQDmY5g0PRBzCXPmCnVeXw3oVOCt
 IuJTjCfIJZ3CTnZGVn0K7W8CfQkdB1URtCMeDxhWiLtFvujVoRZG5KK_U02kDZGERzgKA31i.t5E
 jW1oveGTNtYMdeY8IhLdHVumG0S.w5EuVWqtaQB_F87w6vMAVOREHwNEciRGa8DpJWz4IaH41kjR
 fj1vl.AFqk0Zkmze7pYEkF4ymOQCiFjvESYhDbo7zLB4KbcNQg6Xj9DqpXL.r1LQWa4mCj0ZINzq
 C4BqFaLzkxRq8JMS.Bfgp0U5UBcKzEdwOLNwJjc4MwQ9Sopfj9igzPYBwROkGp3DG6pql1xd2hbo
 5oAAwql8gZ6UeVgTP8lh9Wg7YBBER6j0fSBF1rFUGLFWJNQZepnI6AU0D9LAuvE5j3nJ7p0GXQb0
 INsCkIwlUzuF4c1J5Qi_ISYVWKCTeBIyQvACtU1iAh.JGRYezr.HieM4.T0_w1JuwNyoN3NeLXAP
 KISsSn3DDp72a5y1XOz6xvIURScsflTgxk2akEcUh5bGIX0GmUKQp6SbZeKTisVMJjZjiHw77qsM
 EqKWPsIAdT9zDLp6nfmTXWp8UfkBAaNjj6YFvbBk7DsVFJT_gDmuLaVGfMHg8j8sZ15Yl.INCWT1
 gHnRwrZfGOiiIwUgNqze4M1Zw5ov6vJ5RzXmAwHiB7AlgyGE4RuYqYctPwW6boGF8YSRg.CVGgEC
 8TYIHxsf_ZPuAdMnmrR6Ex3IyJqmobBCxHv8_FhH20HXgTjTqjvnVVywQS70xB9v.Y.vhPbyEjXk
 2UfsC0GxFK_2zdxEMmJYIsjyeuUkWJVE4PErHrUobosozos0ZCpNur.0t7vC5wE3y._7pEI24KCZ
 wNIquLMQ2of9iMUqTHv0Jeck0yqXjoHkMjlXTmGVMSQxCZSZUhJByV_bWpB1sS6GEKY7qkcuEHrp
 I7YtAh5wJrT9kqc9wQxux7ed8xm_BTF6w3gozDZRERG9qdbHCo9.qGkm3jeLcPqPqtaGxEhtOy7V
 Kbs9JlCFaZ0O7vbqWTTPsM2VBYxcaNFNrPA3gd3Bhufd0S9Rh1pOJ5F8g.M9nYgVZ2i5lp3QAhGc
 drdOeQdY.57FfJ0ncV0eIyWC7TaefEXJYKpV6vs0J6zkpI.hpu.jzTjHTEZxdWeLA2Q2MPPX0g4H
 YNu5m84ETxqq9hxIt8sQyld7cgN3Y9NJ8LCJLg7JACP9r_4zHYVNac8BbMzcF6qukps5vH6fLL6Y
 Py.0KbUDESoSXrz4_UEG01fzoRJjc82gJ8Tgz10bZ3dZ6Zurqell5DC2EbHk4yiv8bezzM_5e0Rc
 9UtrMTpzsSI_pB9lNIOlum5Ocm.JcwQqXXYiNZa2tAP8V4IykmrnJFWrXrdISHoa0jnutXr.jbpU
 qIdL1tvc4FTFny61Z3BfSmzICgrgUldL2tvQunZVtg8H76BErglhTFkiigU3Jr116mSSzn8G2zeE
 bBIWLFIduB5T4_tcj2KY9OvkEoaf8BERwetTx6hHNJDIjGmENLyma1bGMnASz0wZ1.PYqspqLXfz
 bS88rh0tAm2Mal3CmvmVcwvwiSTL.HE1bV8Px.kwTqCCuzi2U7_tnG6A1H766sk9sIDzGdOpuY6Y
 4YT_y3KFTIRYPr60MDoEnM8qseTKceS_qcR.eYmXAea8kZKyBxehG0ZS3vat06zerdkK7Crd_sen
 FLSaOnMEYM_HZAY024fK16jU1nPyEYknDSRmrl.8gB0.k3oViwPxiW6jYMRQbeVNASaxYhZXZ19e
 iC_kwy6ULdHNSl4eb0.alVF0EjgnMJdr7vdrhn_wok4upUzIxals.PCQQQGNNABDTu_KAlKnYKnX
 1kraAC7G90O6iW0GpAsofXRCqu0pqrkQCkp5.KWUAuGo_6Ayclo.52t65zngyfttOArCxeBvI0IL
 VOJLbYRSH.PyMCtCikTtLB5gZTpCX6rA9VVhuabY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:14:11 +0000
Received: by hermes--production-gq1-7dfd88c84d-65ptt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 395ac973b3706d14ddbf652d9544c668;
          Tue, 27 Sep 2022 20:14:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com, jmorris@namei.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v38 38/39] AppArmor: Remove the exclusive flag
Date:   Tue, 27 Sep 2022 12:54:20 -0700
Message-Id: <20220927195421.14713-39-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195421.14713-1-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the inclusion of the interface LSM process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f47134da6723..284f74ba9af7 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1168,22 +1168,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1290,8 +1274,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1954,7 +1936,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.37.3

