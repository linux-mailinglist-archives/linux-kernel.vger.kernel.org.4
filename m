Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F9F66D477
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjAQCjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjAQCis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29418B28
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:58 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09XGD006403;
        Tue, 17 Jan 2023 02:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hmfUNFapTwaKJCFXsaOGLvciuDyj+d+kxYcTE3x5ZNc=;
 b=VmYUOuqj/NimP3Kjv1OifnUBPiUJk0zG8lKPt5zzTXOvvuqnt+aNOiOB3IhmkbsBCjQR
 Zi1K2qbugOvQASt/H70J0KDKPWQCg8w/CBQqBA9d1AHbRLhiKzkUT3cZpQ9h7uXpr9qh
 kCf8B/369Ov2ofK5KZsFceZ4ocZruaoOX3TH4SRQdkvSsYvoQTXeSAcMAU6CozzwZItB
 7sqeGJXWRSvonCqcZ+xn2e7tHCd17vtC9yJvicKiVRIubVqi7y88LLEUogzsgDl2N/Xq
 Sq8ai4/fXT0yLKXBR7xNXIrJP0oUUc28b9t08+twiNyaJgHZ4z3Qkl4IO11UAC+PrAbg pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNCpCO004918;
        Tue, 17 Jan 2023 02:34:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo41cXDCYpk6IwUSSNMVJlLXj6BtopCWbOW3m8miKoXin1iRKgcD82GASSe9zDQ6GIAohrpJ9tUubWgWFLJTBcgxxw430B4n+Eh2H5+88vWUTwJeuI0PzboWoPSCFpOD24FSQ1esLgQo6APIFujCiJswJLCtYmI94In/dXn+cNu4KT8TAVR1D0xmDvialcV5THdtGj+Rx4zV3camkE1iD0WajZWneROdfSIniBtTuMgPQyw1PN9hHkqIkLwmxDBNjiIDPMzx2SINBFOQ6SEs8o7xDUVS7qDodlD8U8Y6xlIko3gdnyMSfKLi20RJgTjbmvpB7cvAgbKbEF99Ulfq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmfUNFapTwaKJCFXsaOGLvciuDyj+d+kxYcTE3x5ZNc=;
 b=WQ+wg/O0FbTaf2plS+4O7VtbsCsfCbDYgU+lvI3/RQrLw+LZUMvIVtKVZseMC7LaPsZ8SSVLXJcev+ZvOCC3+6986Kv7Fk8ssq6yhURFElVOCTST5YSRxNQr4K3KtSpHwfykrLO58umHJ9EFAwtqhYr9/aMcyTa0YocS8T5IpctscJpp8l+3U/ItgQNRd7EgeXGHNm5KYjw4hTNl1ZB4I1gds6BZcQ2J0C3c5e9UPsaEOchoD5XB+ltOdgjI0yNcMFL1LWRabmYbVLQOwPO+S7eR80Uqk2iR9CKQthq4xXbNjT/c/lwCbw992Ndds/7SUOZd5uXsFv23CS3na1/4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmfUNFapTwaKJCFXsaOGLvciuDyj+d+kxYcTE3x5ZNc=;
 b=B70u3VGq7Bxg94JkfQH93Xm+/4eWUyNHL1KC0BTT70Y2jN7rSeLtkvCAqdvwU8kEwjGrCrQSscsE2Ioi1gEv+q0k1tfqS/ouHHdS4HcIHGWRxzdfDZcPcEi9pSrpmQ44qY7ZVjEbMFJdZ7C7oN+IEeDWj3reuQ3ZRwToycLAe44=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple tree
 store
Thread-Topic: [PATCH v3 30/48] mm/damon: Stop using vma_mas_store() for maple
 tree store
