Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368837273FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjFHBKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFHBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:10:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57220269F;
        Wed,  7 Jun 2023 18:10:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357N4jxn007978;
        Thu, 8 Jun 2023 01:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=f9H5tbRJXjMs1laAjPTDtel4URXdJoz6jKQIf7hRDw4=;
 b=UqsRZAzo7tranlsG98Myq4iUjD1ca1jYCxVlW4xSzBBgKPg+eY7pEetBdNfL9NSpXB3a
 lxeFElvJmI+u5FaFRdULsuGt/OgKSrD+Cn2VY5fPTg/KMhxzY2KZ/1142D+aPFOu5I/Y
 6mJUwo0xgDYs2MC9SqHgBk2ipGY6WGd68UOd3qIw8zkJEysz6AdBBlbnAFzFXafvlgxf
 nZsD4uptNR3zHYOkqsVVwOMOwZcpTQuzwFKx3pF+z6Zk07ruDy/eyusNhtzt3fSuLUUP
 PL40fved+GeHsfyuzh/knhPWWCH4f9tLlRORXNLW+kMmyhlpobYrALCVDY66hoyaIwEw /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rk3xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:10:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35810Grl002941;
        Thu, 8 Jun 2023 01:10:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kytfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVxXqr2wcFT7jXh5KUwuA3ln7FIwQtG38iSiwoR5YgRjELVTI2Ppf2SqBU9Y8wt8JL7OGyKBqiid6fqJ8YSdq8N2Vjmhy7vj3SWzddBv0zEENA99p7wm9gKfxtI/FW0tynztKdupoYBW8l89bETKy7yZo/39O9aTdnaiVww69kpu0nvoJITP7Y432I8AMEJZB/RIBspXsDo+P8iCY1vGd8wTgXiMoYOko2i8m5EvrZm8vKBCN4YN6EbtjkGtrhBKl0kz1e3B56DWylO3igVV1NWW00Z/Ch+633B3QevyxDOKGUxB+evgtgPUuRpvxQDrGxxZpVQRnrsUAfxTAs0U3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9H5tbRJXjMs1laAjPTDtel4URXdJoz6jKQIf7hRDw4=;
 b=Q3lYmzCqw2E0OWTaKgh3kWWANxRtx+sMYShFo6rGGlalz8bH2yjYSgrnmUzXq4eRtqAqpP6SU+FMbM/aUUx5Y6uH2ae/xuNS4rxTZOEdffDvonMN9X/DCb0W0nbj3R7zZYd7i21pZsr7FRhWokrEfPBhg/QpN4qhpNu/PY3JFBHPap6IsEea5aUpRUQnxhSiB6XrE0oT4aUe3ZFCpccEfzV8YsAxxqi6/QQFqUBPkyVAJBSMRda9RLSB8vaaMtBLT1RMWFyHWADZjGVK0AU4TqDZAIOJt6I0BIXuKVWoZJLm/tx1MySKymKCCRz7eDC4xJfznWaA2GAXPsEdhi1lAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9H5tbRJXjMs1laAjPTDtel4URXdJoz6jKQIf7hRDw4=;
 b=bV4hNm3BQkD8Xy6Xahw3jzcknvp/SjHyshaOQSi9hyo9tHuEedpuIvFh6HQOvgkveh3VqtYb7c8U4QMLiWCdr9nmQceumHYQ445q3Y7WIcHLY/fV63L058A6ZFnoV4309ABpmrI69ASEDyxiNssIiKILg57EpiW+FSi087B0A44=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:10:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:10:19 +0000
To:     Zhang Hui <masonzhang.xiaomi@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhanghui <zhanghui31@xiaomi.com>, Bean Huo <beanhuo@micron.com>,
        peng.zhou@mediatek.com, yudongbin@xiaomi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8fy4v4u.fsf@ca-mkp.ca.oracle.com>
