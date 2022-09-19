Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7015BC4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiISIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiISIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:51:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639824F22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:50:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J6kTHg009869;
        Mon, 19 Sep 2022 08:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=EvLfK8D9rOc45d27O8pvlHKWO3HVniQiKNmapn2hwBM=;
 b=kzAxcNAO6r94JBWHP24y+Wvvc5op7vHqh70Uyxc15+JnKiFJiYHjjNAazaAJbgI3QA2o
 nKG5bdv/KELxFwxPz4YoQyvEW6BqvaqpSS+ETa4Qho9/JgLa76MukH99A3ri4474UxE8
 E90no7/b0CzHPBriYVW7SkamPQWQtzEY7WWiBz4ipTrm9BTNP/zoAx9vCj1qzybKIFee
 z6KpmicUhi4WS158q4D2UkpKht9Bo2NmCIZ2PpgUcbOorFV+3oFXYbZB2mxVuPt1lsak
 BU+03jkPWukSjXQH9p5yENQ8DBsEu19FjwkT37TADLtqm/BuZJItI6xCwuTSsxApNnUI 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kk5fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 08:50:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J751um036235;
        Mon, 19 Sep 2022 08:50:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39c2hjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 08:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAc7yMew0IhTP3S0P8grzXOlcxS4utiNbrch2paDTfpGBwAu53F/YkFu7zk1+CzX4zPctvAPzYNTpOW2eunA5t+fHS0SHgnq+utG+D0ZhatlsjNkoxFC9q2/wusEAuwWCu72hmAiFSqR/SpGNl3unuqfxfl9aw5pC8834bMeTg8C407UfKR0fiIazGQSTMrAIihTUp5UTuV7GaUziHCKUOPHFtKJsg29lDgHd6hnfUL0em4aeCU86+kujuZtLt5I3cTgtK8mqIsWIRboN+7M9/FQavfDulXHI7J4VM/sNsAqzk5fmW5/LbNLU48JU0DvPAYBebZrQUlnA7sXsXMdYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvLfK8D9rOc45d27O8pvlHKWO3HVniQiKNmapn2hwBM=;
 b=dqx/XxuCEtfkrimucjCY3iZQglmTG2smbxP84tzTClqvWLrk+3nuz+JvDjXk2fdGijD6MvOuDhCCmBPkcYLZQlBMbBTM81Xdv4pPa1EbKSJ/Vtfw7FOPvTBz9AMlXTLCX8ALPhhkmrbmrKU6DBHDLr9QVUzV4gxiW8QZrDefrwxS1P6tPvtsd36HgkVeBwXCiPd7NCqRUVh2/8nCs2qWjixm7pYmPJDVYyYTNDHOpjMk/40J8AU3cdRguuQ9anVncGM1BqQdYpiAE875JcxdJ6gqGKp4qem8FL7hDQUtGGnERDRHztj6qjgLc6O2BxSfB9RpM1mMv/s5jDttcCgnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvLfK8D9rOc45d27O8pvlHKWO3HVniQiKNmapn2hwBM=;
 b=ioI16FbxKY+mUCsn6fj8bBU7lQvWDKr9kqugsbrUoN1G5fYXV2Q77bQalWp/sKBR8cn8TxhajPiCdK2czOO1dz84mzbB+XrMF6YpzNUXdYn9iTQzgTCUG85crf0PEG7JDo20NiF7Cx2JOCefRoBLIbe0cnhmYIa3BahmsXAeD0w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4989.namprd10.prod.outlook.com
 (2603:10b6:5:3a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 08:50:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 08:50:40 +0000
Date:   Mon, 19 Sep 2022 11:50:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/cpufreq/qcom-cpufreq-hw.c:333 qcom_lmh_dcvs_notify() error:
 uninitialized symbol 'throttled_freq'.
Message-ID: <202209181024.rhoJMAL1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNXP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 34691720-ff90-4ede-d954-08da9a1c07b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMnpqf3TkFyTd2ulS0Fuo+xJ7vjk17lP+GspnUMU2U0M30ODxXY2imhPstvTmhyjq6AxIc6uj+E+JkRvfZLxsPhft10k+t2qeSoXi+Zd5qYscna+2WEWQmzG/PAZP/ordmmv6QNh2suYzswhaSEPivLCpW1r/rBimKqVZ0VKNNjULg+O4D8aCk/bwir2CRB0YwPX0pFsX8eu3euMM5HtWvejWnOI4wFN27ALwHqYDy8ipzGTwCH2CFnCzjPjWm420PJzDLAG7UOqQu0ClZaHox1p8JRTYMLi3fRSuTYH2Gah+70YtU9JuN0Kr19MNHy4W053B4+AM4csr1SZqqj0yqRsIEyKBrQP6HM+Zkopa4cMHbqu09F1I4q1acyX0il5+Pzu+HwYXVZNWi1Is2+e+J6oQLvk6alQ1wwPPbYcYl+yOOnivItcLIswsUWALuIiBHE9s7KH/R0slg79mEcKvq9CNpxe1nfhPbzGuZkLBDAHszARahmGIwx8Bib9mFoZ5jRAypjdZWn/V9cHRFUrZVdp+/oan+cFYlq3z2HCX2mWYdT4aMSk0o5MLlvEILKOFiGP4AZupV/YqujZWAejzo/qS3QhUMI45/9Q/R4VN8wQ2Xu/vFEec/Z/K8ELEYlt+cJFcwFp8a2mTT/VRfQnVl650xcqrxKWrc0c7lR2oTTUwgaMMhZkm4IlWPYuHmOTz43SooItPRviYQF1ikT/CFVjNtu4remy0x6gJKe3FxPMPF6/HmhdDVtQRHWCrr8XjGUKu+ucqY/IaZjwC8g/Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(1076003)(38100700002)(8936002)(186003)(41300700001)(9686003)(6512007)(2906002)(26005)(478600001)(6486002)(316002)(6916009)(54906003)(36756003)(66476007)(66946007)(6666004)(66556008)(4326008)(6506007)(8676002)(966005)(86362001)(44832011)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ypDFDNVP3L5dy80voPTARZgh3H10NmyDk2TO37T1xARm5ObnM14rhdrqBr5r?=
 =?us-ascii?Q?6AX1JIdRMf1tkmqTV9p3o7wUvDLLumV80Pucw7NulJcVOdFVbisOhpHNztGN?=
 =?us-ascii?Q?2k+Tglh9Z0VthUSwoQ3Ond1jpL5M1WeuSvHmSB81POO6FvxqPoi/wDEx4tRg?=
 =?us-ascii?Q?n6fRBHAfS6eJcO03Hr3b1fbU1anl+IkCcEH/HKznMG1cTQdHedYQHEQvYQlH?=
 =?us-ascii?Q?rX+dkZuaOQASVdJQvjbG372h2tYYklnRGCCFxN1Hge9IGFxWmxj2E+fHNmOR?=
 =?us-ascii?Q?rHNJmv2oZgkQl6hdRQDedMqOWJSDk+oNTCgP5gUjxvQ5cBCcDmXnjfW5V6OQ?=
 =?us-ascii?Q?EqSUXPl7CV1z2zWlGcjRQURzVBu0SxM7wnWfK4ryE6LvISIFx9W8tUKO14Y/?=
 =?us-ascii?Q?mYNDvZN96Q2x47DUptRKB5XWEaV3bG1uIVDvXYmfV3BEF90wOInQvfbP4txd?=
 =?us-ascii?Q?vtYvub2aK0Jth3Wf0Tp01toMMs/ODXb5JA95xwU40HkUcLAPLUNS0rl4HutF?=
 =?us-ascii?Q?3Lw8eEtwGx9oypGaYJVR+HSg83U3VmzpPpeXXlD76fbjAC1KbhqoXYGdy1Tk?=
 =?us-ascii?Q?1tnPxK6FbyYq5kSuq+vk+Y13VAW/dJoj+YADI99Sk8jV1LRD2F8UEU3itp2+?=
 =?us-ascii?Q?uxwMxSWirBanzZ2YXNlY3Ozbh787jd4zjMXBTE9vwJHHy+qJsXUTjAk8PiPA?=
 =?us-ascii?Q?cnIjf1bvsXv1lt6TOmsQ7eCtRvpo8h267I+25SE3vidbcqfu3ZAp60r66M6W?=
 =?us-ascii?Q?Y5G8eG8E3i5H8j7sodq6KURJ49jQD8TKuO/L4+etKx8HR9YCHnKXpH8uWwen?=
 =?us-ascii?Q?3hy89L4zB/79VR5C6lkicnBfkvv43Rrn68q0C64GsHGEJ+S+cdSAYv/Xn7Oc?=
 =?us-ascii?Q?l0BgfcmwPkmXx43XM732FkilUPA3nc91zI+EBEb+sOmUt/jT6iN8AVxP4azR?=
 =?us-ascii?Q?C/S2+qxOpqy0LVsJw5/2IJkvAl93PGuDL+CGiVeUwu7Ts/Y9F7Kj/gdwrs0P?=
 =?us-ascii?Q?U20MooiewHD+OLjNPxkXYisSeYMaJrffzFPWz9rxynghAc35pcO3umWCFsrT?=
 =?us-ascii?Q?xVS7UVq2xXXPDectXkpq0ZBgZ2+ldc2EP8bSVOnMAceBduKnei5UrKZs8TlE?=
 =?us-ascii?Q?uZ0rhgxikiYNZBdPDyGXuVaESF7jQLbvCQip/lq8lEwZmPNvOWjBYZRhPMjB?=
 =?us-ascii?Q?KmILeZCyovK9ES4Z0Q2pG1K08goybsMFucINqUWaftMr1i4DO8347X/i1fkl?=
 =?us-ascii?Q?3GMCI0K2Sb1AIRrSr47WV08FfYQ4hRReest7ZoJ44mjAJ+bKzz0g0moNOPSI?=
 =?us-ascii?Q?N3c5VMwG6xvjRyX1fhcJOkGN8Xu/4+iHuhGxDqNb/iWZwUmdI5e3f9DUKQ5r?=
 =?us-ascii?Q?cwW1R1PtdeKrNbAORMqQ7WLK1E9pptvG5q5Q8WwZHDEt68QqG0Kzy1cPjawE?=
 =?us-ascii?Q?aUkw7T68Sjf08faH5LRpfJ/lClJygCQLL2jKA0RQBSbkGI2IJRSEwBrarVyB?=
 =?us-ascii?Q?MZPxxLKvn2gDnMorNtv/4x0LWNH1ouP36TKrWdNaOQMakqURLABejWm7MA8X?=
 =?us-ascii?Q?R7uJp/3im0REwqUAOgNcFIIhV8Pha5v6iSCTliri4WwZprapkRiNpTTfRfod?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34691720-ff90-4ede-d954-08da9a1c07b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 08:50:40.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEV2x8p7ghDKy7F0rbMNTREvFtSZSNEYZ/PrYmYKPIlOxarZjAwmVAF81Tl7c9UjgtbQ+49LnDnr60ewPVgOTCvE9O0PRBjyQesBH5ZIAn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_04,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190058
X-Proofpoint-ORIG-GUID: pAQThB3X-M0hFQHedd6wkXQa_z15KYJv
X-Proofpoint-GUID: pAQThB3X-M0hFQHedd6wkXQa_z15KYJv
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
commit: 6240aaad75e1a623872a830d13393d7aabf1052c cpufreq: qcom-hw: fix the opp entries refcounting
config: arm-randconfig-m041-20220918 (https://download.01.org/0day-ci/archive/20220918/202209181024.rhoJMAL1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/cpufreq/qcom-cpufreq-hw.c:333 qcom_lmh_dcvs_notify() error: uninitialized symbol 'throttled_freq'.

vim +/throttled_freq +333 drivers/cpufreq/qcom-cpufreq-hw.c

275157b367f479 Thara Gopinath   2021-08-09  290  static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
275157b367f479 Thara Gopinath   2021-08-09  291  {
275157b367f479 Thara Gopinath   2021-08-09  292  	struct cpufreq_policy *policy = data->policy;
5e4f009da6be56 Dmitry Baryshkov 2022-03-26  293  	int cpu = cpumask_first(policy->related_cpus);
275157b367f479 Thara Gopinath   2021-08-09  294  	struct device *dev = get_cpu_device(cpu);
0258cb19c77deb Lukasz Luba      2021-11-09  295  	unsigned long freq_hz, throttled_freq;
275157b367f479 Thara Gopinath   2021-08-09  296  	struct dev_pm_opp *opp;
275157b367f479 Thara Gopinath   2021-08-09  297  	unsigned int freq;
275157b367f479 Thara Gopinath   2021-08-09  298  
275157b367f479 Thara Gopinath   2021-08-09  299  	/*
275157b367f479 Thara Gopinath   2021-08-09  300  	 * Get the h/w throttled frequency, normalize it using the
275157b367f479 Thara Gopinath   2021-08-09  301  	 * registered opp table and use it to calculate thermal pressure.
275157b367f479 Thara Gopinath   2021-08-09  302  	 */
275157b367f479 Thara Gopinath   2021-08-09  303  	freq = qcom_lmh_get_throttle_freq(data);
275157b367f479 Thara Gopinath   2021-08-09  304  	freq_hz = freq * HZ_PER_KHZ;
275157b367f479 Thara Gopinath   2021-08-09  305  
275157b367f479 Thara Gopinath   2021-08-09  306  	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
275157b367f479 Thara Gopinath   2021-08-09  307  	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  308  		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
275157b367f479 Thara Gopinath   2021-08-09  309  
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  310  	if (IS_ERR(opp)) {
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  311  		dev_warn(dev, "Can't find the OPP for throttling: %pe!\n", opp);

throttled_freq not set on this path.  Just return?

6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  312  	} else {
275157b367f479 Thara Gopinath   2021-08-09  313  		throttled_freq = freq_hz / HZ_PER_KHZ;
275157b367f479 Thara Gopinath   2021-08-09  314  
0258cb19c77deb Lukasz Luba      2021-11-09  315  		/* Update thermal pressure (the boost frequencies are accepted) */
0258cb19c77deb Lukasz Luba      2021-11-09  316  		arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
275157b367f479 Thara Gopinath   2021-08-09  317  
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  318  		dev_pm_opp_put(opp);
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  319  	}
6240aaad75e1a6 Dmitry Baryshkov 2022-03-26  320  
275157b367f479 Thara Gopinath   2021-08-09  321  	/*
275157b367f479 Thara Gopinath   2021-08-09  322  	 * In the unlikely case policy is unregistered do not enable
275157b367f479 Thara Gopinath   2021-08-09  323  	 * polling or h/w interrupt
275157b367f479 Thara Gopinath   2021-08-09  324  	 */
275157b367f479 Thara Gopinath   2021-08-09  325  	mutex_lock(&data->throttle_lock);
275157b367f479 Thara Gopinath   2021-08-09  326  	if (data->cancel_throttle)
275157b367f479 Thara Gopinath   2021-08-09  327  		goto out;
275157b367f479 Thara Gopinath   2021-08-09  328  
275157b367f479 Thara Gopinath   2021-08-09  329  	/*
275157b367f479 Thara Gopinath   2021-08-09  330  	 * If h/w throttled frequency is higher than what cpufreq has requested
275157b367f479 Thara Gopinath   2021-08-09  331  	 * for, then stop polling and switch back to interrupt mechanism.
275157b367f479 Thara Gopinath   2021-08-09  332  	 */
275157b367f479 Thara Gopinath   2021-08-09 @333  	if (throttled_freq >= qcom_cpufreq_hw_get(cpu))


Uninitialized.

275157b367f479 Thara Gopinath   2021-08-09  334  		enable_irq(data->throttle_irq);
275157b367f479 Thara Gopinath   2021-08-09  335  	else
275157b367f479 Thara Gopinath   2021-08-09  336  		mod_delayed_work(system_highpri_wq, &data->throttle_work,
275157b367f479 Thara Gopinath   2021-08-09  337  				 msecs_to_jiffies(10));
275157b367f479 Thara Gopinath   2021-08-09  338  
275157b367f479 Thara Gopinath   2021-08-09  339  out:
275157b367f479 Thara Gopinath   2021-08-09  340  	mutex_unlock(&data->throttle_lock);
275157b367f479 Thara Gopinath   2021-08-09  341  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

