Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B707D74FB07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGKWio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGKWim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:38:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C159E49;
        Tue, 11 Jul 2023 15:38:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BLb9hq025481;
        Tue, 11 Jul 2023 22:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qak3npi2xkSxc2qaZfb/BReTDKiC0oQsIwxSsFO0iRQ=;
 b=cNiX51pbhGMOP6gSohw5razy1tgl+e2ksdyS53aC4L/gTf4eNwAwPUsiRFQtHEd3mR32
 QyQ8AUVVbamjgGbyPW6vADSResxMcpNKomDQy8de8GOWGokAm1/8Muy/g/SzWvcLxEwK
 6PMJ9EW0DVfOgckTc/rgKjylIcZ0vJNg2YxtLGADva2SiY+aiEtZhdxZ3IvI8xxYtB9c
 9WYhufzwlIK7ANtAg9HRKf7dnTxjsdgjLkiySV2K3DAcoMDtLPRfnOz5M9sLg8/CKlkN
 gPMaebkodLB7/eRCsfOE57TjBiDwbkTRRbLkISizVQbPS/kDMAWqWupikC2aTv+EjsgC nQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf4s8372-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 22:38:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BMcRbn013482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 22:38:27 GMT
Received: from [10.110.62.125] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 15:38:26 -0700
Message-ID: <1dc7db21-668a-0247-1b03-016de72cbad8@quicinc.com>
Date:   Tue, 11 Jul 2023 15:38:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     <robh@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-3-quic_eserrao@quicinc.com>
 <20230711215645.6wclz5uffqnlpnnd@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230711215645.6wclz5uffqnlpnnd@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1DltD-QI9r9SytLrXn5LAyJNmFzSdiWH
X-Proofpoint-ORIG-GUID: 1DltD-QI9r9SytLrXn5LAyJNmFzSdiWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=473 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110206
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 2:56 PM, Thinh Nguyen wrote:
> On Tue, Jul 11, 2023, Elson Roy Serrao wrote:
>> This property allows dwc3 runtime suspend when bus suspend interrupt
>> is received even with cable connected. This would allow the dwc3
>> controller to enter low power mode during bus suspend scenario.
>>
>> This property would particularly benefit dwc3 IPs where hibernation is
>> not enabled and the dwc3 low power mode entry/exit is handled by the
>> glue driver. The assumption here is that the platform using this dt
>> property is capable of detecting resume events to bring the controller
>> out of suspend.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index a696f23730d3..18ad99a26dd9 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -403,6 +403,11 @@ properties:
>>       description:
>>         Enable USB remote wakeup.
>>   
>> +  snps,allow-rtsusp-on-u3:
> 
> Please spell out the whole thing as "rtsusp" isn't clear. Also, it's not
> just for U3 right? For highspeed, it's L2.
> 
> How about the name that Roger use: "snps,gadget-keep-connect-sys-sleep"
> 
Done. Will make that modification and upload v4

>> +    description:
>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>> +      case even with the USB cable connected.
>> +
>>   unevaluatedProperties: false
>>   
>>   required:
>> -- 
>> 2.17.1
>>
> 
> Did you Cc Rob, the devicetree maintainer?
> 

My bad. Thanks for pointing this out


