Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77839601B94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJQV5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:57:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA95F23D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:57:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJOvOd007960
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:57:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=s2048-2021-q4;
 bh=4Gwrmc/wMA7PJw4DmoTR4QVxHBNqnKj25/n6cmwGG8M=;
 b=DEQL1Y5/19SdI/qkreK/PpoReDB7fVEH3vg9aw7OFngCozFiA1m8OxRRBK9lGayDsU3p
 6IJWrtkKwZe0AI0qiz50+6PcZgPeNDR2Chn7Yh/Fbi5cCPEpoAcCQng+wVYrOVE0O9yV
 AqD79HOmtXpAMrKcyqAp/+8gpIEwoyEEP+zRbEuxp5CwPtY7/rcPwB8zOZdVL8EcI6Of
 onQgJEHWKu6TYuAsGbNHEe1pdJHYz7v2AY26qf6Mj9KoKxYUBrnqR7mreZ50bv4toN8v
 0dm9/p4tJs3H5tfLZsf0Kwb9QSblCdHmn/c3UTr1Qs7j5s3OPyyDwfc9b8y9DmVIFez5 8Q== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k99auv54j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNQwbjkKqXmR6ncvbybBcL6VPcLtiJmQJYmo2GbxffMUR7hM6riuDRQu4Tjoia/BHW6K/ZD1Oj+/2fna/01B1J0I65s3yy0oQi+YQAJTJL7EbnJ1kJRJx9a5wEAGi39dDik2tMS8vanlaR/C0XBsnYVTW2RKgTZLPQylteTov5ZD0chS8VxFltAyCjt6/LKsvcyYVexomEFp/2t6cP87Mw3ZZlR5CC6Nmmn7gjFDqqmInzOZ6tG1ML3QwZds++JPeThwRBz0MoVDuQn2FJzaTE0dK+d8eOWynDeB1LThm9gDm5j92kfmGToMoVNK2DxiPv8p6111gbnIrJXMXHrRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc+gO10ZDJ5vBNup43tL5gWHimv/C+Q0Xeqhj4SG7Vg=;
 b=nncBn/S4/eIpa2MAW+UmPKS2EKwxUDmnrdjDCLNDacUAvAxhexkd//exUi1wSrDd5SEnyT8ZuycYNmpT+GkvH9a+KGM1sUkW7NemkEbT2p23ouGrmHr+B7TiqM4WfwvmHGQM24Zt0HlZKo6vHr4OMaNyBJ7CyoG0bLoqn9hP1S1esOTeAEmK6erOT8V0D9Wt6MGzbYtik2gBSeW70lYHBvfnnJoJ3aS+V50kOjSKMwhBbKYqgOAEN8ZzI3XgGpkbloY2k61LrfpaInHYRLFDCNw/HyWr5QhZ+e2ucgpXr/bIn4qYRcp3sAN7nHBXBIWTWd11rjruLlF9NAAzE2xCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM5PR15MB1868.namprd15.prod.outlook.com (2603:10b6:4:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 21:57:24 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c%5]) with mapi id 15.20.5676.038; Mon, 17 Oct 2022
 21:57:24 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Slark Xiao <slark_xiao@163.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: zstd: Fix typo 'the the' in comment
