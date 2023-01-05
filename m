Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3C65F437
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjAETRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjAETQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE4BE09
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IT0uf006625;
        Thu, 5 Jan 2023 19:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=so5kYfEUIHFMMJc1aQOfT+gqvy/LsTSX+jpBqfvWQLw=;
 b=V1ALkXoNwpuNHDBTRH43e3FCdj2wvI9Deti99depd+z0OT3Peh9/kTRQYyt7FIhvukob
 hJCI95Qi1XmUjx/O7nWsqZeTDgHngPZsYsnrY8Mg3wSjrFKL1wV3p98+UCptJyF9kOQl
 pqybfFeJHAdIq5yEND5hSVqa8Y1TeIviENqm0hnQ15hBtTlmhKAhfJIBLkazUeqUCzIH
 SROqXV4tQNCVIOYPyOGlcGfGPDfQOCT8TzAFEAAiRP80L2cAY1FFWexEYwszz5GKcWBS
 s1VHn4jdhr3a/JAKohJsRyB5OUGFMsRmzGm5Avwp9FoC1EdWuCFOk+WoZ4lhudS1iQcI TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcpt9mpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpj023372;
        Thu, 5 Jan 2023 19:16:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYNX84l1sV0UOjqDE9cw2SMrjiEuZgvddGCvmPJyVAqeMZSJtphJzYL1qDwN+WTy/oWcCer5me05LcikCAq6cpD7fHgP1jF1+F0DhxbKc5p9dpt4Nh6a+XnWZpPkhPebxSVPRLL8J1ENEIDXrk8e9dTkhOir6A+nn2E27+2tGb5ZJiLceUzU400oKRlDyVB5NcUwAQipR8nV7e6bQQEEx1PWh4sIZCis004AnmxZLlYW4lxGRdBJ4+ZVqKw5fUodfCe2cv4wQp3dsiIpgQ9PD5MY44k45Wj97VkIXDSoGCMzp+/KfhdfC+f5dhpTilhw7WvVdnCdlo4ATatjdBmLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so5kYfEUIHFMMJc1aQOfT+gqvy/LsTSX+jpBqfvWQLw=;
 b=TTSDivfBWTr30k4N5wTF0SbBhvtm7FFcx2WIqkeWixl842DdOIWSE9HDiT4wdMKAiEHNEXNV+2upUHEd2j9zUJKwPhPKUMvsrjhOBGw3z/rpuQMA6+b8pr/ePPrCTaqYXnNHWGocmVTiO5qvnfCb2s8ouR9AOc7uAfaAwtF3zynZuI63YrpPK+s9oZzrLyKqhTQ3p+Tn0x8RFg2e6inPI3m5qutSXyXNXJDNE07nTPqDGxgrhpyW0ragpQA9j1sTxhNEs7eFVIjS6Ouho1DQLmw9KzmZAUwQgzUtfNF4O5w0ciUCOCTDYKXh4HnHtpy5SMPDAkKR03mJXZ6TT//N4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so5kYfEUIHFMMJc1aQOfT+gqvy/LsTSX+jpBqfvWQLw=;
 b=OwS9cJ6X1kNeZiHrsdzMaEG6+HiRTAUd9oTHij6ZDNotOMAVoDzNfbfq8xBrd3ubUsWqveQ4Qc+9OSHP5WwC2kmi/YMAVnAvx1bP3G+WOnDcQHRCLLDSk4UdkRdfayVzGGVTOshl4n0jvh9lFegEFeZWB9vLvB5xoiR8D8cPzC8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 12/44] mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Topic: [PATCH v2 12/44] mm: Add temporary vma iterator versions of
 vma_merge(), split_vma(), and __split_vma()
