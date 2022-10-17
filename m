Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1A601C24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJQWOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJQWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:14:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC38178AB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:14:40 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJPKp8011750
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:14:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=q/d8ocWcWjjqnPZ6yvF9rpa9fuYIGMZLsTTk8Tj0Jm8=;
 b=QmYtmAfhl9vD8am4z0tCdifcoArAyuC0Qwh7qRrdFTWPKBrnO7Ex8PcFL6MyPw0ivaXY
 bnHpy8kXd4uUMnAcEU86qDAMCRF6KHqnyOA9THXhxiaCGfTt3KNaXr+gsY49A2yRtmHE
 eu5yhEAreYnxIKHrLgb7IzE4OYcpucoUelI3dOD2H/C0nvqurFUqZn3pST9GRRJuXHdg
 xCBm0iLq1CxERy6nKQBwNfjLS2MMv8NiV5B1maqcfCeDdhHAfgK0+c5Jsly3zsHdOlKL
 CWvGHzhL/EqMovj0pPCm63+UT6ocWkcys4wdJqKOlPf0veE8FmeOID4HjLARqzQs5D4s fA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9d1jhr28-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:14:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7Oldsw50Oi0dCp/3lRbArg+m/evWS9KOfoKXjt1nnEKsLgrgLeO/pT0wZMfdpLI8LAmSBsO9kwEhn9sjT80z3qGpIGK9/TCNncWa7yZgQdWx8qTmKVVfL0mn/n57R92oeesuL82NWCvvmx5P1iba4/T+wSBByfJExC7fjfPBMbz0XL3ongYVPGRAvCNLX0d90zBqnKktn1XBMBUH3QfZuMXCtZdZn+HYbuwSBFa5lh6e2sAf6kfYN5rPV3uoQxEc4QYXYM0g/rbtZcyMgSCWtEOIiHb+xvAfrbFzrXocch2L6F7st9SjsqCDv7nvz1X5M8QDUx3aFKA0t+OXv4WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM5L7bKVzhxq1Kv2zZ0x2QwcEmeOW3JhuwkZZXmJGs8=;
 b=UuMXKxGWfswwmv6pU4UlZrSKk1K60lTRZJdDoEztXeNau886NCeUI1Tvkx2Lwmpu+5GpV3/2wj0a6a61P4FqaRw0u/zxN2ISAxtK2sJPVcTFyl5X+eAogzq+URNNJgE9IYgybUH1DaUW4Mka3zQnzfsLUozlxJTAIRuuBwmy3s4O5b9FfY72CevcXjVkT4mJ+TFoAPgF4t5hy/rnkdngJl5huXolnGAcCG77CAoesWCYf4ZzNprQ4EOMIrW1HW61IaC6BBPfyCz4ZRrBePWM48OBdL2NJn7nXnx98f/UPmiXyNgMFwZv2Qh4+2mSmZbBq024zxgxr8RGj1B726zJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM5PR15MB1417.namprd15.prod.outlook.com (2603:10b6:3:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 22:14:38 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c%5]) with mapi id 15.20.5676.038; Mon, 17 Oct 2022
 22:14:38 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Xin Gao <gaoxin@cdjrlc.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: zstd: Fix comment typo
