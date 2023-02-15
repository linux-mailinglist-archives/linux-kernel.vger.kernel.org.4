Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEB698171
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBOQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:58:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EB233DB;
        Wed, 15 Feb 2023 08:58:16 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FG6oCw002832;
        Wed, 15 Feb 2023 16:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0Z6Gjb5kPHb3KDCWYT0wsNV5ujNln5w12ihJdPAd5k0=;
 b=gd1FHh2gEXNeQ34L/PYtJ7fpN+3Ucn+AucdfcN0U2g5WWoBxTE23RK95s7YEvXBaRj+J
 1AFKXP8qwWgg37/CipxFtqov0bBSK/Jl21ulkJ+F1nHQI79wfn4+j663sgXUxU6iM9OT
 o3/vbwaxY49FrbS07dGLgEg/x6ekp674X5ra/8l9M+LAcVFPD/gOwM5a9oEg+o4jSBel
 a+eioLVJUobhMGVehHRfLgGP4oC5/wqx8O5tu/rcxg5wKQFfnLiBxmfrlMgOjfZ8MbDb
 oEtgQr7brDReh+ky+42g4cgB64FxGiBj+ElhJeoIe3GIrERTk2rA6JrbbmNsETCk3Sqd ow== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkmje4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 16:58:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31FGwBhW004211
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 16:58:11 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Feb
 2023 08:58:10 -0800
Message-ID: <d35633ea-4049-6f51-3a3a-2a258a4af037@quicinc.com>
Date:   Wed, 15 Feb 2023 08:58:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/3] mailbox: Allow direct registration to a channel
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230213232537.2040976-1-quic_eberman@quicinc.com>
 <20230215101732.pbpom3ub3yh75n4w@bogus>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230215101732.pbpom3ub3yh75n4w@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uHz88WbATykub5Nxeey4JWl_YL45w4n0
X-Proofpoint-ORIG-GUID: uHz88WbATykub5Nxeey4JWl_YL45w4n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=756 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150152
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 2:17 AM, Sudeep Holla wrote:
> On Mon, Feb 13, 2023 at 03:25:34PM -0800, Elliot Berman wrote:
>> Two mailbox controllers have channel/client binding mechanisms that are
>> controller-specific and not using the devicetree binding mechanisms. Mailbox
>> channel/client is conceptually done in two steps: selecting the channel
>> and binding the selected to channel to a client. Channel selection is sometimes
>> controller specific (pcc and omap are examples). The channel/client binding
>> code is all the same.
>>
>> This small series de-duplicates and refactors the channel/client binding
>> into a common framework function: "mbox_bind_client" which all of the
>> channel selection mechanisms can use.
>>
>> I found this duplicate code while working on the support for Gunyah hypervisor
>> message queues [1]. I've only been able to compile-test omap-maiblox and pcc,
>> however it is a straightforward conversion here.
>>
>> [1]: https://lore.kernel.org/all/20230120224627.4053418-9-quic_eberman@quicinc.com/
>>
>> Elliot Berman (3):
>>    mailbox: Allow direct registration to a channel
> 
> I am unable to find the above patch either in my inbox or in lore[1].
> Can you please repost the same ? I would like to test/review w.r.t PCC
> driver.
> 

Hi Sudeep,

Not sure why the patch didn't end up your inbox; lore seems to have 
linked it correctly and indicates you were in To:. If I missed 
something, let me know and I'll make sure you're properly included if 
future versions needed.

https://lore.kernel.org/all/20230213232537.2040976-4-quic_eberman@quicinc.com/

Thanks,
Elliot

> --
> Regards,
> Sudeep
> 
> [1] https://lore.kernel.org/all/20230213232537.2040976-1-quic_eberman@quicinc.com/
> 
