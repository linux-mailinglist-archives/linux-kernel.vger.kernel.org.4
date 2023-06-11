Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5326172B414
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjFKVEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 17:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFKVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:04:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEE1DB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isTGmP4gyygvzeDTVQJJ5b54EfYVD4hVkL4fAUsGjl5v6gqDovN54GmWqRzP+SC8xZkWbTP/8qdVsHnnRR+puaxQ7bCBOR1l/ccGzyXxi9u0An8xMhL3nVMSEdyJW/1grOMURL06Ybbkj35xpeTWino8qMDy3kqZOj29j53o5SftQQWN5viUoVMtWFR/SNt3vzAB95yTvmtGY0cxUU10ITYhvqrK1ZQMt9M74ocCWu1IYH4W7/ukRWgnvFw0T0O7sKLjVSmxHI4YuCMrehxY9Gj2E32TVkxVYsznbWDgsRsDdk8UqyAVRotfCcrHzEtHOWxcmr0D0MimadD2nxWjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uo4cTrgst41AXW7qH4sAD9Pve/25A0+c/5SRBPnJNE=;
 b=aiixdHpWASutNwwnFo3kB3O4W5rpEDCwr1VS73iamSqzMvXEEp+81DJH0y84o9AFFJplCi3m3m76wy9JqWs8YpnSKz6kz7B+sEejxnR/yPwJRpmBvy6qZ6F2cXVltHO6TzeYQZWGQD+3MaE2gbSdRHEU3wBmgLPX1Hw2mfmrzX2W8AAta3jg1kUpmVkzE713nuja5fbWKajoJtLjHyfZt5Y7IzqHDO8tY8Fqja6LQGnSBI5XGvqKFHzW5Fbhn7IVI8MyA+h3ciKAaOmbO/mOoKGZ/uB47P2BAdxB+8CMjEIQ29FEbqIg/4AimXNEHbZwH0gKtYzM2EtUtRXRBx0tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Uo4cTrgst41AXW7qH4sAD9Pve/25A0+c/5SRBPnJNE=;
 b=Gkag3jKOrLHGh2fuXgOh8KBesNZP8JaKm4/LEy8ItPALhhT8W0WHy2EGx8YxxAWk8NH/ipzw99igfIMLfsKis+0pElgzEOh3SZAjzB4EznzalXeg+jafdxME2eCJu2s8czxmsx+xmczhlmKmY2pEB50sbsptRf/DxDkHI0vAA4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS4PR02MB8429.eurprd02.prod.outlook.com (2603:10a6:20b:574::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sun, 11 Jun
 2023 21:04:41 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::b530:6b1b:5f11:a276]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::b530:6b1b:5f11:a276%4]) with mapi id 15.20.6455.030; Sun, 11 Jun 2023
 21:04:41 +0000
Message-ID: <8e3176e3-8eb2-de7f-cc79-d04fe48ab8e6@axentia.se>
Date:   Sun, 11 Jun 2023 23:04:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] mux: mmio: depend on REGMAP as the code has that
 dependency
