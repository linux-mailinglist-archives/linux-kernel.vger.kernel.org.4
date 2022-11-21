Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9B6320E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKULlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiKULkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:40:33 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F01000
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:40:22 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221121114019epoutp04cee39e416d1c90eb23bc144aab583f08~plq-p1gqr2773127731epoutp04r
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:40:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221121114019epoutp04cee39e416d1c90eb23bc144aab583f08~plq-p1gqr2773127731epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669030819;
        bh=72tROAnM4O3TgelH1eMyWmJRXNB4hVOxg3JytWS8x/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEto1I66eS2n7IAhCT5ky5bxZs0LyTAPECXYiFreZFXB20xgZY/rmYp8yOqdtD38Q
         rRyXYXjyQ0EPuICLlpvenYNbGFIw9A26MtJbckIO2V90WYuSWnoHWVNODWQMdq1b45
         yebSCUfPrQlmD0INbgu5gVqybf2asPt7OLZ8ZKWU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221121114018epcas5p14a45ab0b0f3ce0786d1eefe34f49f7a4~plq-PvYaY2845828458epcas5p1s;
        Mon, 21 Nov 2022 11:40:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NG56S6rdJz4x9Pv; Mon, 21 Nov
        2022 11:40:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.84.56352.0A36B736; Mon, 21 Nov 2022 20:40:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4~pjkk3ulOw2130621306epcas5p4Z;
        Mon, 21 Nov 2022 09:06:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121090622epsmtrp27cc8cc09e71b4be9a3bae1950f8cd9a6~pjkk3AeW72801828018epsmtrp29;
        Mon, 21 Nov 2022 09:06:22 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-17-637b63a099c2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.4F.14392.D8F3B736; Mon, 21 Nov 2022 18:06:21 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121090620epsmtip19268db92a9a372a96aca8b31d251ec6a~pjkjXWcWL1474114741epsmtip1I;
        Mon, 21 Nov 2022 09:06:20 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Vivek Yadav <vivek.2311@samsung.com>
Subject: [PATCH 1/2] dt-bindings: mfd: syscon: Add tesla compatibles found
 on FSD SoC
Date:   Mon, 21 Nov 2022 14:41:17 +0530
Message-Id: <20221121091118.48628-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121091118.48628-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmhu6C5Opkg+WHTS0ezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWC1+LTzM4sDlsWlVJ5vHnWt7
        2Dz6tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VW
        ycUnQNctMwfoICWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpe
        XmqJlaGBgZEpUGFCdsaRpUeYCs6xV5x7+Iu9gXEOWxcjJ4eEgInE5oMtTF2MXBxCArsZJU5d
        /cMI4XxilHj+/TI7hPONUeLg48XMMC23jv9hhkjsZZT4fmkpG4TTyiSx/dlTdpAqNgFdidZr
        n8EGiwhsYZRYeX4nE0iCWaBQYt7CK0A2B4ewQLjEmwd8IGEWAVWJhtMzwXp5BWwlTjXvYYfY
        Ji+xesMBsM2cAnYSaxtfQ8VvsUusflANYbtITOvug4oLS7w6vgXKlpL4/G4v1KPpEpuPbGaF
        sHMkOpqaob6xlzhwZQ4LyDnMApoS63fpQ4RlJaaeWgd1MZ9E7+8nTBBxXokd82BsNYnFjzqh
        bBmJtY8+QY33kLjz/CFYXEhgIqNE10HmCYxysxA2LGBkXMUomVpQnJueWmxaYJyXWg6PtOT8
        3E2M4DSn5b2D8dGDD3qHGJk4GA8xSnAwK4nw1sdUJwvxpiRWVqUW5ccXleakFh9iNAUG30Rm
        KdHkfGCizSuJNzSxNDAxMzMzsTQ2M1QS5108QytZSCA9sSQ1OzW1ILUIpo+Jg1OqgWnJveV1
        NnVz/roHTV4oxLf0+qmnj4OLZ0+6xzbp21yZ1UdY9my7++PMtPesST5tO88FT7w3rfn0vxcb
        OEN07iXrPY0UF3f72+AY3caa5HD39t2bpaVOce82ndR7tsBT5PCOdvedfjuuPX3peuI9+zLP
        87OvrXBjYE5Wd/qSqbB15S+31NP3z5rZSc5b+275cq3XUhtVFr1kuDd3o36S4/c0LdPtVRxh
        Ph8vO3I4hAqs+5Pp/zW80GbrYbtHSptytwfdelCaGPnkwqo6LzYT5qsaS57LKv3bwMnsfy7b
        ZO78Jx4PZ8eEKBpzXFjaKCKQfmKj6+a5coV3K1vnTE+6OL3igVXFG4uXamaSLqk5qtLySizF
        GYmGWsxFxYkA7mj2KfwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnG6vfXWywfN/phYP5m1js5h/5Byr
        Rd+Lh8wWO9oWslhc3jWHzWLR1i/sFg8/7GG3aN17hN3i9pt1rBa/Fh5mceDy2LSqk83jzrU9
        bB59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVcWTpEaaCc+wV5x7+Ym9gnMPWxcjJISFgInHr
        +B/mLkYuDiGB3YwSa949YYJIyEicfLCEGcIWllj57zk7iC0k0Mwk8fx/FIjNJqAr0XrtMxNI
        s4jAHkaJd9NPsIIkmAWKJb4f7AHbICwQKtHwaweYzSKgKtFweibYIF4BW4lTzXvYIRbIS6ze
        cABsGaeAncTaxtdAcQ6gZbYSb/ZETWDkW8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85
        P3cTIzgQtTR3MG5f9UHvECMTB+MhRgkOZiURXpFjlclCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MC2rEhWeOLda4J9n8d0/8hcvR38w+c7KvD/2R9ys
        zNbpLK/sVRfE9rkw2zcYfQsSLBdb7tUrnMNr6Tr5Rtuq7JdpBZf+nZ399Jnl+fk1u7bclmPn
        4+iyXj1x6/SXS3aEixmum5zTcjhAaSXL6zmeMxbev/rk+u/z085zHC6OuvhLyzRS+YBlXMua
        eRtv7FTIvDV7f06I1p0Yu6uHjm6cOIfjLctWuUQ9RkEFKyvreuOIzn7dnfcZNj9Y7L1CVvq9
        6uHgDbXnDk/NOLz18zynWf/7n512nvny9NN++1jXy2X/w54r885uP3njgDO/aMn6dw7Ckx78
        6ZzCk+N4o2xXL8vmK2LtR0wKnE3vPrHfmnNeiaU4I9FQi7moOBEABPKObbMCAAA=
X-CMS-MailID: 20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
        <CGME20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the compatible properties for Tesla SYSREG controllers found on
FSD SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4e4baf53796d..8c3334999bec 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -69,6 +69,7 @@ properties:
               - samsung,exynos5433-sysreg
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
+              - tesla,fsd-sysreg
 
           - const: syscon
 
-- 
2.17.1

