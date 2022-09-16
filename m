Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF195BA719
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIPG4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIPG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:56:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FC06BD50
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:56:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G6MHEq013401;
        Fri, 16 Sep 2022 06:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ixKu4zlhX+vNvH+bcPzms9KardFAp/kasFXs0pynZLA=;
 b=ZgxlcqZ+FTNGip4TJLGbddM3Slezxj8wepIP4PO93Pmd5cTkfiRgc0q4kpdpJA4NYpAq
 LJgxLL776HXff4UzZgSkHnj09BsDyfB+nCqEEYHsScpIoz1wqfHhiI4UIvV9BcUHsaKv
 WYghre2g89VTHx9RDEaolaLvOQC9adsPp4fzMmLWk6sUifNdgaCStu+N+vu+E83ecpjg
 Oi9h8zFkKaUd/mKyqA7aZkYFuPJH7R63L1lnI0YMkwfnYGyiAkFDjPMBg5czUSTMIwKV
 4KXqwyjuLyqqYyOf/zuR+TZ8w3a2nGWskBOFLR+XDvU5LpFlxeSj1NswsOaCQoeUoXr+ nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xb9pk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 06:56:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G5Q4Kg015949;
        Fri, 16 Sep 2022 06:56:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x8ufq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 06:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiWZMJHaPsP7D5/Ah1gygrMozzbbYxvaqScj+qPiZk4bUU0WDhQVhf5hYA7ZDlcoh4ChDgEcvFmQFlNYCQ9kIJSWYRB5zcb5DzvfdnidG1uroF4J1zgwQs0AuaFDvxt4bzs+OAEmXNoJ0muUqqBr3FGLcoFaI/EmO+L4f7LkUn/P/rBy+5rKkPHOzH5szevvZLTvfQHrkvAWvrA7nFD8V5M5XxAtpBPbWMqjNktJbqkRQ/RKOkCGGkQNqM2hIYSIgjGJs4PS+hL+OnfbM72lvjvaazx0H0pFhArZ6zYfNaLu1k0Q3RTpwkIIbhzSWHCnVVqm/5a3WXMxC71d4blybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixKu4zlhX+vNvH+bcPzms9KardFAp/kasFXs0pynZLA=;
 b=eTqF1yNDW4zBXFsLagqnMF0nRPpcyxkzmUxihwXHvZg6sSjvF4Fo8aArUZ++5MLp7gzNSay9N/k8LqcGmiTel/YLrWhHhZmNr8O9ittfg6+iPyxKxn2Mhvnsfqi+an5IVDTkli7YLmP78VXAIQpiG9JyZ3H30sFlNv4pf7NtLYOT3BljfoKbm4x1jXS/T2FbarVLsijx6tpf9YnqpqgE5DL5xNIOnfh/hmNxv+uka9FpT7C5xiob+r8IMa/AY6Ybh76ZKxgPzzIhHmstMZ1bODhaG7SlxS5ZgOfoasJsJi8Ib5hyLouvvY0ef61BJOAWbAlT1wnoqy+oCstyAsKZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixKu4zlhX+vNvH+bcPzms9KardFAp/kasFXs0pynZLA=;
 b=rO5r/QUuaIOV0nXmpNiMsNtX1ePn4Mvbx1C8sVJPqwH/II64PTWimxs4hm4dcV/++X16fijkoyHPN5XwK3q0wFmMFpjD5sv//zKozGfzCoDtMohu5prtZ/45gJwIBZfMPY8+BL1ri4GWUuhzwzHcNZI9oT6rF0fKyyhtZOflsAg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6676.namprd10.prod.outlook.com
 (2603:10b6:510:20e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 06:56:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 06:56:00 +0000
Date:   Fri, 16 Sep 2022 09:55:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: [jic23-iio:testing 149/150] drivers/iio/dac/ad5593r.c:87
 ad5593r_gpio_read() error: uninitialized symbol 'val'.
Message-ID: <202209160614.IE7ciPMN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c2fb3f-8791-47da-c474-08da97b08361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkslKwCPbN13cYv4EMBsnOSggEYQ4ulUMVuA2pBzJgBr0gzEvB+gFgE638AieSu7N8T8sVRyvweNA3gTkvBbzKw/bpJx6dgI+bJF1qjakHNmBjT4kKqgDCRS8bXSTYpR2EmqW81EWqR18/rzfmfzEe1iOtMZspQ0+GKpD58EBQE6c2OXx1XGSbIpCx9+zcNUKpp8iHztEyvy/3o+Ewe8ZgOzyzCfNL+3KYhC6IpMz8+34vFW86eAoQH5L55FIzhVcq2IsZoMBYfPmDAxvM69MX4AX+R2xb/9PzsFClp/iP8eSR22S5EpwtEk8GYMnuk9RPRQTzvGHstaLd7NpChK55783IlOF7xyhtvcaYNWtc5N8j3jkYszodifnMnDoPt+5/rlpHRJy2BDSNnBT3rpQp0utaGqNAE8y2Nf16K9nLf/t+eBZX8gbDl2LevjqNjfxLocmF8UfSIgMOUz7NUMSzG3hJppNyMyfi+AuhfLaW4k8RexY0lsCrJ5DQLdwet711hRBDLqNcW6Cl991J3LSiMfbCPIfN+KmI+3+jTqIsgU1YoeFwTZow3W4Dlxoa9LcVys5BiGTDtG8UvPo4EdWR+itQt0WfVHpWcLu20w7ZeQp7mBirf271D8GWcrZBf9GljCujQ1ZmeEjh2AoIeBsuYGLaBchP1wrtGFloOjgOzrL/Slk2yOTC82614i8GkH+Wv53bFiHN0GHoBs/P5oZhM+9dkDYHC90NMYlEmYnUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(966005)(6666004)(41300700001)(6486002)(478600001)(6916009)(54906003)(316002)(6512007)(83380400001)(86362001)(6506007)(9686003)(186003)(1076003)(38100700002)(4326008)(36756003)(2906002)(66946007)(8676002)(26005)(5660300002)(8936002)(66476007)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JkurBaM3SVGVdJODSjmmPyQA9Cpo4ChJ+EmknHgW6DpZOugLIJE9t7Eo+U7?=
 =?us-ascii?Q?gKHABv2roX3/w2yBWD/0oMxI8unDEpCEvnGDNPt63R+ZMopSBxvmzw6zvVEh?=
 =?us-ascii?Q?/BuzWF+Sm//yXyQPoaXC85ms02F8FX9SVTdo6ajA2rXWNPwX0lQgcn7qVujL?=
 =?us-ascii?Q?CSoQZHmWS0HttTVwfVwZ78J2slOynj/8DHDk+0aaZ3cZwln2TnO+vr/i93zW?=
 =?us-ascii?Q?/L9/4auFZXU2C7mqYx0gfZzc0rJ5iu2sFN6z34DWpXDyXgVRf66t5o5MspMi?=
 =?us-ascii?Q?7qW9TPuqhY4ATWOyW3rePqs51t0vcGvcSvSiGIuFNfygMsf+GBkRZN/PbEdP?=
 =?us-ascii?Q?Cx5UEwSypw+f509oKAolkJt1XsJ0pZcPFfXbojWH74lZjyf/rkOdt+vj2qLc?=
 =?us-ascii?Q?dT5t1iOaEbqfnJDhHhvix4OGZJE0GtpeR/gbuAqh+vxn9yTrbVVrMb3nmWx5?=
 =?us-ascii?Q?amAmTSOH376Pm7S4eXXv9NhYCBsOMfbZ2nMb63azeK9M/BDCQNj5BEXBdJ10?=
 =?us-ascii?Q?sXg8znsYgg6m9DvkhEvscpmBQDfuVQ5a8KVOO/lvIsdtJyy+Kr9pvukWJDGB?=
 =?us-ascii?Q?cS+nk+vtWG+qK6fMsEY8wjg5KtUFF3Oi/jqXxF1IXm2czJLO+tZN0Ma6l6kw?=
 =?us-ascii?Q?IxlL1PrR0CMNr3rv+GUO/1Xtro633VJTLTL36joL72+5HO+8wFqwzuO+GVfS?=
 =?us-ascii?Q?UGzcXQnAOBDf8RmV/vXkymhBpjgZCOAWe60b19NADX3W2lKkTm5Umi739ffw?=
 =?us-ascii?Q?UBGGP/W3/qbpV+PQ2EyjCsiW+9hRyZMx0zCFTm3H2Acbpk2H95urIShbKPDq?=
 =?us-ascii?Q?sKyV1C+uNlEkwgRtU8Ktkf/aeLWHzzNhxrDAfBJUHZTqrVa9y1i6U+7DpnR/?=
 =?us-ascii?Q?K+o+1ahJdKgjBy3nbdZ5cYk59jh4rwHgJzhW8980qrTQ5l7gINIHirwVSbUx?=
 =?us-ascii?Q?E/otKrCtYtOJWG7cyyzDmhUGuH1WhdqY3iNin1DaoG+jY+D6O/AD123izLRM?=
 =?us-ascii?Q?dzNcw0ANIK6twsQugdYwytx8nZCgJKRdMqO3VHedsEk58b83ahheE9tE7oSA?=
 =?us-ascii?Q?jbYUwaVcs5ucmPQQcByDzfHvQFfENskCFcgQW5xxiFhYfRdeiOkwU0dtqVZd?=
 =?us-ascii?Q?0lWp3YadNyD/nY0PmGbn/ia6IMfaagf5kt9qnlfx0l0VohGqO0QwWmJbgqyu?=
 =?us-ascii?Q?lEr6mMjJEwRUHGUL/QOJWZmwVFJQav5NbA2RiKtJexLzi2kWWRlbiaWkT6fV?=
 =?us-ascii?Q?WlMaTqsZICeAHaoAO4p7gFoliPV0sQBg3bWXlgEsKJkcDgWHSd89RhfWPA2t?=
 =?us-ascii?Q?ZVp4rXO2R6p6Pc14Ei9BaQzfBigRdsncloZELBWrvMt4mGusQh/pMLn4332x?=
 =?us-ascii?Q?99zi/+/I3j1q06woQPwcLoOhFVSK3wsDVjElpOOp7sJwt8i8wYm5/LZJN2y8?=
 =?us-ascii?Q?CeomUVDDpSZZKyxaeCDdgNaRpzLQCvIpeuTU2X9xxxVx3P2N8lmjXuCTWo6G?=
 =?us-ascii?Q?T2hqaUAGWnR6w0doRHdla591SNnG2QY4+G+slLuHjASKU4nUfCtyeMaUxqU9?=
 =?us-ascii?Q?ADzRL09oyybU86Eyst0YAnPZRr82ZMRdcWXlYojqff5U8bv8GUbcenmw9iPt?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c2fb3f-8791-47da-c474-08da97b08361
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 06:56:00.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGiRkWdMtmE4Zq0JqKuL7GIGU7i+7Yykl6b902NPy0X8YpmYFtr7sY/eCUp59GYwy97r/8aPa8AL5FX9i7NTdDVg+HGDKpt3qe4xDyJHSWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160050
X-Proofpoint-ORIG-GUID: LqsOJiJP4XJ2aHU_sJmoBllxcJS9CGDw
X-Proofpoint-GUID: LqsOJiJP4XJ2aHU_sJmoBllxcJS9CGDw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   62a6e699f4669b2c51f408273756f93b21c9f1a1
commit: 53b6e3b2164c5807669fbf6b3df0e1494b4d03b8 [149/150] iio: dac: ad5593r: Fix i2c read protocol requirements
config: x86_64-randconfig-m001
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/dac/ad5593r.c:87 ad5593r_gpio_read() error: uninitialized symbol 'val'.

vim +/val +87 drivers/iio/dac/ad5593r.c

56ca9db862bf3d7 Paul Cercueil     2016-04-05  79  static int ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
56ca9db862bf3d7 Paul Cercueil     2016-04-05  80  {
56ca9db862bf3d7 Paul Cercueil     2016-04-05  81  	struct i2c_client *i2c = to_i2c_client(st->dev);
53b6e3b2164c580 Michael Hennerich 2022-09-13  82  	u16 val;
53b6e3b2164c580 Michael Hennerich 2022-09-13  83  	int ret;
56ca9db862bf3d7 Paul Cercueil     2016-04-05  84  
53b6e3b2164c580 Michael Hennerich 2022-09-13  85  	ret = ad5593r_read_word(i2c, AD5593R_MODE_GPIO_READBACK, &val);
56ca9db862bf3d7 Paul Cercueil     2016-04-05  86  
56ca9db862bf3d7 Paul Cercueil     2016-04-05 @87  	*value = (u8) val;


In the original code the error checking prevented reading uninitialized
variables.  It's not really a problem, because ad5593r_read_word() can't
actually fail but, you know?  Technically the checker is correct.

56ca9db862bf3d7 Paul Cercueil     2016-04-05  88  
53b6e3b2164c580 Michael Hennerich 2022-09-13  89  	return ret;
56ca9db862bf3d7 Paul Cercueil     2016-04-05  90  }

