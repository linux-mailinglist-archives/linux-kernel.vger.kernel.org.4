Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63413644CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLFUDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLFUDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:03:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489726558;
        Tue,  6 Dec 2022 12:03:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6IwsWP028083;
        Tue, 6 Dec 2022 20:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=qWlKEI4amWuK2Jdg96n7qPsNGWDLiKJlNwUT6+YdwV0=;
 b=1lH+45wBRxjF0OMmPeaPd29V4vZmhY7IgSf/LofpKlrZc2sbJVzq3z03EbcA2mTxQl8X
 UFnNJ9xN5xg9AujMpjnfTAL3Xt40xTIeo4X4KLe6owiV0Ul98GRsqN3gg4VyRdaUXlKL
 Ghb2OJdAZrTHlr42LKyZPQFxTQqiEeq28qSo8gKCLiXoICNvlYzf4xGvUQv0H8kdCGK8
 CnK681WFJnAqafd2mWda0142TY85SSXnkX+4Ej4wc0FXS8+WUxVJ7IvovEXKO4z6qis3
 92cYVvfF7LHCC3UGwX54fa5GNEgyK4B8PzepYOFmh9c3+ZA+6n/aXCC7lCGjQ5aMksoI JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ybgrm63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 20:03:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6J5Mwh030642;
        Tue, 6 Dec 2022 20:03:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa67pk2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Dec 2022 20:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtg3xskCgBd9T3eBM5Br9yedKTdrCAzomo89Lv8MFPe7fTYAdti02RvH5S/GWcYFYS3nB/vI5EeOkfEOYqX0T7oGK9rY/zE5h3u1sgjvSkC3kUN1D/BZGBceceGgw695hjJAo58a18eMfKfwI0y4bRd180qMaogQBVmT0l5Ebk/aHI70URxlB09AXKyqM7tkWamtz6grsMVUbjQk8pI2tYYel2Csy0JxdOtWhA2ajCJ+c+6J/yY6zDjaTyGKvJmNKbIierQbKOh8jAM8mu8P/xxNV+PJGIdKHEJLFr7wCZ1R3dspkeLcdjhuy5NbguCC0Wjrmw70y4ZKGkPk8ZEEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWlKEI4amWuK2Jdg96n7qPsNGWDLiKJlNwUT6+YdwV0=;
 b=Zriy1HPoVWGjlrKf4xwdQHb5YYuFs1HKXjJoGSVW2mUTIMobLUHA7EpSBlUy0+d/wjNl6qDM3PPBXkNW/6fD4iB49cpmvOZRCVXaWI+dfLoEXyrPE6Gs0J90e73XF7vJ5/xzwH693k6tLLBwO01jCNYL937IkbnyYbF0sRBzWlCfv05marowa+6q/lJyArOSjLZoZApuPUoXeapNSz506cias6r78Eg7nEMEF09upyvkhPA+ZpPahPhLN+1s6D+kVDlq8wHRLlIWJ6bwUzyiru80S2xSL2QZVMmXskukNTVA0O+Mj2WmhmtBUWKtZSG5aL+aGgWiJtQXqiZBvzXVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWlKEI4amWuK2Jdg96n7qPsNGWDLiKJlNwUT6+YdwV0=;
 b=HuKMbWJCaanPzvAqgK4VDxJzLD/rAePRadIflRwgZbJgAdTLUHrlOLdDOZM6BU3ARa41uamTLrgHcIDJUBZdvnuWOW8/yLd0DrT2t4D9jbjP6RZNeCYICJ77J7G6BHaJcJHdYUn+yNwU9nvFDfyqrUEPf1encpQWlbXDiST1aQ8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 20:03:10 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 20:03:10 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mcgrof@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v10 05/13] kbuild: remove
 MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
References: <20221205163157.269335-1-nick.alcock@oracle.com>
        <20221205163157.269335-6-nick.alcock@oracle.com>
        <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
