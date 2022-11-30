Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A69263CC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiK3ArG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK3ArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:47:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9354F6DFEF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:47:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMx0bW020122;
        Wed, 30 Nov 2022 00:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I5jFdqhJc5AsGXSYnoTtga2cCYXPMD3radJ+eKZla7w=;
 b=J+ik0aS0pMC1RQTE34swBW4Tx40PqRR7dOX74VFJRUO/r+KFkSO1iJbeD5JOrpoAmo+d
 P93GyYNJauCF1PCDLUtEB21M5vEoHijTt6XjuVHET8VfBYZr0qrO6HyXAdSkQoBEpY7d
 72uxMzN3Xir6+QvTrKzIr1SwlArluTnHwpgK+ruDm9hlIbIw4Qz4hrNZGOph6Enx5uUH
 VjAX+gqx8KFRQjrMCL8PgraUt8yJ1NywiWaUkaOUcTVo3VUffv7oCN+ylALE5fGl5DCF
 NCFktIWabMQF0f1CkqoRv/NKyEHZ4OcQIh61i5WUciQZTBPr9CayRGeaJCyfNSrZ+dE6 FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt8n9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 00:46:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATN0lgx011601;
        Wed, 30 Nov 2022 00:46:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398efy18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 00:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6y5p4qu5DQwz87oyQW/UsBrIUpHhjB9743i4udz/olpmdjBHjAopWNAKDMFgx6frAAzdNWN9mDrK7pcXXje9khau6Ysdg84dI19R/k/goZlCi4yo+zKres1TgWtPsL2iTm1HAu+H4OC8wWo5MA2CRhZUSF2B9KuxpbuoFJbiUJ/72AagXk7Al0SZjwgYu6xKTKaxaiUl52g7/cWQQHZCWdWFPt64XVDg2rp5XzNtYAoBdnRuZ9mFaKaKzMUs6ODI1O8JOyeVKE1gN5pxrRfoz+PbnxPyjJzfQuGrUivdRiNXvj3EPCPsik8oES9/vFqPgddtF/0JLbVvukm0GLuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5jFdqhJc5AsGXSYnoTtga2cCYXPMD3radJ+eKZla7w=;
 b=MDd5qGzHDrpGnTmA+gjG2M073EVvOX6usBn5ZEHEihF63xkHg8J1dOyHQ8TyTKCaTDrWNe2O+76Xk2f2dlTozL0SKA1AdBXJIjFWLKgwsJn3ulyqq+f+K7tBsObS8CW/BSpkrXKeSpkjkYeRdey5dU6ndr6ZRf42iNIlzsY3o1CC93/AZyxXnVANkzQZmJj1/CZjaLXliDVqk3wYuqgzOFkI/xnl6BtSXlZeSam978pa3q7S1bU3jbozHUcNNKHWqch2+2MS20Tff0t5ASZCZAdxcoBGiPYbdXX4YR2Dft+7kWfRWlOuF4ZLHgls0kWN7dttQVNODISbOeBlDA1AUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5jFdqhJc5AsGXSYnoTtga2cCYXPMD3radJ+eKZla7w=;
 b=uw0oZvbv4o0Y6E6FFGbPJbj+THWXd+t4KICA8PCrtiIbKXly7A54YleBxGyUyE5UORmfMf5Bco+rLBf/t0H5vveAySQsEzyjK7dRlXXlc9KUULZY+ZnknjE4yz0nXKHgNAFvUDbQNP84aJEwyNRlMjbAsAkLh0IFAwGFOhlvKvA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5692.namprd10.prod.outlook.com (2603:10b6:303:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:46:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Wed, 30 Nov 2022
 00:46:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/43] VMA type safety through VMA iterator
