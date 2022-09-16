Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC125BA71C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIPG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPG5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:57:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4A6BD50
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:57:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G6vGZU008622;
        Fri, 16 Sep 2022 06:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=j8ZpW9khbk2UTOEWBVrHKbJWqg5PrrUyKJkuzbj39Lg=;
 b=UlpqUmlGr0lrwJvwpbHrumJ1ivbWu4cKEYV6kHPwSQtkAj/kIHKJGfwMjjW0SGH3ppjM
 TDFe0nZ8+COJyD3IHuuOmDxebyrUIiZ0Re99Id27Tx/7+PHhpo0NJMwm8iloLvSzbxpE
 CH2ZUkUvUHEZCrllbzRg6IKimHzueicZVOK8mSIs8v/EyubA/HZ0HIve1ou3H4O7zVjI
 QoaoeFS/TV2yrQKfZZDNSqXYDljjEw4A9JlTPVAtkopFM4dIPSQXfKZ2VvXZ9ardp9kX
 H2/yzvo5jxx/VcORZLwICoWal3kj2BHNurQRjdrgc73bocTr4LytfKFgqVXl0lpPmM9P tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xahgvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 06:57:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G59cgO015909;
        Fri, 16 Sep 2022 06:57:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x8ugch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 06:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxU1M8emLrvPygFFq/BxiivjPehDAXAOAPr2MfNEVpRYBLrImU/I9HWlW1r3pZVhhij5kLxVV5bd0tu/NoFWpM4DDw/oQiwZI/UM0vQa6y4ylNemxUms48MK4IcohMwz+JoO9Lbs57MWgdKjQDl2TtUhIKRZjeU0pguKM9ukUHmHO4IyoYU+7YFJ2kfSo9bH/e59c5nDt3prS2yCEAPqFytT8/0t0i/8O079VfH9LhyJ+OU49yDFw9hscvli4o03LBpQ3bX2AC0X3lW/AT55a8la5qnw3o8WGg6k89NoG1+U5VSxW9UJlgZSvScHencoffhv3E7lv8sNykOyNizvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8ZpW9khbk2UTOEWBVrHKbJWqg5PrrUyKJkuzbj39Lg=;
 b=WF/Q9QKris2/HrOff86mTZ7SVu8SgWXrzKtwlz1LMNdeZT0Nk1SPEINgq/YvM0Ihl4SoK0JgzTxhdE0awZSVfsbeFcDloLnHc6Aci1kCJg+VuEr+f9l035U+tQsj2YbS+yrltqOv+EKlf1EPUJ4nurPTjmYO43xomWUdsaMD6kY0OYyjdZkPZdZU005UqS2FbZGf+nRddsOgOcoesu8s8Kt4mOvamOlpyIRtv373FR+rvD1luxYq59r0j4TTUEsF29OuYfBZtp12DD+IPMLRPpWzufNrH9dmxhHcNz8uPr/MgdXH51oZ22Zaaiv30Wfqonct0rbISWZBko06Za4hpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8ZpW9khbk2UTOEWBVrHKbJWqg5PrrUyKJkuzbj39Lg=;
 b=BpuJBQne+4aKOoZzmNPjGQ0y6ErngCYjkcQD4H5HtD86l7+HBFoKGjQWFCHZ+z0C0lpf5cd7U/AWEnW8z6anQZPZl7FR4cLL9bLnhuw17UIAFRyEfxSQrPT9gWulO40Nzig+yXtT355mSUxYJRRATjEuzN2gwqfmZUg7F01Oq4A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4952.namprd10.prod.outlook.com
 (2603:10b6:408:122::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 06:57:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 06:57:08 +0000
Date:   Fri, 16 Sep 2022 09:56:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Russ Weight <russell.h.weight@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: drivers/fpga/intel-m10-bmc-sec-update.c:103 flash_count_show() warn:
 possible memory leak of 'flash_buf'
Message-ID: <202209160713.HoIRfGTB-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: JNAP275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 626b9171-2870-478f-b71c-08da97b0abe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFQMvjT4w0ya376qKhpoeUSKSuL2aPP1Wa8EcPFkg9dH3OP6m+pYEi/7Lx4PPCXJuAhQ4HPIEV++cY7a63WH5zysUm48YaLgitYoble/z6GcPPWtCjuc8EN062l2IvSq7FPhcruiB0jlUAgokchNQvxdFZquGtB8eRhi71/g+bpawXt+anoPR8v+IGD58MtDD4s2dutqEJgJZ4gbz7caQ+mRmAdD54Jbs98P97hL9CtNariYQq6IE35UhB6c1B2HHkMqmZxd/AVqYQtkIJXAQr4JSmIH0/rUJwxDTEffdQlgps1kNCOrNGQRUf69MZFBQttMPQ8P2L/Hv1m9rd5WfajNGP7eb3ql34bHbwvooeRFp3YIHqecRC1sBdHx9Nu/GIo71SsT0lzyIYTessQNSixpY+3bfGcMPam0xmdHvI3EMdStCRtxAiR7GG9xfSmWKnmU5auHafKZRwloTJm4A81cA2Hm/q9QkxywMOw8MjxFkLt+hN+NiSYGyIGmUVBMGl1ITA1MSMdwsG1CcVQc6f2IDb3h+233FNctNihxljEUjNND+T9+VTz/B/ewWo/06QOZbKj4LjDX5Ejq8j2CUMgSiXu2qZNgPkRWE4GL9nuvBl4bljIPv4hCnsrzlZYwkDWJJ0XH2zo+BWB0k9fh13DliXxtzQiRCRLe6OCTkkzjxD2kNKfObMLGEpAGdVhH85t6tMVii0NmXLAMAbyB3qyGFkHDOY2Mkj4FrxZVTdVZlUMAAQMaCgV58u6TmUmXXiu/N4ZFbyaWqmRyIleuGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(66946007)(66476007)(66556008)(8936002)(38100700002)(44832011)(5660300002)(2906002)(26005)(15650500001)(9686003)(6512007)(186003)(6506007)(1076003)(83380400001)(6486002)(966005)(41300700001)(478600001)(8676002)(6666004)(4326008)(54906003)(86362001)(37006003)(36756003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXLuEaIWFQUICkwl7RvyIuq59cwYftPVnrCQwpxCKRvGoVbjYhkt5CV71PGO?=
 =?us-ascii?Q?VPJgLzWNUzBy8hUQVehCVR91RIUjZvyfV8IVdv4EkSwecUIjGKVOiYFWKbsm?=
 =?us-ascii?Q?mse9PiOjj2zdtjoY8ElUFwdmsE0RM8bBILodf1sqA7zOfaCcfzs8hHIDuRoz?=
 =?us-ascii?Q?EkgkXYM1lJ6j8rJSLxyaJThhBidq92J9EYc82YnZ39NOZPtylNwpx3sP3G4q?=
 =?us-ascii?Q?KuaeqMkx2sQTLJQKsi2AF/V+Kqm6dO7CVcLHNjhd3RJoDBSi3/KK0OgFbtu8?=
 =?us-ascii?Q?aWFoCnEYk1zJJ1zRxezRsGfx/5kEy2/PB6ASEmv3gTFSwruL6M3MacnzOgrm?=
 =?us-ascii?Q?qvz4IGfODShrhGs4ptzes6LAdXQj8c1Ldo181b6J1+s+t1xIoOx4hAAGxViH?=
 =?us-ascii?Q?ecojbk0rfdGidB5u0BXWaktQ3GwOeVZpZ161Qewr3Z41+Yxl2n2+ycbW/n4t?=
 =?us-ascii?Q?KlLx8poc72hvXaPngyrN7qBReUX5Mtn0PrExVfgFIyQSPzaULEsqoVXkXxxZ?=
 =?us-ascii?Q?KUB6X0MV9SW5S+0yxuX57Hm3RFoqcwNsFV2Mp3usyiTy67LOPpQbc1nL93Fb?=
 =?us-ascii?Q?5CPWZSnbEFzbi6/KUr4V94ws/uwHKJlQfEPx0kyIqHY/eOo0ZU6xphSWxSbg?=
 =?us-ascii?Q?DeqVqzH0lBpiTGBNXBTSGpGpHp7+NMMuCJkggVuFgpaEswi6B9m9tlhRyTaJ?=
 =?us-ascii?Q?qMFTq7gWd8hwTXLE3u+JDk4Omr5G4NXkkBdAYquBi2MiaWZaLFS0qwlDgtxR?=
 =?us-ascii?Q?YzApBvAfReig07hor1Sc5z1qcav2rkya6jhIWXCFzawlV/wRrK5ArIlas8C/?=
 =?us-ascii?Q?dAJepZodOKAswD0rdb0SotR+oAsNmpF4dhQqaquebDCdc3awJxEyyPTv8wQy?=
 =?us-ascii?Q?C02hMN2CIoreGQIikfl1zYLNmJNbdsmtI1k57hJjBlNBVgvpdPiqCSgzYtkq?=
 =?us-ascii?Q?+jgGi37fuoZuEToIH1bjn+EarVYq4iLwh8CVW3dXyVwO0FEQurcoGGQbIo53?=
 =?us-ascii?Q?xrqtXxPDKv4Hfh2LKXq28xxkTUF2+Me+EVIcJMPC88H/FeJvLIAS0hoT3fVE?=
 =?us-ascii?Q?yAhtJjIoc/Xhx4/JjNQ5mYHecWPbkG3073BMtmRGuhIGRIcx7KAbWFb8O52D?=
 =?us-ascii?Q?6z0CLy4FjF+e+ukQvk99maeV/Lq7HvP1Hi3Sf8tx307NfKuGBx3jdPqNykey?=
 =?us-ascii?Q?wmc1NJ5nJo4vfMWqVKuvpPelpHXgk9zlRebShrJ3tF0idjZYYm+/ZClsUJk8?=
 =?us-ascii?Q?/EdxlYSbZbHG3GnYZ506HFppxe09UfvKUcFR6S755VR/sWweQ4KLkXUrL/ex?=
 =?us-ascii?Q?a5NUvg+EQEPpUDX4N4NaCy9ArdG2Mp52ugZULh69/29vR/KqkNLX05ls8tAd?=
 =?us-ascii?Q?WZIfI4kNojjAoq77xWz2kkKSCNzkUpYsPIg19BTJMa+xeNNoeNXBgLJ6S5Je?=
 =?us-ascii?Q?++iiyhg+F7i3JS1MoVZVCRo9NYZ2X9XNpSFiQawCpFyoNyIQeTwb450ueWDD?=
 =?us-ascii?Q?0mXvD/qH+F8rYY7nKF7hI1+cfz4nQojyFURUGqn/LPN+XGNpmIhFUTucoiQQ?=
 =?us-ascii?Q?u8Dycrsb6RSPwnoYzexJGNqdcMNWnj7RRCHhhC07lqyllOq8GmAbf49r94iT?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626b9171-2870-478f-b71c-08da97b0abe1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 06:57:08.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdR1fRYk932AcM1sgyDxlfo1D0ki0nPSJtJAO8n6deiqTQPnVGqonF8veNwAwg1D4X006SNyjxtdpl0DAd7ylzTMbSMjIS5rkVlVbCB0sO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_02,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160050
X-Proofpoint-GUID: eLlGsWmn7l_rTQsVWSyDqVo5WDgpVNgE
X-Proofpoint-ORIG-GUID: eLlGsWmn7l_rTQsVWSyDqVo5WDgpVNgE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: 154afa5c31cd2de5e6c2c4f35eee390993ee345a fpga: m10bmc-sec: expose max10 flash update count
config: m68k-randconfig-m031-20220914 (https://download.01.org/0day-ci/archive/20220916/202209160713.HoIRfGTB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/fpga/intel-m10-bmc-sec-update.c:103 flash_count_show() warn: possible memory leak of 'flash_buf'

vim +/flash_buf +103 drivers/fpga/intel-m10-bmc-sec-update.c

154afa5c31cd2d Russ Weight 2022-06-06   83  static ssize_t flash_count_show(struct device *dev,
154afa5c31cd2d Russ Weight 2022-06-06   84  				struct device_attribute *attr, char *buf)
154afa5c31cd2d Russ Weight 2022-06-06   85  {
154afa5c31cd2d Russ Weight 2022-06-06   86  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
154afa5c31cd2d Russ Weight 2022-06-06   87  	unsigned int stride, num_bits;
154afa5c31cd2d Russ Weight 2022-06-06   88  	u8 *flash_buf;
154afa5c31cd2d Russ Weight 2022-06-06   89  	int cnt, ret;
154afa5c31cd2d Russ Weight 2022-06-06   90  
154afa5c31cd2d Russ Weight 2022-06-06   91  	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
154afa5c31cd2d Russ Weight 2022-06-06   92  	num_bits = FLASH_COUNT_SIZE * 8;
154afa5c31cd2d Russ Weight 2022-06-06   93  
154afa5c31cd2d Russ Weight 2022-06-06   94  	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
154afa5c31cd2d Russ Weight 2022-06-06   95  	if (!flash_buf)
154afa5c31cd2d Russ Weight 2022-06-06   96  		return -ENOMEM;
154afa5c31cd2d Russ Weight 2022-06-06   97  
154afa5c31cd2d Russ Weight 2022-06-06   98  	if (FLASH_COUNT_SIZE % stride) {
154afa5c31cd2d Russ Weight 2022-06-06   99  		dev_err(sec->dev,
154afa5c31cd2d Russ Weight 2022-06-06  100  			"FLASH_COUNT_SIZE (0x%x) not aligned to stride (0x%x)\n",
154afa5c31cd2d Russ Weight 2022-06-06  101  			FLASH_COUNT_SIZE, stride);
154afa5c31cd2d Russ Weight 2022-06-06  102  		WARN_ON_ONCE(1);

do this check before the kmalloc()?

154afa5c31cd2d Russ Weight 2022-06-06 @103  		return -EINVAL;
154afa5c31cd2d Russ Weight 2022-06-06  104  	}
154afa5c31cd2d Russ Weight 2022-06-06  105  
154afa5c31cd2d Russ Weight 2022-06-06  106  	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
154afa5c31cd2d Russ Weight 2022-06-06  107  			       flash_buf, FLASH_COUNT_SIZE / stride);
154afa5c31cd2d Russ Weight 2022-06-06  108  	if (ret) {
154afa5c31cd2d Russ Weight 2022-06-06  109  		dev_err(sec->dev,
154afa5c31cd2d Russ Weight 2022-06-06  110  			"failed to read flash count: %x cnt %x: %d\n",
154afa5c31cd2d Russ Weight 2022-06-06  111  			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
154afa5c31cd2d Russ Weight 2022-06-06  112  		goto exit_free;
154afa5c31cd2d Russ Weight 2022-06-06  113  	}
154afa5c31cd2d Russ Weight 2022-06-06  114  	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
154afa5c31cd2d Russ Weight 2022-06-06  115  
154afa5c31cd2d Russ Weight 2022-06-06  116  exit_free:
154afa5c31cd2d Russ Weight 2022-06-06  117  	kfree(flash_buf);
154afa5c31cd2d Russ Weight 2022-06-06  118  
154afa5c31cd2d Russ Weight 2022-06-06  119  	return ret ? : sysfs_emit(buf, "%u\n", cnt);
154afa5c31cd2d Russ Weight 2022-06-06  120  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

