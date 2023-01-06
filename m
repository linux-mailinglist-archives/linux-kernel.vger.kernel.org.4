Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC68660672
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjAFShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjAFSgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:36:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D877DE3F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:36:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306H20OY006430;
        Fri, 6 Jan 2023 18:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tCpwVg9M0mUsjwvTdhOVZLOjtsFTyuT5qZ83U/YXb0c=;
 b=YXYvbG6GHNtoR7DUDg8WxqO/F7Pr7QmBCgcqaZkRWjz0mYo7B5ECJNNKLc2GdNljpZf9
 g22Xd9MKvC5Ly7pXxtS3Gk1er+uaK0sEdj29fjSVLdNrenIigx7rgENVbWHhjXGg8sV7
 zQlMrHACAuVbyOQXsBOjiVlw+OtnNMLeffb1L3/heTrJoW0Wh9GG97t7ACVXDhaWJePM
 SS5NRnXUSHEk+hTefay1JrVPQPquNfXZs4XT2CteXrKQ0sC0JeTp5MJfBQ8pAHRb4ScY
 M7y0BRjjx0oFYK0hSgvdBYMjZNF+m0MTy88IxpSZwzkEA1tt1A5oFPkgNVhPntJQBiSE /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgquqqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 18:36:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306ISVsK021054;
        Fri, 6 Jan 2023 18:36:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevm7109-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 18:36:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElFEcx4mlPI06gesPLS35JBfV9lzae01RwMVQ4FZ3iiKv1o71NFIOwT1XDs0umcBGjgRifodZXzjEcBTO0H30J6bEUkICeqKLs7l/6kDuuKx/FoW1JHpgsLN7Zdr4Z1+G7/RZp5a+vt63+ONis2AVY2wlOKk4DdcddbdKvTm3hMlqJDTSDJ0yUd9cewkrGaz0wkclCHwFDcyqyYdkcOWWWoWLAZKcU5uUUdJaNd1VFjt0RTuAnke98vK0NvWc7gJ9in8leUghTXhBvYVBKMLw+Bz3G5D5VcK/jlpPvuh399+Qmmm8Wf0F9f245Z+efmaRjle4QFLjzGNk3/qFqZqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCpwVg9M0mUsjwvTdhOVZLOjtsFTyuT5qZ83U/YXb0c=;
 b=M06mpSsYm7vQ1UveX25TUN5GNgT8CB1XkEwGefH1Lp99iePKry5SBTkzebrnvvp2o9FD6rbHyg4JGLHkNe2CN/yi94C4fYpi3Ll6xcEiQ5G6Srg3ox4lHZpTHxXa/IO9UMNpru4MmesnaI1Z0bO3ahNbJ/+yfl77wDxU/7DYcGV4Jivns/jhK8YV45zIRjmBngJDjZzWbDHlf8CgEtNJIOmIo4XdB39QzDS+RHqRO27Uh3W+x4DYdl4xT1w2EV7Uv07A7i8qB8z7LNXJdTf99BGV3iKpW7Ju0aasKzqfw7/VKLsvy053NWftR8rbHOFfQiwnqX++uL2ju9S2LCFVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCpwVg9M0mUsjwvTdhOVZLOjtsFTyuT5qZ83U/YXb0c=;
 b=aWwlnJ9n1u5fgEzrRR3H9+Tz/duiO4bFXpRljhz7+J/wjmx+W1Dw6di5LwUy5D5Z5BeKIqbZ3kie+5nbweKOVER03heVfJxRDhjEf8gMTEC9kCUAOIjI9a98zkYqW5wnkXSRi9NswR2dVc2Ij4LsBDLBFW+oEMpjphFpyZvcOVE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4663.namprd10.prod.outlook.com (2603:10b6:510:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 18:36:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 18:36:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Thread-Topic: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Thread-Index: AQHZIR+LoHdY1LXO4kqyIytgW9FJP66Q/rmAgAC6eIA=
Date:   Fri, 6 Jan 2023 18:36:07 +0000
Message-ID: <20230106183559.mpdywid4szzpghlk@revolver>
References: <20230105160427.2988454-1-Liam.Howlett@oracle.com>
 <Y7fNo4IElYXCyPmd@kernel.org>
In-Reply-To: <Y7fNo4IElYXCyPmd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4663:EE_
x-ms-office365-filtering-correlation-id: 31af13a5-1547-4c20-1d2d-08daf014e01e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: brWlkL+QWUTyXDw8mldNOKP+3dgzI9Ht+Z2SmBd+0TGs6zh6XaL6Vou5S9NqaaZaM/o48gpqsNCvsCqoTuud6BcOc5/uNXjmySFn1BTa+Gy8tjHTt6roCvTTBe4OFSTuutW0p1GyyiqHJEcMRYba0BcipyCkS2gd9LIIPq0itwgqn66AqJTv7oEWAXDUAywG0ccGIloEtU+GthqNGc/z2aaQPV68mqZCoh54/DPFFv7nx6MHrfyEi3NQq/bo0a4cCpENKAPw4NvkWI721aU6l9Dh/Kn77RNWZwU7inFYQjHnyLaDQAElXe5QkDZUuokmcY2m6UQuwkSR+Y3oGa9acobmu/KvekDHzjyzRLtv5Ifa8oyvGr0H95MWus5Xdd5Y0IGJGtCeOhC3zF2AnOMrH9vjig3xZFzm1BxTxkokQNowqvx29doRE5pZ4L3rufPdoxUZr05hfvd7V2oFiMuZ4sxES8AeTbOpEVbRRuFuMpjzK23+zKfbn92SVGqsNLH9DeKdOS7nK2iswviaQp0VdFGaqyuA36zRW2zNlmNpZ1+quymZyOPM8spqOTSb05mlbVuwLoRBwd2L4NcIqaigG0w9l4PA0HVF8V+slILCAACpDbRCS6DPXhldqepjvm9+7Zm+JLUUtXP6zcqlForCv3yoqMW09oY3uxM4N1ZGLXPug4Sw0GhFVvv2w/huBlwjTMTPYQd/zknAyujvzh0T5rOXgop1AH0JUZUx9bf/zAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(9686003)(6512007)(54906003)(6916009)(71200400001)(26005)(316002)(186003)(8676002)(966005)(1076003)(91956017)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(4326008)(6486002)(478600001)(38100700002)(6506007)(41300700001)(83380400001)(5660300002)(8936002)(2906002)(44832011)(30864003)(122000001)(33716001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHoLsjc+y1GUuxhtXGbb/61NbOJgmaSFctSqzD9nAa0ercCmVrFgFCOsjmEZ?=
 =?us-ascii?Q?IJlbHvbgqScfM5iBaQHSXfq0/wLBZ2tiMpteTgcWOU0XTi2RD5g8Q2Xqkc6i?=
 =?us-ascii?Q?DOHRhpUFes5mKNoGeugmmvJJuI4pnmh6/eZHdtBsa/Ol56STu+vzcIk85Ctz?=
 =?us-ascii?Q?tyEINXCiK7pSN2g5o+OWVqt15RPi+tcnYWCeCIhaKziK4XoBLjDKTZiOdnNg?=
 =?us-ascii?Q?a9OJtmFJIHVPG0y7H8fm4EbcMxwdytXce1bB3vtGCnzHzlNXaZD2N6vvvGIy?=
 =?us-ascii?Q?NAiZZQ5mjyb9xPBC8b5VMPoydwSdomvIHhl2c+4/KYg376B02xXbtXws1h9E?=
 =?us-ascii?Q?T3rZ0QobJeseeAaPQxRL2izmgjRFYCdQlE701vQUC3Txl7xkDlrMbgK8wDXc?=
 =?us-ascii?Q?s7pO43PjC084WJLCMpKuchK2c7ozqMUKck1NW2zUbedKY3XILCNkm3Vyd7Di?=
 =?us-ascii?Q?v1HHMnnHJ5ssM1XBDAy+o0ho3L5YUh12edyvnUBeXoVdZvIlBKJ2x6JgE5Dc?=
 =?us-ascii?Q?X6lKFJ941YhXGkVfntls6Wt2voJycUs2QsVeHLQF84PW1kM+NheCkleSt70y?=
 =?us-ascii?Q?LGtK5LsUr+Inh6GP5tCBDTfKL3OARiEheILvNP+hG+8Mj2qrfV95OjonPOZy?=
 =?us-ascii?Q?4/ZiYJ/AFAK3RHC+0vqM4QLa5J70mgCjyNTwb/HSQiPLu+4ebjjBT19sBfDD?=
 =?us-ascii?Q?pgsRXEbp1ZWzlnIit0TN7a5xuzDGI8Y5D3vmB3eYZ8H09pDdJ6VqVaz4Yoin?=
 =?us-ascii?Q?rhOnTocS0rDKvzD+fuwgzuZDVEovqjjGwSoxhETeO5hYYapBBrp6T8I4bvAm?=
 =?us-ascii?Q?/dayo69Ev3TjuhBbTxif4vr7j6m2fUXkbohzEBgwA1kWyVrkBzeiqTgc0ckb?=
 =?us-ascii?Q?TEYNS7KEVGfMwjFo3WvmKn0FN2cP2+GG1Q76fBpe8PuCXl/oyUg118ogRHbL?=
 =?us-ascii?Q?BFgQXugw8U8VM2NnwvlbKI2x0DclcbfZWmE+eR/4xAQiNvLX5CIZoDCJO61i?=
 =?us-ascii?Q?AoTPQorhhyi2AhY5rDlx8TZ4SdrjCqbj7oJPywc/bzb4gEaORLM+qxSra+Xp?=
 =?us-ascii?Q?zOd2cqUhUHiOxAhKpAmZEo0wmotD3P0Raj0Y7ZxFgbJoMUO8GghFtS+xRYe8?=
 =?us-ascii?Q?71M5KTcvS6o7sGIglwlDoHp0wXrQsD4PI8M9ewgF8IFQUjwETepEtUOtJkb7?=
 =?us-ascii?Q?kw87UfQ4V3oEKujJco+FRrVdyc6XcpJ7BegR0aty1iRs3gkL0/GRJvxbTmFC?=
 =?us-ascii?Q?OR2hxbqouJGjTLkRgHrt/9TSrrSavEsT8MKcLfsdgCag9KtDf7Y6XoC5RCxz?=
 =?us-ascii?Q?6qSoDjexLU3F37fb99hM88+NIJcDsEXY6vmqdEjiUm+CyREiHpxGeOrKUvIY?=
 =?us-ascii?Q?KKr1+ofjhw9AdWTafcOmLULV/AbB322VQNBcH2m0Uhn1BHrDf1m5cu7m8yoz?=
 =?us-ascii?Q?HZy2zShkp10RtlW0CpfDKqegCq1BZ6+F1FZeB/mmSdBYKr2qkBRXTCTcBdhI?=
 =?us-ascii?Q?hzczQgpD2+dAMWDOoDy1Y2bL32OE6/iGQVlzzp+7ePcFT3E9NlfMx1/Q91Aj?=
 =?us-ascii?Q?41iTjgKdd+/9Ye93TPFSOwc+CeyuTVu+MDA6Bu4RZef9XXhUGp5Act2Pgabr?=
 =?us-ascii?Q?0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02B95E45E9534445A78E353EC0673116@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3U4oWGmSfD2fomGH6EYViKmwYa93rZsncJ4cyC9EnorlNrrxm1NcfbIQ0+xA?=
 =?us-ascii?Q?ukI+0k3c/ESyUsArWggyE/hxETZGsmzcJHyzzTsdwua4/pkHM469P+DhsrcZ?=
 =?us-ascii?Q?q4zml8xwL52J3o3dEE5itKsxKxbcFDEJaaYjVStp/MCrnwXdjsSJfZOoo+0/?=
 =?us-ascii?Q?Gv+CKW/gYLahCodc3wPgGB50ESM4ZWT2OIXQUkaaV/6d7SFMN4/teq1dtIoZ?=
 =?us-ascii?Q?6CKlDCHYWTNXQ/sdnhdwVlvxmjWCuJIe1pundksTEMqelXp2uCEvTCRK/tQ6?=
 =?us-ascii?Q?n4QmXd4FZ9Q7vdSFSE39Xza8/f6wRNzZ9CHc0ihqmSgh5P4sl28m5nFBPN4B?=
 =?us-ascii?Q?y/xv5Bw/D0NIjVMSy71lNlMbJ5gHsyrVAeB8bzjC1tZxrdc1MymZde+/73/J?=
 =?us-ascii?Q?LQnSwOEpET1jJiCOpT5fSFgYyQswuAMVTfxtu/96gcwqmE6c4LNO6oz9qoEz?=
 =?us-ascii?Q?hjl4kCqbU5c15aLWIN19tr//seBxNcM+jvTL6VP/220Ynru0WduSCEDbsyZ4?=
 =?us-ascii?Q?rr1o7crTz/antCObqBFihtmrd2z1j9TvW8pjwRTqIvnK/CVyxh/SKc93Geq4?=
 =?us-ascii?Q?HDXE0ruoxsh6K53NSxyV3mIZsfoUH2fwOIVdW322ALUzn6gb0rsPS18q48Ph?=
 =?us-ascii?Q?2LCRfXsGBc4gI8JjTKZ3bQmtlSntuidGUieP9DdSqyVMB5fDlfj6GR8K4YoZ?=
 =?us-ascii?Q?BNr2feXR0W0aRbYSgHwRbwZ/WfiSB5rgfpTkzbXq7cQ/niSTm9BRZO64uwjq?=
 =?us-ascii?Q?tQe82BWDrytxexue4yY/o6IycgGssE4LgVX/h9ed1j9qDSPmW5MWd7dCL8ds?=
 =?us-ascii?Q?S60CY75KMw/PDkkbAC4HpjfVJzGUPYILc8uRN17BaFP5X4MbkqETX6kanqwo?=
 =?us-ascii?Q?3s7vCkDwJMQcyPkGbPsF6snQwIyhExPmPxTjCh7WJZuLBWutuT5qlD9t+GF1?=
 =?us-ascii?Q?8BAgNZgGA3QhSsHhV7J7vy3IX/QlAkGEkXKeZICrNKU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31af13a5-1547-4c20-1d2d-08daf014e01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 18:36:07.5959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDwLsVPzkVPAiAin6k6h5fj07/4boAY/smYy0QQEs51HeP23T1WlC7Gn5MBfSnHRvtGpfKJEEV0TUq3fWJ5MpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_12,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060143
X-Proofpoint-GUID: e8qDCwlWhrnuIsv9nRCBNBn79m0gUvWr
X-Proofpoint-ORIG-GUID: e8qDCwlWhrnuIsv9nRCBNBn79m0gUvWr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Rapoport <rppt@kernel.org> [230106 02:28]:
> On Thu, Jan 05, 2023 at 04:05:34PM +0000, Liam Howlett wrote:
> > Preallocations are common in the VMA code to avoid allocating under
> > certain locking conditions.  The preallocations must also cover the
> > worst-case scenario.  Removing the GFP_ZERO flag from the
> > kmem_cache_alloc() (and bulk variant) calls will reduce the amount of
> > time spent zeroing memory that may not be used.  Only zero out the
> > necessary area to keep track of the allocations in the maple state.
> > Zero the entire node prior to using it in the tree.
> >=20
> > This required internal changes to node counting on allocation, so the
> > test code is also updated.
> >=20
> > This restores some micro-benchmark performance:
> > up to +9% in mmtests mmap1 by my testing
> > +10% to +20% in mmap, mmapaddr, mmapmany tests reported by Red Hat
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2149636
> > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
> > ---
> >  lib/maple_tree.c                 | 80 +++++++++++++++++---------------
> >  tools/testing/radix-tree/maple.c | 18 +++----
> >  2 files changed, 52 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 26e2045d3cda..82a8121fe49b 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -149,13 +149,12 @@ struct maple_subtree_state {
> >  /* Functions */
> >  static inline struct maple_node *mt_alloc_one(gfp_t gfp)
> >  {
> > -	return kmem_cache_alloc(maple_node_cache, gfp | __GFP_ZERO);
> > +	return kmem_cache_alloc(maple_node_cache, gfp);
> >  }
> > =20
> >  static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
> >  {
> > -	return kmem_cache_alloc_bulk(maple_node_cache, gfp | __GFP_ZERO, size=
,
> > -				     nodes);
> > +	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
> >  }
> > =20
> >  static inline void mt_free_bulk(size_t size, void __rcu **nodes)
> > @@ -1127,9 +1126,10 @@ static inline struct maple_node *mas_pop_node(st=
ruct ma_state *mas)
> >  {
> >  	struct maple_alloc *ret, *node =3D mas->alloc;
> >  	unsigned long total =3D mas_allocated(mas);
> > +	unsigned int req =3D mas_alloc_req(mas);
> > =20
> >  	/* nothing or a request pending. */
> > -	if (unlikely(!total))
> > +	if (WARN_ON(!total))
>=20
> Hmm, isn't WARN_ON() here too much?

I don't think so.  If we get to the point of asking for a node while we
don't have any to give, then it's too late.  It means we (I) have
calculated the necessary nodes incorrectly and we won't have enough
memory to fit things into the tree.  It should never happen.

>=20
> >  		return NULL;
> > =20
> >  	if (total =3D=3D 1) {
> > @@ -1139,27 +1139,25 @@ static inline struct maple_node *mas_pop_node(s=
truct ma_state *mas)
> >  		goto single_node;
> >  	}
> > =20
> > -	if (!node->node_count) {
> > +	if (node->node_count =3D=3D 1) {
> >  		/* Single allocation in this node. */
> >  		mas->alloc =3D node->slot[0];
> > -		node->slot[0] =3D NULL;
> >  		mas->alloc->total =3D node->total - 1;
> >  		ret =3D node;
> >  		goto new_head;
> >  	}
> > -
> >  	node->total--;
> > -	ret =3D node->slot[node->node_count];
> > -	node->slot[node->node_count--] =3D NULL;
> > +	ret =3D node->slot[--node->node_count];
> > +	node->slot[node->node_count] =3D NULL;
> > =20
> >  single_node:
> >  new_head:
> > -	ret->total =3D 0;
> > -	ret->node_count =3D 0;
> > -	if (ret->request_count) {
> > -		mas_set_alloc_req(mas, ret->request_count + 1);
> > -		ret->request_count =3D 0;
> > +	if (req) {
> > +		req++;
> > +		mas_set_alloc_req(mas, req);
> >  	}
> > +
> > +	memset(ret, 0, sizeof(*ret));
> >  	return (struct maple_node *)ret;
> >  }
> > =20
> > @@ -1178,21 +1176,20 @@ static inline void mas_push_node(struct ma_stat=
e *mas, struct maple_node *used)
> >  	unsigned long count;
> >  	unsigned int requested =3D mas_alloc_req(mas);
> > =20
> > -	memset(reuse, 0, sizeof(*reuse));
> >  	count =3D mas_allocated(mas);
> > =20
> > -	if (count && (head->node_count < MAPLE_ALLOC_SLOTS - 1)) {
> > -		if (head->slot[0])
> > -			head->node_count++;
> > -		head->slot[head->node_count] =3D reuse;
> > +	reuse->request_count =3D 0;
> > +	reuse->node_count =3D 0;
> > +	if (count && (head->node_count < MAPLE_ALLOC_SLOTS)) {
> > +		head->slot[head->node_count++] =3D reuse;
> >  		head->total++;
> >  		goto done;
> >  	}
> > =20
> >  	reuse->total =3D 1;
> >  	if ((head) && !((unsigned long)head & 0x1)) {
> > -		head->request_count =3D 0;
> >  		reuse->slot[0] =3D head;
> > +		reuse->node_count =3D 1;
> >  		reuse->total +=3D head->total;
> >  	}
> > =20
> > @@ -1211,7 +1208,6 @@ static inline void mas_alloc_nodes(struct ma_stat=
e *mas, gfp_t gfp)
> >  {
> >  	struct maple_alloc *node;
> >  	unsigned long allocated =3D mas_allocated(mas);
> > -	unsigned long success =3D allocated;
> >  	unsigned int requested =3D mas_alloc_req(mas);
> >  	unsigned int count;
> >  	void **slots =3D NULL;
> > @@ -1227,24 +1223,29 @@ static inline void mas_alloc_nodes(struct ma_st=
ate *mas, gfp_t gfp)
> >  		WARN_ON(!allocated);
> >  	}
> > =20
> > -	if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS - 1=
) {
> > +	if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS) {
> >  		node =3D (struct maple_alloc *)mt_alloc_one(gfp);
> >  		if (!node)
> >  			goto nomem_one;
> > =20
> > -		if (allocated)
> > +		if (allocated) {
> >  			node->slot[0] =3D mas->alloc;
> > +			node->node_count =3D 1;
> > +		} else {
> > +			node->node_count =3D 0;
> > +		}
> > =20
> > -		success++;
> >  		mas->alloc =3D node;
> > +		node->total =3D ++allocated;
> >  		requested--;
> >  	}
> > =20
> >  	node =3D mas->alloc;
> > +	node->request_count =3D 0;
> >  	while (requested) {
> >  		max_req =3D MAPLE_ALLOC_SLOTS;
> > -		if (node->slot[0]) {
> > -			unsigned int offset =3D node->node_count + 1;
> > +		if (node->node_count) {
> > +			unsigned int offset =3D node->node_count;
> > =20
> >  			slots =3D (void **)&node->slot[offset];
> >  			max_req -=3D offset;
> > @@ -1258,15 +1259,13 @@ static inline void mas_alloc_nodes(struct ma_st=
ate *mas, gfp_t gfp)
> >  			goto nomem_bulk;
> > =20
> >  		node->node_count +=3D count;
> > -		/* zero indexed. */
> > -		if (slots =3D=3D (void **)&node->slot)
> > -			node->node_count--;
> > -
> > -		success +=3D count;
> > +		allocated +=3D count;
> >  		node =3D node->slot[0];
> > +		node->node_count =3D 0;
> > +		node->request_count =3D 0;
> >  		requested -=3D count;
> >  	}
> > -	mas->alloc->total =3D success;
> > +	mas->alloc->total =3D allocated;
> >  	return;
> > =20
> >  nomem_bulk:
> > @@ -1275,7 +1274,7 @@ static inline void mas_alloc_nodes(struct ma_stat=
e *mas, gfp_t gfp)
> >  nomem_one:
> >  	mas_set_alloc_req(mas, requested);
> >  	if (mas->alloc && !(((unsigned long)mas->alloc & 0x1)))
> > -		mas->alloc->total =3D success;
> > +		mas->alloc->total =3D allocated;
> >  	mas_set_err(mas, -ENOMEM);
> >  	return;
> > =20
> > @@ -5745,6 +5744,7 @@ int mas_preallocate(struct ma_state *mas, void *e=
ntry, gfp_t gfp)
> >  void mas_destroy(struct ma_state *mas)
> >  {
> >  	struct maple_alloc *node;
> > +	unsigned long total;
> > =20
> >  	/*
> >  	 * When using mas_for_each() to insert an expected number of elements=
,
> > @@ -5767,14 +5767,20 @@ void mas_destroy(struct ma_state *mas)
> >  	}
> >  	mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);
> > =20
> > -	while (mas->alloc && !((unsigned long)mas->alloc & 0x1)) {
> > +	total =3D mas_allocated(mas);
> > +	while (total) {
> >  		node =3D mas->alloc;
> >  		mas->alloc =3D node->slot[0];
> > -		if (node->node_count > 0)
> > -			mt_free_bulk(node->node_count,
> > -				     (void __rcu **)&node->slot[1]);
> > +		if (node->node_count > 1) {
> > +			size_t count =3D node->node_count - 1;
> > +
> > +			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
> > +			total -=3D count;
> > +		}
> >  		kmem_cache_free(maple_node_cache, node);
> > +		total--;
> >  	}
> > +
> >  	mas->alloc =3D NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(mas_destroy);
> > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tre=
e/maple.c
> > index 81fa7ec2e66a..1f36bc1c5d36 100644
> > --- a/tools/testing/radix-tree/maple.c
> > +++ b/tools/testing/radix-tree/maple.c
> > @@ -173,11 +173,11 @@ static noinline void check_new_node(struct maple_=
tree *mt)
> > =20
> >  		if (!MAPLE_32BIT) {
> >  			if (i >=3D 35)
> > -				e =3D i - 35;
> > +				e =3D i - 34;
> >  			else if (i >=3D 5)
> > -				e =3D i - 5;
> > +				e =3D i - 4;
> >  			else if (i >=3D 2)
> > -				e =3D i - 2;
> > +				e =3D i - 1;
> >  		} else {
> >  			if (i >=3D 4)
> >  				e =3D i - 4;
> > @@ -305,17 +305,17 @@ static noinline void check_new_node(struct maple_=
tree *mt)
> >  	MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
> >  	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> >  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> > -	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
> > +	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS);
> > =20
> >  	mn =3D mas_pop_node(&mas); /* get the next node. */
> >  	MT_BUG_ON(mt, mn =3D=3D NULL);
> >  	MT_BUG_ON(mt, not_empty(mn));
> >  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS);
> > -	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 2);
> > +	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
> > =20
> >  	mas_push_node(&mas, mn);
> >  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> > -	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
> > +	MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS);
> > =20
> >  	/* Check the limit of pop/push/pop */
> >  	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 2); /* Request */
> > @@ -323,14 +323,14 @@ static noinline void check_new_node(struct maple_=
tree *mt)
> >  	MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
> >  	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> >  	MT_BUG_ON(mt, mas_alloc_req(&mas));
> > -	MT_BUG_ON(mt, mas.alloc->node_count);
> > +	MT_BUG_ON(mt, mas.alloc->node_count !=3D 1);
> >  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 2);
> >  	mn =3D mas_pop_node(&mas);
> >  	MT_BUG_ON(mt, not_empty(mn));
> >  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> > -	MT_BUG_ON(mt, mas.alloc->node_count  !=3D MAPLE_ALLOC_SLOTS - 1);
> > +	MT_BUG_ON(mt, mas.alloc->node_count  !=3D MAPLE_ALLOC_SLOTS);
> >  	mas_push_node(&mas, mn);
> > -	MT_BUG_ON(mt, mas.alloc->node_count);
> > +	MT_BUG_ON(mt, mas.alloc->node_count !=3D 1);
> >  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 2);
> >  	mn =3D mas_pop_node(&mas);
> >  	MT_BUG_ON(mt, not_empty(mn));
> > --=20
> > 2.35.1
> >=20
>=20
> --=20
> Sincerely yours,
> Mike.=
