Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02D5BEB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiITRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiITRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523A4DB05;
        Tue, 20 Sep 2022 10:03:26 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KH2VNZ031286;
        Tue, 20 Sep 2022 17:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fQCvxPU61NHYx0I3QmM1H3vlAIyZOE2m1uOWdTdchJ4=;
 b=mf8cvIizT4KVk3Wd13JhpU+v5Q3vdjgCILM6O/ECQCioNVqlrCneyCRlazCnIYCH0ied
 AZ1OvVq1r0uPMKN6PZxDbM6NJQdIcTvnshFsIlRRYFKzZtdqoVWfL5uTEpt5CdV0xDNY
 c6oamHg9XNrrSJsFMQWFCVAbs2Yriin7w7viwJGZDtI5TB3gwMfrZNsCX41yY5NVSQxB
 WlCJu3oys8EtPD65pmNORlHq4z6piklcIYdTxcsRp3SKvaMpPyeovyox5L1lPNeVsnt/
 xzpFpHjO4JOF0yLq7I7Bq19LpOU9YS6zlUT2jr/AjLoxt0Ixxg43ct9T20qmzxfTL4oM GQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqhjs80h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 17:02:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KGp8ir020400;
        Tue, 20 Sep 2022 17:02:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8m6u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 17:02:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KH3EsG52691370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 17:03:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47A13AE04D;
        Tue, 20 Sep 2022 17:02:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C22B1AE051;
        Tue, 20 Sep 2022 17:02:47 +0000 (GMT)
Received: from localhost (unknown [9.43.42.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 17:02:47 +0000 (GMT)
Date:   Tue, 20 Sep 2022 22:32:46 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 0/2] make weak attributes in {k,u}probes
To:     anil.s.keshavamurthy@intel.com, borntraeger@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        gor@linux.ibm.com, guoren@kernel.org, hca@linux.ibm.com,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, namit@vmware.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org, x86@kernel.org,
        Yipeng Zou <zouyipeng@huawei.com>
Cc:     chris.zjh@huawei.com, liaochang1@huawei.com
References: <20220917015522.44583-1-zouyipeng@huawei.com>
In-Reply-To: <20220917015522.44583-1-zouyipeng@huawei.com>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1663692878.h3l8c563n8.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yRFZ6NnVwkeJV_6MthdEmUtO_Y_I2tyz
X-Proofpoint-GUID: yRFZ6NnVwkeJV_6MthdEmUtO_Y_I2tyz
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_07,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=677 bulkscore=0 clxscore=1011 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209200098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yipeng Zou wrote:
> We have some function implementation under some arch does nothing.
> We can mark it with weak attributes to improve.

That's not always an improvement. See [1] for an example, among many=20
other patches to reduce use of __weak functions in the kernel.

As an alternative, please consider the approach used in [1].


- Naveen

[1] https://lore.kernel.org/all/20220519091237.676736-1-naveen.n.rao@linux.=
vnet.ibm.com/

