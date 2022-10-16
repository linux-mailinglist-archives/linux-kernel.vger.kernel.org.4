Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7715FFE31
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJPIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 04:38:49 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9333A06
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 01:38:47 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 29G8bsTE010663;
        Sun, 16 Oct 2022 08:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=f89lXePvjCnT1OufgmfbgKs+01TmHNRYN1/FEZPg9Mk=;
 b=gikJ9Kr7+68dqTGdUzaPXJrBChNgXFraLS+gRay93QWhkP6G+SD/f/eDe1WMZUNCjA6Z
 MyfF9HbzNI8E3xIdMNUh2i/Wp/dZPcOYUem2rtxXqoLhrJqzD7bi8f5g8cJ9dDTLbPbi
 dBo2KDzj4m9z2OIpXh7UeeG/b7pYKgOAbYhNlqYp/dDGmrfaqYbQilvvfGOeQ5F1psZ5
 f0Gqg4VjLxTCJLWDZ/+vOeUlfJ9P9iwqkOLGrbe4DNy5/Xu+5HHXBZdvjh+i5A9OjdHq
 /lCo/PJ2MzI4bcFkjC0Dm9K7p5i/UOhCxe5cFtGbKWk8Jz3DVegCmQBaWcfH2wZIVOA4 Eg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3k7ku98t9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 08:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn5U9BDMYAqUCQpvOc3EahrFdJUf/dMdomTakU9AYbn827aAsWGivHcO1WbE9PfI0hdXYdQKBaVgGQ5FRvbL4z5vNHHL25CPpQpN+YVG+iMLFGHY32icgWC0F/berZYbpWNd4h0NqVOMDjXh9wPnRGFjN7bha1sTHiZkUWbh+1wlVG8yTGxYLaVnIGDh87swSB9YO8hwbV3alzYDU9dcuZnPFDO8JqISD+6aERTNLvpZlnNskcGfBQAXbmZwqPS9OUq+pDqOF7jmwDJ7WDVp28zk3GJVwPtzQRYCvQxM63YSi6uo2noSZ4wSBfdrx6HVY6Nrtbwn2dkM37pf4ynZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f89lXePvjCnT1OufgmfbgKs+01TmHNRYN1/FEZPg9Mk=;
 b=WMaJBnXsgxw3cwd1lpVtR/KC/5MHXw+FTmAwc0hyEpMuiGkJSf63T+HuZvqeGiATdBb+iDeGAGnqXcGB2mjrHQ4S+Vh1+G0SPO2qVCeDjjtUV6wEjEzg01xnHl++TCc5cuvicj/KfNq13XDVqC0aLbTvO1//TBUnSlnPC1rgtdqeVk2qtj8lKPJ0v8QCv8DjVSjVXG0yGhlk2YZiylcW3cUvPw5aba2YLSlekQvRGVYVRSF1Qgi/Bqnuq5AclLjCraX9vfQnMyy/YYJtsCakBVdbUN8JhQdgDYke/HvLNcs6rqD1CEt+R0l8RwF/5HfCRk1N+69hMV0f2LYD2NOcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Sun, 16 Oct
 2022 08:37:50 +0000
