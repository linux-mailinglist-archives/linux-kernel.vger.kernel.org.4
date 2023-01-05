Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701665F429
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjAETQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjAETQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:04 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE49C7E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:02 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUH1w030095;
        Thu, 5 Jan 2023 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q+J1EkBiJRATPpQFyS30k/tjqsPU0yIzN5CZ1B/Xy+8=;
 b=TYUBUgCkdUrcckPzPWcWf0RireYxsCI71TECVoxfqgm+hAKYBbfBX14agH6zWttqKqbK
 fvy+pmwbQ3ZCYqObXuxhLW2zRim7yr/BPLlewMMli6q3WG5foJ7EAg4PPL7Fi+YzgQXL
 AnK5wNELmPW1I+JvsiSNYsruZ4ak40CPSwqvsY03OuYgtBloKHBdyMBZaloFIiE7mzfV
 /9xUb+4udGRFHIXZ3s3X/vZA89G1N97aZNkhbicjVS9ObygrBkmFDtROu7vAMKHZdqZ4
 Ycyly3KXyy7X9yx88/onmpx1o6bLhBhPsESCCSV+3w9Oqt6dtEM3CuD/HZ10zhH21wrq 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9k97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I0WPH023380;
        Thu, 5 Jan 2023 19:15:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6kx6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo4lYUGLmMy/FqYEnGkZJ8Srk9n40SesP0V442GM0p+C6hYmdiIxp1oX4mw3CkyzqHo0QCZTtO5prgE+5sWxUXj1dSmcO/DJ68OzkAgQO3YjJPclubl0pdx5vL7fZ29OGaP56BmekEjsnQTzTgLbOIYHC5TiLPb32iR75WAxHZ8wlZNBtk1+0sCzRPNTE7J6hd8UehurEWP2JpeLDj8j/aXXIX5YB+LTIq5dhh/80t6X0oUSYCa9WfqWnKI4mhGZpJ75L3NIeU4mb3QiHpf7CARLKxiGaWeFdatiJXrhRKf6Uiw7wePnplo3XtkVanMNXzTa28nj42m0ZGlMpSbHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+J1EkBiJRATPpQFyS30k/tjqsPU0yIzN5CZ1B/Xy+8=;
 b=Wj6jum0A+oWzlZcaC5H1LSZdIzTrmUdvhVH6eleubsq5CE6n1Q5t8Ex8/y/GSfSgG7DdNSMmi2/uCDI9rQNdH0L8D/ZvVU1NiHWM9FRn+cS2VzexqEKzm8yqLK3nxE3vSgL2/UQQDoElPWqpER9JTA4IljUvcs7uQaxqeo0SqzwmJRiHWjm5QJeV/JFtrYohrGstN7vyVCaEFOIsAxRGRhyERLKKDHVhzQpYiaCCIDnnGYfNoTbOhoSxBeLscHV6IQTueCPZ3UVq/4QPsv/kUgM1r2fUhoMrafZrgMF171jJVhdfUUOW10ZFuihlUzFFdAiPkXzqV96jRnB1SxPNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+J1EkBiJRATPpQFyS30k/tjqsPU0yIzN5CZ1B/Xy+8=;
 b=jGUzFx+pLE4T+1cc6N36UHaFK7LIiNY5JIy0tUWLObGgkp5xYbVP3j5R7C/vcMy4l6azQXznNu7GDUpthH9DK9PcA5/cE2PNZ832R5vwnuzPExA6E/iMl2IO6K4jzXAEqlSlRHHpkzYu+sZBmnccURzRc45r2EYC2HqyTjrRJY0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:15:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:15:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 05/44] mm: Expand vma iterator interface.
