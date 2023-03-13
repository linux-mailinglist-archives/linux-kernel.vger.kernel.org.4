Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A96B8423
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCMVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCMVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:43:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0CEEB67
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:43:11 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DLE0AC002745
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : to :
 from : subject : content-type : content-transfer-encoding : mime-version;
 s=pp1; bh=1e7xSsLbQplYJGkDFpxrlHRXdlKoqX1vhxiMrXvLSgQ=;
 b=Hwu02Ecbd7K1grye/9S4C24rWlNh+7Q3AB0N30gBxtIf3L0UTDxyYHOzLfxkEL3d9LNT
 HGb7Zl4EooCr8x8a8rya7giWMTq0S4fPABr0Zip9sgA7OyhUsMFhk8UQWr8VVR+KSnBf
 oA5nAK07n4pZ/vUkjx3JFMSHxR/G4fMTnqQvj905lC2KD6g2Rukws7GzBdRmiyYypYMj
 AoahrgSecHAfzjvy3jrn1ptO9Kny9+HcHF0MedO43HV0ErQjy6rR4RNXxskMW0HuFQoX
 XaKSZYY2u+W3z6o18h8TBhoMhjNI5vVjje4kWW6XCDQXavMmRf3BPzJtDcYx/GWRGz8r bw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pabjggn9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:10 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DJJGi2006299
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3p8h97c4nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DLh8qA61604138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62C8558056
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2416458052
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:08 +0000 (GMT)
Received: from [9.65.198.39] (unknown [9.65.198.39])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:43:08 +0000 (GMT)
Message-ID: <7c91820d-0153-e4db-1c60-38b6f650ed20@linux.ibm.com>
Date:   Mon, 13 Mar 2023 17:43:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: Documentation on IMA for Linux Kernel Documentation
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QwKttDXsnblwfmLV6iHVfoVSpBGefYNV
X-Proofpoint-ORIG-GUID: QwKttDXsnblwfmLV6iHVfoVSpBGefYNV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=283 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130166
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing documentation on IMA targeting users (not kernel 
developers).  It includes concepts, details on writing policies, the IMA 
event log format, utilities, and more.  It aggregates existing scattered 
documentation, but adds much more.  It's maybe 1/2 done.

Questions:

1. Are there people who could look at it and see if I'm on the right path?

It's a lot of work.  I'd like to know that it has some chance of acceptance.

2. What is the process for getting a block of documentation added to 
https://www.kernel.org/doc/html?