Thread-Topic: [PATCH] lib: zstd: Fix comment typo
Thread-Index: AQHYnW0cbJtj3fohcEWy5ouJvZknuq4TsNWA
Date:   Mon, 17 Oct 2022 22:14:38 +0000
Message-ID: <A284C914-6753-45F8-A695-8AE269569C10@fb.com>
References: <20220722014745.14614-1-gaoxin@cdjrlc.com>
In-Reply-To: <20220722014745.14614-1-gaoxin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|DM5PR15MB1417:EE_
x-ms-office365-filtering-correlation-id: e69ee01a-bf74-40b1-0d48-08dab08cfb31
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSk5haMb9bHi6I151Mczgw4tGTTyPx0VbPU0Kf4qwzrncaJFNvWYx3CaWaCygm5LsRIhDfGWYXy+JH3mfFhSwP5juTkJif3jBF7hlgEW+hv5LCCdIBYuBXErzGzbmJ5zBr4b4GjAv5TDoyk4VbQeOVTO+SBq7/SoSIQ2I/Z1Lk0wzHFAss3auGMlweJODIzqF56iq5i1TczHxVk5YMpTlr0Zt9GvpQ1vh17alyxFGIChr9ZIpqmXb20l1DER3equCbe4oiNQThL6dkA65rtTDOGvAxfbPBsHVWlWoJgCucLoMpkUxi79CW5mYSk483+e011oojzHvm61qdVBThxUN7W7ceyCyygts2IRdcMlpVqxWwhYeCEPmJhgmEcJSZxCbYXg8CfQ0DHpCi8DoVSl68bXWliobxo2TrVYKrJp6KH+uCyneCBHN4hUVk8qrwJByhsOC3YD5q4jY9mXVFE0lrPT9gwc7DC5Mk/KDIlWqfC3qeeXiEpTdaENdNHcYPYUIDZB5fSpiL0ql/UIl0Sxdc5uM1fERAg2B8yXTAELwOaZbdPCRBcewMVi49PPRVPNHGl1wsD21LptFZn5MVwj73Yd4waVVOH4tM7rojoIzzzDZx+ODEq6u7YmfyvMvUtdbsAIbp1t8EbsK6oUzILNhIFQebK6Z6jjNhA+ngSiIGKI8hF8yYYfOmdMWA5czF03m+35zGClFkELgJWevzktRuHQ1IS/0FIJt3bsfAVJtqX6NbORzJ1bST/TvCj7ojk6W+8BQ0SzbpMaVgjroxGXjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199015)(66556008)(66476007)(83380400001)(4326008)(6916009)(53546011)(66446008)(64756008)(76116006)(8676002)(66946007)(36756003)(6506007)(41300700001)(5660300002)(316002)(6512007)(86362001)(9686003)(8936002)(33656002)(38100700002)(2906002)(186003)(71200400001)(122000001)(478600001)(38070700005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVi90rf+mHrN1hqhf5Vwqj4flmU2hAY1bPXLEz5VhtNpmYDTv5jnu2DosKn2?=
 =?us-ascii?Q?pVjbwc0pQUL/zSYZxkaXU7OCohkpAH5OBLvMdB9zY/hofUL/eQ98gfkzNiw6?=
 =?us-ascii?Q?/OaL3g5ewe3GVfVKhxR/IKWPJOi0+lrN5ke337/PTWCcQrly6PS+0QtC9U/M?=
 =?us-ascii?Q?Vy7/gtyzrokZ3WnVRiD8P+N39KH9LAbhL2ZAQqiwDxhk3hnAcIL+Gr1ExieD?=
 =?us-ascii?Q?AaI0EYHZ5MPW2NTaOLy8QzYbPCaqUCDYLCnE/8SLlo4wg8MiVVGPEzM19plJ?=
 =?us-ascii?Q?Y9ioyM/HrmgibDNmBbdkxcDIP8DFJzuFSmu9AWm63W4PFfwmLi4yWRk985Ar?=
 =?us-ascii?Q?066YUxm4u/kmVZFBUoKMLYJjVMbi/FQWg/Q8GxvMTW18bfP10byjb/AZ1jDi?=
 =?us-ascii?Q?idsJeWcQwUWK5Vlpg7bnQICWhnbJJ7pHgNCR205XCE0Kl8oL2GS5ImM6BbQI?=
 =?us-ascii?Q?RMuR9o5hMVx4KZJund45dvZpPzN6LHSTFRHt7Pbbscog6OwfyvWip89aD0Ox?=
 =?us-ascii?Q?Ayk07ROrhAnaMj9Wpw4gSDe4EbRG0JVaRlqityGVYo1oyGCf4jtdoDoPCW6H?=
 =?us-ascii?Q?2LiKN9uKiknnxnYI4qK1l4gh1IaT+NVgRCmVjjgGFW6GvhiP4iF9h21g+g7c?=
 =?us-ascii?Q?MxHw1H5G8OhuLiOVy1W0KXDgSUN//d9B8spOpPxk+dr4pojuqXOdwU7JGyha?=
 =?us-ascii?Q?Npx6QdDo2W0uMQHBfwCcr2mHCaNP4Gcf4drMnZUyDRKJTrnutxowFduw9Ejf?=
 =?us-ascii?Q?+qlDx0/BPPmmqvG+THYN14QY9sgcPCeaUkPlTuJahCcxQ+N9lPKB1fBuqIJi?=
 =?us-ascii?Q?WeFvOkhEF44N1NJeh3/foKoowsvn1hQy/pfEyEjkI1dSPMYGgY9gbX4RuBOv?=
 =?us-ascii?Q?O0fOYuRvln3PnJZJJqwHIcVwHb7heDhKDFftJ2iGi/ct75IrFmiDxxHO1pbT?=
 =?us-ascii?Q?KtkAqEjJUPYZJ89SKHB5VSa+tjLsOg+V2QKWvRTF5p25di/lVz/TJsylZuBx?=
 =?us-ascii?Q?9cqgERNDTJdRk6WOVb4h7IEE7P71w7deKBlZ9PlIR9GnccgETYJe2RoYTnE4?=
 =?us-ascii?Q?Rq9e5QE7Tm+Xv0x8SabZv0OqiKDvxxGy8OMC+Cig6bVTEybsJO+eVtgbuu1O?=
 =?us-ascii?Q?h2lRBcrg7Kwm5GDZkeoeHQn8W0DQzfO3q7RDQDHqai1HqKWoc64f+unOI9Tu?=
 =?us-ascii?Q?qffpxCTqfVdfHeS5CIyMkr+tascQppsW1LqFDNHEQItfCj+XF+ftyf6BfQXC?=
 =?us-ascii?Q?W6pEDwyJtxa+3IRDXImmisbUUTCHPQnUDpboTqzUieNxCa3041wOdGavgNtg?=
 =?us-ascii?Q?od2wNNx2I0z+x6JO2POlZL/96PVlAoMg0uBzrA6Kd3gjYavqOw72goMmraLe?=
 =?us-ascii?Q?mN9jQi1vtU9ucebpNZkdVfUpybDPPYmKRdhsPjLg57prR60GbbEiqZ/vdys0?=
 =?us-ascii?Q?1d5oZ3679Gwl7w5YI9ItrezgKZQwwRzyDaRmp0C1cLnt0PPw8rcc3HYSSZko?=
 =?us-ascii?Q?XZ5ulLQkaDZWp2TR7hOnbaS8aqh/zS5vMSuvrhBcQbGZiO+VP0mhuV04sdJX?=
 =?us-ascii?Q?SyCAPAT7C2klTov/xb2w7DIUSf28Kjcbj0BoLgr2Ubmh9bMERojVfuc3X9D9?=
 =?us-ascii?Q?/N5qLlZ6SEE25H7LZpoao7k=3D?=
Content-ID: <EF899DC2440207459773DB593CB4FAF0@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69ee01a-bf74-40b1-0d48-08dab08cfb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 22:14:38.1927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/4u6bGNcs1Ls5sGcowhYKAOYIJOrOmqZWE66X4D99ksEeHshapY8oxFygxlvfHTJY8gJFMbDAUS3ueJoVtvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1417
X-Proofpoint-ORIG-GUID: pe9Seb5Lo33AO1MMmN7kGaDfodRks2TV
X-Proofpoint-GUID: pe9Seb5Lo33AO1MMmN7kGaDfodRks2TV
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


> On Jul 21, 2022, at 6:47 PM, Xin Gao <gaoxin@cdjrlc.com> wrote:
>=20
> >=20
> The double `when' is duplicated in line 999, remove one.

Thanks for the patch! I've taken it into my tree for the v6.2 merge window.

Best,
Nick Terrell
>=20
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
> lib/zstd/decompress/zstd_decompress.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/=
zstd_decompress.c
> index b4d81d84479a..6928e85f9d19 100644
> --- a/lib/zstd/decompress/zstd_decompress.c
> +++ b/lib/zstd/decompress/zstd_decompress.c
> @@ -996,7 +996,7 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity,=
 const void* src, size_t sr
> size_t ZSTD_nextSrcSizeToDecompress(ZSTD_DCtx* dctx) { return dctx->expec=
ted; }
>=20
> /*
> - * Similar to ZSTD_nextSrcSizeToDecompress(), but when when a block inpu=
t can be streamed,
> + * Similar to ZSTD_nextSrcSizeToDecompress(), but when a block input can=
 be streamed,
>  * we allow taking a partial block as the input. Currently only raw uncom=
pressed blocks can
>  * be streamed.
>  *
> --=20
> 2.30.2
>=20

