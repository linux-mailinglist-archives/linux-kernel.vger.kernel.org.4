Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA227186CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjEaPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjEaPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:54:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7097;
        Wed, 31 May 2023 08:54:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERYUo009468;
        Wed, 31 May 2023 15:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=2JCC4m9t+6pTamUZwJmg/pn0fbW1Tpp5kT5PnXNE7w4=;
 b=ihRPtxSLRApFf1+nb1GF7jZqs7Gk386tlwCK/mNdvLqoVE1oXSLICKh5LUzfFDyzKBpG
 fDPIEGk0UgXftSrX7MyTu01KkAf2YSZrie/UB+y72OyVSMflb8Un2Zvyzf3hVkmIqbCX
 cpCAyA4vXkq5ZrT2iozTeoBVVgUD4tFNEuT0GexnoJKeKs4PJUOkxioZ1GO25vdZxvaa
 f8TowSWuffoGYN9ftVY/6AtVjxO2wblUvX64tOMzsntn/dwPxcn2wan/EiGGK0s9hGy/
 9Us9QqcucV7y6cV75I6daXA4rexUvuV8FwGo9xEgu/NSHhgmhW38c74TsUJ8Vf01iUxc 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkp8p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:54:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VF5ju7014673;
        Wed, 31 May 2023 15:54:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a5snjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:54:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaMiNp+q+KePhFMibPv8bHXM9TFyh4xPt91FAomm0afQNH7O4FbsFLXzh2LnFQY2JY+ZomyvGXr3E65dbmOg4MpA62691gBr9H9wb192GBuquLxlCXKqt5eQa1KdKFxWNtsVUWeL2fAFsfMtyKwzyzaA8lUo7uX2XLAL1Ow04qhvAl8RIzlD+97YTwmDuSFbRjsy3rbPPYpcufp+tE2hZ7LdKnLLzbQOY3PjZbmuwmsP3K4k+b5/6ArmJ/mflU4GdRx12+3lplz29m9cjJM6WsPWcHIXB3ChkWauhqtj+fSN0K7OpPlu+SNt64uM5e9oMvLtmEOX8bHl3QZzSOn9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JCC4m9t+6pTamUZwJmg/pn0fbW1Tpp5kT5PnXNE7w4=;
 b=KoZmX4+FqWWF6CquuPnJNHzra8z1eZL9ltwdiWQBZ9nclT81RZwV7xoK37Cz7V7iB6BBJ5x4xLET8IX6hlmc5cgFyBPlxcFsqTUlE2thiziyd29VA7auh0Qg7j7Yb6qed+mAUMTtvSCiZVb1QQlfqedyA8YLZOUFZgerXwpxv8lCupHxmAKIofwwfDIpQkL8DMBBTmnoSy8LBPjvKbHiJOjv/opPLOvJZjcNPhMpJBJd0ZrPyIMiKYkkjBDP/Ir6ujSuI5nK+fUtI5UwKcJDKQM9rn2QQRsmFvWJaz4Tkfcdemx8V8bJI+Y7Cy6pzlPdLJzfHwqPTp1epyuj5XQLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JCC4m9t+6pTamUZwJmg/pn0fbW1Tpp5kT5PnXNE7w4=;
 b=Gqyp3ymvcV0urAJR3zY/YTyUJChpV7rj1IWabobMmq5Ema8x8ND8G9r/fUnkB37kYxReKr15Ri9qM0OfVbTOwuTga/2HqsfxMNIfm7R1poh7ouisZ/BOZtcbqdsJ2BjR7rXWDWRWx5TuCPsLFwqfOFrFs8PMe2W7ZOGnQc8XsLU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5213.namprd10.prod.outlook.com (2603:10b6:5:3aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 15:54:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 15:54:13 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: ufs: qcom: add compatible for sa8775p
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1l4ebu1.fsf@ca-mkp.ca.oracle.com>
References: <20230411130446.401440-1-brgl@bgdev.pl>
        <20230411130446.401440-2-brgl@bgdev.pl>
        <CAMRc=MdDct0UzJPpOTuKHmm23Jc529NwkBWJJmXfeevpkQaSxQ@mail.gmail.com>
        <CAMRc=Me4EQ_7ArCeJASzKTimuSH=yNkrwm9DgE93s7kjdS5Nrw@mail.gmail.com>
        <CAMRc=MfhYu6sxhFABjyQUT5NGwNu1oJuRjMBqPvQ0Z8MhjoSRg@mail.gmail.com>
Date:   Wed, 31 May 2023 11:54:09 -0400
In-Reply-To: <CAMRc=MfhYu6sxhFABjyQUT5NGwNu1oJuRjMBqPvQ0Z8MhjoSRg@mail.gmail.com>
        (Bartosz Golaszewski's message of "Tue, 30 May 2023 11:47:07 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cf00c7-3e33-4339-c0ab-08db61ef4784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbOpZH70ZoQq2pR9hQvXGDkn8H/RS9wYYCIlTVZU5UuoUtjV+YG3bdaSUtz9+UHFgLRe8h+je3r3MAraPXxbB/U1HCfl1fRqWWPl+SUpawv/WBUs8+O6GoQKHMITVAJsu3FtjxhIPC8cE7KMb5uwYZn3oPjPiHHj0ktbQHBTDCrQ3PbWQrlCb/4V65OLPWe8z2wfUqT8dQqMSpRkA2YBx6T13Z/xucT4MPl0ZfHCOhdn4/akHLHTX854waYIbo8aLI/X7OgPLSJkZN0vwUGzwhWjhYy23s2EVNRRa3AvAS4UENr77yckOgvPwIc9PdK6JPDXd8y4aN5x1PzMmOWPfaezLKg0eTjRN5ikQL5M8QBCNwopCzxRCwftcd9qmIjZemN9DoqNsDu8u/QV1wDCyG0Rl488P34IIZJbvlRFtgfVH6YRZPLR476pzMk+G2Cg/G6AD+EE4T/osA0XaHPIp2MwsoT+AZ6PS0MPbg9DDeZ3yKjda6SGICqOvVtr3y8bHHxhuP8dJMQZju85WGLF6ktnziLMfN0rExFZPxtXpBkygo6a7qSX0AmpJCu7nMmC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(2906002)(186003)(6512007)(6506007)(5660300002)(54906003)(8936002)(8676002)(478600001)(38100700002)(26005)(86362001)(6486002)(36916002)(41300700001)(316002)(558084003)(66946007)(4326008)(6666004)(7416002)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgQZufb7TGBtDpH+W+89XUEJmM2yndKeeRX7SjkFvo4gsZd6uULPKl3hXoIw?=
 =?us-ascii?Q?EOCUJueiJqbRNyWGYXJYafHZYBFlSDBiU8mgyu2vBKFFwn6Fk+LibHFTbR7R?=
 =?us-ascii?Q?rIWh+Msq3tV8oVifBNFPJaeRrr8uF4fGKPARle2w10b3MyUtUdECxyodu04r?=
 =?us-ascii?Q?VyIRF3ihM1b4HcS8S8MfwffgSM1UPjCGfCxdAQyozSbM2DcXhFW87+FKOjve?=
 =?us-ascii?Q?f4Q5qwW/fzKjVAGlsQX7EgQf06egnTHK1Xvm7qUCkvK5UYlVrhuyk9/dGoWQ?=
 =?us-ascii?Q?BJAZt8kGPwkr2crKx7SjIS388fPiz17eoDKlX7SxaocRGPfsJ/xCY4B/rqwH?=
 =?us-ascii?Q?npvZn3Q7ZfCl9LjxA3TlfHNJ0L6dFQ6i+volsBFzjo+2kbOIxdsRJPG5oJ6J?=
 =?us-ascii?Q?0hTThIR4UfeqhR4HukJp6CAX8AS7IIY/9nh+H29mDtxU9Mx7X71s6pDmfdJi?=
 =?us-ascii?Q?uNXkg/5v3Q2O8urTMrl+Bn718fmk+OzflLHMR54GLfn/zvyA9E2b7Sw+AZID?=
 =?us-ascii?Q?q+3n3veo6qSbagYhN/KzOgl8VTMek6m6P58cvFSFbEphJNLD30qEZP6FbPxh?=
 =?us-ascii?Q?CDF/VJrmxpRHSvOKgSE4T242oCjojIo8pRSrbJnwAFAbxMf9R04146q8RENk?=
 =?us-ascii?Q?qKupi07r5PhSlrYby6kVQTRVUl3tt+ZbpLWV3CeIqstF+/JjnD+/8BxVRZoW?=
 =?us-ascii?Q?xVV5tdsllxVW65cB+z7aXuKpQC6WkGgiVq4mizZXskmL/wIeFBNYfwsIY3dW?=
 =?us-ascii?Q?KkWGjyByTno/QipMJVZCvNG360kC7ZhHLvpaZxZzpW856FvAAB8mzCGY1NlV?=
 =?us-ascii?Q?M409Y4pAZcBic3CssyFmL5fc/WfbYpFlZSFJ6Xidw07Zs333ZswL/OQUg9Fz?=
 =?us-ascii?Q?75xGhXzHuoHfpU8gBtuJHt8V13eZd7nsmZVGlgIN8KsqotB9+bQVPe220Nkf?=
 =?us-ascii?Q?j/D2VdSLBN7yX9KWjVbzbL4W/5sbyfF40w8eUtCLcDXLXbTBg2olDia50eMP?=
 =?us-ascii?Q?vnk5+o6pyVizVRyjIV1sYLaSL/ejFU1XsfYy1nyC/uc9kYomWqLZIFCOQkv4?=
 =?us-ascii?Q?KxNleBpvAxLbCSi9T4ZEjobGcsCZhQZmy4KrLaeNi7PKYJu+da/v4tL313oN?=
 =?us-ascii?Q?3RYUt+sL9VSvcNEDSaCt1mFZS3Qsiw3eb7f95i0bog1iXR7vbVy7uNLm9N3R?=
 =?us-ascii?Q?ey/iHV6B+zLP9ARF8PZAPfxXc5O7hN8jqOZ3bug6uxNohUm5qRau2ukDJqOF?=
 =?us-ascii?Q?E4v+1jj5i12SPHcoZCCOVfm1Ds7mMrxgEf7ubKh1MhKSjjdG/eI4o7bnRCUz?=
 =?us-ascii?Q?gltEaQTiWiwVKq18HUp5kFyz9HMvzchJhW1Mj0HNPEISTQfMRauJyX8RURHS?=
 =?us-ascii?Q?ay2YL8nZeHJOEOnXdbN1E2JzS5RUNSZN1soNmDqcq7J1UWMDfSrMrM17igEY?=
 =?us-ascii?Q?PNaJES5pmC9dS4inpTUYdUqDKfR5uoO6bECXhR4QUS1Wr7g7UBKPZyuwhrzO?=
 =?us-ascii?Q?ANcw8q0xzbMI59uWzH0io1KnV//SYMXjg6SELeIh62jMWaiIyffaQdtQa3f9?=
 =?us-ascii?Q?tx2SYfTP47ATVvl2uFfz8PcPQBtCPqjgTSddAodyBTtyzF8TMIy5XvGfo5dr?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MKpt7sdSLA8xDF3flP60Br8d41PXDPNAiAa1a2vm9I3Xq7RGH+nMG/cz+OI9?=
 =?us-ascii?Q?poV/ueQLcf0+9NP1IhsNm/3kTw+SfC7ADUxSHZkUt8e0ZDW0x32yaYRoG81q?=
 =?us-ascii?Q?VrSUkBaZgB+4qv2S3W33HUnAElLW2xhqrc/0XVZD/D4jHZLfmLpOxYlcGGn5?=
 =?us-ascii?Q?cEzn5p/w9z6ZI6BUb0kHDL2TeBXj8+GUfQ1hKZmvNOMA/cD19O7kPL3ETp85?=
 =?us-ascii?Q?o4onLJeEne7sJ9ndl47ByFhsNK5TYElL1Gx68M8LnCg0cEmT0j7JOBCqgIHm?=
 =?us-ascii?Q?L9xj8lsCPQBZK+RO4rjBPZzf/Tm6+FJb8sgJZrXMy+FPcjcRJebF+UczhnuX?=
 =?us-ascii?Q?LlO7AfOkTbu3+Ups1qtlt2wqy+1v8Qj52BU1QbNf5PBl+OAOU5VaWBLci6EI?=
 =?us-ascii?Q?v1A3NWuXtzfgbTIJ1i8uxTFcr55L9JEITmlL80xS3gNoHHrAnw6M8Bw4DooU?=
 =?us-ascii?Q?HfpKYfG6mGorplNYXCAiXFn7br3WyzfG2FYErWbELKUMlZ688qO9G+mW3BsT?=
 =?us-ascii?Q?WjgOJ5IDRv9fOxrq+exumNHicLlH4gAsHq1ELHjYfSwFYb0vs3lBxsD+doGV?=
 =?us-ascii?Q?s2iNEdviazXqmNomUqH5ZXMS2OPAEHAHU1z3w45f70KMucMqkgnLZG1Y7KQB?=
 =?us-ascii?Q?qrdMM0Ln75Coj0lUZLFuFwef8yuNKBkGi3GpMv2fjjWwy+Wn7wNIMy2DLJD+?=
 =?us-ascii?Q?C8OU2UeDfUexPb5AWAJYO7Pb57AslT0OaJjF+/I3OpVkdYnkDjg2RsvdLN+n?=
 =?us-ascii?Q?jNwINiQcQl11cJ/Sa1H73xENmjqmA4z4gNbkXxiW1TBYC2nQ1YYvdsei0gWw?=
 =?us-ascii?Q?QUmbx64hk3R+lJEJQ4/AmZwDXwVqjBe67s/1L5kg651lc8Bm6pHo5nmkYvBM?=
 =?us-ascii?Q?kT+AQhVLYKcDJYsiIcbmpIcg9DPICtvP/L3IAVlThJurh/9lzHJptHTwLNPJ?=
 =?us-ascii?Q?rmriiH8OGOYM3o13sWVcVOs4J8pvpl0Bmj+JSEjIYKE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cf00c7-3e33-4339-c0ab-08db61ef4784
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:54:12.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4rHE2JMfWuRdMMybR/P6DgoG4fdOB+hwnSHheRh7zDUQIuKjHCrhhiNhEZEC7Yk8SfEVuwK8IJiBOcjopgEN1ZuQHR42dh/deSK2mJDQ8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_11,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=753 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310136
X-Proofpoint-ORIG-GUID: MWYQxPS9HE2UCPsJLMyvtPG_B8k38Xkj
X-Proofpoint-GUID: MWYQxPS9HE2UCPsJLMyvtPG_B8k38Xkj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bartosz,

> Hey UFS maintainers, could you please pick this one up for the next
> merge window?

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