Thread-Index: AQHZKhwz3Un6d8d2IEit8wQQlG94yw==
Date:   Tue, 17 Jan 2023 02:34:19 +0000
Message-ID: <20230117023335.1690727-31-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: b0383868-e724-4938-5cf7-08daf8336ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/uS9SIxjMVVWv5PwhBQ20jKzyoQabibd/Z0IbO87wEr+QGRwT9EGfY299h/fNHOp3lEBg2OW3eE8JsmnGWpTzPB1AVIvabhferlV7CsmisP8yZ5PP7C1mgmjzMh5s/X7Ik1uy5iQhnWXlv5FJGWkpy48ad3FmpeomPjCcQn1SlAf/4hlAZdcOCfFmr7mwWqpUTDsFP5TbVOp0fnIDLApbjBcszWa2jEjDC4PhhfSo4vpFIXGeqO5YMfAlK8h784GxCUIpVM75AzH8goJmmh2A+4b/Ghuu1LKuuF5dqTnSzuH2+O5QrZICgJ1fBzdvPnEaVY+Q+HtTJPLglBbeVMDBD2i9W3bXFuhS7ImnFtXT62W48DpcmDclmsbYjd59QXubPeYUzutffc1dqzMACMkxaXufABp2Zu5tBjIKBEPb/c1DkdBUKHC08bm4hTqu4N1g5Cah/kKacVPwQZbdkQJTI5tUDMTwQtPgCGhzWmbPGWBLcs+5lLmav5jCAuuWVGbwP2NAlTAJ2al4QHcZeSYTYyovoOdDaOKPeIHPybkgBdaCliFRCGCx2cBKOtjTuCo2H53ntloumQl14nfLFnq2PJoiz1B2ScwK5r9V3HnLOgimzMZGOgXpCjS+kUHOoexHNPw9/ugfePjAgPXfCUlaNgwib+ZmWheOxLPMPRpjlBUW2/Z6CQ8YS9XMENlFAiECJ+hFPUhhCRXuzZn+7QGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9IVXSVnzgsH0m8ifXaHUabbIpwiZi5+0D0w7WJ45qFoBJbIkb+FBttoXI5?=
 =?iso-8859-1?Q?0vmiKgvBlJVjebi5HyYgNxpUSGZh14wR3bKzvekUmJV93F6+UIIqcTbxXb?=
 =?iso-8859-1?Q?eZIp2I/1JeTofC6psVuBbVpPI0B13L2onyJRDMfc71JkHQZixZ+Ao8wmjt?=
 =?iso-8859-1?Q?S8LFj2XGKrsj3SSx+lnvqXWAWhBWt0cmcK59wpa+WFutu3PqptgGkojr8l?=
 =?iso-8859-1?Q?bv3ajY9JJHE1lrF2H8/bGoFBqVVZGrBGxGrIdpzkvqygKOih7hFdXN9F6z?=
 =?iso-8859-1?Q?jol469xGIq+PKBUCGCg2smpYS+RmnRmOlrRpOap4KvQZ6Rif51TCPbE684?=
 =?iso-8859-1?Q?6BvhTY2yGwlvGzOcuz/PRSPy7Bqng4m/KaBYrYmQ+4KQwERgtcbhs7vXxf?=
 =?iso-8859-1?Q?+NzWnaQRVcfoh56qLkPW41gvdzmWxiI9LjlAagVFL9iwebQHX2jeK+3xdJ?=
 =?iso-8859-1?Q?MNQgoPNTRoIwdWUyGqU/x2RXn2xOE88rgr1zvHnvFRBrwt+/3lWXUYGX9q?=
 =?iso-8859-1?Q?q1IB249/VJk/hKi+6LDoDP7rjrtH8RZrJgbyNgOj/S9BCrhce/QVj7GMny?=
 =?iso-8859-1?Q?bI/8XJHbUDveknUGUcE+gHzBz6EqfBiWiwnVoG59CwsMpZVzbRjziPLiF6?=
 =?iso-8859-1?Q?WEn+ystFRw1uaWQiG4NGQF9o/XJ461u1DTBGZH/IaNXoq0wlZUot7vHb54?=
 =?iso-8859-1?Q?OdfNSZQnN/NZex2BGg9+iFPOMUqd0hNUSauttYq2KcJihrjG5E49C0TNX/?=
 =?iso-8859-1?Q?3tIQ4KtN/GvZf4+hrL1wwcxZngswyjqbafi4KoCYYkHW3GlQ2T39m61pFM?=
 =?iso-8859-1?Q?SS559j3qjvtX9mNvZKNLiMFJ27oJaV9gR/Pi0LWxARc/uHYC0FzKnj+MLN?=
 =?iso-8859-1?Q?JVbjR0QhbijlAyWnLT2onO0nFO9MCEtDgDhcJmRTD8UePTBckhgT4o0IGv?=
 =?iso-8859-1?Q?DNzrdpEa8q7h+0e9msE3qvYOUYuvQx/0LTH0Nsql399/Yetcoiy7tbxg1x?=
 =?iso-8859-1?Q?X916SfaqvchKc66i6DCc9VpekUpEQRvrW9TAzAdrSaESoegJov1FZX9ZBk?=
 =?iso-8859-1?Q?1mwxAqbyPtRXEOyh8XkkhCY1IbtJX7Nxru2CfI9o5QddT24WCXGR8hczao?=
 =?iso-8859-1?Q?QwHGG6XCgYbO5UiUQH1uEPE8sXS73GrxRrSyqfcTtizX151nHPl+LGhZWQ?=
 =?iso-8859-1?Q?S1qzWkO2Fkc5ulV1DcN7XUdblQgSxdHKvoUfB+5IbObCb8ZzIN5nxZJYE7?=
 =?iso-8859-1?Q?dY76siB6vcwD+edYoxhW9B/vR1+w2XIzqEHPu6Jtmxckwx0aRAUlZnBrZb?=
 =?iso-8859-1?Q?amDLVx5WPdwYIO/WQKvknsFLh6UT3a5MQ2NxGg4n8bU23ia8dTg8IXVyaQ?=
 =?iso-8859-1?Q?bOazGxFz5PRw8xgxeo1TtIROmnBIFgaHrY1GqYPeoL3n93NcNMulInymk+?=
 =?iso-8859-1?Q?tne6zlHp1ZOW3ysBABq5GbgHw++2MgqSZYgqH0Q1mojKMcRL4R+EHmR+o2?=
 =?iso-8859-1?Q?pyj37/tTHnluEp9Kx+vFexUF3odrqAN0jH/Eicr+Xk36FNWSkk9QDFvCLU?=
 =?iso-8859-1?Q?4o8eRhIyPQpBEo05rG6KowB+NTw1tNKT6HitjTuudesezOrnLMbq2YLylA?=
 =?iso-8859-1?Q?WkmAtvg3ws086zmrmgSK3p60C51KKN96utePuIGZhvgy2Dw7Gz6dhb3g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?VyLf78F2bjaAgz4Fk29itOFNOO0cyPBDQsVmuMF9URziQrQs1ZtrEL74mJ?=
 =?iso-8859-1?Q?hA9sxzJr9ftMXwhOKwMf4fJYBMLOJPbYdtlBC480FBtMNC7OxNdHIxm59y?=
 =?iso-8859-1?Q?AVee0YTsDxCTEvvP/ZhoTQZAFW1CROqiaLExjgAeCa/CGRyQViRAn6Bmcm?=
 =?iso-8859-1?Q?E2ECRJZO5DQCPHauRamQNXukG0la+H8/XT2nBqlGkxnH9iRJ3pI10hkdiR?=
 =?iso-8859-1?Q?sJ4HU+GVlKejrZrnv0Ifg4YOod4ZeYAe+gAKx1Q4x4pHcuoJbRXQkXqB0C?=
 =?iso-8859-1?Q?DCr2ja2Jq+kYbHt/UieVBJFsO3AqebwllsK8psgXyNj0zDQy7cXGKkWX31?=
 =?iso-8859-1?Q?b4/4IXcBqgIIjC/kTzN0yfpeIdbBcTd/PjPoYPIH3pjXxbxZ2KqpllZ3OJ?=
 =?iso-8859-1?Q?GuPzir1QX6kYOlahj3C8QKXfmetUQap7GTyOHnlQpi8s869xdEH4asJpiq?=
 =?iso-8859-1?Q?AizrEk4UYXvd/Frs3At8DqkExVrgrEZWXlcXllJUmo0d0XdWGT/0xnvCCI?=
 =?iso-8859-1?Q?qVDoM55q5m1MtlUUoI5+vZhuVOfh3nybwGOZvKYXS+f++tD2Pe0v4NAuEu?=
 =?iso-8859-1?Q?HHeqOErCXvHbZ2hdK6b8Ni+YSWHzkIS23/80hkGsrmLaooZZjqHfNeLFyG?=
 =?iso-8859-1?Q?v5z4Obni1ky0Qoy+T6elCEOVBBWLcDaUb43g83EN0IDIn1xW7OSZiZe5gP?=
 =?iso-8859-1?Q?5WknQIm57wZQABRm1gUmpWJjEOKF6CaKR7GqTJpY3ZwtzwfsX4dQt8RSCo?=
 =?iso-8859-1?Q?TungG15CnXfeUCdOjVUILNqRujTzApmIH/VLknAupPe4dmqumE2piJVEg0?=
 =?iso-8859-1?Q?nIuBn95vrdehO+5ottCEHv9OBEn0gZFKzg4qILM+px7q4xR9/9K0PdcOuV?=
 =?iso-8859-1?Q?2R9vHDJajqQx+wvIPzhzOxEaRGaKIHWpbxvaglCUVD/CRoTl3Ys8vl5ayG?=
 =?iso-8859-1?Q?1Iiu+Mb8jnwQ94k7fPDpXerLLMXcNeEh0REjbGJ3QML0E8OBRleGh/2ZQS?=
 =?iso-8859-1?Q?VXFDKQsvhTLegd6JT1Th5SR66cdxeKjNISeYKc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0383868-e724-4938-5cf7-08daf8336ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:19.6091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihdsyY913nlrM094iRldbP/q48+mo6j3KFe5M1BvdoZnecyo68XiCSY0UY9Tnj+uPUZb5VwxS+9pjKVUlGEElQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: CAhge6zkWoe2C1NJMMrL1AtaPlYlnb_y
