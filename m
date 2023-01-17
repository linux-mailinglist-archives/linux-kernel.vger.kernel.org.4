Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D066D478
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjAQCj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjAQCis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:38:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C61C336
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:35:58 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H092Bi023154;
        Tue, 17 Jan 2023 02:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1BgCv6KPHQPA9madWtiugJOXRBCoZ3mSdPjJPZaavpU=;
 b=eVK5SD03i7wLzTutUqXuUIWd53kh9BMirZKSypt+58dks5NHXPpjJKYbg22+Q+EMO/u/
 XVFggwiHHWmizpwdcL7OYVl/x6bw28rA7Q0GnXzhrCGVJYVC7O8BEe/oAmWAibH0sV0m
 BXjvf21uxN16may4r9fgjMwxBHvR2+2f9vs2ml/GhlbWo6SgVqcMGArQl4e7oUTSsrwc
 VqjpumgbhWadIDo2o8m2CRL098VniqWWMUUTbS/y04C+f9EvN+W7u+bMCBnwNMBkxMrV
 T8TIoDAY5nP+moOwdo0CZUaCy65TjiPZxqotC9XKcbYm4pLr1PQFT7dExW+n468G529d IQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3jtukq2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP45028373;
        Tue, 17 Jan 2023 02:35:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GImZAtuUCm4lZXwg8T+5V4LRMoT5bwpiMEcCqIaa9ky9yoQXGY7KSvnNaVhy/bEd2qrHVJj/1N8L/avFjXyNL9tdM/laLj5OLWMp7nFtWuaj9OC4I/dOckaRHda0XArr4b/5CjJe2JLSLE+2Bp8p8Lq04KXK+vDBje1woR34w0a+W8MsF0o5lwrR9WJefHrAuTaT+AxbbYaEJvJk8yByYFmEX94XKxJr20ELU3/xD9m3UJroqyjxXHNnW2+j+BwMuqAmmHtlBiA0i7aJSXWBAt4MkGx+R+/+IngIHo/WwXIZKntdn631v69ZU1jI98h3Ot74ml2Xt24V5llktHaSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BgCv6KPHQPA9madWtiugJOXRBCoZ3mSdPjJPZaavpU=;
 b=bMdBZBQ/7KIQTnLmpWunfH2DzZXlAricFIu5+fhgW+cOdbvY453rooSXkstktGDQDFgsb0moX33W6+MPTH+iVFeVnNU86pZclP37r1+Rln3DoseXIe/hEaPQ8LDD9BXWo+cI3P6o1rc2BmNtGMLoAxZyy6RY1ie5pBu7clsfhvr78Yt8PBCrNZNcmPmLCuTVyZnz6IGnHn7hvyfZILOH5UO8kMiB60GoyNBQzKlHdZ5nwOIsjJwr/91IGN3y8wskOhJ1DsFdJJCifb1x0ivrPPuYMgOiGf0g/MYSIbUeWrhJsQNWGoDEJUYgLGJOAXry154DqZvbKfV85CzZTVjmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BgCv6KPHQPA9madWtiugJOXRBCoZ3mSdPjJPZaavpU=;
 b=J0+dqPRHqo55z/gzFvA+cBkHOT0r79SEAk8pnby+cXFe5fONHKyQqp2M1/vpzjZIuIS/fY3Ht4Qs+4vgMI/pTqeGUp6+axW6SZaIDwSThc5H7+M35uhYKZYjWiJDqNzAFeF9nyopESbaSYYS5mjZauwkSPkhVMjnrc2b0TqCqqU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 44/48] mm/mmap: Don't use __vma_adjust() in
 shift_arg_pages()
Thread-Topic: [PATCH v3 44/48] mm/mmap: Don't use __vma_adjust() in
 shift_arg_pages()
