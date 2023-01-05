Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAE65F458
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjAETWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjAETUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D686F94A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:59 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ITbK9025520;
        Thu, 5 Jan 2023 19:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8X42YIEluPVSvQF5e57VuXQC/2wRI7tsq11bZj4u7qM=;
 b=iDzsMY7Q6+80BNR7KP/iuYl8hEnMTzWtGW7Ajkk/6cJ8PAix9lFiIRXMuV036BcXQYD5
 fhQjZtmjmHeu+Gs+31Nsu8yRgtdDfZyUufojUb/H7e9XN6Z37BeYcuV0SLUeHQQp3gDE
 TBL1dod5W+gb+aKycsPPtbTQ0JMVwyUDkA07QyzR055ss7xsp92tOs7AuFx/bPrcfEYZ
 wiM8XSK9h1sQl20hUsuUf3e7rxmi8VoTLwqev0Em5BS+kQPJE0f+HHSQRTRqWYzOdH/p
 7K4gqj/25T9zxcw02gpLrs3kiHd0P2nBzAgZKWNBX3+cB2tDEDBCyukBfAjRFNeGRoxq YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmtskwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I9Tnm012151;
        Thu, 5 Jan 2023 19:16:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0u4xq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1CiDUApUpaWDaQqjIgTfPS+GyGILO6JTPcv9j+FGY/NP2NqgVlkc41xQZlAvaT+mk2rawjFR6hfSZXT7vvcUHlqzH9v1vRH/8PdWlZgERVd2KarwMx9qyjxo3iENf05BCvM4CZshvV4p1PFoQl2jPj6a4U2DalFHZSVLP4sEgJz8kxiU3C3od+I3L5kEmU+1/xPXT3w42+onFTIFCY5gy58ZIZGE2xrnL2IEOINEwcwFhUqf7jnwEih325m1NLQ5DfsYf19kBV3bBnZs4l6eDuqd8pb5/GPE1ELntjHmNPlreCXByEz9a4vOsJvWjVddYQC1rzqfz72y8xrPPjSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X42YIEluPVSvQF5e57VuXQC/2wRI7tsq11bZj4u7qM=;
 b=kPKK+A9hE/XHsFQRdKDaYjJDp9DPQAZ1KYxMcq4lSC7sFrB/TUltplLSvIXpjUqPemG0YVxML3DYXlihorkR9X4iuzmuu19KIgOgdJ/M3JQuB1HvTC2piPncNH/CXDXSCylu56xIOjoNtv/JP0ypn/w1Ir5sGl8ma1Zwu3JbNqJ+/aBZ874phuq1pDH4KbaMdPdAgMRbHRDF+nBOy3VGiV+rdKRMYnX0kK8gf2u1BK6OMXoesqBFgRf6riaby8W4ohhXe3qTxmfdxC4JW4HiqrHLFW8Xf36Tz0g1FcMZ7gGEoW8JBEHGXP/iDsOFXngSHhsfaE7k2gdKQCwhLnDLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X42YIEluPVSvQF5e57VuXQC/2wRI7tsq11bZj4u7qM=;
 b=cqs5DU6PYkOcWJeI2xqtKAv/M4wmZfvWim/RqM1BOC5LzDtoYvv7JY8l1s/Rs5kVnSp9ZMHA8Jx+6jjEqSD/VJp4xIk6/UKLma6ceI1+iDAmDtrl/5i65w0nudwOi+Rxxk7nK0QP5MOrPqBTS8ComkZRb4gOwEyaNS9bQ253dz8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 43/44] mm/mmap: Remove __vma_adjust()
