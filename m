Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB6652211
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiLTOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLTOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:10:07 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9931B1ED;
        Tue, 20 Dec 2022 06:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDSwi0fWLkCoAh4WWP14D4pMXRQqX5+hvNARgs5JVZcNvTAAakDt8umEsTSw2nvL0JJlAYqEO8M73ioGsAn/FyqtVRohaQOLeH3KV7jc9MgJJJxHvyOS8Obz7+6yeOb8FzgL3oVuCRVfMPpKLucjdCso8WzPCYk4KUX1+bZtVnnlsjmtWAsgtCS1f9li3bzNGxkWF7Afjr5R1Vt7jwTgszu+zxMO6M3Ac/rKKWQ1oOgb2uIWFSsaKu8ZZOu4eh4VJk/Px72zpId2FgEWhVJ74eZjDvsbX9SsRW87TqvEDv5C78BBkiDfc+ivnJMzBMMLQmr7DPaWqo159KREo6zhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvmyPiEhs9Nid8p3hGU1xW0fnPYonj9e6ZPPfA7U7ns=;
 b=EEMnSh61AtR1quGVgUvjJ3pYR/PGZ2KzFKddMvvG2MlnQ81fQBiHbg8rlhFwkJDRPaDWbjwP1iiMcd6207xGCH0e8Vqm5bpZkXhfVSeZ/DKnN1+Dqe03c3gGHyw6zErh0wW7v3V9mPrLo0mzQeRZbienJXynBWOuamov87TF6dehx/MB/FhCy+VjKmbPXqd8riCZBGr+wX2pNUlSelFlyXKoqZsTF6gbT6mz/uzb4M8MHS0gTa8MAp26nAzKMHdD+Mc3EB6vhBwowKSX/zZEk4bSU0f4dyeJ5ayDmBL9fptoZsWjqg9ydLNq9BBUAoXsCJQWJaAfBQETGrGmK3P69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvmyPiEhs9Nid8p3hGU1xW0fnPYonj9e6ZPPfA7U7ns=;
 b=MCtUKZb/J4FWwiuO8FetczWQILIZOva2jvdpQtnjOQKIu2ofW8xKJzkcD6jcSGcrTn0adJi6d7Yg7/KsZ31IrBJweOXY32WJ4esDnAt2rFbNkMQTRNaXoQajbP9+jXEppmcd5REq8hAc1UZluthahHl08rBU8MZu7Y3DHN65Gjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:10:03 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:10:03 +0000
Message-ID: <bbfd859e-b8fb-d69f-887b-4a3d82bb0437@nxp.com>
Date:   Tue, 20 Dec 2022 19:39:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <YyHq9OOKBLP2GEcc@kroah.com> <5d1485d4-08d4-1e26-f597-b5fa6cc65ce6@nxp.com>
 <Y4cF2pX4Lohefm4f@kroah.com>