Thread-Index: AQHZIToiYZPyIynTeEK2D7YGgsoDAA==
Date:   Thu, 5 Jan 2023 19:15:56 +0000
Message-ID: <20230105191517.3099082-13-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: a0ed8703-eea4-47cd-61dc-08daef5146b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SwVmSZ2qjP0TdaXZZjCB4ylR9Ly38fGeLMZz38SSrZtna1WtKW9QDSlQvZhnp2jgYSF42PxLVtLgzOEZ7F/3/CETKNg5npXp2Il6MS1cWYpg5sNYnGB2vD1C14VbvhIiqp1c/LeNfo5ig/roXL0rZa9v4MLaGhRwpHDUb7KC03bhTQSJk0EnLnuPRawPD3vGpzU0viq5RYzBs9dqdUpQy2MCAsxrpcs/iJae1AN+0lRjumxex/hIsf/yc6FEPQ1vIkvxDjPT7ytQmkH7jusbhWhm1JhrhaXhDi9nB/VcAFZ7srSaiXzAWj48H1qsBpK1q3EwxZu3qaWYXw0F4AAlLxyyTmyYJp7mstoj04AWkXYNHz9tV7nYtUtYw4zFp55YyLCe3cL2TOQgkPvMln9B/RI9Ret6uN+osSwnSgG3hr6DSovMNFLe73IL+ankjEevPBiDZ1SIZu3HciJ1RfqB+eUjWrqpsoBl7CY1yi/qMAecUcdME91QF7FQG43kfScQQ2L4lHxohR30UL7GE2/fqd71uBBl3l1xTQ/7u8BxwLqmGElM8fohoZm/DViVarrH6Wc7aMiEDQxKsM3/+1KaQGLIFJnraJxMLwr6GWCR01eIwgTwtKo+leKT3ETOxDT4KmqU3SsW1E5uXA1wUrTTqOwFigRpx62Mt3y63lD8RQK9mKCn1s1rertHZvjrx/8evWhQv7mzCE9YaToceTtrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s9JWar33ZvmVx4o2zHwnUsIIV12rkkbD9rAO6UehQdY1Q7DZakmOUcVAGB?=
 =?iso-8859-1?Q?xqK5XCvH8qa9VQjRzDVOTWr0wXG3/DneFZuiu4smF7ewU6tHAOMZj1Aq2R?=
 =?iso-8859-1?Q?UQ7JwBBk1WFaAtmx33BQ0s0i047evZooWCybCuh7d6n6ZwtAYWzqkZLhbK?=
 =?iso-8859-1?Q?EsVLr0SoAXNAeZlNTC5kmVMExngOLGMYOAnRqLK2sywYf1QPbHIdQC+Okr?=
 =?iso-8859-1?Q?nqYC0Q5CJzFtPb8EfaAxgqb46+7fgiU7JN9R9okTB/uH9T8O0n/8iMWHa2?=
 =?iso-8859-1?Q?ltk3OPrOrcDk93vPfg3zrBPrDv25RaLNIgWviXnzWDUFpHjE1oghncGcmm?=
 =?iso-8859-1?Q?w+ExxKvli1K1Z7WOQyLRe0SqbmLtzAajIHnxnjKknZMIyF22M47Z52NHYR?=
 =?iso-8859-1?Q?pu9o4a9f5i2ks7QYyOBS9zbGRk1BjFWXdjzjaCvaTzVpTLaIyCoLPKJjgb?=
 =?iso-8859-1?Q?ZHAYiCxCXhMxrSm6Dk/GDZRG1R9yOwqtLr1rgvplIsUSbQ1DBTQ9WZtYOw?=
 =?iso-8859-1?Q?Scc6UkheebHtZz+kAghC9HAJxMXjI7OQQuSO7YRaseiITgO/a0xNBAByfW?=
 =?iso-8859-1?Q?04HCmje6EA5G03gE7lqZ5dV4KvTyot6r6oCGPbafCczBpPzjqt0GkM+58U?=
 =?iso-8859-1?Q?/WTT+HLNc65RSR1oDglIcAEdQm15ctL7GaKeliLgAV+eayOJ2k8Hi1drxU?=
 =?iso-8859-1?Q?jlNpOAY+DdfQgZ/FVspBlG6/GchEbUnx75dpc8b8aS4bwz///0p/Dj/9mZ?=
 =?iso-8859-1?Q?QR7vdC6zK91BJw3SZvAZvbyNzp7TYrv48zZ3+BglzptKKQQHW9VC1vauja?=
 =?iso-8859-1?Q?C/SyiBbCXF3HbZklSXXzNK2J0FiDJhM4vGhOrAfUaxUNv2eaJOSnq7kWBG?=
 =?iso-8859-1?Q?7QDsNzg02ewPaz5/mZIFDKAiVictIQo4TbfD1iiNdf6bMiNlRofSXb5ZKc?=
 =?iso-8859-1?Q?8dh8Gnyr44/B0bLU7fohMYh8uTZhtn8rx7vZ2plG8pp1W50OPhTZwMaXIv?=
 =?iso-8859-1?Q?/ayDzEFT0D6YaY8cFvsRLciNlKkOVebohqEK2nk9omM5UNsj3sWSSvjYa6?=
 =?iso-8859-1?Q?bpXk3uyqiG6c0zcxDQxAMY7pJG01EZ3bIhCsfBmPuZ6KcvVo/NGdDY87aG?=
 =?iso-8859-1?Q?QYTHf1Tv5rMfnZzIInVia4191+EnVVjaGuor4iSzQffho7PFkli2sAzXDb?=
 =?iso-8859-1?Q?VKC0UpPfKgL99N270R1FHJtEXc+373sRoIcLMFDNWMb/5WWaHpf7Xbq+86?=
 =?iso-8859-1?Q?V8Cd2TTDKgaFa04Q+4FI5XK0bXqhUK9+mmZr6tDKufr9jhI46qFAfhYOKN?=
 =?iso-8859-1?Q?6/k0D/btoDo/pv5/1vLH95QuX2Z8LtTAVIwTlGuw3+vMOVfMbeK30tTL6A?=
 =?iso-8859-1?Q?TStnr895Cvv5HICX+Z4VqApf7jAaKK8Z0DEdskix5nK0Bv5NEglBhEFKNU?=
 =?iso-8859-1?Q?eBqC5osPYzu10eMDrzumjvDcWKTqEfr6uVkt2wFtYxJa/hcpn1CQK7doTl?=
 =?iso-8859-1?Q?3+uZzLOGFoBJugJxD7wdBt/hpwUW5av4ycMG22Cs34whvoKjJsRsFNFRmj?=
 =?iso-8859-1?Q?lL3jYT6QzxImyDqS08st8m4XqcUdSWqVexEvMAfoAeRPsnDBBdAG19qyz8?=
 =?iso-8859-1?Q?SroJNISiLVFnJhZJ+x2MyyFY0pRCGNgEUmPnYXrfyD+GDCwCdDTXuTog?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kgPCSVyb/rExMCo7EwEEvwGOIgioY+9jVnZz5sb1uDnrPYKBVFQ8E/ra6QrXmeyP1LEn/bD2feVeLwlh+Q46lM1lYJBIsqbfM75f0z0SlAGiXb3hAZd0fLiXXQLt26e3BrIhMmQMCBu9iJCRFtK1JpGBwZcjkXGFOmitfD/zh23IWtzxOXBpQaSgBE1CXswc9xLxi5jp//5QNuR3S+bE9qKi2W6b9uF394zU5AYtP+1s6mIZ/WBmrpMqxIKL59mjjLEBKrl7D0OOxsMY2GKxlwaIaau6q6zJ0sJ64Y0DlkAjnBTU6LG4FZPlxYKjA/XaLFw/I4mn1SRwYIqLLihGBpaVrmouZZEKvmW+zDaSJnGiCDyoQFE85Pk9dy8iYBj9p9NqrlDezvKbgfFZb9xJdr8qkdSEoqmqENj5oQJqOJFCkJGelv7CR8hgmwvwz4x1Vf4f5viZLjphdEoE9a6+1CcdXHsCkHiEusKBR5P4+7FnWJ09r46pb9RgeYJspWRDAicTyF4NOO45r3TpU+DmwgDm4/qJ7KoIUZjCE9g95h2WOjEkktbWrIfTYh+/zPjLWwUC6i7RxmF6fme1n3esYZ3gJXWOoA/uHxVpeHEHkpbQNeUPnTsNPMCC1MUOCuouU4ma4yEyrwai4DIV+ZFNzW0l1u6Nf+7zGArEOZQDEdCzzDjNWz3QDN84xQJTNHA9xzlUd4/rwjbcz9MlZKIAEp87Xa0tOs6SQu5y9beMxa16xdkO/FJ5yJepPoLTZt1ohDdb4UAUSvstsIQXM3oVDQG6TynOIgCJ0YgflwcoKGIj/nmRMlFx+otl1D1ogmZSxMHnXJVhiAq/D9lXm91nIJulpdCzwa6rHEK+J48RDV4NcT/KgVDDnDKuU7YVub+Rs+Zbohqk2Pias7+RZtIZvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ed8703-eea4-47cd-61dc-08daef5146b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:56.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzAqN+NI49ABIeBoDicdC1U9Yqy9ewQzCAPOigtuFbqfPyAWqIqGgd2AH6ncbg2aC1wLINLsylHcHHZCF9PjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: rK7sdBuJeTSq6XEYkAPip3kZmqzOTQae
