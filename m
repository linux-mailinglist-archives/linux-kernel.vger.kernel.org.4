Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA41A5E62E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiIVMyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIVMxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:53:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFE3E99A0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:53:23 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MCkSBx031015;
        Thu, 22 Sep 2022 12:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EMMrbPpnVu2KIeviMqn2ADJFSOeRHY+vjNS+Z/uUL4g=;
 b=Djw/J0RTUtlMq8mAjXvAx3MVmmMLny0h0S+g1V6verBy6VY/jiwayzQonrNN0TwTI0Ti
 9hWxFgbBZq3u/vDW/K8cnnEz8a4JNoA1Rarcp2LWzAPfg7q57+9LpGiwuZZJvl9SVL4Z
 HC6p9z/6L+H2JNOfaWWWTZQCkE8SW9n/JhjGoOKVnT58R1H5HwOwVaxfyCOLDrMNUYSF
 ugEHOqGyMhMILexidplyEXvzvQVUBAWdPG/bL7NRhE0ggfNjnKC8HWOdWY1QXJ9i4i8P
 VjUO75V3nP7Ty3vSEnsP8vAgeOZZlNN4HiZwq5X61jFvj7zJYLT40HbYGkky12Kt0d0f RA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrptcaghj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 12:53:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28MCq1vE031346;
        Thu, 22 Sep 2022 12:53:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3jn5ghmyv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 12:53:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28MCr91F30081364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 12:53:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DE7CA4051;
        Thu, 22 Sep 2022 12:53:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5597CA404D;
        Thu, 22 Sep 2022 12:53:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.115.178])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 12:53:08 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [powerpc] Kernel crash with THP tests (next-20220920)
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <YyuhD+7N022PgRA+@monkey>
Date:   Thu, 22 Sep 2022 18:23:04 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>
Message-Id: <5B4296E1-922B-4B01-A16D-CB427761FD2E@linux.ibm.com>
References: <C2C8DA4F-F00F-43E9-ACD8-2A8BACA55893@linux.ibm.com>
 <YyuhD+7N022PgRA+@monkey>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: egoh55Pn-Vyx9HaWGHlKKX99qDCQ2z8X
X-Proofpoint-ORIG-GUID: egoh55Pn-Vyx9HaWGHlKKX99qDCQ2z8X
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 22-Sep-2022, at 5:11 AM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>=20
> On 09/21/22 12:00, Sachin Sant wrote:
>> While running transparent huge page tests [1] against 6.0.0-rc6-next-202=
20920
>> following crash is seen on IBM Power server.
>=20
> Thanks Sachin,
>=20
> Naoya reported this, with my analysis here:
> https://lore.kernel.org/linux-mm/YyqCS6+OXAgoqI8T@monkey/
>=20

Thanks Mike for the pointer.

> An updated version of the patch was posted here,
> https://lore.kernel.org/linux-mm/20220921202702.106069-1-mike.kravetz@ora=
cle.com/
>=20
This updated patch works for me. The test runs to completion without any
issues.

- Sachin=