Thread-Topic: [PATCH 00/43] VMA type safety through VMA iterator
Thread-Index: AQHZBBHT7th0AJMxTE605yCVrxP9Da5Wok2A
Date:   Wed, 30 Nov 2022 00:46:48 +0000
Message-ID: <20221130004645.2leyk56mokvxqlpd@revolver>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MW5PR10MB5692:EE_
x-ms-office365-filtering-correlation-id: 3506eb60-0a0c-49cd-f07c-08dad26c5ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukK7W6zQ+sIo4ehrLwPzBklIjFV+HeE/yHEj+LVjE2Beu6vxEa+PdDuHXKobx3tcjtpYQhV/dnUmNRazw9efxl6b05KWtVx7L85hoa9EXw9NpcoBtdEih1xfOADQ4n78KjPSPnp52dxTZCMnm5D5OQJ2U28XC7/zjymZDsjnpp8Rb1eiOExMFCS8eiqIO2pTUGs4Q3gd4gypD0/im55bS4vWPzhr5P41+Jea0RjPmDwVpp2RcPSFJ9jKrlgVAYXjiFDvqx2anvM4npCKIQuqpiRZhKQk8t+vfXo0q8eYr0DTYnnId2Wd0DaStKXn4HDvmO3UtErdsLCU2THabxzyLhgYemKL4aDA+ju2iZfQTdJa5BbrHDpYOjrWExEg4nn5q5EIiP1lVCmVAo1hn2hhv63yU8ECpuviHnzWG3zgBLDgGRBiajwURHeECYxwy4ILGIqWM0Wq2isYSKBcO05F5Sr2x549y6WUlh+3O7uDROCwWwfplqZ8JsmYhGkT6p/U1qboIGMi7lOa2624bYubsPcCYHDAVvD9sFAvsO5GRiLXJ6QwHoyfZXOrmOP08MkRKUFwUsfoOpdupEChf0Ox9te0GLQiT5qmQUcmwh2Ys04U9euZWbsbA/Jnni3TNPMU6v9/OI6Qh4uOIdkVlAl2lWJneLQKuQ8ReVXpiEhVOS8PZV28vC5gtBB8kjS7fYZmko8SiyA1u0dUSheSgveruuLPvXW+5IXFJUY2Bigroj0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(38070700005)(33716001)(5660300002)(44832011)(71200400001)(66946007)(86362001)(38100700002)(122000001)(110136005)(6512007)(76116006)(316002)(91956017)(26005)(9686003)(186003)(8936002)(6506007)(1076003)(66556008)(41300700001)(64756008)(66476007)(8676002)(66446008)(478600001)(6486002)(966005)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6iPjW8GikVmq8ZXy4WOyZnMUyL+z9NqioNFNyck5NvukclrMg4Twt0JKTRAI?=
 =?us-ascii?Q?pmvVDxKBwhdsxy+rF1pKKlA3Dhet2eO/L2d46/TcOnkzdViLLfl24zGLqGES?=
 =?us-ascii?Q?pNmK/rq2aQDhBRzXfL9JlFAFu8x8qDC/yWGS+P80r6dX8eqO8zB9sunJdxr2?=
 =?us-ascii?Q?X4X9LYZmiTU0iI2jOFi9Bc7+WCLGlq3r0XJow05CjtVyYnSPt0E+rJsZylxG?=
 =?us-ascii?Q?wZKm/UtTzbLqK5Ygavd40u5gk4Qy5kwcgj/s6MNtBpoUSayBcIQ/6wy50Jui?=
 =?us-ascii?Q?mks42HIWS+CucExgatQqbPyEU3XOvlvN+Rx7VdKaGcBqc4ABaisrBxIpsNEr?=
 =?us-ascii?Q?VqbXOPao0pNiQXKDoLmkU0BXp6vQpteKAPPAKCajjUWR13QWbuV5pa8VP9mq?=
 =?us-ascii?Q?PHkHTcZZOoOL9wXGkQvfFf1ikjopE5Jsi0X7/W+/0DjlJFl1IGif3okX0ReZ?=
 =?us-ascii?Q?AnsXQgmuwuD+hMtTDwLQ7MniYU8Hn+JlaYLDwls6DOm0xmNVco64guKiuSrD?=
 =?us-ascii?Q?J3XxsJjmxf7EbeehDrz69rTdae5EecQIqMnFpgpiQAPgwsBma5ksMSTanUAT?=
 =?us-ascii?Q?8RnAgt4n3ETJYDk+LlJezUNSVvO4X07PA2ZacytB7vr5QoC4stABx53pR8nT?=
 =?us-ascii?Q?upl95V2lCP8CP5wAWyfW1b2lBr885iCiW4cGjdAt5lfWx4alJy6yxAzvic8w?=
 =?us-ascii?Q?2l+K7onuc1Yrs14RCsnoOBk9vzt/1XLCAgstUFy721ZS8n1SOFYhC9vlrX3Z?=
 =?us-ascii?Q?abtqRd82sK3sJgKC9oBw02W6FgFHRQWuB7NJGRZyRa876PJNtV5x30nQMEqg?=
 =?us-ascii?Q?LMKGKjXIBt+iG/Vp2k09hrEMb+HL2Y0xw4J2oPsB0Aa9rRvvPeVB+X7i79Bd?=
 =?us-ascii?Q?YCVOhhOQgmKOb2DUmS7aU2VgvgYWOWlkY++VWJDjZhsTq8mEhzf3H25Jqpgz?=
 =?us-ascii?Q?BLMOYmiLbID6kJ0Ns8OwpjmUj54x2BAHgGUOqUeOkx/+Uv50SLIAcJf9A9di?=
 =?us-ascii?Q?jaPsk3pap/bcTtz7UuxOIFaBuBDh3vC6+r+guZNzm94W8XQyo0YbowTjyiFC?=
 =?us-ascii?Q?NPShcLr0kCPb382zwl/ThNNUjahhZxZc0lfKZ2mpRSraWLnOyXL0cRbT//7B?=
 =?us-ascii?Q?FH4qaO5muFQVvAxNhfxf6L0kL0nrL5HcdkfB1ZX9GsCfePG1/3AV5yXE8N8G?=
 =?us-ascii?Q?KHgK0TG3VB5UFMvIW9mTcFAl1yWszeGYODvhLFrYponN1IYBwAx1lIWHiKbG?=
 =?us-ascii?Q?nl4D+or1ES/mZKfXOK0Ty/Qro3svG6anQ3q0Q0Dyb8yOsjtk/xjJjf9rZb2I?=
 =?us-ascii?Q?2GtSLnVyP4ACikmLBfafqnUZkqYW7ngBZM+szBvouaNZSqXdN0sIa7tBYv0T?=
 =?us-ascii?Q?MdCsH9O+GMhH9RuxUlItkPmr7a8kXy1GGwXGMQb9vhnGDc51RI2iIZAINCOp?=
 =?us-ascii?Q?9qNeUkSErfHMhTT7ygy/A7r5pMo2SGVFBpQWdfVTBc9AeU0h9A4ahdXDxZ+3?=
 =?us-ascii?Q?ffOjlpXDwHWf4pgwwPs2CA+CSSt2TncHXsHqcJaN+xCeGI1xsmyCQ/eob8cF?=
 =?us-ascii?Q?+xGKvpyS7cuMhaWifSb7CobABV0iJ4RjRSSTvkg0dlPf6p2M3+Qf2W0rnt4f?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98E5D4746CDB2B4B80F2584D013A57E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GbL0HNAfirw7lW8eh9f108hOSWxiQsQ1RPKdDQ0GbFnmeDRXLzc4eyq3t4Ft/lk8lbDI/kP9u4kKhJH/AlXMDHaZtfaQMu4e3A5EiFlONWVKBel5AV/m22glMEYjQhErJXXJEixUXCl38BuMwxZCBjrDYHnqf5uzw05taJK3oDlURQp4hecesu57VMtZzf37us9d8O5ip4Nr68itu8wUSizMwv5k/DHVNQcjH8YK7Pvfh/b2/VE7TNZDqwNt73hPVD2xDEh7u4xginAHz6ziKaoXvWKP70lALvETBuDnoS4uH6Jw87h7K1RnKpFZYTaPhCYi4nGEYuY6f6SUPky/1XyjdsW8qdaoOLLjCkkSui4HqYb81gxXDb0Jz6bbYRJzFHlJ5aSZ8vj/aUP9vudqCDb1S/H3ovCIW14j2mWyOt4muwTUkCfHWtp3KQ4x5yIOO0filZW+KVaNaLpcXviJgqYvzNJjC8j2+C6MeCK5KJK7rWh/vlTGzBsZ2sgcWRsC4FExuOKFhJYY078lVOQRMIYF/0C80yl+4Lar7v9z9M+X2zCkGTOelc8I3LRDOak1KQw1aoRiNFvphb/whigDrLUqKqjZS7n0UCupnJyZJWqlXiTk6v8cur5B7C+kFnt/Wt4ni1lWBKB0CJgXB8NeSX0wbeqs3hr5hn+8dhZfTNxSAOGPix+IvhW5RXBhP0w4qPyHOuquGnpNdcWDBunLl7QgbFVbq+VBF2FTd7d6UkvSvB3DnZ6kWM672T74iMDqMjGHQhH4INpLmoWPtGgejeEnBia5Faj0Os7Fix2/ZQLLWI65grhgVFNTsbuw8RFiBd1F8YVGe8tLhCjyNxX0+5b9Wg0qXRjszfv+qDQ1H2CBXMgYMl5cQN6z5DGKJzox6CmLcg2SIkHoPQDxzFMt3A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3506eb60-0a0c-49cd-f07c-08dad26c5ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 00:46:48.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83WByY/RqAJkSzT8Qq9we5QLP3n9+nAgz96VK3vMOao8egULyg3hSeKta8qRLrzucS1D1W4Iinea0y5v5czFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300003