Thread-Topic: [PATCH v2 43/44] mm/mmap: Remove __vma_adjust()
Thread-Index: AQHZITooQKNu+CQr+0yyrT4FApFQNw==
Date:   Thu, 5 Jan 2023 19:16:05 +0000
Message-ID: <20230105191517.3099082-44-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: 93297b97-5ee3-4d76-cb3e-08daef5160f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7Rv6rHpcbPIwbY71MW3D7BddYjUyJAEbK0jh4NJDoQQuIB67kB28b+V09P0vjnchB2tewoTISWEIuxHaYCD//POk0NAkuIk8rsMqAv7Q4AeaetUzivBvCtsuhC7bWvl5urkwqkC6AYtyPmJu2xvdP2ZUhGCKJFciuK0FchKtYONiSkfGKLS/GdiZCq5oJ9dxnSKjlMzalJZJa8AAWLXj/qHJUIYDKXSJVpQ5fIoyCiliuucsBe1Aan0N3tZK0ryhOkNb/eI7zUzRS/Dip/boofwSbU2g9FoeAQusm4PXe+DrUfeNs/Doxydgj36EU4d/YtoRp/oSlgikkvUFOQ4Q/fGdDjBIQqbLSfkUHImXdI1jOvKoeyDIP0PdIBQa+kso6GReOjhksaS0l0Ltrf3vU0CJ7qg0LWLWcZ0FkSvsc+KVcauzqrOpYZGiWq8cyow1Z9yjk4vWeTVD1MkAl8oAXngZQkNcEg7yS9Qxgfpzq0qDlz06coB1YVkUAj9ix5Fagv7BU04BXi57/u5z/YgyaRp7sA42b5WCUGW5441iUJn+C2diVoYGZcwggTY4slKxsIfVgBFLyE+vevTgufn3KmvIQHPGCCzkKTYaFoq3A/cr0/Ygl6ig1D0ssj3+FDPfwCpc+1rdXtG1o2pLn7Jc146XH0T08oWVOrSK+WirM1Lteo1K0fBPYJyiyy+VNaMHdPpoVsC/y0BW0Tuj8lKww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(30864003)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R1R+ujTk5Ydh/QC4tVRKmvbW63JXPtpo5/+90bvz/EcvTaR0yvdxuhZp0u?=
 =?iso-8859-1?Q?GWb6KzlHlq4fQEHUeNHhttBSM/pE+/1sQy2VPkNVcE6rZFVo73q5VOnXs9?=
 =?iso-8859-1?Q?MQN/WK35jFGSvEnWt6J4B4NLzmBkabdTOS1tN+DCwvwI2UoZGNcp48JZAp?=
 =?iso-8859-1?Q?AODOn93ehGsWDLVVDkDzaiQuwlBq8vEuOUW99XtOOQpKai3XPaY+FFHXsx?=
 =?iso-8859-1?Q?O6UOK81lU6S6QdmCX8Gm35kCBSgMmLYJVhRxUxPjgsJcNHRslqgMHE9CYN?=
 =?iso-8859-1?Q?kgLzi8cfus1yIqQ4GbrMfCrwsYtMyHx3P5YApyvZViojS1sg03URnm0ph5?=
 =?iso-8859-1?Q?JfJ6QQ2xojUeEpj0kxMs2JB0hOmuAl/Km001x860ip4mi2FxEKXQMEqaxJ?=
 =?iso-8859-1?Q?txnVH0ZeSRRJj+0GimoHieCLL2EeR9w4DpOXbpe9wjJJkvyfW58EaGzb3r?=
 =?iso-8859-1?Q?LasH/YnFc4WsMII5n+q2sM8yYF3yT1Yk2G6h1L/YBKWErqcZd5EgjhJj2M?=
 =?iso-8859-1?Q?tsCcNj5Nk1jpfPQXbjI0loAy9wM/rIjA8D4jYlVSTYsKuA4dsIt3F+0foG?=
 =?iso-8859-1?Q?OqP49FbD2Vk1asB7ktF316ZZpuHqH1boqMuOLJ2UQAgzfT3HzbCu/MND7K?=
 =?iso-8859-1?Q?srTyzxZY9LnXbDKrFn3HlzxIwr5v8uoyQ0bwsRbCzK65qQ0wA/R6U9kRcI?=
 =?iso-8859-1?Q?jMuyU5Eoco72ehKd34znf/cdKyKIcD9fS6fp7kEUT5lb0BjATXy1Ojh2ak?=
 =?iso-8859-1?Q?NehNNYNaiFmQrexh7ETtIv/epezF2Zc6ew6LfHEq8x3zFfG05z3orIddCi?=
 =?iso-8859-1?Q?jlc28BdI/o9pAmjXPgmQqCd3uyk47PvvoQYfGC95IodmAW2+7vPi4gqDgL?=
 =?iso-8859-1?Q?3MuBM68q+n33dFUtEqPAmGeZ8Qim78rLX6phLV+n42NlkiEHbeH9R72yYR?=
 =?iso-8859-1?Q?405w6bN6bAHi0Qh9TjBp1A0pnN36kH7Wxh5hV0akqtdWR4FVUeVABe5tnJ?=
 =?iso-8859-1?Q?bm1ykApklHV7FZkQqRUIOQIuzKiPIilLJKlIQ8pZI72jC/M8bxKf8rrUww?=
 =?iso-8859-1?Q?t2KuCOFqntk3S5Lt6GVRBwf8SfXgQEgHbPzvky/h2LkoBzg1e6KJqnhAbX?=
 =?iso-8859-1?Q?MTjlv93B/LBa0QYaMyMQV6jForGpRHXNSGUfHbkOzHWHa2TqGjvXHOKWyF?=
 =?iso-8859-1?Q?GA+nd3V/Kll8WN5QO7C3+7wroEDeo2S3aAZey9sNu3hm5YW8d35HO6SsP8?=
 =?iso-8859-1?Q?bT/ygQp40NWEF8TcpkNIydyETxU2d5safWKXRiLtVbrZOXY19rX5aIiVNV?=
 =?iso-8859-1?Q?eERC+6Hu/NX28y9wIgWqSvMCkTbyIxmenVCdRjkug298XZhKvKKCL847IK?=
 =?iso-8859-1?Q?AktjLshWfq2dZSYFf+BfLOLHU1oegJ8yzO2rcFTf4iv0UqRBYuJIjZbBQU?=
 =?iso-8859-1?Q?feba8k63K5cJ4YBvx6EqgY//Yw+kbD4VcbEcTphiEXrm48th2qBgA19wUq?=
 =?iso-8859-1?Q?XpQyybXuHm4E+GiDVtzubc6cbwOKwQhjg+afB+HiXwPzooNPSt4oxIuHjn?=
 =?iso-8859-1?Q?HB4isixLBvlnB0siWxjgEp3xglvpZQaJmSK70Ndy+vDFJ6pTET950Vqu+1?=
 =?iso-8859-1?Q?33uIh5wPXxXGvpkOzg39J/BN9xc5PXPcUD8tAOpTXetzO86agLWmghcg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nTBu+4+vhB7Bxnf+tmNUaEGCthsgPpsrWJC0h+Lsn6YWPolGGPgoKSq2q4kaqSAIG8K0R/FGOlwjDvrT1ERpTFGKSo+Jiao+aer28bKDZAwBR4jX7zdJx43vLUxM8UATeK14WL83taTkd34qRDtXK4JUKJPFaS6vEXDTU5w5SbqYy1gAuq8I780GdAZbPM7uTLCe39lGEtZxemn9bKU7iiS1q6JKYRoHix3tbffVaGoo9OPFBIrT4Crv6ePJ7xU+wxvBKW9mBmonBQxHhixrWae8GDtaNydfyb16ZXTthBPI5pH806jTxCWXj3PcpjjhPBUW5l8LkgrM9pkratg+pgIqCdPr1dInwtNkxnD0qQmhRZbDuP2yI6Z0UWLMZwfsIkQPahkyHng5bqdwh77v0C1nBM1weUmEhIBZn1AQMLgI0mg+NPRD//8lLFmga74sPbKtKwR0vZ4JfBuHHVkAb5A2Kc4Gr4e75erE/NBMKgxEKD/iwQWZZmghKGAnKw6tyw8ksFBz7bysGLU3/e760xEOcODAKPAHEa5DcsePkGMIqNMQuIaGxn+BCTsW7/F8uusRraEAuqir+j6lJYhzrjDC8UVIO9/CGUo0Rhl4R0xNYjrKDWRvbj25RBYbAdVw1A5DWdQ02n4eSwUziawaqxwoDRo4MNgPNxlJ7bU8zbZXuvEnuCvQq5eCdel2rpalb04xqRctnk5czjVpwuQ09RoJt0NmYKczAOliKCxnt6OhQHTFNXVjyfXvhD0YPe/0LOp6bSJifqXjbAoPxeFh7Z9X/j2UUn+ilb8030llPuw9i39ZHTckeXSpKH52z2/Fqu6WZorcCrUPb0UNa9q2mXkmXYcMV/3FW+aeUgQUdHDuP6+75zE99zRjJWmuBD4HHpCi/s0sERwjBVoQupaHDg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93297b97-5ee3-4d76-cb3e-08daef5160f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:05.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKtwm9F+urO/eao1ou2ze08zfLB2YDKHwrXbP5iD7wXMCQ33JlEEcAaBJQfctPDJLBOGvOy6NHGmKbzHeE5/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-GUID: QYbyHldh5EGBo_nHIQnNr384sB1lkxqw
