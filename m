Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27256601B59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJQVdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJQVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:33:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C07D1F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:33:27 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJP6Jt023851
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : mime-version; s=s2048-2021-q4;
 bh=tj9SlkINRB07WkEvVDE5JdkLDKnMqgoIuW803MuKqmg=;
 b=jWONqv78x/omU8G3X2NaNMtpjbz0O+cb5TeM5fxN4/4RqQ8cnMa2RU03Td0ddIT233h+
 gZzKiGEu1hE3ji/YDjhGJ6aDDr0VyGaRfVuoTRwwPZXLLginaj4kdZMU/sY/LKL7oj5d
 TSTF4RczHQDjH9eCVE+WzFJ9PF/n7z0K/Xx2CoNeOWGQxNj3PSvnPT+jsBEsa+KA+Bcn
 CgiZusufj9q19l3a0BIv5A18u85Yrtd/dcb+5vVTlqMn+1rEP1NC8y1YcDQW+gnQchyk
 5D/VQ+YpN8qjbO59gaVU75BsVMSDol9mZkBpQ15nEq3Kzf2KfYEDVdew1oIb4S+k/phN 8g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7tpv4se2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/PJlUkUPaeT0d1rmxa9A1fqA/TkyrcuCmnkpuM4EBbyJGiH6a8MWmLq1x6tRRwJmCKDPKnw1mEY9UR+7BnObFBLVi6zsVRLudAq3MHHloX+StUCahgpokq//erJAaeIJ1dwu+e8lhErELGhmlQhSzkPioexr101hQaDhzNR8KbfowywStwJPt1KpsVj49KSzoqmKKY+NI4Je8GEQfSK7NbLU5nQ5fE053BZlKmbd5KVVDMGXdNH1XRDMm9hXvCdzlwFWBALVkmwVH+Vub2gK9IBkL+Pu7llQFI4NONGnrhkhWGuUbtAD9BlUJrmt7+jCKFCCD91rs2ilvzwht6Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHU4kjKCDMv4UBh4gBPlzJ6iXugoWOZm2H+owGp+Wl8=;
 b=Xr2ithfDAVhLMLhYseJwcTSQctt7DVCkpaloIuJMq11JQOPxDVfZbk+W5toeVLv59TeiHXNZEmtPtGn+Y/ouNfwpouOGX0MFO7G664oTDDfLXx6dFnZPjmxMUVeSsXw+OSVdSKjL29kd+57NQwaUHI+IvA/644Uh56HC2Hw0PqZyMD0CWoYP8NW1osoimD6NZRWKdEiZ+ZVFookdG7LyX2iFhPRruNWU0OHrFIYVhpNmmyQjMJEDZ7foWHW/2waPw5X2Nt/SOIClhZRlqQojHpb0SuLiAvphxnYv0yCM65d2IbETxpSQPfG/ePQeNJ5sHb99imo8XSX/PJga5tQ+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by MWHPR15MB1150.namprd15.prod.outlook.com (2603:10b6:320:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 21:33:24 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c%5]) with mapi id 15.20.5676.038; Mon, 17 Oct 2022
 21:33:24 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 terrelln
Thread-Topic: [PATCH] MAINTAINERS: git://github -> https://github.com for
 terrelln
