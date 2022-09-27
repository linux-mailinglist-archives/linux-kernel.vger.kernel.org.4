Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D465EBDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiI0Ipf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiI0IpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:45:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77421BF6D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:45:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8StMQ032658;
        Tue, 27 Sep 2022 08:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=BMYVz5hw52qzYntpHJrMdBg9lxLpQh2H4oJL9fIL8fE=;
 b=EtnI4hPt7NaEOmU53T0SNzF7ou0Hgxj/wmGt1vHyZged/rWDyqJcDO5pxsEiDZbztCG+
 Yo0RzsMPQDzzhOiXp6FeDyNOb9i4hgp6F4RLW9X//RhySnf0FNkt/yqOrGxn7HkGzsQi
 lwzlaF/CmOCAwKzdq24RGzv7fM7QRgAk9i3lPJ78nbsZ8XxyZbOnrKfqj58gDzp6G130
 gJWSMNbIn/ZS5B55wB9gf5bC9Bk5ZbzPBiKmu9RSAQvJDE0QgyiKCOtDg4H+jCp2+9ST
 Ng2HeTvt8naqIE1evpWaoAjnGe3u4D5EqgPtWdAKC3RRbRp0q6W0IjRu49feA5Jb4S9h pA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwdyxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 08:44:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28R81tbI023823;
        Tue, 27 Sep 2022 08:44:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpq7s825-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 08:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBOMe9FhUk55Sm48OH38ROz4FPPizBSwz48aPmTLoC80SKDsPCNgLYehpnXRE+6HQJK4r89kg3d3UosB+ve4+VuXgU5MrNIUj5qcnPe260GL1xwHA16vgpr0MNNIeEdaQWTwHsBPJQhXMATWWVOpRy/4idjhODZP79Uir2VEJhSkDWZ1kMHOE7ddZMqFKN3L4kuaDLKhdhlfnJlnhtQPqoub0vgbmml41O5eJgZblFpQ2EFnkePEGVTeAaWx5e4W2QPKZKVMjHG8cbajAFDOPyGczyC8LZSd04FDvnCpCX9Y0QH76L39yo5VDz0qnMksIrvews61z+4dum2YB2S6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMYVz5hw52qzYntpHJrMdBg9lxLpQh2H4oJL9fIL8fE=;
 b=POS13Uh+WkegdHOI6qfLEmLSkzN/DJRom02sGYz8R+3A46E9oNmozMKGZbKcR9sBKL89wVRr7FOHd2SmggY88/vACfYhN08xeYC/QALB0L0pEwbOhXW/xb/Mc5TR0j1Vcywz/fLhgMtwd9XUJshdPnH+ddLpZlqf97gyNBK3dnVkwVPS4T/PfgugEW9Qty8qCw6nTWIrRy8lc2D2rOhaWRekSMVKoATU0rTd0oSP8fFqzQvBmZfdLc1CYhycRU3/4uCJWy/BRn7rQNIU7e9FxuIx7xRAroJxXTCMDaUi3IZvJElf2h0rX8YiA6wMEeRjRTnpLfwFnSOYkzyOrLTf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMYVz5hw52qzYntpHJrMdBg9lxLpQh2H4oJL9fIL8fE=;
 b=x86jZohRQAd9sXHPCv6LG5mD01X0lGyLSztbWSYkTZbPiK0UuY3lZcFcNCfFgv2hnFDGjnjZRbOt5hjasOTICpfgspqIAl1gRqNtsmlwowKYM9I27zW2YsBbLupffrLiqFu0zttikvNOZ2RVNcn/iLfDzj0kCi7J+/nbDO8IQrk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6674.namprd10.prod.outlook.com
 (2603:10b6:510:20c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 08:44:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 08:44:44 +0000
Date:   Tue, 27 Sep 2022 11:44:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 55/63] drivers/iio/adc/mcp3911.c:441
 mcp3911_probe() warn: passing zero to 'PTR_ERR'
