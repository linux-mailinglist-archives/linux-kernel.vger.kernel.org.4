Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A592D6E6127
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjDRMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:23:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F052D4C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXYUvbr03slkWEfoh4EZXt8muFzqqQFoiZFyglO8OkKd3Agstx/zvf+FV2E5rjCG3mN8sPM2Rlge7/Vr0ImgKFkgwQ+fA3Z1huCWnBgwFWMvwTR8jaOh2H0+toeBcQj9iCILyZX+mAiGlRN8KeCLgAI5ept3jo7+ygMuE11JKoh22Bg+4+rC55Eop+/fX8mIpbQcwVk5P3FoaFgj2fjatx6bU6UIX+eZmMwTYivJOYHkbs0/t/bGGFH0BLu4Dz+5/vo7fdaIplelBvBkg8fHNakwZU0PYeJjjW74QncY74deU58lLLgnmff4gcdLlmp5A/Qb+c0fOYv/tFTRFYs+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ngKSDnhWljnINHoudtsfCOB8Q5wvGmv2ZHO9Z/hGMc=;
 b=W+LrrLTCy/kmywnryQdMTHeg0PVBav50tYl7oHlWxe58ppQsXBBiS0RDUMPo9YFgxapzMNrebNvUeEKKDTTwslezCkKV49xPOBl+P2g1pujAR3cSRiSuAE3hgf0+qvZTY85qpvlCojLlMzRk4Lz7opGhTPh2j4NZz/NWodvJ08XNCbIBEzH5eOW+P+Dr41pzM/sI2BHUWzcrE9Tfut4DFSAn5ra/Ma67WGtyt5NrqOkeFnpn8G0+ZVdU9xAq63sys5bvLAT2H6mBY9G/lvDgiE0ABQ6cvOFK5WXgwKXWh4qqgxXd35EYu6BXPW5azDOzgknij1S1OjatbTP3SiBZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ngKSDnhWljnINHoudtsfCOB8Q5wvGmv2ZHO9Z/hGMc=;
 b=SHhassBVTOrmFjJd7o/l0FjcKzHggYkNUEKT4a1U6NuZZoFQlUZSZPWEzHMpsMET3zCdd/kVqJv0C9jqsQ/JoEfVORhpQhJMMLGLabfNNAtOs5zhNwU5d8pZg6OwEAEMRZ3O1+IFtEaWwMT8aRBiaxGxYJSSGWBx+FRGGEmaMFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from SG2PR03MB6732.apcprd03.prod.outlook.com (2603:1096:4:1db::11)
 by PUZPR03MB7013.apcprd03.prod.outlook.com (2603:1096:301:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 12:23:39 +0000
Received: from SG2PR03MB6732.apcprd03.prod.outlook.com
 ([fe80::3dcc:2a50:b1d4:b953]) by SG2PR03MB6732.apcprd03.prod.outlook.com
 ([fe80::3dcc:2a50:b1d4:b953%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 12:23:37 +0000
Message-ID: <0fcf5bb1-938b-64dd-d76a-e8f819acb9cb@nuvoton.com>
Date:   Tue, 18 Apr 2023 20:23:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] ASoC: nau8825: fix bounds check for adc_delay
To:     Tom Rix <trix@redhat.com>, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, luca.ceresoli@bootlin.com,
        peda@axentia.se, javierm@redhat.com,
        u.kleine-koenig@pengutronix.de, ckeepax@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230418120955.3230705-1-trix@redhat.com>
Content-Language: en-US
From:   AS50 CTLin0 <ctlin0@nuvoton.com>
In-Reply-To: <20230418120955.3230705-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To SG2PR03MB6732.apcprd03.prod.outlook.com (2603:1096:4:1db::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR03MB6732:EE_|PUZPR03MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 80206db6-7c37-41fc-33fd-08db4007bc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QPJ2zmAzgmpc5+bxkX9zlsvOfyFudczl3AibmtiD2ThXTbwzf+XS8ADBqNb2dlT80t2Wd0E6RlxvzaF0V95RPnD2PC2b80/YHOjzQQ0IylbEpnrxxFCOPIQT0kCpEr/QCGAYNeZWRSMq8QRwcWfys19vX1VGByf+d1rQfi58jj2fcoQ752TUjR05c614J9Z36Ha9HmX1p1D62wpzsp1nnOH5zFk37e7CuTqmpoW1YDHPs6zcbcMT0tivcVrU2x65hJSS5q2kNypN795funfnaR6PVwIAJKjYEmZcE5UAXRRmjJfk4KtAuPF8LHfS6hIl0RZTv34l48FX1I9EPIsOSStnDkcK3+Hw6iWcY7IWVQiQuCDUO7X1/t2sjNU7zlo9tdA2yFPHjbJkOIYhllZTU/oPCTioY2SCU5Mg9TmLEn/k/J221xK27wb0NCjqzjKSpI8AlESLsZe1d778TEQAxOEB7bGh2d+RtnJo2DO0zWIGuwvBr8EwPMZEZg+rDsMIXXXfRXIZZtONrccq9UvpUkKa5+VN3jH93ZBUFyth7NPeu2sEp0Bl8mPGwe/Ave1zuAOla76zGKn45DVl7rF/PhTAGyq4mkl7kgsiNPOq7unovr76i3TBT8trxZok+v4kfcVgrwTPKl2Du1Wtyj0zhR/tJfktfhrGCUo5NB9OTY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6732.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(316002)(186003)(53546011)(66476007)(66556008)(4326008)(6506007)(26005)(6512007)(6666004)(41300700001)(66946007)(2616005)(478600001)(6486002)(2906002)(8676002)(8936002)(7416002)(5660300002)(83380400001)(38100700002)(921005)(31696002)(86362001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZnNGMvS1A1VUFFaFdCVUs2U1F0UTFxckRKVVN6N3lIazNSdTJXQTYrYjJ4?=
 =?utf-8?B?a3p2Rk0zUUNzSVpjOTc3d2xtSng1ak91eEZHUm5ramtQcEo5RFlVR2ZTYVB3?=
 =?utf-8?B?OXJjbE1VeFg5SXFRSFFnWmV3eDZldUJtT0lnbXgvU1JoV2ZmSlg4V3NsVnlj?=
 =?utf-8?B?OElHVFVDN09ZM2M1SXBQQm5MOVpOdGlQbkllUDcwTjZKakM4TjlXSGRUNkhs?=
 =?utf-8?B?N29jbVdYbFlQZkVsV1pNVGF3dVJLQTNHSjM2dWxGU0VjT0RZSGN5b2pnWUZZ?=
 =?utf-8?B?SldZMUtUZm5Bc2JxRkxJMStreitLUnNXbnVabEIxK3NLcVNhakIwVkRNZWRa?=
 =?utf-8?B?SVBsZVQwK05helpkTG1lMkZJU21jeVFobXl3R2hteTI3TTdubXpCR1U3ZVJ6?=
 =?utf-8?B?ejBhRDdnV2VTa3dLcjNQM0ZkTDk2T1FxUlRGM29pb1l0Wlk5UnhuZytTY1o3?=
 =?utf-8?B?RXBZV3BjY3FvMkZOUC83YnJZaXM3VTNnaUp5cHJRdHQxdFM5ajVUejZCQ3dk?=
 =?utf-8?B?QzZMbHh3dkl1bndzTkRMNDhDdDgrMzNiRjljYWJHUk53WEkzcytqRGp1QzNv?=
 =?utf-8?B?RmJReTFBbFRqWXNTVk5MaDBhUXJnWnJVRTN2eGY3azlDRkZpWXNpZ2lGWkVP?=
 =?utf-8?B?b0Vod0I2eC8zVTUrZkovUVBDT3VqY3A0Qy9CT3lnQU10dGdZMDhkci9lZEtB?=
 =?utf-8?B?VDFmNzY2NjhaUmVvM0w1ZkplVDFYT0lvOU1ISGFuQWk3OGRNd24xWm5UMDA0?=
 =?utf-8?B?MHBoc2VqdjJtNnpVVXZZV0dFdHF6OW1rTlFGcnltanVnZENQYXNnQ0pEMVcw?=
 =?utf-8?B?OEgvdDBiMDFWcUtvWEZrVVZ1dmx4K0dTK3JPTm96QlV1MmVoQ1NDYmllTlNT?=
 =?utf-8?B?RGYxa3l2d3NJWDRWWGY3d1Y2dUdyZFJjR045NjZZUVJObXFETlNTbU9WWnBk?=
 =?utf-8?B?amZtRnluTm5tTjlIeS9lays5em03NU5Zbnp5aCtzU004YXQ5citNVXVjK0dw?=
 =?utf-8?B?ZVdubzE2SCtGenVtOTNiUnVycjFOUWdSUSszSWRDRHFwdjg5cWN5QmxRZFRR?=
 =?utf-8?B?NEF6Rk5ac2lMbE5FMnFTU2dCSldrVTlOWTI3SWQ2SkhrZTVJcG1EMWd5VFB3?=
 =?utf-8?B?M3NWd3UxYi8wbVdEZm04L3dVSGdVUjZqRjZHVGNXRjU3bTZONmd1a3Bnd1Na?=
 =?utf-8?B?SE4vZi85NjQ0OWxZVjNLOFZYUmVrWjgxU1ZCbDhKQTRzRXZUNTJQZlJWKzVp?=
 =?utf-8?B?L1pLNjN4Ri9qTEJYcE5pY3BRMFlYMDc5MVhDdmNwZ0FieUVISVJYdEd3dko4?=
 =?utf-8?B?Q3pxcjh6ZkFwcWZ4QnIwbFVoQUdHRTBFYmhMZXI1VE13S3FDd2VJRHM3dGQv?=
 =?utf-8?B?UTNCRUxnOE55cDBWMkE5d3lyeVlvUmFhT2prUG5scFhFRzB3azF2UktTRzNp?=
 =?utf-8?B?S0tjeUs4c01tRzlIbzJnTWlyYlhkQTA2VWpwdXREakNsaGVqbm5iT2p6bVo0?=
 =?utf-8?B?V1lxcUdZcVkxdWwySy9PZTNhVm1odGpNTXcvRFROc2RxUlJhR3JUWjAvanU2?=
 =?utf-8?B?NnpLR1FRZWw3d1pHU0h1aVVBc1RNbjErdkx3eC96MXprK0NjUCtYMzRZMXEw?=
 =?utf-8?B?WGx6RjVuNXVuZXdaZHRGMWNrQzhDWDJOUTZXVm9Zem9VUGtweVo2UXprbVZj?=
 =?utf-8?B?cW1udlpIWFgvRXdZVXQ5V2ZVcDl0czBUbG9YUm4wNEYwVllnTWtmWElJSkdh?=
 =?utf-8?B?Z3ZDRXRNVzRpakFud2lmNFprbXdOSE81UWFVTy8xcjFhUW85VWVzWXNXNFhE?=
 =?utf-8?B?V2RhZUczMVRvbnVKR2h0UDNlS3RpUUVnaTQwOHRkZmVKUFA2Z0F5dFNUSFc0?=
 =?utf-8?B?dWF2ZmFBTXJJNU5CbTI2ZmFIK2lpdCtrQ1BzYnNFM3hjUFoxeEVaVXczY2pB?=
 =?utf-8?B?ekxRa2RyNERSVDVlNnlqbmsyWmtiOFh1QmovNWJrMmxZU0VYSEdwdVg1dnMx?=
 =?utf-8?B?cUlmcGI3ZTc2Q3ZsQmlFRFFDS29Fdndma3NFNlcwaXp2RnZvUXh4bzh2ekgv?=
 =?utf-8?B?aGZ2WnNMNFZQN0pkc1hmQnI3ci8vKyt2UGQ1T2g4ejlleElxTzgyV0NnSVZW?=
 =?utf-8?Q?p/OipnD5plnEvvzzGLYhGWpOB?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80206db6-7c37-41fc-33fd-08db4007bc3a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6732.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 12:23:37.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YahDjsCsHShvnNf7unWE2YGw8/FbLP4Ap+FsBIUOYkvi7oBa1yECbSp2Y/lxhmYkZxgzxwhzK/e4S7TXotJ6dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7013
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2023 8:09 PM, Tom Rix wrote:
> clang build reports
> sound/soc/codecs/nau8825.c:2826:31: error: overlapping comparisons
>    always evaluate to false [-Werror,-Wtautological-overlap-compare]
>          if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
>              ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This is a bug, a logical-or should have been used.
>
> Fixes: fc0b096c9291 ("ASoC: nau8825: Add delay control for input path")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   sound/soc/codecs/nau8825.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index c4389f5fe603..f4eb999761a4 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -2823,7 +2823,7 @@ static int nau8825_read_device_properties(struct de=
vice *dev,
>       ret =3D device_property_read_u32(dev, "nuvoton,adc-delay-ms", &nau8=
825->adc_delay);
>       if (ret)
>               nau8825->adc_delay =3D 125;
> -     if (nau8825->adc_delay < 125 && nau8825->adc_delay > 500)
> +     if (nau8825->adc_delay < 125 || nau8825->adc_delay > 500)
>               dev_warn(dev, "Please set the suitable delay time!\n");
>
>       nau8825->mclk =3D devm_clk_get(dev, "mclk");

Sorry, it is my fault. You are right.

Acked-by: David Lin <CTLIN0@nuvoton.com>

________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
