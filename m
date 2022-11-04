Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC60619853
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKDNny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiKDNnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:43:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9B10AA;
        Fri,  4 Nov 2022 06:43:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A4DSo8m008110;
        Fri, 4 Nov 2022 13:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JSXQnPxZWQ5jeG4mGk67p5oVSs52bWoZD00vGMG6zZM=;
 b=bzSux6VOpKqwXZYoGZJiItl2doKhSaH71vFF/irWIyLrx6Smycsa5d5Q3UFNcywVNcoC
 gf1FszdLvS3p1nUWHOpfY799QRpW78aTzW7HXoXAbiqIHJd0P0OpicuY4Wq5ilkxUALX
 9nTg0tgTkOUGcEYvR0T1i0egoUq1BqcNd28UTeqWyUQ/LgEyzk5TtJKPyQPyIGkPbHFf
 0ef/mvdUzdyhNlvQgt4yFi1NEg9S3CcEMH1SkkEfm2MTHRpYPOcEYKlD0C7wbk/dIy52
 88qQCMYjEIuI3tb9cPHkFrFpF5ZMMpk3MySABoktV0rmY/voj0mDPmEwCCQPXfQvp8z0 1A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmvcm95ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 13:43:27 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A4DhRDs029974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 13:43:27 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 06:43:23 -0700
Message-ID: <b6dee8a3-a504-2a1d-25c0-325ce28ee005@quicinc.com>
Date:   Fri, 4 Nov 2022 19:13:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] usb: chipidea: ci_hdrc_imx: Fix a typo ("regualator")
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        <linux-usb@vger.kernel.org>
CC:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221104095838.2132945-1-j.neuschaefer@gmx.net>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221104095838.2132945-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ovsz9FIV8NfanvNs1B29ELV3liU7T0qV
X-Proofpoint-ORIG-GUID: Ovsz9FIV8NfanvNs1B29ELV3liU7T0qV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=867 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/2022 3:28 PM, Jonathan Neuschäfer wrote:
> Change "regualator" to "regulator" in this comment.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 9ffcecd3058c1..1d6ee1d894f01 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -355,7 +355,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>   		data->hsic_pad_regulator =
>   				devm_regulator_get_optional(dev, "hsic");
>   		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
> -			/* no pad regualator is needed */
> +			/* no pad regulator is needed */
>   			data->hsic_pad_regulator = NULL;
>   		} else if (IS_ERR(data->hsic_pad_regulator))
>   			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
> --
> 2.35.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
