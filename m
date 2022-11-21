Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548D26320E6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiKULlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKULkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:40:31 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3427178B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:40:15 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221121114012epoutp019b06af25896f0769d789f38e1beda112~plq5fTqHL1567715677epoutp01F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:40:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221121114012epoutp019b06af25896f0769d789f38e1beda112~plq5fTqHL1567715677epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669030812;
        bh=k6BCQhAc1QJjlToPfL6iH8ZV8+rahLxp9IWGdjPBumQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vF/ZzhPyxPa0R4v7CcV6Q60iK9Lowf4B8nRM5w5+6XJKr/jn1pefh8ggg1ORfdZ/2
         ctSYc/zoURoQlH52hBcdEIgFq5lkYIYApeWF2X7jGFFyQbWkOzoyOBSFQvh601o6tz
         eVoAyyYSNSA2klT9j9738XS0bwlSxQ5/DG8XzmoU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221121114012epcas5p1c4d1e194fef85cdd2d3699e7ffb12130~plq5M-G4M2845828458epcas5p13;
        Mon, 21 Nov 2022 11:40:12 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NG56L4NN7z4x9Pv; Mon, 21 Nov
        2022 11:40:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.2F.01710.A936B736; Mon, 21 Nov 2022 20:40:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221121090555epcas5p29c8c7de6dba38449aaf3357beb43432d~pjkMhPQ0A2126421264epcas5p2C;
        Mon, 21 Nov 2022 09:05:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121090555epsmtrp2972a73b8f017fef049d485f7478297ab~pjkMgh6F12801828018epsmtrp2N;
        Mon, 21 Nov 2022 09:05:55 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-7c-637b639abba8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.19.18644.37F3B736; Mon, 21 Nov 2022 18:05:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121090554epsmtip179528108a46eaed0d211936597639005~pjkLNmTvj1475314753epsmtip1n;
        Mon, 21 Nov 2022 09:05:54 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 0/2] arm64: dts: Add SYSREG nodes for FSD SoC
Date:   Mon, 21 Nov 2022 14:41:16 +0530
Message-Id: <20221121091118.48628-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmuu6s5Opkg5VLFCwezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM541fyMveApc8XcGU+YGhh/MnUxcnBICJhInH4v0sXIySEksJtRYvYJhy5GLiD7
        E6NE/8PTTBDOZ0aJ9//2M4FUgTS0XZ3GDJHYxSix9e8ERginlUmiZ9oaZpAqNgFdidZrn8Ha
        RQS2MEqsPL8TrJ1ZwFPiwJXnYLawgK3Err+3wBpYBFQlGh49YQO5iRcofmyjKcQ2eYnVGw6A
        bZMQ2MYusffAbnaIu10kVr33hKgRlnh1fAs7hC0l8fndXjYIO11i85HNrBB2jkRHUzMzhG0P
        dMIcFpAxzAKaEut36UOEZSWmnloHdSWfRO/vJ1AP80rsmAdjq0ksftQJZctIrH30CWq8h8Te
        /mmMkGCMlbh85xrzBEbZWQgbFjAyrmKUTC0ozk1PLTYtMMxLLYdHU3J+7iZGcALT8tzBePfB
        B71DjEwcjIcYJTiYlUR462Oqk4V4UxIrq1KL8uOLSnNSiw8xmgJDbCKzlGhyPjCF5pXEG5pY
        GpiYmZmZWBqbGSqJ8y6eoZUsJJCeWJKanZpakFoE08fEwSnVwGR3juHN+S+T9237cTKy/M8n
        js2xF+Myz/xw68rr4Y+5tHwGl6RlZtoUy/ZFHnaPzumdTd35buI0hZb/xvn9G+3mGhjZzf1T
        tsP8pphpTYN/8QZ1GQv/OLe+ExW3991pORywpZ2p8Gmy9NpXdw/Lab5j/HXEZuOBt3Wzrpys
        fDnj7eGOGzNT6nnXJFnPkXb2et+5WDCpYGrwsXDH9yu4zxxWZQz/kxXdEPZP7KhD3VWd9JNe
        L9TEA/rq1moWujz7qmJ6TPTT2YdSPickU3vDpvAbFvAuON2/7X/ClGTWNAmfNOm7D1pyAqW/
        Jb6ODqy02/P/YtrxwNl3/m55W3P1ypupt04vuGa77Iuq4poKRw8lluKMREMt5qLiRADU0aQq
        6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTrfYvjrZ4PpuA4sH87axWcw/co7V
        ou/FQ2aLHW0LWSwu75rDZrFo6xd2i4cf9rBbtO49wm5x+806VgdOj02rOtk87lzbw+bRt2UV
        o8fnTXIBLFFcNimpOZllqUX6dglcGa+an7EXPGWumDvjCVMD40+mLkZODgkBE4m2q9OYuxi5
        OIQEdjBKrH36iRUiISNx8sESZghbWGLlv+fsEEXNTBJXfr5jAUmwCehKtF77zASSEBHYwyjx
        bvoJoG4ODmYBb4kpv9VAaoQFbCV2/b0FNohFQFWi4dETNpASXqD4sY2mEPPlJVZvOMA8gZFn
        ASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4HDS0trBuGfVB71DjEwcjIcYJTiY
        lUR4RY5VJgvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXA
        tPOCW3n3b0mel6Fhi/q/9OU277Mv9NjJY35x2dX49IZbEzPEii81BpofXLOvSU8v7EnyXR7T
        B+bXeln7PYw7b5xJ2G27wO1SnWJ02HrOhuba0zeehtSwJ7KfaluxZemr+Uuf3vra/mBHMSeH
        1qynXXoOu2tP2B8pOu+s4X390m9Rua6VgQz7p66bJdO/pVd7l9Li/8Z/Zsw/FsjI/O50+x0D
        m+V/Jm6YrTTzek5OPkdZxF+HveEvHOIZ2bpfLPKYmFVoknj4b0Waz8aG1SczfT8l1BQt2P/Y
        fYagkmdGSMXDxdoRHzu4bu46WCKVPnN9f0fbo7SXHXrTFn+W8A3XvF3+91fLpdbKm4YT+taK
        KrEUZyQaajEXFScCAMnYbGqWAgAA
X-CMS-MailID: 20221121090555epcas5p29c8c7de6dba38449aaf3357beb43432d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121090555epcas5p29c8c7de6dba38449aaf3357beb43432d
References: <CGME20221121090555epcas5p29c8c7de6dba38449aaf3357beb43432d@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSD SoC has three sysreg nodes one in PERIC block and other two are in
FSYS0 and FSYS1 block. This patch series add required DT binding and
DT file modifications.

Sriranjani P (2):
  dt-bindings: mfd: syscon: Add tesla compatibles found on FSD SoC
  arm64: dts: fsd: add sysreg device node

 Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi                | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.17.1

