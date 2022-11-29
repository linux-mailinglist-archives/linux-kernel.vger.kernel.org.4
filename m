Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95263C564
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiK2Qof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiK2Qob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25074218E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP2cK031397;
        Tue, 29 Nov 2022 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=aHOdDKavLloGafgH93hTJTglrGPWzuruOY+ChiztX/GHyKgJr94YDF3D3ZGKsZWBOv/d
 r091ChYYyrI0mGwOFol35+2WGt69z2dc3LFSBrOSBo+Ui2TwZbgVXDKkbZD2VCwIuGq9
 ShGrj7y9a6R3Olh+tVqYrVhmet1xeKXWbQEYGnFH+N7GpVP3cFZKtl/d+drxNb07sfDw
 WnbM12uFuARg/EvrR45qKdQdaYrhvInawwiEowWOhkj1Bx3txGCpM3Q2d7z/vHVk0AD1
 o8gkoA8wMoVZa6PeNLMdOeii+woRg42JsMhcLPBkQyuhvqz6kgDq1YWIU8N7zSb5RHAp ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xar0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBT030968;
        Tue, 29 Nov 2022 16:44:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7oyOZ38OnMNuHPSushC5gKhoAbmurjMIEq+LmOKlhwPT55KlsONZxiQLz8LcVetx8/PyOEINjpraQrsZ9EsJmwRqb2moYlFOSJPWabynJmpz5ApvF0na8KmSlCZs2ZoPilTar0z7NQXfqkXWANfWLneQ4Z7tIV3z9WQgOU8WGno6g0U9JL/DmVxrU9jPTPFt6s0gHO5QX3PfaVJiFtFyg8is0R1Dx/Rld0hbqkwg0A6/F/wS+zWRm0GmpyGzoeBcPnsoQo3t1luuG16oV0AJ/PeWLXrRGLQ0MVN/SODIEZh2cZzLcsiu77ncqRSuq5fNa+g/UdlCkv+dGUGuhXJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=Enh93bhXoXalVoC9OqhBzy/9cDCSD4ha+wPREPqYb9UZIm2Q5OsxtopiP+f0HXF7PmneYivmLx6CgjsUsbDuFWxnLLvF4Ax88BkghOYxic9UDqQ7xkZGFNtLL9eZXCD81uSPeQV5Bn7ScfU9hfVOVllLZ9jN63+u8PElKaCdxn0L8YWcp29r39KLmBsxQPZvu4xTmpsVsjhgB+IaCvmITAdonBJtlK1g5Zqmx2fl5yWjqUwV2wxFzuMCogXB2eWgt99nUO1Bk3P4vOJZcCErAeYn3taQNXhK/I0IcmDectnhsVucXFkTxaSNs6ISj1qOIIxzHCZddAq8GBbZOP8TRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Tx7nAJZ+GxOyzn9iiDwdI6oGCO77RYAvxfmdcFqVE=;
 b=sZYACo7uue0zYh/NDoB5aPEejPCxNO4kBtwiPw1hmgzOrHZdsqVGex+3dgVBJQLY66M9UJGHTsIXcn4DHLs4VX3o1DECPkjW06L+4k0MuuQVvH703gDRFYWRxDmim2R0Ko4bScL3zkP/n6T1HTxDXxxUre0aggEvpWceSIb0cPA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 01/43] maple_tree: Add mas_init() function
