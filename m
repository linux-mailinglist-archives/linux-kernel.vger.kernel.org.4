Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43863C58F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiK2Qr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiK2QrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A86C72C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOtVo013826;
        Tue, 29 Nov 2022 16:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H5O2qrKfVCu4WvkzldgsjO8M5umNjWJsGJwucEotnVU=;
 b=zuo2KyGALaQGjha/1bB3jxKBkhQMr4htKK1cPBy4aWg2CitOkk+brEKjX2kzoz19kb6x
 aQ5+aNzXsV5/r5FG3ire178ywR3NHTQOB7uJhF0q/1+GGNQtB0lYz7apC/ARmvjJeRah
 eLG3I4LneEINUdvsHc+K1z/SmEw0eH01l8cvOdsoXB6eL9G6Blwpxgjobl7fd2cJdGpD
 DamwxnxnFCh65uY27AB6l4H4yfqCGfc+I2f/W0gyEphni50I5gqQz0VI1So8XGwkdpkR
 piUfPonPCu+CvipeHhed7Tzizd55NaxG+jWKxeDyHaBgDqxGUmya6LqiseqcQZeRMhvs 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt7e5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaU3026698;
        Tue, 29 Nov 2022 16:45:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LldYVL8toIezzLSYS1IHG+cY+6yrWRn5ogIRHGoDen8SB3vRg4RQq0qRaeKuGhge4mL4oKl6cCuE89MHHBTqp9v8BzC5k+0u2EBUDqyskoImQRsFoXvc5wYFH0sb3Fake3WxazOtF+4tnepNdpLtlFZOCSu2qZ72LL/VlMt1S00gPbBhpQklMb1XoMQ7+7Mmg9tNna0b4uGunTkZyIcwkWOt7MWkWRSZJry2Ez9ddefCcBk7fehGYhsQUEc73qZwdY5KdnjHeiEljO7hJubyZ3AEREqdC7mNa5fLQ5EDEJJ+mKQUr6y2F4FrlXuVW7IRWy9pPQo/DW/J1jUQHvCc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5O2qrKfVCu4WvkzldgsjO8M5umNjWJsGJwucEotnVU=;
 b=PgDF6ZFh0o7fumk53ntFwrJZrP+ZXpn+Lre0u+4pE/GRYNnviGnor4/LiqF6kUgbe5PHb6kQul125WgbPa6TbcCpkNW++HuTbgpLJePW/PfAc9URC1e1KN8tGhh7qMVYI+WeY1iI/DBf7BCFrcVIuFJ7gaPNpqFAzGL5Yu1DOMP3zCmPtcX1Gqxq52A0eanc3XkhY8wyl4M3K1KOVzsAsCm5r25yvtGoKWHKzdUIAKXRLChqdIfruhpCXoM7sdgpdRcPkwaM4oataZRCcygPQQUCKGqFuAkJ/oaGPJIxMEZDLxamByQNENoxG5cLnNEVZ8qhrqsk1lXmU9w+9oJ2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5O2qrKfVCu4WvkzldgsjO8M5umNjWJsGJwucEotnVU=;
 b=WR8zHfI7LufY5SjR491A/z5kkyH72Lrw96oPuGYuQ5PMwTvXSFBGzS5BMOsxi6XYkfFNhLal84JV3e7DjEhYZxsp7hHQn++ZfmMKDBNN9AJEfQL6zeY30DDclH0DD4uiMJnwhj1R/rbk45FxIy2Sdzzz9+l9JSEXoj7vtxdggVo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 35/43] mm/mmap: Refactor locking out of __vma_adjust()
