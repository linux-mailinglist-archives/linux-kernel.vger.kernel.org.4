Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C516340AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiKVP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKVP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:58:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F46B9C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:58:20 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMFZgOR029535;
        Tue, 22 Nov 2022 15:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IiYrMhj8C+q2xAedGORq1xuuaSKuPsPMSy0NhpHh8Gg=;
 b=eSestv4MMb8wcS4zqDPb22TD3NzPEypVmozRLUgwpUKRNOuNYv95HWoCGgeotFoj6qFU
 uZrh7+7CpGM5m72mcr/Lo9LyqrPyxo/7Wv6RYmHyBMIR15lPI9tmGnK7XWBbZqKXzEst
 idDqzpFLDNruT+bJob0GuONOVPLdmvU245ET4dssWutjxtOYlqYihw4jdx7EMxkEnL5e
 kVCSOixK9ZKs+OMUYsj1lTyUPrkCxPjRsDqZGzbIfQtLwdDn5nL9m9EsXZi1q157FXYA
 ZcUvxV0HYYjrX5cIoxVCifSe3lgCim/62k3bLGC8WppAIUiBHD37w7z48wBiJ7wr2r0S cw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m0ptssn78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:57:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMFvmGD015977
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 15:57:48 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 22 Nov
 2022 07:57:47 -0800
Message-ID: <16572c2c-f769-629b-ba9c-0b1835516c72@quicinc.com>
Date:   Tue, 22 Nov 2022 08:57:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
Content-Language: en-US
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     Oded Gabbay <ogabbay@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
References: <20221119204435.97113-1-ogabbay@kernel.org>
 <dbc740e5-4f23-a461-bfa0-e0e8859f45ec@quicinc.com>
In-Reply-To: <dbc740e5-4f23-a461-bfa0-e0e8859f45ec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T5IrZ1KcE-UgEUVDBMGgg98W6oQXTvWc
X-Proofpoint-ORIG-GUID: T5IrZ1KcE-UgEUVDBMGgg98W6oQXTvWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_09,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2022 3:04 PM, Jeffrey Hugo wrote:
> On 11/19/2022 1:44 PM, Oded Gabbay wrote:
>> This is the fourth (and hopefully last) version of the patch-set to 
>> add the
>> new subsystem for compute accelerators. I removed the RFC headline as
>> I believe it is now ready for merging.
>>
>> Compare to v3, this patch-set contains one additional patch that adds
>> documentation regarding the accel subsystem. I hope it's good enough for
>> this stage. In addition, there were few very minor fixes according to
>> comments received on v3.
>>
>> The patches are in the following repo:
>> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4 
>>
>>
>> As in v3, The HEAD of that branch is a commit adding a dummy driver that
>> registers an accel device using the new framework. This can be served
>> as a simple reference.
>>
>> v1 cover letter:
>> https://lkml.org/lkml/2022/10/22/544
>>
>> v2 cover letter:
>> https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/ 
>>
>>
>> v3 cover letter:
>> https://lore.kernel.org/lkml/20221106210225.2065371-1-ogabbay@kernel.org/T/ 
>>
>>
>> Thanks,
>> Oded.
> 
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> I have some nits.  Nothing that I think should be a blocker for this 
> series.

I don't recall if I previously mentioned this.  I'm planning on updating 
the QAIC series to be an accel driver.  Therefore there should be 
at-least 1 user (probably several) for this subsystem in short order.