Thread-Topic: [PATCH 01/43] maple_tree: Add mas_init() function
Thread-Index: AQHZBBHUSiYwaMytbEaQHrYR/QRpdQ==
Date:   Tue, 29 Nov 2022 16:44:20 +0000
Message-ID: <20221129164352.3374638-2-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: b0d8fc19-8809-40c1-9ac6-08dad228f69b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wihFiZt84xLBQvlx5+8rqmjnnrtaijvMVc4aBp1M0+sPhiukcMyZ6jRyRq2y6A2yODCDSjxqLJ2xrsPewGnBAd2GBWcOqIWOcTnYfNf2IdRGCMfAw2nAZI+z41YOxPH0DcYNym4oTmpCFepdUCpFgr2ChQLteBbCvD/M1qTn869kSPqIrG81WHPol2RwTHmKgyGV2nc6/JRu/dxV7YVgf4drq3qSxh3MMIhrFIh+MQlVqj2OB7krm/CxipeCkAhZGxpiV0lRPmu79uaOsPb7wFszfddH0ezUDgA2Jg+78qxxOAaZjUMY49Fh0Sz7zEPpvXWDgnkiBbF+8RnnwfTPmaMDYbSG0ww3dRysAdHUHRWv24Y2Dtl30LnWOlPbuK7GhL9//Tu4o6KNcO5hvizFhL1GvqyIFoieTN9Uri7kEU0S8+S3gfQ+r6mk20PJe0ggQqMUZr6pYo6IGsfesxZOi7dbIU2oSPUOZPWI7/7JDiftnydLkhlB7S0Lw83fGWuYyJ9erQH+UdkvNjiQJw8BtlvmBArer8b7s2XK8BRObcclKqbPrjCXxS4js4ezWKTI8VlLqQijvPc0xDNNntNiqO/rs2qmNXJQ0xuZ9FOk81unn2lD6fzyTxvY3CGB3YpLesSSb8JlESBuGkgjV1GBtmYF76tw7qTBfYQ3iMS2EXV0jRbOR5BT0pI77DQn8BKfmzg7oGr+0qYNOLxkH0JkPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KVjnEAIweWMz3mOQxk3kaZEaUvxxfKhaV6E6PV0l8DEswUoYV9Wop53lpj?=
 =?iso-8859-1?Q?CpOw0QKYu5gGFMdOc4RzHFfFzb8EWg9faE17+FXmmhA0T/crvqlp7BUo+C?=
 =?iso-8859-1?Q?GCUb44fEjGuLSfzRACmWAZN23t8FcwUSNsIxBNqJASpCat3ZocT09DGG9n?=
 =?iso-8859-1?Q?HMqxNHv4YS60aYwYXDSObyzeXRPFGNGrf4z/c68q+Dk5mkHFzte/fe/7Jb?=
 =?iso-8859-1?Q?No09Ehr/nf9W7oF0IYMTla2smeMFR1MV7EAgcel6JIw/X2WcUdnwJwa6cF?=
 =?iso-8859-1?Q?PiWFAPmIh+m+jSVpWtwfnQ1lreZPp7nayB1miW+ruNl1jOJCJ5BzBAE6CG?=
 =?iso-8859-1?Q?Hrn3Gm2Y/l/HHGkr8b27Irh/IfhKSOfaev7/4vOTwtFCM8G/5F+OPiDkqc?=
 =?iso-8859-1?Q?P2ooMJhIIBTDdsAhO00oVpiKmWAycLXSKWin1ldIAOrnjfXaR6EGwIQ4Uc?=
 =?iso-8859-1?Q?Nmts2sM6Szsu1v2WTOgvzNqy6onsHoAWWszJQfa9xGYtSD/v+zgdi1+5SF?=
 =?iso-8859-1?Q?Z8KOzAS4putGr2FdrWbNfZlgUN70mEulzjGELMnkgertUUwsWXYV89T5Lx?=
 =?iso-8859-1?Q?IjRdP6bXfw261eObuIeNd6fuGSmx5RW8UplHEorB5+VLFuVuvcN0UpTuu5?=
 =?iso-8859-1?Q?lpLq4KWr/sFSdCBOtA5qKDwZxOk7UnczQCByoAaOZfF4X3uJzTudwMpGbQ?=
 =?iso-8859-1?Q?u+hbj3tTefNq8D1ecQomLbXLl0FJqN04q68s4yRmy+/Uate+3EXhIZYhOA?=
 =?iso-8859-1?Q?y+BCuGqr1qnqNgYdjSY7n3C825kC1kGznvYJ3zFd8fEHbBpPMF/ZrtLc3P?=
 =?iso-8859-1?Q?xwxOukFFWyetuBupH5sxquln0g6efuvm6J6jieuryjKTHAWs1dlP0SNpLK?=
 =?iso-8859-1?Q?nEflXPpqXOqq2GBb/RqdjBTlEMg09cZ4RESLQPzRizG/qY5MeG/N0Lhmab?=
 =?iso-8859-1?Q?f6+bRasAI1MufyaQsb23bfs0Lioy7UVqyPqq2cScViy4RAZnIVGiFB5Af8?=
 =?iso-8859-1?Q?Fjr8sUGFLWCRv7T7MmDTxOb9ZK1CUflSwdevhNYTMT3gCoz1hHl3GZEEAg?=
 =?iso-8859-1?Q?WqUcRD15MO0SWLFMdFpnR64Pqtq24BbPX7q/drLI9GqWXhm55BrtvsyXH/?=
 =?iso-8859-1?Q?xCgHxyGxFt2oLptIwOhgKCoesi9nxxWCBEubN5muConKJ8540TWmWc4u1A?=
 =?iso-8859-1?Q?PuDFwBSsq+THN4+AuUlswO3d9/izYaA3piC5DRvr0RR/NBCXFnp+AtXJs6?=
 =?iso-8859-1?Q?sy+LseVWekmNtV4BSclNIB19dQFdAhcKpD9/JWb1KmGCqxOoLRddldqBeG?=
 =?iso-8859-1?Q?4E4ouOLqMPUF9LsmYAb8lVPxzzPaHvy5pAcUaxixZYjGKEwVXosDt0QQ+J?=
 =?iso-8859-1?Q?fjQLMse5eoGJRSsUk9cQ2mZR7rLEWYkG0SHDYMws/KNTvqtt2RzrgiRCtP?=
 =?iso-8859-1?Q?5eMgPKZoSYP0dcuybDWCLlEoPhrDKZCu3mVeGmXY3V0SWP90a0T/a2S/L/?=
 =?iso-8859-1?Q?qmKeU6L620QZfhF6L5YKwFz4pu08yO1+R9VcO5MkFm6lOzwBXyOrZiD+13?=
 =?iso-8859-1?Q?ZGxCyUuCylHgP3pLwoW6uHMlXxRKHaG1YVOLb46EAHvwRpGijyKgf6lFUq?=
 =?iso-8859-1?Q?C1NAXIm2In6n5/i/YGJZc3VzUN5rq4EYAnRB0FUvHhN7WQq0vFF5GPoQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NWR1F4xpIIsoaPQ/556naATNDhLi/yRIkwvO1NnUfhDX4GJii2wymsnd5LLXIZFaukR0YzOTiHZwgSG/SiU52NIO7Gz0DUMljZWGb50iGsS5Fa2xTv1aaVNXIo6PwCEdlCzBsAcn4PfXgaoPkMmLsuM2PCtlhW5xpyYMi0lf5gBZGv6zYkUinqY/vAItW8hkTtHN0D4l+iiCOnWpEWzrNMen8RSRG1NEhxFPtCDD5VbgthSSjVKQmuQq1eXpi5ql5SH/4+bB8T8VeN70/kQBpMDlU8JOjhUtv8xRqgfsivh9aKPfx+3CJhy2gvkexyMKvriuIAPggMXp8NkzsaftEI1RASmpCqJfR2ef1mn3Drv+MBnrF8cWuBI/TYHZI1fhCHcOgByuRNlelp0CRdsrnT30dUqwzseScDkHJFFrmkPWXQD81GbcCTDOw3MRTdtvRSi1CnOr/SxgHgGztjcofO2dyphSXSPEAdLHCx2yT0jlRWrlPDWXmEUa06lGlMzzUCgZ9xaOa8D29Bt7DGb7EYCBHhnYF5ngltTDS1iQhhzhqPdBs/uZzcoLfeHVLLPAYZN/NIT9t2rZp4tYpfc/Tc98VEx/ztBcBERtGReckQ1t5goe7LycV7bxZUgijl7QudYYUc3a4Mg4P4GSnkAgUSG5KWf1Er9TCt+ETqTvpnsdFmhWNlrdxAe6+GpStmaC2ASVjwvv3kNiekrTDqZrYL6ci3ZKKn1SHN7P9qkvYx78jkzZlMRhreA7tCb8wnoDbx5GaZSLo9zjRXUrqI5VKbnxdQtpcl0eNZE/HQjUmDo305/W+9tluADUq3LrgLoM9HYgexcIlE+Jp1nLxYj3d0h0TBdyF3YyFfdhwv8/KJE8huNGV1UB1xtk1pn9qkUJhEBHebWaM9x+5tUNpBaasA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d8fc19-8809-40c1-9ac6-08dad228f69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:20.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZaESyCX9SSLTV6S0wJrOCIXH2XPs1yRjolAGjUFd1oeKx6ZImm9+CcE8eNN6XmVTV4VS2u145FvCr8mlE6y3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=967 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: Qw2IpEuFuFyv9RwtcbiIRYTQxwjR8QlB
X-Proofpoint-ORIG-GUID: Qw2IpEuFuFyv9RwtcbiIRYTQxwjR8QlB
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

Add a function that will zero out the maple state struct and set some
basic defaults.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e594db58a0f1..3f972602c978 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -433,6 +433,7 @@ struct ma_wr_state {
 		.min =3D 0,						\
 		.max =3D ULONG_MAX,					\
 		.alloc =3D NULL,						\
+		.mas_flags =3D 0,						\
 	}
=20
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
@@ -471,6 +472,16 @@ void *mas_next(struct ma_state *mas, unsigned long max=
);
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long =
max,
 		   unsigned long size);
=20
+static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
+			    unsigned long addr)
+{
+	memset(mas, 0, sizeof(struct ma_state));
+	mas->tree =3D tree;
+	mas->index =3D mas->last =3D addr;
+	mas->max =3D ULONG_MAX;
+	mas->node =3D MAS_START;
+}
+
 /* Checks if a mas has not found anything */
 static inline bool mas_is_none(struct ma_state *mas)
 {
--=20
2.35.1