Message-ID: <202209270726.iTLNBc3Y-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MR1P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 639974dc-6188-4495-9bfe-08daa0648670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZihQHqFo+uYdTRNtvElNdLeoo0CgB9efBk0ZZgeMl1Rnla/L7IH6o1L9XDWqFXryEt8iNST1aukIhDKbcRVueunJDaYYyjBeZFlg6aAc3secHGT9xyWiu2cMqLnMTC/3NhmsoBm8TOH7kbyZ4Vu97u/1m77upNZ4//1j9fKEKQKJ5K5zgHvgbR3w41hRzFz4rhDfeflg6J2x1GnWRxhkCKW6pxF6Ko5eyV10UdsVxFPAsvnlrE8mWsVrF6MFbs53s4AHQFnTXFekRpLYibwan/TrzqSRsIf3SJNhiJKBJCEvBw7okHl5RSKOR6gn5ECIc+Jg3knmKqVMIyQtY2uJ+JMYwawtXfw4WP1aMvRfS3+WJmcvrIbArAJIhSlGycPTTydNZsYOYO4bIqMQX7gQ3T/uhpJ7K7UqFGxXTKjiUEhjwiSnNkITs55lamuYP9jLP2JWBk8/DGNrLVOn6ZhbHW9s8rCAZj52kubHx36upa03q15kbcHiheKf7awilVMMzgHXld8e3eoXzRcSVd6XhPuVLTS2ApXa28DUeD0C/GCvJIjm05gRPKWX8MvmC+V6/qv4eDeluNwp8ymC2WPc9z917TN0uf8ao4O5y0uRHSCWOrVkPdxsZXTW70EvxhxVkTYghTQrGkUyRKzJ59agMIWXvAPYIMOFa2lsqXs5JyO18AC259IxCFWrwaQPYWJUS3zjrmHc/aqLJXIXoQyZBXNXIn7oA0GR5Af57zuvfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(6512007)(66476007)(66556008)(66946007)(26005)(4326008)(2906002)(9686003)(44832011)(41300700001)(186003)(5660300002)(316002)(8936002)(478600001)(8676002)(86362001)(6506007)(966005)(6486002)(6666004)(38100700002)(36756003)(1076003)(54906003)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FHRrGrqqeSZ7Xt3Ot6ge+mlX+X9hLKpnvTpzvrB0g4//4K87dq15+ziS9Rmn?=
 =?us-ascii?Q?ue7+aCAtp15mjY0OYHVpbpd8QfP9nqGKYpIyhh9kidXLfi3Io0qoZkT1PohN?=
 =?us-ascii?Q?uBu1aEGwDyYUDgyLj/3TKxMqMvsWCOMV1OYaz8HwKIAsbIJhj0fXzGeaJHeF?=
 =?us-ascii?Q?wbq9IbPOU3964Sb1P2jaUP1N6xZb78yvNJC4oVDRiifqdFPwnY/IzmcKPzNn?=
 =?us-ascii?Q?Td3QG2M78+6q3yQPkjKqpDe9ZEKVt/WHXnfspqtgoengWWGqHwn4E+lUUdWu?=
 =?us-ascii?Q?cKLrKJ4oBiYGlab39EpQe3Ua1JSvec0PhXg1L9iBTVJHkPmstCkAp9MNuDPW?=
 =?us-ascii?Q?6yRZZJciQuXlGCoqOQP3I+QRJzUEjF3BQccO6ApDzmHRA62jodY/VYh50Rly?=
 =?us-ascii?Q?U8qmvL3JBtKm1NEzigNyzbpdV7hqzI/a6jY+a2PHnFze6pwxg2zjuEJHDMX1?=
 =?us-ascii?Q?iFeqZcKDoaM2ZnpRFlhCHUxDiiOVjIfFk6WeOtXBPMNYz70eJADU29nGPTQ+?=
 =?us-ascii?Q?xsGMmT9eyYn76CmwGqmV4kp7QrGLmXSiWNRdApa2M1xj8aJGAq6pSm3D5Lpi?=
 =?us-ascii?Q?wiP1+PMJEHkjheGjCdEeI/zrgmfNiZhEZaOdJ68E2UrZoCnInh+zWZSCQHYa?=
 =?us-ascii?Q?QH3lRNzOmuvetjFfQxThwVQt5/bXkHF/0vWO7jLr078bEFDz2B1L6KnibdCS?=
 =?us-ascii?Q?YJ91dGxyp+6tRjxzZ7PzTHVdOtgXYRVdXQ8mLl5N0Ak6DwNHpQdHrkahf/TW?=
 =?us-ascii?Q?Ge+yEF39Q6V5GiLcMnQEpwHT7gtDStYMoke2gGgkfJPA8JiVWkr9dtY4GaBO?=
 =?us-ascii?Q?WemHZsxQiiglnMXTzX83QuFDxRkGf9dceowLrWMavfvu53e9csV4mrOijzDc?=
 =?us-ascii?Q?7lovTMFqmlButY8J6rvnBWko17Ym5nNVLxJcHW2NVx3VOU/FXEnfVtWGKCQW?=
 =?us-ascii?Q?AytSxt/01t0Lof75n6A/ta+DljrEsShSYHO3hmlpMaJ3B9XQVMxAEHEC4JUI?=
 =?us-ascii?Q?oh/qEzcasx1l+cjZl2nrWEEEH0Wlu3CnVd8D9Kk7iIjwsZzmSJ/dm9WNDxxP?=
 =?us-ascii?Q?smpej7+nFGWScp17+s8oYA15lBJZ9rMPL/qtir+3ZXUkMee34dTJ6M6Ol59d?=
 =?us-ascii?Q?9N5HLmZFzJ+j2LaoC4nWz4R1DLq3B3hobjP7oTzQ7E0YaHgwUBaHaWJq4zls?=
 =?us-ascii?Q?b2zrKCU41ShP/RP4fVt5ROjmvCa3qZSLN5GCXbK67RONgs/eZUIdisbrajTl?=
 =?us-ascii?Q?QG4OO43fsdT+dt4mG4ySVkc57dTQcB/odxPPtXDPgIkNddR6uoT/iYhAr22N?=
 =?us-ascii?Q?0CL6voPWUPLULtronOCMJxLD7XwsiWWj6NYTxkyuja4WONVeSmtgLIK2VBA5?=
 =?us-ascii?Q?PZy9GAgRVe7Sd2IjD4Np5LS5euXtLsFWUclpwKKr9/EIFEICWQRI8UF+u/kq?=
 =?us-ascii?Q?ptP7rnK0xlgtJ/edCU+jfYQvoEtGU6cc/O7ZyzkN9lozQeMgZkt9bX5usIgO?=
 =?us-ascii?Q?sDVpIpX+T64sdPQlqiGy6N0AIaj+M3uGnOUGjn9QzRSI6cp8/ZZ/p0fGlRCx?=
 =?us-ascii?Q?cgQCJ9nBb4KBrc+IOUQJecsEouWhQcQ662L0hjDG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639974dc-6188-4495-9bfe-08daa0648670
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 08:44:44.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWU6oJXyLe9uMlky/otf8wc1NV3wWcv9sXCxzQhVjSqa18Wp8+ZBr4KmF1eN+040NIo5tXC+j85KeI6kbEtoXIHippOFjGcsULE0iWCJSKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270051
X-Proofpoint-ORIG-GUID: iez5pOf3ERuv2ezoomNx0fOEyEFnks4M
X-Proofpoint-GUID: iez5pOf3ERuv2ezoomNx0fOEyEFnks4M
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   df957373c1649c74b78bf2fcfd144f0c3baa68a5
commit: 08a65f61db69ae4850c3c15e8fbe6293a09a998d [55/63] iio: adc: mcp3911: add support for interrupts
config: openrisc-randconfig-m041-20220926
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/adc/mcp3911.c:441 mcp3911_probe() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +441 drivers/iio/adc/mcp3911.c

