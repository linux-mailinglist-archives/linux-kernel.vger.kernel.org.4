Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7476F5057
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjECGuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjECGuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:50:22 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE573C11
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 23:50:15 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230503065003epoutp040a0e0107bdb83efa993d12bd72009497~bj3GMNtCP2576525765epoutp04W
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:50:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230503065003epoutp040a0e0107bdb83efa993d12bd72009497~bj3GMNtCP2576525765epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683096603;
        bh=CM+8mMQP2iq+VCp4c684wdumP+wzl9e8MEJfoEWqXDI=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=o0NMDxX6PyNlAvMh6mMIKdIXzA52+uIgyfnTp1Q/esM406ft09ZJAh2HME98OM3Ip
         cIiD+bK+ejavG8f6SeBtQUFKrGz9ElmVQt6CZuU39Tyr9U6At1ObljfA44LiQqflYP
         XrQyKSLaVfCEPPdFfRqfL6R7AoVSyl/38ENLk/JU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503065003epcas2p38a30ebb96e1684d4c852825b0d0d9e7a~bj3Fsuu4D0342503425epcas2p3r;
        Wed,  3 May 2023 06:50:03 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QB6yL2Cnzz4x9Q0; Wed,  3 May
        2023 06:50:02 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-8c-6452041a1bc4
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.78.03265.A1402546; Wed,  3 May 2023 15:50:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] scsi: ufs: core: Use readable 'return 0' in
 ufshcd_hba_capabilities()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Keoseong Park <keosung.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <28ea2183-d1ce-f42d-1765-9d07d7481eda@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503065001epcms2p55114ae8c2d6dc6bbae680af747177454@epcms2p5>
Date:   Wed, 03 May 2023 15:50:01 +0900
X-CMS-MailID: 20230503065001epcms2p55114ae8c2d6dc6bbae680af747177454
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmma4US1CKwcrHvBYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYtGNbUwWx0++Y7S4vGsOm0X39R1sFgc+rGK0WH78H5PFwo65LBZL
        t95kdOD1uHzF22PTqk42jwmLDjB6tJzcz+LxfX0Hm8fHp7dYPCbuqfPo27KK0ePzJjmP9gPd
        TAFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
        KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
        ChOyM5afvcVW8Jy34uGsbsYGxincXYycHBICJhLXbl5n7GLk4hAS2MEoMXFmB0sXIwcHr4Cg
        xN8dwiCmsEC8xLzXwSDlQgJKEl0LtzKD2MICBhLrpu8Bs9kE9CSm/L4DNkZE4AaLROPhDlaI
        +bwSM9qfskDY0hLbl29lBLE5Bawl1v+6yQQR15D4sayXGcIWlbi5+i07jP3+2HxGCFtEovXe
        WagaQYkHP3dDxSUlWs9sZYOw6yVa359iBzlCQmACo0TjsT9Qg/QlrnVsBDuCV8BXYvazo2AN
        LAKqElvun4c6wkVizZSrYHFmAXmJ7W/nMIM8zyygKbF+lz6IKSGgLHHkFgtEBZ9Ex+G/7DAv
        Nmz8jZW9Y94TqOlqEo8WbIEGiYzExTnnmCcwKs1CBPQsJHtnIexdwMi8ilEstaA4Nz212KjA
        EB63yfm5mxjBiVjLdQfj5Lcf9A4xMnEwHmKU4GBWEuH9UOiXIsSbklhZlVqUH19UmpNafIjR
        FOjjicxSosn5wFyQVxJvaGJpYGJmZmhuZGpgriTOK217MllIID2xJDU7NbUgtQimj4mDU6qB
        yVp9joJn2/WIDo6da5q+V60O78/S++atJOli5P/jt8ZV2ZKcBxNFLcISdxvtN6ooX1XM4tO4
        1da33/i+14yMn4cTT9YJ3JnAxB+V4yAbmORxdO4OAbE7Sfv3XO76sltZIGXnrZSfKR0Gs167
        Cji7mfTyeeguXybRHCkjWWzTd+LVVakixj9pLMxbgsXXHOyOf9Cb++bbYr/k050vr8pyJR1P
        sGfmKjS5FK3oxGz3R2lGx4775We9LC25pSae/cDCtsnPprT0tWIPq8D3af82LUldafiSUy3J
        UOOmVdNGQa1F7pM+n3y78VCYRwHrjIhtqxXZv929ppWwrOdKiJimaeUD0Zybu7snv6970q3E
        UpyRaKjFXFScCADt+7QjTQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502113116epcms2p7b83da0d683e29f667c38f5430b985388
References: <28ea2183-d1ce-f42d-1765-9d07d7481eda@acm.org>
        <20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p7>
        <CGME20230502113116epcms2p7b83da0d683e29f667c38f5430b985388@epcms2p5>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 5/2/23 04:31, Keoseong Park wrote:
>> The 'err' variable is the result of ufshcd_hba_init_crypto_capabilities()
>> regardless of MCQ capabilities. Return 'err' immediately when the function
>> error occurs. And if it is not an error, explicitly return 0.
>> 
>> Anyway, if ufshcd_hba_init_crypto_capabilities() returns error, MCQ
>> capabilities is not used because it fails to initialize UFS driver.
>> 
>> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
>> ---
>>   drivers/ufs/core/ufshcd.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 9434328ba323..44328eb4158d 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -2343,18 +2343,20 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>>   
>>   	/* Read crypto capabilities */
>>   	err = ufshcd_hba_init_crypto_capabilities(hba);
>> -	if (err)
>> +	if (err) {
>>   		dev_err(hba->dev, "crypto setup failed\n");
>> +		return err;
>> +	}
>>   
>>   	hba->mcq_sup = FIELD_GET(MASK_MCQ_SUPPORT, hba->capabilities);
>>   	if (!hba->mcq_sup)
>> -		return err;
>> +		return 0;
>>   
>>   	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
>>   	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
>>   				     hba->mcq_capabilities);
>>   
>> -	return err;
>> +	return 0;
>>   }
>
>The most important change in this patch is that ufshcd_hba_capabilities()
>returns earlier if ufshcd_hba_init_crypto_capabilities() fails. Please
>change the patch title such that it reflects this change instead of the
>other less important change.

OK, I will change it.

Best Regards,
Keoseong

>
>Thanks,
>
>Bart.