X-Proofpoint-ORIG-GUID: QYbyHldh5EGBo_nHIQnNr384sB1lkxqw
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

Inline the work of __vma_adjust() into vma_merge().  This reduces code
size and has the added benefits of the comments for the cases being
located with the code.

Change the comments referencing vma_adjust() accordingly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 kernel/events/uprobes.c |   2 +-
 mm/filemap.c            |   2 +-
 mm/mmap.c               | 250 ++++++++++++++++------------------------
 mm/rmap.c               |  15 +--
 4 files changed, 107 insertions(+), 162 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..c5d5848e2c3e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1352,7 +1352,7 @@ static int delayed_ref_ctr_inc(struct vm_area_struct =
*vma)
 }
=20
 /*
- * Called from mmap_region/vma_adjust with mm->mmap_lock acquired.
+ * Called from mmap_region/vma_merge with mm->mmap_lock acquired.
  *
  * Currently we ignore all errors and always return 0, the callers
  * can't handle the failure anyway.
diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..fe5a4973718f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -97,7 +97,7 @@
  *    ->i_pages lock		(__sync_single_inode)
  *
  *  ->i_mmap_rwsem
- *    ->anon_vma.lock		(vma_adjust)
+ *    ->anon_vma.lock		(vma_merge)
  *
  *  ->anon_vma.lock
  *    ->page_table_lock or pte_lock	(anon_vma_prepare and various)
diff --git a/mm/mmap.c b/mm/mmap.c
index 6dd34e5ff1f7..a8dba6b6c34d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -802,133 +802,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 	return 0;
 }
=20
-/*
- * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
- * is already present in an i_mmap tree without adjusting the tree.
- * The following helper function should be used when such adjustments
- * are necessary.  The "insert" vma (if any) is to be inserted
- * before we drop the necessary locks.
- */
-int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	unsigned long start, unsigned long end, pgoff_t pgoff,
-	struct vm_area_struct *expand)
-{
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *remove2 =3D NULL;
-	struct vm_area_struct *remove =3D NULL;
-	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
-	struct vm_area_struct *orig_vma =3D vma;
-	struct file *file =3D vma->vm_file;
-	bool vma_changed =3D false;
-	long adjust_next =3D 0;
-	struct vma_prepare vma_prep;
-
-	if (next) {
-		int error =3D 0;
-
-		if (end >=3D next->vm_end) {
-			/*
-			 * vma expands, overlapping all the next, and
-			 * perhaps the one after too (mprotect case 6).
-			 * The only other cases that gets here are
-			 * case 1, case 7 and case 8.
-			 */
-			if (next =3D=3D expand) {
-				/*
-				 * The only case where we don't expand "vma"
-				 * and we expand "next" instead is case 8.
-				 */
-				VM_WARN_ON(end !=3D next->vm_end);
-				/*
-				 * we're removing "vma" and that to do so we
-				 * swapped "vma" and "next".
-				 */
-				VM_WARN_ON(file !=3D next->vm_file);
-				swap(vma, next);
-				remove =3D next;
-			} else {
-				VM_WARN_ON(expand !=3D vma);
-				/*
-				 * case 1, 6, 7, remove next.
-				 * case 6 also removes the one beyond next
-				 */
-				remove =3D next;
-				if (end > next->vm_end)
-					remove2 =3D find_vma(mm, next->vm_end);
-
-				VM_WARN_ON(remove2 !=3D NULL &&
-					   end !=3D remove2->vm_end);
-			}
-
-			/*
-			 * If next doesn't have anon_vma, import from vma after
-			 * next, if the vma overlaps with it.
-			 */
-			if (remove !=3D NULL && !next->anon_vma)
-				error =3D dup_anon_vma(vma, remove2);
-			else
-				error =3D dup_anon_vma(vma, remove);
-
-		} else if (end > next->vm_start) {
-			/*
-			 * vma expands, overlapping part of the next:
-			 * mprotect case 5 shifting the boundary up.
-			 */
-			adjust_next =3D (end - next->vm_start);
-			VM_WARN_ON(expand !=3D vma);
-			error =3D dup_anon_vma(vma, next);
-		} else if (end < vma->vm_end) {
-			/*
-			 * vma shrinks, and !insert tells it's not
-			 * split_vma inserting another: so it must be
-			 * mprotect case 4 shifting the boundary down.
-			 */
-			adjust_next =3D -(vma->vm_end - end);
-			VM_WARN_ON(expand !=3D next);
-			error =3D dup_anon_vma(next, vma);
-		}
-		if (error)
-			return error;
-	}
-
-	if (vma_iter_prealloc(vmi, vma))
-		return -ENOMEM;
-
-	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
-
-	init_multi_vma_prep(&vma_prep, vma, adjust_next ? next : NULL, remove,
-			    remove2);
-	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
-		   vma_prep.anon_vma !=3D next->anon_vma);
-
-	vma_prepare(&vma_prep);
-
-	if (start < vma->vm_start || end > vma->vm_end)
-		vma_changed =3D true;
-
-	vma->vm_start =3D start;
-	vma->vm_end =3D end;
-	vma->vm_pgoff =3D pgoff;
-
-	if (vma_changed)
-		vma_iter_store(vmi, vma);
-
-	if (adjust_next) {
-		next->vm_start +=3D adjust_next;
-		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		if (adjust_next < 0) {
-			WARN_ON_ONCE(vma_changed);
-			vma_iter_store(vmi, next);
-		}
-	}
-
-	vma_complete(&vma_prep, vmi, mm);
-	vma_iter_free(vmi);
-	validate_mm(mm);
-
-	return 0;
-}
-
 /*
  * If the vma has a ->close operation then the driver probably needs to re=
lease
  * per-vma resources, so we don't attempt to merge those.
@@ -1055,7 +928,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsign=
ed long vm_flags,
  * It is important for case 8 that the vma NNNN overlapping the
  * region AAAA is never going to extended over XXXX. Instead XXXX must
  * be extended in region AAAA and NNNN must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_adjust drops the
+ * all cases where vma_merge succeeds, the moment vma_merge drops the
  * rmap_locks, the properties of the merged vma will be already
  * correct for the whole merged range. Some of those properties like
  * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
@@ -1065,6 +938,12 @@ can_vma_merge_after(struct vm_area_struct *vma, unsig=
ned long vm_flags,
  * or other rmap walkers (if working on addresses beyond the "end"
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
+ *
+ * In the code below:
+ * PPPP is represented by *prev
+ * NNNN is represented by *mid (and possibly equal to *next)
+ * XXXX is represented by *next or not represented at all.
+ * AAAA is not represented - it will be merged or the function will return=
 NULL
  */
 struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struc=
