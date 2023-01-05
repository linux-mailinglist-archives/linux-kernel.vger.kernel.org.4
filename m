Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36C65F43A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjAETRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjAETQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBDEE14
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISwM6017230;
        Thu, 5 Jan 2023 19:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6qo0x6FwfVqAS5uWsZQ+S2ecMjYQ7dLgAPgm0zpCre0=;
 b=vSyOzL8tcAAuY4vJZ6V3Bg15vz/H3+J8aXZGxTSNJP3izxuhzwjTsylRz1LRyj+t+I3h
 UvClVF6SbRAcxRrhdI68tt/iWZJkbxYK5LnKoitYCRbheEsAjgBXY00MYhO5ULtcEhPN
 dMS6x9dOuwudtQBVT51L0waDjEsRf1z3pb8fUX8U7GfCrUUayFTKmX2qpzlkmp/zeewB
 b1kuZC54lIRoWFCIa96z8WANf2R6EVLZw+Ngdbnp9MS4dszFMbmK8LPgS6Wq7vi0FPvw
 oItseISCclNttPPIXVxt26SNmCUW+WEUxY1xwdrzCpZgqzXtE9M2J3jX/B7z6iSOFidH mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv31ns0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305Hvlpi023372;
        Thu, 5 Jan 2023 19:16:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwept6m1t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5TW9e6HC+cHo/VcWv2ajOu8dKZ02e4Vclxf5ziV3KxtLKRgDM65/na7F1+lRJ8YFkC/HWxmLlAh2vt+xJgfXsS3NOAe3ReJlRszzDGgbnkTpHz6dGixmGrfpAG5rF0o0/h30rKReQ5yqXAsfXv/YTjHmnT0juvZsogzyI75ra9V1bv2TP3y3hTz0UhAD4aANu/gVG372BmqVT4rcHQPs1UPSIpwyy4XBUIMqRIl6TWQCkt4GkKaCs4cnuoTFZUygWt6zrnoMDf8nGP3TzziujjCoKy2kUoDDaR7lnYYhmAOCBflVAjqMTrX3a+O5CQoY2dMxLEPzDgrJ5Mevbf3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qo0x6FwfVqAS5uWsZQ+S2ecMjYQ7dLgAPgm0zpCre0=;
 b=FRaV1OeQlrAxG0yEAeRzzpPB+7vt2BFNBuf1oRs+nh8RXCkSCWYV7nrn1um9NKt6dt88HiOzdfax6uOABhrOa52QedA/whOB3NrCxFkw1YrYioS5VugNobWE5fZmd+LtU3f0S5ALcspDTMkvqH2GhwD0hlaTIIkdx8U/uRX8xBfMAdBr7t+H6BhWa7xoGZze2bLFLJJ7WoX6bq6EDlALeewSXQWS81AUBWxpseaosir3DMfnm5WmCsv5bo1S3g0K1bzY50OWc5kKTAxUHZIIgpY9mqZTYBgamIBQWQWmrLVqlhWwv/3zgEh2zRQ825TbEfxfn0HlPwhBmXitkM+iVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qo0x6FwfVqAS5uWsZQ+S2ecMjYQ7dLgAPgm0zpCre0=;
 b=cwdL2033Nwiq5c0znlN4ikzSCj9MJnkVFhn/Cv/NLJOlWpwBv/9vF1fR+gquNYBTrKpHzTxQeNxBtPyiVHSMf7z8PnVjmq/xfgc4HNM+L2JyjKw0bfzOPaCoOdBFiHEyTq36c2QjC21nfou5Uj9quUTIEQBOW9DUJSocCJcHlV8=
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
Subject: [PATCH v2 11/44] mmap: Convert vma_expand() to use vma iterator
Thread-Topic: [PATCH v2 11/44] mmap: Convert vma_expand() to use vma iterator
Thread-Index: AQHZIToiYnsZgqopq0a1R0DZdr8guQ==
Date:   Thu, 5 Jan 2023 19:15:55 +0000
Message-ID: <20230105191517.3099082-12-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: d7ac6b0c-cbcd-4fd2-3ed4-08daef514673
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ARPfkIvkw6pK+B9cEWfh8VVQKBM2BRhZiiuwIcTbHd+t7/LBj4ivwdj6LLxgIv2kBill8RLe6qspXsxn1laYiCzt77RMQY3mJo48WkS7P6A+h52IcsReuhmWIrqNU5mV8tGtGM4zBRb2CLOUzAt3f4y+ROFlE5drr3KFmFoiW1aJAAKjnl7qBE1sG6N/L2lUj5YssR8lwZ0WVkYnpVLkRcyWaq+YIJoSuNwDRpMAbfyH0VxiLCZBIItwynx4c+apXae0kvBXa8VMyuI+YenlHR+wBMglbyelrautiEN8FzjDDcmF5aOV5TcnbI3QBqW3nRY/EOBAWE5wupduYeb4HZ7DRd4XiAMwzMV9L8Z9n+l9FoB6VnnndZiNcs7LJj4fxGqc+HqIGvaY7r33TFGcRUNSQaeZ5q8g00O9VSAPLWjPhRTm4GfF9pImkY7rcwJ/cQuHzYuFt5gL5z6pvRmMThGhI4K01rA+4QuqzaImFMJ8PvT5M7mBbeTAg9sfx79do+AnAvKaXHmj8HgobU5e+IYZLQk6FmtqxBp0c4gzRkvJCn/u7vvvIKzw8h2EdtP3/KV1c5nEmhcK/eMmEq+GRCk4aQS1vDlXAlCTXbMED8TBfpvqL6OF8CVmwP4S4hYu6bkmfmEmfhlCJR4fXO6QxJfvKjylg7z2gdsrR0b4qpdpjSIo26GH8iKTv3EU430SPm6mfvxC4eqkGFd48f23g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yhSCYklmObhK+WPC7j8nHzPfmbUZbzIXoKECVlmKCj4wCX9QMCQ70Xc78i?=
 =?iso-8859-1?Q?3O/xgv9XW+0SMc50RHFaU2bdLOrBWzT+5II8ObUhT1m8CFyj+XEFC8b+uS?=
 =?iso-8859-1?Q?NSoElsqNLvSkXkCYflTHmtW+jTNlJrroQEhRI/RGNzfO8x8zaDhsh+AvMK?=
 =?iso-8859-1?Q?iDFz4/5o4Vq0lqrPTU3saQIdHHjsNVS3/jTpULviMC+jtB1dnK0X3fk58z?=
 =?iso-8859-1?Q?K39stuClZ5M2Nygz0Mm3niLVBvWDY6DCReEHV3RIzAgT907OvkHvFGnBoG?=
 =?iso-8859-1?Q?HpWOXMM7yH18AICPwWBQk5DJpy+GJddghX1lWUkfQF8ZXbNWrAW7JqbOHn?=
 =?iso-8859-1?Q?nbnKHrIUN5Kfip9GMUER4fN382K4v0/T+HRCwMXh6sC2B4fvd+HYBzP2UN?=
 =?iso-8859-1?Q?fRum8gWZtbqhamN5hlrXHUTTDR4DfMqHmiwRal+3D3ibLl+kMYG31H4b4A?=
 =?iso-8859-1?Q?3of1hd4kD5MSWf9tAFiCkjNIMHzCvXDbvej6YTBR5BJw8w0OKyUyqehiA0?=
 =?iso-8859-1?Q?48pjnqTT0j+a90YvwqmDldAZlKgTp99W/RqNGaVdXJCOD6dbeTBkdUFgyo?=
 =?iso-8859-1?Q?ecggv27/waDlM6CQxs/4cYmXrLUqG7tdRb/A1FLPjAgf6AblII8WUXbybg?=
 =?iso-8859-1?Q?N3/JD8OFod6L+nl2zsr+YUgdhsR5yEKniBjfmDO4vf5X/d88YpHi4fRN1G?=
 =?iso-8859-1?Q?N4662yKfXHfoQcGj1W+3+RGEVKWdebnBBmQquhJ1RAzSfevA6/Vk2vgj17?=
 =?iso-8859-1?Q?vkkXI3+1M/MUeHGYcwMae1Sugl2g8RHDFcbMOdRMk0KsvJzoHN5YfBXQMa?=
 =?iso-8859-1?Q?BpcLx67N1aSPORA+Px1JukeJkQR3TavWjCNn0v5WX34H5UM5XtCSXrNkww?=
 =?iso-8859-1?Q?WWoBu6Yh3JQaCQMkGosUHmw1ELRIY1k5GlCVkuXdzcobHSvUufFQ0jtlN0?=
 =?iso-8859-1?Q?p/76fRQT1oQXIQL/G+JDysbRf/At6kLyNtLwYHxBbA5GWokNw20h33zXbB?=
 =?iso-8859-1?Q?/HuGClAijUBzj4O0/cHawpeOVBViao5m17AbQPq3Ly/cv24OKyHQt+VLy2?=
 =?iso-8859-1?Q?L2gg2Wyggwy68f/Za+qnJExATCGZvFj+LVIzcO7Vm57ZUh0wwzX7fXzB8d?=
 =?iso-8859-1?Q?PRC3bWKL1422+Hfm1n+krD4XwLHUI9X/h+Jx+eyIprF3itSXEsZZYOiN1b?=
 =?iso-8859-1?Q?b3A044F0a5uBFT0NJL5mbut8JbLRyHVN6UGopTAvPaqq8d0I9Ocqr9Gj81?=
 =?iso-8859-1?Q?+1CbRbI3Y2WnvWL/qpd/++5VnPBDh7PgzRJyZ0CiAY3d/qJQ7YF96x327z?=
 =?iso-8859-1?Q?P2zcjIlCDqrg0PsjkW6fffQ9s5ZmyFdeAKVS0yunY7p55GcVgE0p+68owG?=
 =?iso-8859-1?Q?JOH5O0yqVgtVsXzMC1EN64HuZjvzFu/IRmhUjsbsj8takMJgEkRyw5CUYv?=
 =?iso-8859-1?Q?9UVtA6EB4Ue0kr3waMU2UJFXo1LBLB1s4ppWnzGTeVCkv//LjEVR7qECrm?=
 =?iso-8859-1?Q?SEtMrIrDrSF4MNNqpaRw9MXr8JQ4tj8C7mIJhbQIQTvm1jP7uVR0nhS7Sa?=
 =?iso-8859-1?Q?hlhNUCRyhM2InmVbr/g/a1dRRzm9EEYZfuqpeD2/oI2/p9o7Jefr2CMObU?=
 =?iso-8859-1?Q?l4xVZmYPJGHCn16DnC1J8G/jzPf3Su+6Oqg+/tSG64G3Kixo4C9XW5ZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uVQ+r3NrTCAWOqDartF+NKJMqqIorqWXYiQ/AQ+M4IGmXALPeMm9O8CMMdk1MtSGn6wrv8tqDjXdnbp16aQQPRBqzNQLRUVutrPjNZZcK1H6GxDXfDpmQAqsuAB3t1raiyABtHBmYY99itj9FKtahQ16DjfvLmncqNZsLMmBUTqfgs8L0ZBFddm9wQL968gP7Lq3HFhJ3SDk9UjilwMyOL0jimzYhKj8WwEwlNhJbMoSMcaineYbUAcWAh/sBSRWRhuZtnAb8l/ekovMdswOEcbcYa7j4LQOwxPV1kpd62A2Pb/ZqvnGhNbrxmdrZ2bVVH89+ojOOBPp5TRtXNtVVamy/P7yo3M/BjwqBAloehVHJxR2CkCuiSs8MRS34JklqqRGdOLeoculgchNLmxZrghyuUqEKT1rFuT2HxCFKWTlT0WWM6Jrai2727Ded2rYzqjwwj7ejrcN2D6Ho6tQqlYgnh21mOo6WoyAMSSp2cSBeFfwdZf3B0FOHrHZ6RbVqgyDw21WhmUrd7n7NmcjIKt5CozauNA/VC/SArycnfDUSuaE0dRkhfqCQ/7Ko4cTiCWdaNAjixgKFjrg75j+rwx/th3k8xIXJxg1KQy+vU5lugK7Yn8dyjXg5UnOtsNzpv5UMdrPZROs+3DiMTCCaJWbtvJftEmh26kwQCVIr7rfAsbkWuf/I2BEpMGDf8D3VUL+Kvxe1bMj+PuhC2lvHKo8LkahA+plzJADZQvN0GS0KXLZ4AaA+b6DcibEWq6sZwwTxQEZ5hMEK/NJ+tz5ke0gFmgK2DNBHj2qFManvopm/XsgB2yVgHPGZPlqTX21WcDSVSu4g7qTA6kfiV3zJt7ebx2BMo87rDC/ILaYWgQhf+icBWVmTxrt6KwcJilWusL7Skqhe9fS7r+tVEtJfQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ac6b0c-cbcd-4fd2-3ed4-08daef514673
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:55.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzSN7CIpanwPuhWzV6G/GQRmuZz3ZD8xdO7YGSVVWtFnURpPh/0BGfIsNPlmsPExbdmk/AZbtDhWb9vWhF9RFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: 8TGkMr94QBCc74Yb2m7gklBCAB84hHOG
X-Proofpoint-ORIG-GUID: 8TGkMr94QBCc74Yb2m7gklBCAB84hHOG
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

Use the vma iterator instead of the maple state for type safety and for
consistency through the mm code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 41767c585120..8fd48686f708 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -586,7 +586,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma)
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma=
,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next)
 {
@@ -615,7 +615,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
=20
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(vmi, vma))
 		goto nomem;
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -640,8 +640,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	vma->vm_start =3D start;
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
-	vma_mas_store(vma, mas);
+	vma_iter_store(vmi, vma);
=20
 	if (file) {
 		vma_interval_tree_insert(vma, root);
@@ -2655,7 +2654,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
--=20
2.35.1