Emacs:  no job too big... no job.
Date:   Tue, 06 Dec 2022 20:03:05 +0000
In-Reply-To: <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 6 Dec 2022 10:11:08 +0100")
Message-ID: <87mt80l2py.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0630.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS0PR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: dc50f776-f883-47d7-2420-08dad7c4e620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdUoinNdHIkP1Xx47Ku//kb5IbCRBvQepp60s3sJR+6xf4N6G7ygZ3nlYppZUerq47QyeJ8TovpmBFcR5pDbvHyAXIWky0MDMoIGBWEjPEJhHTyvTmoPfGXhkNW5TLrhGTSbmUf6ygQg9QElIznVENj/vfQpLO5mH3yzcorvMid8mcJ0hSPymnLmW00vqpEAYa47WoZmwrpKo0wMoZ6wHUBbd84utUcsIWWUudrabvmY9CJOcPbdxSV44hlGnaCTSBP+G74uqJU9lKvdbKuTjYBDjVRlVu0QhbqBnxuGU2qo3xWXbF2vzjuuO8iJI8+p1uLmVmS2qPCTpha/FJBhAlp99Q1Gb4HzHOT1JPtrZLIUbDIz8/5jpbpArFCgJdcMsNwiuQ+mRw3VtzB6Ri7BInnK4HL0evW2rYGy4QCjkZRnrlehVKI9e2IjWg+bIO52qzrncGnVAfVZbO0uoSnjvfTiQUkQO91WetzkvNgn951ZSV1o1Be2gW7q4E622pH0Mwme1iQ4Cb+zQQIKG/HdP0iXvbabK01UP4Q8LhDqwRqudCfU7JDaProZHLD3Qf3iJBufZPJe1jvpVr8ktxtdZZ/sFULfBeso+Ri4tf6u4NkhlBl7dJFmmRpLTxdqDtPToO+ALciRAzolVqDxqlCDlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(2906002)(66476007)(41300700001)(86362001)(36756003)(38100700002)(186003)(9686003)(6512007)(66556008)(8936002)(8676002)(4326008)(44832011)(5660300002)(66946007)(6666004)(6486002)(316002)(6916009)(6506007)(53546011)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NkIY+RsYla+lY1ice+W4fsXYRJutaNfZqQyxQjcd5IaacTBLpgwa2f/pDeP5?=
 =?us-ascii?Q?1zcWP7BLLV5aXDz80fWa/Si/wmtJ6FOCM+4lNabqwe/HX4Bjez57cwVvWmcP?=
 =?us-ascii?Q?ntHTfmIXhblMahXIh6u8a48Z7ID87fG6Q5rV3OOi1SVmuYlejlHJjqnVQgVs?=
 =?us-ascii?Q?r3sPKuVlZAloYdatqDO0bqjYoHRPjZUBpkhUGW692YSYWr0nuMJ4H6H0cPYh?=
 =?us-ascii?Q?Pcy4Dv1hNVIPRHLQ/xwgpi/U4D9YvQdWkcbogFtx1fW20MwsROgenJX93bqI?=
 =?us-ascii?Q?CQPd0j8kDA6a66UHtjpIM/u3Y5DYP5VWl2RsyYlJIZWFfsza/IYb0dqT7vbZ?=
 =?us-ascii?Q?pzLv8cSuGEvwGppaOoztz60wRPZxXvNB/Kq4E5HiMbpxDRC5PWgxxIJvqYGl?=
 =?us-ascii?Q?OPPJcx6FgFZfMlPKdzV/pUidqu4wAxRQ436H93PocyicSF+0wY27EuHdnM7B?=
 =?us-ascii?Q?PPOChBgo2TW0mgYSzLMjtImR8+DGGOFLaBed1TaGgo6uuhFbNBZjyVUVOLfQ?=
 =?us-ascii?Q?RGGS5d2xY76SS93gBBzcgBpB97juIxs5OfXOovSZyIvRkHPA1e9VwMwC847g?=
 =?us-ascii?Q?ct941RfsG9M1itMUDq97wy+wPLkDpfahI9yzQTbnMvmr6JpfeAuz8a+k3wKJ?=
 =?us-ascii?Q?+ZttAwx3uhzp3RvSw9O4h7HsakY4uq72wbx7eVCmQyVatBj/L17+bzxafAoV?=
 =?us-ascii?Q?WO0r+zCVOMGylnFVT/Mf/ysPNgiduVIYYZdocGjG6wqNnMu2f+0t2z6RWm20?=
 =?us-ascii?Q?eLXHYUzSGT991dy00fVSa44m79+e5+JCMSOjHlTdvvdyIl2j3okC1aGEWs+g?=
 =?us-ascii?Q?Edes8G2yBgivRuX1qjfFWjGAk0SP+dFcKTFnU5pLpk2Q2qYNhI5F43V0htFx?=
 =?us-ascii?Q?rmpHFrN/tbvzHqFQMXTLOpAIDIk1Gk8VIaEUa3p7MlC0Sys2e0/Ks4VlM61G?=
 =?us-ascii?Q?L/aFg7uxv1L7wmIwxT23A4gw0aIu6Bu3JNj7RFRROEd/dQ45qUhqZKzew/uh?=
 =?us-ascii?Q?K+vt17NQiNttxuiXhvUqsW+7wTUeJ+adNEGEZU9rjUtft7nkD7g1wnhvfZzP?=
 =?us-ascii?Q?fJ5azfQpEswftl71j2yA26rruxJW0yG8Swy9nUc9n4uCY4L5RweK+zlK73k6?=
 =?us-ascii?Q?NvFK1jyFc/GZQ0caV+Sm1sdImgkk9gAUCJuACglrIy6v+LEuiHVGsHT8jtZR?=
 =?us-ascii?Q?alNYaDOzgpecjAaIrN924xEjefjHdn0YY9mP36Vnww1VpDfKRpR5EJN7elNq?=
 =?us-ascii?Q?VZhTTEUqiPHgo8mXaSppIJK9c364soaUeRroD8zJlq94qmfPwewHQaCcySMi?=
 =?us-ascii?Q?pALWO0eW0x3bnL/SMRIOqYpkCdDMJ6piKOoSlIabdLxggpYCsgk1vG2tkTa5?=
 =?us-ascii?Q?OCoBfIZBixyvmgxhiNPPKL1zpcf3STdgeY8wOjtrhQgT7IWQ+0mJeqm6z4Tu?=
 =?us-ascii?Q?oAR2Ub1wAuBAn4OMovkRoGMGreef8MYbVcNjcRfgVovdjPMHGmfZa3Zd9FXk?=
 =?us-ascii?Q?NZVoO06wveCfrgYgW+XSf4qF8aBJukSJdMYIUkESIOgLuXsHcNiFGb9D4LIB?=
 =?us-ascii?Q?inhQ/+6HA8+Ypf9jpXR60QJsQlwvxosVl+DswkX8ocvDJExNy+n3hRgPCDlZ?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BxAx8yvLlnaytpsG6nTNPgHeVMXSgzuWQGLjp7eOBZp9QuvrbHlDOC7kFmlJ?=
 =?us-ascii?Q?woj8Dt0PCd+qqKWy7wtM46OqcLikrH3a0w1zwe060wp1Xtdhfwb7K8fyQpzM?=
 =?us-ascii?Q?ZEPrN6/yhihPztuS3a7ijf73oaublbFIdbOOQGUmeRXd48xWeL8mGvglPtIu?=
 =?us-ascii?Q?TwVPBDfgbJlIdMPLtI/WWccndT7FVKZNNXTn0NAIOajDTZPkDzPcQBeH0X4i?=
 =?us-ascii?Q?wMwG80a4tV/PqlbV0J71i6qwaDB1uGsen/tvTHOOEyrQa54Yj+WMrqhJqjPE?=
 =?us-ascii?Q?2TtXu46QYDEzK4AIOt9ZO6S9v3Pf0L5/dSR0hZjorvoMNMzT44m0hGDU7YXQ?=
 =?us-ascii?Q?+3hXUOiv3DuGkiZK26oIao8f5U4LZgqgs/eAtvsWn98qY0ZSVfM9wLiLIjWc?=
 =?us-ascii?Q?9rbJ5L5JJu3ajm8R6wrYzKTdTkfH/XAXSqcOztRZ6WHCo5YgOt02wPLqJ9e4?=
 =?us-ascii?Q?ZbQttuSE960Dn8ijFvawDnNUqUaBHg6FQnDF1JfVrcyVZQD6CZEVGnyqjhUY?=
 =?us-ascii?Q?p8fNBmhDFbhEdcrcraJMJgVf5ZK36wJaeHpwTQ/cJnEfsQh3efAsCj7qUw8p?=
 =?us-ascii?Q?5QxvevUMYIg3SjtST2OAGGN9qjQ7n/XiuxqH1ejydPx/DQg+I0axFzP3BBbN?=
 =?us-ascii?Q?VMHY9Afs2ZUpWLKSOBHgkh8MSmKp+in+XJi5j5ayFur2znMWu153uzO+2n5a?=
 =?us-ascii?Q?vSYkOB4SDO/1ljAhV2IEu7dJuRTg0uiDWorAU68mS5Ju80CL1xW7wIBNegYq?=
 =?us-ascii?Q?srb0eM0n4o+hoBX2Yz908QIIXNZei/HNRYVv2zKh34tHvaw8QbLqN0kkuyGo?=
 =?us-ascii?Q?IcTmEdJOQA07HA16SvVJbRUHH1HLIG9DcNXVxQc5wH/h8nIWZL7AP6rTI4US?=
 =?us-ascii?Q?u7D6ALa6orVElZlVi2M00JFXa7Dy8iRVmlPphHS4Q0Nl3ADXRASSxDZ7um+Y?=
 =?us-ascii?Q?E/7ABs3rpk7gRjp+l9I0K+v4tm9jdQucmU70gwqrgfx1eRd+xBIJl0tpihzN?=
 =?us-ascii?Q?4MLQOxyhutlQE23FrlEAmO9Fww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc50f776-f883-47d7-2420-08dad7c4e620
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:03:10.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aspjyDMWjQ1QvqX0iYDEJf8BNsJEvdpDwHfOYWwtEF/BAxpPMSrWtLTHuOKzqUHS3VDBH8uun1E8Feh3oq8jlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060168
X-Proofpoint-ORIG-GUID: RG71rR1O5fYNrF05VKiiKP6tQUa-ZoU6
X-Proofpoint-GUID: RG71rR1O5fYNrF05VKiiKP6tQUa-ZoU6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2022, Geert Uytterhoeven uttered the following:

