Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAC5FBF96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJLDrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJLDri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:47:38 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B179EC6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:37 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221012034735epoutp023cdd5040497eb71aab36b302086c3b65~dNa1DAiex1949919499epoutp02i
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221012034735epoutp023cdd5040497eb71aab36b302086c3b65~dNa1DAiex1949919499epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546455;
        bh=e+6ZEuzGklKnaYmJ9kFYIdB8xhWlS7LQO9Hox4PJb6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g02EXSJR4cv6LPHBWtgOdr3QA6k1tWcJlgwV2GG+aZSZ2EoaIsnxOgZSsSpKdMWlY
         5Wi2DGzXlCIEDAzOUwot606wcVNGHYjFwtqnrq6i+LBuzID5batNqwa8+xAhIpIFtJ
         g1RFpKuonLfqVYtRTERwKW8uXm7nJlMVsMaQslNY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221012034734epcas5p162bae79cac725fe1d1c9ee9909d277b1~dNaz15SCH0074400744epcas5p1Q;
        Wed, 12 Oct 2022 03:47:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJWR18PQz4x9Q7; Wed, 12 Oct
        2022 03:47:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.DB.39477.2D836436; Wed, 12 Oct 2022 12:47:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221011125145epcas5p4f9d2656c8b91d7bb6a51989afa49120d~dBMqbT9tF0099200992epcas5p4A;
        Tue, 11 Oct 2022 12:51:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125145epsmtrp1f8bea722cfb8ffac8b4da292a3d0b205~dBMqaR19F2656926569epsmtrp12;
        Tue, 11 Oct 2022 12:51:45 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-38-634638d20ea8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.0D.14392.1E665436; Tue, 11 Oct 2022 21:51:45 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125142epsmtip1a70854be8c175ac3ab0544709f0a685a~dBMnR6j1P2178621786epsmtip1q;
        Tue, 11 Oct 2022 12:51:41 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 02/15] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Date:   Tue, 11 Oct 2022 17:55:03 +0530
