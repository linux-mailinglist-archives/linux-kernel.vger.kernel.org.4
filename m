Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4F65BB6ED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIQHYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQHYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836B45F7B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220917072359epoutp0191f0f9c55b1451bf8e7ebb8d1607dd1d~VlPojJrgx2007820078epoutp01Y
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220917072359epoutp0191f0f9c55b1451bf8e7ebb8d1607dd1d~VlPojJrgx2007820078epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399439;
        bh=h/4r2gEtnptD3nTlpYtosI79Zc0cl2MuMZT/t5g8j7c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=a3JQfVXNDPB2lTf/XD4EHD3dsjbJXI66BvMIE4VA616AVWS32kGgCzTm+6urD0DCl
         HdmfDXT7DewJ0jnsjeLkYraw+s8cJlpJA2pPERMi49n4O9etDVwPPiFId3IVA+WBVG
         s/uJJ6QsxZEXqin05d+jZVMKjUInEjDnm4nwZVkQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epcas1p1321a2b30b98d399b138f1354bf507725~VlPn9n06a0249502495epcas1p1U;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MV2Vj5fmkz4x9Px; Sat, 17 Sep
        2022 07:23:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.71.51827.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p3fea7d947782d9ce58d91249533e0c1f7~VlPmUAIq_0974609746epcas1p3Q;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp25cc98e975fa0587e14882dbf1a216ff7~VlPmSuZ0W1654916549epsmtrp2s;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a36-f25ff7000000ca73-27-6325760d68ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.F0.18644.C0675236; Sat, 17 Sep 2022 16:23:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072356epsmtip208adf45c36e874da31948459d2147ece~VlPmECPXb0131701317epsmtip2S;
        Sat, 17 Sep 2022 07:23:56 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 00/13] Samsung Trinity NPU device driver-v2
Date:   Sat, 17 Sep 2022 16:23:43 +0900
Message-Id: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTX5e3TDXZ4EarpsXfScfYLaY+fMJm
        0bx4PZvF++7dzBZ7X29lt7i8aw6bxe3GFWwW+3o+Mlo8n3adxYHT4/evSYwem1Z1snncubaH
        zWP/3DXsHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQ
        l5ibaqvk4hOg65aZA3SVkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3
        uDQvXS8vtcTK0MDAyBSoMCE7Y97CdYwFPxQqFvT4NzA+lOxi5OCQEDCR6H3C2sXIxSEksINR
        YsatGYwQzidGifu77jFBOJ8ZJZ5t/c/WxcgJ1tF86hJUyy5GiR+7LiNUzfm5nxWkik1AVWLm
        jDXsILaIQLlE88YTYDazQI7EkztNzCC2sICdRMuTD2BTWYDqJ+2YxgJi8wpYS8xaOIEZwhaU
        ODnzCQtEr7xE89bZzCDLJASusUvMew6yGeQkF4lT+5ZC2cISr45vYYewpSQ+v9sLdXa2xJSO
        RSwQdoHEuedbmSEBYCxxcUUKiMksoCmxfpc+RIWixM7fcxkh1vJJvPvawwpRzSvR0SYEUaIk
        seTPYahFEhJTZ3yDOsBDYv2tqWC2kECsxNSGfvYJjHKzkDwzC8kzsxAWL2BkXsUollpQnJue
        WmxYYASPxuT83E2M4KSoZbaDcdLbD3qHGJk4GA8xSnAwK4nwqnqqJAvxpiRWVqUW5ccXleak
        Fh9iNAUG6URmKdHkfGBaziuJNzSxNDAxMzI2sTA0M1QS59XTZkwWEkhPLEnNTk0tSC2C6WPi
        4JRqYNJ/6n7uz6u9U76tr7aaO1Ex+owiv+ptt6YFlSdm3ioxsxKwbOgLm2dWkZrFmuN8t9XA
        T7xeQTGjlnEqa0TPl5wKlay0R4E/ZP9qaW6y9t7sOy17VeRLjZmT+U5M21Xw7NbvuXWl3P78
        Sm5rTJlVP10yf9yyxuPFjrva5ZxKuq9OZ+aYtjcu2etoePNUtVu/sMm+fxdiXl/1lzVOqV23
        6N3tM290ftx6PKc6redW//HKh1mWn92PnIq59jlDvY0lqVy9o3ePV+clBT6WQ3oz96Z0Cz43
        2BnAG8mxtVeq5OhRW5n1zoWnrVdrM4tzrbRyL33HzPIpeEO9YP49hbdNu/fLSfebz7rreVTU
        smivEktxRqKhFnNRcSIARwYc6hMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvC5PmWqywbOT5hZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGvIXrGAt+KFQs6PFvYHwo2cXIySEh
        YCLRfOoSaxcjF4eQwA5GiW/Pj7NAJCQkNt1bztzFyAFkC0scPlwMUfORUeJT+wVmkBo2AVWJ
        mTPWsIPYIgK1EgePzgeLMwsUSMx+OhNsjrCAnUTLkw9sIDYLUP2kHdPA4rwC1hKzFk5ghrAF
        JU7OfMIC0Ssv0bx1NvMERt5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P
        3cQIDlQtrR2Me1Z90DvEyMTBeIhRgoNZSYRX1VMlWYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQamkxeeLv94XFLyrgxbkan/lD0HFvy78eb0revcJ67a
        66qkt/245cnSojlxvtTtUobHGz02hG31XMJ+7ZZJ2MwJIT8FW21lJrefknzEf/+QZHZczun7
        G5TCPmZPmXAjfGq0bM3bW1NS2VNqrX5mS+0Uns8xPzP49aaNjV4/vXtnXuhwtOvwSb9SwLJ/
        7cTe7TJPUjK0ndTjuiyXbeI2EznBvjFF5PyhtZVn5ILOzlj21kdmkd/DZ1wsukGT80+pHy5s
        NP/SouiXV5ToOeHZxlcRpgwfq3XCjGYdMXw2b0nQr12nVOd3Gm5benKmBrO96ZLGGb8E8m4w
        Lmj5I1Twznan1dQXn12jDN9wq3czLEg9rsRSnJFoqMVcVJwIACUIm/PDAgAA
