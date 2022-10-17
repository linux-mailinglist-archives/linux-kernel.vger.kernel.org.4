Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3F601B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJQVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJQVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:49:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B762BE2B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:49:09 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJPk8g028730
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=6h0cmaxcXj5SQAWeLctUzI4EhZ5dH9UsLu8oiH0omLY=;
 b=OUfz/dEzQs5FL7ZrJhGd52tHJ47Oepm8VRei89KNbZhA5QDCOSybHF+mwH1gher3yMM1
 D8QQXU4GMEVjcG2kUZJw7OQ3h3u3ZU0+3V0SGksIuyj6uRvr3wTbcCv+Rm3zYc+CrY+4
 ag+s6ZQHH/sT4KLv0v7xAwWqs16JCLc3u6dowmgXq0eGuRE0tg0zOuTUbKFrG13mpl5T
 nnHNo3Z0JggmikzdLIS+EFEJwvRuc5em0UPocLpafd4huRevO5G35u8Z+yRmephb5S4G
 UXycfeHd0GZ23+ehj8U6DCD9kGJLC7daIJ7RC2zH6ehC0JJfh0HNVBi5/lQr8MNkLHOn gg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7r6mw0j1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgBh2ccKXfKmKiMlv5o+j0DNjyHczzWwmaJT8hKt4/qY+KnriJGeA4fR90Uu0QFJvaAt1VBbGWgDAj8Kr6stipsFoS3dK3jfH2auMLBVgPARr2zu4SYlXLuffrvTlpTjfoRBzVPyXV1e0ervVDbfX89JdhZ/4kyd7D/V1n8IZiiV7CnHPYSaUDIXgHAF60Akonqz/6tatJtk+ZARJxledSJE7vBqZN3PmjzYRof8EeloZ9KJ40zg+oR7M1udEXoEA3DPKULiSwLqjH4DJeWwDCHhZOZi6Js8krkh04XDV8uJdQ5oTlVjJO+/TaT0SHdV29dNgpnFcZSXlHafexbFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ7rSXhrlWvcZkChGhAjmkFYOXEoorZJs+CmMtUF0qs=;
 b=aMGC5s1+93CtjTSDWZqQpWQ9w21Y+u9ckz6mp6C0swDtniNcHfVXW60L134XoGMQF6Gjgg/f68ol6X8iH2I+HBWjzR1O65AnPMdrA1CpH42tnYraJ9wyiQb78AI+QuDTvR8m++vRbbgOYhztaif7E4PBx4NBEhT1ZqaGp7hDxmDTrql8faaEBp/v/aGGluuxxYqz6JOSVbq2Af4flB4aGBkAVXsNlY0AftX9f1qGfZoxQJtQqmHQHbzP+PGxx/tDgVyRaCSErTTyhE0pz0hWYB2OLI7k0dNZXhl3h47pJcVaDG7cZtd6RvaHGIUehQ9RjOhywcfbibdRDPRtAwISnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by MWHPR15MB1904.namprd15.prod.outlook.com (2603:10b6:301:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 21:49:06 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c%5]) with mapi id 15.20.5676.038; Mon, 17 Oct 2022
 21:49:06 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: zstd: fix repeated words in comments