t *mm,
 			struct vm_area_struct *prev, unsigned long addr,
@@ -1075,11 +954,19 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
 *vmi, struct mm_struct *mm,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen =3D (end - addr) >> PAGE_SHIFT;
+	pgoff_t vma_pgoff;
 	struct vm_area_struct *mid, *next, *res =3D NULL;
+	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err =3D -1;
 	bool merge_prev =3D false;
 	bool merge_next =3D false;
+	bool vma_expanded =3D false;
+	struct vma_prepare vp;
+	unsigned long vma_end =3D end;
+	long adj_next =3D 0;
+	unsigned long vma_start =3D addr;
=20
+	validate_mm(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1097,13 +984,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator=
 *vmi, struct mm_struct *mm,
 	VM_WARN_ON(mid && end > mid->vm_end);
 	VM_WARN_ON(addr >=3D end);
=20
-	/* Can we merge the predecessor? */
-	if (prev && prev->vm_end =3D=3D addr &&
-			mpol_equal(vma_policy(prev), policy) &&
-			can_vma_merge_after(prev, vm_flags,
-					    anon_vma, file, pgoff,
-					    vm_userfaultfd_ctx, anon_name)) {
-		merge_prev =3D true;
+	if (prev) {
+		res =3D prev;
+		vma =3D prev;
+		vma_start =3D prev->vm_start;
+		vma_pgoff =3D prev->vm_pgoff;
+		/* Can we merge the predecessor? */
+		if (prev->vm_end =3D=3D addr && mpol_equal(vma_policy(prev), policy)
+		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
+				   pgoff, vm_userfaultfd_ctx, anon_name)) {
+			merge_prev =3D true;
+		}
 	}
 	/* Can we merge the successor? */
 	if (next && end =3D=3D next->vm_start &&
@@ -1113,32 +1004,85 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
 					     vm_userfaultfd_ctx, anon_name)) {
 		merge_next =3D true;
 	}