Received: from SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::dedc:c167:426:9eda]) by SA0PR11MB4766.namprd11.prod.outlook.com
 ([fe80::dedc:c167:426:9eda%7]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 08:37:50 +0000
Message-ID: <aa528d8a-7d57-7a28-07e4-8fe77503289c@windriver.com>
Date:   Sun, 16 Oct 2022 16:37:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace
 gd25q256_default_init with gd25q256_post_bfpt
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220913084023.2451929-1-yaliang.wang@windriver.com>
 <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com>
From:   Yaliang Wang <Yaliang.Wang@windriver.com>
In-Reply-To: <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0193.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::12) To SA0PR11MB4766.namprd11.prod.outlook.com
 (2603:10b6:806:92::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4766:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd518ff-ffe9-40be-65fd-08daaf51b5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9/FQLDEPa+9fx9e68O+4W0bV2PYRubirySaWjq+I4eyKb0JojjEBxQMFH8Ud4bKXnnticw5kY+JY+uMu+q+o8kGkv6Zgyh5ssQi4jSbcasGkexTpdv0cFzib941l6ITSYcsT8JQ0GKRQX0E0wc+o9szmRjWE4mNy4MXYqCvF15i0YLcaRAwUcxEGbGSe7l2TfVxClL0kecXOS2AxCg56RxEYycM+WiScB7KALHfnvi5XItgF7C/QkPrliRIcOvFKCGU8lIFPTId5B/y8gz5hodA3vMpo5lYLPKOjiVdDVD0aMGNyKblo4RkASraDpIS6Cll8YjWdX6gPXIJWSyV4eGe3PA+DC7H56p+qk5lQLELtUYneTdbCic39dKKvLLFyDgWpkI6ZUYx+krziHqHk0Jm9gpW4xTnkqdyc4tY68Nzy/GE0mk/UgwoyinNemQgXBalpw0JUZU+A2dFZOWO+RHMowteAAvgb1aXWAdVPj7PKLNfi4pCWctn7D80JatV12O8KKXim4o/ci+/wNuCQQpct2K5pqb6zfLLVhQcB7w2tthKF9PEfV/t9dFQC1/xJDxkz+GRlqozxf7KCWtB+DRb+jDqnbcRLCWvOWRB9CyJeosm54YdxBvDZZGerd5SSf8vN6MWsKVWt5eYg/2k91NSk2Bv4YWSvLt1wtW9oSbv1/WQG2wBDSPbqjHtxFlBD6VyzvteKRM8JsPYaIhDKPuB+cKUAGeseYjMATl90t0iOPfYWWJ3mePmRHnqy1FJ2znHWwnX476YOPC6EzK0OirADdzCQ+Aqp1Fr2tI6VD0wHBPzQ70jG0UHrx0BLUVmg5y35MMrC+j0u1Ed9OrXTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4766.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(366004)(346002)(136003)(396003)(376002)(451199015)(6512007)(26005)(2616005)(6666004)(53546011)(6506007)(83380400001)(186003)(5660300002)(8936002)(66946007)(316002)(6486002)(478600001)(4326008)(8676002)(41300700001)(66476007)(66556008)(2906002)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXU0VUtmNzh1OENnVHphVm9JRk1uRzQ2NHFXOUY3dFBESU5vQ3NuL3lJZW9a?=
 =?utf-8?B?MnhCR0l6VUNOREExcU1ZNFF0aEVKakgvdU9paWQvR3g1SHdsVmtST0ZuNFNl?=
 =?utf-8?B?WDBIZ1Q3Q1JEdnBLUHl0Z1ZaSE1Wd0lHeVZGNklHQXJjU2JRUkw4WVczT0dL?=
 =?utf-8?B?T0ZTdWZ6ZmdpcHZYYk5ySFZOQm5KY0V0UFJTREJPWWcwOGVZRlF6VFBhbTQw?=
 =?utf-8?B?cmVvRHdPKy90VjU1eUl6Mi9PdzhhdEJiZU5JNStNLy95YUhWb1UwRXFaYjBk?=
 =?utf-8?B?ZjNyU2kyNVFXeTRWcFYzWjhLWGVHNDcyVGQ3UTkzWFpGeTVvOTN2c0MzdWx4?=
 =?utf-8?B?bDNMTlE4V1ROc0x5cWpXRWdBQWJlQzJFMWFjSkxvampCc09tRC9YdnRtUUg3?=
 =?utf-8?B?UGtvblpaTU9vU3l5VzB3ZE5mQW5tQUVPV2crQ3U5WXMzcGJuZmNxTEVlUCtn?=
 =?utf-8?B?bFMwc1FiazdVM0dPVEt6TGJWdU55NHZCZE14RWZDVzd4a25ibFlzbzJMS2w5?=
 =?utf-8?B?aE1sNEw0SlRVSERVdGFkVGhLYUMzL1IycGxOcGxRVVpIK2ZxSFZwQ0hVU01p?=
 =?utf-8?B?Wk9tSHNmQTh0TjFiUXpKN2ZqYjd5cXd5Rm4zY0lYay9kMGsreVVJYUlpSk9s?=
 =?utf-8?B?WjdnMDh3TVhNYTlPVzEzOUcrVVZHMXNlSk1MNkdlclNGakQ5eWJjNG1qNlBQ?=
 =?utf-8?B?NUJrb1RlWlNjYzFVRGhlMms4dmdFSHZYZloyTnlUTXQrZVdDVmJVL1hQR3Bk?=
 =?utf-8?B?d2FIbnd1bTRNR1FCTVVUMTU4NDJtRXBkeDRlVFBwU2hSMVRVcGpZZDVFaGQy?=
 =?utf-8?B?WlAzalZ5NzVNZnB5ekdacEw0WGpKb2NXRUEyK1NCL0Nveld6Sjlndm1QSklD?=
 =?utf-8?B?QnB2by9CNElFbHFJODFHYWh4YlFtWWgyM3JkOUxaQmZPQlRFK1NoZjdoTHpW?=
 =?utf-8?B?bDBzUE1OZWxncnhNZ0ZYZzhIcFQ1aGdaeGxxRTlLWjRxS0tQdFRKVEtDWVBH?=
 =?utf-8?B?M2ptV1VVTGZxaEJiRDVjYVg0akJWMUkyMnNnZWw5bDBUbTI0NVQ0VjZDUm1K?=
 =?utf-8?B?eVZsK2xJK3IvZkh5dFRieHR5eXlQRGVuaFR0c0orSmFrNVh1STdnYWNaMFN6?=
 =?utf-8?B?NGdJOGpYZnVTY1V4ajY4ZzlOb1BXMzdmdm9ocHhSbWxJUjUrc0RMS0xKbGVG?=
 =?utf-8?B?TVo2bWZLZmQ4Skx0V0l6Tmprd1NqZ2x3SGp0dEtQd2dZK1B0aEFsSXNZMk9E?=
 =?utf-8?B?aWludUZuMURlRUMxQUxNK1lVNjNrNHdWZEZFdkZMMXJrMUczVEFnK1ozT1E4?=
 =?utf-8?B?UW1Bd1FGNW9mbUZxMCtaVkZtZDFRSmhDSCt4dnZLQWx1R1g0ajlsTndMQnl1?=
 =?utf-8?B?OW5sbmoxdjE0YkhmOWx3cDc3dGwveW1BY2E5a2dGbndEYWQ4WFJnTlNreHpV?=
 =?utf-8?B?TDZVMVllOGZ5dG9MMEhPRnFDejllNkIxNVUwSU10aW42US9KWGtoN0MvaEVz?=
 =?utf-8?B?cHBCTWJidDBUTlpuNndXT2RxellNeVpnZ0JVUjg0V0RHd2tHbXVXbXQ5SGpC?=
 =?utf-8?B?YXROMXdkYWkxR3RoaS9aRGNiRFJDand6clovNHVoUG9SRTRYeEtJV1FyWXBW?=
 =?utf-8?B?RndJSzh2cmRPaGZla29qUVN0U3JHanRlL1AzL01hd0gxQWJLUGt1RVZFcFUx?=
 =?utf-8?B?UHhSTnlNcTVyZjlRU3E3WFJSVEgzVXhyb3lhcndickwxZU9tQlltSEljL1NO?=
 =?utf-8?B?RXdVZnZnNFE3bGQyMXZ0K2sra1NMZDNCaXNzdTZ0aW1FeE80Q1NxbVhGYjBW?=
 =?utf-8?B?U3FVUXV5ekhtK2xaeEFIbm9weEhXM2ZmdU5oM20zenFDRmZWbUVFOTZhYW5n?=
 =?utf-8?B?OGpNSHl5RHpFaXErMTdwS2NNL0s5RWF1akxGQjlQaUNTWkprbVBtT005dDAx?=
 =?utf-8?B?eUZjVFFhUkZOSzJOUk9MVFJaVGQzbFpzNW5oa096ZmN2Vy94Y1NxM0p4b29N?=
 =?utf-8?B?R1dZcTlQTUUwQmV6QzRNRVFZdE52RVk4SUI2czB0cXFNL3BJWGNWWEd6MW81?=
 =?utf-8?B?bGxYRkRKODFOZWlobVh1a0pZcHI0eG5pcytoRm9VU0VTVERTQVIwSXpHS01x?=
 =?utf-8?B?c21xb0NobzdHZHJUMHZYcCsrUFVGQXhiRU84d1RuLzBxaUZQUFJQNnFmTkdS?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd518ff-ffe9-40be-65fd-08daaf51b5ab
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4766.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 08:37:50.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITqPbCJmQZdUcTMM98fvsJiGOMUWiAS1bm1NeYtlFCakEtXqq1qiV1x8SZordZexhPwg/G68D84Uq00sOMKY1Lww/qFW0Q+PEOk3eRDbebI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-Proofpoint-GUID: UN-TH9Y3ATuOWpEyhjDdL-6rfzBuGSTy
X-Proofpoint-ORIG-GUID: UN-TH9Y3ATuOWpEyhjDdL-6rfzBuGSTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_05,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/22 13:35, Tudor.Ambarus@microchip.com wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 9/13/22 11:40, yaliang.wang@windriver.com wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> From: Yaliang Wang <Yaliang.Wang@windriver.com>
>>
>> When utilizing PARSE_SFDP to initialize the flash parameter, the
>> deprecated initializing method spi_nor_init_params_deprecated() and the
>> function spi_nor_manufacturer_init_params() within it will never be
>> executed, which results in the default_init hook function will also never
>> be executed. As we do have quad enable function defined in BFPT, the
>> post_bfpt hook will be the right place to tweak the function.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 047275f7de18 ("mtd: spi-nor: gigadevice: gd25q256: Init flash based on SFDP")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
>> ---
>>   drivers/mtd/spi-nor/gigadevice.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
>> index 119b38e6fc2a..bdc4d73424af 100644
>> --- a/drivers/mtd/spi-nor/gigadevice.c
>> +++ b/drivers/mtd/spi-nor/gigadevice.c
>> @@ -8,19 +8,24 @@
>>
>>   #include "core.h"
>>
>> -static void gd25q256_default_init(struct spi_nor *nor)
>> +static int
>> +gd25q256_post_bfpt(struct spi_nor *nor,
>> +                  const struct sfdp_parameter_header *bfpt_header,
>> +                  const struct sfdp_bfpt *bfpt)
>>   {
>>          /*
>>           * Some manufacturer like GigaDevice may use different
>>           * bit to set QE on different memories, so the MFR can't
>>           * indicate the quad_enable method for this case, we need
>> -        * to set it in the default_init fixup hook.
>> +        * to set it in the post_bfpt fixup hook.
>>           */
>>          nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
>> +
>> +       return 0;
>>   }
> 
> Maybe we can get rid of this fixup hook entirely. If it was a default_init(), then it
> was set before the SFDP was parsed, so the quad_enable method was overwritten anyway.
> Would you please check why this method was introduced?

I googled the gd25q256 datasheet, and found 'C' generation 
datasheet(GD25Q256C[1]) implements the JESD216 standards, it doesn't 
have the QER(Quad Enable Requirements) field in BFPT, but it does have 
the QE bit in SR1 bit6, this may be the reason why the method was 
introduced.

[1]https://datasheetspdf.com/pdf-file/1295936/GigaDevice/GD25Q256C/1
> 
> What Quad Enable method do you get from SFDP? I expect that spi_nor_sr1_bit6_quad_enable,
> and the fixup hook to be in vain.
As above mentioned, 'C' generation doesn't have the QER field in BFPT, 
so no corresponding quad_enable method can be found in SFDP.

Regrading to 'D' generation [2], it implements the JESD216B standards, 
the corresponding quad_enable method is spi_nor_sr2_bit1_quad_enable, 
parsing the BFPT can get the right method.

As for 'E' generation[3], it also implements the JESD216B standards and 
has the same status registers as defined in 'D' generation, but its 
datasheet doesn't contain SFDP and BFPT definations, so there may be 
some uncertain.

So, in summary, I think 'C' generation devices still need the post_bfpt 
to add the correct quad_enable method, this can do some benefits to the 
outdated devices. For sure, the post_bfpt method should distinguish the 
JESD216 standards the first and then apply the correct quad_enable 
method, I can cook another patch to do this.

[2]https://www.gigadevice.com/datasheet/gd25q256d/
[3]https://www.gigadevice.com/datasheet/gd25q256e/
> 
>>
>>   static const struct spi_nor_fixups gd25q256_fixups = {
>> -       .default_init = gd25q256_default_init,
>> +       .post_bfpt = gd25q256_post_bfpt,
>>   };
>>
>>   static const struct flash_info gigadevice_nor_parts[] = {
>> --
>> 2.34.1
>>
> 
> 
> --
> Cheers,
> ta
