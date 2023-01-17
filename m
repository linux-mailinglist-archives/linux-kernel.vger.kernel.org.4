Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78666D45F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjAQCfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjAQCfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112742B091
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H093bB023167;
        Tue, 17 Jan 2023 02:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Cmac1MFdopFe4FQG1oWkYqzoTR0Iob3h5RL8j18i6lM=;
 b=JAcRayxLxZ/wsWX/QpuqV17sAJ6XNYbxy4PKFy5OhSbiNTfP0EiRH95KFtojmmh0fRjR
 ZrQOY5RzJK/nG0OjwfSGwoOwklBb9T5B+6hQTjBtnUTyQBDTrsry+BuE63iO9yqONgju
 SRPUWmY1RYkiy4XTC429g+KAJg/hxaqLFGMg1VkmsZ/tVvwDHd+L/Y2gYPAdJr/pV/YK
 /O7wXA7USITz74RXt314CCFeRVQltSd+kQ+gPuHEVJQANCbO60Ie4/y9TzOKf7qtCSKm
 73Z3wcIbgFfz1pSyX7fsWCy349PE/TjdDiUkQLVhcKIn7gLH/AdxABVWE2NhvpBArGOV 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNor96020620;
        Tue, 17 Jan 2023 02:34:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq37hb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1IOGgbSMeS0ssoILXNFmC4KlwN77M/RjIy2wkKnFk9/UAgieFgvrzQOnAO/FemszX0aIypmMErsOlLE7clzlB+cXWMJGt41TPdeqIorEuM9NcNRJ57s61UviCBBIwJPjBQgUAjI44KzIQqG59In02nlJHWvxIzZwqp54rSx81uL+ZtgZyqmNLNMRfcpTpQiRUfLHvADaRgmZbVUzyt0s2PUbpyiNuscEq3KorTGTPR3hjN448PJERN3qrvbSR8sUK8OjXSrElnl0VkoZqyMZfBnwLRaFkaqd4QpJnnGmjuqoGklhMMEvt6pIR6C9j/rvq0CetB2Fm8SwwVUS4SjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cmac1MFdopFe4FQG1oWkYqzoTR0Iob3h5RL8j18i6lM=;
 b=fncDp+LPj7IOLTH0ssZOGwFAF0CEokZac2rospZ/20FkF89u+GPM5yfTADpwZ81FC+pRsKS11KrSYnbIFl8fvUhSH74tXLKlYmlyjIEKZUAE1iU/RIhchBg2ZQtVnIqmKl9CAO/oYwybueof770ZPL8yeFaHC/W/GG7GX1GSwcku+jdUVDqBkjqfkmtBWp/R6XwjGEXfJJoa7+8KXuUa5aGGwMfwO10VfTyAhAnsTgMwvjgNm7eOp6lDcPmdozJ+h4WMxkbXV8apj8aCZ24evOXhSVeOO2/nS/a8Ys4LGb679a2PwG3yjQfdWvs4oLBQ1kHHP/w12WIjegBZBa7xKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmac1MFdopFe4FQG1oWkYqzoTR0Iob3h5RL8j18i6lM=;
 b=Hkz42slXHDVUdW24a3C+WOhYLARbieU4omFxGYbR7rpNoI22zV2eyMQnswUo2szkIReMYeyRgWJlsckhaZQHXbd0cjdVA0liyjPx7yedlbIvIKpGjQSgoBaDHd48JIMfocTx5hLhDXJVDZ5XXQqSTBna5WHYv47taOPvM5eLH9o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 15/48] ipc/shm: Use the vma iterator for munmap calls