Thread-Index: AQHZKhw1tU1Rx5vwfUi9LCp2M7SsaQ==
Date:   Tue, 17 Jan 2023 02:34:23 +0000
Message-ID: <20230117023335.1690727-45-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 082412cb-0bbf-4825-9f6a-08daf8336f2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qc72xEoAijJwk7pJ0JJrDYnZB3SJlNDmTJDsrIZB5doUAxMfkFhXNwW6C/Yx3dK9k+aZyo+n0KacKKNqOxPl5Bh73ecNvQS3cLaL9QBOoc0nhSoDtT8NkneeuBw6jDCZUMr9mqp7lGshlIIAkIzQ0F1F3QLh5X/z1/zAyCShE6bgVlYn4k+NzK6NypimkxsplY0PKpdd811SO0StivkwbeX7/QDSD55UCVPNPmiTL9IXxJk2X3kdbkeVPTZZtPuRqyn8yg3FnOm9uhOn2c+0ClAVZ8IfUFmAjx43wgYKjbaD8jVqs8v7eJOddr+1vU41wiyD782LSltT4cF1E7Z/NX/ctpczRW6pmwvmoaL/APhlp5bhYAMY1L+mXRz4MUI4D8eYS+3Ke5h0NmQkvK+YjPdp8IEnI0izw5OVfb11LNfuDt7Wntpu1+Te99LllOxBPlj4nFCP5G/72ChORX6Xp63wG1yAsfZEmfXNTgN8oO8+vVI9AV8G1mOMADtU7MFTJFNVKKQD8JAjQnM9j5zOFPmBWXQ6ccs4iHb55pI+aSH6mwPbFGYvqYr8+d2SkHL0aH68YaEl5bLbFN2rqYqv4T5yKSw0HMGIBdEfGj8aGq0PcT9ANWtbYWmf5dx0cuAPQ6W9GMjWvihmieBo7SC7l0tDCz20h6G2dlanXcsc9xbbighmg7S7q+b4EDAk6i6WiPoyY52Q0Pl3+mAFo6peHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gL1mQ/hGofT93C+A3EjEiXbX/jfbmevISuJdygTTsAC+u6DXfWp1oTJPE1?=
 =?iso-8859-1?Q?ahRrkvXmtMSIj1HJh1t0XNCSbp7vvpzWyzVf97OFXt+XuE3DTiVnMfRJLj?=
 =?iso-8859-1?Q?v5LU8moOwoqIqaLng2TncOq8vNJz46RaaOjOB6J4LPVZF2/W9EnSUKE0+P?=
 =?iso-8859-1?Q?AUKcMoLbk9CfWZK0CLAzY08dEY/ytDjL9CoE1WINFn+1y0hSDcfhHuB/zz?=
 =?iso-8859-1?Q?6FtSDxIcI7NUy0PoLW1uG8rhVVEGxWE94oUeyoBBesZ3o3QWgCcf/j2gyo?=
 =?iso-8859-1?Q?iPYaKAvu+SnMkY/sFLShGuGTT4xgCXlByxpQrnzeB534VLowLotDP9JCfJ?=
 =?iso-8859-1?Q?UuytyIZVGWQC6utHFgkRnJQ35XgQv4BC65+wI9cM0sgylS4J0qUv9t6m+2?=
 =?iso-8859-1?Q?NMIve4numq/2WOm+il9qlbXQgReC6c3klqNRIyumLmOS60yiday3wCuhzP?=
 =?iso-8859-1?Q?K7m6EApNP/0ArPNoOwSvshT3oy7++vtSQPIrWDyp/yy0+/cKQTVkk2HdB8?=
 =?iso-8859-1?Q?K4GIrfsaCzEfLQZf9w6rD+XC5VSGPY1OBGwQTRs8l9Qz3WfbrDSGcD8oGI?=
 =?iso-8859-1?Q?TycnllUTa3KvbltX54en4AtnE9oywzSrIDlbZDiigwp0sDIVQP+kEzApp5?=
 =?iso-8859-1?Q?KRolE9zD+gww1AqjK6+d7sQGxAZWYrgV8acWGJYyCfZOEyaf7s34n82NpF?=
 =?iso-8859-1?Q?5uLkNTceXFviH2ejREGEx/+Alo1A9YALKtqdFfQoilGqtI4P4Pp/fXyKuG?=
 =?iso-8859-1?Q?2PQPxUzsvgqYEoP0Ruv+qNYrgUj+Xps165FTAMsaYCfBrvLs4vggXbqkd2?=
 =?iso-8859-1?Q?zx+xXsnn+k4vqf4BFrbbvNyEkIRjBi+P4c+HIOruU4cuKyvkbT8eSK1YMs?=
 =?iso-8859-1?Q?GxHH+EFqwGZKANu+7QhjQ49tQCx3hpkrohbyVZMIMT5fZFgvAoSOBExhvQ?=
 =?iso-8859-1?Q?rah7g6JvD2tBjICZkXbl/p8kS18cZrrD9NTu/ROAxackJI/H/FGowm8LuT?=
 =?iso-8859-1?Q?UZsaIxP6zrIHhkbIFzPfUKON+1+Tdas2FT2fQzA7k/oDZky2ydQfE2L7lx?=
 =?iso-8859-1?Q?AkcLQZXzFqKlT7s7N4OMrAKRwRIf4dXtT4yG0tDBrHKos+rcQjB47274GT?=
 =?iso-8859-1?Q?7EUmKAzNSXv6N6bO2b9IJnFynwHO6oxoxCRVsXYLHcEm4qwv+BMx1xR/x3?=
 =?iso-8859-1?Q?sAsjg7DfV0wfoPB0eBrzGdJSmzeTzgGZ3dOgzBUSGOfBohkPx7FF4vsbVJ?=
 =?iso-8859-1?Q?J2ymC2JI+QEaIqAPX1gwxk5+uvv+42Nu4pd8m6/J5X3J8pBYTaDuHy3LhF?=
 =?iso-8859-1?Q?HzKt2UiMq1hTk7ThTBl9tMwD34Nj/PPVw7gwhOEVZHkUMo27mtGbQNaoYL?=
 =?iso-8859-1?Q?a2z+YdD+LOl2Xak5f+3Z3Mq/YPaqytmQd3MBrcJICIlVnyr1D3W0pIS2KU?=
 =?iso-8859-1?Q?PgWvuvrhctyaoNjxvwCQaUAd8TqPsS159CtLs1S4seDgYHUeMFvP0nBFni?=
 =?iso-8859-1?Q?TkWjWHnK2b/Inhtw5JmBCqGA31t9iu4T3yWhPgBj2C8i8Hl+97nE9bdrmg?=
 =?iso-8859-1?Q?sUlYb98ucphJ+PXaKpqV3fdbsDwvKkpXh0TDpMHqsraRELTFHQqDN8qCsw?=
 =?iso-8859-1?Q?JKz4vt6snmMwfeetmrBD7ufRbl9oc9ibXHYDX003M91A7MxzQZiSB7mQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ENwXwpWAKVpLRdUeYnNKU7FjhWnb6FQOvnczwFBFsw7ZjKB1AkUUKVB7MFmlVMengC9X93z6EpSJ1MI3ml6Iz/fvwQlm+XdtHEKL8h1WEXhhxjfgbR0oKBm7LH6C5sR1Y43o0Zjg82ASfipOaeZLOwagmNiXZelyeJsee8Z4Z6GheYmbvhnrci7IdckLjTSVEsFsbMeyu8niZvQqR/MDjfZHdGP99tHTr0fKHM8+Vq7o1f++8SdPB8zByu6JNq7MJojFLWRZKvo9sm/UBvkiRfdOT1omaTAwtRiXdGTshh4aAYsFmCIfdJWJ2bBekxVjyphweGNyydexeBcxknwpjxM02bOUTDOS5TbosTpb1X/MoWW+wYmRaXpaKp0O2/7lhNR80KzVIladnCTHsuRjXFphAx+PKvlY5GSVkqFZZogQu03xr0hkoTwACnL+sc9FgHx9uyKoAC8rIJGbyhzMOcQRm7kAUvUgOHylthOBBx9UejZBrRFnxd7U8oWDf+MXyampjm+poUD2oeR/lsfBgFFaA7oOAOjXt1FbXn9phmH5Jve1/vu3+F4R6+SMTJG4LDwXIA2ONE3cohTWkDvqseDFr3SLq+IGwYj3ul6c4APl4XNunnwXSzGmO/URkfgTIT2S9g0e0Ie3k9rspw+Ht72Usra3cnuIWgbq1c5gIh5N2K5PFPcdF76ii75AlLXNlzoeWDvjBr2hw4XZ4rroQdTTkLiwhEtInzVkjuKaq7xQ3tVeXUUFsrj/emGYIbNje03nc1s1MiT40vvf2ObTpoqmq2v4cBGHFZdU3R8X5jy7NgfiVynmL7ZOirNaUQm9b4sBEdh9MKWz1hi6k2FRoPOhDZeOINI+V+IGhGDZR/rm95AKGTYH7DPKq8ncnUUocRotyHTEZZXfORnUn6gx4A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082412cb-0bbf-4825-9f6a-08daf8336f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:23.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYXoq9EBK9ube2ivbb195FZer9T7dwhMML1J/R0weSkPg2SY98lHGV4L8/5O1YCsG4HY355LeE6G0DFArphpWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: HMD8jwVCL3Q15RGzH15oO5Xq5Y3B06yR
