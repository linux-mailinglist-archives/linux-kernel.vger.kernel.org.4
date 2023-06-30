Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864374430D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjF3UDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjF3UDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:03:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81C13E;
        Fri, 30 Jun 2023 13:03:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJe3jd022974;
        Fri, 30 Jun 2023 20:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7Kj8HQoxK0oXlxEssFyywogLQQqErFgwwotTvJTZo2M=;
 b=ADRzBsVnBPNiEaqBxnhw22kglW9SzgMuY2utGSnQEOh7j3DhQDmBqQt0z9Q9abHHzW5K
 6WGK9Y5doe6Fdg6O03VKC5FH0pnFfYYaEdhxCPpGdIzwEejZ8L29AsDr8DyDj4lmPlOt
 1rzW7+6eq3VsPwsWwIDkLuaPRuhNa/Rj2VZxqFyZLGlkgeJDOiSrPXubKfMI12bocBdW
 rJmOzuOI5nY6nxk/ast5b1K2w4s33Dah3b4/2XafkVbTqEFQRS8vvFwnrq2gwJvXrUXT
 BLWa753IjXMvQ6ZWTwkjiOdOLNcNTL5NqUo4zQq276L1o1JCiwPMRzY3VMp+k6Fkytx4 IA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgy1tmsvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:03:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UK3QqN016147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:03:26 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Fri, 30 Jun 2023 13:03:26 -0700
Date:   Fri, 30 Jun 2023 13:03:25 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support.
Message-ID: <20230630200325.GA1059662@hu-bjorande-lv.qualcomm.com>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-4-quic_kbajaj@quicinc.com>
 <ea4c49cd-17d1-6921-a447-5debaebb0cfd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea4c49cd-17d1-6921-a447-5debaebb0cfd@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vYd3QWMYftPcC3hZ48bRaNHZ4nArgx_K
X-Proofpoint-GUID: vYd3QWMYftPcC3hZ48bRaNHZ4nArgx_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 04:53:44PM +0200, Konrad Dybcio wrote:
> On 23.06.2023 16:18, Komal Bajaj wrote:
> > diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
[..]
> > +static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
> > +{
> > +	struct sec_qfprom_priv *priv = context;
> > +	u8 *val = _val;
> > +	u8 *tmp;
> > +	u32 read_val;
> > +	unsigned int i;
> Please sort this to look like a reverse-Christmas-tree
> 
> 
> > +
> > +	for (i = 0; i < bytes; i++, reg++) {
> > +		if (i == 0 || reg % 4 == 0) {
> > +			if (qcom_scm_io_readl(priv->qfpseccorrected + (reg & ~3), &read_val)) {
> > +				dev_err(priv->dev, "Couldn't access fuse register\n");
> > +				return -EINVAL;
> > +			}
> > +			tmp = (u8 *)&read_val;
> > +		}
> I don't understand this read-4-times dance.. qcom_scm_io_readl() reads
> u32, so this should be as simple as:
> 
> val[i + 0] = FIELD_GET(GENMASK(7, 0), reg);
> val[i + 1] = ..
> val[i + 2] = ..
> val[i + 3] = ..
> 

No need for FIELD_GET() to do that, you can just do *(u32*)val =
read_val; although this comes with alignment issues.


But, that this the length of val is always divisible by 4, and I
wasn't able to convince myself that it was the case...

So this is, pretty much, what I proposed in v3:
https://lore.kernel.org/linux-arm-msm/20230527205031.iwsujvlbxazukwfy@ripper/

Regards,
Bjorn

> 
> > +
> > +		val[i] = tmp[reg & 3];
> > +	}
> > +
> > +	return 0;