+
+	remove =3D remove2 =3D adjust =3D NULL;
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
-			is_mergeable_anon_vma(prev->anon_vma,
-				next->anon_vma, NULL)) {	 /* cases 1, 6 */
-		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					next->vm_end, prev->vm_pgoff, prev);
-		res =3D prev;
-	} else if (merge_prev) {			/* cases 2, 5, 7 */
-		err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					end, prev->vm_pgoff, prev);
-		res =3D prev;
+	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
+		remove =3D mid;				/* case 1 */
+		vma_end =3D next->vm_end;
+		err =3D dup_anon_vma(res, remove);
+		if (mid !=3D next) {			/* case 6 */
+			remove2 =3D next;
+			if (!remove->anon_vma)
+				err =3D dup_anon_vma(res, remove2);
+		}
+	} else if (merge_prev) {
+		err =3D 0;				/* case 2 */
+		if (mid && end > mid->vm_start) {
+			err =3D dup_anon_vma(res, mid);
+			if (end =3D=3D mid->vm_end) {	/* case 7 */
+				remove =3D mid;
+			} else {			/* case 5 */
+				adjust =3D mid;
+				adj_next =3D (end - mid->vm_start);
+			}
+		}
 	} else if (merge_next) {
-		if (prev && addr < prev->vm_end)	/* case 4 */
-			err =3D __vma_adjust(vmi, prev, prev->vm_start,
-					addr, prev->vm_pgoff, next);
-		else					/* cases 3, 8 */
-			err =3D __vma_adjust(vmi, mid, addr, next->vm_end,
-					next->vm_pgoff - pglen, next);
 		res =3D next;
+		if (prev && addr < prev->vm_end) {	/* case 4 */
+			vma_end =3D addr;
+			adjust =3D mid;
+			adj_next =3D -(vma->vm_end - addr);
+			err =3D dup_anon_vma(res, adjust);
+		} else {
+			vma =3D next;			/* case 3 */
+			vma_start =3D addr;
+			vma_end =3D next->vm_end;
+			vma_pgoff =3D next->vm_pgoff;
+			err =3D 0;
+			if (mid !=3D next) {		/* case 8 */
+				remove =3D mid;
+				err =3D dup_anon_vma(res, remove);
+			}
+		}
 	}