Thread-Topic: [PATCH] lib: zstd: fix repeated words in comments
Thread-Index: AQHYvmvhPY/R360MqEqgogiWdHNkeq4TZ7WA
Date:   Mon, 17 Oct 2022 21:49:06 +0000
Message-ID: <6C60A865-6BEA-4E9E-BA88-F03CFEA41BEB@fb.com>
References: <20220902013212.3739-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220902013212.3739-1-yuanjilin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|MWHPR15MB1904:EE_
x-ms-office365-filtering-correlation-id: 1043c5ea-eb84-4546-da1a-08dab0896a53
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuxJt3Vb9WYkk8IyHPv2/xdjb9MWpR8Wj9wiVCG7KUPYeEZAzhut9OzLA3OmeW4c9FRQlbfM1qvkpxXSHpbeC78PFUhFGD3t46VQhsd9iIyM3wkFBC5ryEOh9fXI4hCr8NABTiHasMz4ngx1gzixFs65Qemx0crvu65wwTHcAOwYsDHO4ehdhPH/kKTqRWj0wkpO5MO+rQj7UDoBxrsUZMvhRSQf/yC0bv9D1XgyVgRSktA4teEWNT7CNyAt8RGNN9//vWDD2Ly7A2H5G+tWRN76XvraTMUgXTMcFzD+KoKXzeUrLo3oFsWdI3TPcKgWJtHDZVg5VeIxVAqQYmnwNdx4APedVxjbFHTehk9IcmLvt3sgu+cHSb5c/sN8sxEw6WWfJDE8Df1Rx1cPGJh0rhNhNYGYF3CcKQ1dQh18L2qXvfwW2loiGrWP2s8O0g9kKpdYYp6xTYSZsPuoS8juHTI7iSp2gZxtMxz+sNymg/NEYSSBNHBD53x8+eXsYkmiSVfqGjpPggdUNuevXF5NQN5/PrNopC8YD5UfMboclSEo+rQDc4iAYT1uKO8QFSvpMq17uyxMlzJeQTEzSlO89a/pPpFOe1yKUZAfbpnA+TGINlt2WcmEwiopR02jJIakD/Tid4AN1pek5knTVZ9n3nHT9+mIVfsbLTIZXnTyo7i/zTvDvxcbIyy4mWARBo52Vqh5+B69K/ibL6sBE3hmGTV9s1Ke6+csRspeeROXHtynR7VC+XtJIrA3dPtltG9jcyq8UYer4bK6GNwn0IFh9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(41300700001)(5660300002)(2906002)(8936002)(316002)(71200400001)(33656002)(6916009)(478600001)(6506007)(53546011)(66556008)(66476007)(6486002)(66946007)(64756008)(76116006)(66446008)(8676002)(4326008)(9686003)(6512007)(86362001)(36756003)(38070700005)(38100700002)(83380400001)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PMITBlAjGBQX4DQ6UhI8H8LB85CZXIiBrafANv2cXdNvJ/qlChloeV1Qz9mF?=
 =?us-ascii?Q?kbY2Q0hCzuIHNkyccn0t53Bum+VCR5UPNtf83Rl8RcRPAaPt8swwYeFTqOES?=
 =?us-ascii?Q?FebI6nQMsm0+ADT9sjMi5DLz9ZtMzStz6s7Kwl6TnUBSP0y7UsQSUdz4Sj02?=
 =?us-ascii?Q?/KJdgk7jMZwgEorZ34rwjseLEHdliUXWwCJNhlAv2eRBth6L9Yjam094FlT9?=
 =?us-ascii?Q?VDOB0Fdckot8FPOKr/Pnv+WToFEX3on9cy4zwi8NTnIoa6ihZcDZo0cHOFd4?=
 =?us-ascii?Q?6it/cIih3LRGnHdxwO81AkniYIEbvEEn50yl1EukbtsXnbWMoCYdd+atQO1N?=
 =?us-ascii?Q?DHGTyQSiL9f/oEOSBF1pQfLFYgMFJZR2bUlfBxw8ILIPPBInQFBUYC3RkmPd?=
 =?us-ascii?Q?gQlwsKWkbMEJFQ+yMV+cm8HZn58teLJjHbdoFpH8/898UYHgiW96RkEdNyi4?=
 =?us-ascii?Q?HLdh1yy+hd/VPBNzIkY8wjBt9SnMvkBQSTRQqyeB1+kzFPy6luWwJfDWSZBj?=
 =?us-ascii?Q?s8sUlrlvKZshVxYjAZe/w+v7YhfTQedm57r3q9fe4QM8JV4VF3AEVWJUwMSz?=
 =?us-ascii?Q?NmiPIGrTgp9JfZindeZFelB9LCaIKRaNQjjBO7o/mSr1Y/sqjL6uMlphjRrw?=
 =?us-ascii?Q?UUnACBsQcXt7dhE+o6wSL1/4WgfKdAdxYoZ+yubFxnXYOa9FvRU8jpQihecK?=
 =?us-ascii?Q?WVSIUgGHKtZx0iDrXhlGJt7TiqwdMaEx3BxHjbTeUaEo6owimXoFerETcOzv?=
 =?us-ascii?Q?3mFU05qA8NzW9fk+mSUIirl1qjC1JbnSLNtSEOJZaD6dSWGW5qM865wLzbkS?=
 =?us-ascii?Q?fJGXkTjTreEiYnx/EQ1tu9dZENMRNTfApjl191HXLTY9DSEDCTBZoc+Mqxb/?=
 =?us-ascii?Q?a/fbDHi5GGu8UmR/ynkaNiToG/dnMA2+XhX+wRrY8lIMP99vCPD0PCLlcRv8?=
 =?us-ascii?Q?R0e8xvzblImQD8OPmkePvpIQBbHDSd9Pp259YrBLf+ByNYRuueDL/dUaye/r?=
 =?us-ascii?Q?TbsJGmzEA8DoSqs0H4h0PmJOgX3BZ24Khib1dZx+0YoHn8wOZxud+1+Y/IQA?=
 =?us-ascii?Q?qgCDEqw921JDrc4oDNDAjagBpUPvXb7W1tKJ8eBxRmFLdLy0/DcvkR2neD5k?=
 =?us-ascii?Q?K+kvifF95ZL2A3+Zy96IM902BcCIS2AHRyTkEYX/YpEDDpEZrfvIbaWvNiGF?=
 =?us-ascii?Q?dI787JNeuu0XdF2kvL5xsh4+hsLde+LRfF5JHHAlMEMlho9SEDwqxQeTKcSr?=
 =?us-ascii?Q?Y582UmlGTd2o5/PpUfMMKOdtjuTC75gTSbgVIcjrrL6D0EjMFBuFOMt4ypXW?=
 =?us-ascii?Q?a9r/F+t+yrmGO9NVb/xVKedVOkE9E8/hwTwJ8OT+wH1R04aaR31jHm0BDENo?=
 =?us-ascii?Q?XoVgmfXga6YcmeoUsUGtlLEoV542s1n7If+KDXoQPQvoU2nxDKnimrbGG4lY?=
 =?us-ascii?Q?nn0AhhN6I90L8MPoeiCSgUHusTzhVKFJbC3nnHmqETxWfBZbAvsVxyvP+ui8?=
 =?us-ascii?Q?gRHODfOtT9Js1Pqj4dSLZfh9WUh6wj+MRyteQDSvWH1GUoisMzDoyT8ep1HK?=
 =?us-ascii?Q?38lIgf086FNupXaIv+2G+0eCBUKUlvbBIXEBBsVbkeEQSF/UqQi2tvyIPBA4?=
 =?us-ascii?Q?CDRTxkQVV0jL8aGtmt5n3Z0=3D?=