Thread-Topic: [PATCH] lib: zstd: Fix typo 'the the' in comment
Thread-Index: AQHYnbU+DjoPft/9j0qhn2DvyBgsqK4Tq3SA
Date:   Mon, 17 Oct 2022 21:57:24 +0000
Message-ID: <CA8B85F2-DC40-4D34-88A8-D1B52DF81398@fb.com>
References: <20220722102426.81464-1-slark_xiao@163.com>
In-Reply-To: <20220722102426.81464-1-slark_xiao@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|DM5PR15MB1868:EE_
x-ms-office365-filtering-correlation-id: ce1336fa-0211-4ccd-a78b-08dab08a92ff
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qqLDJLCA/wc6OMOSPXI7NgmUahbzYfCC9ZvjvWwAEM2g073Xvi7HA9/SCI0D/MjHNO0h0jySWLdzWAJ7WGblz8hvs1qLSIBmPZALp+cGExlEE4nFuTngNf5d2dM8hHV249mdwxlG34kIR4ZTWLWWClsjOkssxxwVAACOht1ZYLInMVw1Kot0C5e4Q1vXxscfPdFrprxzmVV+iVlKAjmJ3zP/GUtM4RDhIG957fccGhZWjjiu9GIgGLunSUwUhe4AkziHvtsZPcuF4NDPg5xfaPnFju94Pik/3k/12dltSebBpJmpiny+ELinkMpb06vX4npCVY3sHxVK3PUlIFfS34vGN26ammouVxhIX6sMbKI/CDp4NJruAUxr6mKR0fOe2Sa33googU0baLUNP74+S4s7mNMAo/xLMbaFEj7XCWuz5RCuNT21WhwE2hH9G6S2iR40xt188XjBDHSXEiOs24lhkF+wxAsE0J1jmfagru2qB41W6bAlrANRfUSt4dVIQ5bTPAx1OfXBjJJv6uA1o9G+Obo3xW0RNg02Ur1tAtMx105vxEr2oan9Oop4QI41MQeq/58+kykWSKQsz3NTldIdzchPQ+Mx0fL+Uwz/KwcfhVmGRDDWXefVDhLRrm4wIH+KvB3DVAOIPDi4NMSo2UaQ4F9FWZg3cbhD68Ta2AXrk3RcQz73Vj2WjrIIzGVNOuidh5HF6Fcy8NIEuWeDiE5DgSw1L7+d5vJvRH1ERf2jI/lMx6EXmYKttVJA9030xBHWfSFqykCITeehOW78sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(41300700001)(71200400001)(6486002)(122000001)(5660300002)(66946007)(86362001)(6916009)(38100700002)(66446008)(66476007)(66556008)(38070700005)(64756008)(53546011)(76116006)(8676002)(4326008)(83380400001)(8936002)(478600001)(9686003)(33656002)(2906002)(6512007)(316002)(186003)(36756003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DCc5ZHzeJCpbMC3SORzK7ScVCLt9RuzwqAdfWU3wyrm20Ub6EcB9FCHb+ieK?=
 =?us-ascii?Q?8oqwoMVOgEjeiY5BLg8L0El0DIKURqG8pSOY/NZwHjG1MN/OrOvDfaky3pwy?=
 =?us-ascii?Q?Stc0LBY7XWc/Fv+PRJF2ZCVAOQvpawWCgjkwmNDGIFfKC5+BEU9yPOTTIwRM?=
 =?us-ascii?Q?BHK2BTxbiQV0VID5fq9HOgjY/Xb3Xd3L7EkvXBX7s+tp2nM1cFxdKYJe7ILL?=
 =?us-ascii?Q?lmzgvzMuQLk6QPRkx7aBaEQKjWk3r6fGbYl/hRZ03byMKmayhUBdXU7B71ub?=
 =?us-ascii?Q?OUcpQ0k0asYlIzRArHbylATP9i+lQo5RcXi3SklragHV+x0AzG1ZfHITrN4N?=
 =?us-ascii?Q?80QfwUdHIzZR1A/z/OUVIJ/ZFwIwBlBQHo8X4VCKoUBKBlS9CBnDDWZs3ovD?=
 =?us-ascii?Q?1u0FoBtIlLyAR7Tw9ubhfouP1KOAo/d+nkyemPf3+LyZsARD1SofAwyWaBua?=
 =?us-ascii?Q?sIayXjZl1o/1/sBiiUkQNMybWnBOme5m2xf558RSgj9zvmf3r+4zru7Vvsyk?=
 =?us-ascii?Q?9XBmx84Ze9ACp42GPHkfkYaFHXDo2esy1tA9rm5nwvynaxkTZB8kwmopQZ42?=
 =?us-ascii?Q?oOxRKPZCYie/UXA11sLgVNlawLCBK4yjsS9t4Idec3j5fb1leQDjt3xYth36?=
 =?us-ascii?Q?TdKm2wRyLVxKp2AJo0s4mpNhluEdxB7Dyi47dtgxv0rmS5ulnSXIdcyBICwG?=
 =?us-ascii?Q?MD/5fgfMBwI8bgmJ2PiQiI1hAABIAgftyLJTbwRgs3JamXPuAVmmmWLC79Cm?=
 =?us-ascii?Q?+PQkVbTh8OBb8YeWZtoXPEbIAsddvW/Vd2WWQ0RlKhrIzVkJPtMhs2KwAXYf?=
 =?us-ascii?Q?wEAeksysgDJKrvxG9CdUP6ie1JrG8UnJgDgvFuJiQmiMnfMOUASZXeH65f5k?=
 =?us-ascii?Q?l4L62MiL+/fdqO/J6PLs3o1iueRCKrRY0X3Qi+X8i8bcul/EnHT60aH7u577?=
 =?us-ascii?Q?X7jjzpryHXWTvhvA6+O/RVyzQ7LtfIhPMV0Iz6b1p12ap62W/kjcxxYRHF0w?=
 =?us-ascii?Q?YcLOw0c+6R5RVsUXF69p4Yi5Vk83fVr12meNgBkxpMMoH838dMpwFdvIQyS+?=
 =?us-ascii?Q?dqzdNF+yEC2B98rA7HQNA93jS73xjGTLwIWDi+K4M52/BOjgwa15fSwBeYmG?=
 =?us-ascii?Q?8obRV4IzczQcw1VhuxuKBLNe5WBxAFDwkBfHBkpIwKlCUlDbJU04t5pOqD/L?=
 =?us-ascii?Q?1qnz7ou2uQ4PDCZH8ZwEjy6S9bfbEWYtGXgZyahASLeGEf+JMAlVk1QhuwUQ?=
 =?us-ascii?Q?dLgmtYpZOynUntlTQJ91YbqI4iRqMbE69f1x+6fE9n9yNjtUPO+1fbowbvU9?=
 =?us-ascii?Q?OvZIn5O+1a93d05ZxxjJvXiyfHummgbAy+/mVADa+naGAGzryNcqYboyJW8o?=
 =?us-ascii?Q?LvAQtJ0KM4fivchJ1p2w/mDg8Ac9KBtOn1VLb8TdZmFdOqYgqrA4Vqzhvmy7?=
 =?us-ascii?Q?ugM3Y75e7rJFdxoycwSElfFCvnJQWUSj5Vf+RgJQKkjqerRQgCgANuRqwzeQ?=
 =?us-ascii?Q?4vDTq8jseFdbSvftgxPsDvuxb3vixxEMCO7BIU5GIOBSETv7Lymv4jZ9/Ked?=
 =?us-ascii?Q?ZMnww6bB5dXtkF0t09CBLWo+F6KGffP+BYNyqOL4tT+hpo36Sz83OUiS+8Ga?=
 =?us-ascii?Q?Jl6/j0vsRrkhbMWY0TKfXsQ=3D?=
Content-ID: <CD3B1D5EFF33A143917555F24418A234@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1336fa-0211-4ccd-a78b-08dab08a92ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 21:57:24.3925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6vJ0POMF2QCV2P+x4VDTYTk5bsHVGKIHudv+jcC/b3Z6Ex20dcGvcpwy3f1sEmuZNquFPOnlfAwhkGSQrHMdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1868
X-Proofpoint-GUID: FOElFZe4jg2I7rtGX3IJb7xNinrtA4qf
X-Proofpoint-ORIG-GUID: FOElFZe4jg2I7rtGX3IJb7xNinrtA4qf
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



> On Jul 22, 2022, at 3:24 AM, Slark Xiao <slark_xiao@163.com> wrote:
>=20
> >=20
> Replace 'the the' with 'the' in the comment.
>=20
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Hi Slark, I've already merged another patch which makes this change into my=
 tree,
so I'm dropping this patch.

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
> 2.25.1
>=20