Thread-Topic: [PATCH v2 05/44] mm: Expand vma iterator interface.
Thread-Index: AQHZITohGvqma0vYPUiffXuhSbXTAA==
Date:   Thu, 5 Jan 2023 19:15:53 +0000
Message-ID: <20230105191517.3099082-6-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5231:EE_
x-ms-office365-filtering-correlation-id: 3a491d0e-381a-4418-126d-08daef514456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjwjtv40IU++uUSdvdcLFrI5q2XFBbD8SZXbiPhKbFH5wMNC9Un/SYQlFGW6c+LvATWUIkRDxm0e7ODlx5GZZ4Ov0u8MnhPmQzPYJ7PrL5/ZUzGMUX2S78TpQhSmmDlOyNzWMSf5uZ9Aqspn+g/BkdY0QWgLsIiBUaOAk23YTlr5s0In+Hc/BtLvmU+WMCpL9AT2bKJLICOJK7dhb7qny5F4K5RxkFGzEjGG9aFRI7IXbfpCDLUQyGnxBNsjMmZl7sGng1p7PU0QS5bnPm8T1Ca+Dw0CS8d5eyeOOdzQ/dT9kZpn6DwOSyXFyiCwyW8UHmogwYxvcmRKwigaFjT0SjDSEH85C5Kc6vop7A/ae7yMA0oG2tdkhB7AxsTIBTkUyzWSGy6BkWleqiIPantmDzfZQ+gWjsFHEOrvqZ/RE5plXX573pGHu7rKqcr8d/r1+Kr4Kfzyqi4x+4VlsCk81sD+O3Xm7YCO8INUHJytYwvJUmZHM3TTotwNWEo8lgDirhHihdKy3etbNLyVlQAw1eTpqKyd6xztjgThBYIcmCwRP/atWvzeOD6Q1TPm9dmhWhhNCdPG5FmjLEezlPEUoc2QTsyhcxR3mExKhM5QwnQKoytnUf++xp7XL9VuBXUiL2augXXkz77guP+nhcMMS0hQULCBog3Re7o1/p58YDd9Qhtuhts1+DFSmsMWbANXwRAwaYabSYioc1cQgTpbfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(110136005)(316002)(54906003)(6486002)(186003)(26005)(71200400001)(107886003)(91956017)(64756008)(66446008)(2616005)(6506007)(4326008)(66476007)(76116006)(478600001)(41300700001)(44832011)(8936002)(83380400001)(5660300002)(66556008)(66946007)(6512007)(2906002)(8676002)(38100700002)(1076003)(122000001)(38070700005)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ySduKwvHKaVbEy60M57hxbe8a/0bpso+7HWw8Q32Bx7RTyIotMwwj980qS?=
 =?iso-8859-1?Q?hWE25Cng9mXYKtq7rgIG5ZxQzVJUGSkj0SBB3FVlwotdW0Jr2+SCGgg0qr?=
 =?iso-8859-1?Q?MI7mJKWSqMuYQMgU/L+pSmzrPMB1bg6ZHXBVe1sa9KXHnLWYV9KxY7nXsI?=
 =?iso-8859-1?Q?qsmAq64ANuXmlmdt+Y4dPMrscM6eKkW9zaB0talxlaC8D+D/wmrWuCWgIr?=
 =?iso-8859-1?Q?gzi1svN29DnIHK5s2NPyx3/MAjWaTffKbblMV+uUiiNQAM0klWqTDzUCUa?=
 =?iso-8859-1?Q?14PnmC68P7FBjQ/tvQz/NOxA1OO1xl0QJgJIj+6T6QXZWTov1tVF8qgaDf?=
 =?iso-8859-1?Q?X/bQ0TAPE5Eevv3SnIQlFtdg6ETurZ0qQqkoupX0BWwIHavR/GLgApCt/9?=
 =?iso-8859-1?Q?omIDbnPADQcB0yfB8GqfMbPAoAw19OH02z9VfI7cSr8ig2yb+Za7/HivZR?=
 =?iso-8859-1?Q?0wP46IVFS+XoAAzBO+t1WW6Npqk0Tk7U5ZLC68Gb05TeCxChnV/KPR4UI+?=
 =?iso-8859-1?Q?NHbph4UY5fUhPWqqo73rWKk4Sj/q+XB56o0fGzXkQas7RMMfN0aAGhx+d9?=
 =?iso-8859-1?Q?knNASnVO2nXSxGUVFDUy2ILWi/gJb3/G0g97TsK3PsfVfxN6G2ya47cDRE?=
 =?iso-8859-1?Q?x6vQW8CJ3/4toodoOtzGQEjxSCIhJEEzE/NriF56m5WJQjaLZ6AuG+wJKd?=
 =?iso-8859-1?Q?j9f3Y248XiOKgXw1iy5srMQr5BZg6d8JGjDDi2R3/Mohz3WrZnd3pURA+r?=
 =?iso-8859-1?Q?KipsWQN7S3GWxuNIGMzhAffBBcDeuAzzc1EQP9fOlzFmPKEjpPMg/93Fjt?=
 =?iso-8859-1?Q?yg7IDuAbCxvGelwYRCyBEZmZCFazXOSaIQIpHrIsOJngenl0gzsoeDa2cz?=
 =?iso-8859-1?Q?w8UcUwbMzkJVRHreQ4qcSwtTyqjYCwSEbH+LDcFoUwrsoh23phXjI3zo+O?=
 =?iso-8859-1?Q?D1YswPsJuYbAYmshl1LUS/1l3cilbmE2eG0qBX8OI31YBv+DkE+tirDGob?=
 =?iso-8859-1?Q?69+GoK2wDZ3fSm+O0wIv1zGFzxnC+2y+Oq8lzV8lRT4nR2qFWdwZlLizT/?=
 =?iso-8859-1?Q?ARpWNtSkrRMPCDO52SbnbqkCyu9p0X/mBxCIXQzTY4IV5Hxfi9TtuCLLT1?=
 =?iso-8859-1?Q?Z2Ib/g6FwsmP2n+8Kgv0Y4Mj1bTJqbq4llSJjhyboLfvIhBzRS2U6U6tDp?=
 =?iso-8859-1?Q?of95jUzA3sDwdZpFPzIQLS+ZeAp2UV017CZ7I45l9pXzS8e6mK3KJSqtpP?=
 =?iso-8859-1?Q?r0ZfPvDvI9o7zfR5vt2/sa/IWzje+gSMoU/sdWz/1PMMlPb/M+blx5x71E?=
 =?iso-8859-1?Q?D2kQkmNIGdvlpBfWumhl1iTIbRD6kHLpyxVEqd8QOIpRIFCVMDO4u2SsC4?=
 =?iso-8859-1?Q?Pj/nmXK5VesoQKNJpzXvSmC+gwKJI44E/Yog+6zBRMffeyLW3ruprgwXb5?=
 =?iso-8859-1?Q?p9OJElnTepEqZMWxtEPacPP/QX7vnDHJh/pO1htSnWp43R+hlL4jPe+ZmQ?=
 =?iso-8859-1?Q?bB6fSD/oHivMkYP6YQD3eQvCdUJyu3N0OzLDdoxG7AYQxJMjpB7ApSOxo5?=
 =?iso-8859-1?Q?MseYUUQ3aW2AbQh1wrzVvAWZAr+VIjhuT7KwFDbKaK0223HtDGu9m+FetS?=
 =?iso-8859-1?Q?/CH0izN0Cts9lmSxXiFDy0THLlLFX98srMI62/9m8XvFCO65Up8H5efg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qCOO9tA1J7uQFfFQlZf5Nvor32mwyGwKMzStHXDD8aj31i5YinjjSMyxBkO9P2Lp6aC/Fwuz79/DM5O3kc/wUuGB0IfrPH+Rog0JbCMS8vRU+L4SBAa/t8ki9b3vUyH6bkL4PUYfcahlStmQvCKzLc6BqgT4hsSehTHQCW3keCIULJ3A/tk3W6Uu8t13QhAkcgn/FOwkf/rt4pjm7S9ycWYSiouxabwJYmju8QvKaf6FVjAv0f7HZSBb84SkjBXyOIhCpBFGw/NFAhcFNiNOC2YofC0wg2wEtTTOryAcem/2iAix2fUVENAXSz9lNg5XUQR8T1MMLA8GsS0gbbpwKMyVn94mHHVLkUejaqoW1NlPPZ6qEj0CHH59AeFsh5Yj/1TxIB1oT7CV4HEVm+8DepEeeBJP6xsCC0MlsYKOX5z7TVx+VWAwLqt+CXtISWL6xhMFXcmLgze2gXvktjZcDo3NpGuqEeZeNCnpXNkUiXpEy08WWZ+a5yNkdFcfqMDFIdMiLTmgZpulKxfanFi7YOKGcP+Vjsh5NO2LkdasVv8cgEKMlr1aKh2Gi5L/yG7ursaCOm7EoC7Vv6hBPBAJMzZEQll8veWruxPL4A8ukM87QNEhOHL2Zm19l4/t6YqnOsL7Q/LoftXfa1qCK1VMrRZgv6I9evtkadvTA4vFO1FJBWEsI++X/LM24dhzfaRYIPGx6+1iEgtjLo2OOifwWPWuMpMZ/C2aqjXohtkprJIL87o4bsxGVnKDl1K7QONM3ua4wxFDypzAj18Q8BGdQca2WdS6xWgL0iwTuQ+AMKrAD94vB3uYDDtEyVIVxqpj0EjoAjGMVGL5M2RslCqyb1zkBmo7LVmwjaIhNdQNzirtC8IKtgYdUnraZjoVEhMLjRmu1tNVeUTpWJ4Ct20bHg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a491d0e-381a-4418-126d-08daef514456
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:53.9227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYhWQc5t7ufFnEWsq9NhbCOjL/ak9LNTOz9kp7aZm4BTcHPYqGEgdI3Ixyc3EEu/8vnXcUiMQAMWEL7aUdZh8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: _dptV2LSHR5x8dTcL9L_cbzWoXMlSIQe
X-Proofpoint-GUID: _dptV2LSHR5x8dTcL9L_cbzWoXMlSIQe
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

