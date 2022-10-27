Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB36260EE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiJ0C6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiJ0C6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:58:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEAA129759;
        Wed, 26 Oct 2022 19:58:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R2QpgS031689;
        Thu, 27 Oct 2022 02:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=k6ZU+P8tmLjNyBSjuy6RdIh9glWRfQVzSYbPhFRsL18=;
 b=C+IUy5tSoOe7V+FrYmtR/rNBiYglDh6WN33VyY6z0QLM2KzR/mGlvEdH9uDnJUqq09lo
 QMlI2X/s4TmYmQ+HAYNXsFX4N/X8nzyyG0gXcRM14V+rIL3ElfplHEDvLt34qF2J9Vv6
 5PHYoR2QDG4OR9YVRzDkUE45XeJ/Ns96DJJTi0UD8Y//0dJcgFWA6nLmmRrqI8QYOSaR
 3zpx0tEDKLSN1kNzdBCdpUd/m+KsycMhXW5YVDjjjGvEmTD30qxPzGib5cLWBOBjv8l9
 ir4gjwFdzAXE+BgaGtYKnQYKvp8D3sc6ISRsYl7D3rWxKH4Yi3DZUUWl5S9S0ZBoqjid MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv0ufu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:58:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM7d6O006671;
        Thu, 27 Oct 2022 02:58:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaggh3h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:58:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29R2wWsd007945;
        Thu, 27 Oct 2022 02:58:36 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kfaggh3fk-4;
        Thu, 27 Oct 2022 02:58:36 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] target: Remove the unused function transport_lba_64_ext()
Date:   Wed, 26 Oct 2022 22:58:29 -0400
Message-Id: <166683942537.3791741.15158391298780922138.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221018081235.124662-1-jiapeng.chong@linux.alibaba.com>
References: <20221018081235.124662-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270015
X-Proofpoint-ORIG-GUID: 9mLTkERhK033oQOm3qATffU-xNMWbNqq
X-Proofpoint-GUID: 9mLTkERhK033oQOm3qATffU-xNMWbNqq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 16:12:35 +0800, Jiapeng Chong wrote:

> The function transport_lba_64_ext() is defined in the target_core_sbc.c
> file, but not called elsewhere, so remove this unused function.
> 
> drivers/target/target_core_sbc.c:276:34: warning: unused function 'transport_lba_64_ext'.
> 
> 

Applied to 6.2/scsi-queue, thanks!

[1/1] target: Remove the unused function transport_lba_64_ext()
      https://git.kernel.org/mkp/scsi/c/621a323c3a7e

-- 
Martin K. Petersen	Oracle Linux Engineering
