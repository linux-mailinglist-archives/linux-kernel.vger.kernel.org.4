Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9358A5FBF90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJLDrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJLDr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:47:29 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F2796BA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:47:28 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221012034726epoutp024f11c660113937f8d0d4978c6988b493~dNas9rMtZ1949919499epoutp02f
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:47:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221012034726epoutp024f11c660113937f8d0d4978c6988b493~dNas9rMtZ1949919499epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546446;
        bh=a0vdFYoSfapPhn0wOLLbypVWbERl2E7gGu0xV0Veo/8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NtXF0NeDIFcUUGxl2G2FqEdVx8K+7+fSVU8pkdaCXR9ENvgUrDGDWXEswtiPs13Pk
         F7RE6SMs0n0CjDneedA6SWt3Jhi3uyATmmHeHgEgXL4WfHiswrcsNVh9AbqVA54bWy
         jJseyBeTutaceZ1BX2KunGGMUg6u59H30Lru4Ybs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221012034725epcas5p1e9ecd07b3fe2d1222a12f907f30e1c26~dNasBYKhP0055500555epcas5p1M;
        Wed, 12 Oct 2022 03:47:25 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MnJWG3v6Zz4x9Q0; Wed, 12 Oct
        2022 03:47:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.62.56352.AC836436; Wed, 12 Oct 2022 12:47:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221011125138epcas5p21b0a93e3bde26c3377e3fa7f34d86933~dBMkFxV8S3211732117epcas5p2D;
        Tue, 11 Oct 2022 12:51:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011125138epsmtrp1db6a44e521f61c05f6e70a5c3716ff8e~dBMkEjaCP2654526545epsmtrp1-;
        Tue, 11 Oct 2022 12:51:38 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-d6-634638ca48d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.0D.14392.AD665436; Tue, 11 Oct 2022 21:51:38 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125135epsmtip1dd029d2e4ca18021177e1357e793ef95~dBMg8WcKV2675426754epsmtip1I;
        Tue, 11 Oct 2022 12:51:35 +0000 (GMT)
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
Subject: [Patch v3 00/15] Add MFC v12 support.
Date:   Tue, 11 Oct 2022 17:55:01 +0530
Message-Id: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zTVxTHub9f+2s11v14jUsVVxoVwYCUlxcFJZOYX5ApBAduhLGm/CgN
        pe3aAsMsKjCYIoM90IyHMCmdCQ+LQEvBAh10ISFuEUZAU7sxOoU69hI1BghbS2H773PO+Z77
        PTn3XjbuNU1w2RKZmlbKhFI+sZ1hGAsOCp1AJ0Xho1++jh4b65lortlAIM2rBQz9rFlmoNFe
        PQv1TTfi6Na4mYlaLD8wUf+38wx0Z9FZnay3MdBCy22AHA0/EajHPsNEvzzNQD8ONhGoulvP
        RF0WGwtpZycx9E3PGoZa9c9ZqGLIwkI2kwGgjystWAKkOps7AWW0tQFqtu0ZTg002FiUxuTA
        qJ72KwT1aMZEUL1tF6mK71YYVE1fO6DWy26wqCrLLEEt9+yhJl4ss1J2vpsfl0cLc2glj5aJ
        5DkSmTiefyot+0R2dEy4IFQQiw7zeTJhAR3PT0xOCT0pkTrXwOcVCaWFzlSKUKXiHzoWp5QX
        qmlenlyljufTihypIkoRphIWqApl4jAZrT4iCA+PiHYK38/PG1i8jCtMvh8uzv4DLoEhzyqw
        jQ3JKFh2c5moAtvZXuRdAO+slG8GzwB8qf0EcwcvAXzwZz/YahnpGgfuwhCAMxNW3B1UYFD3
        2xOWS0WQoXBEayZc7EOWAmi/rHaJcLKcAW33VjdE3mQYLK2rY7qYQe6D66tXNyw4ZDx8aLFj
        brs3YEe3ecMBkktsWLNYuzlHImz9vmmTveHT8T6Wm7nQUVu5ySJob3XgbpZCnamO4ebj0Dzd
        5GS2c6JgqBs85E4HwGsTtzd8cXIn/HT1180ZONDYvMX7YdOjV0w374ZjHVrgOgaSFNQvSlxp
        LzIL1k49BJ+BgIb/Db4GoB340wpVgZhWRSsiZXTxfzclkhf0gI3nHXLKCObn/gobBRgbjALI
        xvk+HNDypsiLkyMsOU8r5dnKQimtGgXRzpV9jnN9RXLn/5CpswVRseFRMTExUbGRMQK+H0fz
        VYjIixQL1XQ+TSto5VYfxt7GvYQF5R61D3twOc2S5zXWysZlD0+6G+5Q6PqqHRcOp5p2JGMX
        Mw5YZ66+lkHWW7Vha/cDi4Lfjrww1pm8agmO86H+SBy632F9R3euM9A0YsrMitwvCoy9lXSe
        Tvecv3K3PmmQV13ZXnygSLH7QZbpml+Q3VDt5/FY3KuXT5XMRfTnln/kmMpL1fg2puUsaX83
        Z2omD9oYTzrSu9hLe7LfOnfQHJB71t9w5npp2rGErMZyyuJ/VjT8QaY1ITXCWIZM3pmxL0Ik
        eNsck3ui9T0WFxNc3/v3FwunV3ZVn15dzw04k75rr3mYd0TMG9DdC50vxsrFN+TkoH/SWrfh
        6AQqOc5nqPKEghBcqRL+CxGtuLFnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJTvdWmmuywZd9MhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJWx80UHc8Ee0YoX
        1/8zNjDuFexi5OSQEDCR2L/2OGMXIxeHkMBuRonvK24wQiRkJP63HWOHsIUlVv57zg5R1Mwk
        cXrWTxaQBJuArsT+pQfYQBIiAq2MEtdXdjKBOMwCs1kkfkw6wApSJSygJ9E4ZQqYzSKgKvHv
        dzfYCl4BW4mbRx4zQayQl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
        czcxgmNJS3MH4/ZVH/QOMTJxMB5ilOBgVhLhZZzvlCzEm5JYWZValB9fVJqTWnyIUZqDRUmc
        90LXyXghgfTEktTs1NSC1CKYLBMHp1QDUzjz1KzlGQ0z7G+f1+C2iVq91GTFtR1M3FLtgQnf
        M80nZS1eyPvrx1eVpTu/Wq9Nr1HfPrEuLP6m2Dzze9Vv2zUnHFA7VfWr6+2NIyaaV29OiDb/
        HLGIR7uXv/TvhcJGW+MDoWe2bJvp91f6g+rqWoG0jRx/6o3eeN0TOJG14kmP8LPrr5Z5JEle
        iuJ4z3Gb4WdCgvbXi9zmaRp3+eptD516+r1nZmB56dKrwicWNzlIe65Ozmrcwn/8kvri+mbm
        Nzyzbyma6dmU1KlbMP2r8vg5/doOR5lNM/Xk2kV8Dj9wzdX4ZD9t464crdDJ7pln89edLv/X
        0GbvJf9mFod32uRlrjOTrq4qDEooEzgsoMRSnJFoqMVcVJwIADrzEMIUAwAA