=20
-	/*
-	 * Cannot merge with predecessor or successor or error in __vma_adjust?
-	 */
+	/* Cannot merge or error in anon_vma clone */
 	if (err)
 		return NULL;
+
+	if (vma_iter_prealloc(vmi, vma))
+		return NULL;
+
+	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
+	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
+	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
+		   vp.anon_vma !=3D adjust->anon_vma);
+
+	vma_prepare(&vp);
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded =3D true;
+
+	vma->vm_start =3D vma_start;
+	vma->vm_end =3D vma_end;
+	vma->vm_pgoff =3D vma_pgoff;
+
+	if (vma_expanded)
+		vma_iter_store(vmi, vma);
+
+	if (adj_next) {
+		adjust->vm_start +=3D adj_next;
+		adjust->vm_pgoff +=3D adj_next >> PAGE_SHIFT;
+		if (adj_next < 0) {
+			WARN_ON(vma_expanded);
+			vma_iter_store(vmi, next);
+		}
+	}
+
+	vma_complete(&vp, vmi, mm);
+	vma_iter_free(vmi);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
=20
 	if (res)
diff --git a/mm/rmap.c b/mm/rmap.c
index b616870a09be..4ee90f06b05b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -262,11 +262,12 @@ static inline void unlock_anon_vma_root(struct anon_v=
ma *root)
  * Attach the anon_vmas from src to dst.
  * Returns 0 on success, -ENOMEM on failure.
  *
