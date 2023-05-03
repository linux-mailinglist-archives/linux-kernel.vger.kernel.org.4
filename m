Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040F46F5F20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjECT3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjECT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:29:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A083D2
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:29:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HovFx000710;
        Wed, 3 May 2023 19:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=1Ofv+WrXN9sGlpXodgfWGrsHTmhgiWXNmgIQy5SBU/w=;
 b=3VtJ4II+3TCJHj7bIeY/0LljGnX/SnA3Wq58Dr1uTTaXS+tksXG2dQPdFZOZpShRCNZn
 SFH6WctA8nP0rXOQsaN51NHBuEOn6XtZ7VuBCHkpUXzBFB09LRBJBO0AIe/plAmk/YLE
 iTyeARcOwwCPYFuRMHpL+9w2RBxdE9+m1CJEuaADYX5vVVJgvJ8qRSMx56Iv1rWVyz+m
 c/nO8Mgwuw66JDfLfdf4F77VEnJovxx7pyA+kA9c4s4AYITf7CmV08u1fYMh4Ww9m+UN
 eSGUxBxoOk6b00m/IP+G5ynYdqFKZixASsKARbo3sbcnaxG1s/T0RRv04l7EFHLey/NR mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv04pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:29:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343IheVn027427;
        Wed, 3 May 2023 19:29:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spdu9q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WifKLH2GDwgiAUat05LJC2JmgqiPp2TwXP35CGX7Rfp2MMmtV9Odvwrh6JikQm1hNSmdX3n+VIax5cP1HFbD6AP1eCrePK8nIcivxuW7xcG8Ar8FYbpBiNLDDBLr1+1UYgdVUlYTg2NetP1wSzYqKwe2W8w7dCGZtaE4eSRjJ7nA/gSY2iqvpi8Iv/Wf8ZDs/aBzf9H4pY4GfSDLWLzksO3pZ8sVHUwJsFSiHddNXIxYRvfULtG6miROlXLpsOp7DxuFkBGHL4JApuueGHnguBPY+KEp19Ne8mof6vYBjm12iMMWCfj4u7cOFFBZBsK7qzCYepraizv+t7+T0ALsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ofv+WrXN9sGlpXodgfWGrsHTmhgiWXNmgIQy5SBU/w=;
 b=XkbWx8/rN0Ms2gdV8fngDQjnxgv9keS9hrANUMBlsY3uqEaBd3txuhRpBXuVY4eYupx+JYuECMKk/ujNooKv1BogyezvjpRyQdLjfMyRYCxtWoUOzGxa41wDIO1iIh5AS4UxenEyi3jCbx3tp5mvCSHQVkrfndXXacytRQZyA+8CtGKjksYtiVSChCTtTB5SCHzxW/ZDi751da3ITos9AFtE4puar8tfcI6XJCXmcrItq62eC8+GZt4x54M7UjeU3y14ggY4AtDXQ0BexofWfbo63Ae1PM9giQiKH7u38cS5eCWQyjINiOWOZ+bMzIu0KPTUkvZY9a17UpSBnS5l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ofv+WrXN9sGlpXodgfWGrsHTmhgiWXNmgIQy5SBU/w=;
 b=w+f9wIM7pODYT+/Z+CpzJ7EWoZ2d6l8JVREHKYLJycz9f06u64eiPq9nvO8ayal+GwmBoYyAgcKoH4S5wD21L+Qjo1UZew0Zrk0d1pYG7k04w7LPoYJ5nGtF70s8mKwJB6RlzQehAgwFuz1kFtkm9plrIiTZCB0PqUhQ9UVbZYk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by DS0PR10MB7272.namprd10.prod.outlook.com (2603:10b6:8:f7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.28; Wed, 3 May 2023 19:29:05 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 19:29:05 +0000
Date:   Wed, 3 May 2023 15:29:03 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 29/34] maple_tree: Introduce mas_prev_slot() interface
Message-ID: <20230503192903.vphoxddkve5xonng@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <perlyzhang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-30-Liam.Howlett@oracle.com>
 <e91f609b-bee7-bc6a-cc01-e2d69fdd68c3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e91f609b-bee7-bc6a-cc01-e2d69fdd68c3@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::21) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|DS0PR10MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: ea663fc8-9782-4a6f-80e4-08db4c0ca83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k7CqBDN9J6yRYg761DCVjjeyrxVx0KGADjqX38O+vZaBTiL7yRxhgP3MpPS9bWHMjZiZPxFVYMZs7I7QNwxDzxcNaHouYU8R/0Wcw6gsynHBQ90HzQ9xyxE8sBjlNqUKNIfuPVSz+cCG5rGj9ykxXsUxw8Ykj+1IE52aSjuMh73yD0Bd90cAPRn+TyCTsLPAo8lr5Cz1Scc3ZblY8/qrezm1RU/cdH+U5bgD6ngD26lwxg96kQVns/9a7ztIz4Dix2uIgHNopt0Qd6D7n6vM41qsYQtIFFoqenXFgkeEg/077yfkZpzQfSPk3vOGHwp5WwOgNHHUvRTte75vvn6vvRaSl9noQtWB8KZ7GZR2KWxyEtjq/GrzE2S84mYcsxE9gMLm7S5pJ+7pm7D9au+tIuXjr7inXg0VWiEfDRUyYfcG1iePur50aN113H0dsdBJYhIObrf1mMtxN+IFxq5r1rgUP1xrnkv2V2aAr7sj3oZQLSY4gO3Dtoi32Cjt8FvCRNRBwhjWycc0n595Jy319EXWvTwzX2uFSqAOsHRXCYyva03pUgc6RATtER2VlvF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(2906002)(478600001)(66556008)(66476007)(66946007)(5660300002)(8676002)(38100700002)(8936002)(83380400001)(41300700001)(6916009)(316002)(4326008)(6506007)(1076003)(26005)(33716001)(186003)(86362001)(6512007)(6486002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdDL3BWOERjYm5KWEkyMG1icFpQTm5zQ2FVUFc0NGRSSCttUXlaQWwrV3A5?=
 =?utf-8?B?WGRpZVEybFdQd01lZ3J6YWw3USt1WTYySnc5T3NYcHRVT0x3Z1Ztc2JnT2o5?=
 =?utf-8?B?cWZPU0RvdEhubXNBaDN5QXVnaEFJdUw5dmpOYVM5V0gwLzkzSWVKV0xDeWxZ?=
 =?utf-8?B?MUJoUlN2ZWRzYkJ2aVpvZzRUQytKbmdpNkZRbWxsT2Fiam42YnJ5ZlU2ZCtB?=
 =?utf-8?B?MW96WHJyVGF3eXZwQ2xjREpkN3J6MGhLMU5Jc2pWbDhwUTF6d2RjYmhWUVBZ?=
 =?utf-8?B?bnVhS2VIM0YwRExYMGVHM244dzZnSnBHRTB6K1BQKytuZkI5VDBWM0EvYmRU?=
 =?utf-8?B?NmNUUnp0dkRqYkROUjJYbmR6VXhnTlBtUHlwMitsei85UXdoZCtBUmd4cGdz?=
 =?utf-8?B?WGNEaFl2OWtQK2FpVjF2aHVOcXpsZEwyQ2tKeDUwbDU5aS9MbVU2VEd5M1Jk?=
 =?utf-8?B?dEVLeU1qbDM1aWN5ZXd2eis2S0szTGZWU01YTG1WT1FhSnlIYXJxUmpXeE5O?=
 =?utf-8?B?eHdVSExsN0U5bVhRd3BtWGo1T3hMY2E0dzJzQmFYaTdOa0h4SEJqNlNEVW9U?=
 =?utf-8?B?K0tIaHhPbXB0WDhxbG5obmJNVmhtNURnSkFqNTh5SGNOYlgxdzN6YTNkMjNL?=
 =?utf-8?B?REN2R2tYbS81K0M0TXRaZVdxcWFkSUZmekRvUWFrUFArWlNLRG5kWmxxQUxw?=
 =?utf-8?B?dlo3N3d4U28xb1ZwQUx2M0ttQ1UyUHhFNUpKaDF2TGw5Z1dyc1FHcEFPa0Q1?=
 =?utf-8?B?TlZlTFhtNEYxWFJXTS9neXBKRytZbDg4VkY4Ynl5MmN4cVBOOTZTemxQR3B2?=
 =?utf-8?B?OElRTExMcG1qQzlnSHRzSEl1eHBnRStlcWFidnFJY3d5azMyQ3haZ0loNzlS?=
 =?utf-8?B?MjZiajQ5QnVmVTRYc3ZiT0o0UUJYVzZqMXNXOFN2N3VxZkh4NjlaNUlxRXhL?=
 =?utf-8?B?UzNsSFJlRWI0ZERvNTN3b3JPVXFPZEx3Y3daYnV2dktyZlQzN0Z5UTd2blVz?=
 =?utf-8?B?R1VqckloTk9DbVluR3YwVG9oYmlYSXZnUWVSZW5IUUlWRWl5YnQwTG0zdzNV?=
 =?utf-8?B?VW10L05ZZUFMS3N0VUpnMGNZYm5nUjRtUFhPQ0tNU20rUFJxV3didVNHR0dq?=
 =?utf-8?B?dmlwZVROYS8vS0NDN05vQ2VwRmsvcHdCd1JnS2szb3c2RUZ2RGRUNlhveXBD?=
 =?utf-8?B?YXh3dFQ2ZVAwR2lJMDRHQ1F6UWFscFQxR2VSMmxMZGI5WU1Idlp1Q0xqY0pZ?=
 =?utf-8?B?NDh2aWllb2FIaVEzbGl5NDlWSzRLSjF3bHBlejVBV3dmcmJwdmRPOW9zVVht?=
 =?utf-8?B?ZlN0eHFtN21CelVVdTZMTmFPb2w1NGp4MkQvOWtvWDI2Zkh6YkVyUnVObGVy?=
 =?utf-8?B?eXBPSG1aalQxWXVrODhwZS9FSi9MU3N3QkZpelRWUXlZSkhhT04yK3pJOGRQ?=
 =?utf-8?B?bTJZZmd3NStIdm1HYS9VeWFlNUxDOExTK3k0dHorVE5TdHNwcmdYc0grZjdY?=
 =?utf-8?B?YUNsVHMyQ3cyODNjZi93TWZuWHRkNmU3TVBNUFdEa0FNbjlhUGYxeXBNaSsz?=
 =?utf-8?B?QU5aTU9jdEZuNEMyOHE4WENSU1JGcGgrKzQ5ZGF6TWNmSW5nMEpKaWxXZVlM?=
 =?utf-8?B?QkVXYit2VlZTMlBHNUI1OFFTZ1JVVVdsV3VaN2s4YXpvcWhIcDJKdWtwczdx?=
 =?utf-8?B?TjdKdVdjWit4YzFINUlZN2oyYXFURkFmTXZ6c1dwVjFkVnZtTTBjNjBOWXp1?=
 =?utf-8?B?TC9hSHdWYmIrSUc5UXpoOGl4TWJBT3krT2x4WWtIcE05VHVmWDlwd1lrMjRH?=
 =?utf-8?B?ZWVTMHF2R0tKL0lKODF6S1I3Z0tuVmVaNnF0ZU4wY2F0UVZya1d1dWMrWEZq?=
 =?utf-8?B?cFgyT0RZalFjdEp0NnhuTjVVRm5ENE84RXZTc2JtN0RCK2NTS2U0OGY4RDhs?=
 =?utf-8?B?MVlSTGU1VzNXL054ZHcrMEMyUzBNY2hpaytzWmVUS05SZnZBV3BpbnJyMHlO?=
 =?utf-8?B?a2ZORWtNYUJqQk85MlZRYlV2eFZOaVFYK1RxV05NMWVqR0ExTUM1cWFJckJa?=
 =?utf-8?B?SUdyUGs5NFhtaFhsOW5QSjBJZnNMYkFFN245TEd1QlBuZEJ1UTJEQVpzZEox?=
 =?utf-8?B?ODJlMUQ3RVZvbW91b1lDQWdlL2oyVFU2djY1SWhjQkhhYnlPZ2hsbzFPWElB?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +o30sq0M2UQj1f1WVGl1KwuFhN+7VnJyNDR6YqpmdyV6A34xDUPfLsBL8rL0peQ9wCW1dlwGxpXYSGXSyAM+sRT8gV8KXRkTzpR48l3oGoRXK64hgKTci35MDPOnyMQrZCkV8WsHzBMUFKoqEZt5r6PvVHvULY6QCqpb2zOioEegk1KVgHqsrfbT3VbSvsNIpN6oXXOu/6YTXpniBzv5rH+uh6BtSxcOrH6dgwoeU44PCJws5mPrleGF15hCtVq4iSzrewbsCld1P6hU5qjImFsGwl/d/oAyR7vCBgHdS38cLAZmO0evgXi3UMImIbnGBNRlijbTjOGov03/9VS67CIyUWv0eQffaCFncGdG2JuGYXfc/A1k/q3c2NG88rit4gUFymrAB6mDONCjF1QBlr/4O/+98+kHBvrGd2Bgha4anssj93uU32ZeqnKuQzVnNTc83km+v0i55MZNQqU71JrHH/5YdqxC8oXErCeLj64JyizHzofd90u2Yi9q7d/Kb8gkExqBHL/g9xYVhdCLQRCSTY3vvyzbH1U5fH8QG2nwAZyfeiioPA+l5v0fCw/6EtUmROEayO62KwVs//2dkhgx+NYJpQn3lOPaM+KcMdn3NkVJ1oNiQiKLzCo5uqr+S3LjdmUvQMdNqUroih8hcM39Q+z0KmqM6DlqVAC63dpzmDwVV4J3zXPOwuKx54ZSQ4NbSTySSYOe3ye99djhFp6fNdASOzJzSWmiQZfcREkv+Ff8uSqTDraQy8en02qDTD87edbAHCOH8bqIvwGCA32qYsNHZfM0JZ8q9cugLBFe6Ws5/MaEgjNg0HOnRND0Z6Q3VcfCnsNxx1N722+6NfM3bdIgCiPE83TsBI6H5AgAS8Kkxy5okyPu1GQux9JYX5sJ3F0gJWL6qQBqM9qLgk34k010GssM3Vu0pfo6Y14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea663fc8-9782-4a6f-80e4-08db4c0ca83c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:29:05.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7HZTLeFdvgBB2CQjuzF8pDFyqyIyzdR6gPAhB+C3cYXctV26ss8lpOIxtkiyQe5mrv+aE28Z3bITwqEIZHinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030168
X-Proofpoint-ORIG-GUID: UjK07zugMUziz_EircJqj1bUtYqAD7TZ
X-Proofpoint-GUID: UjK07zugMUziz_EircJqj1bUtYqAD7TZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <perlyzhang@gmail.com> [230428 04:27]:
>=20
>=20
> =E5=9C=A8 2023/4/25 22:09, Liam R. Howlett =E5=86=99=E9=81=93:
> > Sometimes the user needs to revert to the previous slot, regardless of
> > if it is empty or not.  Add an interface to go to the previous slot.
> >=20
> > Since there can't be two consecutive NULLs in the tree, the mas_prev()
> > function can be implemented by calling mas_prev_slot() a maximum of 2
> > times.  Change the underlying interface to use mas_prev_slot() to align
> > the code.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 217 ++++++++++++++++++++--------------------------=
-
> >   1 file changed, 90 insertions(+), 127 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 7370d7c12fe3b..297d936321347 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4498,6 +4498,25 @@ static inline void *mas_insert(struct ma_state *=
mas, void *entry)
> >   }
> > +static inline void mas_rewalk(struct ma_state *mas, unsigned long inde=
x)
> > +{
> > +retry:
> > +	mas_set(mas, index);
> > +	mas_state_walk(mas);
> > +	if (mas_is_start(mas))
> > +		goto retry;
> > +}
> > +
> > +static inline bool mas_rewalk_if_dead(struct ma_state *mas,
> > +		struct maple_node *node, const unsigned long index)
> > +{
> > +	if (unlikely(ma_dead_node(node))) {
> > +		mas_rewalk(mas, index);
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> >   /*
> >    * mas_prev_node() - Find the prev non-null entry at the same level i=
n the
> >    * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
> > @@ -4515,13 +4534,15 @@ static inline int mas_prev_node(struct ma_state=
 *mas, unsigned long min)
> >   	struct maple_node *node;
> >   	struct maple_enode *enode;
> >   	unsigned long *pivots;
> > +	unsigned long max;
> > -	if (mas_is_none(mas))
> > -		return 0;
> > +	node =3D mas_mn(mas);
> > +	max =3D mas->min - 1;
> May underflow.

Thanks, I will address this in v2.

> > +	if (max < min)
> > +		goto no_entry;
> >   	level =3D 0;
> >   	do {
> > -		node =3D mas_mn(mas);
> >   		if (ma_is_root(node))
> >   			goto no_entry;
> > @@ -4530,11 +4551,11 @@ static inline int mas_prev_node(struct ma_state=
 *mas, unsigned long min)
> >   			return 1;
> >   		offset =3D mas->offset;
> >   		level++;
> > +		node =3D mas_mn(mas);
> >   	} while (!offset);
> >   	offset--;
> >   	mt =3D mte_node_type(mas->node);
> > -	node =3D mas_mn(mas);
> >   	slots =3D ma_slots(node, mt);
> >   	pivots =3D ma_pivots(node, mt);
> >   	if (unlikely(ma_dead_node(node)))
> > @@ -4543,12 +4564,10 @@ static inline int mas_prev_node(struct ma_state=
 *mas, unsigned long min)
> >   	mas->max =3D pivots[offset];
> >   	if (offset)
> >   		mas->min =3D pivots[offset - 1] + 1;
> > +
> >   	if (unlikely(ma_dead_node(node)))
> >   		return 1;
> > -	if (mas->max < min)
> > -		goto no_entry_min;
> > -
> >   	while (level > 1) {
> >   		level--;
> >   		enode =3D mas_slot(mas, slots, offset);
> > @@ -4569,9 +4588,6 @@ static inline int mas_prev_node(struct ma_state *=
mas, unsigned long min)
> >   		if (offset < mt_pivots[mt])
> >   			mas->max =3D pivots[offset];
> > -
> > -		if (mas->max < min)
> > -			goto no_entry;
> >   	}
> >   	mas->node =3D mas_slot(mas, slots, offset);
> > @@ -4584,10 +4600,6 @@ static inline int mas_prev_node(struct ma_state =
*mas, unsigned long min)
> >   	return 0;
> > -no_entry_min:
> > -	mas->offset =3D offset;
> > -	if (offset)
> > -		mas->min =3D pivots[offset - 1] + 1;
> >   no_entry:
> >   	if (unlikely(ma_dead_node(node)))
> >   		return 1;
> > @@ -4596,6 +4608,62 @@ static inline int mas_prev_node(struct ma_state =
*mas, unsigned long min)
> >   	return 0;
> >   }
> > +/*
> > + * mas_prev_slot() - Get the entry in the previous slot
> > + *
> > + * @mas: The maple state
> > + * @max: The minimum starting range
> > + *
> > + * Return: The entry in the previous slot which is possibly NULL
> > + */
> > +void *mas_prev_slot(struct ma_state *mas, unsigned long min)
> > +{
> > +	void *entry;
> > +	void __rcu **slots;
> > +	unsigned long pivot;
> > +	enum maple_type type;
> > +	unsigned long *pivots;
> > +	struct maple_node *node;
> > +	unsigned long save_point =3D mas->index;
> > +
> > +retry:
> > +	node =3D mas_mn(mas);
> > +	type =3D mte_node_type(mas->node);
> > +	pivots =3D ma_pivots(node, type);
> > +	pivot =3D mas_safe_min(mas, pivots, mas->offset);
> > +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> > +		goto retry;
> > +
> > +	if (pivot <=3D min)
> > +		return NULL;
> > +
> > +	if (likely(mas->offset)) {
> > +		mas->offset--;
> > +		mas->last =3D mas->index - 1;
> > +	} else  {
> > +		if (mas_prev_node(mas, min)) {
> > +			mas_rewalk(mas, save_point);
> > +			goto retry;
> > +		}
> > +
> > +		if (mas_is_none(mas))
> > +			return NULL;
> > +
> > +		mas->last =3D mas->max;
> > +		node =3D mas_mn(mas);
> > +		type =3D mte_node_type(mas->node);
> > +		pivots =3D ma_pivots(node, type);
> > +	}
> > +
> > +	mas->index =3D mas_safe_min(mas, pivots, mas->offset);
> > +	slots =3D ma_slots(node, type);
> > +	entry =3D mas_slot(mas, slots, mas->offset);
> > +	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
> > +		goto retry;
> > +
> > +	return entry;
> > +}
> > +
> >   /*
> >    * mas_next_node() - Get the next node at the same level in the tree.
> >    * @mas: The maple state
> > @@ -4680,25 +4748,6 @@ static inline int mas_next_node(struct ma_state =
*mas, struct maple_node *node,
> >   	return 0;
> >   }
> > -static inline void mas_rewalk(struct ma_state *mas, unsigned long inde=
x)
> > -{
> > -retry:
> > -	mas_set(mas, index);
> > -	mas_state_walk(mas);
> > -	if (mas_is_start(mas))
> > -		goto retry;
> > -}
> > -
> > -static inline bool mas_rewalk_if_dead(struct ma_state *mas,
> > -		struct maple_node *node, const unsigned long index)
> > -{
> > -	if (unlikely(ma_dead_node(node))) {
> > -		mas_rewalk(mas, index);
> > -		return true;
> > -	}
> > -	return false;
> > -}
> > -
> >   /*
> >    * mas_next_slot() - Get the entry in the next slot
> >    *
> > @@ -4777,117 +4826,31 @@ static inline void *mas_next_entry(struct ma_s=
tate *mas, unsigned long limit)
> >   	if (mas->last >=3D limit)
> >   		return NULL;
> > -	entry =3D mas_next_slot_limit(mas, limit);
> > +	entry =3D mas_next_slot(mas, limit);
> >   	if (entry)
> >   		return entry;
> >   	if (mas_is_none(mas))
> >   		return NULL;
> > -	return mas_next_slot_limit(mas, limit);
> > -}
> > -
> > -/*
> > - * mas_prev_nentry() - Get the previous node entry.
> > - * @mas: The maple state.
> > - * @limit: The lower limit to check for a value.
> > - *
> > - * Return: the entry, %NULL otherwise.
> > - */
> > -static inline void *mas_prev_nentry(struct ma_state *mas, unsigned lon=
g limit,
> > -				    unsigned long index)
> > -{
> > -	unsigned long pivot, min;
> > -	unsigned char offset, count;
> > -	struct maple_node *mn;
> > -	enum maple_type mt;
> > -	unsigned long *pivots;
> > -	void __rcu **slots;
> > -	void *entry;
> > -
> > -retry:
> > -	if (!mas->offset)
> > -		return NULL;
> > -
> > -	mn =3D mas_mn(mas);
> > -	mt =3D mte_node_type(mas->node);
> > -	offset =3D mas->offset - 1;
> > -	slots =3D ma_slots(mn, mt);
> > -	pivots =3D ma_pivots(mn, mt);
> > -	count =3D ma_data_end(mn, mt, pivots, mas->max);
> > -	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> > -		goto retry;
> > -
> > -	offset =3D mas->offset - 1;
> > -	if (offset >=3D mt_slots[mt])
> > -		offset =3D mt_slots[mt] - 1;
> > -
> > -	if (offset >=3D count) {
> > -		pivot =3D mas->max;
> > -		offset =3D count;
> > -	} else {
> > -		pivot =3D pivots[offset];
> > -	}
> > -
> > -	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> > -		goto retry;
> > -
> > -	while (offset && !mas_slot(mas, slots, offset)) {
> > -		pivot =3D pivots[--offset];
> > -		if (pivot >=3D limit)
> > -			break;
> > -	}
> > -
> > -	/*
> > -	 * If the slot was null but we've shifted outside the limits, then se=
t
> > -	 * the range to the last NULL.
> > -	 */
> > -	if (unlikely((pivot < limit) && (offset < mas->offset)))
> > -		pivot =3D pivots[++offset];
> > -
> > -	min =3D mas_safe_min(mas, pivots, offset);
> > -	entry =3D mas_slot(mas, slots, offset);
> > -	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
> > -		goto retry;
> > -
> > -	mas->offset =3D offset;
> > -	mas->last =3D pivot;
> > -	mas->index =3D min;
> > -	return entry;
> > +	return mas_next_slot(mas, limit);
> >   }
> >   static inline void *mas_prev_entry(struct ma_state *mas, unsigned lon=
g min)
> >   {
> >   	void *entry;
> > -	struct maple_enode *prev_enode;
> > -	unsigned char prev_offset;
> >   	if (mas->index < min)
> >   		return NULL;
> > -retry:
> > -	prev_enode =3D mas->node;
> > -	prev_offset =3D mas->offset;
> > -	while (likely(!mas_is_none(mas))) {
> > -		entry =3D mas_prev_nentry(mas, min, mas->index);
> > -
> > -		if (likely(entry))
> > -			return entry;
> > -
> > -		if (unlikely(mas->index <=3D min))
> > -			return NULL;
> > -
> > -		if (unlikely(mas_prev_node(mas, min))) {
> > -			mas_rewalk(mas, mas->index);
> > -			goto retry;
> > -		}
> > +	entry =3D mas_prev_slot(mas, min);
> > +	if (entry)
> > +		return entry;
> > -		mas->offset++;
> > -	}
> > +	if (mas_is_none(mas))
> > +		return NULL;
> > -	mas->node =3D prev_enode;
> > -	mas->offset =3D prev_offset;
> > -	return NULL;
> > +	return mas_prev_slot(mas, min);
> >   }
> >   /*
