Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B2602DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiJRODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJRODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:03:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE80D2581
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:02:58 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDPbQv008429;
        Tue, 18 Oct 2022 14:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DOKy8TZjBJuaWeQcB9x5tAOPu7knV4WtbkFSgi+edMA=;
 b=XnvZ4gvShWMJsY1UPcIv9miQmU9LgwF/T4KjJqqGkKsrYP9Bso8f6hUWqq4RJdTYGlPg
 a2637CxgS201W3dmdDqTDdBg5Ax5ol68jtjgg+X+iK3Jqlu+ItGDt/RRPFnkOPrftSYT
 YXTOoqNmUuV4w/ZTEIGFPXyt+FtJcxGArsMkB9cO2LQQpzp3JtXlOdKc5ChBl2eKKuIF
 7Kf00eXsBqScG1w6QAda8T5i9hN07XAOaHl8HG3+Waq82Hks9tV6rlWyMIT9odouTuLG
 ZPeOk3wF4ETicTxYvu8pqqK9Orzho9aWwjwFXVpTYOpUcxH//+bC7Bk1Vya2qSSOMyzG jA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9w139pme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:02:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IDsuPo022047;
        Tue, 18 Oct 2022 14:02:35 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 3k9be29w8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:02:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IE2aa443712814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:02:36 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C241B5805C;
        Tue, 18 Oct 2022 14:02:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 213B058060;
        Tue, 18 Oct 2022 14:02:34 +0000 (GMT)
Received: from [9.160.80.75] (unknown [9.160.80.75])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Oct 2022 14:02:34 +0000 (GMT)
Message-ID: <36908c1d-4672-807a-d157-d3ccd0b03148@linux.ibm.com>
Date:   Tue, 18 Oct 2022 09:02:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/5] fsi: Add regmap and refactor sbefifo
To:     Mark Brown <broonie@kernel.org>
Cc:     joel@jms.id.au, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org
References: <20221014220540.55570-1-eajames@linux.ibm.com>
 <Y02SztthO39FYIeu@sirena.org.uk>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Y02SztthO39FYIeu@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dUw-xid7m_220pP6K4mkCtSOkPtuV5-8
X-Proofpoint-ORIG-GUID: dUw-xid7m_220pP6K4mkCtSOkPtuV5-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=744 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/22 12:37, Mark Brown wrote:
> On Fri, Oct 14, 2022 at 05:05:35PM -0500, Eddie James wrote:
>> The SBEFIFO hardware can now be attached over a new I2C endpoint
>> interface called the I2C Responder (I2CR). In order to use the
>> existing SBEFIFO driver, add regmap drivers for both FSI busses
>> and the I2CR. Then, refactor the SBEFIFO and OCC drivers to clean
>> up and use the new regmap drivers.
> Is there any great reason to provide support in the regmap core for this
> rather than just implementing in drivers/fsi?  AFAICT this is just
> ending up as an implementation detail of shared code in drivers/fsi and
> won't have any external users?


One reason is to have a common interface with the new FSI regmap. That 
way abstracting out the bus transfer is trivial in the new SBEFIFO 
driver, assuming the SBEFIFO driver should switch to use the FSI regmap.

But you are correct, I doubt anyone else will use this. I suppose 
SBEFIFO may as well not use the regmap and just use some callbacks for 
whichever bus transfer...


Thanks,

Eddie


