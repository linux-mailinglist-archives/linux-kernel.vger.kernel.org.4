Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C876AF8BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCGWcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCGWcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:32:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC9E7B114;
        Tue,  7 Mar 2023 14:32:32 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327FEULh003451;
        Tue, 7 Mar 2023 22:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ta5Vpfm87qjvX/lqhv2vJzZiXNq0T2VHXd4yuanzdD4=;
 b=YLJENy4O+Q9mVISQMwHmlye5cnmoe3E1d3I9wnRC4ipg7V4Qq5A0JvS5VNSQv86uRLIW
 gxjR25iLRSg5LJWFfSyCDTyfSj+GeARUnyI0LHFDGUB8JBqb/ZUucrR5AWCVK2lNohwK
 MJCHrtwO5+50wM0tvjrDj1Dmgew/W5QlYo5bqImNE0WWx4ZO1hIQQbcZ1Imrr0T+8iKE
 yXbxzU356F/b4AMiAIU1m5IkV0zIgYFV25w9JBUCE9VDKRB+B/Kyjt7xova5DJ4f0SCu
 YRU4Xd4aWzQ1m46b2+aAK3jjgoAwlErc/PGLuL4Tfi+J4hmGIWrovSZHo5nOy1af5wbw sw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5usx2x00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 22:32:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327MWGAd012529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 22:32:16 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 14:32:15 -0800
Message-ID: <71d2cafd-ddf7-25a6-4df7-01f686cb322f@quicinc.com>
Date:   Tue, 7 Mar 2023 15:32:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Drop redundant
 pci_enable_pcie_error_reporting()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20230307201625.879567-1-helgaas@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230307201625.879567-1-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tiTRTKatob8zmhGKBaDS_yts7XMWj9P9
X-Proofpoint-GUID: tiTRTKatob8zmhGKBaDS_yts7XMWj9P9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=833 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2023 1:16 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks sane to me.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
