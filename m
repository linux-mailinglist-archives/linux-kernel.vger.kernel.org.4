Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E56CAC97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjC0SDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0SDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:03:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567A30E7;
        Mon, 27 Mar 2023 11:03:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RHeFdP024993;
        Mon, 27 Mar 2023 18:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=psKJd1Fb7WpV7qE/eC14kqSf+lvJphPr0dEudiYyc/Y=;
 b=I8TOijHLwnzyJOPaP+FDQhtmIdQZLC4XAzLixbDQT2D881HlDWYGsfXiS3cOMgQ3BWT/
 plH9cAPb9pBdAlm+w/CKBYxuYxIFtbWmIZ+mB5QroObDZD7DuyyhCDcC5c45V4GY95Aj
 gfZwv2Z0w5XoDfC+9POQsoCvtmr8KJxFoF/65UQoBiudu/nL7Dd8J1r0TqPeW+b9lCUW
 2Fy7/n+VjheU4Ybye3hLfBN3+mREVwigwGG0M+hVWxlxg+24SE/N8+JUI9ViI61ZfcYA
 wXBtYdmauFcT0yU0FPdIZkn/r9E1rfE2yx4TLC552xVbMKP5VtiyKmcveGG+8A8tM+LL mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkfqyr3th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:02:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32RGFXA3027435;
        Mon, 27 Mar 2023 18:02:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5ac19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 18:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg31E3HYaYtr3HQrJygIUXMvMFLq5DKt99AGiUIRF1vZA163M/diUF/IaFu6ReMglujyzuLhi3X7hlm1YQfKzu5lRRBm9akjApkL4IV+CcdJikWcXN0WIYfRJCfTkeJbEwrmXlzQoaW4susv2QFHbsZ8fADadPcZTdGhFENW7VM5Ve9RzGzIi4/to5Kr2ph7b1T6Mjbr5ZxWIE8l5ezvaYNQkZq4LzpVriiy4zssWwQ4nNwuWwCxO54O5fWZXln3pHxrECCuCB3mSvINmstm/ZsvnnTX7FuMkECBLxQU17hXjA0n7nGDn0oiD2CuSBP6QS0DVFOni9RrILVzFTv7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psKJd1Fb7WpV7qE/eC14kqSf+lvJphPr0dEudiYyc/Y=;
 b=HiBPAx65oIiXv1yZA1+/QH7saBZsUM8MLe+r5QkG56P+SaVKnZgHKXmYAI2+PRc7jf9zD6lUllGEA1q6zPK0i/yHTP12cHMr6QnKKw0qQKaSZLf66c1aq03T3GsouMd9jcXEZmZvphbqiPqDeDe5y2Gbo/HkM9tqbFn44jtBbDn6WNFOS5rNUUFgeux0oFPaeIFynwPz9PBXMIDiqIgc2L6ovD8r5nzR39Rl/2mUWlIrk6i98+Oo3JNm62nDHJ45nXEqqDsg2R6eyADITcUZjN+O+YhZ9n4VlEz3zArx8nKj/Fk3xqzBh0TZT5UjCX0exhJ3rvN4pw8OMjlHQzWQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psKJd1Fb7WpV7qE/eC14kqSf+lvJphPr0dEudiYyc/Y=;
 b=FYnvjoHjxid+BURIbKdiC2dEbMnyd858GyVT2T90YRlioVLE4R6c+U2i36+nMBkZmNRgIjp7zdqkOeC0U1rCp2gr0dJrwQ0sIDRvt/cuq/Ybr9baMFOfyujuNYKnBcYYfNiKMB0MhbwOrd3119q30tIveE0PV95PrvxV4NjpKV0=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:02:39 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::2479:328e:902:c863]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::2479:328e:902:c863%5]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 18:02:38 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Tom Rix <trix@redhat.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] scsi: scsi_transport_fc: remove unused desc_cnt variable
