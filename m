Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED164569B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLGJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLGJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:36:48 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7B3D93A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:36:45 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221207093643epoutp0330bc511b901b47b8af73ecb0ccde1f18~ueTpbVUzh1066310663epoutp03E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:36:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221207093643epoutp0330bc511b901b47b8af73ecb0ccde1f18~ueTpbVUzh1066310663epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670405803;
        bh=HN4KaD8GuNID+ZYSO2MfhF+r29o+2SvJAlKMaq4jfkY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MS/iz5GC8xgkrTuu5gDowZTzbGcbvXx4rsN2eR3c7ZzA5RJ+A4ioPxClTKCCvjHhv
         oHO+XuCkBpE4RYO6GyRCH0gQOgwTCAKZm45r3aFdtztWoCWgatvgKK69osyoP5zMQe
         wuWUuA4qdQgecip1KrLEUvxBIIItdWwrf5HvGHbA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221207093642epcas5p1a85e9a2c9b43ed68f992c59b776f26a4~ueTo1GabW1731317313epcas5p1t;
        Wed,  7 Dec 2022 09:36:42 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NRscT0Kzxz4x9Q1; Wed,  7 Dec
        2022 09:36:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.3A.56352.8AE50936; Wed,  7 Dec 2022 18:36:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221207085843epcas5p45d904815c5fd6d632937543ea3d90c50~udydsi3xy1340513405epcas5p47;
        Wed,  7 Dec 2022 08:58:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221207085842epsmtrp192c4ddd79126b48b44bb53dd989ea2e1~udydrvN8M2582425824epsmtrp1N;
        Wed,  7 Dec 2022 08:58:42 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-d4-63905ea8e8d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.57.14392.2C550936; Wed,  7 Dec 2022 17:58:42 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085841epsmtip16df16e8865d448353867447c3c43dbcd~udycTtH2w2358723587epsmtip1I;
        Wed,  7 Dec 2022 08:58:41 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 0/4] amr64: dts: exynos: add dedicated SYSREG compatibles to
 Exynos850 and Exynosautov9
Date:   Wed,  7 Dec 2022 14:28:28 +0530
Message-Id: <20221207085832.86909-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmhu6KuAnJBksbzCwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7IzFp1+zFawjq1iSmsnUwPjPNYuRk4OCQETiefHtjJ2MXJxCAns
        ZpT4svkiG4TziVFiW9t3VgjnG6PE0XePmWFaFq14wgSR2Mso8fjdKaiWViaJttf3mUCq2AR0
        JVqvfQarEhFYwijR2r0LbAuzwBRGiWO/ljGCVAkLZEpMOj4d7BQWAVWJT6vvs4PYvAK2Eh+b
        brBB7JOXWL3hADNIs4TAMXaJyfMeMkEkXCR+XpzEAmELS7w6voUdwpaSeNnfBmWnS2w+shnq
        1xyJjqZmqCfsJQ5cmQPUywF0kabE+l36EGFZiamn1oGNZxbgk+j9/QRqFa/EjnkwtprE4ked
        ULaMxNpHn6DGe0hMm3IXzBYSiJVo3zCNZQKj7CyEDQsYGVcxSqYWFOempxabFhjnpZbD4yo5
        P3cTIzi5aXnvYHz04IPeIUYmDsZDjBIczEoivC829iYL8aYkVlalFuXHF5XmpBYfYjQFhtlE
        ZinR5Hxges0riTc0sTQwMTMzM7E0NjNUEuddOqUjWUggPbEkNTs1tSC1CKaPiYNTqoHpYPq2
        qY85vqr45DYfZdsn93TK5vsPfFVX7Czs5M1bZrZav7E7MD/pWV/xlrwF+UoLNZKy6/d9z1jE
        z/TpMkNoV+/CY9/f//ol9krnBXefjM5Zj/nzw9dbxlsK55hxS24yT969dXpvrdXPdVOSV3w6
        pC6l+ijzGSNzafdr9TXrgiJt5bcI/P6/rYMznss8TnyWFcvSS/fTL91bWyDnIL25JOXZkRoD
        3psL3Wp/no4Ukfg5MYL1SyXb67xXezrL5i/9bKB66GjzlXepzyetKvnII22lXJKp/J9Ho93g
        09uEhBPrcjRkjjj/lJ8i06DQffb4xo/xX7uj/112njT5yGzhhW1JFU5elb7m/Cb1kXuUWIoz
        Eg21mIuKEwFom/Rf9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTvdQ6IRkg4VPLS0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBmLTj9mK1jHVjGltZOpgXEeaxcjJ4eE
        gInEohVPmLoYuTiEBHYzSpxdu4IFIiEjcfLBEmYIW1hi5b/n7BBFzUwSJy6vZARJsAnoSrRe
        +wzWLSKwilHizKOpYA6zwAxGiaVLz7CBVAkLpEts+jwJzGYRUJX4tPo+O4jNK2Ar8bHpBhvE
        CnmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4zLQ0dzBuX/VB
        7xAjEwfjIUYJDmYlEd4XG3uThXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2a
        WpBaBJNl4uCUamA6ZjZ3U9IJ6TWmPUXvMrPOTkx6aBN2z0vygbr0s87vVdurTmWsMH0uPPnO
        7KUFa64YySr5+jEf/VdamHNkV8eckrRsV6Y1pSxcJyO/3TbKn5Pw2pfHS5ZJfB7n3eVrgv5f
        f395y6XZrRPKT3a8vdlnfvWbU0ph+KKYrU9ul3u2i7NMunEvTNuycF1k/a3MuliOAOlmNVuG
        1guveqYLSHjqb3O9bijAYSf5yMHGn+fwTJ/46f5rLzzS0LzzpfrF3YzKfv7gzW81/54zvPXw
        4kf5pbE9d5b4TzNW3VyQejWjWGr6y1au4E43B67f9nIHL9Z7nTvM6WCpwrbo+vvPAk3CbCuk
        7vUfeGS58r1bQLcSS3FGoqEWc1FxIgBRivjUogIAAA==
X-CMS-MailID: 20221207085843epcas5p45d904815c5fd6d632937543ea3d90c50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207085843epcas5p45d904815c5fd6d632937543ea3d90c50
References: <CGME20221207085843epcas5p45d904815c5fd6d632937543ea3d90c50@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 and Exynosautov9 has several different SYSREGs, so use dedicated
compatibles for them in dtsi file and add respective compatible in the
samsung exynos devicetree binding document.

Sriranjani P (4):
  dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG
    compatibles to Exynos850
  arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos850
  dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG
    compatibles to Exynosautov9
  arm64: dts: exynos: add dedicated SYSREG compatibles to Exynosautov9

 .../soc/samsung/samsung,exynos-sysreg.yaml    | 26 ++++++++++++++++++-
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |  6 +++--
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi  |  9 ++++---
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.17.1