- * anon_vma_clone() is called by __vma_adjust(), __split_vma(), copy_vma()=
 and
- * anon_vma_fork(). The first three want an exact copy of src, while the l=
ast
- * one, anon_vma_fork(), may try to reuse an existing anon_vma to prevent
- * endless growth of anon_vma. Since dst->anon_vma is set to NULL before c=
all,
- * we can identify this case by checking (!dst->anon_vma && src->anon_vma)=
.
+ * anon_vma_clone() is called by vma_expand(), vma_merge(), __split_vma(),
+ * copy_vma() and anon_vma_fork(). The first four want an exact copy of sr=
c,
+ * while the last one, anon_vma_fork(), may try to reuse an existing anon_=
vma to
+ * prevent endless growth of anon_vma. Since dst->anon_vma is set to NULL =
before
+ * call, we can identify this case by checking (!dst->anon_vma &&
+ * src->anon_vma).
  *
  * If (!dst->anon_vma && src->anon_vma) is true, this function tries to fi=
nd
  * and reuse existing anon_vma which has no vmas and only one child anon_v=
ma.
@@ -1265,7 +1266,7 @@ void page_add_anon_rmap(struct page *page,
 	if (unlikely(PageKsm(page)))
 		unlock_page_memcg(page);
=20
-	/* address might be in next vma when migration races vma_adjust */
+	/* address might be in next vma when migration races vma_merge */
 	else if (first)
 		__page_set_anon_rmap(page, vma, address,
 				     !!(flags & RMAP_EXCLUSIVE));
@@ -2548,7 +2549,7 @@ void hugepage_add_anon_rmap(struct page *page, struct=
 vm_area_struct *vma,
=20
 	BUG_ON(!PageLocked(page));
 	BUG_ON(!anon_vma);
-	/* address might be in next vma when migration races vma_adjust */
+	/* address might be in next vma when migration races vma_merge */
 	first =3D atomic_inc_and_test(compound_mapcount_ptr(page));
 	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
 	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
--=20
2.35.1