Thread-Topic: [PATCH 35/43] mm/mmap: Refactor locking out of __vma_adjust()
Thread-Index: AQHZBBHd2j6SeN81mEmcl3JrUDIEzA==
Date:   Tue, 29 Nov 2022 16:44:35 +0000
Message-ID: <20221129164352.3374638-36-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 15186eb2-4563-48c8-fbfa-08dad22913c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ra7HO3ofmphVm6yJxBp7tned6DW8VjPbrf3Km8KAn86o5m686Yy87FHV9Fgz/IdsSjIwPlw57lltbZdfojhLgJS6V3Osc+eG84n/wyXvDWeD7hz3vqV5eDPGx5kbt5l0BaubesxtOEFkdFDfoRlZKdE5BdkmC+/U0eGrqRNplUyHDV6AIhRWcqUy0cFLQ/4urW8jAhfmPrIgg//YcY8tzR7p4BbwAwH9ep6zH1dCvyWJVlUZAHKu58SPZgHNmQjyR/xAmmclw18Dp7pta+RScoqohlW9Ht7MXpD9f1CgVJY/HuQiISD3m1CMe9AkIp1uD+3FKFR8E9DtBAo26k9zwvjYdM58SizXl3EvP5QLwVBZ51J7ugncgDM6YI2qFd1YUx2Z2NpSEgfsC5+22X1FBFFkGZ+TNaNWhXYmMJoBd8kcNCvJ1yEWO6+4wM/2wnbD154dNN2p9LqLFiLMTNfZoAYpfSM8O2NbyLix5+ScHI4XR16ybDznYgnu/QTdqpQe6HwDjN0jPAupU3Qwl33ucCD+Z4UsDkoL53SwnkDs1nMKtUjTrXRsQ/EjGShL/cI2Wn0OqScJJ7WqAMBONgrERVedIsMLKiEvHfOdttJz+y9PRLfKTz9/HqcHtMTN6TtVZnaCF6bTzWPeWZ4ZQB1Q93S1ZbPo8QJu9DwXoMFd1nzyW1k7KuGV+i1Y1hn7AtCMYGMVMFkB7ZxzfLFIa3W5lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z8zDYfAEQt1D+9NMzeiKitBQ2F3KS1uRnzQLSGAJbsxYicS8+E1k7uMHiP?=
 =?iso-8859-1?Q?NjOa4OJBaKdVpB6lDLKgYVmfxZWwjQSHGoON4mlpowYo5Q+8gD/K4IG0bK?=
 =?iso-8859-1?Q?2m7PjZC1jpkqqpGHslwx7GYgu28MCSoKZIPgN7HQkBrE5bnYyofnOHZ80L?=
 =?iso-8859-1?Q?mqxTG5n8E3gPT6gGwORYgUDHKd4Xo7dbZK/zrp8HpAsNd/CktZHKMixufy?=
 =?iso-8859-1?Q?bfXzbgWAyzoeRu5CAJW8nfN3M6H45XsaB3kT/WV7HYMsc11ewPkbfJrahg?=
 =?iso-8859-1?Q?q9vQJdHzskJhFWwHN25NqyS9IVY4Wyh3jjMXdTxkJSghiev7sk/+KdShFs?=
 =?iso-8859-1?Q?y5pg2OFN+Mc/TRSvcmA9bS2r+/vLU/U/gmzpP+unHTOqtCap5E85vMtjVZ?=
 =?iso-8859-1?Q?8lyC9KV/pH4lpuXmsW2phU1FtMothh2SsVio7EtUvllXjapGhKIIe8gb25?=
 =?iso-8859-1?Q?uQx31aA9E6YITw/674nvVfcNJx4LKo7nLsRweP5ExqjWKTU4RYb+dJ5w9w?=
 =?iso-8859-1?Q?avhOXn+ozvnLzFCnHsTE1oZBWT6YoY7GKgR5yiS33ausAWGfz176d8EI7U?=
 =?iso-8859-1?Q?w4MF/rLsNt15p7SppPX40WhkNX1RYZJNltFLw8+xwJuplr+YnJuvCOgqMv?=
 =?iso-8859-1?Q?CwAS1WFCnCgz4i3fGxSEqXs0PCq1kKdhn9T3MZ9jyr6+lJV6WrjMM6MjY4?=
 =?iso-8859-1?Q?YvS/+EavT6VKamcXUVdMXjnlV90WX0QdQPKJdHrdkFD2PJbFp+NbAJPJvo?=
 =?iso-8859-1?Q?fNE1XPrzFsZfeJ3em1qWBt2uf82iTGk9xdcWRIh1t4kfqXMCbVzjamwbVn?=
 =?iso-8859-1?Q?5Vt1UWab2uRsOIChWaxp5dT4Nu/YlqaFja214lacqSAhT8oeFgtUaWV57L?=
 =?iso-8859-1?Q?Ms2mqDbAqi0946hYFWXhO8WAhVknwsjC7IJWyYjmkxsbJCoUt3KWou4Dcb?=
 =?iso-8859-1?Q?fD9fF5L9cK76xpv42OHp5dBthY7u9cw0nG9waSWzx+Z44nPa2f8Ue+vFa5?=
 =?iso-8859-1?Q?nxsfOOzpBSjZ9CJ+Qo0T7r5MlBgfPu+hmUdO7RCjZ+farfyt+dOjrQTd3H?=
 =?iso-8859-1?Q?Md7tSEPohpsG/xWMUJsu6dVDTvn1kiR2JPKiYXdthbGSd8L3K8hjaLqlb0?=
 =?iso-8859-1?Q?isIgDWM+UHBa//tWgeSRi0IUQ8ASHJFXojoMgxrUW8MAYJvDS4giYG3IQh?=
 =?iso-8859-1?Q?SzFT4UQjw8RrO5w9LbxR5vxIrBaGrk1LlVmLI6w5+82fwm9VonYNS636/w?=
 =?iso-8859-1?Q?ikTJcVU+30Zo0Tzj+B9Btfh54AMcP3C0vW71xJgHSBwfvbv1Fcwn5BBOmH?=
 =?iso-8859-1?Q?5rl1nPX+1p4uW/zgoso4w0npvru4PjEPhV5z4ab4QHT/hTD5gj9j/6OMbd?=
 =?iso-8859-1?Q?sk2Ekq1dUo1kjd2215JPrB9dBkI1e98vrjUR9h7Q3jmotQQpQ3AUvwORvx?=
 =?iso-8859-1?Q?ADyisZmnO1y0WUjxgPPTh3GmVoQ3rYjNGPGPvYJ0Fw2M5isbG7czoKr8Z9?=
 =?iso-8859-1?Q?wMTPpkBDnR0lBhFfUyVu4F4LVDuXQ+FTOKIGXWgokTgsQ4V/pEUrDT6Ylv?=
 =?iso-8859-1?Q?jKLvoC+8H3W3aHDtM/lY6ofmJE7l3qTzDCSrkCPQDTqBSO7gvHrOI3i4lB?=
 =?iso-8859-1?Q?l/fzytuIRTRQmdnF/Q/CmorFTS1owjWCFxU1Kc7eFCOeIEiYLEOeeFIw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uL9UtS9sYHVlciYW2jPxcMPmH9grfYilo+A+VmLf04oOXDyI1HcHwgId4UGL5rG2Nw0+/5eSbS5oJMW0FQmgvlAtLIa2marI77tSOzhnJRdc+FrKcbs9ZbcVS7/PHwp9CuvXFKQZUp6usNoQ8TkjgrdVMZwFReAIJ0TlUvRg1HkRfri4aOla1K51Z+/M+3cEXwmbsFeBPyMhHxCpyzwiVwCaV9GLV4aPeXtoxhzVh21FUBNNzDpl6CCtTZEO2QBiIjXzZ04xKDDsqqlH4+QZz0I0Dn5fh1xqCjex7VtjdN5sOM1EA45qEnRODKoMNl/rzahyF/ZLry5595gryYxGR0P8ClXvLKmBh0eumo3umHnrvETKA+MKMfzLgOfKufFuDuLm52f0NxgdCTUToTUI0SxhBjFcP5ME7mBj6OoH58Jj8bKqQKpb6v0uAp4ZlVWh2WrF4bQSvDBFtjN9SptVdis6tOnBdPcUfserEIEq+5XcY1gbRR9AUS26kocZLCEbRoreBYWFNEwmM75Q5bdm93hzfFxrKaciMjST2amrjBwE/QIQyQR9aBF+z7yv1rjQ7VNMEVIwLASpvGZxjTNa4Fnyg/gNt9rW7vU6KnFGUagS8PpMdPJcejAQq/YztVTC3HfGzptgUXYprlUj/6OoEPTULtjCW8tE+rYMaRB/jhzEci46w89NHtEnrrSQW05RTSQ6rSjtLK2lZVJdn78gTCltUVnCfk2+wYMD95JHE/8plxAnZOyVmI1BSxjAl4Z9qDBJERTxiSKgf0t3UMty01mIic+iQ8qWz85uDro7JM3ylyqbs0BSTvXj1hHzHSjtl6fsIc/PlQGY+fyJTxmxbm4NUwW0sTXf3NmhA9R+MMD4kARbqCKOMbvFDuuB9R/t6x/Tl4I7cupMwSy5LY2Xmg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15186eb2-4563-48c8-fbfa-08dad22913c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:35.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9Stvd48BqmWOBRBiVn4O2jkLDja4uXg7L3lvT3Fz5/vceys2zVZjRJgEfH3UqRdJDSnydvyiVAAtu+6yIA2fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=799 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: JznB5SdMNQLOnWg0qGAvF7VAPLRSnqoE