X-Proofpoint-GUID: rK7sdBuJeTSq6XEYkAPip3kZmqzOTQae
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

These wrappers are short-lived in this patch set so that each user can
be converted on its own.  In the end, these functions are renamed in one
commit.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 11 +++++++++--
 mm/mmap.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 126f94b6f434..9c790c88f691 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2834,11 +2834,18 @@ extern struct vm_area_struct *vma_merge(struct mm_s=
truct *,
 	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
 	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
 	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
+extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
+	unsigned long end, unsigned long vm_flags, struct anon_vma *,
+	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
+	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
+extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
+	struct vm_area_struct *, unsigned long addr, int new_below);
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
+extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
+		struct vm_area_struct *, unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/mmap.c b/mm/mmap.c
index 8fd48686f708..4dd7e48a312f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1150,6 +1150,25 @@ struct vm_area_struct *vma_merge(struct mm_struct *m=
m,
 	return res;
 }
=20
+struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+			struct mm_struct *mm,
+			struct vm_area_struct *prev, unsigned long addr,
+			unsigned long end, unsigned long vm_flags,
+			struct anon_vma *anon_vma, struct file *file,
+			pgoff_t pgoff, struct mempolicy *policy,
+			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+			struct anon_vma_name *anon_name)
+{
+	struct vm_area_struct *tmp;
+
+	tmp =3D vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
+			policy, vm_userfaultfd_ctx, anon_name);
+	if (tmp)
+		vma_iter_set(vmi, end);
+
+	return tmp;
+}
+
 /*
  * Rough compatibility check to quickly see if it's even worth looking
  * at sharing an anon_vma.
@@ -2331,6 +2350,18 @@ int __split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
 	validate_mm_mt(mm);
 	return err;
 }
+int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		   struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end =3D vma->vm_end;
+
+	ret =3D __split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
=20
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
@@ -2345,6 +2376,19 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
+int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
+		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+{
+	int ret;
+	unsigned long end =3D vma->vm_end;
+
+	ret =3D split_vma(mm, vma, addr, new_below);
+	if (!ret)
+		vma_iter_set(vmi, end);
+
+	return ret;
+}
+
 static inline int munmap_sidetree(struct vm_area_struct *vma,
 				   struct ma_state *mas_detach)
 {
--=20
2.35.1