3a89b289df5df4 Marcus Folkesson 2018-08-08  366  static int mcp3911_probe(struct spi_device *spi)
3a89b289df5df4 Marcus Folkesson 2018-08-08  367  {
3a89b289df5df4 Marcus Folkesson 2018-08-08  368  	struct iio_dev *indio_dev;
3a89b289df5df4 Marcus Folkesson 2018-08-08  369  	struct mcp3911 *adc;
3a89b289df5df4 Marcus Folkesson 2018-08-08  370  	int ret;
3a89b289df5df4 Marcus Folkesson 2018-08-08  371  
3a89b289df5df4 Marcus Folkesson 2018-08-08  372  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
3a89b289df5df4 Marcus Folkesson 2018-08-08  373  	if (!indio_dev)
3a89b289df5df4 Marcus Folkesson 2018-08-08  374  		return -ENOMEM;
3a89b289df5df4 Marcus Folkesson 2018-08-08  375  
3a89b289df5df4 Marcus Folkesson 2018-08-08  376  	adc = iio_priv(indio_dev);
3a89b289df5df4 Marcus Folkesson 2018-08-08  377  	adc->spi = spi;
3a89b289df5df4 Marcus Folkesson 2018-08-08  378  
3a89b289df5df4 Marcus Folkesson 2018-08-08  379  	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
3a89b289df5df4 Marcus Folkesson 2018-08-08  380  	if (IS_ERR(adc->vref)) {
3a89b289df5df4 Marcus Folkesson 2018-08-08  381  		if (PTR_ERR(adc->vref) == -ENODEV) {
3a89b289df5df4 Marcus Folkesson 2018-08-08  382  			adc->vref = NULL;
3a89b289df5df4 Marcus Folkesson 2018-08-08  383  		} else {
3a89b289df5df4 Marcus Folkesson 2018-08-08  384  			dev_err(&adc->spi->dev,
3a89b289df5df4 Marcus Folkesson 2018-08-08  385  				"failed to get regulator (%ld)\n",
3a89b289df5df4 Marcus Folkesson 2018-08-08  386  				PTR_ERR(adc->vref));
3a89b289df5df4 Marcus Folkesson 2018-08-08  387  			return PTR_ERR(adc->vref);
3a89b289df5df4 Marcus Folkesson 2018-08-08  388  		}
3a89b289df5df4 Marcus Folkesson 2018-08-08  389  
3a89b289df5df4 Marcus Folkesson 2018-08-08  390  	} else {
3a89b289df5df4 Marcus Folkesson 2018-08-08  391  		ret = regulator_enable(adc->vref);
3a89b289df5df4 Marcus Folkesson 2018-08-08  392  		if (ret)
3a89b289df5df4 Marcus Folkesson 2018-08-08  393  			return ret;
0e0a07adaff971 Marcus Folkesson 2022-08-15  394  
0e0a07adaff971 Marcus Folkesson 2022-08-15  395  		ret = devm_add_action_or_reset(&spi->dev,
0e0a07adaff971 Marcus Folkesson 2022-08-15  396  				mcp3911_cleanup_regulator, adc->vref);
0e0a07adaff971 Marcus Folkesson 2022-08-15  397  		if (ret)
0e0a07adaff971 Marcus Folkesson 2022-08-15  398  			return ret;
3a89b289df5df4 Marcus Folkesson 2018-08-08  399  	}
3a89b289df5df4 Marcus Folkesson 2018-08-08  400  
0e0a07adaff971 Marcus Folkesson 2022-08-15  401  	adc->clki = devm_clk_get_enabled(&adc->spi->dev, NULL);
3a89b289df5df4 Marcus Folkesson 2018-08-08  402  	if (IS_ERR(adc->clki)) {
3a89b289df5df4 Marcus Folkesson 2018-08-08  403  		if (PTR_ERR(adc->clki) == -ENOENT) {
3a89b289df5df4 Marcus Folkesson 2018-08-08  404  			adc->clki = NULL;
3a89b289df5df4 Marcus Folkesson 2018-08-08  405  		} else {
3a89b289df5df4 Marcus Folkesson 2018-08-08  406  			dev_err(&adc->spi->dev,
3a89b289df5df4 Marcus Folkesson 2018-08-08  407  				"failed to get adc clk (%ld)\n",
3a89b289df5df4 Marcus Folkesson 2018-08-08  408  				PTR_ERR(adc->clki));
0e0a07adaff971 Marcus Folkesson 2022-08-15  409  			return PTR_ERR(adc->clki);
3a89b289df5df4 Marcus Folkesson 2018-08-08  410  		}
3a89b289df5df4 Marcus Folkesson 2018-08-08  411  	}
3a89b289df5df4 Marcus Folkesson 2018-08-08  412  
4efc1c614d3348 Jonathan Cameron 2021-12-05  413  	ret = mcp3911_config(adc);
3a89b289df5df4 Marcus Folkesson 2018-08-08  414  	if (ret)
0e0a07adaff971 Marcus Folkesson 2022-08-15  415  		return ret;
3a89b289df5df4 Marcus Folkesson 2018-08-08  416  
08a65f61db69ae Marcus Folkesson 2022-08-15  417  	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
08a65f61db69ae Marcus Folkesson 2022-08-15  418  		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
08a65f61db69ae Marcus Folkesson 2022-08-15  419  				0, 2);
08a65f61db69ae Marcus Folkesson 2022-08-15  420  	else
08a65f61db69ae Marcus Folkesson 2022-08-15  421  		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
08a65f61db69ae Marcus Folkesson 2022-08-15  422  				MCP3911_STATUSCOM_DRHIZ, 2);
08a65f61db69ae Marcus Folkesson 2022-08-15  423  	if (ret)
08a65f61db69ae Marcus Folkesson 2022-08-15  424  		return ret;
08a65f61db69ae Marcus Folkesson 2022-08-15  425  
3a89b289df5df4 Marcus Folkesson 2018-08-08  426  	indio_dev->name = spi_get_device_id(spi)->name;
3a89b289df5df4 Marcus Folkesson 2018-08-08  427  	indio_dev->modes = INDIO_DIRECT_MODE;
3a89b289df5df4 Marcus Folkesson 2018-08-08  428  	indio_dev->info = &mcp3911_info;
3a89b289df5df4 Marcus Folkesson 2018-08-08  429  	spi_set_drvdata(spi, indio_dev);
3a89b289df5df4 Marcus Folkesson 2018-08-08  430  
3a89b289df5df4 Marcus Folkesson 2018-08-08  431  	indio_dev->channels = mcp3911_channels;
3a89b289df5df4 Marcus Folkesson 2018-08-08  432  	indio_dev->num_channels = ARRAY_SIZE(mcp3911_channels);
3a89b289df5df4 Marcus Folkesson 2018-08-08  433  
3a89b289df5df4 Marcus Folkesson 2018-08-08  434  	mutex_init(&adc->lock);
3a89b289df5df4 Marcus Folkesson 2018-08-08  435  
08a65f61db69ae Marcus Folkesson 2022-08-15  436  	if (spi->irq > 0) {
08a65f61db69ae Marcus Folkesson 2022-08-15  437  		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
08a65f61db69ae Marcus Folkesson 2022-08-15  438  				indio_dev->name,
08a65f61db69ae Marcus Folkesson 2022-08-15  439  				iio_device_id(indio_dev));
08a65f61db69ae Marcus Folkesson 2022-08-15  440  		if (!adc->trig)
08a65f61db69ae Marcus Folkesson 2022-08-15 @441  			return PTR_ERR(adc->trig);

