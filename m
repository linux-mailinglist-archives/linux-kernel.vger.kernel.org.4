Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699A730D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbjFOCRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjFOCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:16:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247D26A1;
        Wed, 14 Jun 2023 19:16:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJgDOw011728;
        Thu, 15 Jun 2023 02:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=3B6DgmKg4feFHE1q6/SLFheC4kDWxd+19rU5My6shqs=;
 b=nkUxBd1/JEmxYb8TSv/tC3W2Zxng4AFPYre0UW29dOTJJN5jhHWIAPFnqiqHDfylmv2t
 iPCqY6OVhziHDV52VBaLv5KkJ0NtLhuqvfvt0iztTMT2XBkayvc7YBTy+AG1erHvr+1U
 1eXUQsFElVu3tqvUY5C4prW7998Qnl/JyakD9SoFJfaOcfz7ygJcnvnPkDOa4jRp9lzo
 C6mQ+OVgHZ1v9ABFcZrNW5ZW9o13nlsbXnJp7IZl3zkkfjGNPY4qenatw1t5KSGNOYZA
 2Q8KwQCxjaQ357nPXSmIWj3DyAtuEBopdVgint1BSr/8719igPdF27FL3KWxN/2ASHjN CA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu0tsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:16:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F0Cakj016284;
        Thu, 15 Jun 2023 02:16:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6bnxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:16:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F2EE7L027953;
        Thu, 15 Jun 2023 02:16:29 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6bnx8-4;
        Thu, 15 Jun 2023 02:16:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Zhang Hui <masonzhang.xiaomi@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhanghui <zhanghui31@xiaomi.com>, Bean Huo <beanhuo@micron.com>,
        peng.zhou@mediatek.com, yudongbin@xiaomi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
Date:   Wed, 14 Jun 2023 22:16:23 -0400
Message-Id: <168679535174.3778526.1520467700618125833.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601124613.1446-1-zhanghui31@xiaomi.com>
References: <20230601124613.1446-1-zhanghui31@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150017
X-Proofpoint-GUID: NSPy7KiN5VbpDbTz73ZwQUN3GONj_1lF
X-Proofpoint-ORIG-GUID: NSPy7KiN5VbpDbTz73ZwQUN3GONj_1lF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 20:46:14 +0800, Zhang Hui wrote:

> When qdepth is not power of 2, not every bit of the mask is 1, so
> sq_tail_slot some bits will be cleared unexpected.
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
      https://git.kernel.org/mkp/scsi/c/e01d05bbf634

-- 
Martin K. Petersen	Oracle Linux Engineering