X-Proofpoint-GUID: JznB5SdMNQLOnWg0qGAvF7VAPLRSnqoE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move the locking into vma_prepare() and vma_complete() for use elsewhere

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  13 +++
 mm/mmap.c     | 231 +++++++++++++++++++++++++++++---------------------
 2 files changed, 149 insertions(+), 95 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 6b7ef495b56d..4dab33c2f3ed 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -856,4 +856,17 @@ static inline bool vma_soft_dirty_enabled(struct vm_ar=
ea_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
=20
+/*
+ * VMA lock generalization
+ */
+struct vma_prepare {
+	struct vm_area_struct *vma;
+	struct vm_area_struct *adj_next;
+	struct file *file;
+	struct address_space *mapping;
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *insert;
+	struct vm_area_struct *remove;
+	struct vm_area_struct *remove2;
+};
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 5b5d5d856152..c990a151e45c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -633,6 +633,127 @@ inline int vma_expand(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 	return -ENOMEM;
 }
=20
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
+ * @vp: The initialized vma_prepare struct
+ */
+static inline void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering=
 VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static inline void vma_complete(struct vma_prepare *vp,
+				struct vma_iterator *vmi, struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->file, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->file,
+						  vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we must remove next_next too.
+		 */
+		if (vp->remove2) {
+			vp->remove =3D vp->remove2;
+			vp->remove2 =3D NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -648,14 +769,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
 	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma =3D vma;
-	struct address_space *mapping =3D NULL;
-	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	struct vma_prepare vma_prep;
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -751,39 +871,22 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 			   anon_vma !=3D next->anon_vma);
=20
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-	if (file) {
-		mapping =3D file->f_mapping;
-		root =3D &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-
-		if (adjust_next)
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-
-		i_mmap_lock_write(mapping);
-		if (insert && insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(insert, insert->vm_file->f_mapping);
-		}
-	}
=20
-	if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_pre_update_vma(next);
+	memset(&vma_prep, 0, sizeof(vma_prep));
+	vma_prep.vma =3D vma;
+	vma_prep.anon_vma =3D anon_vma;
+	vma_prep.file =3D file;
+	if (adjust_next)
+		vma_prep.adj_next =3D next;
+	if (file)
+		vma_prep.mapping =3D file->f_mapping;
+	vma_prep.insert =3D insert;
+	if (remove_next) {
+		vma_prep.remove =3D next;
+		vma_prep.remove2 =3D next_next;
 	}
=20
-	if (file) {
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_remove(vma, root);
-		if (adjust_next)
-			vma_interval_tree_remove(next, root);
-	}
+	vma_prepare(&vma_prep);
=20
 	if (start !=3D vma->vm_start) {
 		if (vma->vm_start < start) {
@@ -821,69 +924,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 		vma_iter_store(vmi, next);
 	}
=20
-	if (file) {
-		if (adjust_next)
-			vma_interval_tree_insert(next, root);
-		vma_interval_tree_insert(vma, root);
-		flush_dcache_mmap_unlock(mapping);
-	}
-
-	if (remove_next && file) {
-		__remove_shared_vm_struct(next, file, mapping);
-		if (remove_next =3D=3D 2)
-			__remove_shared_vm_struct(next_next, file, mapping);
-	} else if (insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, insert);
-		mm->map_count++;
-	}
-
-	if (anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		if (adjust_next)
-			anon_vma_interval_tree_post_update_vma(next);
-		anon_vma_unlock_write(anon_vma);
-	}
-
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-
-		if (adjust_next)
-			uprobe_mmap(next);
-	}
-
-	if (remove_next) {
-again:
-		if (file) {
-			uprobe_munmap(next, next->vm_start, next->vm_end);
-			fput(file);
-		}
-		if (next->anon_vma)
-			anon_vma_merge(vma, next);
-		mm->map_count--;
-		mpol_put(vma_policy(next));
-		if (remove_next !=3D 2)
-			BUG_ON(vma->vm_end < next->vm_end);
-		vm_area_free(next);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
-		 */
-		if (remove_next =3D=3D 2) {
-			remove_next =3D 1;
-			next =3D next_next;
-			goto again;
-		}
-	}
-	if (insert && file)
-		uprobe_mmap(insert);
-
+	vma_complete(&vma_prep, vmi, mm);
 	vma_iter_free(vmi);
 	validate_mm(mm);
=20
--=20
2.35.1