This is return 0;  It should be return -ENOMEM;

08a65f61db69ae Marcus Folkesson 2022-08-15  442  
08a65f61db69ae Marcus Folkesson 2022-08-15  443  		adc->trig->ops = &mcp3911_trigger_ops;
08a65f61db69ae Marcus Folkesson 2022-08-15  444  		iio_trigger_set_drvdata(adc->trig, adc);
08a65f61db69ae Marcus Folkesson 2022-08-15  445  		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
08a65f61db69ae Marcus Folkesson 2022-08-15  446  		if (ret)
08a65f61db69ae Marcus Folkesson 2022-08-15  447  			return ret;
08a65f61db69ae Marcus Folkesson 2022-08-15  448  
08a65f61db69ae Marcus Folkesson 2022-08-15  449  		/*
08a65f61db69ae Marcus Folkesson 2022-08-15  450  		 * The device generates interrupts as long as it is powered up.
08a65f61db69ae Marcus Folkesson 2022-08-15  451  		 * Some platforms might not allow the option to power it down so
08a65f61db69ae Marcus Folkesson 2022-08-15  452  		 * don't enable the interrupt to avoid extra load on the system.
08a65f61db69ae Marcus Folkesson 2022-08-15  453  		 */
08a65f61db69ae Marcus Folkesson 2022-08-15  454  		ret = devm_request_irq(&spi->dev, spi->irq,
08a65f61db69ae Marcus Folkesson 2022-08-15  455  				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
08a65f61db69ae Marcus Folkesson 2022-08-15  456  				indio_dev->name, adc->trig);
08a65f61db69ae Marcus Folkesson 2022-08-15  457  		if (ret)
08a65f61db69ae Marcus Folkesson 2022-08-15  458  			return ret;
08a65f61db69ae Marcus Folkesson 2022-08-15  459  	}
08a65f61db69ae Marcus Folkesson 2022-08-15  460  
5db9f38d394f12 Marcus Folkesson 2022-08-15  461  	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
5db9f38d394f12 Marcus Folkesson 2022-08-15  462  			NULL,
5db9f38d394f12 Marcus Folkesson 2022-08-15  463  			mcp3911_trigger_handler, NULL);
5db9f38d394f12 Marcus Folkesson 2022-08-15  464  	if (ret)
5db9f38d394f12 Marcus Folkesson 2022-08-15  465  		return ret;
5db9f38d394f12 Marcus Folkesson 2022-08-15  466  
0e0a07adaff971 Marcus Folkesson 2022-08-15  467  	return devm_iio_device_register(&adc->spi->dev, indio_dev);
3a89b289df5df4 Marcus Folkesson 2018-08-08  468  }

