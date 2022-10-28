Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E66106A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiJ1AGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ1AGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:06:02 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA137963B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 17:06:00 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221028000557epoutp021a8f29aa0f28eb7fe46a753188a33acf~iEt4ZYqza2004720047epoutp02R
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:05:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221028000557epoutp021a8f29aa0f28eb7fe46a753188a33acf~iEt4ZYqza2004720047epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666915557;
        bh=W4vEb0RpV7zSfH+2x6pcpo31LhO6vyzOs3ZF8z/vowk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=ab6aFYlXsO3O3HjT+ChR5VyBKk+Agjo5tkKZi1d8UZov1RqpfqA1ij+gCI9YJs6Q6
         XnShYywUhr8TO8L6MtxuFY+bIJiQJrcI5OAPqaVL13QkgHiHhEn/qJAuk5FBgcMdtL
         G9bwt9f1irLlAcNRHEDnd65d87ANT9EsuxZ4gJWU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20221028000556epcas2p24fe69a712c225da2ac81bb47300eb042~iEt3whXx90981009810epcas2p29;
        Fri, 28 Oct 2022 00:05:56 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Mz2rN1Z1Dz4x9Pp; Fri, 28 Oct
        2022 00:05:56 +0000 (GMT)
X-AuditID: b6c32a47-ac5b870000002127-37-635b1ce42458
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.3D.08487.4EC1B536; Fri, 28 Oct 2022 09:05:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] scsi: ufs: core: Use 'else' in ufshcd_hba_enable()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <87a0d265-f9b3-dbc6-edff-396c5a354f92@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221028000555epcms2p7f1660c757d0af8399af64fa31bd87cb1@epcms2p7>
Date:   Fri, 28 Oct 2022 09:05:55 +0900
X-CMS-MailID: 20221028000555epcms2p7f1660c757d0af8399af64fa31bd87cb1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmme4Tmehkg63fOC1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtHt1+xmjR27+VzWLRjW1MFpd3zWGz6L6+g81i+fF/TA48
        HpeveHss3vOSyWPCogOMHt/Xd7B5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzni38AJzwS3+inXT
        97E2MO7j6WLk5JAQMJH41nSBvYuRi0NIYAejxL+Hx1i7GDk4eAUEJf7uEAapERZwl3izaTEr
        iC0koCTRtXArM0TcQGLd9D1gNpuAnsSU33cYQeaICHxhluh8uJ8dYgGvxIz2pywQtrTE9uVb
        GUFsTgFriRNT/0HVaEj8WNbLDGGLStxc/ZYdxn5/bD4jhC0i0XrvLFSNoMSDn7uh4pISrWe2
        skHY+RJPbvZD7aqRWLD9M1RcX+Jax0awOK+Ar8S1x8/BbBYBVYmfE1+wQtS4SLzpbQGrZxaQ
        l9j+dg4zKByYBTQl1u/SBzElBJQljtxigfmqYeNvdnQ2swCfRMfhv3DxHfOeMEHYahKPFmyB
        2iQjcXHOOeYJjEqzEAE9C8neWQh7FzAyr2IUSy0ozk1PLTYqMIbHbXJ+7iZGcLLVct/BOOPt
        B71DjEwcjIcYJTiYlUR4z94ITxbiTUmsrEotyo8vKs1JLT7EaAr08URmKdHkfGC6zyuJNzSx
        NDAxMzM0NzI1MFcS5+2aoZUsJJCeWJKanZpakFoE08fEwSnVwLRhX0rW71PH+Bh81uputfnz
        4cxPe8NPSpMYk3rczLzEbtz9UPH4SGkwo8lRrpaGY61HXmYV9F0/FfTLosbnV94vFqZjxSwc
        f+cEnjnbHp82P5DDxLH5z/svShdPpv/n2nJh086JchUTJrh/zqsPjbizWUv1xMKIrq7ZW4VV
        CoUO8+9MDPUXfs/4a/3rpf+mnrm3vbX+nViC90J5TrP2+b9erZ550kA2xU2Ld+VH9217dM6F
        Wyz0smZYWMPOwt64eMLqWdceNjR+nOE7i4+nbMLVsp6cxm8W+65Kmqv+kRR4e4Sd6W21g3eK
        CEPEj/0fajbcMeITmG2vFVN8q3qCyvLtJQKeR9surpxyfonUyQ4lluKMREMt5qLiRAAizHzh
        PwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93
References: <87a0d265-f9b3-dbc6-edff-396c5a354f92@acm.org>
        <20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
        <CGME20221027062013epcms2p7af8fbc60caaba50686233492fb3dfd93@epcms2p7>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

>On 10/26/22 23:20, Keoseong Park wrote:
>> Convert if (!ret) { ... } if (ret) { ... } into
>> if (!ret) { ... } else { ... }.
>> 
>> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
>> ---
>>   drivers/ufs/core/ufshcd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 7256e6c43ca6..3b794be53287 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -4670,7 +4670,7 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
>>   			ret = ufshcd_dme_enable(hba);
>>   			if (!ret)
>>   				ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
>> -			if (ret)
>> +			else
>>   				dev_err(hba->dev,
>>   					"Host controller enable failed with non-hce\n");
>>   		}
>
>If ufshcd_hba_enable() is modified it should be converted into the widely
>used "if error return" style. How about the untested patch below?

Thanks for your feedback.
That seems to be better.
I will apply it to the next version.

Best Regards,
Keoseong

>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>index 05feec10fad3..89f8b86c3f85 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -4668,14 +4668,16 @@ int ufshcd_hba_enable(struct ufs_hba *hba)
>  		/* enable UIC related interrupts */
>  		ufshcd_enable_intr(hba, UFSHCD_UIC_MASK);
>  		ret = ufshcd_dme_reset(hba);
>-		if (!ret) {
>-			ret = ufshcd_dme_enable(hba);
>-			if (!ret)
>-				ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
>-			if (ret)
>-				dev_err(hba->dev,
>-					"Host controller enable failed with non-hce\n");
>+		if (ret) {
>+			dev_err(hba->dev, "DME_RESET failed\n");
>+			return ret;
>+		}
>+		ret = ufshcd_dme_enable(hba);
>+		if (ret) {
>+			dev_err(hba->dev, "Enabling DME failed\n");
>+			return ret;
>  		}
>+		ufshcd_vops_hce_enable_notify(hba, POST_CHANGE);
>  	} else {
>  		ret = ufshcd_hba_execute_hce(hba);
>  	}
