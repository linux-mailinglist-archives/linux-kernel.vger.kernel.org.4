Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FB614ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKAQG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:06:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E93713E14;
        Tue,  1 Nov 2022 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667318776; bh=GDM5w/VeqzXan3VWgpM/qUk5TbfOxJCHDnXddN5FY2E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=QnqfJL1ucll31p6hRPGdK0rNqX3J1n6DaEO9OEl4Ei8qe4eqRQ6PVZxbwXBeawo3+
         pgzbW8GTTRVUWa8Bfe6pT1+b4oKaW9mG5Q9w3Z/bct/tQ8sv163x5eZ4lrX70ZEFvj
         qA2KeBbBEXWV/2vU+XjDHtAOQBCS3NG8XqFtKexvT0bdZ2qRviPrnE/Vhe+alQ4VkD
         dOEwz3phUr8eIQMKW3GVDw7OZ/PrkxSpPRZjV/H4DMmNDbmPeoDDQY5K6disCjUf2x
         gazzijXRzFr+fMj9SihgU4XSxNeQMLWT/++6XxmU1dYMEBWJKJ38bHr4tDJ+wSWAF4
         hrMGPmT0Vbfwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1ouaTL2iA7-005HB4; Tue, 01
 Nov 2022 17:06:16 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ia64: Fix a typo ("identify mappings")
Date:   Tue,  1 Nov 2022 17:06:09 +0100
Message-Id: <20221101160609.961950-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/VRiGKjvC/suvQdqYSsF82L0JMSiSVg4aF1DQVvMmkX1CJI9art
 HtrqolxTTDg+JqHeNQybqSf9BGPIHmg241N+PMI16yAEMiaNSttZKKMSxWBt+ZyEBRejXfj
 QUYRxrpZKWIvseBOpAxyQhcj4M5oOaHFullar9+IHPYgVciBsZbfqQAR9vJqMdFS6ozpiBf
 IvEpaztOQPLYm9Z0VY1fA==
UI-OutboundReport: notjunk:1;M01:P0:CinfW92A6PE=;XnaiRvyVEhl15pc8HtejAYg6GNs
 PJYMwfoxBsQuVW/9ils3T/lJnuKWM3MoiNqWikPCndzaYLTbwGme4MBBWUpI8jmjDfB6iiVTw
 Sn8frRqd+IsJL4RykXeTTlaLKBFUu9ri21ZA1FAYsJoJbmKulLpK/imXr07hYrU6lxnSxXjWy
 9f7aY8yu0QR9AJ9/3LImfbOulilBhJUoEUAKBUZIuirkJwOR1DEbTVDa7nNoK0Jk32Rgpl/wW
 WLtAsihjSbIFhepwjLmYxtBQE09OIBp2Fyy0G7oOkBUC9Z2/ZZnzci6UIvTUfxBpFZ0xXVrY6
 tOkGs/4vdPnUq6F48zZ4avY/2ucldbOhd1NYFeys8nAQMxhsjLNFAa4qKb5AiYccS4R6wcVK4
 nFIq6i6c5cQ0kfbvfvGCjIGj8db3CauGsRpet1S/BYgXjQiQNTVBgAbpoz4NMCHfIuvd6Il1r
 wkSQ/1iEygyfDaBMXx0f1czt9EdOSOY1Q+UR4k2YLc0zgiUR+QQuNgClS1mDBnh+bhBPap3hd
 NkrbYqXGvRWSy7oTFpSLRkC1ji6STv/Uuaigu+ASnBAHoDGeVSTG8cWUHs/mteC6txevHiJs3
 zvBVWgVyUMocf0LYCclZ1hALERH/QwAGfb2YD0L76wXetF4s5+mTxYbms4jVm4uVJhlQCISvy
 XtXWnbj/ytLy7KjWTfNvBeK8hKcQpj7aonGbgFKQf0jv2EZnnjjVfnmtgJt2hy8WdpyP/8egb
 E1LEXqtnC8X7oahrLYemXiPV/j0yjt1+hTj2HdOOBVPAkgBe074TQFtwuqmOprPmq207nq54w
 hclZ7fhuhVm7dJ3xZt6nFX23GdIGfH7wE6HsfobpBnhMbLflzkeo6v2cXnG+9SNxMxF7q786s
 E7Amgrbc3Pi64MPHWLF3z1JoZG+dkEo5Gxs5yaDng7RemE+gEMJg6slyS0YvPn43knEOXZsQz
 tIix66iVg2C37IAf/r9ubPxER8o=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct term here, also used in the next line, is "identity
mappings". "itentify mappings" was probably just a typo.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/ia64/aliasing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ia64/aliasing.rst b/Documentation/ia64/aliasing=
.rst
index a08b36aba0159..36a1e1d4842b8 100644
=2D-- a/Documentation/ia64/aliasing.rst
+++ b/Documentation/ia64/aliasing.rst
@@ -61,7 +61,7 @@ Memory Map
     The efi_memmap table is preserved unmodified because the original
     boot-time information is required for kexec.

-Kernel Identify Mappings
+Kernel Identity Mappings
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

     Linux/ia64 identity mappings are done with large pages, currently
=2D-
2.35.1

