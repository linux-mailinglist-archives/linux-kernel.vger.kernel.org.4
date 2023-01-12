Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9DB6687D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjALX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjALX0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:26:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E011C271AA;
        Thu, 12 Jan 2023 15:26:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CNGfEQ027549;
        Thu, 12 Jan 2023 23:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7YWumTXKJiqwgfa/7b8nVtfCfD2fu6bHjckr5zpwG3o=;
 b=woYvV5d6iG5FOGsp04FLxnJrW7YsSxxD0TE3YpOjtgT+ZiX1ewnsBKjXs6N/njsHAKEi
 yd3xQs08gPJR5wUNS8/F1Ba0zd9yJ4BrotFMZ1AACL3eh4QwVYWOW3w9++DjfeUg3tuh
 OkaNWTqo50Yx6oJUDEseI3o++2AnPiN7HUYE0/uDbWX47NT4jad75stRymu+i64KnkUv
 xoZelAMIjdco2pIYqyAHwiyiDELSxftLkoDdm2ikTXiVBoPuKmCSO4cNF+3UhjPoXlAb
 pXRDlBRu0zgWf5kosqO05LtCn9kLlyp1bV8gUQnVaE0U6EVstreDDlPipfSvHmBuJJBM mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n27nragbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 23:25:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CLjkfm007494;
        Thu, 12 Jan 2023 23:25:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4cx37m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 23:25:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwWykYdA9Vm9n6oHyk0rwrnIzVvIFuOH8JwttLU7qh5bUw25B467BYaYPW0S7BHkhgMPDog7zHXI1SBvYT93JeCSkV0on4lmxLQcRjazrRhm/eSGLpSvR8OFPHS0tK7xowimohnPvyWSZqOu+rQmSfIkEXAZDPpKD/yittEOX9hZCemOVYRdrLWDrQ5t3r1G+XGKo1u6EqEt5xPTGgK6kzPEPFga2o5OikDO5iHxYa87PUgZEf7O3G3Z0Iil3sJ+DlxAd0PqK+VBpCzXn3OPlugX9AhJKEEOtzCzI7Nwdvm4VaCj/Buw3KEohGy2nyuZEB051AjYpddwxYoKpIQMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YWumTXKJiqwgfa/7b8nVtfCfD2fu6bHjckr5zpwG3o=;
 b=cgUbymmx+1GxSPZhJeZzVeWCF264JFlAT4VjwAIkaSD5HHNpi1JeaFAMbaRO6Shp9bIGB4tWBe+o0vLCh51ZqPIbktvpcMAHbIt/pCgDxr5IwYOwv+7h7LCQx6m+9UG76hwfVXOsHRzj6OTrN3VtL0POl5mHv9mpLRy/qSx60BbPVF41Xqca5yrLF9pa9wa4E+BwrpG3asip1I1NnN30FZKEXo1W6a0PmROi2YZBkn6kKsbq+KyMDmBwUTfUANPo2q60HyxOw7Hpuq3e/SNsRW+tW9WjQcPgFd0yzTG3B/yuI6WUmFTvgz+7FUco0b4f0SEHik066GtN+Vio4lDQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YWumTXKJiqwgfa/7b8nVtfCfD2fu6bHjckr5zpwG3o=;
 b=XPhqKhpdosnaE279ksobTPeig8qYwVGxkmHhrxeShMyJ+v8vWyfVtBbReMjfyWDS5OwhsiAb6AiSuGhkOcRNxj9JbbhdqZtvEqt++LGgFVs3yeEnt9YRqO50otp2NYMINippoGT4J9zL5Ml60QVOW4fjhAsK2VBsmXL+7FFUZNI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 23:25:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 23:25:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Thread-Topic: linux-next: duplicate patch in the nfsd tree
