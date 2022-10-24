Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E27609F59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJXKw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:52:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0DB59E9B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:52:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OAO4Lo025846;
        Mon, 24 Oct 2022 10:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HSGaiIa2ORJ+xymqPUNjuBXNzQNO8EIc/T/J8L5HQ8g=;
 b=VFC/WyDq0BO8Z0j6DQMtXBrMqIWZ8p9CSpWhdhQc4k44BoDZxr9HTR6XrPLkvY7U6b2b
 kphF0gXtPCu+VykbwxRZAYLxosb4Hdob8IT8JAuN1zRu8Pa3NhtX9RqiYd2sNrrnhrNc
 j+BMGRgmGtxP696LWFZbcjMS+Wulr6Zd2I4N9Nd/y4/R0N2nWQQSQzSmFsAGJAfbt8zC
 RkuIBBw5XOBTzNMboWa7NfWqR8n8OZXhXRTAISOWa97XowoxnsyrJNcMJulPTPu1a1z7
 zD/73LHsjeu++bUwye1praHxhsUK47GhyPbxqf2fP5vk9lH1li7WItqEuIIKS1QLbW2P PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84sua8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 10:51:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29O9DdmD004199;
        Mon, 24 Oct 2022 10:51:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9hnec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 10:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLopDZZeW4jsqTosxogXn191YE89E1ZqlQxdpyg6aS4Y+OvxPuGD06/cz8jD36nPyl0NevOHQMDvklMTDo4ltEpHZQUBWnz/NbpbGuFceD0gZc+NVMw283BkGLCVAziO1SAOkJrRoVSOUy9mmRqjZWKcqLIPkUpo3TkleHXKLw8+CkVNWmT+Rdip/XujJEsMAGfhOVMryLN+naIvcMqFb9yaRX6IZGUtnv7ktZh9O4i9hKN6DnUT1wPb+AFHlCCZaDrwwDXeBCvLQjmapY0SC6NLLJWdhqoHsVYJXxK5J02Ts69NZlloTFZcO/jq5QT0Dsksk8ijgRV3EyCBz+Yx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSGaiIa2ORJ+xymqPUNjuBXNzQNO8EIc/T/J8L5HQ8g=;
 b=F6PCX1Je74P78AbiIZV+jHgBGePA3srpZziYYZoQdxhtOLhVxZsowq6N112p+LwAjLUqdH35uaD2RK9R5330hXbV73wLGlArcYff5gycL53pZnWdPj+gM9C3aT9pB/KM5nn2EouYsBu2c2YlcIWrQkgpPmXTUnGyRT/rKr2kloWafyDXj8i7sQ5Uy+J/tTdBI2EloQmTRbPIpaiVth5Ip/1CClw9Nd3eXPgMQTJ4XKHaBYI7GBc1MLPy0tEb+k7MLh0/3judkuEy59BOWUzhepnNrBzW9Ksrz/abro9CxivdDRlLBJrS+HoVvT/andgfg0LJNLsqFV+UUm+c5CuTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSGaiIa2ORJ+xymqPUNjuBXNzQNO8EIc/T/J8L5HQ8g=;
 b=tSaPvsvZdBBtjKD3858QsV21oCgfHumYsWwj2EepXWYIafGkI7fQNpQxIOnOGq7jRxoJ4Tzeb1WgpP10b2xCvC9gyMT7b70IFTsKXN67ZDqLoxFPLzxuPBR7Z08PlFXPhFRPjD2zH8V9ky5JQuolE/wFmiXAp6YUgo8vEl1j1OQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN0PR10MB6005.namprd10.prod.outlook.com
 (2603:10b6:208:3cb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 10:51:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 24 Oct 2022
 10:51:50 +0000
Date:   Mon, 24 Oct 2022 13:51:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
Message-ID: <Y1ZuOg2b06u3TJtV@kadam>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
 <Y1U0pINWo5yjUdc2@kroah.com>
 <Y1WZSysScBH0/6kd@smile.fi.intel.com>
 <Y1WbY903LjRATVwh@smile.fi.intel.com>
 <a762dca8-2458-c40b-7a35-80971c46ac84@intel.com>
 <Y1ZTXa0VZrl9jvUU@smile.fi.intel.com>
 <86cafe81-004b-8a0f-b50b-2bad38f84635@intel.com>
 <Y1ZZuY/cS/zePKTe@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ZZuY/cS/zePKTe@smile.fi.intel.com>
X-ClientProxiedBy: JNXP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: be6c46d2-f1fa-4dbb-82d1-08dab5adc0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYXS41rO3a4TulOta7p4ojm84uVQzXArMo4lW/ghs2PsjAXHB1HPTVnUYfh9k9vSFb6YSPI23F2lcDttkS+o6eimZpeix6dTtVz3qmfwMxMvTwihu4gZ5lWAdBVHYgoXJVifjMRSro80RNtSmhNbjh+PrE86OZucUHnOgjrDg22Jq/jFDVE3OHkzA3AODHqAKFQKqGqHs6Vx2rRysmYdOhSkPnKd5/UfnrF92QCoostZrmBvwd3jn2Ef5TT3feKpjDxM+gSCDnKNC6vA0dyJd4t+WvLKtYJtr/oIcH290694Pa7LIbATN48JetHS+J9445uB0JX6cnk1LolcjWs68R5uAiXnoZj5ZKFi/499sTN7fNoMN20vcZxpbx31k8r2XFRTIzy0ZqYgfsByYpgp5B3MR3M25hxNd5Mf5zmavSIIDC4Igu7XCjo4Kfc79MfE6T44GIGFVifzTNdAFcKCAiFvxJvqldF2jdwHNVFtTe807YRViiCm+NvjMzQ7t6UEB3Zc9qfvBuKHYzZg/bBz63S8FQwZyGZR0uWsEppuFbaf1HzgN3jfpnNHliEn/fMU2KZDtVbnZNOMv5Uiu0PyS0PhpS2G6FlWISK4Yvd4Q9SO/GTEpu4t+nFy7c5v8aPSFuqGs/W6xFG5oRyVJ46iRACPUe5NQFyhfYU7XUrFlXPcu50PJMQjnYH1XVkvOvnXVLqpvsRcGr8xd5xBHD19iiWsbjh2D03lQBvikYXqiCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(41300700001)(38100700002)(33716001)(966005)(6486002)(478600001)(66556008)(8936002)(86362001)(83380400001)(26005)(53546011)(186003)(6666004)(2906002)(6506007)(4326008)(8676002)(66476007)(5660300002)(316002)(9686003)(66946007)(6512007)(44832011)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O66TB4MAU/5zXOLTb5DHHv7UOHxOE8xb++Lo37EyFg/gwXrRL32Y6/hyDZae?=
 =?us-ascii?Q?T+ZQXobGlqDeRGO+APeHgGX/YHu3GrT7AoRmuvJgmQhD1HzoJHuh29TXLd2C?=
 =?us-ascii?Q?gTgGstq5EYkGB7t/LFNuAD4Oia37MHXwmpTIuJnNzAoriTyCPc3kxppUAHoN?=
 =?us-ascii?Q?EPsN0hKN9twbHzJDhM1veQADkzNW8KisYkRcixUjkftT4NUlKc3j867spHgx?=
 =?us-ascii?Q?Ve7HBDe1Y+yvsKkN0JkxuPa0s46GX4PlughRrtSxLlCgHpu1PodcRaKVy1Zz?=
 =?us-ascii?Q?ZXUIuawjXukBJZ3idImkKuHXFEYsjT+eXuBGruf/nXhVBYahtlh8SzosS/RU?=
 =?us-ascii?Q?TJM/FGmK54drocLdc2JopupOFghbCbkoH4n1ijSWR+CicKJMo7arijmEQiFN?=
 =?us-ascii?Q?jpKFHkbuKxqQk2EQFQnk7mq1eJHxFF3e3qo6cXFX/3k91b+cQ5ZTIP5kEIYX?=
 =?us-ascii?Q?r9utW0v910KanfTPy2vyuHi12uclPi5e4Bqza+fD11REQV5SHSDZFJ0WZLkB?=
 =?us-ascii?Q?jK3Ztu8nafU3QxgVL7b9rnKwTUbuiTQSJBfwTOimm0qtIpGbKr2S6p0lH9do?=
 =?us-ascii?Q?PyZxATMsovSgcqdH/2siiJqIRpZvyrPLEZEQpgY4Vd/YkEDyqn7GAHX3MO3e?=
 =?us-ascii?Q?yMNKo/JtwJJnN1NxroE5ydwXzHtFvQmqs6rEbE+nb/tQPwr7jC8eemTCH+eh?=
 =?us-ascii?Q?nd4pieKU4DwozO9r3Zqk8f1gkV/5fafGW+8cwMmLj9Qd05r15UNvTHsioOTQ?=
 =?us-ascii?Q?JabsG4uWrVfyYBSPl41gINxn1oM2wDqoqBGXM5wqSnv0nS47ekTAod0oZt59?=
 =?us-ascii?Q?Ck3uGS/H8xNlT2nnSSXYP7es9tF4xWMjRv2c/oTd7rpJ8PlLmV9mFW8OvDDS?=
 =?us-ascii?Q?xkUUombz7DzNwFtD6F+zZcAsp7Kvkvi+Vk3Qn56pZ1G4JstzzHhaND/pOGLN?=
 =?us-ascii?Q?mza0XiLg9994qpktIsWujGmGRBwkUMR62kBaX4GE/6MkSVuWjECL0Wb0kXnZ?=
 =?us-ascii?Q?xu78JZLZehzGLcNyd5SOPPrhvvvgXqV56ydP5xBT9ezYnSvDUXmNhOd+n58g?=
 =?us-ascii?Q?bPRkTHQQSp3LQmC/PSo8yUa4n8NcscXs3vcIoDEm07ECMMc535b5i7tZBpWi?=
 =?us-ascii?Q?xIoGbfHSsDbcKckwBAg/nwQRKV3dzY7zhR9MatlfHSkGVp1U8Qg3GCg+nafw?=
 =?us-ascii?Q?MxDCA5LmF/zwNfl/HtMtKQ8S3C+slM41z8F7fnR7Cmu4mm0Vb6yxsMfgu5xo?=
 =?us-ascii?Q?IhSE7Xj+T6LllY2DFPsFYk+jzog3npPAWDcnLvmR/rLLK50UOUN0zAn+BDYT?=
 =?us-ascii?Q?8hWYjS3swSfM146bkhukqLhtoZFsQ7oYW4BzkBNMqb8lHhKAUY269v133qsL?=
 =?us-ascii?Q?VZ3TzyUmjCD0qEaeIx/eoSCcUER8nSFSIrELL/hwSu+1N1TEtUnI2jaDSVJF?=
 =?us-ascii?Q?YdWfEzsX69P8wx8khk9J1diuod2MucrohqeCtCNFDfzY0RfxbtAJXvu0xFQz?=
 =?us-ascii?Q?L1bUooj2xKp544jJuyZpgvhNRK0f1D+2ABhZeNkacb6R7/ueFbuKsUEXnWnV?=
 =?us-ascii?Q?uTJmrCskuxXS3hZXQAzMGXulCmEupSuDcWdccyes2E6stYipD0wYwCGwlRh6?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6c46d2-f1fa-4dbb-82d1-08dab5adc0c9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 10:51:50.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+5pQFBSI8UtZpCO/Gu6QqXsWIzyL0d6BUGckbZ5Yy4xWfOjQbqJHfeP8BRAF0sP4xBu3rFRsoOigS73axWpgmjXj2fsQvjuVYGDrNmpgCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_03,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240067
X-Proofpoint-ORIG-GUID: XdaIyU5qOcBx3-lpUPBkenUpjsgthhL3
X-Proofpoint-GUID: XdaIyU5qOcBx3-lpUPBkenUpjsgthhL3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:24:09PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 24, 2022 at 05:08:37PM +0800, Chen, Rong A wrote:
> > On 10/24/2022 4:57 PM, Andy Shevchenko wrote:
> > > On Mon, Oct 24, 2022 at 09:10:53AM +0800, Chen, Rong A wrote:
> > > > On 10/24/2022 3:52 AM, Andy Shevchenko wrote:
> > > > > On Sun, Oct 23, 2022 at 10:43:07PM +0300, Andy Shevchenko wrote:
> > > > > > On Sun, Oct 23, 2022 at 02:33:40PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
> > > > > > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > > > > > > > branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
> > > > > > > > 
> > > > > > > > Unverified Warning (likely false positive, please contact us if interested):
> > > > > > > > 
> > > > > > > > drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4
> > > > > > > 
> > > > > > > Andy, this is due to your changes, here's the offending code:
> > > > > > > 
> > > > > > > 	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));
> > > > > > > 

[ snip ]

> > 
> > Hi Andy,
> > 
> > It's a smatch warning, it may be a false positive since Dan didn't forward
> > the report. +Dan
> > 
> > smatch warnings:
> > drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine
> > type of argument 4
> 
> Ah, okay, pretty much looks like false positive due to smatch unable to handle
> _Generic().
> 

Yes.  Thanks.  I'm testing out a fix now.

It will take some days or a week before I push the fix probably because
I have a bunch of other changes I'm doing as well.

regards,
dan carpenter

