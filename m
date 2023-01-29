Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFC68006B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjA2Rbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2Rba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:31:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E021715A;
        Sun, 29 Jan 2023 09:31:29 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDlkJd012236;
        Sun, 29 Jan 2023 17:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=qdC0xyKLoaOTuMWEF/2CnwWlSq5XIkTv79tuQEfcKlM=;
 b=VW8nLNYK+paIbt6urRpNm/3q/sqocgSiDCsaTd1+HCCComNS+Rx0CRUoLxm+ajUV0hf0
 vXutvC0vvAd5GZv3SvwAcZK9E+BU/YlPbNmHhcKzYoB7TFX+VduXJ/hqY1SvBCZuexOY
 4wkWDCMIIR0HCXZtbfhbkEMEssL4bjh/IhSrLfR8RvtH2t+Jv9SASBI2m603ke5mlzuG
 GsYaioAR+a03HINTT9NMvwDcp4quz214ULy13eTAcabQnpfgeWi0d/vUsGmiL0TUlxll
 L6KcaZ3riJg/CnuLsyAYll6bpwjmsWImFIyHp+Ed+S/+TwTAZGL7hlEINEoCJ1d0/DFx Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv1469e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 17:31:06 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30THV6S6030161;
        Sun, 29 Jan 2023 17:31:06 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddv14699-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 17:31:06 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30TDR3Hh026758;
        Sun, 29 Jan 2023 17:31:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtmpvar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 17:31:05 +0000
Received: from b03ledav001.gho.boulder.ibm.com ([9.17.130.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30THV3Zw38994628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 17:31:04 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B6B6E050;
        Sun, 29 Jan 2023 17:33:07 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31A7E6E04E;
        Sun, 29 Jan 2023 17:33:05 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.211.110.248])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 17:33:05 +0000 (GMT)
Message-ID: <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create
 block device
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Zhong Jinghua <zhongjinghua@huawei.com>,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        hare@suse.de, bvanassche@acm.org, emilne@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
Date:   Sun, 29 Jan 2023 12:30:30 -0500
In-Reply-To: <20230128094146.205858-3-zhongjinghua@huawei.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
         <20230128094146.205858-3-zhongjinghua@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uaOUbDbeIJ7bzyBQmbqB9mkUuaqfIdK-
X-Proofpoint-GUID: tLV0rDBztqfXhwftHdWv4OmWn1a9UCGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_09,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
> This error will cause a warning:
> kobject_add_internal failed for block (error: -2 parent: 1:0:0:1).
> In the lower version (such as 5.10), there is no corresponding error
> handling, continuing
> to go down will trigger a kernel panic, so cc stable.

Is this is important point and what you're saying is that this only
panics on kernels before 5.10 or so because after that it's correctly
failed by block device error handling so there's nothing to fix in
later kernels?

In that case, isn't the correct fix to look at backporting the block
device error handling:

commit 83cbce9574462c6b4eed6797bdaf18fae6859ab3
Author: Luis Chamberlain <mcgrof@kernel.org>
Date:   Wed Aug 18 16:45:40 2021 +0200

    block: add error handling for device_add_disk / add_disk

?

James

