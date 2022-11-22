Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92219633FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiKVPPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiKVPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:15:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6643C6FA;
        Tue, 22 Nov 2022 07:15:35 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMEX8k6015368;
        Tue, 22 Nov 2022 15:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rhBffdYPdTlauIRdEqJ7HG27aUNvBoJ3ie8MoayMT0A=;
 b=Wzi0acL257X8dP/rxKmZmg57Y+ydh0es7VHIINK7/7cFxyJd7CIpXs4ncHfO6JjPpa2z
 KxdbbeHYIU//WczBldj/Ak0evZQvSELJEKEDAsee8heHL/49xXM8t0za2xj6AIDeMLC1
 aflp/o42v5+IfxGOPKimLJd5pVdFRseXvdlTcs2WUAVWCCeZkW57sQK2HMJhW5pmj7Dj
 96RCz+TBEd21bZBvSnHkczCatnGJ/avSWdmi/5qX91RL/QxD0maOravzZ7XqXUg8Qs9J
 fznNFslcDKUoJ540AsQs7NBiqipTIUKj/nIa7DZ4bNoCpHcSFPZLZ7W59eWQFW91YwEL aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0x7ywpq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:15:12 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AMCMT7p024785;
        Tue, 22 Nov 2022 15:15:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0x7ywpp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:15:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AMF5AFb014275;
        Tue, 22 Nov 2022 15:15:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kxps8vdww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:15:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AMFFlAI51511710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 15:15:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C9F2A4040;
        Tue, 22 Nov 2022 15:15:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C13F9A4051;
        Tue, 22 Nov 2022 15:15:05 +0000 (GMT)
Received: from localhost (unknown [9.171.79.173])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Nov 2022 15:15:05 +0000 (GMT)
Date:   Tue, 22 Nov 2022 16:15:04 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] lockdown: s390: kexec_file: don't skip signature
 verification when not secure IPLed
Message-ID: <your-ad-here.call-01669130104-ext-3635@work.hours>
References: <20221121072715.836323-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121072715.836323-1-coxu@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xmuclpu3WEszRI2qNbRBVQlm7RMy6X6b
X-Proofpoint-ORIG-GUID: hqOy_mHrsET4QwN4av8WH--pPNhPAy8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_09,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:27:15PM +0800, Coiby Xu wrote:
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -33,10 +33,6 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	unsigned long sig_len;
>  	int ret;
>  
> -	/* Skip signature verification when not secure IPLed. */
> -	if (!ipl_secure_flag)
> -		return 0;

Looking at s390_verify_sig() especially before commit 0828c4a39be5
("kexec, KEYS, s390: Make use of built-in and secondary keyring for
signature verification") I think this condition actually expresses
2 things:
1. the firmware is secure IPL capable and secure IPL keys are
   provided and present in platform keyring.
2. secure IPL is enabled.

Wouldn't this change have implications for machines with older firmware
which doesn't support secure IPL? In this case platform keyring won't
have any secure IPL keys (since firmware doesn't provide them)
and any properly signed kernels will be rejected for kexec in this
function. Unless secure IPL keys are also present in built-in or secondary
keyring (which is possible after commit 0828c4a39be5) - is that what
distributions normally do?
