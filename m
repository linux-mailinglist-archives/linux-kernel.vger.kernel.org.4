Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED5705CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjEQCNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjEQCND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:13:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B74231;
        Tue, 16 May 2023 19:13:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJwrAo019730;
        Wed, 17 May 2023 02:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=55MGMGUzUAtw4duf2ws1S6xkNzpHCTWAzSn31GTVsZQ=;
 b=ighBMhKdWsEUqE/cwWsTC8Fg0i/0i+JIPtT8+dq7B0FC1iokD3vO9XjclTlBDIYxueyB
 gpQe2oVqG+L6LKUd/1YWvqSG0iR9vvNFXR7cBiJn8b0AOCSsQkLkwrn7EEc+ly/B8UKw
 ozIBayeoumdJrBGEVwsdXeHIIu3D3vwtL+Wdkd/tf5cUDOFAlJbq4zhxyxL8Ar/sSyb0
 GTjaV6qEqN4V7VHIKCDWqVjPgb+KohB1jaeBrNPi51EPCogJ4cSeJE+XFlmfq48GPv/R
 JZv/NFCu2d/SECtLk2qjk/xkzLT/e2NFrg6rhP3p0ALSux4M0zDmjPy35RwuHbDthRTs Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdmtnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:12:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GN8PGM025063;
        Wed, 17 May 2023 02:12:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104tw1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:12:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H2CdOG016064;
        Wed, 17 May 2023 02:12:44 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj104tw04-4;
        Wed, 17 May 2023 02:12:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>, avri.altman@wdc.com,
        bvanassche@acm.org, jejb@linux.ibm.com, stanley.chu@mediatek.com,
        mani@kernel.org, quic_asutoshd@quicinc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keoseong Park <keosung.park@samsung.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: ufs: core: Change the module parameter macro of use_mcq_mode
Date:   Tue, 16 May 2023 22:12:27 -0400
Message-Id: <168428950410.722180.14993171496306444150.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
References: <CGME20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1> <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170016
X-Proofpoint-GUID: DIpJ777dZ8eCRrpY5S2CqnbjI_6P1qvr
X-Proofpoint-ORIG-GUID: DIpJ777dZ8eCRrpY5S2CqnbjI_6P1qvr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 18:44:20 +0900, Keoseong Park wrote:

> mcq_mode_ops uses only param_{set,get}_bool(). Therefore, convert
> module_param_cb() to module_param() and remove the mcq_mode_ops.
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: ufs: core: Change the module parameter macro of use_mcq_mode
      https://git.kernel.org/mkp/scsi/c/9a4327fd8864

-- 
Martin K. Petersen	Oracle Linux Engineering
