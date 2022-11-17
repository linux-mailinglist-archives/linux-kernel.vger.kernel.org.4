Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDF62D1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiKQDcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiKQDb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:31:57 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C88E2C5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 19:31:54 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221117033114epoutp0274408966b4ec4db8596b7bfa8bc36999~oQa1jDkqD2995229952epoutp02_
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:31:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221117033114epoutp0274408966b4ec4db8596b7bfa8bc36999~oQa1jDkqD2995229952epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668655874;
        bh=iW+EEZ5DDVxBNv18mHjY1/pchzwXF/LQI1zg/4DYalw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q1OQgmepYYDq6VE3T5rfC/jPPlHa684iEqbh4H8leop9nI8bfl4pshrRfMJVDQBpe
         QR9pz9SQi7hWXzyWFBi7Jgf9eNrRwljbKbZGksYqOkNORXnctP9b3R+zgnfgUkmy80
         P9EKreeUjBuiZVGSmX3afIc8s7MFUGIRMva7wlB8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221117033114epcas5p4344972b0baef6246c7e3c76b7377a396~oQa1LSuyY3006930069epcas5p48;
        Thu, 17 Nov 2022 03:31:14 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NCQS12G8lz4x9Pp; Thu, 17 Nov
        2022 03:31:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.A9.56352.EFAA5736; Thu, 17 Nov 2022 12:31:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221117033110epcas5p23a5a214690a4956d35463962153a27ba~oQaxnZfWC2865428654epcas5p27;
        Thu, 17 Nov 2022 03:31:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221117033110epsmtrp1274f90a6499cd9e4c85f61d214ffbf1a~oQaxms2v91179311793epsmtrp1N;
        Thu, 17 Nov 2022 03:31:10 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-39-6375aafe089b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.F7.14392.EFAA5736; Thu, 17 Nov 2022 12:31:10 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221117033109epsmtip223250a609729a653ae71a51060acd2e7~oQawjr4HJ0188201882epsmtip2L;
        Thu, 17 Nov 2022 03:31:09 +0000 (GMT)
Date:   Thu, 17 Nov 2022 08:49:51 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221117031951.GB392@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221116171935.GA24524@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmlu6/VaXJBkvvmFn833OMzWLCv0VM
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
        e+y+2cDm8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjPuv9zMWbGWvWLvzCksD4wK2LkZODgkBE4meB99Zuxi5OIQEdjNKXFq9
        E8r5xCjRfnMzM4TzjVHi6efVcC1r90yESuxllHg1bxIThPMMqOXgXSCHg4NFQFVi+1UzEJNN
        QFPiwuRSkF4RASWJp6/OMoKUMwucZ5S4/Gw5I0hCWCBS4tGK62CtvALaEpvawOp5BQQlTs58
        wgJicwroSMw+sBPMFhVQljiw7TjYWgmBTg6J+zeXMkMc5yLRcuAXC4QtLPHq+BZ2CFtK4mV/
        G5SdLHFp5jkmCLtE4vGeg1C2vUTrqX6wOcwCGRInWndD2XwSvb+fgN0mIcAr0dEmBFGuKHFv
        0lNWCFtc4uGMJVC2h8TKlw/ZIEGygVFi05K5jBMY5WYh+WcWkhUQtpVE54cm1llAK5gFpCWW
        /+OAMDUl1u/SX8DIuopRMrWgODc9tdi0wDgvtRwex8n5uZsYwSlUy3sH46MHH/QOMTJxMB5i
        lOBgVhLhLVEvTRbiTUmsrEotyo8vKs1JLT7EaAqMnYnMUqLJ+cAknlcSb2hiaWBiZmZmYmls
        Zqgkzrt4hlaykEB6YklqdmpqQWoRTB8TB6dUA9PJfylfWdbf39949UFKckjTsjV55x0XB/2c
        ySJRe4XTc/7XQyKuvx97hy85ydwkvmJ5WHz3NLP2lSaeEm4f9/fnCiuHFSZerXNaE7+lfuH+
        9kOdK4sdDT8rrFDe+eTvweQPbo+l3VZ45RXdiImz4ZowreeFyTuzC3JT1Ur3HvvMt/Z63uLK
        /EPMXU1zI9vWJfxP2jHh98PIxgm/br7zUogOE/y21m6CfKC1x50u7RMBW3/P2uRxLfj2vWLV
        md/Pe++sz7g5QXEXF/+XbPkjq5VfqZzZcK8p9GbuhHtL/V99CWFnZ2ea9DXDu23ixMt31TuP
        cnz6emci0/sHAZ9efVu7L1dJyLxvxvvTGix8by91KbEUZyQaajEXFScCAIMAeSAqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO6/VaXJBjNuKlv833OMzWLCv0VM
        FitXH2WymHToGqPF5V1z2CzmL3vKbrHu9XsWB3aPnsmr2T0mNr9j9zh/byOLx6ZVnWwem5fU
        e+y+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfG8sNTWQqes1Sc/7WdsYHxDXMXIyeHhICJxNo9
        E4FsLg4hgd2MEhvabzNCJMQlmq/9YIewhSVW/nvODlH0hFHi6qxNQB0cHCwCqhLbr5qBmGwC
        mhIXJpeClIsIKEk8fXWWEaScWeA8o8TNtpVgM4UFIiUerbjOBFLPK6AtsamtFGLkBqC9s9rB
        angFBCVOznzCAmIzC5hJzNv8EGwVs4C0xPJ/HCBhTgEdidkHdoKViAooSxzYdpxpAqPgLCTd
        s5B0z0LoXsDIvIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzgmtDR3MG5f9UHvECMT
        B+MhRgkOZiUR3hL10mQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
        ZJk4OKUamGK73vFFPAo4vrLn7GzvMv1oX2+D+v/H58Za8Su9+ucVUWd/YIvyua/879kNKnIe
        Tzd8UqTjsP8CY+8cHw3fYhtupYMGhkJ7zDcI/OYOj31o9C1Lf/HOuy+uPuKdNPfjosKojYZM
        mz8umLOye3drl7BifnV15Zczl9Ktfa/5mXfeWdTr/Hay85mPjMslJj9s+2ZTN/83w4ftOre2
        O1lq3l5jOU+d5bRdwZVNlr4lHx9EPk15FlqX//Jt81OFP3/1P/MoBVxMLytkYLp0w1thxswv
        kZtevQ/8P3tz2JcPMs4tni+kpG9UZh7Nd1rLt0fk2K2WrHebizo4o6UMK1y/MunsZfjlsE1L
        KZVDcb3ELiWW4oxEQy3mouJEACZTnNv4AgAA
X-CMS-MailID: 20221117033110epcas5p23a5a214690a4956d35463962153a27ba
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4cb27_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221116172324epcas5p3d9877249797ac741ead5785cba27e00e
References: <20221116171727.4083-1-git@augustwikerfors.se>
        <CGME20221116172324epcas5p3d9877249797ac741ead5785cba27e00e@epcas5p3.samsung.com>
        <20221116171935.GA24524@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4cb27_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Nov 16, 2022 at 06:19:35PM +0100, Christoph Hellwig wrote:
>On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
>> reports eui as 0001000200030004 when resuming from s2idle, causing the
>> device to be removed with this error in dmesg:
>>
>> nvme nvme0: identifiers changed for nsid 1
>
>What EUI did it report before? Is the identifier stable after
>multiple resume cycles?
>
>Can some of the Samsung folks here reach out to the relevant firmware
>team to see if they have any clues?

I will check.

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4cb27_
Content-Type: text/plain; charset="utf-8"


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_4cb27_--
