Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E66C7634
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCXDSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXDSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:18:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389A55AD;
        Thu, 23 Mar 2023 20:18:11 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O1dvEn016924;
        Fri, 24 Mar 2023 03:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=BNbeD3ySaTQDwCEDcLt5eGh9bouiy1EAvy296wcI/hQ=;
 b=JchxvEydFK8o3Hh414Y1ok7FUfexcwJnCqjA7RUohRBsM7wi8LvfL5mcHTcE7UNniAOE
 qYqd5CQIQO3TSON11VHf/RiIzznQUkmgoa26poZ5sREJCMpLHpA9+ZQy6ZIYCCBJ+YsJ
 PynNgIz8y7qcm4NrJoeOjf9bp0RoZ0V1zvZwg/lkqgW3zKbk+Pz71AjO5UNUYVolYDTJ
 ahhuzD2TKXxcp6DrHnGmhiP0OOhMikjx4bYJ0lmn2ZTPe4TI6mj/ECDLzrmRfUAieHCu
 SbYx8FT3yFdZnTNx3Jiut7L3oIZAPU+BD5miU12/n3vR+/FVqtPQgxG6UkPXPVb8i5Lh dA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgxtbx10a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 03:17:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLLPZ9025320;
        Fri, 24 Mar 2023 03:17:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pgxkrr96s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 03:17:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32O3Hoco29754022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 03:17:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 283CA20043;
        Fri, 24 Mar 2023 03:17:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16A7920040;
        Fri, 24 Mar 2023 03:17:49 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.122.5])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Mar 2023 03:17:48 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [next-20230322] Kernel WARN at kernel/workqueue.c:3182
 (rcutorture)
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <ae015179-03b5-4e4b-86dd-cbab75230c7f@paulmck-laptop>
Date:   Fri, 24 Mar 2023 08:47:38 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Zqiang <qiang1.zhang@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <23F7ADE0-0B96-4257-8910-6B678E0F0C7A@linux.ibm.com>
References: <139BEB3F-BC1C-4ABA-8928-9A8EF3FB5EDD@linux.ibm.com>
 <fbb628c1-08bd-44ff-a613-794b134f6d46@paulmck-laptop>
 <233B28DA-70DD-4AD8-9C72-1FFCA6EFE56D@linux.ibm.com>
 <ae015179-03b5-4e4b-86dd-cbab75230c7f@paulmck-laptop>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OoTAlPW90XYFrUCV3SZOFYP3mlusXGsr
X-Proofpoint-GUID: OoTAlPW90XYFrUCV3SZOFYP3mlusXGsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_15,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240025
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Hello, Sachin, and it looks like you hit something that Zqiang and I
>>> have been tracking down.  I am guessing that you were using modprobe
>>> and rmmod to make this happen, and that this happened at rmmod time.
>>> 
>> Yes, the LTP test script rcu_torture.sh relies on modprobe to load/unload
>> the rcutorture module.
>> 
>>> Whatever the reproducer, does the following patch help?
>> 
>> Thank you for the patch. Yes, with this patch applied, the test completes
>> successfully without the reported warning.
> 
> Very good, thank you!  May we have your Tested-by?

Tested-by: Sachin Sant <sachinp@linux.ibm.com>

- Sachin