Thread-Index: AQHY302aTRIYILhcbk2P0bHjQfLzw64TIY+A
Date:   Mon, 17 Oct 2022 21:33:23 +0000
Message-ID: <B9EF7F5E-2026-4023-87CA-4D9D7526783C@fb.com>
References: <20221013214636.30701-1-palmer@rivosinc.com>
In-Reply-To: <20221013214636.30701-1-palmer@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|MWHPR15MB1150:EE_
x-ms-office365-filtering-correlation-id: 6c1c6a13-8f46-48d8-5084-08dab0873868
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5/xPxQdFkrlk8DE6VSviZ81CgapYsfkFAJr+fuVYLfSYU5oADXnVEZVXaJOYS4KqZxGKhgvNyRYA/q2reEg4mOkywbZGhtubRI42KJXtDSnHge8uurn96pzObPMcvA3Baffy9osFDNdc/gD3iyrW27PVSDvzUS/mtHXHhoySiLR7910LSowLjo7umf1NVY5NKvsvAh5Mhgzrzc3CkMtywPXwF09cuIf4eWj22JCG9FFc4F20T93NHyjnbTbprkDJy+vVx2AgxxKgQojk+V70mI3OL/TcmHImf6fLA3cfsyXBYgXCY1UK8N9+pSUvYcQhQNMsWDyRhamFUutObsoMViWJJ+Sv45JD93jzUYki6IuMPhP/B4PXTAo7VKrf61rgpxvZBUsB5tBs5zrp71XY22Ya033ZC6WwptW9IkkEBhOxLJJrePpju0y9x6S1LC5unHNsvMRMU732quQT5Kjw7dPl6Y4YiFaexd53+rWREXJR/2C62Ee0niV1fhuhffBQDdTDTshsb/VcP7A+fWQGDIucMQlUs/QSdpRDyEjXEYWn5o9x9ff2RTrUMTxrAz9yxZUamPhln8SboIoev88K+Eyq0DqPvk8ks3yvKUtHkD7BabLsz/c8U5GNTXJ99cfhpn+g0KVUEGDYJQwCKGrfJOp7OZaYz/V0kY2RFHYc0Ue6QtmWRV8z3kXFDkweM2MQ5I0p41fI8mlZuATEORZ76mcW8UpqpC2vY/tn2dcx0/fVLZYLUh0R/Uo0e7Gh9fRAayHPE/hPwSlUbPl9e8qfSIKMKM1OePwDmLq5+PoOka03fGOIplcAiU9mBa7GpNi82Qh+TH2s/JkQbWUmXFy6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(36756003)(38100700002)(8936002)(5660300002)(122000001)(83380400001)(33656002)(86362001)(38070700005)(9686003)(54906003)(6916009)(186003)(64756008)(478600001)(966005)(4326008)(71200400001)(6486002)(6512007)(316002)(66446008)(76116006)(66556008)(41300700001)(66946007)(8676002)(66476007)(6506007)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?znaBwesJsfWv+V2WgZ3rweUqwQaUMhDiTClJbVrSFlgrHeHzuvE8z81EpNRi?=
 =?us-ascii?Q?P6ZBVu3yMdsBlNKGzHTv+LoZck8y9NsKExCMTWD88CWIpBwmSgLX/1tq0kmM?=
 =?us-ascii?Q?WhtiOSD+qz1TQ/RV5RTAhTJ598ZPZ+2b4dGBkuR3bTfzknUJUVAFcZXH/T8w?=
 =?us-ascii?Q?s43BZIPHS3HMwdjS/auDCbmrShg1Me2kFhYzmvN7J652rAJ4/bon+kZ51PbL?=
 =?us-ascii?Q?TytG+l26mnmr1/cw99czgOUZFs9k07wOESjKzqwjnAAXwWvmPpR6U/obVPhB?=
 =?us-ascii?Q?csRls7STqDlevJcfPOfStJJZdbssHm45LNmcjzfU9954E5ndicEexjYXVDid?=
 =?us-ascii?Q?1qVcvJ/29kGnabateAJU9zIIauaKZBdNS/39f/JbsuUmRTiTVoeLpMhNHTsG?=
 =?us-ascii?Q?knGg76aC5Ym+kwkrSXYyE4zm3S3cchznznkOEkIMOqRL6KOXI/Co2JljWHee?=
 =?us-ascii?Q?JpBKamzsRH1sPN+x1nv7BMKl8/kAijVYdES0a1fRmUZxJuG0+xBpdGckGiFQ?=
 =?us-ascii?Q?TTJW4YIc/HkozlQj2JKyMKOHEekvdRxj0GGVOUYUGiClG12tO2ZF1DorQdUA?=
 =?us-ascii?Q?HbHbcdUldzUb+w+j9qepFIwhYUONNZAwT4ogQ7OIJFUbLY/ipBQ2K8inY2H2?=
 =?us-ascii?Q?G5OD07byobRKayaCZFYF3751OqHoERGQeNtidn6Aa3g2Xt76gX791mmS1tXZ?=
 =?us-ascii?Q?Ad8yAPOu87qQbPaZKvmWeSpS0u5iT0C60OJtZiQaqjUaN33EIXj4KHn0e/vP?=
 =?us-ascii?Q?xPQz3sdOBFKTI4Slc+v+UgWRD2GCX1U2XNdo1EQupmvFxAkcfopAwdGz+Hhb?=
 =?us-ascii?Q?zjBSHiy1hH4YDMVhMMIE2YmW3FNhj94goNx0L/ys4GIZPTobHMFNS6BRKLrb?=
 =?us-ascii?Q?5OOvytTwdNaC7f9qIxaEHb26HzJYJbCsN8V6TZ7sUxcbNzRrEu/DQbGMao/t?=
 =?us-ascii?Q?/MjUfyHekRHaf644H30EuuL2sxStMXHflrCdaQfFVadVdeCjGPUD1H9OZ6+H?=
 =?us-ascii?Q?1L5KEe67+EpRozFtDuoQL+5U3C3KgZCwfFsnmNIEVa7bvbh2EIe/j3baSdxY?=
 =?us-ascii?Q?5nbROP/Hovkv2DHESlDjmUQZ3TVLUVZlc3QQlZnwOtadlBKlOkEE3kL31ii2?=
 =?us-ascii?Q?KEBMaKr+VAk0rCNISbMVxCvIWHxR2lscpkfYEX56Hig2zSYRfuqzDvmY3Lb8?=
 =?us-ascii?Q?bcBXVYTnZZmn5U7RAh1sSoL+BtGPr1bOiuYj8pyjofexZEqvlRFI2ovNspos?=
 =?us-ascii?Q?HQDSFjDFIAZPcvtWrZMgybdSnUX07OQGw08pUCApbIi2dOk8ffuZtxDsmXa5?=
 =?us-ascii?Q?JikEAWzsauz4Dn7zcMft68fGCme8ZIaVFaNkMrZYOLhbbKHRx/0GM7r2dQ86?=
 =?us-ascii?Q?E9Nf8icocERq4qQKlqILbdjmPw7Z73PkO1x4PUssGKvfJS6C72JSvH+0E/rq?=
 =?us-ascii?Q?o6aGZ0n0KQk1LHs2TUjH3Qm446L3L7SxRIgLAJxcBpt/Em7sTg8kzouMWwb+?=
 =?us-ascii?Q?W4Ze+YX6OqRPQZ5N87w7XUVuPFuP6csYe6fnndIPiPfG+TMmOZ8YDa2bd++J?=
 =?us-ascii?Q?E83BgptocVi6lyjEgFv1C47K5xTZM+Mcv9rEB8nNYEu3quNpA0RcXrFpXYnL?=
 =?us-ascii?Q?BzA+Znx2tzN/PeehE3WQ0sM=3D?=