X-Proofpoint-ORIG-GUID: HMD8jwVCL3Q15RGzH15oO5Xq5Y3B06yR
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

Introduce shrink_vma() which uses the vma_prepare() and vma_complete()
functions to reduce the vma coverage.

Convert shift_arg_pages() to use expand_vma() and the new shrink_vma()
function.  Remove support from __vma_adjust() to reduce a vma size since
shift_arg_pages() is the only user that shrinks a VMA in this way.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          |  4 ++--
 include/linux/mm.h | 13 ++++------
 mm/mmap.c          | 59 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d52fca2dd30b..c0df813d2b45 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -699,7 +699,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff))
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
=20
 	/*
@@ -733,7 +733,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
=20
 	vma_prev(&vmi);
 	/* Shrink the vma to just the new range */
-	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a00871cc63cc..0b229ddf43a4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,14 +2822,11 @@ void anon_vma_interval_tree_verify(struct anon_vma_=
chain *node);
=20
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sy=
s_admin);
-extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *expand);
-static inline int vma_adjust(struct vma_iterator *vmi,
-	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	pgoff_t pgoff)
-{
-	return __vma_adjust(vmi, vma, start, end, pgoff, NULL);
-}
+extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next);
+extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
+		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
diff --git a/mm/mmap.c b/mm/mmap.c
index a8c941e3be84..a6e07edc15e9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -637,10 +637,9 @@ static inline void vma_complete(struct vma_prepare *vp=
,
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next)
-
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *next)
 {
 	bool remove_next =3D false;
 	struct vma_prepare vp;
@@ -686,6 +685,44 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 nomem:
 	return -ENOMEM;
 }