Add wrappers for the maple tree to the vma iterator.  This will provide
type safety at compile time.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h       | 46 +++++++++++++++++++++---
 include/linux/mm_types.h |  4 +--
 mm/mmap.c                | 77 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3f196e4d66d..f4b964f96db1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -665,16 +665,16 @@ static inline bool vma_is_accessible(struct vm_area_s=
truct *vma)
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
 {
-	return mas_find(&vmi->mas, max);
+	return mas_find(&vmi->mas, max - 1);
 }
=20
 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 {
 	/*
-	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Uses mas_find() to get the first VMA when the iterator starts.
 	 * Calling mas_next() could skip the first entry.
 	 */
-	return vma_find(vmi, ULONG_MAX);
+	return mas_find(&vmi->mas, ULONG_MAX);
 }
=20
 static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
@@ -687,12 +687,50 @@ static inline unsigned long vma_iter_addr(struct vma_=
iterator *vmi)
 	return vmi->mas.index;
 }
=20
+static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
+{
+	return vmi->mas.last + 1;
+}
+static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
+				      unsigned long count)
+{
+	return mas_expected_entries(&vmi->mas, count);
+}
+
+/* Free any unused preallocations */
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline int vma_iter_bulk_store(struct vma_iterator *vmi,
+				      struct vm_area_struct *vma)
+{
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store(&vmi->mas, vma);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long ad=
dr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
 #define for_each_vma(__vmi, __vma)					\
 	while (((__vma) =3D vma_next(&(__vmi))) !=3D NULL)
=20
 /* The MM code likes to work with exclusive end addresses */
 #define for_each_vma_range(__vmi, __vma, __end)				\
-	while (((__vma) =3D vma_find(&(__vmi), (__end) - 1)) !=3D NULL)
+	while (((__vma) =3D vma_find(&(__vmi), (__end))) !=3D NULL)
=20
 #ifdef CONFIG_SHMEM
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3b8475007734..3cd8b7034c48 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -904,9 +904,7 @@ struct vma_iterator {
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
-	vmi->mas.tree =3D &mm->mm_mt;
-	vmi->mas.index =3D addr;
-	vmi->mas.node =3D MAS_START;
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }
=20
 struct mmu_gather;
diff --git a/mm/mmap.c b/mm/mmap.c
index 87d929316d57..9318f2ac8a6e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -144,6 +144,83 @@ static void remove_vma(struct vm_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vm=
i)
+{
+	return mas_walk(&vmi->mas);
+}
+
+static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *v=
mi,
+						    unsigned long min)
+{
+	return mas_prev(&vmi->mas, min);
+}
+
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+				    struct vm_area_struct *vma)
+{
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
+}
+
+/* Store a VMA with preallocated memory */
+static inline void vma_iter_store(struct vma_iterator *vmi,
+				  struct vm_area_struct *vma)
+{
+
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.index > vma->vm_star=
t)) {
+		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+	if (WARN_ON(vmi->mas.node !=3D MAS_START && vmi->mas.last <  vma->vm_star=
t)) {
+		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
+		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
+		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
+		mt_dump(vmi->mas.tree);
+	}
+#endif
+
+	if (vmi->mas.node !=3D MAS_START &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start))=
)
+		vma_iter_invalidate(vmi);
+
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store_prealloc(&vmi->mas, vma);
+}
+
+static inline void vma_iter_clear(struct vma_iterator *vmi,
+				  unsigned long start, unsigned long end)
+{
+	mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_prealloc(&vmi->mas, NULL);
+}
+
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+{
+	vmi->mas.index =3D vma->vm_start;
+	vmi->mas.last =3D vma->vm_end - 1;
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	vmi->mas.index =3D start;
+	vmi->mas.last =3D end - 1;
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 /*
  * check_brk_limits() - Use platform specific check of range & verify mloc=
k
  * limits.
--=20
2.35.1