Content-ID: <1DBC5C2067349E4EB689ECCAE5567580@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c6a13-8f46-48d8-5084-08dab0873868
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 21:33:23.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Vl8FYKOk/MPvrMDeaAMHaig2x86tnLz/pLS2j/JTaFJbNNWPLGeP6nrzMZWlgzI/oAiLvprfGpjatJkfYUJtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1150
X-Proofpoint-GUID: asj-YhSm430Zw6ZXBrzZ7WkSqWkSPvVt
X-Proofpoint-ORIG-GUID: asj-YhSm430Zw6ZXBrzZ7WkSqWkSPvVt
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
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



> On Oct 13, 2022, at 2:46 PM, Palmer Dabbelt <palmer@rivosinc.com> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/  
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks for the patch! I'll take it into my tree for the 6.2 merge window.

Best,
Nick Terrell

> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41a925931cc3..748f9aaffdf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22528,7 +22528,7 @@ ZSTD
> M:	Nick Terrell <terrelln@fb.com>
> S:	Maintained
> B:	https://github.com/facebook/zstd/issues
> -T:	git git://github.com/terrelln/linux.git
> +T:	git https://github.com/terrelln/linux.git
> F:	include/linux/zstd*
> F:	lib/zstd/
> F:	lib/decompress_unzstd.c
> -- 
> 2.38.0
> 