Message-Id: <20221011122516.32135-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa1AbVRT27iabgA3dgTq9olAaxz7oQBNKwoWWaluEhfYHThydqm1cwxqQ
        kKRJaGvtCFVBQEuLlkEeDS0h4lBaKO9CgMhDhocVBgQdSMsb0rEaQSkUXyEJ+u8753zfOWe+
        cy8X95wivLkJSh2jUdIKPuHOqu/YvTNgCEXKBBf1AM025rPRhL6eQIaVeQzdNyyxUHtNHQfV
        DhfiqKzbzEbFnXfZqOGbKRa6vWCvDuZbWGi++BZA1oJ7BKqeHmGjyQevoaGmIgJ9VlXHRjc7
        LRxkHB3E0FfVf2KopO53Dkpr6eQgi6keoI/TO7EXIVWhrwBUo6UUUKOlizh1p8DCoQwmK0ZV
        l2cS1PiIiaBqSlOotK7HLCq7thxQf394lUNldY4S1FK1L9X7xxIn1uP1xAPxDB3HaPwYpUwV
        l6CUh/OPSqRHpCKxQBggDEUhfD8lncSE8yOOxQZEJijsNvD9TtOKZHsqltZq+XsPHtCoknWM
        X7xKqwvnM+o4hTpYHailk7TJSnmgktGFCQWCIJGd+FZifOWqAahvc85WDdQQqcDKzgJuXEgG
        w58frmJZwJ3rSTYDaF2+w3YGiwD+2FcMnMEygJbFvzgbkjxTi6vQAmBjTxnhDNIwWPxwzdGY
        IANgm9FMrOMt5AUApzN06ySc/IgFLf1rjlZeZDScmctzkFjk8zB35bpDzCPDoSl1keUctw3e
        qDLj69iNPAh/M37rmAbJT9zgQO5N3EmKgLZ7110CL/igu9a1qze0Xkp3YRmcLrG6+ApYabri
        4r8AzcNFdsy1b7cbVjbtdaZ9YG7vLWwd46QHvLg2gznzPNio38A7YNH4isvJZ2HHDSNwYgpe
        673kcjXHbmSJEb8MfAv+H3ENgHLwNKPWJskZrUgdpGTO/Hc3mSqpGjgeu39MI5icsAW2A4wL
        2gHk4vwtPFB8WObJi6PfO8doVFJNsoLRtgOR3cAc3Pspmcr+W5Q6qTA4VBAsFouDQ/eJhfyt
        PMOX/jJPUk7rmESGUTOaDR3GdfNOxcz4yczcytbvI88L++WbzCFtS2+fWGteGDakd4/Zjmdb
        j+hPfk4ni9LfDexRilM+KDtE9M1EPbqwS3A5s6p3W9H4OI+145+xseiMth73vqid5RNhHX7C
        mKhXCucqJ0WjYVcPmUfkUtOVfe90nR6Q7BnK+TTPJ2R/RNPQKSlxrILa2lEz/IPliaAU9zLJ
        F9bmgbRHYcbltuVWhXDm1zePgme+G5zdv/D19n6iPOSu7iXJ4fubm0OHM44nd3nG+DYE7jrf
        MP3YvXQ7fTbkp3nJq5v4rU9uzpasQn+PN6w+wl+IoXMz6WkC+ayt5P25/BMve00B26nnom1J
        e4QxvHCFXt1aeMbIZ2njaaE/rtHS/wIbmurxdQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRWUwTYRSF/WemM0OTkqGgjlXEVCVKAkKi+KuAWjUZlQcejCzRQKEjoLTU
        DojLA4tAaqMEMAQBEbVFBQWh7FAES4FI3DVWo1XBpVaiFiiKgiCF+HbO/b7kPFwSFZZgIjJR
        kcKqFNIkMc7HmnvEy30HD+2K8x/QUfBTawkPvr/UjEPthBWB77RjGDQ2NBGw8XkZCq/3d/Ng
        hekhD7bcHcJg/ZdZ+qTEgkFrRS2AttK3ONR/eMGDg1/D4bP2izg8W9fEgzUmCwErzU8QeE0/
        hcCrTQ4C5nSaCGgxNAOYnWtCttHMrUu3ANNq0QHGrBtFmbZSC8FoDTaE0VefwZk3Lww406BL
        Z3J6/2BMXmM1YKazyglGYzLjzJh+OTMwPkaEuUbxg2RsUuIxVrUuJIafcPu3FijrieN1jxvw
        DGDjaYALSVPr6WJDJ9AAPimkOgBtaJlG5sEyeia3j5jP7nTVtJWYl04jtNo8A5wAp3zprspu
        3Ak8qBxAm6vOIM6CUmUYPVHYPbfhTu2mP34uxp0Zo1bTRRNX5u4CKpg2ZIxi8xNe9M26btSZ
        XagQeqSyb84XzjqZP4qQfOB6GSyoBktYJSePl3MBygAFm+bHSeVcqiLeLy5Zrgdz3/NZ2wpa
        qu1+RoCQwAhoEhV7CECFJE4okElPnGRVydGq1CSWM4KlJCZeLHisuRctpOKlKewRllWyqv8U
        IV1EGchBd5/YO5FJ2uO/CgxfAjlJIHX3rHeKfiGe2hFbYDvVpYuof+A2s3HFKfXtrTl54VMy
        q2kiwn6gTmL0ldwD97c45CrHcIFG0mG5sb9y9G+RfcTt4dMbPE1wbY1xv9fO7M4hwVS9Ve1o
        NAb5p0f1x65TovsmX/kMhBXusa3KK1g5jk+/Ts+yn+/Z3iZrDuoPHT6h9kfChiLTXqIxDQnb
        x/dyLaF9UZuGvdPstt5c30de3/F35RrFpHKHwRHaF6MYbM8fsWXWWKM282uFUvitQ3ZY27Me
        epLbvmWtSfRjH4jCWz1FHpmi1SVLes8tUC96Y3cUp+3bcK3/0IWfR8tcxRiXIA3wQVWc9B9C
        B8eeLAMAAA==
X-CMS-MailID: 20221011125145epcas5p4f9d2656c8b91d7bb6a51989afa49120d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125145epcas5p4f9d2656c8b91d7bb6a51989afa49120d
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125145epcas5p4f9d2656c8b91d7bb6a51989afa49120d@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

Add Tesla FSD MFC(MFC v12) compatible.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index ad61b509846f..9fb4cae1b68f 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -24,6 +24,7 @@ properties:
       - samsung,mfc-v8                  # Exynos5800
       - samsung,exynos5433-mfc          # Exynos5433
       - samsung,mfc-v10                 # Exynos7880
+      - tesla,fsd-mfc                   # Tesla FSD
 
   reg:
     maxItems: 1
-- 
2.17.1

