Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10515EB32F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiIZVdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIZVdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:33:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A237A1D00;
        Mon, 26 Sep 2022 14:33:40 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QKUeEF019145;
        Mon, 26 Sep 2022 21:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=3wF5UurgHZ5jEKblWYYmBthc3MPcnNLGgmFOSHUHiwk=;
 b=nksG543AmHVnIvJgtlT8Pkusgj+hCnjrgwgxghVwTvgXdu6xJBCbmzfpN8ICBnZTqqq4
 NwDT/LCFq7q+xM7CE3HhurXJ0UifwKEZ+lLUR/sW1GU4pIv9wrTwcsWcVB67DbmcxOz6
 NtPHfwHXJ58TtNDen+12R8QP9ApEitbYmeMdNB1gvFMochJZkIuu/g1lPTuZUHB9/Fnf
 p8jLyp52GJRnvzJDhezWkOTP8rfdA0MExQSJQWtoRDd724XDFn+QcAxNcm62n/XnbeHX
 gqokEn6QEPwpGzdY3OvxIym6N6a3SpgO4Bh3/zoyWtfdiFn3Ivx/MZbv1qemS2yCXWtk 8g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsrwfmpj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 21:32:53 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28QLWqJD025165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 21:32:52 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 14:32:52 -0700
Date:   Mon, 26 Sep 2022 14:32:51 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_richardp@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 04/16] ufs: core: mcq: Introduce Multi Circular Queue
Message-ID: <20220926213251.GC15228@asutoshd-linux1.qualcomm.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <e0ae0fccc579fa17b6cfcf3b8bcf963f5ebe67fa.1663894792.git.quic_asutoshd@quicinc.com>
 <20220926144957.GE101994@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220926144957.GE101994@thinkpad>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BunqsqPa_-iwxa5fehyGnNmqhAYykcSY
X-Proofpoint-GUID: BunqsqPa_-iwxa5fehyGnNmqhAYykcSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26 2022 at 07:50 -0700, Manivannan Sadhasivam wrote:
>On Thu, Sep 22, 2022 at 06:05:11PM -0700, Asutosh Das wrote:

[...]

>> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
>> new file mode 100644
>> index 0000000..934556f
>> --- /dev/null
>> +++ b/drivers/ufs/core/ufs-mcq.c
[...]
>> +static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>> +{
>> +	int i, rem;
>> +	u32 hbaq_cap, cmp, tot_queues;
>> +	struct Scsi_Host *host = hba->host;
>> +
>> +	hbaq_cap = hba->mcq_capabilities & 0xff;
>
>Define 0xff
>
>hbaq_cap should be named after the define used for 0xff. It is not quite
>understandable now.
>
Ok. I think you want the name hbaq_cap to be changed to what 0xff signifies.
Is that understanding correct?

>> +
>> +	if (!rw_queues)
>> +		rw_queues = num_possible_cpus();
>> +
>> +	tot_queues = dev_cmd_queue + read_queues + poll_queues + rw_queues;
>> +	if (hbaq_cap < tot_queues) {
>> +		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
>> +			tot_queues, hbaq_cap);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	rem = hbaq_cap - dev_cmd_queue;
>> +	cmp = rem;
>> +	hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(cmp, rw_queues,
>> +						 num_possible_cpus());
>> +	rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
>> +	cmp = rem;
>> +	hba->nr_queues[HCTX_TYPE_POLL] = min(cmp, poll_queues);
>
>Hmm, so the driver is not using the number of queues set by the user?
>If the number varies, I don't think it should be configurable.
>
I think the driver would use the number of queues set by the user.
Because there's a check(hbaq_cap < tot_queues) above that ensures
that the HBA has enough queues for the given configuration.

-asd

>