> On Mon, Dec 5, 2022 at 5:34 PM Nick Alcock <nick.alcock@oracle.com> wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations in
>> non-modules will cause modprobe to misidentify their containing object
>> file as a module when it is not, which might cause it to spuriously fail
>> when trying to load something that is built in to the kernel.  They
>> also cause misconstruction of modules.builtin.objs, leading to incorrect
>> output in kallmodsyms (notating things as being in modules when they
>> actually cannot be built as a module at all).
>>
>> Automatically identified with the new tristate checker, and purged with
>> sed and a subsequent make allmodconfig to double-check.
>>
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>
> I can (sort of) agree with the MODULE_LICENSE(), as it duplicates the
> SPDX-License-Identifier at the top.
> However, you don't explain why it is a good thing to remove the
> MODULE_{AUTHOR,DESCRIPTION}, too.  This is useful information, in an
> easy-to-parse format.

I was concerned about that, but I kinda thought they went together and
it would be neater to take them out in one go -- but I'd be happy to
keep them in and only drop MODULE_LICENSE.

> Moreover, many of the affected drivers might be converted into modules
> in the near or far future.
>
> If the presence of these causes issues for the tooling, perhaps the
> tooling can be fixed instead?

Only MODULE_LICENSE invokes MODULE_FILE and thus ends up introducing a
KBUILD_MODOBJS entry that triggers things going wrong iff not a module:
so only it needs to go out (or be replaced with a variant that doesn't
invoke MODULE_FILE, if you want to keep the license in too -- but if the
thing is no longer a standalone entity at all I'm not sure what meaning
it could possibly have).

-- 
NULL && (void)
