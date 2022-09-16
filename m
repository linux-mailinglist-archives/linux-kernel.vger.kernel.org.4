Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CB5BA447
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIPB75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIPB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:59:52 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E3175AD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 18:59:46 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220916015940epoutp0365cf5a3e8c66432d5670a2196aa3fe9e~VNLL9XAo80827808278epoutp03Y
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220916015940epoutp0365cf5a3e8c66432d5670a2196aa3fe9e~VNLL9XAo80827808278epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663293580;
        bh=9G0ppnqCwIQ7bDdIKHP51/CzqD6B6ZK0tZT2BI4TquQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=eyihuuVLtCFtuD6kve0yIcfg5RSKY16SqLfg69vvcVEbSOniPiAuSTMjhyC14VIpn
         y7frmMJXcN0ZdOPc8NHFRym5EFyBVXYgfuIb2IlDItIZNJANLf4AZ3/j+PbP4r7FVn
         YtXcROnKFQ3keI2XNS87SV2Nxs7YIAWB0/i1tTSI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220916015940epcas2p42993e6a2335e42ac91587b8421c652d9~VNLLhZXH60158101581epcas2p4s;
        Fri, 16 Sep 2022 01:59:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MTHLz5FvYz4x9Q0; Fri, 16 Sep
        2022 01:59:39 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.30.61565.B88D3236; Fri, 16 Sep 2022 10:59:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220916015938epcas2p49da7df282a581ba109cb3ed94ddc77cd~VNLKJw2N03027730277epcas2p4t;
        Fri, 16 Sep 2022 01:59:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220916015938epsmtrp100be8cfd8cef5ff0d5b40edf98500e6d~VNLKIw2gz2687026870epsmtrp1Z;
        Fri, 16 Sep 2022 01:59:38 +0000 (GMT)