X-Proofpoint-ORIG-GUID: 7RLdXsXbUi55QXEyF1Gv-u_KdtLzvlJC
X-Proofpoint-GUID: 7RLdXsXbUi55QXEyF1Gv-u_KdtLzvlJC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam Howlett <liam.howlett@oracle.com> [221129 11:44]:
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>=20
> Andrew,
>=20
> These patches are for 6.2.

Slight correction, that should be for 6.3

>=20
> This patch set expands the VMA iterator API to provide type safety to
> the VMA operations using the maple tree, as requested by Linus for 6.2

This version should also be 6.3, Linus didn't specify a version.

> [1]
>=20
> It also addresses another issue of usability brought up by Linus about
> needing to modify the maple state within the loops.  The maple state is
> has been replaced by the VMA iterator and the iterator is now modified
> within the MM code so the caller should not need to worry about doing
> the work themselves when tree modifications occur.
>=20
> This brought up a potential inconsistency of the iterator state and what
> the user expects, so the inconsistency is addressed to keep the vma
> iterator safe for use after the looping over a VMA range.  This is
> addressed in patch 3 and 4.
>=20
> While cleaning up the state, the duplicate locking code introduced by
> the maple tree has been address by abstracting it to two functions:
> vma_prepare() and vma_complete().  These abstractions allowed for a much
> simpler __vma_adjust(), which eventually leads to the removal of the
> __vma_adjust() function by placing the logic into the vma_merge()
> function itself.
>=20
>=20
> 1. https://lore.kernel.org/linux-mm/CAHk-=3Dwg9WQXBGkNdKD2bqocnN73rDswuWs=
avBB7T-tekykEn_A@mail.gmail.com/
>=20
> Liam R. Howlett (43):
>   maple_tree: Add mas_init() function
>   maple_tree: Fix potential rcu issue
>   maple_tree: Reduce user error potential
>   test_maple_tree: Test modifications while iterating
>   mm: Expand vma iterator interface.
>   mm/mmap: convert brk to use vma iterator
>   kernel/fork: Convert forking to using the vmi iterator
>   mmap: Convert vma_link() vma iterator
>   mm/mmap: Remove preallocation from do_mas_align_munmap()
>   mmap: Change do_mas_munmap and do_mas_aligned_munmap() to use vma
>     iterator
>   mmap: Convert vma_expand() to use vma iterator
>   mm: Add temporary vma iterator versions of vma_merge(), split_vma(),
>     and __split_vma()
>   ipc/shm: Use the vma iterator for munmap calls
>   userfaultfd: Use vma iterator
>   mm: Change mprotect_fixup to vma iterator
>   mlock: Convert mlock to vma iterator
>   coredump: Convert to vma iterator
>   mempolicy: Convert to vma iterator
>   task_mmu: Convert to vma iterator
>   sched: Convert to vma iterator
>   madvise: Use vmi iterator for __split_vma() and vma_merge()
>   mmap: Pass through vmi iterator to __split_vma()
>   mmap: Use vmi version of vma_merge()
>   mm/mremap: Use vmi version of vma_merge()
>   mm: Switch vma_merge(), split_vma(), and __split_vma to vma iterator
>   mmap: Convert __vma_adjust() to use vma iterator
>   mm: Pass through vma iterator to __vma_adjust()
>   madvise: Use split_vma() instead of __split_vma()
>   mm: Remove unnecessary write to vma iterator in __vma_adjust()
>   mm: Pass vma iterator through to __vma_adjust()
>   mm: Add vma iterator to vma_adjust() arguments
>   mmap: Clean up mmap_region() unrolling
>   mm: Change munmap splitting order and move_vma()
>   mm/mmap: move anon_vma setting in __vma_adjust()
>   mm/mmap: Refactor locking out of __vma_adjust()
>   mm/mmap: Use vma_prepare() and vma_complete() in vma_expand()
>   mm/mmap: Introduce init_vma_prep() and init_multi_vma_prep()
>   mm: Don't use __vma_adjust() in __split_vma()
>   mm/mmap: Don't use __vma_adjust() in shift_arg_pages()
>   mm/mmap: Introduce dup_vma_anon() helper
>   mm/mmap: Convert do_brk_flags() to use vma_prepare() and
>     vma_complete()
>   mm/mmap: Remove __vma_adjust()
>   vma_merge: Set vma iterator to correct position.
>=20
>  fs/coredump.c              |    8 +-
>  fs/exec.c                  |   16 +-
>  fs/proc/task_mmu.c         |   14 +-
>  fs/userfaultfd.c           |   88 ++-
>  include/linux/maple_tree.h |   11 +
>  include/linux/mm.h         |   87 ++-
>  include/linux/mm_types.h   |    4 +-
>  ipc/shm.c                  |   11 +-
>  kernel/events/uprobes.c    |    2 +-
>  kernel/fork.c              |   19 +-
>  kernel/sched/fair.c        |   14 +-
>  lib/maple_tree.c           |   12 +-
>  lib/test_maple_tree.c      |   72 +++
>  mm/filemap.c               |    2 +-
>  mm/internal.h              |   13 +
>  mm/madvise.c               |   13 +-
>  mm/mempolicy.c             |   25 +-
>  mm/mlock.c                 |   57 +-
>  mm/mmap.c                  | 1071 ++++++++++++++++++------------------
>  mm/mprotect.c              |   47 +-
>  mm/mremap.c                |   42 +-
>  mm/rmap.c                  |    4 +-
>  22 files changed, 862 insertions(+), 770 deletions(-)
>=20
> --=20
> 2.35.1=
