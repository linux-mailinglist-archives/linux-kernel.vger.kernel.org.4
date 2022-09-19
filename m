Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D663A5BC530
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiISJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiISJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:20:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5D8BCBB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:20:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J9EB3I026653;
        Mon, 19 Sep 2022 09:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=H+rvA184RWTdaB0ERBimUBUFhfkGe+7pZNq8yFigvqw=;
 b=QGbsUDuUETYwoOH+cv8jLKbFxNM/+4GE51pK7y5GGw3ECzMC7ricSe5+n5jB15IModOx
 MAxWiI9uYBoF3vQNgD6v7g/5eipSgYfD2oNNE9oGR83ErEAWxKBhbziE8mEWbUZ8b/sp
 Sfr55qJZxL+2TjCdGn0hdKJFjuWZbr6sc9XuhDoTdwAu8K+dO5/AP2New25nrFoED+kw
 xDCgi1AmsEul+7NHvGwLuO7I2gx4e8CP955UfP9HNSvcjSL2MFJHzgdwdx7kiGRoQ1ez
 YfeD+o/PlNjdIe1nPVD05IMTG6k8LaXM4CW/xsOSK4OIxXwrdsDH17g3c9NtTn0LNLTB VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stb8pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:20:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J7UMAf036405;
        Mon, 19 Sep 2022 09:20:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39c3atq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjIIjdWcpxqf39uj1sKnTorMi7t7PPCQq5/NciSkU/2oMa34i1nUbEKeviRVJvS2D0NFI8XfGMCXewVRCcHraXxX8/LpxtlEp9YmAf4rvZdpLDs6SpwxERoDHT030VE9oN1gPZrXWX+qIiTmvB195WSovkl+2cEFie1kc3K+RR9fowJjJryI1uau7epMqGpZ3bPx3lw72mANjvAWaXHiJxxpZGxPBayeK7CuBFAyxvCIIVRQtvZnhP1BaKlMylYknPId3GHjs06l9XknvbS6Ye52GMNjPoZVtvhYePvc3/0AF458x4kkeS+CirB2GPsvc+X49Ly9jLQNFNbZEOltvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+rvA184RWTdaB0ERBimUBUFhfkGe+7pZNq8yFigvqw=;
 b=cxxyIpb4V88FlzGVM/AqHYwjYovHGo7Auge905EZCCKYmzHDggcqq5dyQ4YG3luKZ9JsDF1B/ClencFU9oDYGGrl0XQQtVMmQx0CJvIoB5I6Me0DEVfYfn4jlU9w///gJGWV6ZssCl1ULn/hwF518uIRqeY2dMiTC8iirPvcrf/qELPKTJrOxnjDmlNb2K8tePWOL9+MzxBp7+L5XZHFnRZ17MDRLxGx3IXwyLDfyR0zyyIi32qroKf/Wc8EoIgyBdjUk7BbUZ9G5sLvlv0/2uxNq1bW5hytqL75zUidbujLaravrE2f6e+HgP4tqRgyUJI/MiykP2+fxumraR3zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+rvA184RWTdaB0ERBimUBUFhfkGe+7pZNq8yFigvqw=;
 b=NNxZXve80Y/VxA0OpnI7vAZ7eemLR0VLSk1BliXMFm0PPowfQG8thjPP9dGHWNY98XNeht3XxbhFJjdIV9F5OqEMu9D92IQYplbFyHzQyXksF6aZb/M+nrieZiuBSj+jTTPJkUK/YV/l7L5eHDXz5ZFixC40KhI4PTQSNlcfRwM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5043.namprd10.prod.outlook.com
 (2603:10b6:208:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 09:19:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 09:19:59 +0000
Date:   Mon, 19 Sep 2022 12:19:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thomas Zimmermann <tzimmermann@suse.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/gpu/drm/display/drm_hdcp_helper.c:254 drm_hdcp_request_srm()
 error: uninitialized symbol 'fw'.
Message-ID: <202209191450.Y4sMY2Om-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MR1P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aa0b90-9ee7-4301-cdde-08da9a201fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olC8xdKV85oTHv/rkdU4ujhGjBWBBl9P39806THMqc1nl1f6rexq7BnJpcxgJwWNQ+pfasJjk6vj9+PlLbUZ4zzRDM5Bk81VciDyZhUhHeJrEJVV6SKqXxRL6wwxEePrcGwEO5gPyoMNSVZIFpZB/OzVXgBNi6GzIlC0ij3jwW2Te8KYBv3RxHDB5bbRbbmsTs27+SDGWHM6f3r22oBh3/QbS8/3UgjehUOgj/t9c2r9mRaOgI6t5filCxZtNFOXv7xRkOS3vJMrnzIdmbHslsMhRuJW24InWJq4SozfNDk0xNDJVe2qcI5mQG+r3MDrvbnzsinfQN8PnqP+5O4kELldW0EKUQ/54us3+1Zvthqa9h1Wc70MYDTXb23ECZdurr+oQLUwi+ZZQBzhhuNoMxN5iOLgPkLEHMVvFiAPM2woZ6WCD7vTNspSBl6oNHSUXQN9uxNVucLDj3P+XxiyciQL8SUJuRACSwXiSdZ/tZIIlxGxrxmlSlbCvA4dKyAP5qoWdhIPyR10tfbAJKlTWnYE9WGl25BnIAHCDyglB52vzBu1a8XPqWbeomQeuhYJgkPdq3KreredZwLZoXf5rKN7URN3KdtJAvpMryg3rpTiiPBenJCwj4ktHN9rwgNSQrf/gUrDbu2XySaGWPrKkurKdvBNhUeJynbFFkitLTyJGzfrFEtEveB24yHq/AmJrXWUgMdz4MpLdRfHt7dtCDW6ITRztmostxZvcB1YBwRVutqr0hTzZvj8GnU+f+ElVExUZegYuDxL3inROifxaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39850400004)(346002)(136003)(451199015)(26005)(6512007)(9686003)(6506007)(44832011)(38100700002)(966005)(478600001)(6486002)(2906002)(5660300002)(66476007)(36756003)(86362001)(186003)(6666004)(41300700001)(83380400001)(1076003)(4326008)(66946007)(66556008)(6916009)(316002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BjMjUzNTIlbSOjIeKeFsMsD+YGM6PxKeFlMTNw0AItw3l23eGactfe2BeGjp?=
 =?us-ascii?Q?eM2H8npEyQY/Enxwppa/zJD2/1AvNb96JPKIGoWrwtoMq9k+FVxpclwVVD3J?=
 =?us-ascii?Q?RTmVtSLcem+kaFoTXH9YcsMT8u3sBiErimVA/IpL0m2uEJEveJafP/hMxT5t?=
 =?us-ascii?Q?XCONlcG8Qr36oK7O7gMlhMZXf13ZpwPzTtqkGxEumZ1LFnJCNnwfLLn7Cg6V?=
 =?us-ascii?Q?JO/Bmh4vudnKkfSQvMzM6ZslfbjuxRa4/GzyJzl+VPWPU36XJN7K54fbJGMo?=
 =?us-ascii?Q?V2i0xGunMC1h20ri3anrjLMjgkS0Fse2/fV1MxJxmPqtIPHVw+28GGZCwMjZ?=
 =?us-ascii?Q?+KdqahYq36u6ir0dOvAIMmvQU7LjADb4rdO0gw3LYMYMt26IUCxhHwjLU1Yv?=
 =?us-ascii?Q?joJx4rqDZ+nJ5sUiYfBHd9OnQzEHW/0YUmMi8d313a7yBYOfVqnhXgAoX1in?=
 =?us-ascii?Q?FLcKgUsR7fd/cJiZeqYCe7Ma0CpM7dAwifDwel0eaDaAYeRQHW6sVed2SA57?=
 =?us-ascii?Q?OKLfNGBxrFnu+h+SfzAMXjYD1ymqKMZABA6a/4jDXHhO6OzqsJCoNMT/SmBK?=
 =?us-ascii?Q?GFw7ltaFSmOs22Ro9zYPf41zmIT8Ht5iLAPAJrl2n4iHIkdoHOOldDWsZvL/?=
 =?us-ascii?Q?DdYV8mtAxc2qQlYZheU//9JSAndVt9eVw0sLND87PxryNfHBv6NIDoadHm8/?=
 =?us-ascii?Q?MAmCAGgiDL3D2o/I9gwjzvH9A1lga4Qja1RLG3fuv8o9o1gigO/qjfJ+VPau?=
 =?us-ascii?Q?/RdzIzhSVjYjBwabfkcRiJR2GD9wLNVwh6VJwzzFLnseh77x57bQEuONUcWl?=
 =?us-ascii?Q?IDDxUfaZXNfNltMf8oU7ulcfjpKFDBZ8Og/XTGgXuz6NQ6tQxJNtcFdExyJI?=
 =?us-ascii?Q?eSGgPdKsmOMkkfEvtZJX+M1a8CKpuKvd8cRY2HQ1WRacItZ2w9cAg/ccf1c/?=
 =?us-ascii?Q?sX5pmt+RQxnI3X9UVgqcpLl07+lUJcxxptlcDkEm/SYF5QyTeg40wGf3/kQK?=
 =?us-ascii?Q?/0BtxjtK36AOhLnk5r+bvslkUKS1FOoP3eIYtXUQKkwSTSBaZkgxg0r+64eR?=
 =?us-ascii?Q?BpYybbZtq9yTXkKwxSZ5oy+MdjSxIrUR1MVCCCkVqioLz7XgpgY33J9C8gir?=
 =?us-ascii?Q?/xv/ZIhM6HcUCDjCPXrmZGCqorudeKEKAyUsrKGpjEi2whh2PbvfpBD+e4Re?=
 =?us-ascii?Q?k/TTtACr7LoEIqBMuq2jO5zECQS7MnAsYSkzcdInnmAeI5+if82rFsj3FJ3j?=
 =?us-ascii?Q?/GwSlczNKIgGCWMC3q93jQScRtvuw+i70dDaDwtxUTm89XQ6bbLCBr607jBc?=
 =?us-ascii?Q?8Vu+OIHU1MP0P+P4RljLT1uOYmxYrvgnFhRSxe2XOKJgI/KCpO4N4j5X5y1u?=
 =?us-ascii?Q?Cd8ebZPZZYtc6iQWHKBQFsn36N/KPvD/cEHZGmLw0A9DzxAoEVqzuD2Eu15m?=
 =?us-ascii?Q?ediomt3AGdx4jcDhvtkNsUVbyO//BONTwiFhB5DFo3DvU0n+VM3yxRHEz6O/?=
 =?us-ascii?Q?8I9v/DveB+9zTJUdY2T6SMWfPuEEGeWMwwMmO5UhpazmXYP3qgPSuUf+Vn9w?=
 =?us-ascii?Q?N6PoZluBudOuSgjHMc0b8CdmdI4PGO4jP+kg7OGTNQ5BLMSm0mhy2CM3rfDR?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aa0b90-9ee7-4301-cdde-08da9a201fc3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 09:19:59.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx9dlt9Px5d+LvrucACSqS4RTXvjTspB/wgB1Nkl1DM/Rw22DK2biDpWy4Pp4T8n8gCFhMOlClvsFjGiRywRXdc/pTejIOiLFlRlqioST9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190062
X-Proofpoint-GUID: kxVzyMoEOqUgA9MBZqb-kpZT0lULQzNi
X-Proofpoint-ORIG-GUID: kxVzyMoEOqUgA9MBZqb-kpZT0lULQzNi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: 6a99099fe1d6c46cbcd74298eeb386c4b9048f77 drm/display: Move HDCP helpers into display-helper module
config: arc-randconfig-m041-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191450.Y4sMY2Om-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/display/drm_hdcp_helper.c:254 drm_hdcp_request_srm() error: uninitialized symbol 'fw'.

vim +/fw +254 drivers/gpu/drm/display/drm_hdcp_helper.c

79643fddd6eb2d drivers/gpu/drm/drm_hdcp.c Ramalingam C 2020-02-12  233  static int drm_hdcp_request_srm(struct drm_device *drm_dev,
79643fddd6eb2d drivers/gpu/drm/drm_hdcp.c Ramalingam C 2020-02-12  234  				u8 **revoked_ksv_list, u32 *revoked_ksv_cnt)
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  235  {
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  236  	char fw_name[36] = "display_hdcp_srm.bin";
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  237  	const struct firmware *fw;
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  238  	int ret;
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  239  
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  240  	ret = request_firmware_direct(&fw, (const char *)fw_name,
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  241  				      drm_dev->dev);
5fe89a6acd668c drivers/gpu/drm/drm_hdcp.c Sean Paul    2020-04-14  242  	if (ret < 0) {
5fe89a6acd668c drivers/gpu/drm/drm_hdcp.c Sean Paul    2020-04-14  243  		*revoked_ksv_cnt = 0;
5fe89a6acd668c drivers/gpu/drm/drm_hdcp.c Sean Paul    2020-04-14  244  		*revoked_ksv_list = NULL;
5fe89a6acd668c drivers/gpu/drm/drm_hdcp.c Sean Paul    2020-04-14  245  		ret = 0;
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  246  		goto exit;

"fw" isn't initialized so this will crash.  Just "return 0;"

5fe89a6acd668c drivers/gpu/drm/drm_hdcp.c Sean Paul    2020-04-14  247  	}
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  248  
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  249  	if (fw->size && fw->data)
79643fddd6eb2d drivers/gpu/drm/drm_hdcp.c Ramalingam C 2020-02-12  250  		ret = drm_hdcp_srm_update(fw->data, fw->size, revoked_ksv_list,
79643fddd6eb2d drivers/gpu/drm/drm_hdcp.c Ramalingam C 2020-02-12  251  					  revoked_ksv_cnt);
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  252  
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  253  exit:
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07 @254  	release_firmware(fw);
79643fddd6eb2d drivers/gpu/drm/drm_hdcp.c Ramalingam C 2020-02-12  255  	return ret;
6498bf5800a302 drivers/gpu/drm/drm_hdcp.c Ramalingam C 2019-05-07  256  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