X-AuditID: b6c32a45-643fb7000001f07d-9b-6323d88bd4cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.95.18644.A88D3236; Fri, 16 Sep 2022 10:59:38 +0900 (KST)
Received: from KORDO040863 (unknown [10.229.8.56]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220916015938epsmtip1ebe5b77a7960d1d2b72853540f72747f~VNLJ8l47J1798417984epsmtip1P;
        Fri, 16 Sep 2022 01:59:38 +0000 (GMT)
From:   "Hoyoung SEO" <hy50.seo@samsung.com>
To:     "'Martin K. Petersen'" <martin.petersen@oracle.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <beanhuo@micron.com>, <bvanassche@acm.org>,
        <bhoon95.kim@samsung.com>, <kwmad.kim@samsung.com>
In-Reply-To: <yq1czbw2ihu.fsf@ca-mkp.ca.oracle.com>
Subject: RE: [PATCH v2] scsi: ufs: add a variant operation in struct
 ufs_hba_variant_ops
Date:   Fri, 16 Sep 2022 10:59:38 +0900
Message-ID: <18d501d8c96f$fa5fba00$ef1f2e00$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQH6/1cAF6qSg90m2bD6JVyUXcFHdQLDRczJAaloHG6teXuWMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmqW73DeVkgz/TNSwezNvGZvHy51U2
        i4MPO1ksvi59xmox7cNPZotFN7YxWdzccpTF4vKuOWwW3dd3sFksP/6PyYHL4/IVb48Jiw4w
        enxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0npJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+P2mt2MBU/ZKtYt+cHawHiCtYuRg0NCwETi
        6vmULkYuDiGBHYwSmzeeYoJwPjFKHDzQxwjhfGaUOHn5CVsXIydYx7+2iWwQiV2MEv/3vodq
        ec4osabhAjNIFZuAlsT1iW/BbBEBc4mJE46ygBQxC7xjlNjX3w6W4BQwlliz6TYjiC0sECXx
        sfkhK4jNIqAqMfvScrA4r4ClxJ1bz5kgbEGJkzOfsIDYzAIGEu/PzWeGsOUltr+dwwxxnoLE
        jrOvGSEWO0nse/aSHaJGRGJ2ZxszyBESAls4JNqvbYP6x0Vi7+qHULawxKvjW9ghbCmJl/1t
        UHaxxI83q5kgmhsYJZa2H4PaZiwx61k7IyQolSWO3II6jk+i4/Bfdogwr0RHmxBEtZLEmbm3
        ocISEgdn50xgVJqF5LNZSD6bheSzWUg+WMDIsopRLLWgODc9tdiowBAe3cn5uZsYwWlXy3UH
        4+S3H/QOMTJxMB5ilOBgVhLh7QtRSBbiTUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cDEn1cS
        b2hiaWBiZmZobmRqYK4kzuuqzZgsJJCeWJKanZpakFoE08fEwSnVwGRUNnOpmy2bZqfv/4X/
        FzaI31ArSf8dYCWjVZTsY3PDNtlfo9yKY33LdY3rz+5ualdPemt/Nn17m4HvY/FjlUvsONmf
        /Zsk95ljVoxYXaDQ/J9OV3NWPNbdXbBLJeyunHs5a4/rBW3GZ52+UTc9hJdzsHwpsL7df1Du
        0rRP9YFKP5ee+TzhwG1lifqCe9o8k368T1ZeqCZd7dT/+nOdWKLLHZvvnYfqjy0oXivMo7+x
        pCw++PQ8A6Yvz5hjtHcWLnL0v2G16lrhy6j/X+qVtlkKdayIfr2Zr4mDJ/J/45Kqh/NqXp4M
        3Pefs3Lu9MVxStaru3/O9pfVe6g8tfTKG+luqYKY4Ajd6Bf/jr2YpMRSnJFoqMVcVJwIAE6Q
        FB9EBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnG7XDeVkg3+XdCwezNvGZvHy51U2
        i4MPO1ksvi59xmox7cNPZotFN7YxWdzccpTF4vKuOWwW3dd3sFksP/6PyYHL4/IVb48Jiw4w
        enxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAHsVlk5Kak1mWWqRvl8CVcXvNbsaCp2wV65b8
        YG1gPMHaxcjJISFgIvGvbSJbFyMXh5DADkaJvieToBISEv8XNzFB2MIS91uOgMWFBJ4ySrw7
        XARiswloSVyf+JYZxBYRMJeYOOEoC4jNLPCDUWLCXieIoZsZJc7MuQ1WxClgLLFm021GEFtY
        IELi2tvjYHEWAVWJ2ZeWg8V5BSwl7tx6zgRhC0qcnPkEaqiRxLlD+9kgbHmJ7W/nMEMcpyCx
        4+xrRogjnCT2PXvJDlEjIjG7s415AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDK
        Sy3XK07MLS7NS9dLzs/dxAiOPy2tHYx7Vn3QO8TIxMF4iFGCg1lJhLcvRCFZiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqaqB93Cf97yROm5ev5dvstr
        r9HOe/e/RhZ6+d5kLYx9rHdx2Qt2FxWe+ckCP9qyd+udPe/jnV7G+S2iqITh7eSD82ad0usR
        LbkbyHZCs8u04u8E2a5rSXoMu5yPJq9c+kk3VCVYvMr1lWe12ee47mqzbRzHdXV0Nu+JCdou
        2eb6TrTSoz81pz7vJJ9Y5k8p7srfXMfXZvu2z+iZcO3CiZ35c9bNXGm248BewzBN7cOeXO5Z
        /9dObn/+/5LlkRdByjXXmL+UM/ZUaSy+GjxbeOcMbj8rIa+fxYI/N71mvcPpLnpH5YPLSt8T
        Kndj/659sllXe7/W4p0xOgVNvaGOmcsCajsFVSf8Vt7nYsqmqcRSnJFoqMVcVJwIANRBkGku
        AwAA
X-CMS-MailID: 20220916015938epcas2p49da7df282a581ba109cb3ed94ddc77cd
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3
References: <CGME20220913075407epcas2p1075426e0ef45b6969e50823d59c374d3@epcas2p1.samsung.com>
        <20220912193703.102267-1-hy50.seo@samsung.com>
        <yq1czbw2ihu.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin K. Petersen [mailto:martin.petersen@oracle.com]
> Sent: Friday, September 16, 2022 10:55 AM
> To: SEO HOYOUNG
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com; beanhuo@micron.com; bvanassche@acm.org;
> bhoon95.kim@samsung.com; kwmad.kim@samsung.com
> Subject: Re: [PATCH v2] scsi: ufs: add a variant operation in struct
> ufs_hba_variant_ops
> 
> 
> Seo,
> 
> > +static inline void ufshcd_vops_check_int_error(struct ufs_hba *hba,
> > +					       bool *queue_eh_work)
> > +{
> > +	if (hba->vops & hba->vops->check_int_error)
> 
> Uhm?
> 
I will fixed it.
Thanks.

> > +		hba->vops->check_int_error(hba, queue_eh_work); }
> > +
> 
> --
> Martin K. Petersen	Oracle Linux Engineering