Thread-Topic: [PATCH] scsi: scsi_transport_fc: remove unused desc_cnt variable
Thread-Index: AQHZX3qZkf0OWayeHEahRMboOzTx+K8O7Z4A
Date:   Mon, 27 Mar 2023 18:02:38 +0000
Message-ID: <F961DAB1-FAB2-4F65-AD5E-0B804F93FB64@oracle.com>
References: <20230326003222.1343671-1-trix@redhat.com>
In-Reply-To: <20230326003222.1343671-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|CH2PR10MB4118:EE_
x-ms-office365-filtering-correlation-id: 352000e3-86b4-4530-2f4e-08db2eed73e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8tz4Vpu7xBJLpxuwi0dyFm0wnS4xOMk5VEJffrxgRs+muMpC/TvUJcJzr/fO0368CtZFYyIIc0O2hmBMe8y2/ux35CKuH9Z2105RsiP73YlMP7j+ThKaTvNZyCv3LM/eId2Uc9JwmRYxgyprss1h7FgKUFLh92U9XPJdLnldkzry87rgk2mZKiK14fjnzQZYwpODz40YqtSGoq69nr/XtQwJyr+V4vUxhu2HERZZdcBrGwYdzEuBmFgwc7F2ROnyuBcuYN9N/WmX09REHQvcZYc//DDYeUTDCPQU2Inny6IhOu3cV+8WphMFDbBzi/LlVcKefH5UxAuYUsjx1//mw1ZHCGwuz31mslDhpH3wGuRfWiRpHgi8OH6+EE6gYlOITRDp1s+yoBKpGdnvNKmT1uPvlaRUlIBAQn1Rzpd+4yZ4L6DA/MouFT7THyqR4qD0tIHT4qTfQl6/29tOL1lOWC2GE9WmsyLA8QUxhdYuQI3U0LRaXKZ2pY1umP4X51UdoYAmBjuLaGPZBecLVvMEv/uokFqZxD6QsAjrmO5XHwTLey5pD5ceh9qaVo/MXcI00caxCuf13CeYb8CLmFXsymOn48zxvaV9Fr1xaI36kRXmlD/SfTxoBVwJW2t8UVXYc52B41Gup8I8Dhg3Qro93Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(478600001)(316002)(54906003)(38070700005)(122000001)(8936002)(5660300002)(86362001)(36756003)(38100700002)(2906002)(44832011)(76116006)(66446008)(91956017)(33656002)(66556008)(66946007)(66476007)(8676002)(64756008)(6916009)(41300700001)(4326008)(186003)(2616005)(6512007)(83380400001)(6506007)(53546011)(71200400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AYiTHxSlEfftyvr9ku+YhNOFI91M5du0SGFA8lYkR4quXP42tXMlNoQ4g24I?=
 =?us-ascii?Q?Dag5YWoUh7kmgGBrB0RIaFAgj3Pe4d7/vdopEZxFx8T+2kuftfCqUV5hYJ4j?=
 =?us-ascii?Q?k7OwHLFx4YfTEf2s/lt509sE0jhTdU8/MNO468uaxR2neWxqgF3OPsDOsT88?=
 =?us-ascii?Q?SQ+AagEb1XedQwgXid3POCqcyHp12DDdM1OTnNztppbNX48tb0pzeaKrYrsH?=
 =?us-ascii?Q?vLQGTUmAnPBDgQ9rVNp5qu6WNP3jj7N9RWKSrsuUDSC0vCGl/9qhvgV77Phe?=
 =?us-ascii?Q?o9wuXMe8IIUA+g3l1Xn2Hzn7Ls18Hs622arEGYTsn4jniRFKcRQKvjjc44px?=
 =?us-ascii?Q?dpcWP4dxsZOXPPNHEs0HASOj3fHgYij6GXxHZ7oJdVWyq/UCQkGFa5wEH7A/?=
 =?us-ascii?Q?Fxen9DeY+cALIiFwtjEw33+omgBgZGYXhlaBeuCexzzyvgsySiJJE2DpTUXW?=
 =?us-ascii?Q?zybyU03CaVCA6dbpz77OS0MP6Hkyx+ETvGrZntYyhRoZ+HYadUsQq7aOAEPU?=
 =?us-ascii?Q?qg15O+5DM85AeXvNj3wVYbq+94GKD/YQCMTjN5MnlSM/J83xxSwnhKD3JX0s?=
 =?us-ascii?Q?sVI15l/0e6Dy80ORKwfwGecoPhb4+jxI0kMF4vcmb4sDaWFJsiaRz/ZhJokM?=
 =?us-ascii?Q?9oee48nzLQpI73+XV+cUNe1kUv1v8rN6LAdSS873Eid30Ryvi4w2yXHRTxdi?=
 =?us-ascii?Q?F0a7/RcQgcck23YWsuMBOAjKAV0g85F8KXi4EQLa/ptM4z5dcB/kvu5lfEOs?=
 =?us-ascii?Q?20n4Q59j7Lq6bD7bCNMAgnZy0AyUICfJLc4SFFL/6J8M6e5vg//832c2s8Ir?=
 =?us-ascii?Q?BT0PUtMRFhvb4L5myg93hW3S2LxWL8FuaKPBPUA9ZPnZgyce83jmfewf8smO?=
 =?us-ascii?Q?PAAoxJZa2KQUa13HC+kp43euSKnCNf9x8l08nemA1X8rrAyw4koPJztmT6o/?=
 =?us-ascii?Q?uS/a+YaVXPqtNMP2LbZxRalrXWHw/N9feDhyUb94D3O19eWI057PE2+rI/Av?=
 =?us-ascii?Q?zb5rfSvkAvZaf8IyuuSTSNcnzLxwlzKEEl+y9ZASTEj4COQJEFRjvDI6PbHt?=
 =?us-ascii?Q?kojhUOLVzFGMt6eeHkRUMTcHs4QMlUyfOBagSku4IXMGKumn1I6aPyJhhPyW?=
 =?us-ascii?Q?atwHMRIP1vrt79zMfsVnLdJ4GU6Asgb2d5NPWkKAEzCY0o6Iz9gjmuybJDzn?=
 =?us-ascii?Q?EO3LMqv+1CF2lDbLzja/BjwtuqsuOONVytFWPmW1QyOV/a86sPMsOdbYoxkn?=
 =?us-ascii?Q?vtgzdE4WdURPDNV8OQQdeSeWkPeu1VnNO3Jok4wMy4RhqBUgrvMUV74hwvIZ?=
 =?us-ascii?Q?DB/w08v1Sd6S7/I0jekVrxH3LwfQVk206+qG7LfN4WnC5YFg3LLanuERn0+D?=
 =?us-ascii?Q?CCN3gCf2ldWnkFTLalBRvCLuIfcqi2ptZLP8iK5T3rSGjr3vy3kRnv4rh75c?=
 =?us-ascii?Q?PcCv5v1KmrwxawAkAZSMSuTxq3ghC0ngtAM/IMx4GjKBRL0ieF+7H2HfGQcI?=
 =?us-ascii?Q?I38FceXvf0FOTsO/2hDFbeYJ4QHvoMvsXVd9VCQqslT4cyTTGgMMP9IAEw4G?=
 =?us-ascii?Q?A4+avg2XK/sXVxFe8sAn/iHrHH384zpBgeVU3paXQOtQBvf2fzqNP8LygOmz?=
 =?us-ascii?Q?zbaulNxg+Ow+14W2EOFE8ifBM45qsvhSmlu0JhmBoS/x?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95E1E1CCD3ECCD4785790932998B4BEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xk3pF97ZosR9RNHv+A7qvA2OAHg5DxrhD5y9wwCgKbykydlBXwcnz38s9wP+BjMdzs/WjDj4IERcpuiJb5y0eu10inDEkhdUj9p0ikDn2IvlN+V+vAicZYEOdAmebXEUvECAKqkoDGb+jARPZnfeqYWs74NoLkHtG9TrP4rW2VTIRZzAkSL/N0Jq5NWOENt+vCUsX9RsXmniW3YwpcZDMEBNpTQGGWmKuUvm0E/f0xzQ/8PJvjReQhhci4/zc6Nx1aB7moxCtb14ww2/9ye8rt5phsYSAfRS96bUD83iYBeJdEVUTunkr2gcJXOsm554qpQk/JvGjnKchqSbKpBPaGeNxoihzxbDmioAhzYqQZxqXgOgnF96p+2nXTw1SkR4VI5b5UmlRN1uJLvXdL3gHK4iPtYhwII2W056C6gAlpuwOJEdHMjCnJg4380Kat4bByns8HOQRy5onzn1mFkvDidIB8sjBA77Bkta52n5Dj1mVVDi+LMwu9u/AXzp+t+3z9nvNhLYkjl50tNWso5MatHJuzXIPNvu993gXiHl/sWSisL3dask2A/H0CaouzXyx2P9NZf75X+fpT46V7P2Jm5+66wpfsw0iBovtMpIKkgQVrHM+lmKpYYM/B9aoeAfwpxJLVTuT0cnptlXLmQnESW7xXk4mj5XWpXvLYvCqcnIAqNEw6Dq5p/uVnCWZTxgFxIzT6HI/7U8wd9C6My2rnnbvJ1iOwzG4Vo+f81yd7QwhAbLGYGvDwrTSuVXVcr0W0dwlsRkVaQ6JlcksPo8grA4EU4l22OB1+r7jNoQTAKSXH89kUuoFoPO72o0x2wjGVfJp5E752a7PITwSvv2sY8bK13L9rXsc6oWI42ET4PCY/1wRhaOSS8B9H7H1YSzqaRfMsYVuijQXmuRJDlHy4DtJDMRK96PYKOKQg5WyOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352000e3-86b4-4530-2f4e-08db2eed73e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 18:02:38.9356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yq7zC5lFVeN8EBWomVFuw1YrXRyr8DPC5qD7Al3ZPoCuFp6SD9/iu/yPhntWFC9az9O7rgHY7KnX5WiFl6mR2tQYnWmYp6ZLsrK860G2BdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270147