X-CMS-MailID: 20220917072357epcas1p3fea7d947782d9ce58d91249533e0c1f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p3fea7d947782d9ce58d91249533e0c1f7
References: <CGME20220917072357epcas1p3fea7d947782d9ce58d91249533e0c1f7@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch set is v2 of Samsung Trinity NPU driver.
As reviews of v1, unnecessary logs are removed, and essential documents
including binding and ABI are presented.

There were some violations like user space access, abstraction and open
count. They modified in right way as much as possible, but if there are any
faults, please let me know.

Unnecessary functions are removed, and each patch is reduced
in size for better reading.

Thanks for reviews.

The main changes are:

Since V2:
- Remove all tracing info logs
- Remove abstraction layer for scheduler
- Remove access to user space file
- USE IDA to generate id
- Add ABI document for sysfs
- Add dt-bindings document
- Use default group for sysfs

Link to v1:
https://lore.kernel.org/all/20220725065308.2457024-1-jiho.chu@samsung.com/

I would highly appreciate your feedback.
Reviews, questions or anythings.

Thanks,
Jiho Chu
 
Jiho Chu (13):
  trinity: Add base driver
  tirnity: Add memory module
  trinity: Add IDU feature
  trinity: Add schduler module
  trinity: Add debugfs module
  trinity: add statistics module
  trinity: Add sysfs module
  trinity: Add ioctl feature
  trinity: Add request and pm feature
  trinity: Add profile module
  trinity: Add trace module
  MAINTAINERS: add TRINITY driver
  dt-bindings: arm: Add Samsung Trinity bindings

 .../ABI/testing/sysfs-driver-trinity          |   55 +
 .../bindings/arm/samsung,trinity.yaml         |  115 ++
 MAINTAINERS                                   |    8 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/trinity/Kconfig                  |   25 +
 drivers/misc/trinity/Makefile                 |   13 +
 drivers/misc/trinity/trinity.c                | 1019 ++++++++++
 drivers/misc/trinity/trinity_common.h         |  437 +++++
 drivers/misc/trinity/trinity_debug.c          |  331 ++++
 drivers/misc/trinity/trinity_dma.c            |   83 +
 drivers/misc/trinity/trinity_dma.h            |   87 +
 drivers/misc/trinity/trinity_hwmem.c          |  380 ++++
 drivers/misc/trinity/trinity_hwmem.h          |   81 +
 drivers/misc/trinity/trinity_sched.c          |  338 ++++
 drivers/misc/trinity/trinity_sched.h          |   24 +
 drivers/misc/trinity/trinity_stat.c           |  898 +++++++++
 drivers/misc/trinity/trinity_stat.h           |   56 +
 drivers/misc/trinity/trinity_sysfs.c          |  667 +++++++
 drivers/misc/trinity/trinity_trace.c          |   15 +
 drivers/misc/trinity/trinity_trace.h          |  329 ++++
 drivers/misc/trinity/trinity_vision2_drv.c    | 1685 +++++++++++++++++
 .../misc/trinity/trinity_vision2_profile.h    |  324 ++++
 drivers/misc/trinity/trinity_vision2_regs.h   |  210 ++
 include/uapi/misc/trinity.h                   |  476 +++++
 25 files changed, 7658 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-trinity
 create mode 100644 Documentation/devicetree/bindings/arm/samsung,trinity.yaml
 create mode 100644 drivers/misc/trinity/Kconfig
 create mode 100644 drivers/misc/trinity/Makefile
 create mode 100644 drivers/misc/trinity/trinity.c
 create mode 100644 drivers/misc/trinity/trinity_common.h
 create mode 100644 drivers/misc/trinity/trinity_debug.c
 create mode 100644 drivers/misc/trinity/trinity_dma.c
 create mode 100644 drivers/misc/trinity/trinity_dma.h
 create mode 100644 drivers/misc/trinity/trinity_hwmem.c
 create mode 100644 drivers/misc/trinity/trinity_hwmem.h
 create mode 100644 drivers/misc/trinity/trinity_sched.c
 create mode 100644 drivers/misc/trinity/trinity_sched.h
 create mode 100644 drivers/misc/trinity/trinity_stat.c
 create mode 100644 drivers/misc/trinity/trinity_stat.h
 create mode 100644 drivers/misc/trinity/trinity_sysfs.c
 create mode 100644 drivers/misc/trinity/trinity_trace.c
 create mode 100644 drivers/misc/trinity/trinity_trace.h
 create mode 100644 drivers/misc/trinity/trinity_vision2_drv.c
 create mode 100644 drivers/misc/trinity/trinity_vision2_profile.h
 create mode 100644 drivers/misc/trinity/trinity_vision2_regs.h
 create mode 100644 include/uapi/misc/trinity.h

-- 
2.25.1

