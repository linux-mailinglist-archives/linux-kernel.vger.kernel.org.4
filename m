Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304A6D3BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjDCCPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDCCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:15:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89D9751;
        Sun,  2 Apr 2023 19:15:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332LixoP008023;
        Mon, 3 Apr 2023 02:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=Xu7hxzHWg1GV5VbFTZHnDf3VeuIiLhcHX+Z5vYrEgog=;
 b=zqxP6AlIsvf6FAptq9AoamUJPb0By8PTLQve7CRafKrbdosxDAorpm+GwD7fd+VcrAaA
 Rp9uj017gOa1z92/yfHvHO25WiD3xgpzyMgv2satATBeRe9Sna0L8iciGA9Y60RHYeyk
 k0c8kAHyZx63e6pCqKoFUkCduyQFK+Kq8e38QS1+YiNRpsYQjBVnSGYjseRnSfgEUZUL
 jajBHzderRNxrhfaPXgZqzsh/b92tpQm9z94TF0WYv2rDZ5+PmtiRM0fnWwdczsJoJrC
 0VZ3uiUXNKIJU9EkPfeQ1UTg5rZxhgnK+SZt+hPKOXxtc0EDCFIk/npvEotHMdkVVZgr KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71j26n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3331jXZ3013907;
        Mon, 3 Apr 2023 02:15:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3ddbpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 02:15:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3332FHwj010318;
        Mon, 3 Apr 2023 02:15:19 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ppt3ddbn7-3;
        Mon, 03 Apr 2023 02:15:19 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Bodo Stroesser <bostroesser@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] uapi: target: Replace fake flex-array with flexible-array member
Date:   Sun,  2 Apr 2023 22:15:04 -0400
Message-Id: <168031383543.650124.8544574837401067751.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <ZBSchMvTdl7VObKI@work>
References: <ZBSchMvTdl7VObKI@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=725 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304030015
X-Proofpoint-ORIG-GUID: uu1SvPznW0d-c7kUgYBXcA2PIEn1FrCK
X-Proofpoint-GUID: uu1SvPznW0d-c7kUgYBXcA2PIEn1FrCK
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 10:59:48 -0600, Gustavo A. R. Silva wrote:

> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Address the following warning found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
>   CC      drivers/target/target_core_user.o
> drivers/target/target_core_user.c: In function ‘queue_cmd_ring’:
> drivers/target/target_core_user.c:1096:15: warning: array subscript 0 is outside array bounds of ‘struct iovec[0]’ [-Warray-bounds=]
>  1096 |         iov = &entry->req.iov[0];
>       |               ^~~~~~~~~~~~~~~~~~
> In file included from drivers/target/target_core_user.c:31:
> ./include/uapi/linux/target_core_user.h:122:38: note: while referencing ‘iov’
>   122 |                         struct iovec iov[0];
>       |                                      ^~~
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] uapi: target: Replace fake flex-array with flexible-array member
      https://git.kernel.org/mkp/scsi/c/5c8c74ef20e7

-- 
Martin K. Petersen	Oracle Linux Engineering
