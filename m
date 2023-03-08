Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDA6B0808
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjCHNKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCHNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:10:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E3DBA847;
        Wed,  8 Mar 2023 05:08:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288E0ed001221;
        Wed, 8 Mar 2023 13:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=bJ2IzizoefEOYEIGo+C7rkjiF0lY/XrPO6gi4Kg7K0U=;
 b=Wmjh15sE4uRlEiXC9ZUKo+rkn8rnfBlObgr64UekV/xgoGPmGmzFuYASyS5Mh0o5LB1v
 gqPpAoDEfWDspruF6IXP+O3YwhEsBotXHH66o7EBE6ceBMDFI2NkYPKQjrol7Fp1etL/
 3QKWe8Sznmv+UfAsfEXMbgdXQ1BltdjSQ9zlPTOXjvLpK6bQYbLx2UwttwgBI2vKPx2f
 KBupCZKpo4smU0NZLL04dPptJLARmBzrak0KU0sCuOaC9Cn7uHFfTSL7RLvIx861HCBT
 fjw/tp3NgUJCEWcusN96ZJzhRRJl05hk8DxFGuVKpKiHNPu0dVdBVHLpnfO8XaU1ztxt Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180yxyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 13:08:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328AslBT021708;
        Wed, 8 Mar 2023 13:08:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fr8q853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 13:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb1bIFAmGPtVJYEYoSiz6pHE45k1Do5KklNjXXIsk/JylxzH00QogjUucp5zlSvDsEeLL8W0yK+xrsmcR6ySH+qeq6tYQc+M98JAhtzn3dtkGoRQ4W57oQZO8xe+fRHdE3OjlxHDWq04K6B8qpFR1+GkpQftrVaalqPH4LT783MWaKmVvzkS7ow+B56j3p63U5/udgvRUjd3GNYo5pJptoLOHMmxhR649xr19NyboVvbyJwlt7x24KL2sFyZfvkVwRt4Vu9MAvsE2hSSqE4QpOJ/2RUiMiYVoxOWN4Tc0PVy8tS27Yv+4TxY5JlEfG8i2QLy9cxmLqp2E10cjYNkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ2IzizoefEOYEIGo+C7rkjiF0lY/XrPO6gi4Kg7K0U=;
 b=AET6lbiW1DrS77QZaaDLoo7yF1TEb/EUlNR/b7RzKw0eAtPpW8wZBBR74KsMM42t9JF7l2GcfkaSVnScMX66s9m3b+ysIN1i0i88oH+MQHCZjy2dW0aHHDlPc+1HFbbA3GVTj421IVThHkXSNmQF67Ztji3wocoGAeAs2TLurcw7XvN4Jz7R6zaEEqcaicEwvdQs0J34I3QOgZspz5rNFWQ6QHTtBTTs3jzawIefibiG28wfhhmheZHQ+1wc1lgb1jer6FVIbYigpgY2i496OmBi/sFssMTxsGJUE97cxMBDrs5lH12lcvCb26Fsh6/TqewT7ZKP7wRSJrVQAO/b7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ2IzizoefEOYEIGo+C7rkjiF0lY/XrPO6gi4Kg7K0U=;
 b=bOiIjfLvpvQjxuR2Z0Th9dNAQHX2mlLCLxSIi7b8bxTqE9HtsLG9wOBJvvggZbc7qFyh8FDPaA4G3hUEWi2wPHdt+sjfMh+daiK8Y6N38uehgkdfEbWDmOJ8Pshk7Ga5rECUcIGYL3X/QX9OhjcisaeTwlgYZjE08hjNXnZAfWA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB5661.namprd10.prod.outlook.com (2603:10b6:a03:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 13:07:58 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 13:07:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Lee Jones <lee@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
References: <20230224150811.80316-1-nick.alcock@oracle.com>
        <20230224150811.80316-27-nick.alcock@oracle.com>
        <20230303105203.GA2420672@google.com> <87mt4n5spv.fsf@esperi.org.uk>
        <20230308130420.GH9667@google.com>
Emacs:  it's all fun and games, until somebody tries to edit a file.
Date:   Wed, 08 Mar 2023 13:07:54 +0000
In-Reply-To: <20230308130420.GH9667@google.com> (Lee Jones's message of "Wed,
        8 Mar 2023 13:04:20 +0000")
Message-ID: <87bkl35r2t.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b78b239-9a0a-4457-55d9-08db1fd62369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: on6oG07IzYGX/SYql+RSoMZarV34r9I6dlR3xDkzXTZHlJrlfTGJQD7oTCfR6CxPELqEkcCVvzRcjs/yy6w+x56c6CfXmfCcsUNjXvosnZbvX0gHAYLaScse7V+zoqRcZilXfKA2gb0GnUTsbmfjsdp/lfMEMqH3QORPuu63Neg2wK5xEZVb2KXvD47zvYnOFim0c1mb5I1IP3TkuCdC7ypznFeVjEi93ViziJTZwXBeZ5Ih+7IAZGQ4v8h8hKbQvzoZMflla/3C99jNiqML40kPHWKdmDsjjD98eo83+qqnHj6DlHIppYjo7G8/1XIGU/ApZPS0fZ+VHF4v7CYuTySY3wPyUuhTWYtAes/THne1JHJ3KQxh7JS5zi2mO3UOJG3P4QI53gGzoIEIAp42UiTNjsf/qivkbBa3k6HV/rlVYk/stxJE4sCl8Z5cMjZVLlKGwYveou2JHCXtH6gbPS046nN1vaDyTCipQVQl0TTqK35blvLGoTvOyNhrLZQAcvR4tjmYppv3ExML27/0qi1ogrolm0XinNmU36SODvMOdiVo6HfokGFiWMNU12DOxsQSX7eE3C+IR8mVbDcBBySwuz2lGbk6Db5zcquMBw73126GlwornclvMpUZspXiWg4VcuSialJlZPiGjsgMRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(83380400001)(36756003)(86362001)(38100700002)(316002)(2906002)(54906003)(41300700001)(8936002)(6486002)(5660300002)(66946007)(44832011)(66556008)(4326008)(66476007)(6916009)(8676002)(6506007)(6512007)(186003)(478600001)(6666004)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osQQalJp71NcTzOUYBL8/fwoWUMYlZDgmBGHvKCiEHc8S9TUUB0TzfEkElqA?=
 =?us-ascii?Q?pqtoI/iDXA0fK/5VwMgwo9bordC5c4LSRnVoyfXhjeRnvyJK38gAo6aDqBbn?=
 =?us-ascii?Q?3QcpIs2rvfhVq75H+6EnKDDAyNGZCwNzUgt34L2kyGEBW9ot1TMr4jWSBqVf?=
 =?us-ascii?Q?sZ+WVn1/dGJjststGU7VF0vHXyeqc0ozjF0VhWFANzD5472UXBiJErotLxcR?=
 =?us-ascii?Q?VyUo8GehFVet6BuFWVcQqYSluEo+LHofFMrODGn75YZwZwQoeuXhTTZ71vKL?=
 =?us-ascii?Q?w/fxqvAf+dhU1uIHOJ8kzL/i59MXNJJLnSc5HOhFKe9SFxMUY5R1+VYCJ183?=
 =?us-ascii?Q?oAE1HNIBguO9/m3dUqdTeEvp8l0bPfuDWyVMV3BT2toh4WsSRfuCCYIGuU8m?=
 =?us-ascii?Q?FJ0SOvV8oGwzmP5VJCgiRHPkAlv5Xe1gea128RKayp6Oy8779cVEPi097JFk?=
 =?us-ascii?Q?B7mKTDrqy1hVw5BdIOcOC/IgUl/lW9LW98dOFO0P3KuswnyNvzAZCHSdd4Yj?=
 =?us-ascii?Q?lVkv6cknnI+SRmVRyA8W8NrjTZYdz6r/IJr/pPSKvc2PXEWP4J/cPqMtcMFE?=
 =?us-ascii?Q?I0sR+Z3tI/ylkZpTf+HS0eut72+Ve+0dEAb1Iq46CRD684oYsolOa3iYbjgO?=
 =?us-ascii?Q?v9AXGXNSWicnj2gHxwZoqAOLFvS33HrzwkrB+dzJsPuIAayDqh9b9oKHqLF2?=
 =?us-ascii?Q?MQCWHWswcX5VFWF83w1Gx/m3Z24R1K5bCfi1MjgERN6eRIA6scPnbGXa2dYU?=
 =?us-ascii?Q?UAQ2CXKBiEye+22GxVFxJfoeHe0nybp8ipc54xgUT9S8dmcoTe3uFftf/Rz3?=
 =?us-ascii?Q?VCbud3ck4wZEPI7XAirA6nyFcJ7uG191cT8SSV7gSTY3jicUBpNk7UxdCEnw?=
 =?us-ascii?Q?vXx0WEXOLD1mAz/aT1KhQc8l6AC9laEZfTmhgiO7cJAzjJag8uu2Skm9iB0n?=
 =?us-ascii?Q?q1G3REaToMeW9/3A2drXJmFG7JQSTzHRd+TTOLvA+j8yHX3TJdrp0g3dvr76?=
 =?us-ascii?Q?4W+JmU0KHS7T8p+mb9p+1JGDZYNs/bNDvksX2lBmJu21LmxsuB3wJamvnLdo?=
 =?us-ascii?Q?6gFBTNpylxaMWxO20RgAGNETC8Jhi5TswcsGIHZDo2FJbDwZQTZnbbnRheRq?=
 =?us-ascii?Q?TUtbXmtpEGhUv5zJVmG6ha3z492YJDZf1cM4Y6cLsfjxa/DfgMl+0PpDwMgB?=
 =?us-ascii?Q?Ovt1HQ6R0Ec+wa8p4eeKALQK26IOHugoBJQn+4CjOB9RxCuKuCs8QO2c+Pfd?=
 =?us-ascii?Q?e9nK7WHdxxmq251iJwipinuy2fIvraHzgJiqL0SgGqlicdmJxhQKdpXWlmH7?=
 =?us-ascii?Q?8NHDMI9xX94S5iUjVzIzc6rS+ogBWyeisgVf6q9lPh15RpYsmTHINGihgycE?=
 =?us-ascii?Q?ZoYa5p7jDSy6vjlfOWE5ESAo5BBsndsWUYQRXqP5lgJNpEjzZppz6om1o416?=
 =?us-ascii?Q?ge1irlUsG7JEEMZEhB5aCVH3zWpVbqyj5GtihL7IXasBl0cNFjImTEH7TqUl?=
 =?us-ascii?Q?W5clyLRxibIigT5jYvt8HVozNWNI1yOVYJx7vT3nz7Qx4gez3z+x11A1fs0E?=
 =?us-ascii?Q?16MFpATDVn5ZFMOgozh1K0jyRjLI5Rndea5rN1BLRd1n3tQnlQfy6PlOlENe?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SAjVpQkZUqO5hjhQ9tkudsMz0lgA2xa/xPgeBjZqmSfyj/WVvSPI+ECjeCRHV+P3Ig7AkousvZrINzJyVs+KHPg65bylXtz3Tlf5QU0fa1Ygd1gCdKkBq2tua5R7S/xZG3i6VgDDUxYUss01E/G8yfl5ldYHIAp7Fj7uQtg/kK38DrtHVEvrYmVszErfjp4dAQxClBzRl354p5i/GMbZWss8lS8/KnH/VLz7WVuYNd3aeFHUPdoR48LEQacUBQNj99KVvQugHOsEZnOJEgErLSVr80L2Qq8XPvgW6jkru+I1nFVwziqnO3ufQqnZsnVS/c/eHjvDNXSbgYZBI3w+0x2d8zcONyLj+YyPyasx2ToG7lBEKCqsYX+BVGZM65BEibTw+g47ur6vElZcQMkZgYNPJjPuhBTkuMFR043qu+vaN53UOeMzP29YKa/0pfRW/CrskkdbKf6SFFumtcvMpbDnlPjk1O6isIdgfBSm42X+Np7hMzvYULUZdBBHBS8iAjLikZNjkDPdbmzTemjRk3rwO3V6x7SGTnIRCIU3WocoYklQk84J3W/fjBwU8Zu2fVIx9Fglp0PRzv+WD9K6lSU1zl9D+i6P30ckiAs8k6yXHW40XjZ213hl8EnvCkrkOwykq6wyVjZrtLMOCnxt6MAN9gzY7gdTDXmLmJkBvaFZfg8kmsX3bZbWMPMb3jSk/1ybAG7VbCYqnTV/g8oHhVDIgsNVpnDf8B0jIepsF/+bYEuZvlqJ5t9p0dBQDoQ+i7JqTZlLY+im0BNycwaQWvfZX4OtBYQ7cI6BexAbuGdN5WwL+ZMB3PoaAx9hg9sD6f1EofJHmbsVub6a4oADeAhtXY9XosCi8N/Ofyphr7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b78b239-9a0a-4457-55d9-08db1fd62369
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 13:07:58.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLGl5E+PbWAvGIIRHE0+diftVwV0fD4lwF7PBN1SA9+m5gn8mF9aB1k2NAvfYJFGPhxZtFOddNQhJimF1xex6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=788 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080111
X-Proofpoint-ORIG-GUID: K-Yo5Na3uvC5rs2q7OxAqiySiiVFnx5y
X-Proofpoint-GUID: K-Yo5Na3uvC5rs2q7OxAqiySiiVFnx5y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Mar 2023, Lee Jones uttered the following:

> On Wed, 08 Mar 2023, Nick Alcock wrote:
>
>> >>  drivers/mfd/omap-usb-host.c | 1 -
>> >>  drivers/mfd/omap-usb-tll.c  | 1 -
>> >>  drivers/mfd/twl4030-audio.c | 1 -
>> >>  drivers/mfd/twl6040.c       | 1 -
>> >>  4 files changed, 4 deletions(-)
[...]
>> For now, I'll split this one into four and mail it out again: coming
>> shortly.
>
> If you haven't sent it out already, 2 will be fine.
>
> mfd: omap: ...
> mfd: twl: ...

I'm trying to automate this whole thing (since I've had to resplit it a
dozen times already), and even making mfd a special case that wants
splitting finer than by subsystem, I honestly have no idea how to
automatically determine a split like *that*. I can't split on file, on
subsystem, on dashes in the names... I think I'd have to literally parse
the makefile to figure out which things belonged together in commits,
and that's getting ridiculous even for me.

So, if you don't mind, I'd rather do it by subsystem or by file :)

-- 
NULL && (void)