Thread-Index: AQHZJtuHjKaXgt/yjkWRrCUo/8ISo66bbLAA
Date:   Thu, 12 Jan 2023 23:25:49 +0000
Message-ID: <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
In-Reply-To: <20230113101326.09b1250e@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4371:EE_
x-ms-office365-filtering-correlation-id: bad585a3-f6ff-4bc5-be82-08daf4f4572a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVoWU3rZOEjwN1hivgcYbvpbm2jCQhSJsG3ax3l55ZzQR1qsOdLC1bXCUDb6UmJ5wW6hbE0BQ54Uz5dnm5wHd7TLZqGbcNlUFJrEvMkJ5ECk8mAMg8n2BVh4mMFMMmxFb0hSIfjKCSIQDyBmPbwiTmihq/grgnN+Wp19wlCB1ZI2az9hikCXGx513EiiKZHLtqAIXzyucsDgfRj5uQ4GOQD5VYisc4N1yeKI7F2m47pmNP2IPk/I131CebtRHU9TDDUV9pHbxUmj+PlTLra/cCYKkHKYoEFgioLMPyd0U/tH6+Oo2J8cZB+zy9k6ICMNLXRHHIkmg1+vD6mXKW3+mp66JRRf1mrQDxrhiqy1U6fyOQoxcK630mh2+/pgqGi+sZFu4V0NZ4tEKAnWtVmIixE6Wuca6b6PUu45ZRkZvJjfJwEXzHqIcK+CyVIoWCzJV56mYnoZvs9dwqijBZs5Rhr2mpeCHu8ywC1474E52F1WN2flqrJeDyJiYwn/bSqT2B7Us+hpYkhwctTAuMyP6gI6ZXX5sdLaL21RKhCiRE1/yq9YoXdhcecIbBYJVPoJc9r1M2/S7gpkw2k2ajlb/j8lq2U/qLkLm/cSKRVBNHSY2WaXihDyP0M99BCoDpneMwMiVGBT2cvVc6konQcfMEnXfg8ZSPeRSan7JQENXobg6xmH9a1FFsfa1o6oPwDicC83zuOF6bYeEWyiCRlAkDUjLde03lJGETW2tKUnRAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(6506007)(36756003)(186003)(26005)(6512007)(53546011)(6486002)(478600001)(71200400001)(38100700002)(122000001)(38070700005)(86362001)(2616005)(33656002)(4744005)(8936002)(5660300002)(2906002)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(8676002)(4326008)(6916009)(54906003)(91956017)(41300700001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L5eNnINYKIb6NiGpgdBaNb8GUAvinUAEz62JhOx5dUEkBJL6pf0s3AjpEpBG?=
 =?us-ascii?Q?eTS6nh0vDKQuqAVTWEn86l6xL0T5M1VQ42btUjO3w1GuTcpKXP6ICV/0dRno?=
 =?us-ascii?Q?5Vlv6I4hHZTdXn3ZKLUsUs1GhLfrnxR+o6uiPDdsTsZ/+cpkoGUVfsZIrw4z?=
 =?us-ascii?Q?OANrdgmPKIRBQf3GoDgOS1QDCbV/6YVU3DiIEAhABQQl60DjqOJKZf+BlIW2?=
 =?us-ascii?Q?cLMczD6Nsi8zwFv9bfAxD3KIzeMFr991xS5V/WM3fetOBz/2zaaijg5PdFjX?=
 =?us-ascii?Q?iXYZOoaDpPfgidAL1U3NFMxHdTXRWzNNr5AQKOeHsMQ9542FYdCVfaMKMf62?=
 =?us-ascii?Q?+zaJoSA9xMBwcrek5G9tduCMpVOxKpAxHwS/3g/9zGmTySYYAs4jkvM65Ja/?=
 =?us-ascii?Q?/BQo780tXPAleZ7HU5PvsuuprA+tEU+tG5PIQyuOXFtBFHAO/ijElJDk9ulO?=
 =?us-ascii?Q?zy6CzMBiq2ngPC2qYKKBzK/cmAdvR7ikY/WWDzubLCzr9EGa6DphbEzmBNTF?=
 =?us-ascii?Q?t4FQ8rDm8qzS4+lFvwnAilOgJSuqqrF+2jXgRGH1+nBNfsuKoRtMc0uMYIND?=
 =?us-ascii?Q?ZQZPNR5i1psY7qbICVUM5cCRLpl2IYoR7eaHynThtL+Gp9MN3Zbe1TlJ2yBK?=
 =?us-ascii?Q?nGelKnz/8YJPg5x/M429ICWYqp5JuW6lZoSyIySMghUHspc7iKXQH1xr29rD?=
 =?us-ascii?Q?VZPuno8O8lffJM6gKMBx+M4feAZndk9p3ho+uVYOEmxscleguiXAk4zS2MDB?=
 =?us-ascii?Q?TU7b/x4AF2LWgS46rP5x96eu+5FpO31E6SlPLi4s2zfd7+RvvF7CbHgTBJHw?=
 =?us-ascii?Q?XoaUrP0QJM1nEhGJxdyy471nrmmaOFEBKH8x8C+7X3xyynSDmfRY5q1I4fjv?=
 =?us-ascii?Q?22lOlPLNX9JZzexuHpICgBF44Pb11mgQ/zP5hOYqPyD0BE8W6t8jE7ZmX3uP?=
 =?us-ascii?Q?SC95I8I3N2jyyyMWW+a5z//ljM3GyxOyW2CN31h2M5/t/F0BQ/o32j700WI4?=
 =?us-ascii?Q?zQAKV4otri6DmWRw5IpHJaphD9N51TAz1jbZZUXKDQ/MSRPimk2bgahJKzYz?=
 =?us-ascii?Q?+XBQcYZqeRgQqAXeHAtklChrd/wnxtWW20C95V/FiBE6LltH3IayuVXyynuK?=
 =?us-ascii?Q?EumANOJwe2MCwcn8j0MC1qnCrAWdwSpRUZ+/TOaSGAiUYxrKN7qIhUuKarhE?=
 =?us-ascii?Q?I+IszobhaWO55TB2rHs/lUn8/xG5e5FqJg+eELCaz9sI5vLdaiuLkBpuuMjk?=
 =?us-ascii?Q?3p59AYiwmGefo6fvwwo4gN57KyEtvYX4q3ps8AvKKxG8IXQN/rKB58CmSNLv?=
 =?us-ascii?Q?NGNtvmFBnyW5tCy3GAQSrxn1ou9FFw4LUiz29R/+vX/d6rgu4bexB0DJm7xx?=
 =?us-ascii?Q?EBN+A1MKtFLPbCo9vX1V2QnXp+jB5OrCDWhGcOSdGS1cqM2w8jADrN+maPf8?=
 =?us-ascii?Q?tULR5LWTHhcUEyTwFNnFUpzvjA4ozv/CGwAW08ejD1sHG6KLA+gEiIPSLBp5?=
 =?us-ascii?Q?ukguc/aQgvVRPnHJx6y17r+AvIZscCmOKCYAqBOXvAUJfhWDEt5HJBSLENPD?=
 =?us-ascii?Q?r+qjXXA4wQ349uvbUfQxucl/byAmz0zKUUC561wnPnasiCS5ksYu0eBofb+Z?=
 =?us-ascii?Q?iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <388392A3FE20C54E969160EF2EA19946@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NPzpGvflVJYfI8zFK5khtwo78cNdXCpPR4NHTXfXzejUhW76mlcqAMpy+o9T6PPTP08x6zblZlmiX3PZ7cL3RXhKD/zeNQAuctiTUZRDYOWF65E/ckrYr2iWAuI0I9mBThpWYaX5JouOuxKleohFNxByt2ndf0vqgbw/hAZoq64vnR9Ry9ehSjBfwy2HYD0TgdihCaULc4Y18rTA3zh2wra/1SmE/CW2X3KI9ed4D3tXaSQBV/LRgyLzhnuGOzve6Jd6U8jqUYkHXvJTO0ss2v30ZpJgZUPUDjXInvM6qAMo8jxS27kn3J8fPdQ7OV7hh0K4cxpg08JM+XUgRmb8EzO4HF5Mg6zwJwnK99BJU1ljDYaQgFnARSN4CvGnFQvH7OvNovZ4LF2Wrf5F1lpkxbF4qMBBYcLfusz0SvI4koCmlssUbL5nt9FdcV4Xn4QAuRlr2pl5NJ7yEFAAKmIjGsg5RtUbl8YoLWaz7k2/E7ZLhTx3ATlIB5ZeiEJRWLPRDJl5SriYOgHE86xs/RZ586LSpr+Aq1vMhaAmGOq5M6pNRLRELfcxQFuUw0ZpgrYJfWhkH0iKciyNkl2VU6wl3s5Yovzd+ysv+4UMK/busRQKpGeOXa3Yfgx2MjACZ7ItBMwmP6y6m6ZfQ5lPTS4ACcq6fJm2ammKlcAPrDXnKXuO1mPLgkEOWXF2RtbXi4n0bIjempMmQOJzdN/eEueIp4Qd+eQg85gBd2mMAxPdTNmqW01EvJc8QOgcBtyET8eygDV/N3VUg0tDtPXrHQ6W9EMTpCXzJcshaarIQLpoa2iqF9bhyM7laeX64RWGYnrv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad585a3-f6ff-4bc5-be82-08daf4f4572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 23:25:49.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mu1qTOoZt6s6pjypvODEs1bu0zvCspBk1Fk0lK2Lx678Yc7PrtI+73tEnQL5eIRRSLcHoTjJ2LUq5CGPfMGF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120168
X-Proofpoint-GUID: Ke4Z-8izb28lYlJ4pTZQ5g0qqqANRWaV
X-Proofpoint-ORIG-GUID: Ke4Z-8izb28lYlJ4pTZQ5g0qqqANRWaV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 12, 2023, at 6:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi all,
>=20
> The following commit is also in cel-fixes tree as a different
> commit (but the same patch):
>=20
>  3927ac397479 ("NFSD: register/unregister of nfsd-client shrinker at nfsd=
 startup/shutdown time")
>=20
> (commit f385f7d24413 in the cel-fixes tree).

Once nfsd's for-rc is merged into upstream, I will rebase
nfsd's for-next and remove 3927ac397479. I intend to send
a PR for for-rc after it's been in linux-next for a few
days.

Unfortunately there is a later patch in for-next that
depends on 3927ac397479, so I can't remove it right at
the moment.


--
Chuck Lever