Content-Language: en-US
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <Y4cF2pX4Lohefm4f@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To AM6PR04MB6407.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|DBBPR04MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 38334ec6-4ec3-437d-f53f-08dae293e343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4iTMKadKYPNxaL+bzMN2vMDCRiXemdcG0TGJ+/DwKqdbyM4/ySLAgEzEp9nWrX3DYJuKVb3ZCRvzFZOELy1OvAaWNRjGplpaPDlOEolnxAiLBQV4biFN8+yNZDQY8EbjevV6FnQ5mlNu/43yz2Qyg+kyWLO8Ad57AgH2UhbnL5yAYjOLIs1Lim437rJgClqSqzFp9gVYoNbk8XtgOYP4cMEbqRS56wp8jHcjGtJl/+sscNyd98mYPkeFnS1qM7TtNKRRdtOIfmDI9Tw6DMBYrR2Uft07v8Quh0K1rKbF1ZK9crh1iZZtwzZWVBYqvUqnc0lIB6xkOhwOK9FSso2T4anCDAGTTPFCiNfhes4jXb/8Zjh2LdVG3tFavC3d2guj2sCKOz867wlrwEWdTu1k38SlfO2t/1JtuYbwikrvhOJXOJOefekx+/M0UqykUCttT5TcIeS1ARM2asuWTbTm4JWfn/c5YcTwdhLmkiNUG9YBp6yh4c9enYQnbcVoABKVtu03EDZhbuGfHIuRmNRzASe6OG4ui2RwcBK5ZkhDakludmFGLkS0CVkcuKthANCV7GClWDEw31H2kXbrh8Hala5wJ+VunbLZ95AxVaRy3iHVQ3vQIduULHZ4s0yt5IxzZ66DuzvPNYhNw31BfRBcov27h4g1vI2HTwKFQ3WKVzHT94DqHHQT5RjzF+2w9KtEbUZ3AQqBHAPdYrj4JmVrS/lw/mH/SUzDtMrPXtm33HvTHsIRXrEV8Q2W5zQbzvaA9DLhfyRGlcSnr+09J8pUVRFdANcJWkAe2dqvWK/O9izet+gN1mLMRnqMctkenfS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(8936002)(4326008)(41300700001)(8676002)(53546011)(38100700002)(38350700002)(83380400001)(7416002)(44832011)(5660300002)(55236004)(2906002)(36756003)(52116002)(31686004)(6506007)(966005)(6666004)(6486002)(478600001)(31696002)(6916009)(86362001)(316002)(66476007)(66556008)(186003)(26005)(2616005)(6512007)(66946007)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVo5V3BwVEVFbEg0TDJIZCtvZ2lxSHB5ZjZRa1pGVStkWmluWWhIamlwSjlR?=
 =?utf-8?B?SCtKOC94K2ttVkVKa3l3c0FwQUo5Tk9DZ3lTYkpoNUFUVUZOMy9TQ3Jvbk1D?=
 =?utf-8?B?VXNOVzQwL1Z3R0ppdEJMczdqcFIwS1JvWlliWnE2MUczWmo0YnY1R1ZNMUNp?=
 =?utf-8?B?Z3BtbDVhN0R3Y1lrNkQvUmlBWTJ5alM5eW9ldC9nZk1wTmNhcmZjdGVaQ3hC?=
 =?utf-8?B?c0U1ODAzaWM2OU9zK2VuY29DRHkrcHpIY2F1YXhxK01kWFJGSFI1Z0Q5Zmt4?=
 =?utf-8?B?Mm5iWlE2OHFPTEw0K1d3Wkp3bk1XUW05T3V5UkZGUUc4amsycGNOZHlUdVRJ?=
 =?utf-8?B?ejI2NEJZa1FjVS9Zd2lReGczZGRRRjdBaXdBQ2NIbmhBazdSYk5XemtnUGkw?=
 =?utf-8?B?MHFTamVzYlJNd2xHdk5qUDdhb3RJdmxSWFVOYTFNQ2kvU2pLUnF5d2YvK3Uy?=
 =?utf-8?B?TzYzNlA4NWFLQ0lEUFhCYk03MDhQeGFVU2RxY3VBRVREZ3k1YzlYYVRxWDNh?=
 =?utf-8?B?bm1mOVlVVkZHeSt4UlYwY2xRQ1c5aE11RHNFZW90OS9oeUJ3eTZzTjR3RzJX?=
 =?utf-8?B?azBMMXh3bkxXdFJpcy9nYXQ2c3QvYXNNd2UrM1NyaE5WdE9Fc1V3cjJBVW5J?=
 =?utf-8?B?VWQ0SDY3ZGZRaW1TVGVWTzRxWnFlL1pWQ3JZYkRUM1lya3B2NjVmbTlJVjJD?=
 =?utf-8?B?eFlVVnRIY2pzNm0wWjBmbUpOVy9uNU1KUktRd2ZKZ2VobDRSdGRmVlhtQUxt?=
 =?utf-8?B?NEFBZytFTnJmbW50SG1rZSthUGNOMGJIR1o4NjFXejJrZk9hWGN2ejNkMHVr?=
 =?utf-8?B?OEMrOU9aMDFlaHVTMngwa3FkWGMyWnBBYjNTcTcyOFBpanF2V0FNSi9DQW9M?=
 =?utf-8?B?V0FlT2xoblRueHBoM0NoYzYvVml5ekJJYjd6eGNhcnB4dDRFTzJJZG9vZFhQ?=
 =?utf-8?B?aC9TZG9IVGVoMW5SVzNGc2xzdGZhTmYrVzhNZDVOL29uL095UWkwcFZ1UVlV?=
 =?utf-8?B?VFVKUHkybytvM2FxLzduQkFTeXd5UFprc1hrT3A4Q3FjRzZUeGdRSTdPc3pz?=
 =?utf-8?B?RUphb1RlN0pkKzhTZ3BkOHZYek5NbGxCaHBGNnVIOU0wc3pOQkxCSDh1RXlr?=
 =?utf-8?B?czRyL0ZBdmRMdVZNa1MvY3A3aEJjWE1tLy9NbDJiZE5iOWZWVzhYcGw4UFdr?=
 =?utf-8?B?S1M5QWJnOXk4YWlNU1dwaXN5aGJjb0NOWm91YW1hOXpEY0V2Z1hyMTduTi95?=
 =?utf-8?B?MUJGZkJ3ZU5XWXE2VVZFUm95TWdTUWdOQ2FoUE9PWHE3NlZEV1BtdmY1Rjcv?=
 =?utf-8?B?RFdzSFREOXZ3OGc4N3lTK1BNUGRUWXZUeEhaOXdQSDQ1WlVpVUp0T2k1M1Fu?=
 =?utf-8?B?RzV3NC9RVmMvZktEWVI3L1dGb1g3dTdZbDVydkV6QWFHLzgzbWJBUEZGVUF6?=
 =?utf-8?B?WSswOC93N3pkZXJaaVZPb0RPZEdXcVozTmhqc0pwYWtMcXJpTnlLUnVFRjB3?=
 =?utf-8?B?Unc5ak9zZEpiVTJ2Q3psNzNDaDFiWU0wSFh2bnF6anJHeVp5aCtIN045YXZr?=
 =?utf-8?B?VTQ2UXptU3dvS1JCaFVBY2NxMVgySW0xaW5ZMUp3Q0tkOXlrTTZJaXB4akw0?=
 =?utf-8?B?UG1xREVyYkFCQ2ZOaWovWmt4VXhGc0VtU1ZnbUx2anhGWjNYLzNTWkZtSUxt?=
 =?utf-8?B?Qkc5Q1VLQS9vLzE0SlZwWXc0aVh1V1FSR015N0h2SGsvbFlCL29Td2dNS2dU?=
 =?utf-8?B?KzJXMEpxSXlOWDhkTUZFNEJoMDViSGk3OEwwWnY5ekdYZEJxekdrZStYejBk?=
 =?utf-8?B?NVZTRzV3bnNpUkp0NnF4bjdTeTRJM0ZQeHhKOE1FM2Q2cXZiVlRWTi90aE1V?=
 =?utf-8?B?TU5acFl3SitPLzBHakt6enhFK09KbUdxeFlWZzZPbU8yTW92RXhGM0Y0M0pI?=
 =?utf-8?B?Vk5VU0pGRDF6OHVvN0NzVkMvcGwzcGVqQU1QcStvU3grc2FSUkQ3b1VMb3hL?=
 =?utf-8?B?ekFlcGtjVjNXWVhmU0FkRGppenZEcFM5L3d0VzJXNnRRWkVRYnpSYlNabWVm?=
 =?utf-8?B?OGJselVGK3c2V2VScEVCY1ZuOEtaQVVpVnEralBJcm4zalN2UkJUUjNwTndN?=
 =?utf-8?B?SnhmTUI0Y2owNmw0VWd3dm93LytzYjZtcElTcmFyZzZ4eHJXUjl3QWRJWnRJ?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38334ec6-4ec3-437d-f53f-08dae293e343
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 14:10:03.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl/jfZEGs4bnmUMKD00ApKLCMuMesUU1voTIlo6w0YGahTi/uHOUYxAuAQax7CT3WYsWDKDA+adkXoI/3bY7NJl5FHGYp8xnfPGP1hy9Gc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/2022 12:57 PM, Greg KH wrote:
> Caution: EXT Email
>
> On Wed, Nov 30, 2022 at 09:10:08AM +0530, Manjunatha Venkatesh wrote:
>> On 9/14/2022 8:23 PM, Greg KH wrote:
> Note, originally you all were "rushed" to get this accepted, and now
> this took 2 1/2 months to respond back to a code review?  Something is
> wrong here, when responding so late, almost all context is lost :(

Sorry for the delayed response,further we will make sure address the 
review comments ASAP.

>
>>> Caution: EXT Email
>>>
>>> On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
>>>> +++ b/drivers/misc/nxp-sr1xx.c
>>>> @@ -0,0 +1,794 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>> Please no.  If you really want to dual-license your Linux kernel code,
>>> that's fine, but I will insist that you get a signed-off-by from your
>>> corporate lawyer so that I know that they agree with this and are
>>> willing to handle all of the complex issues that this entails as it will
>>> require work on their side over time.
>>>
>>> If that's not worth bothering your lawyers over, please just stick with
>>> GPL as the only license.
>> Dual-license is signed-off by NXP corporate lawyer.
> We need a signed-off-by on the patch itself.
As part of Version6 patch submission signed-off by NXP corporate lawyer 
updated
>> Though, we would like to understand what complex issues which require
>> work over the time?
> I am not a lawyer and can not advise you of this, please work with yours
> to set into place the requirements you will have to keep this working
> properly.  Note, it is not trivial, and will require work on your end.
>
> I will push back again, and ask "Why?"  Why do you want this dual
> licensed?  What is driving that requirement and what will having it
> licensed like this enable you to do that having it just under GPL-2.0
> will not?

Our corporate lawyer suggested to use this dual license for NXP UWB product.

>>>> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
>>>> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
>>> You can't stick ioctl command definitions in a .c file that userspace
>>> never sees.  How are your userspace tools supposed to know what the
>>> ioctl is and how it is defined?
>> We will move ioctl command definitions into user space header file as part
>> of our next patch submission.
>>> How was this ever tested and where is your userspace code that interacts
>>> with this code?
>> We will share the corresponding user space code soon,meanwhile can you
>> please suggest how to share this user space code?
> You all have ways of posting code publicly :)

NXP UWB user space code available at below shared path.

https://github.com/NXP/uwb-driver-testapp

>
> thanks,
>
> greg k-h