X-CMS-MailID: 20221011125138epcas5p21b0a93e3bde26c3377e3fa7f34d86933
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125138epcas5p21b0a93e3bde26c3377e3fa7f34d86933
References: <CGME20221011125138epcas5p21b0a93e3bde26c3377e3fa7f34d86933@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds MFC v12 support. MFC v12 is used in
Tesla FSD SoC.

This adds support for following:

* Add support for VP9 encoder
* Add support for YV12 and I420 format (3-plane)
* Add support for Rate Control, UHD and DMABUF for encoder
* Add support for DPB buffers allocation based on MFC requirement
* Update Documentation for control id definitions

Changes since v2:
 - Addressed review comments by Rob Herring.
 - Addressed review comments by Krzysztof Kozlowski.
 - Addressed review comments by Andi Shyti.

Smitha T Murthy (15):
  dt-bindings: media: s5p-mfc: Add new DT schema for MFC
  dt-bindings: media: s5p-mfc: Add mfcv12 variant
  media: s5p-mfc: Rename IS_MFCV10 macro
  media: s5p-mfc: Add initial support for MFCv12
  Documention: v4l: Documentation for VP9 CIDs.
  media: v4l2: Add v4l2 control IDs for VP9 encoder.
  media: s5p-mfc: Add support for VP9 encoder.
  media: s5p-mfc: Add YV12 and I420 multiplanar format support
  media: s5p-mfc: Add support for rate controls in MFCv12
  media: s5p-mfc: Add support for UHD encoding.
  media: s5p-mfc: Add support for DMABUF for encoder
  media: s5p-mfc: Set context for valid case before calling try_run
  media: s5p-mfc: Load firmware for each run in MFCv12.
  media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF
  arm64: dts: fsd: Add MFC related DT enteries

 .../devicetree/bindings/media/s5p-mfc.txt     |  75 ---------
 .../bindings/media/samsung,s5p-mfc.yaml       | 164 ++++++++++++++++++
 .../media/v4l/ext-ctrls-codec.rst             | 167 +++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  21 +
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   |  60 +++
 .../platform/samsung/s5p-mfc/regs-mfc-v7.h    |   1 +
 .../platform/samsung/s5p-mfc/regs-mfc-v8.h    |   3 +
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  |  36 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  56 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |   9 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  51 ++-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    | 410 +++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  16 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c |  12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 435 ++++++++++++++++--
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |   7 +-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  44 ++
 include/uapi/linux/v4l2-controls.h            |  33 ++
 19 files changed, 1349 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

-- 
2.17.1

