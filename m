Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46BB6267F4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiKLIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKLIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:10:29 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7EE09A;
        Sat, 12 Nov 2022 00:10:24 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.85]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeToK-1pRzty102G-00aYlX; Sat, 12 Nov 2022 09:07:26 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 94B0F3C1B8;
        Sat, 12 Nov 2022 09:07:24 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 51027C8C; Sat, 12 Nov 2022 09:07:22 +0100 (CET)
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add linux-kbuild's patchwork
Date:   Sat, 12 Nov 2022 09:07:17 +0100
Message-Id: <20221112080717.17914-4-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221112080717.17914-1-nicolas@fjasle.eu>
References: <20221112080717.17914-1-nicolas@fjasle.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ubk5q21QCZ1sNKrXxb4A/q9xW2Eoud0Z+u6/wKvrTIGwiNU7Yw8
 1se6n97qAcysuguJE6Iuva+SoDIirNyICLeh1HcYGHo+U/5cXTNEeGg6nVV8Mtt95fEwI1I
 BQND9vKOWMoThFvOEZkFHECa5BuJ03nBbiakMPb2UcYzeLI5RwVZnfHyt1R2M8wlhNKeBsF
 4eQ+d/qMQx2XOaY9eEGsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TqaGPW/bFHc=:d411UQh9HZwNf8rPSYVLnv
 fXllaWYWgEB57I/hdxUyLkZslh0k+wTt3+1z2wDRyNw6VEc0eM4+LCTLc0w4UtCiBcs9n0fzW
 s/4py88szCUJKqpTL0ijEHDMr1fwrfMV4AUKxXY9ua7e764dPT1A7Uf863/QXPeQvRdZy5jEe
 WwD83Pyrd66aROxf3blvdN+rilJuKtun3XUcdXu8jMx1+C4NrhIbAv0b5mjAi7gmFtxdZB76/
 CmuKMqoZXQ51xO5NVJNF+nSXWqSOqKw4Iu3LGXE5TcyTxt0sKiQ5pbozRGAUiONJw6s5OURl9
 YV1834EZRqJpQnDAjqqLhc35MwOah+moJBERf0FrCTHBhTwKNbCYhY09+Ys1qWGEPEu1QhjOb
 M8aE6NssSyHsPPT3QB4MggXzYwC46A9nvDxE+qCzEduLBAvTFWPAbCAWU544O1qR2IgGwak7L
 3yHfwpVxcj/2PCDMz/r3O4vx0+QDcKcmu6ds2NRtwsQS1glkOpxpXbwieC1PLR+j8DVgJx7mL
 HzCUShttQDfck4CrGRkrSell1e32GL7pMqDKnzMFhfl40B1dKQeymZPJBOBVPRVj8u1WYZwRv
 coDv7G4h+ZZeSrR59Ft8hElultreDHdoytBnBzZdrdvHBetu0amz+4cbtwoJvaokK85Wu362J
 68ykvLSOCeCInzZvrbcDrWcZltNVbKbgdy5XUHdrnOSIMlbiOlgngXeK//KwTK0Cu++Gexef0
 jwk4I+KeSBZDxHrj3htTtc/8Eoyi6AlbH1ls+ouVWlU3NGwwAzaWJIWPIsSxM0EObtXKOwA0K
 0huiyscPL6+VptWOR80IYZ9H88r1yXUR9E1GAkT4ThxTEd23OICinUrH2Hxz3UdpUNQ+CM10K
 wnKeGf4MhwzWkvqgWMEYUsBdkCN4L6YX2UrJ3O2TpL1k2Im6mqpyPFxYq7Sm05QAogCtXJW29
 EhDnOZE4lh5LNBvFrl6DP0/3Ld+88A8MKlEd2VnV8sPcgGmkLLjsN2bmIZ11wtAzr4TEBNsIL
 nRbBTp7EyuNdRxe2SEyK/wWMs6NH6h6pZm942fiDnemx6IT+1OhhIfmWxqs+JyCQqP8VGWQAh
 eMYYbS86kiimimMVqNdVnMAPqA0eEIYDFb+i8lw0Y13ATrruRB5Hhjuyu4EXbX5uHKTYdPCqT
 HHiG84zDs7se2yqZsF5F5CcLslcwQDVjRCbrY5Lj2WmG5mFEVgsI9foItYtTwfQCYXh1f3UQH
 M9QF527L9IdxPa6VpyKrwaV14K/aHHdI7ilyv+wmIqS1QBIwbK796FVepuePA/P0frhM+qsMI
 RRzsj1QKX8ISTdASt4trd2GLKhJmLg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add patchwork URL for Kconfig and Kbuild.

Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48e45633b223..92b3febf8eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11026,6 +11026,7 @@ KCONFIG
 M:	Masahiro Yamada <masahiroy@kernel.org>
 L:	linux-kbuild@vger.kernel.org
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-kbuild/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kconfig
 F:	Documentation/kbuild/kconfig*
 F:	scripts/Kconfig.include
@@ -11088,6 +11089,7 @@ R:	Nick Desaulniers <ndesaulniers@google.com>
 R:	Nicolas Schier <nicolas@fjasle.eu>
 L:	linux-kbuild@vger.kernel.org
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-kbuild/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 F:	Documentation/kbuild/
 F:	Makefile
-- 
2.37.2

