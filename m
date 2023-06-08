Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE2727488
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjFHBna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjFHBnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:43:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B626B1;
        Wed,  7 Jun 2023 18:42:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357M1aWQ017139;
        Thu, 8 Jun 2023 01:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=h7JRWbyTHucf9/F0C2dIxrJbefyf3Q8Ccm0lELi6Yl0=;
 b=EFOPFaxK2SJRo0VckNRg+ad0NukySROX+jR1VkO+uW8SJFUbX0/1lnShBcptZP73MoAQ
 pqBmrq8QjI5EDo6ga5XVE/F7G+Zv+wtATmNtTvgzsK84EgYav6ExsCeJLreFXSloVwlA
 nWYV5+bO8+8AtjCrhLN7CB5qrY56Ir5CXHuSrRVxuhWvxuqhR1fhkpu7hiT24VfEOMIl
 cw/FSmEBQhO1L2jnLMkszOpjfzb36BXW/OiXDCFNzUEOhZhbk+Pv3rRUBezFOE4P5TVZ
 7TULWv7DXHTimFxJL332UzPLIjY8MmCmohTddeU4zckv2cwdg0eD8LHow/jx6IMRvVB9 Yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pk6qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3580195H036498;
        Thu, 8 Jun 2023 01:42:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hyt95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:42:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3581gQUx031871;
        Thu, 8 Jun 2023 01:42:40 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r2a6hyt3a-11;
        Thu, 08 Jun 2023 01:42:40 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: virtio_scsi: Remove a useless function call
Date:   Wed,  7 Jun 2023 21:42:15 -0400
Message-Id: <168618844257.2636448.10449034140884036644.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
References: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=679 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080011
X-Proofpoint-ORIG-GUID: xe7hLWhUF81nOTjLB1hjmVU8DMjD0FMc
X-Proofpoint-GUID: xe7hLWhUF81nOTjLB1hjmVU8DMjD0FMc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 09:35:08 +0200, Christophe JAILLET wrote:

> 'inq_result' is known to be NULL. There is no point calling kfree().
> 
> 

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: virtio_scsi: Remove a useless function call
      https://git.kernel.org/mkp/scsi/c/0e5e41ee3d73

-- 
Martin K. Petersen	Oracle Linux Engineering