Content-Language: sv-SE, en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
 <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
 <20230210115625.GA30942@pengutronix.de>
 <31f2a49f-bc48-d502-df31-667ef1a83fab@axentia.se>
 <946cea0c-6d7f-c2e3-4412-4967ece40b94@axentia.se>
 <fc94fa7f-2e73-7b9f-ea4c-2c5dffcbf844@infradead.org>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <fc94fa7f-2e73-7b9f-ea4c-2c5dffcbf844@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS4PR02MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: bf04b4ef-1931-4802-a580-08db6abf7945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xesDelj0h4BxF761Sap/6te5oll2bxZMklZx08l7gyRzxsaJeDj7qv/G8qeuT8U9W/yeqPF5ApC7FMLKKWdKfDIHp9E5QBBVPBgBzqJ2yqeqnxaHjkMCCNZHFjCYjFrQpkuEjFpG1b1Kl9xVwyMMQkkHY5SK5g6fFFaJHlZUSNoGq37FinFXfUI1XjLXGsngASwOEuulcTR21kSh7W7ZQn3tuHFZoezw1jzAtqD4qTwEwrEl+Nb1jiOcyUSCs+2f27xe/ij7/LLWck8ZzDd1tZsSSGakbazRloV4U5EQc1JD5yhoY1saER4E/vLKSvaUCMUdH6jQxZ9rChzGM2p/l1MwJKC/5oeILTbYdW5+g2CHsAoPywx8J5tBZQAm/cCOioG2cVLBrYafXM0wTXvezKaSszXAIA0uriAFaUzbuUJ32un2WFH6hPJd4W1rGb15+sPAFs90oAJoYjncg1SvUtpvtek6vRm5QDlhyh6g3lTty7FVaGZ2DWFAjpu9sra9gjJAsF9ZmemkJbIzkyvI+U+59D1GQLtkaE9Y5m4hKuJnnvwnVRCOnTyAwQQsPeCKQfDBZdu3/+S25XHzneI2Y8XZ9sCodX6+oTDXbozt3VLkI4LAlhQDWuKyTsWVZxN+Kj1ugnu/psc2Ej9RiTJTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39830400003)(136003)(346002)(451199021)(2616005)(6506007)(26005)(6512007)(41300700001)(53546011)(38100700002)(31686004)(6486002)(6666004)(186003)(478600001)(110136005)(66556008)(66946007)(66476007)(316002)(4326008)(8936002)(5660300002)(2906002)(86362001)(31696002)(36756003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFdpUnk0ZVNmNDJTSzJKSU5sZG50SG5KMjl6SjlQWlVGZENpVFBlZ0o1Y3dy?=
 =?utf-8?B?TE1za0w1YTJMUDhtR21zNGQvbEVQMk9USjZsY1c2b0tXUUdxVDZiOTVuak8z?=
 =?utf-8?B?SytFTDRiVGN0TGhHTy8wbFdNMlQ2OVlLSnI2RnptcUE3dW5JQVFNY3VPVlhI?=
 =?utf-8?B?ZERFY2hpWGcrek5XaE5GVmdlVGhHVUZna1pJTlFuRXpVVlJJZ21CTVAxeVhx?=
 =?utf-8?B?aE1wSVR5QWZCZVNkZlNueU5tbGNwa3M3VmxURkQzVTRseDBrV0JsbnpKbkdu?=
 =?utf-8?B?NHd3TUxEdk4vRTFEMUJZbzRCV0xMeXVQclBGdFZzSlkyTXl6L1hZYWVwOVhV?=
 =?utf-8?B?bjNmR1pkekU1WkdJWVJSSGpVbFR0K3gvU0F4dnNLVGg0U0RlNlN5c0pubXJC?=
 =?utf-8?B?aXBaNW9GdHU3SXhZb3pjNkFNdERTcUJPemVpbFFNZG0xL1F3Q2VTWXcvS3Ix?=
 =?utf-8?B?YVlWOGZuQWpsVjZXbGJWcmdpVXkvNHEwZFpBTk5kK0ZBcDJSTzZKaU1wYVZX?=
 =?utf-8?B?cUpuQ3UyRlBpVkdCUXQ5N2xsbm1LS2dadFVnb1A3M01Cam1NNTZDS0drQ0xq?=
 =?utf-8?B?MVp3NVJ0UEN4ZjdkVGJhMjhXUlI3ZUhSclFLZVh4VzRaRDIyYU9rMDJSRGs3?=
 =?utf-8?B?aEh6QjF5UlpmWC9RSzVyQzhMbERFaEM0aEFWWkJYcit3b0NVYlF3Ly9WNWhQ?=
 =?utf-8?B?Tm9ieTNRQ3VPQk9Ub0tBQkQ0VUszaTdFRVNLb2ZJUHJVRzdMU0pvL1BMOW1t?=
 =?utf-8?B?YVdKTFBYbnpQYlNGaGFVeGJLVUtXNWpJd1ZlMUlwdnNDZGpJZWppL2xhQ2Z2?=
 =?utf-8?B?dnJsczVJQ21UWU1ybkxLcUZDN0hqVlBmTXVqa1p3bS9lNEtjZWdjbEo2bWM3?=
 =?utf-8?B?MHIvQmlQNXN3a3NTaXBsNlZZU1o4S3JFRFM4QTl3bjdBSDNRdjBqUmZVVTgv?=
 =?utf-8?B?RFgxQVBsQkxEYW5QOWsrcnVYTEYrTG9ZYVBoclpkTmMwbzF1M0FiaU5jQUZo?=
 =?utf-8?B?d2FDTXc5VTlpUWhXamtMaFlxSTVXUXV1RVUrUUl2aWJSbDgvcmI2TkY4Mmh5?=
 =?utf-8?B?dGs3bndHNWJFSDJ5d0ZkU1VkQkFQUHJncmJCeTVqTHovcEI1WGJXaWN4Umsy?=
 =?utf-8?B?amVvV01WZlFVYk1aM1EvSk5kM01wY21YdU4xTFJOeVBWTXdvSUdtYkY1WmZY?=
 =?utf-8?B?Y2Y0YVdwd25pekNyNTgwN0RYb1ZLMklyUk5YRWZXb2xtWEJXRlc4YmRjRUdU?=
 =?utf-8?B?RW92VzYvL3llSFVOVEQyS0NJaERGSUo4Y2p4MDZONnY4VHJJemh1WHhOM1RK?=
 =?utf-8?B?RlFVVkVHV201aVlKWnFXenpLWm1ZWlRUYzRGc0piS1c1cVR5bkx3dElIZC9J?=
 =?utf-8?B?U3AxeS9KTjUvV09JQS94azR5TGtVdTVZOVNMRDFVV3lIZXVScTAvQkNFWGdJ?=
 =?utf-8?B?TzBoMkhMa2hIYzRjakZQbkNxVjdkeTFJVkFLYXVvcFhFQ0tnZ0hnTVZ4UEND?=
 =?utf-8?B?cnhrYVpDcUNsajFWdkxsV3lxNW1qRDF2OVZuYStXSExsQ0JhS2VEZ1RjSU9R?=
 =?utf-8?B?Q21xY0cwd29mbHJwWllUNTA3UkJPdTVUS3hCS2MvbzRhUXg1elZ2ZFR2b3dJ?=
 =?utf-8?B?aUpWUUNXQ0pLUVhDbWJrejJaRE9VOEhCZzZYNHkrWlZHcXNFdjJhVjFXWUtY?=
 =?utf-8?B?N2dqSHJBUk1GUWVJRkl0SEpKQnhVemR6RXRpQWVyS1dNVnBQaGxDOUpxU3di?=
 =?utf-8?B?R3BHTWV5ajNheFhvNENHUDhraTZFOTNsOFRTWEFsWW5kMzU5THFaYSsyN3BP?=
 =?utf-8?B?cFE4dTdUZjV2cWYzVUt0QzMyNlFwc21BTlNSc2tKQ3ptNHI4NzNVOCtKTEVV?=
 =?utf-8?B?WTVCU0l6OTRzVzU2TVZGL0RKN1h2Z2lwSWFISWNxUUc2V3RIZGZCcEZnOEhp?=
 =?utf-8?B?WE1oRy9jd3RrQ3FDUlIyZktDZG9jdStVcVN2TE5aZ1pzeitIK1luYnBrUDdN?=
 =?utf-8?B?ZU9pKzdJbWQ0d2ZEd0Y2YTNJWGNlblJ1dVBXZXEydHR5Tzl5TEI5SlBUaGlK?=
 =?utf-8?B?OGsycXlNUTF6SmdhTTQrWUpPc1FHRFVQTE9VMWh1TjNqeG83UUJIdXVKVjVX?=
 =?utf-8?Q?LugZjQ0C3TOafhuIq87Mph0L4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: bf04b4ef-1931-4802-a580-08db6abf7945
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 21:04:41.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HHqHv13fG7gqgswxJj41i+TLfpY+w6C83Ww8lBA/sPfp22EtxnxvsQGR1+r9WnB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8429
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-06-11 at 22:59, Randy Dunlap wrote:
> On 5/24/23 05:52, Peter Rosin wrote:
>> REGMAP is normally "selected", but that causes a recursive dependency.
>> But since REGMAP is "depended on" in other places, do so here as well.
>> The (implicit) REGMAP dependency was lost when the strict dependency
>> on MFD_SYSCON was removed.

*snip*

>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>> index 80f015cf6e54..7f07ca06eb2b 100644
>> --- a/drivers/mux/Kconfig
>> +++ b/drivers/mux/Kconfig
>> @@ -48,6 +48,7 @@ config MUX_GPIO
>>  config MUX_MMIO
>>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>>  	depends on OF
>> +	depends on REGMAP
> 
> REGMAP is mostly selected, not depended on, so preferably
> 
> 	select REGMAP
> 
> here whenever this patch is ready to be merged.

I would have preferred that as well, and if that was without problems I
would not be so hesitant as there are really few pre-existing "depends
on REGMAP".

I do not know what to do here and am not sure whom to ask for guidance.

Cheers,
Peter