References: <20230601124613.1446-1-zhanghui31@xiaomi.com>
Date:   Wed, 07 Jun 2023 21:10:14 -0400
In-Reply-To: <20230601124613.1446-1-zhanghui31@xiaomi.com> (Zhang Hui's
        message of "Thu, 1 Jun 2023 20:46:14 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: e80a143f-0680-4b74-cbd4-08db67bd2080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiYtQux+6NWyHr+14nS+InrqtvBx8SqyUuEQYr618fNuKiWLSXArwmifdc7FClFVQAbLW8vfGVgp8FbzuqJoSfXqlWfYwWjpv+Vic1ToCtm49gZ5rLi5VvMRV5aEqWmdp5pk5XbChM0IdTjqx3WRzamJ+peOgXDWTHBwKvscDDoi2bLRi8DrSjxf3Bd1plUY8Omm/r7N6wjcUIxOWV8wLCePTYFhHl4OTXrZNB3QjpiLxhKWsETxOaUQFu14wFnjv3l+87JBw8+YEHtib4hDJGwWQISf3w2Wu73JG7v/gncaXBoCL7eJ/oBG7ymYEA1VQY4P0CZFj9kOyjioP8GrZHTDSQGHtiwIZcgATbVS+r/vBbZEaavqGygRVER/3grOd59nwsZh+yZsMQuj9g29/auaUM1PxgbhTBb4Z2N3ePfPog4LUZNgt0ar0aSwHog3/a12YzDI/nDrlxdKt90Omxjr1JVI8wdZtFAr+xLdfKz5Jjje3HoPb6rv9YcCcA/HHngiMZu7x/itKBdICDtYAsekksHAkucznalNQLRiWiZnMRMO5Ej4KGPYGOq9UtQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(66476007)(6916009)(54906003)(66556008)(66946007)(38100700002)(4326008)(6666004)(478600001)(36916002)(6486002)(2906002)(6506007)(26005)(6512007)(316002)(41300700001)(7416002)(558084003)(186003)(5660300002)(8676002)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRfEow8P+PdN7mBpmJg2JjmsyDg10cVKfTeOBomLo7CvrG317N1xkDZx/pT4?=
 =?us-ascii?Q?6/s5pwl5EAwcnTT3Q9UHUdRmo50pX7DZJrXwwSW38ydBBh1AK8EgOuUIQgLd?=
 =?us-ascii?Q?gisfdsOwMjNRAbOmlB8XS2Iw7AhrT492mAEiXxwOSlDwcCu8tg+lTWUeeSJX?=
 =?us-ascii?Q?/Knd4vEqfLyNLnwppQdINzUXxF+x/5ZDhkbV5akr/4irmfdpTpJOYNyTMjC/?=
 =?us-ascii?Q?jCY/oHC1h1mIxyWA4YtCREXe9C/ocizUZxOM4mCkpQszgY3UaIrKzjZhqFPB?=
 =?us-ascii?Q?MT6VdwBhUTG3sgTTmUfbg+k8sbBBwspw78hGbw5/h3Mf7PD6AScpdHpztaOt?=
 =?us-ascii?Q?/YsB5ARyyH0HJ9CnHxS3rX8iaj3aw3yiZbRd5nMQ986Lp7ne5ApbIFi2k/Ox?=
 =?us-ascii?Q?2uIp2XXpSxUPl0NCQi3WbfmTU3vn7n4gUtOvtLloQJUBajyKbb+NB3rr9qCX?=
 =?us-ascii?Q?sZlCO2Q8jnsOz3RVqA2QVqtiYBDquSztNwuXaaOQDnt8fGNySwKW0OnbBWxv?=
 =?us-ascii?Q?BFxk0MwrM/Q345lSbGGCLB3oDEXqxjYN6X0LzZi37t27HuYyt5xiwiMX3XAs?=
 =?us-ascii?Q?zNTeTFPVsjKIIedg4w9bJya+YtGY67PuXIryvmNA2874TtLZp+hIztGnV44H?=
 =?us-ascii?Q?ZRYnlbZKHkas5qlejBx7ZhDCgKcd3J0VpzClf8jW7rKF1WAQos06XgvsmXD8?=
 =?us-ascii?Q?qr7Ea9RbL/odDa8axr5FWUA8U3F6NZeO4/BxuQdrbk2DWvpoKAzZlh2D9N1t?=
 =?us-ascii?Q?FHZ9f0GWQcEAy51r2DL4IfKsG+qwg9fwusCjCN8jHQU6Eh0EXuRO1Cevcben?=
 =?us-ascii?Q?Qhm+yS4ajNy7/Y98vK4YEH1lM24JgQ1G15pPWwTgwjNo3x/pmG1iJovvTss0?=
 =?us-ascii?Q?FoRwPEfIkvhBH3QAOiZ0IlnMnlGx/PXp/tsQymbunyZeePJsofbn1Lg42oy/?=
 =?us-ascii?Q?pPlQIV9/OzVFtWRndwGnB48ssGPGaWySDKIW91yn5rWsJZr4vDyicQV/KL9r?=
 =?us-ascii?Q?Xedm9BoOvl05vPLyoTIBeK5UZhTM2KokRus8ZXJXA95xgGXWthnUS2pD2yO4?=
 =?us-ascii?Q?Ajc9/53KgNB6dkaLSLgnTQcPD+L5Cz1xkf/tROyOAVFhttd3FwbRPHALePSJ?=
 =?us-ascii?Q?7/5jfA+Ky6rT1ASTmlBXbVXdRp88eDWnHp9IJStBsQhqD+mnJHG1rSLfyVum?=
 =?us-ascii?Q?JnpP1PUt1UF/1jjtT6QqkP1R0abxCKWaWeDpMAZuh+VznJdH4Ozbe8lDctOR?=
 =?us-ascii?Q?qngRAg95sCrmBfoBr9xdrF04e3RVBe/em1MhzfU8prM/QsPteLuJRvf3XEeQ?=
 =?us-ascii?Q?EbaqN/tz/iBPLd2u8cYay/NLgGrVlxxkWT2Gqq+asbVD7bl4Rjb9tIHtys75?=
 =?us-ascii?Q?OVBokmiY1BN0AtlEzHjHBJ/OTn+f0iZhsurCZQkyCT62wIGKxwBT4YUX4scu?=
 =?us-ascii?Q?Hj2y0VQqSnms/zM+8kbCOP8NJMFjGx8Grd1LkJjIwrej7zG8zsgCkVu05YpN?=
 =?us-ascii?Q?WItvLfNutdY7nJL4WrwaAvSTaXr2U710E5494K8r9bK6OlzVnboDlsGI2LDC?=
 =?us-ascii?Q?ne/YlU8u32TkxeWYJbbM+svFydAtKjgUmkNZslMlIs6Pm/054KLuXw0AekrY?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Psv/NwDk59/MAxtC53+rhHRLEnAR25prPN3Xufne/eLKV7ZyXcDd1bcNqAyC?=
 =?us-ascii?Q?2Ko7vo209bjazQW69Ir48LEFd5gbvTatnlCaR4Z5E2/mMuAkjhxQ3ldFDhIq?=
 =?us-ascii?Q?1h3EuZ2MSNvdz3q2C5/NsUQr76ol0u0goXd0JZW4wKj+fXyhRh5ixAOKijjF?=
 =?us-ascii?Q?IiUuACvrnXuH6npBygVnJG0+kaH56CBQw/6RlNXS3i1095W+aOlCnOy5Lz+5?=
 =?us-ascii?Q?v28vUMXGrLjnSFUzdASQXgT0A1iDQIJI7RffZr4DppCNMZZyhXehZk1SBvz7?=
 =?us-ascii?Q?nKvKJFNZdMdu4TXOlk3sNVoiwO9cgZV2ddNzwoBg0DJuzE/bXyFbLbK4im7p?=
 =?us-ascii?Q?QCaTSCCfYsVQvbCW5IH0RcA+49WpL2VVX0O0oh1XQRPh7nz7gpIF5zRbWWrK?=
 =?us-ascii?Q?Xyr/Acq7bkupYscTU2GQQQ5Ek6CcuiPczIri5zO3iRoNUbM/6T2TbiHdCfw6?=
 =?us-ascii?Q?XEVzXvVuoAlVJYxghYzthvcb5oBDKK2kqSW3TRsuk5PwAv6Xp67S/eoH6BPU?=
 =?us-ascii?Q?51CjxLFaQADRdu6ZMJrzzW8yep2auIqPQlLc8hdUPDRZ0oiXkp8QFW0l2jDY?=
 =?us-ascii?Q?2Mrh6rwZQmMl9ZZq1Uw9K1RE/XcCIS4jbwWQTjPUrTVv9RIMUEFi2JUkkA/p?=
 =?us-ascii?Q?fN6n/BkPjYgcViw5MjsgRpKahheDXmTOgc7BDCX7OBPHmTbiN1vrNusuTiZ9?=
 =?us-ascii?Q?LWOl7I1pDopm3ugpTIV0DzQEZE/a2bhrRk+8zxvGfhRo9LpSK9hFuAVfQKvk?=
 =?us-ascii?Q?5ZJRHE/mrUT58mmEvh7d39EpE4IDmD6ZjDu+jWHpHvUd8XP8xucLPaIyPG1Z?=
 =?us-ascii?Q?KsHJppKDZG/Rtw5NcJ5vgWqj8yD9eesaAjGhXk50+vnzoYAuBcFLVWMIDEqI?=
 =?us-ascii?Q?KpC6RHcwwT4sWIkbXNrbpgaN4JgLndw/FLIwN0nO9cw6X14HA8Hdkb0VT4wA?=
 =?us-ascii?Q?qiLJqj1x4re2HudKEV0DY5iKBV8banV2EfLMUqpY0AJIsSPSQL2b/r+/Ad1s?=
 =?us-ascii?Q?4Xy1ZbKzGA9W2HJYAMZ5blWUnAYQSW95O2ZbDTyki+jaAWCo1vgfBFdJKobo?=
 =?us-ascii?Q?ecikx2LmCnrIZNyc7Ulfb8+VfCxMIg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80a143f-0680-4b74-cbd4-08db67bd2080
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:10:19.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuHp8Umb3H/635wLpzAYUj7N8y6cce6R4s8/Zin2az+7EkIKCN7eeVPhfxqAnXFpCfV3vE09IKW9apn3WOXem2eCB2bUmK3YxWjmu6T4/Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=951 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080006
X-Proofpoint-ORIG-GUID: tIiM4RrCLbbPEYRl65nmEprBpNq_Wb4d
X-Proofpoint-GUID: tIiM4RrCLbbPEYRl65nmEprBpNq_Wb4d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zhang,

> When qdepth is not power of 2, not every bit of the mask is 1, so
> sq_tail_slot some bits will be cleared unexpected.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