Thread-Topic: [PATCH v3 15/48] ipc/shm: Use the vma iterator for munmap calls
Thread-Index: AQHZKhwwDJZwzI/fykO13z9qFmrIRg==
Date:   Tue, 17 Jan 2023 02:34:14 +0000
Message-ID: <20230117023335.1690727-16-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 1de0690f-3786-4753-3108-08daf8335407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRipqpfRzXYN50faoQg1d8N3BGWWxcPBRyCYTexNzODW2xBrMDIP5iQrIa8PDLY19XPQW1w2hoTHpIK0wdFNuVnMus9+fIQ9MfP8rJVZSXdx2xzgm8QbOn/6QaPstsxbrsdYxQBIFirvNoXozpaiNtPc90KRYqkzp3HTpp1ELv7DxLEWmvnB+u5zGUFo6xe2DOK7HsNy17KEFdq2GYBCvOfiSQwmKpmWJA1hxdOi/glTSA1Y74Xa129S9Yt9pededGvt4C1ElK4FYLLSG617nUDLUb+unZGmZupL2Ta+XzI6IwxTTsKBKOVknKHqTqF1vrIzazSOG++c/JKXZX44QvDGaKcJ22ZzkNv/UGPWxvoZ4eCjITjqjAJ+ZbKq2MSHwpDZzi+dtvoJn60MUUUJejVfidNtsYnbu37eWp8TjdGFjMMYbp46VQSvvA6RUm/woHjhQ3AH6GUA+OhLkj0o1m8a/Y1t/EqnFDXffTMe3DhBmBzeUMJozuBWIs+1UUrRLMh4idWu3aWSZe2dIGXJtzVjxWFww80zeDYFYMS0keHco6Kgdoz+JZwIbhdTJvH1J1UEMUng1WMH3bPfKQJPuXxVcFn9/7bsTBXBtAm3pn2E8DssMrcoP5BzXkjAa29GotAdOWmF3Z9rWqRJr80yvCbxQsZ/bF9wqdKBbiSFDv+GJizTEhs23qD6zPdupOHV1+IcwG3HhiyPD8DmWvrx2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(2906002)(83380400001)(38100700002)(122000001)(478600001)(54906003)(71200400001)(316002)(107886003)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MgvuotZzmfhdHDUydZUIZvdZ9jjwdfhoIWjQGKaRXli5mW9GKQDKwtlsBi?=
 =?iso-8859-1?Q?vz9z2bKfVbwRBalYNRtfW5nMgfd3oWqRh7tCPvBm0N6Ne1xCbZ0Ez/TJ4j?=
 =?iso-8859-1?Q?SKKizccmRuF8zzDqHv6NTifqQ+jOn75jicS3PU/i+OzosIgHJUCh3kxzXy?=
 =?iso-8859-1?Q?bZcwWdvxGn0zMcScOMwGwm3RadRK2Atmd+H3/0QLkDQMoPItvR+O2RYoh5?=
 =?iso-8859-1?Q?KVC0EzVjPybck7uVcaqEmiFhfUe2wbumQe12olUkB7HMPW1AkHBEjavaVe?=
 =?iso-8859-1?Q?MIpmbIpdK2dBfcvop0jYUIqsHA+vchvPO8i8sRjIZxE8OVwmrZh9VEzUmg?=
 =?iso-8859-1?Q?k2oGMdP/HOXHDV/XseD3d/jIz80MLwk2PYeplJkYBhcKd4DjBTs0XwcBp4?=
 =?iso-8859-1?Q?4/TW0LallEqY/UPq8/IRAmGWSCezUT1oI4VOpF+cMdS67+33FlzaJm5ra2?=
 =?iso-8859-1?Q?uSQgMjC2B5RqdNhrPozICl6kHInBqINdk95G0adWtfcEj6gsn5FvVyMMhu?=
 =?iso-8859-1?Q?ywIPI6xhUTF0NHcsk8B5AbrMZQ66zVW9YOlNF+0BFRLE+JyWTCNfDde2h7?=
 =?iso-8859-1?Q?FaoWLtAr8j81oVKeoqpgy/iUR6FqYmlVW10KLfJQzZcYppYBjgTzxzi1f+?=
 =?iso-8859-1?Q?d+GvzTCh5zcxdUjMeFvvJ0x3GpvoXZ2DJpuSGV7JoSeKjYA5QwwKfSWLSK?=
 =?iso-8859-1?Q?znF/IX1KuxHUBIzOJfF3Q/671i0rxAHoTlfZgzFLcX/ekUZpUQ8cuvmfiz?=
 =?iso-8859-1?Q?6J9wFZ0LsaoimttevnVuj53YJWgx0IuIHNBgFwcBkfNGRBfr8fN/rBlGtp?=
 =?iso-8859-1?Q?UkUjPkRdvdc2qEtX4/q2ABKYgTnOmCjTcraMcNUeoUzGhQTvPHZin/w3Pe?=
 =?iso-8859-1?Q?NyWoa619+2bJMq0WGVdq2pOYoHLYQE2MXDQnpV3tQzxqWOlLokJvguaRVb?=
 =?iso-8859-1?Q?Zj2/cpHMCIoz7Kx300tVv7a87h4Jbh9xlok6SscNXJSVWqrNeBb3nnUu1A?=
 =?iso-8859-1?Q?fOUDXXoNEOANH+DIk7z+9kg//7oAd7rd3fro4ecFwDDGxWOAcTkerkMbki?=
 =?iso-8859-1?Q?sUWedAPYJ/UV1gfsJ8F6P1MGE9p4N5KG7bYmGkiY60k8l/znt0LgA0a1qu?=
 =?iso-8859-1?Q?F1l1JnLNU0spg+QXnVHrJUKXXSL5OpCtXM9me+vUNrvCH09VqkVnVZWpqN?=
 =?iso-8859-1?Q?OEZB65yHJXydQi6sqDgWJVrox3/nG1SyJh/j/Kv4d280EcIr5JFP/TPoBK?=
 =?iso-8859-1?Q?d2oPh+FLRw5Opjx8Df2ndCmngmxF2p425r5NMk/hQQaOKZ8MrwlZn342dM?=
 =?iso-8859-1?Q?euccsC5Xyr/H6njgOryr4bRlv5Di1BmI4WyBR+CWdpndW6udUq15OwbnnJ?=
 =?iso-8859-1?Q?LPYwv/RVRnk3HMyYAu6d1cMlkRb4GDu4bJIfU0IYe5HSKrh686SQum/l9w?=
 =?iso-8859-1?Q?SUqvx6Fz2y4dapQ96lEulNuXUKeWHw4LVgudujzYcNMoeN/d1lIm04uwPy?=
 =?iso-8859-1?Q?t1IttMCmzXsE/EudPd7wcjYsi/YiOircz14Cs4W/9dUyX2LvZc8n8WQUv4?=
 =?iso-8859-1?Q?gMIBO4MFZLazy+lg0kmJzgkQN0eLjO8kz5bUCmr9RLjBLhPJzjhcvA2icu?=
 =?iso-8859-1?Q?vOzMWYn0Bl/0raX0aHqSele2yO4leU5y5UzHJzbr0BpgAAZMyAzm7jfw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PfUDXBhXXZcDMmhjgd1bmOfGEJ51jg3qfSOdkXn0E3WH9mpJI/FgYA/3uzJmwr+w3UweAAJyF+XNjbYmwRr1KHN+cxOGvfv5A3CkE2J6K5BwujkBN20BqqzxjN+CicbIhPHpsjNOH+dBVf17wbJregyTp07gDfi76M/sYjq0c7mWHDQCJQn+Lm6WTFcZXTlfw3jaS5KQZutYM5tajVGunUCLgQZwhP/bw7NeoigkED8YzWWyLbouesZE8mpEyi2AEVAuRHhnFsJl22kfXZtU4pZ7v6VVeMBaV4yGUTD/yrwEsQzZ4NBMtyE4Cg2JzhCuVLOfLp0w6iaR9T8EcQife+Ibhn1rSnEy+3nx4wusBiHdQHqI0VVskiA3od6TfNbKv9xDE735wNkT3OAEcvLpLsblhBBPdYMXrFYfVahXLFbLqSlYnX/mgwekCGM1GzFTzRbVeNDGJjzIlH1tTReJm50cCAgtbhDG2BHANRftH0+6jDKmhG91fFUBzW4qrqxIXNDIy/+a3+HjojshCb4HParoymdlWRtjXWj1rDEqn6JnC8JS0FXiR4QyKIizDpzFJb4wxEyeOz92y0V2xtNX5LQfezJiJsFOAASB8XF55GbyO0Sz0eMJdLPR7Pxh/3ax2ZbCmetf6UNPCAjM+NQIuwtLUkD0tDy/ADcn0ksG2j7gicaEtg6OEYNes93jN0DWoI28X/ycRISVwU3njXlsbrw+GR26kWqUd7rfE8u5n1LakwqS1eLg9IRiimdddoPB+LFf5ffj3Gi3vy00LUre7O5/b4UGGRYin6YpGAtpwU5YUAOR9BW4Ioxt5pYCTrXeYKyn2pt+vFklmqm2pPylOOvAssKvDRnZaZ1VSwNLXszPPruBf55v05XIVL1Dx70XOeTweSk6dS0km1wkoJj/zQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de0690f-3786-4753-3108-08daf8335407
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:14.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Erv3XpLtV65737wcmpUnkUmxIf1gKRI14D2y247TdzpqGyACmy0jd+ueGxux4a1slw6Y1OHPyolqAHo0zKbMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: tYjrD7L_DhGEphl8Brb-RImUZXj-Ubwp
X-Proofpoint-ORIG-GUID: tYjrD7L_DhGEphl8Brb-RImUZXj-Ubwp
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

Pass through the vma iterator to do_vmi_munmap() to handle the iterator
state internally

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 ipc/shm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index bd2fcc4d454e..1c6a6b319a49 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1786,8 +1786,8 @@ long ksys_shmdt(char __user *shmaddr)
 			 */
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-			mas_pause(&vmi.mas);
+			do_vmi_munmap(&vmi, mm, vma->vm_start,
+			      vma->vm_end - vma->vm_start, NULL, false);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1810,10 +1810,9 @@ long ksys_shmdt(char __user *shmaddr)
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file)) {
-			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-			mas_pause(&vmi.mas);
-		}
+		    (vma->vm_file =3D=3D file))
+			do_vmi_munmap(&vmi, mm, vma->vm_start,
+			      vma->vm_end - vma->vm_start, NULL, false);
=20
 		vma =3D vma_next(&vmi);
 	}
--=20
2.35.1
