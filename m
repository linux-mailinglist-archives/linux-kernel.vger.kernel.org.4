Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844FB740B41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjF1IZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:25:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:26686 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232236AbjF1ISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:18:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5XS79025324;
        Wed, 28 Jun 2023 05:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4bHwza8Eduoh9dzsmAR+RGoikY/FB9VhaVuThdeOOXI=;
 b=GFOT/5L8cIrsYubMz/luaD9gSPvEQ85Z1VnDml8g9RLQNmMR5TYfOKFXS6JzCKvW14Wz
 c0kCEezRfHSvITbo0L6izYdNj3n7sOn5gCJUkK1Sg/58OLsr0cZbjHg7Yh6Mf1rbb3rp
 6VoVdipcuVPeqdw8m21SYgIL5ZLHOB1kVKpaliV6clRkpaw0viNBZNqFxKsHdcqKp7VR
 U5vPkvvFSDDyHEucQQDJZFhA19a5D0pKrNCCYivhTS9nILuUcIpIe+cCLhSfImyhJt4l
 hvYcNcEJVlQIdg5KAmSLSTnR5CQRgfzmbJlxeifme27i4nLB6U+hfPsG4Eo1ePo4QEuR Qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgetpg0nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 05:46:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S5kBJU005524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 05:46:12 GMT
Received: from [10.50.9.120] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 22:46:07 -0700
Message-ID: <7b0b3f88-9ecd-090d-de65-3d4779b64a91@quicinc.com>
Date:   Wed, 28 Jun 2023 11:15:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V24 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1687855361.git.quic_schowdhu@quicinc.com>
 <2023062734-smuggling-bulldog-a46c@gregkh>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023062734-smuggling-bulldog-a46c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pBZIzRLXA8B6fG9SkouqsZYZcdo7sfcZ
X-Proofpoint-GUID: pBZIzRLXA8B6fG9SkouqsZYZcdo7sfcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=846 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 3:52 PM, Greg Kroah-Hartman wrote:
> On Tue, Jun 27, 2023 at 03:19:23PM +0530, Souradeep Chowdhury wrote:
>> Changes in v24
>>
>> *Implemented the comments in v23
> 
> That explains absolutely nothing about what changed at all.
> 
> What would you do if you got a patch series that had this as a change
> list?  What do you expect us to do?
> 
> {sigh}

My apologies on missing out on the specifics.

The main changes in this version are as follows:-

* Updated the documentation of the structure dcc_config_entry
* Renamed "nr_link_list" to "max_link_list"
* Used u64 where applicable
* Removed the locks from ready_read method and also dropped
   the use of unlikely keyword.

> 
