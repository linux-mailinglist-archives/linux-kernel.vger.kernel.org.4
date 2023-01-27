Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAF67E87A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjA0OlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjA0OlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:41:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A99530EF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:41:12 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30REMeX6030704;
        Fri, 27 Jan 2023 14:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I/iAj1uQpqnKF8DoBboace+4lHV4n+SnEUspq1vIVf8=;
 b=NQjbsof6GHnzliGwOj+w6+uzCXDynZ0armVup7nn2hGgXkx//r2fcGKLD4EmHIt3NUAj
 yWWTWgWzbewP3emefIhZUSXn0r7s3FUC7UL3+Mj8UgcYgv1D7kNpHxY0ZyPT1awHdx2h
 CcJSyTLlCyqozuEHSlgTc57z3JwUV06za6h2PtWba+cHQ7+gszqurdJHnsdiiYctFsoi
 w66sHiZSB55NAFz1GEXIAUwgjL6iP3Kj+QuEceXzRPqj4QTNadktZpMabtTbi+9eJaCp
 OXasSNYgeycy0Akn3L7FTqNRWx7UdmPKK/zhuY8mPlucOs026GR8YWd6TbJ7fKhowmqC Qg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncgau8gca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 14:41:00 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RE56Hd019851;
        Fri, 27 Jan 2023 14:41:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3n87p7ukdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 14:41:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30REexs88127114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 14:40:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D5A75805A;
        Fri, 27 Jan 2023 14:40:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72C1958051;
        Fri, 27 Jan 2023 14:40:58 +0000 (GMT)
Received: from [9.160.191.74] (unknown [9.160.191.74])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 14:40:58 +0000 (GMT)
Message-ID: <97f6dc04-8a5f-c518-b804-992c7d46829b@linux.ibm.com>
Date:   Fri, 27 Jan 2023 08:40:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fsi: Add aliased device numbering
To:     Jeremy Kerr <jk@ozlabs.org>, linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au
References: <20230126223850.901302-1-eajames@linux.ibm.com>
 <8fa108c9dedf884eab6dacaf3e9680b7c66c4202.camel@ozlabs.org>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <8fa108c9dedf884eab6dacaf3e9680b7c66c4202.camel@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nBo_uXQCwPIOI3Y0uAx3QNuR5k1UcOjB
X-Proofpoint-GUID: nBo_uXQCwPIOI3Y0uAx3QNuR5k1UcOjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_08,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=997
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270133
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/23 19:03, Jeremy Kerr wrote:
> Hi Eddie,
>
>> The I2C and SPI subsystems can use an aliased name to number the
>> device. Add similar support to the FSI subsystem for any device type.
> Sounds good!
>
> However, the majority of this patch seems to be the change to a (const)
> enum value, which you then convert to a string to generate the
> non-number component of the device name.
>
> Does:
>
>         dev_set_name(&scom->dev, "%s%d", fsi_get_dev_type_name(fsi_dev_scom), didx);
>
> have much of a benefit over:
>
>         dev_set_name(&scom->dev, "scom%d", didx);
>
> ?


Hi Jeremy,

I agree, it's not a benefit but my objective here is to make sure the 
device name is definitely the same as what the alias lookup is looking 
for. Perhaps it doesn't matter so much, and I can drop that part of the 
patch...

Thanks for looking!

Eddie


>
> Cheers,
>
>
> Jeremy