+
+/*
+ * vma_shrink() - Reduce an existing VMAs memory area
+ * @vmi: The vma iterator
+ * @vma: The VMA to modify
+ * @start: The new start
+ * @end: The new end
+ *
+ * Returns: 0 on success, -ENOMEM otherwise
+ */
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff)
+{
+	struct vma_prepare vp;
+
+	WARN_ON((vma->vm_start !=3D start) && (vma->vm_end !=3D end));
+
+	if (vma_iter_prealloc(vmi, vma))
+		return -ENOMEM;
+
+	init_vma_prep(&vp, vma);
+	vma_adjust_trans_huge(vma, start, end, 0);
+	vma_prepare(&vp);
+
+	if (vma->vm_start < start)
+		vma_iter_clear(vmi, vma->vm_start, start);
+
+	if (vma->vm_end > end)
+		vma_iter_clear(vmi, end, vma->vm_end);
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -801,14 +838,7 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
=20
 	vma_prepare(&vma_prep);
=20
-	if (vma->vm_start < start)
-		vma_iter_clear(vmi, vma->vm_start, start);
-	else if (start !=3D vma->vm_start)
-		vma_changed =3D true;
-
-	if (vma->vm_end > end)
-		vma_iter_clear(vmi, end, vma->vm_end);
-	else if (end !=3D vma->vm_end)
+	if (start < vma->vm_start || end > vma->vm_end)
 		vma_changed =3D true;
=20
 	vma->vm_start =3D start;
@@ -821,7 +851,10 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_a=
rea_struct *vma,
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
-		vma_iter_store(vmi, next);
+		if (adjust_next < 0) {
+			WARN_ON_ONCE(vma_changed);
+			vma_iter_store(vmi, next);
+		}
 	}
=20
 	vma_complete(&vma_prep, vmi, mm);
--=20
2.35.1
