Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE86716A90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjE3RNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjE3RND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:13:03 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64D116;
        Tue, 30 May 2023 10:13:00 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UFnxM2017369;
        Tue, 30 May 2023 19:12:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=FwkP6U9+abkTw5jLxAP82NS3Pqb2yLMLtFGxIOmhkZY=;
 b=IUc1O1SrTMIn+QZWfRSS9AjGAvkYdvByQSrp6ETusmwrvXwnlpUOltNzYRtxq0x3+su9
 okK5FpSsBPPHOgZAR9mczGidpgVLhSdp9Xbkr+wJ/YO9RW31LEqZWsCpH37voqsl6/18
 m2tYXvz2NGHE8n+OW/yOB9XxjcNZNEAV7X6q7GehQlF86gTY+7bWsmMxcGCDuuyM2DsK
 lw+hKYMenVMXCymEvvG8mjtNFCtOXOcQFyFFHa7YaHGKt1AAZdE8612c5GaCiznhWYZN
 0eLUrp8jZXRPt4UhWdMDRaemW6IgGaZfu2yVqfpJ3ufR3nGYPg4lId53E37OmVFg6tI7 Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3quahy9j2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 19:12:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FFE410002A;
        Tue, 30 May 2023 19:12:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 26A8F23694B;
        Tue, 30 May 2023 19:12:28 +0200 (CEST)
Received: from [10.252.5.129] (10.252.5.129) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 19:12:22 +0200
Message-ID: <fc7fcb92-dec6-413a-7b08-1083a444f6fc@foss.st.com>
Date:   Tue, 30 May 2023 19:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/4] introduction of a remoteproc tee to load signed
 firmware images
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <ZHYiYGMHdqxBaDzc@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <ZHYiYGMHdqxBaDzc@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.5.129]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 5/30/23 18:20, Mathieu Poirier wrote:
> On Tue, May 23, 2023 at 11:13:46AM +0200, Arnaud Pouliquen wrote:
>> This RFC proposes an implementation of a remoteproc tee driver to
>> communicate with a TEE trusted application in charge of authenticating
>> and loading remoteproc firmware image in an Arm secure context.
>>
>> The services implemented are the same as those offered by the Linux
>> remoteproc framework:
>> - load of a signed firmware
>> - start/stop of a coprocessor
>> - get the resource table
>>
>>
>> The OP-TEE code in charge of providing the service in a trusted application
>> is proposed for upstream here:
>> https://github.com/OP-TEE/optee_os/pull/6027
>>
>> For more details on the implementation a presentation is available here:
>> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
>>
>> Arnaud Pouliquen (4):
>>   tee: Re-enable vmalloc page support for shared memory
>>   remoteproc: Add TEE support
>>   dt-bindings: remoteproc: add compatibility for TEE support
>>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
>>
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  33 +-
>>  drivers/remoteproc/Kconfig                    |   9 +
>>  drivers/remoteproc/Makefile                   |   1 +
>>  drivers/remoteproc/stm32_rproc.c              | 234 +++++++++--
>>  drivers/remoteproc/tee_remoteproc.c           | 397 ++++++++++++++++++
>>  drivers/tee/tee_shm.c                         |  24 +-
>>  include/linux/tee_remoteproc.h                | 101 +++++
>>  7 files changed, 753 insertions(+), 46 deletions(-)
>>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
>>  create mode 100644 include/linux/tee_remoteproc.h
> 
> Looking at comments from Christoph, there seems to be a good refactoring
> exercise in store for this pathset. 

Yes, a good opportunity to ramp-up on kernel memory management :)

As such I will wait for the next revision
> to look at it.

That's fair. More than that I would prefer to focus first on OP-TEE part that
provides the service. The OP-TEE pull request review could have significant
impacts on the kernel implementation...

Thanks,
Arnaud

> 
> Thanks,
> Mathieu
> 
>>
>> -- 
>> 2.25.1
>>
