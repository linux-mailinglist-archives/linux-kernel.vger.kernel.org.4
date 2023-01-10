Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363FF664226
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjAJNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjAJNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:44:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E41A3A6;
        Tue, 10 Jan 2023 05:44:25 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A7WFZ4005591;
        Tue, 10 Jan 2023 13:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q5eiY7y80BpaK9CbsvAvraGpL2YrZqpEBL/Z6QbslMY=;
 b=d3w5tJtaeX02jzCHak1gY1pnoN/Xm4TNupdiSH1ZEJE/OXAtSONDkkHIwoONOktJYTm1
 tQ5odKp2nRVjSqanQjEt/2p1VaQ++cJzwakJB03iaSTsBvPAbKUaYaUyPRgWO6AMsxrE
 8QgsU5lolBbQOHPKwuYlQDUZX7VPoqb4ePkX93cE90OHINVCNMbigYBOViM9TjL38/o5
 fCEDwAyTXfxMFN4XnaG3nBzL3mIezYG/XE/qsD+XY7h6fTAUyYJcagmnqYKOZQHzNMTn
 msOnN/Amd7pTalG9VRdRtWmyMDEQ5+Ky0RZubXLp+IdBECocT+6cg5YmQFkZ97NQmLfh aw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0ssh9snj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 13:44:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ADi2J9025851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 13:44:02 GMT
Received: from [10.50.61.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 05:43:57 -0800
Message-ID: <09e06270-6b97-c0e9-e2f3-e6208def0f0b@quicinc.com>
Date:   Tue, 10 Jan 2023 19:13:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
X-Proofpoint-GUID: t_jh1-gxTbi42ERcKkQb2TxCxLaLvo4T
X-Proofpoint-ORIG-GUID: t_jh1-gxTbi42ERcKkQb2TxCxLaLvo4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_04,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100085
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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


Thanks for reporting the issue. 'select BOOT_CONFIG' should be added to 
'config QCOM_DCC' configuration option as well. Will be taken care in 
the next version.