X-Proofpoint-ORIG-GUID: CAhge6zkWoe2C1NJMMrL1AtaPlYlnb_y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Prepare for the removal of the vma_mas_store() function by open coding
the maple tree store in this test code.  Set the range of the maple
state and call the store function directly.

Cc: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/damon/vaddr-test.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index bce37c487540..6098933d3272 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -14,19 +14,26 @@
=20
 #include <kunit/test.h>
=20
-static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas=
,
+static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 			ssize_t nr_vmas)
 {
-	int i;
+	int i, ret =3D -ENOMEM;
 	MA_STATE(mas, mt, 0, 0);
=20
 	if (!nr_vmas)
-		return;
+		return -ENOENT;
=20
 	mas_lock(&mas);
-	for (i =3D 0; i < nr_vmas; i++)
-		vma_mas_store(&vmas[i], &mas);
+	for (i =3D 0; i < nr_vmas; i++) {
+		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
+		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
+			goto failed;
+	}
+	ret =3D 0;
+
+failed:
 	mas_unlock(&mas);
+	return ret;
 }
=20
 /*
@@ -71,7 +78,7 @@ static void damon_test_three_regions_in_vmas(struct kunit=
 *test)
 	};
=20
 	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
-	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
+	KUNIT_EXPECT_EQ(test, __link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)), 0);
=20
 	__damon_va_three_regions(&mm, regions);
=20
--=20
2.35.1
