Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BFB67AB45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjAYH74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:59:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCA245BFC;
        Tue, 24 Jan 2023 23:59:53 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P7jCEl010113;
        Wed, 25 Jan 2023 07:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tbmwcRINlEFcXEbMDAVwgpPTxxQYRDQfGvNfRvkTt3g=;
 b=BTkIdnF1fhp4rV5Nvy91YOp7LGNKNxaAHqIU8pXCRBtsnAtStHQBnB7j2NefKo4UkIpA
 JGgClzqrZFK20PWiBVbqtEAEK4tn9BL3eHgONv4hpq5YoXU6b+XIu39L5Nk3CsVlzbf1
 EEfx6ZtOsPgDdrqShU86FvwDomunFLjw9248muWLoDUHnvDgtOmSRpHQzurhtDVZK55/
 H3y2Lpjchd7lDw7xfxJzRQL2F3OJYoPEj1us+5nxTk+grrYbPejuPsmalgdRxRlDeTMr
 KMie9MJoB8aG19QPtBwZ51fr93+omSEW7knfU5HXmJs9uOpuTuvajc/+6Of1zG5E5e05 dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najqa9bba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:59:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P7xZ77010821
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 07:59:35 GMT
Received: from [10.50.40.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 23:59:30 -0800
Message-ID: <5ca6868c-4e1b-9770-a6e3-d3a961eea757@quicinc.com>
Date:   Wed, 25 Jan 2023 13:29:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V0 1/1] soc: qcom: dcc: Add QAD, Cti-trigger and
 Bootconfig support for DCC
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Andy Gross <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <8337e5672559b197a13699d2c0ee69f18f6167a6.1673247689.git.quic_schowdhu@quicinc.com>
 <202301092313.RPU8Nsb1-lkp@intel.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <202301092313.RPU8Nsb1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IIeIRvrTZ3jeEwbgDxBf-4yzTtghF-4g
X-Proofpoint-ORIG-GUID: IIeIRvrTZ3jeEwbgDxBf-4yzTtghF-4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_04,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250073
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2023 8:58 PM, kernel test robot wrote:
> Hi Souradeep,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20230109]
> [cannot apply to clk/clk-next soc/for-next linus/master v6.2-rc3 v6.2-rc2 v6.2-rc1 v6.2-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Souradeep-Chowdhury/soc-qcom-dcc-Add-QAD-Cti-trigger-and-Bootconfig-support-for-DCC/20230109-181920
> patch link:    https://lore.kernel.org/r/8337e5672559b197a13699d2c0ee69f18f6167a6.1673247689.git.quic_schowdhu%40quicinc.com
> patch subject: [PATCH V0 1/1] soc: qcom: dcc: Add QAD, Cti-trigger and Bootconfig support for DCC
> config: powerpc-allmodconfig
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/887ce0321641a448b3c53ad5e3f5b05a47c83ae9
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Souradeep-Chowdhury/soc-qcom-dcc-Add-QAD-Cti-trigger-and-Bootconfig-support-for-DCC/20230109-181920
>          git checkout 887ce0321641a448b3c53ad5e3f5b05a47c83ae9
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "xbc_node_get_child" [drivers/soc/qcom/dcc.ko] undefined!
>>> ERROR: modpost: "xbc_node_get_next" [drivers/soc/qcom/dcc.ko] undefined!
>>> ERROR: modpost: "xbc_node_find_value" [drivers/soc/qcom/dcc.ko] undefined!
>>> ERROR: modpost: "xbc_node_get_data" [drivers/soc/qcom/dcc.ko] undefined!
>>> ERROR: modpost: "xbc_node_find_subkey" [drivers/soc/qcom/dcc.ko] undefined!
> 

This error is getting thrown again because 'QCOM_DCC' is declared as 
tristate. Since DCC is using bootconfig apis which belongs to the __init 
section of the kernel, it can no longer be used as an external module to 
link with bootconfig apis. Will be changing it to bool in the next 
version. Thank you.
