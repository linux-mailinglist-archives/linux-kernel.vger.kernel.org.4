Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4BD61F5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiKGO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiKGO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:27:20 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0069B1E3F8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:21:13 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221107142108epoutp0224ad4991c37a8d2a4b573dba9b9976e3~lU1a7XaeJ2392923929epoutp02i
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:21:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221107142108epoutp0224ad4991c37a8d2a4b573dba9b9976e3~lU1a7XaeJ2392923929epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667830869;
        bh=xu5HiGuhdMYiBk9eR1LTVtkgBzlNFGVtIT25yDzOKAw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K+5LOTA7ELqIC6IZU2dGm7wz5WdyPJwgrN5ELTd8dXGksXnOUSJnqMbR7pdoiIO4a
         C+yVPKhfYxC4RZ2GIDhnREVCKX4O0hKQxMkwwN3HNwaahOE96cu80FA6gs2Trr7ehK
         VU4MC7XZ6vOPNaOHnMsme/r+rfJld/bJxnfqjo4A=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221107142108epcas5p4b6cb4ac45bd2a5043348b29b2feb5b94~lU1aLfryZ1230712307epcas5p4o;
        Mon,  7 Nov 2022 14:21:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N5YLT1KnVz4x9Pp; Mon,  7 Nov
        2022 14:21:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.B0.01710.15419636; Mon,  7 Nov 2022 23:21:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221107123641epcas5p26e310f1ab6addb4fa6757f5147b8e50b~lTaOE4FgY3098230982epcas5p2I;
        Mon,  7 Nov 2022 12:36:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221107123641epsmtrp26e438fe0d8ca7ed98536aae7e72eb6bd~lTaOD23qo2366723667epsmtrp2f;
        Mon,  7 Nov 2022 12:36:41 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-09-63691451f7e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.84.18644.9DBF8636; Mon,  7 Nov 2022 21:36:41 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221107123639epsmtip1258435c8702be6a964d137db2ae6cc31~lTaL71AQ40856308563epsmtip1D;
        Mon,  7 Nov 2022 12:36:39 +0000 (GMT)
From:   Inbaraj E <inbaraj.e@samsung.com>
To:     krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, cw00.choi@samsung.com,
        alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, chanho61.park@samsung.com
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pankaj.dubey@samsung.com,
        Inbaraj E <inbaraj.e@samsung.com>
Subject: [PATCH v2] dt-bindings: clock: exynosautov9: fix reference to
 CMU_FSYS1
