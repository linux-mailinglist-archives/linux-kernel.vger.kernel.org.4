Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7016A0219
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjBWEoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBWEoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:44:17 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438CF1B562
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:44:16 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N4P9JK018050;
        Thu, 23 Feb 2023 04:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tOPu+8AR0Tb7GAwyJHfbA0kiiTWqUMKgPivx8Ui7wPQ=;
 b=X39UayOsKtlSeFIO5klrBN5WSd+GfFO5516rl0t3FFf7vWSlJe6Kmp3ZXpmSi02Xw8SC
 x4nxlCeXFsfUah7hVNdGm3REm7MOfHjd0YO2wQLHGsBz+FM4Q9LWYwOTuVpqMCPc+Vae
 b/WiF3V5EayioZqQYq1Z6pLldHah2X3Bb7fUmtuJBtq4LzgmW4rEyXl0+g4bC2Iuv+ye
 2OkX+7PTXZweeGqZ5gEvVQmObi+Kb9u3G2vlu0HIhNvgwyfZPvxhGX30FptYQmyTPWkw
 3TXGYLRLmUNdhEGcFxhKrssjMuHihgc+fp7hjJUxZI2FIuISwifVDGuMHrc4ObW4aeNs yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx13nr9n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 04:44:03 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31N4QHHa023969;
        Thu, 23 Feb 2023 04:44:03 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx13nr9mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 04:44:03 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MACCeH020323;
        Thu, 23 Feb 2023 04:44:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ntpa64ntq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 04:44:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31N4hw2f47579626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 04:43:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 832A12005A;
        Thu, 23 Feb 2023 04:43:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A71D02004D;
        Thu, 23 Feb 2023 04:43:56 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.109.216.99])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Feb 2023 04:43:56 +0000 (GMT)
Date:   Thu, 23 Feb 2023 10:13:54 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     paulmck@kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and
 wmb to  lwsync
Message-ID: <Y/bvClrV60CXK79G@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
 <20230222174719.GA1400185@paulmck-ThinkPad-P17-Gen-1>
 <87fsaxavk2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsaxavk2.fsf@mpe.ellerman.id.au>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JXL-DZjTI8sgHlLsb-RDXvtha1t3n8rW
X-Proofpoint-ORIG-GUID: zv3HLh0Lqu0squ-vI-fDiTIrrKUWSLV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=974
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> You are correct, the patch is wrong because it fails to account for IO
> accesses.

Okay, I looked at the PowerPC ISA and found:
"The memory barrier provides an ordering function for the storage accesses
caused by Load, Store,and dcbz instructions that are executed by the processor
executing the sync instruction and for which the specified storage location
is in storage that is Memory Coherence Required and is neitherWrite Through
Required nor Caching Inhibited.The applicable pairs are all pairs ai ,bj of
such accesses except those in which ai is an accesscaused by a Store or dcbz
instruction and bj is anaccess caused by a Load instruction."

Thanks for your time, Michael. Sorry for the noise.
> 
> Kautuk, I'm not sure what motivated you to look at these barriers, was
> it just the documentation you linked to?
I read the basic documentation. Now that I have access to the PowerISA
document I guess I'll go through it more thoroughly.
> 