Content-ID: <A59D7D0EE6DC784A819271A02082C057@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1043c5ea-eb84-4546-da1a-08dab0896a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 21:49:06.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9I1Z/BrZmVPaRM/IC2f+M6z9YUERIy4+1pLUMaTprQ/qh39QUL2/JgKh9qZKVZ/GuyyaJHM4wBKn8ePpRZ8WBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1904
X-Proofpoint-ORIG-GUID: adYkhv7gwBSrJULdIoBACBtSruCnUOGh
X-Proofpoint-GUID: adYkhv7gwBSrJULdIoBACBtSruCnUOGh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 1, 2022, at 6:32 PM, Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>=20
> >=20
> Delete the redundant word 'the'.
>=20
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks for the patch! I'm including it in my tree for the v6.2 merge window.

Best,
Nick Terrell

> ---
> lib/zstd/compress/zstd_compress.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_c=
ompress.c
> index a4e916008b3a..73fff4c60149 100644
> --- a/lib/zstd/compress/zstd_compress.c
> +++ b/lib/zstd/compress/zstd_compress.c
> @@ -4441,7 +4441,7 @@ static size_t ZSTD_validateSequence(U32 offCode, U3=
2 matchLength,
>                                     size_t posInSrc, U32 windowLog, size_=
t dictSize, U32 minMatch) {
>     size_t offsetBound;
>     U32 windowSize =3D 1 << windowLog;
> -    /* posInSrc represents the amount of data the the decoder would deco=
de up to this point.
> +    /* posInSrc represents the amount of data the decoder would decode u=
p to this point.
>      * As long as the amount of data decoded is less than or equal to win=
dow size, offsets may be
>      * larger than the total length of output decoded in order to referen=
ce the dict, even larger than
>      * window size. After output surpasses windowSize, we're limited to w=
indowSize offsets again.
> --=20
> 2.36.1
>=20