Date:   Mon,  7 Nov 2022 18:13:37 +0530
Message-Id: <20221107124337.114135-1-inbaraj.e@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTXTdQJDPZ4MFWVosH87axWVzer21x
        /ctzVov5R86xWtz9M4nNYu/rrewWmx5fY7X42HOP1eLyrjlsFjPO72OyuHjK1WLR1i/sFq17
        j7BbHH7Tzmrx79pGFotVu/4wOgh4vL/Ryu6xc9Zddo9NqzrZPO5c28PmsXlJvUffllWMHp83
        yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzviyZg1bQQtPxaEPTcwNjM1cXYycHBICJhKL/3aygthCArsZJY5/U+pi5AKyPzFKXOqe
        ygrhfGaUmNB6iA2m4/KRpywQiV2MEgsXTGCGaG9lkvj40wjEZhNQl9jQ/Z0NpEhE4CGjxP7m
        ZkYQh1ngMaPElYs32UGqhAWCJD7s/soCYrMIqEpcW3sObBKvgLXE5RtbodbJS6zecIAZpFlC
        oJFD4uDxDSwQCReJiZsmM0HYwhKvjm9hh7ClJD6/2wvV7COxf84vRgg7Q+LY9uWsELa9xIEr
        c4DmcABdpCmxfpc+RFhWYuqpdWAjmQX4JHp/P4EazyuxYx6MrSwx88h9qPGSEjsv74Q6x0Pi
        7OfbYCOFBGIlrl1wnMAoOwthwQJGxlWMkqkFxbnpqcWmBYZ5qeXwiErOz93ECE6RWp47GO8+
        +KB3iJGJg/EQowQHs5II7w23tGQh3pTEyqrUovz4otKc1OJDjKbAIJvILCWanA9M0nkl8YYm
        lgYmZmZmJpbGZoZK4ryLZ2glCwmkJ5akZqemFqQWwfQxcXBKNTBpX+DXZIz/Htz+SM0/xuz0
        xI9aB58dnmcm2OKqLvXj7P0DE6wYHmfMfh7v3ynJYX4wbG3geoO8qBOrW7jeCERPOGluWf20
        /3Oe6F8R7xiX4MA9p/oU7k1sfjE3ID3gypWSFPGa2YnLVAo9Ctex/pj2/j/LE9/sMww+tx79
        PBs341FFYmlemtT0Q18F/bY3i5qxlE5salrNK2G5+rV2bLLQvZmqrYzzfNL8f6sUx/5/1Pmp
        TGLaNLvGpLirK+zbhN7uKv13S5Zt1vMaofIL3KcuyfxjytV7cmtiWYrmFJPe58H3Pd6nOvqs
        +Z68bqVGwjXf4019pvmnJAoP+Nkt2vvS2iTgitMv09Vel6MuBCqxFGckGmoxFxUnAgAcE5xg
        GgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnO7N3xnJBi+3qFo8mLeNzeLyfm2L
        61+es1rMP3KO1eLun0lsFntfb2W32PT4GqvFx557rBaXd81hs5hxfh+TxcVTrhaLtn5ht2jd
        e4Td4vCbdlaLf9c2slis2vWH0UHA4/2NVnaPnbPusntsWtXJ5nHn2h42j81L6j36tqxi9Pi8
        SS6APYrLJiU1J7MstUjfLoEr48uaNWwFLTwVhz40MTcwNnN1MXJySAiYSFw+8pSli5GLQ0hg
        B6PEoSlr2CASkhKzf09nh7CFJVb+e84OUdTMJHFo4y4WkASbgLrEhu7vbCAJEYHXjBL/731j
        BnGYBV4ySrxYdwTI4eAQFgiQOLbDFqSBRUBV4trac8wgNq+AtcTlG1uhtslLrN5wgHkCI88C
        RoZVjJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBAaultYNxz6oPeocYmTgYDzFKcDAr
        ifDecEtLFuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHJ
        fOWC0AAf/sUH3kpdkT88f23o+dYNby1i1Rc+E845oDn9y66aVxMe8rcFhvplPApg/v+wIbP4
        x8e6jTdyK5r5l7OsbJFMNSi3dl+Xu29dzuTyvj33+TjV5JRrWpNXzJwnyr/u3ukSxhXPRA46
        N6zaHzuDSVj1GYeT/j+DKwU9U8+s1nj6u20u3+kN98Iin/0Q3lx22LagPLE11GTbnYXKikX7
        IqOXXUj9ObvRYNvsu4VCKSlsVXvyGpa0cPffTl/3lvvAu3jb1BW1z0qj8iJ4srS8Ly/9LH2Z
        acetK5PyXn92sztcunwFd3XvoVlZv66ov5f0Ofds/rGa1+/82230FNez2Akc2uIkozj3pA+r
        EktxRqKhFnNRcSIABLQpW8cCAAA=
X-CMS-MailID: 20221107123641epcas5p26e310f1ab6addb4fa6757f5147b8e50b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221107123641epcas5p26e310f1ab6addb4fa6757f5147b8e50b
References: <CGME20221107123641epcas5p26e310f1ab6addb4fa6757f5147b8e50b@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reference to CMU_FSYS1 mmc card clock to gout clock instead of dout.

"gout" is output of a gate clock.
Unlike any other clocks, the fsys1 mmc top clock does not have a divider.
So, it should be "mout -> gout" instead of "mout -> gout -> dout".

This fixes make dtbs_check warning as shown below:

arch/arm64/boot/dts/exynos/exynosautov9-sadk.dtb: clock-controller@17040000:
clock-names:2: 'dout_clkcmu_fsys1_mmc_card' was expected
From schema: /home/inbaraj/mainline/linux/Documentation/devicetree/
bindings/clock/samsung,exynosautov9-clock.yaml

Fixes: 4b6ec8d88623 ("dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1")
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Inbaraj E <inbaraj.e@samsung.com>
---
 .../devicetree/bindings/clock/samsung,exynosautov9-clock.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
index 2ab4642679c0..55c4f94a14d1 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov9-clock.yaml
@@ -148,7 +148,7 @@ allOf:
           items:
             - const: oscclk
             - const: dout_clkcmu_fsys1_bus
-            - const: dout_clkcmu_fsys1_mmc_card
+            - const: gout_clkcmu_fsys1_mmc_card
             - const: dout_clkcmu_fsys1_usbdrd
 
   - if:
-- 
2.17.1

