Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E667FF50
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjA2NOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjA2NOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:14:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E6BBB9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1674998083; bh=/14ZPfJMabfXZtz/YCRdcrIUN5mBNRyQkPceGaXBkCQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ktv3waJMgdQlz7+K8gZQxatfsvumn6AFRCfOTfTXY6173i39NtX6HtUswdoaM/rVd
         dky3PCMSSqyy0Y5vILge/suqXyWJdi08B5sSiCtxGQZA/7yV7w6S6av4wLCXruCHk+
         4N9NwosGe5VBaEtl9G2010jvSZp3mU6DRJboQC+FrNKLbNQZauWhNyYfkH4anUxO3L
         hLUIRzF7N5DpOoELxLiXsq5ckZzW5W0xe/I8SR31yYnFP2oo2uKzvndcriALqQJOAH
         NqNVZpBarIkp/9Tr5qWt96JmqBxapUGMwL1gb33Jilh62ufvxgHQRGX6dZB1gB0wsc
         gIlZ8UjVFoDOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1oeisf2SEg-013aRf; Sun, 29
 Jan 2023 14:14:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Nick Terrell <terrelln@fb.com>
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] zstd: Fix definition of assert()
Date:   Sun, 29 Jan 2023 14:14:36 +0100
Message-Id: <20230129131436.1343228-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/ZAhSq3caiLIgUhjFdsZBwOlh3xV1QguoIGzAM0QAzQfmz5eu2b
 liuakIcSNihFPC4jakk4RDFlzhrk3exJSz3ODE7BiMzJ7hU6kApgupUGJRY4RzS9zD7d5oE
 7dcvoeh98p8cG69kII8ZCiuaxbP8lghLFSvVBXph73aE3lc2Kwl9Twa5LOLfpIkr3HayMD9
 S/UwUkNLJCJWxV1Drl73g==
UI-OutboundReport: notjunk:1;M01:P0:mKS/UhlDEqQ=;eXIwsdWomTgZ67eV+NRM5kD2gP2
 39d5Z+qALhHIetnic7zWyqWLaFHytUDKyVXt7kJX903yXZQNBBszB+NyGTzO3J8zVa3oyEP1a
 72oH7G5SwP6aR+a6jBVi3OOmMLBPDR+pnfoFOzVNyofmGMZlN7Q6FaN0u1Cohs1avVorO7H/o
 t4CXJMO4VY9iYB5OsQi8h1L8K8ELcIaTHl2ymWPgNsNeY00VZIA6ffIK/5Y+LNxxN4Mp0cAZ2
 HNE+EXapWj7FcHjUMO3E4BzddeS4T2gstm34AGsuTe062Uz4q9yJpUdwbu1823UESBE5Pptp7
 4WhkdctZ/KGgqtUm4ZO2B+tU1aj3GK+v0duHx3LHZHo6XV7LqYvYoLY/9SfqAmOaXFmo39SB5
 cbw8vc62dVMeixZUiF8Qj/aIjP/ElVHskGF+h/wlbRwdM8zOYwLhwsfPM2VM/WXOvBDEtCX7w
 TMf4VHfcwEUOy8JhBpXaUNpCX3ozKrgdsKCNZymc1lTZ/k8omvCle9U1y1X/+PLASuxITeKw4
 E3TZwf6lUxjsQM09EbAxmgCl2cpnq6MzOiu1i8c2wKsDbfaz9ctg0XrJY3SltR8jHTLaKj6Wn
 oooxmUfcRLuEksPDpmDFOClg3wKPhG5DuLIKEDQcC8VucZ7fjC1GqxC/gd43gN1THl3nu5VIk
 QYFgtrfWQZhg9Gxda16O42Ymyl6HVanUZy8E36XjCuHpwCn+rjz6qOGcpFGyVL1cCLJh9F7yd
 vGG1FnQL0V+7nzFajbxbGutfs83OEt1cF3tk65iYPuWapmRgJeCpdWjwMikyQlHEclYWrMGyp
 f6FktBjvcF1ixJQW1jn5LVOzrF53XTGFERKjNqndGJrirGp+5udiZzpOQKIJx5bKIincoroER
 HJsrxEeGeAnxZSA7IsviCEK7aTMFvknqKOsApSebpRouRzDUrb1xeFYKwfb91XzTiwzLC6ExM
 wSyo+ZJVBNq3Ks7DSQk0PGW99mk=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assert(x) should emit a warning if x is false. WARN_ON(x) emits a
warning if x is true. Thus, assert(x) should be defined as WARN_ON(!x)
rather than WARN_ON(x).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

Commit e0c1b49f5b674 ("lib: zstd: Upgrade to latest upstream zstd
version 1.4.10") mentions that the zstd code was generated from the
upstream version of zstd, so perhaps the definition of assert based on
WARN_ON should be fixed in the conversion script and/or upstream zstd
source code.

=2D--
 lib/zstd/common/zstd_deps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/zstd_deps.h b/lib/zstd/common/zstd_deps.h
index 7a5bf44839c9c..f06df065dec01 100644
=2D-- a/lib/zstd/common/zstd_deps.h
+++ b/lib/zstd/common/zstd_deps.h
@@ -84,7 +84,7 @@ static uint64_t ZSTD_div64(uint64_t dividend, uint32_t d=
ivisor) {

 #include <linux/kernel.h>

-#define assert(x) WARN_ON((x))
+#define assert(x) WARN_ON(!(x))

 #endif /* ZSTD_DEPS_ASSERT */
 #endif /* ZSTD_DEPS_NEED_ASSERT */
=2D-
2.39.0

