Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8674F556
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjGKQcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjGKQcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:32:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47FE7E;
        Tue, 11 Jul 2023 09:32:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BFVO6I027999;
        Tue, 11 Jul 2023 16:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=uBr7zMLDJXBH2GPBouC+mshXnukFubY8SffHMPcenPU=;
 b=gsjHIXgVtEgS5PwhaX2Cj68YZgWTA6ydasfcZ6X1AbSv7HAS/CHHEGhjmJIGpE9m6wms
 3V8xHI+uh6BTBEHaeGABsYfx6Lw/hB9HzL7yYVAcNKRS3UfqBckc6+zBb+6jjvdrSLwn
 og4UXLQBYvuf4tb08C91sDSedZaH9ltqsUt4+lLEOe0KZ9NVndSgG7IaT74QE1YOoAVR
 IqfeSGb0JofANq0NC7CrVtcX0rxFWMOqzu2Kv1H47/AzIq3jthcTj9ymFITCbynz4Qk7
 Ua+R46/EG41MOqMO45Gaai4ZqFQbgwrPb0gm3GQcDtWOz5lkdaLBHTvjXLKTMi9mnDDq ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj6378x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:32:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGQGx8007109;
        Tue, 11 Jul 2023 16:32:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx854cg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:32:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BGQBXT019529;
        Tue, 11 Jul 2023 16:32:05 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rpx854c4h-6;
        Tue, 11 Jul 2023 16:32:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     quic_asutoshd@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        Can Guo <quic_cang@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Lu Hongfei <luhongfei@vivo.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: core: Update contact email for monitor sysfs nodes
Date:   Tue, 11 Jul 2023 12:31:47 -0400
Message-Id: <168909306212.1197987.7624893253606524856.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630003913.3713155-1-quic_cang@quicinc.com>
References: <20230630003913.3713155-1-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=824
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Proofpoint-GUID: o-9FDE1H0cnDk5YZ8uUqD46aRWZcPhvm
X-Proofpoint-ORIG-GUID: o-9FDE1H0cnDk5YZ8uUqD46aRWZcPhvm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 17:39:09 -0700, Can Guo wrote:

> Update contact email addresses for Can Guo and Asutosh Das, replace
> Subhash Jadavani's contact.
> 
> 

Applied to 6.5/scsi-fixes, thanks!

[1/1] scsi: ufs: core: Update contact email for monitor sysfs nodes
      https://git.kernel.org/mkp/scsi/c/ef470b862dc7

-- 
Martin K. Petersen	Oracle Linux Engineering
