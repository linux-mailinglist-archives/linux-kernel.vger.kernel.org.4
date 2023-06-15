Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A827730CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjFOBqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbjFOBqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:46:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED46A26AE;
        Wed, 14 Jun 2023 18:46:19 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK0Aei018100;
        Thu, 15 Jun 2023 01:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=yvBIOxByfIKgD8cSlrcULAP3SoACy12rD/ybGqKMB3w=;
 b=PVmr7wPd+RniVInE5yM6y4S8hExlkQbd4YVr+2d38OO0I1puAZtFA1ZCTflrL3kH364h
 hUUxWUEljTGsU1BNvYly4Y8LEkWR3hLANGa3vNrQpiwXLO6/e1EVzxxjITS1jpmi8zR7
 HiViACV5i83m1ZCqSqwfDK3xztc36/tn1sdkTbqhS2KBpog21gcIp+w5KhqhkB6/MWPH
 jZTB8loeeRawwM9VKxjx16IbFYkF70UjwhV7JV2cEyM5vJD6ahVntFX5u/6aS9O/JzlZ
 ZT0MeOIKRY+A60r/a2F2M+6xtFjhDW/LP6Vvjl9cB3LXcvwGhH0/xvp7SDLEBXoGA6rx uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d8vxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:46:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EN4Ri9016232;
        Thu, 15 Jun 2023 01:46:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6b2v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh+stTMHTe8fgY9TR0g9DQTp5JoQlzG62SLJZ5qObVa+SBWEWo8L1QqB2wP2ghb/4o6Vd5a9vMe6kBJpjWRwg9YMrU1m/6yNwT3fhl07V9daOb4aK65fYQwjCf9sPHHiSTDaA4zv7II25E6OhYv3iQ8d56yuJ1nsiQGfLMFHnIvDFehkY6erkCyBsoTDRpqjKX+GG0xON9Goq8ZhZ4qo/h9pqiOolTl9KD101nh5j3MUBNvUZhm3UEhnPF/VJB0VolTjjqlSZtOmFWKF7VlFK/J7K6F7yZQaY+1afn9QF4HgNLMp2YZbwdjuA2w/9uOIi+TpY820CnqFYYxyPprm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvBIOxByfIKgD8cSlrcULAP3SoACy12rD/ybGqKMB3w=;
 b=jhHo+sP7LNwS4+xF+bZSfVee6dhq+IvOrEiXeLnkDhYg3JphaaQhbMs+sVJTW0sFAD4w0wJKl9b8j1FrA35XLhySVYEEtLBCN55g7KKAbVRdRt3DuAcDR83/mfscA2NLH0W7SerseHOhVrW+IHh6ldRRBGmHu6emss7K3GLIf7IJDrEAfHrpx7lGXNZRxJIbOltiMd4Dtqqs42gOVXx/YfVFihBz7Ng3BF3pIqGmKhES6VJGRAQWa89gl0vEEeMYG68Ig8FC8VV4w2BCoagH/y6eIA35R3WH6gH3Zr88muFRWU3Cz2e/THw1lFbTzKRknCP5YUkqYFPw2jIPOhYoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvBIOxByfIKgD8cSlrcULAP3SoACy12rD/ybGqKMB3w=;
 b=jMvJkSLpn1IaqfMbixlKrH6uaceGWtsixVNxU74mXmD0MO9IbiPRA2rKN+oceWuOW6WRkx+6J7Z2r1aOuDdJ836yNa9O6dSc+S/QyvG/NyozEArZUVA9t9RcSM1RLgCq73mIi/R2/57oNhxZx13wBghjLnT2Xy4oK5SWvq1Yb0g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 15 Jun
 2023 01:46:08 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 01:46:07 +0000
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>
Subject: Re: [PATCH v1 0/4] ufs: Introduce MCQ Quirks for MediaTek host
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs6twl9m.fsf@ca-mkp.ca.oracle.com>
References: <20230612085817.12275-1-powen.kao@mediatek.com>
Date:   Wed, 14 Jun 2023 21:46:05 -0400
In-Reply-To: <20230612085817.12275-1-powen.kao@mediatek.com> (Po-Wen Kao's
        message of "Mon, 12 Jun 2023 16:58:08 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fcec305-5972-45de-6520-08db6d4249ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ms2PMRM/1eqfddpEHONoZogcevynpbryXJPJMWtBDcQtbPjAUgP272rrTVDrb5232N4JgdgAHGSshzXxzcrbJ+FrgE/tRJA3hSV8DvL9f1b+Fqny2Qj5N6M74ZVAfDGu18FeXXqnasnXNbB+YDC4j+Weus5TG001whxL7zPIlsf+kWoLNAy5ZatfHB470o5hAEdkfDt9nZAPWjtDhS07gs/HE+/TRa0jJRGW36RjunJeHQ4143EPO+VJMXgW1dfgkXR7SplZLZ9Fhfi3t11zwgMjA6r5podKmEl+J9+Wod1Hmm05zClkygGOUovvpEsv3Bn+b1l7f7HYKxNvZPMoJDPZCZad5HF9+NLoeoD9hnXvQ78DgFshw0r3ILw1hoG38BQ+rzfUdwmhFxX/05ROeQ/4bf0An9fS/rnNQX/HRYlPn2CSAYvjTd6AdiHObTffCd3JsoxWlFzhlI1zR73/eiruTaGdInLAQfE0yLjSNTlqQ9LHvMYKqUKdTY2Sf+XAi92BFh17DHKVuL4p5S2Z4LXidFOogi3iyhi7YrLY03XFWenK0ccxeAIyPrGFxet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(5660300002)(26005)(186003)(6512007)(41300700001)(6506007)(6486002)(558084003)(7416002)(66476007)(4326008)(66556008)(66946007)(54906003)(38100700002)(8676002)(8936002)(478600001)(2906002)(6916009)(86362001)(316002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q89F/6Qu/s9ArZ0oVZk13K2pcaXj7v/gY502celYTUMayk9jJiLnbMcUggT0?=
 =?us-ascii?Q?Ak+jjaavG7MTLJrBCR03v0dcivmfmBlQe9Y/xP3ww+yws+ZNK85zRajWGmGN?=
 =?us-ascii?Q?cpMH2B3yfJMMjDZwFskW8DHOMMZ14ZrQQXWtauTCnfpbpPh3V/EXr83KE3HY?=
 =?us-ascii?Q?nZfVkKFjzwE3Htc/psn3YrIwlKqNqBXQNyPNn9RpD+GbtEIERaoeeiAjWZIi?=
 =?us-ascii?Q?rG7NE/xmMOZS8AdzZ2niA0m1Ux9rZqqb098uM+cgObYW92jt83zgCePteBzc?=
 =?us-ascii?Q?rgW/CVF4idrL32HtrSBn+11vxGZFaCkjWG632QxPH/cFYh7B2C71QW08L4gK?=
 =?us-ascii?Q?sHTgs1qBKAHLTBYvbB0CZHbcNzsU1hI8x7QHqAyY86vfVpb094ZYusqi/rQS?=
 =?us-ascii?Q?31CZDEd4qaSJQCBEoaorGl1Erl+mEf6PGgjlp5HwX8g/0FtNw3KDlbDFRxfj?=
 =?us-ascii?Q?rbsQFdK/pnv5z5TlD/tQaew/MzQrdyWGeA6vTaefNEpTFUq/jag5ipqyPlL3?=
 =?us-ascii?Q?+uF7VN7atCP1W+myCoR/rxTdCuP0xVj17fDKtKcQhtWzLPo1Q7iPajzPta6w?=
 =?us-ascii?Q?S/WERX9CfGSy+5/Za1/XWHkjP1ApZK6TU2jdBBOX6Ve3Txx3D3K1j4vyXF7s?=
 =?us-ascii?Q?tuIepHkVs9SY0qxOFjoBJH373lyxqMIWq5B6A8R4SAfDql7QEvTsDU3EPepf?=
 =?us-ascii?Q?XOJMJyP/RYGju+NxNxX2EfREZj8zL7bY4uZ+Y9pyAlIGvd7AZlUIdk/7I3bq?=
 =?us-ascii?Q?9ue79l1wJacwlCwlH6ivlpylGiJsFnt/OLLoBaektS+CV5wlaSICnAyGgAwj?=
 =?us-ascii?Q?bbWwbdf69TvoBMpbWz/kQKl4kQLDoZXqVqrwKBvlArWWdk2SsVkxUq7+4K/c?=
 =?us-ascii?Q?AOGIArVA4+zfSe0mp40rew2Mkn8NX1UEHp2HrQb0A8SHyhRIf/+eRRLcJlzF?=
 =?us-ascii?Q?0x93QQ1rf5CLTIyAKWNnJcXTLD9AKpexc70ZnP0OYGXN5dAiiWvEGY8RtytC?=
 =?us-ascii?Q?FhC856Kx+v2IFAWpO2JdhbxPmyoiVW/96WFPG8dTmn5C0UB/vXXMd7cQwBUm?=
 =?us-ascii?Q?ieV8Kb9o3qudwHUEP/PH9XQdNFKrXzdXNH4XP4kkMgOvprVnylGqp+c6VNA6?=
 =?us-ascii?Q?e4qHtQvJtnk2MLF1fmb7eQF0ZafrSYgrum3fesDlWCOl9fuqlNNoHoLRX9zc?=
 =?us-ascii?Q?V0sQ8NkxY1IaEuUp/CMQfn0jWNILblNJR2pzgW8aEE7dx6r5Csp5cuePrpEj?=
 =?us-ascii?Q?pJk6VY8xxndmO/2zzKjRTl/5bcbvvcOFOLG8NileeqhiyYS5mbErRC7dpYfG?=
 =?us-ascii?Q?R8homYjdgAcFEomIvX+WaGMsB1+e7PzXGOJxmN4amSMQSFBzvbDKUvNW40A1?=
 =?us-ascii?Q?A0wEOkjW4A+JqYVCYZMcC/EMdOby29uqlNaXtT7dTsIwlltTswn/SqgSHPmR?=
 =?us-ascii?Q?d3x5ghboe1sHGPGJRsL+rM8p48twkg5eallRuN2VdIZA4N7okOgE1GWXRHC4?=
 =?us-ascii?Q?77sV5nL8GCl3q3zqjT4FWbPqOo142uP9SjmiSus/aLM4X3+jPNY4tZTI/tka?=
 =?us-ascii?Q?6EVCPQLgz/UDesqrN2F6Corq8mWXmHWOYyUcZRolUgpBCghiBR1Wd5jKyeM1?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U+EqwwNlyePyXINQkEOjJ/arvpXthpD0ow8BzYrK5p40jk13VxR4HPtyMHkc6eulithl781ChT2yQOs/OFgadiuGneMaMxmhWqXOK7LlC+91tXWZFAwxu7Pm8yprFdr87TKaqChngl+mHFAl22FIcYyVHJMmYDZ62DjLfVbqjIgbknEqrMHWzlgbW2aiPFVkCRkpqSZyjnzicsqBh5BdomslYH8X1jlLZ0zJZRCj8C4fiKgc7Pbp/tnZwbO2DNtu5A4KpfhAv2VJuk02hX5fSzKohUlhmdS6b1T57ieRnT4koDFb18tATBnoykMDcMtdjsZjuSEcw6gXc5/UqhSCsJponjsouiI5678LOW7UAuYEQG0kf7KmyLK5TEWdy88ELFZeb9KKPtlGLhbvUURjJJ3IhY5Mya+a8P3nnFO3paEhyRHK0szovRDUM2+jlndOmHCZVpdueFGkcFE32vktxTts8snoVER8bRdJyyzJH7iRhaNICdndEiuetSBwEHvnZDJCwRvX+8QjDn8+IeCA7hu/ZF+lcLj3mGsVby+7bKXd6OUpHFQAHNIrPWgOLopy/xPynBKai0oxqsq003beMF14P0O1rD/sYoekl4ASE5yHACX9pYDv8LopklFbY+nQLVlsOeCfjkNHayAVZR8NhVov5GyT8Cc5u4IiClYmOVcp2KA0Xg8lrKH0ypoqZwUucniRgW1i69J6ekLM6d2TQQfdqk559gqEo79cz1pYU2VW/Nz7wfEtR+pGTW+j4P3wXqat3eQcZg7M+aiK/pUs/qf9ZMOvtf1BLqMHL5apcTutyU+sHMvsrcIWhPHZO6Ib9jm13kv2qu7dBxEpLQ9DK+TG0JnaUUhyLpxyi8eYilccfaIPtyjrk/awkrZWw4cJxoBPet3++E4K8ajWCVd1KP0MXWJIcvrfzCPfoNPWDVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcec305-5972-45de-6520-08db6d4249ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 01:46:07.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u89AOlWiFPxTfwLylM5IbsYXZP/cvfddWMtGGdphIWj5mbZoQMkBkDWam5QkxCX9j/SzXtUAxfQPRa9alvT74Wj1RVzcPC9KesTLNh32wJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=709 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150013
X-Proofpoint-ORIG-GUID: 6XE8Sn12lTte2-9VtRNq0o7W3206htqY
X-Proofpoint-GUID: 6XE8Sn12lTte2-9VtRNq0o7W3206htqY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Po-Wen,

> Introduce quirks for non-standard part of UFSHCI and address Bart's comment
> from last patch

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
