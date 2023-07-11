Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18FD74F538
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGKQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGKQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:32:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76EE10C4;
        Tue, 11 Jul 2023 09:31:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9O4D6003075;
        Tue, 11 Jul 2023 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=nzvpgrmp47PgS++DnG2CJ9zuNLv7T6AupqxWH/6THQg=;
 b=sD7jIX7kVwtxFCDX/CSWZ+PvCJzkFi08KzAQBXpY54KXN36Nwdm/L4vHooxTeR5Yr5dR
 zj9gDNDQVq85HYXoeewYK2wa8FG4f0prNi/zFa5QQHAA/e1VnO5gRh82zznmtShjqsWF
 JwsNMYZityK7AJ+enCBiJwfzyM0lQSLS46gLA+Q2fpW4Z86Nwxg7tvGi4x8AbDVu1Zo6
 WDT/nUS9BOdfEd10T8gO/YU24UmAUV4CKLHmLeyNy1L55mW+3x7xXmGS8z01ZVu5vdVT
 sek+FnXm2OfTn3IfgeM9S61VXgCc2IILSMnRosAYhf2wSqqtiW+GGp0BDQQC16bhNnCn YA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xukrx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:31:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGUtBh007087;
        Tue, 11 Jul 2023 16:31:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx854c65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 16:31:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BGQBXJ019529;
        Tue, 11 Jul 2023 16:31:55 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rpx854c4h-1;
        Tue, 11 Jul 2023 16:31:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Arthur Simchaev <arthur.simchaev@wdc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: Re: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Date:   Tue, 11 Jul 2023 12:31:42 -0400
Message-Id: <168909306217.1197987.12628480788972137019.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626103320.8737-1-arthur.simchaev@wdc.com>
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110148
X-Proofpoint-GUID: kA-rDDGF4Pe8tbZ40RRzeQuNHKawx-Vf
X-Proofpoint-ORIG-GUID: kA-rDDGF4Pe8tbZ40RRzeQuNHKawx-Vf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 13:33:19 +0300, Arthur Simchaev wrote:

> The new qTimestamp attribute was added to UFS 4.0 spec, in order to
> synchronize timestamp between device logs and the host.The spec recommend
> to send this attribute upon device power-on Reset/HW reset or when
> switching to Active state (using SSU command). Due to this attribute,
> the attribute's max value was extended to 8 bytes. As a result,
> the new definition of struct utp_upiu_query_v4_0 was added.
> 
> [...]

Applied to 6.5/scsi-fixes, thanks!

[1/1] ufs: core: Add support for qTimestamp attribute
      https://git.kernel.org/mkp/scsi/c/24befa92ed47

-- 
Martin K. Petersen	Oracle Linux Engineering