X-Proofpoint-ORIG-GUID: MksLhkmb5XlN_fK4YoDqAhp6r_llCjov
X-Proofpoint-GUID: MksLhkmb5XlN_fK4YoDqAhp6r_llCjov
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2023, at 5:32 PM, Tom Rix <trix@redhat.com> wrote:
>=20
> clang with W=3D1 reports
> drivers/scsi/scsi_transport_fc.c:908:6: error: variable
>  'desc_cnt' set but not used [-Werror,-Wunused-but-set-variable]
>        u32 desc_cnt =3D 0, bytes_remain;
>            ^
> This variable is not used so remove it.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> drivers/scsi/scsi_transport_fc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transpo=
rt_fc.c
> index f12e9467ebb4..64ff2629eaf9 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -905,7 +905,7 @@ fc_host_fpin_rcv(struct Scsi_Host *shost, u32 fpin_le=
n, char *fpin_buf,
> {
> struct fc_els_fpin *fpin =3D (struct fc_els_fpin *)fpin_buf;
> struct fc_tlv_desc *tlv;
> - u32 desc_cnt =3D 0, bytes_remain;
> + u32 bytes_remain;
> u32 dtag;
> enum fc_host_event_code event_code =3D
> event_acknowledge ? FCH_EVT_LINK_FPIN_ACK : FCH_EVT_LINK_FPIN;
> @@ -932,7 +932,6 @@ fc_host_fpin_rcv(struct Scsi_Host *shost, u32 fpin_le=
n, char *fpin_buf,
> fc_fpin_congn_stats_update(shost, tlv);
> }
>=20
> - desc_cnt++;
> bytes_remain -=3D FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
> tlv =3D fc_tlv_next_desc(tlv);
> }
> --=20
> 2.27.0
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani Oracle Linux Engineering

