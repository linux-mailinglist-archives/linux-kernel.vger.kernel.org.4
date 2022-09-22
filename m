Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6451F5E5A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIVFIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiIVFH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:07:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D3ABF2E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:07:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M4qTg6012553;
        Thu, 22 Sep 2022 05:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : from : cc : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=nT3B/wMBqejh6lpCW83oSITogIn6brmx377SfiSL784=;
 b=Bng88UVhdAxAeCGD7TDDXMvRK3L479yINS/lkf+GaYsU4kiknjhERbc630q+OQ3e/ygW
 qii7XR8rv+WsfFwglMLuM5R52u46YkQAHd10Wp9FvSEF854FzNXBwXOk8Jds7p2SRrrF
 U/mLDsqRRaudUaosDbcyN15x7LbMgK6T0P/it4MlMupzN9wvwrcWMmvpcXLZg36ZoUFP
 dgo1Mt970fg+W/u5wFYeStXLcnqx8GBurCav/jpELKsCWHBgWcolohxqDo+oC7d1bBPH
 vFLDtqOTRu/ZJeULhxe6wSp0GaLJXuMBT5KM55snbtR9qWmB+HwV7ikKixpfUcZSKFnV YA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jqtd6n6vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 05:07:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28M52dIi011236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 05:02:39 GMT
Received: from [10.216.24.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 22:02:35 -0700
Message-ID: <cfa26ff3-c95a-1986-58fc-b49fc9be49d5@quicinc.com>
Date:   Thu, 22 Sep 2022 10:31:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
To:     <cristian.marussi@arm.com>, <sudeep.holla@arm.com>
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_avajid@quicinc.com>
Subject: Query regarding "firmware: arm_scmi: Free mailbox channels if probe
 fails"
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9kijr2JaBsrUNKjqwquqznrYt31zJDWv
X-Proofpoint-GUID: 9kijr2JaBsrUNKjqwquqznrYt31zJDWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_02,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=844 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,


Do you have any update or suggestion regarding thread 
https://lore.kernel.org/lkml/20211105094310.GI6526@e120937-lin/T/#m07993053f6f238864acad4e9bad9f08d85aeb019.

We are still getting this issue and wanted to check if  there is any fix 
that I can try.


Thanks,

Shivnandan

