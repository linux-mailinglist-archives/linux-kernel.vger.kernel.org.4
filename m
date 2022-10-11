Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE85FBA49
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJKSYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJKSWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:22:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19123FD4E;
        Tue, 11 Oct 2022 11:22:48 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BHRncI025950;
        Tue, 11 Oct 2022 18:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DDh7tcA94iui9rDktkliYwqfRE6Z3S1aBHpOfy8zETk=;
 b=E4AN3P2Hvr4sS15aBaHg9oMgsVlK0SIlh3gQrpmAZkiL2OOkF6Ri4hW5u0Qrp/+EwmY6
 Zj7dtjlXdLd/mMD/x0hp2C4uSY13SqEeMvMb1s13WWQvxM00vcHNXpLvYMOFRrJyZB4F
 mDCg1YQoYxQiKwAWXa152LQ3Cakgx6lj4+ZSouoO/mglqxaBIWtlAdbfcUKkXc+DHsyC
 vIkCJG6mHnTDrnX0ZWcovyUMlrUZEBwwv0TNgYRCkUWkoPrHgV7G4DX0xOotuZNwPAFz
 BkVjQsG71A5zm157BcrKu4pTeEQImKxtXOVhBdoE+NKzoh0BxFYNIluENCREiaiuhE8z Vw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx2kue0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:22:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BIMbCp024325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:22:37 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 11:22:36 -0700
Message-ID: <ff27b168-38f2-9be4-197c-2920b66b1754@quicinc.com>
Date:   Tue, 11 Oct 2022 11:22:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
 <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 32Jp0yvnEfnfB_W8bdEL1YUVBEPmlF7j
X-Proofpoint-ORIG-GUID: 32Jp0yvnEfnfB_W8bdEL1YUVBEPmlF7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210110107
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2022 11:02 PM, Jiri Slaby wrote:
>> +    char *co_xmit_buf[2];
>> +    int co_xmit_idx;
>> +    unsigned int co_xmit_count;
>> +    spinlock_t co_xmit_lock;
>> +    struct work_struct co_flush_work;
>> +};
>> +
>> +static int rm_cons_notif_handler(struct notifier_block *nb, unsigned 
>> long cmd, void *data)
>> +{
>> +    int count, i;
>> +    struct rm_cons_port *rm_port = NULL;
>> +    struct tty_port *tty_port = NULL;
>> +    struct rm_cons_drv_data *cons_data =
>> +        container_of(nb, struct rm_cons_drv_data, rm_cons_notif);
>> +    const struct gh_rm_notification *notif = data;
>> +    struct gh_rm_notif_vm_console_chars const * const msg = notif->buff;
> 
> So you did not comment on/address all my notes?
> 

Apologies Jiri, I wanted to get some consensus on direction to take the 
RM console driver and missed out the sorting here.
