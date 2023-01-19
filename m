Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CE6674049
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjASRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjASRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:49:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FDB9005
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:49:02 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JG7Cps017532;
        Thu, 19 Jan 2023 17:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Tb9OixybtBCyFPCDnz9x7s2Bqq8Qp0KlkN3FH+tXIPE=;
 b=VLzXNZ9ypYnZctWCEcadCsobXs6JagtWwWon1dNCFGwGfrtX4/GKc/TzXuDE8xVeNd9z
 4mEW6/0g77rcK3F11LXMAJMC7DxjhTTjJSKyTaKt1t3Ne8etGA0EfYWtRG45fYfIq1Y4
 xymIq8tUZ27nYga47n+66dHhCkrvn30pcfk3IhcBbX6JTG4G3+BCSORzr/PkxhWgGKKd
 Kyzx3VDIax4k12hT0p1nLnEIolJlFbtk+8n7FNgmOTINb7mj/mzsukrumAas3pKdmPS1
 sCZpit3urna1G5kCaN25y3uWdGTt9mftDqmnLHozmeyXXJJwUpM5S2llKJtLA7R136I0 6w== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n78qsbnkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:48:52 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30JFOkiT027632;
        Thu, 19 Jan 2023 17:48:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n3m185k9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:48:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30JHmoSu53871042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 17:48:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11C665803F;
        Thu, 19 Jan 2023 17:48:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E045558054;
        Thu, 19 Jan 2023 17:48:48 +0000 (GMT)
Received: from [9.160.43.39] (unknown [9.160.43.39])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jan 2023 17:48:48 +0000 (GMT)
Message-ID: <ca233daf-1bcd-3b2e-68bc-2b9d48f4c7ee@linux.ibm.com>
Date:   Thu, 19 Jan 2023 11:48:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] fsi: Add regmap and refactor sbefifo
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nirlGIyyvAQCqQqNFU6MBDqjE4QnkRbn
X-Proofpoint-ORIG-GUID: nirlGIyyvAQCqQqNFU6MBDqjE4QnkRbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_11,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=518
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/22 15:51, Eddie James wrote:
> The SBEFIFO hardware can now be attached over a new I2C endpoint interface
> called the I2C Responder (I2CR). In order to use the existing SBEFIFO
> driver, add a regmap driver for the FSI bus and an endpoint driver for the
> I2CR. Then, refactor the SBEFIFO and OCC drivers to clean up and use the
> new regmap driver or the I2CR interface.


I'm abandoning the rest of this series in favor of an FSI master driver 
through the I2C responder. It makes a lot more sense to implement a 
master driver here because then we get all the engine drivers for free, 
rather than rework them to talk over i2c.

Thanks,

Eddie


>
> Changes since v1:
>   - Instead of a regmap driver for the I2CR, just have a private interface
>     driver for FSI, since SBEFIFO is likely the only user.
>
> Eddie James (5):
>    regmap: Add FSI bus support
>    drivers: fsi: Add I2C Responder driver
>    drivers: fsi: Rename sbefifo and occ sources
>    drivers: fsi: separate char device code for occ and sbefifo
>    drivers: fsi: occ and sbefifo refactor
>
>   drivers/base/regmap/Kconfig      |    6 +-
>   drivers/base/regmap/Makefile     |    1 +
>   drivers/base/regmap/regmap-fsi.c |  231 ++++++
>   drivers/fsi/Kconfig              |   32 +-
>   drivers/fsi/Makefile             |    9 +-
>   drivers/fsi/fsi-occ.c            |  766 --------------------
>   drivers/fsi/fsi-sbefifo.c        | 1144 ------------------------------
>   drivers/fsi/i2cr.c               |  116 +++
>   drivers/fsi/i2cr.h               |   19 +
>   drivers/fsi/occ-cdev.c           |  157 ++++
>   drivers/fsi/occ.c                |  536 ++++++++++++++
>   drivers/fsi/occ.h                |   57 ++
>   drivers/fsi/sbefifo-cdev.c       |  218 ++++++
>   drivers/fsi/sbefifo-fsi.c        |   68 ++
>   drivers/fsi/sbefifo-i2c.c        |   73 ++
>   drivers/fsi/sbefifo.c            |  797 +++++++++++++++++++++
>   drivers/fsi/sbefifo.h            |   50 ++
>   include/linux/regmap.h           |   37 +
>   18 files changed, 2398 insertions(+), 1919 deletions(-)
>   create mode 100644 drivers/base/regmap/regmap-fsi.c
>   delete mode 100644 drivers/fsi/fsi-occ.c
>   delete mode 100644 drivers/fsi/fsi-sbefifo.c
>   create mode 100644 drivers/fsi/i2cr.c
>   create mode 100644 drivers/fsi/i2cr.h
>   create mode 100644 drivers/fsi/occ-cdev.c
>   create mode 100644 drivers/fsi/occ.c
>   create mode 100644 drivers/fsi/occ.h
>   create mode 100644 drivers/fsi/sbefifo-cdev.c
>   create mode 100644 drivers/fsi/sbefifo-fsi.c
>   create mode 100644 drivers/fsi/sbefifo-i2c.c
>   create mode 100644 drivers/fsi/sbefifo.c
>   create mode 100644 drivers/fsi/sbefifo.h
>
