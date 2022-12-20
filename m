Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F06522E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiLTOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLTOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:43:26 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1A1AA0A;
        Tue, 20 Dec 2022 06:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXni79qU/zL+JrSij8en+fdWHPemBMfILznEeuYIfMPDXUKjRte6o6I9xenHiw3CWrITl1y307j0f1HpvpAd3K3iziKYlkqeeTjPgQYGS3ft1+cNcJp+JhTaazLcDVnctxcpd3k74ss2aGw+QedJWVcquRQnYJ6EAcx004+Ce4gB0F5n4CPrdQ9/ivFV6XyXZ8ZUy9L6BopQOs56th0/20gSaDDW/qzBIW7jbmU9a2QXFaWlMBsrwCodSGGSta8WaYLkygNVl84ybW83FXtfuIzJDrXpiFkfiBrJna1GB9u1gg8n/eRqCNZsJ99EDVAWVy+hTfG7zvCCi7zuG2Jo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM7QDPoUwRNWwZK+uIjWtihPHbkmzKAHArkPlHwnA+U=;
 b=B+5DIkrC0EsVPDcakZFv3gZ5qzVJtk4LvJILywUJ5/ti5PBaeDmRN7OnYcArRXHk8DLxVimzmwaVO9H2ZukqVwtwfTXElQ7op0tAyajkDXgMAxNgVDVKZ2lOwpcniKuH9mItkCD4emnxGzJJ6dp3yIaT0qg4M0M4nWlEt4EwZDxYwOcffpplBKSORuHMJQBJyOaY+5B6IIV/Lp7e11M8Hzo2j4ANJTvYmsJPhV/mBMEdrR1viZhX+NT9yX3uDLMMtBVFu7OFWA/DRkmaYODUH7BgCDlajzY81e/FeS+4xLp/ifCULswJ9v+Ig/ELdy24SAcH//A/JDn3NxY2N531nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM7QDPoUwRNWwZK+uIjWtihPHbkmzKAHArkPlHwnA+U=;
 b=QPI15maBXo1Ra6bA3zRqlA+jZCrf7Qlu4qIisBLP2mYNbPQFPy4j4ntXCg4dn88wDahy8gOn609QG3DoZ90asjZ4xA8akZhwfCBr1MHxDwgNNzLHY96ITh22UZeXi6jdP4creiQQKp1jY0Sji7c0zw6VSnc5nMMIhpdDTkBuS3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:43:22 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:43:22 +0000
Message-ID: <047ed933-9e13-804c-52cf-0815661f0f5d@nxp.com>
Date:   Tue, 20 Dec 2022 20:13:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Content-Language: en-US
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
 <Y4cF2pX4Lohefm4f@kroah.com> <bbfd859e-b8fb-d69f-887b-4a3d82bb0437@nxp.com>
 <Y6HG/vz4MWRwcEhj@kroah.com>
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <Y6HG/vz4MWRwcEhj@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To AM6PR04MB6407.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|AS8PR04MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 16af4262-e018-48c2-8d04-08dae2988ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xl29Seq85+P+O1lvO0H9guroq1Hjj7EjVmqnnUjyo67fQtrL+aHzUt2YPP41qM/5cq1qGG/D10OaABJrAztnurvjuss+w1vLenkT5RyF+5tunDYSyj5fL9qClXpkmXIPbhNMPOFuoxR/Qq+8gMWew+FEY/GsCPPOCsF6aqr6n86g/Z2BUw31WmcZ5gZQyliiK6Xy+wF/2mVdc5WLMoErQ/g8iVsUSobuaeBnKaAv8Dpuy/dJBcl5SwoHaJhZczqiv3tNEJDeNIboeoqpEIui9frtTfbZIjgFgmPQsBdCJ3zVx/GZ4BlKVJvPfP9bJ1nWHV9w40z/wXtLEWtBFpwm9gOw3ZOpCM5kBZdTU4nLX9WoHtWoKRLjrRzRJX0OrZMtEXsMLCGjTWOVDvWZ25owwV6ns1jNp/rRl04wMJo3b4lx3UpGz5vvP9NmhbBi5XggSAFpPaeTLWDdejshl5Lho0n1CF4ecCaiLk5FFG1SsAtF3wFogwlOxLZ5aLKJeAOPfLrz31KoXfVQb3xZux2BEpzZbehws3dWFYr9wScS24uHiMZfZX8hSSrGd0hfB4HdD+Bf2TqTdBD3l20mXGWlzSH+CI6cwx4dl3/LFt/S3zJsZ40kMsfKn67EBsyXuauFEX76WWZLWnXj/5grc1swEDpzqTOg5O7YwLDH8G0BNeB21UGaSgUdag3u/QeMyWd6dRLPV2fp7IUReAqVwZswdmLnbTeH3p1CLVodXcJywTtr5aFYc9R+/fHE2Ynt9YuvEWrPTlj1uP5BTZtBXXmlev6ThrWmWI3Djy6uoKQIvUMhImA8y7KBYRup3Dt5aB+P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(31686004)(6666004)(966005)(6486002)(38350700002)(38100700002)(31696002)(6506007)(53546011)(55236004)(478600001)(86362001)(52116002)(2906002)(26005)(186003)(6512007)(44832011)(45080400002)(5660300002)(83380400001)(7416002)(8936002)(66556008)(36756003)(66476007)(66946007)(6916009)(316002)(41300700001)(4326008)(8676002)(2616005)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FEUjRZWUxOelB3R1dCNWVYWUYxUExlVWlyR01JWDd6WWVpaExjcXJ0bEJH?=
 =?utf-8?B?LzR2ak9NZngvSTljYUoweWFuVWVBY2szYVRkajVGUTNwZlRNeWQycEcxSklL?=
 =?utf-8?B?eGJPVmVlK0sza1ZyV2RodmJWazNrY0tIWldrN0UxOFROUWdJZytTdDNPS0FU?=
 =?utf-8?B?ME4zNjU3VmIxaHBndVlnWEhmR0wwWTZHUVVRTXR5bHY3Ull0bUg3Qy83YVJQ?=
 =?utf-8?B?cUNCWVcvbFVEMXFYMDIyaGJVLzhxQ1RTR01PeVZVR3IwTHB1T2puckNFR2VQ?=
 =?utf-8?B?TzJZSmg1U0JITW9aeEtJMHAwM1hwSm1PTGl0R0dNY2UxcmN4Y2hxdXhnODg1?=
 =?utf-8?B?cHFTMGpNWjQ0bUlZTWVYRGgwb21ESVU3bDViL0RuUERsVjBwOWtFUzJmN2J1?=
 =?utf-8?B?V3RtajBRREdUYU1sV2tJT0ZHZkdHQ0ZBQVZZK2R5aDhJR1dvcHdsdVl3UlpP?=
 =?utf-8?B?Qy9qS2xkTlp5WEtMTXFVWmd5cXVwTzdpT0NvbGlvczNhZFIvcEJmNDhkeVdJ?=
 =?utf-8?B?MVZSY1JWcUVycjF2K1lwQWJZQjFuV0JucVA3SURwOGI2R0UxM0FlYS9RcEV2?=
 =?utf-8?B?NWhsL1lLQWlVeG9DTjU1ZWF2QXdhTXNIWk5ncE5qQmdBMnNOOHMxTlBsOWk2?=
 =?utf-8?B?STYzZXZzZGs4NHhjVnhMUUFURFZPUzFaWTZGM1hDQXdabUxKWEZvSVRFSjdY?=
 =?utf-8?B?OEE1ZE9UOGtJWXhZZG9XZEttTXh4cDdLa0cyRjV6NlYwa3M3eVAxY2ZCVWMx?=
 =?utf-8?B?MThhOGl3aGU4T0dKdTZZWHhIRlhjZjlpQVZPUGh6L3l1NE9vU3NXcjB0QzNm?=
 =?utf-8?B?ZmhqM29lc3RtVFdzN05hMXQ2bjdGZ2JNekJyblJTUEhEeHFyZC9wZE9pL2VR?=
 =?utf-8?B?RzF4S1V1a2dZcHZSTlFIU0IyaEQzQXBlOWppejZZcW5iZVdnR1hsa2Y4NitF?=
 =?utf-8?B?Vkg4cEc4M0tYcEYzNWJqSDJ5cndtRW1sSTdEdjBrVkxPRkFkRDlaODlyQUhw?=
 =?utf-8?B?cFIvQWNwNW1TdXpNQmR5L0VLclpMeEVldHRHN3VxWks2eXNJRkViVGs5dTJY?=
 =?utf-8?B?cEo3UXljWkNPb0k2cmJjN3ZhUmhoYVBqSWZEQ2FFYnljM3BIM0dWb0FnenpG?=
 =?utf-8?B?aE1KOEhZdXAwWVMyR1VsNExLRnVNV3Jzbkw3a1RqUkh1N2dSY1BtU2EzV2hS?=
 =?utf-8?B?cVVSd2tpZUdMVUpnY3l6VGtyQU93U2RxT1c2L2lOeWswY2ZrNTdxTXRHMXBu?=
 =?utf-8?B?MTVMRCs3blJ2WDU0YzdaS0NpUG9YeUw0UTY2YmVsL3cyMnMyYnQrNDQyUCtt?=
 =?utf-8?B?M04zL3BMUmFtSWFhbWtablVGa0Ezbm00TVFUa2dhZmRwOUNid1hpVGIxb0wx?=
 =?utf-8?B?ZzU1VWM1MUhrd080QzBWMkIwSGlxNzZ1Y0ZXd3JUOXlXa2hMdmsyTnMyR3Bi?=
 =?utf-8?B?RXpnOEJrRDF1N3FiVWFXQjlxaGU1NXpYS1A4a1pVUFpZandZT3JJSjUzWWlh?=
 =?utf-8?B?OFFwV3ZUeHJGSWZFTzRHbVd1aUJrVTJkMnRGWkt3RmFHaFJNNWJ3ZVU4UGVm?=
 =?utf-8?B?alI3YmY4MWJWWVFESlV6K3U1cjI5SGFKeExsQzhJTUVxVGh5MHRPdEQxYWQ5?=
 =?utf-8?B?S3JwOVdEeHdiQTVOc0JEQTUwVDJ4Y0wvci9iNTFpNWcyTUl5MXlYK2M0VStq?=
 =?utf-8?B?aUlqSHdkbEdONWt3UjN2OS8vQmtHTTY3eTNmN0dtSVJQb09xa0JsaEtiUzd3?=
 =?utf-8?B?Ym1OUDNpN1JhOXUxMUhJa3ZkMTVZblpTK1BoUC9EdnVRVUt3N2NWWGFhV1Ir?=
 =?utf-8?B?T1FaRGhLY2Nkbk12TVVKSS95NWoyV24xL2NrdUIzdDFheFhDcExnc21LLzhE?=
 =?utf-8?B?S1g1TzcxOVBEOUg5NGs1bnRjR1A3eUdaSk5CanBpcTdha3RiSWcxaUJoYWRP?=
 =?utf-8?B?QVQrck90MXJWSUlGdlk0WVhQTGoza09HQkFlbEZPTFJCLzhJakErcGxFNjlW?=
 =?utf-8?B?RkpjeG8yNjk2c0dqWWdRdzAyMFB4d3U4ZWtDc0dYdE9vNlVRc1ZaSGRrS1FB?=
 =?utf-8?B?VlZ0em9CNDdhaVlCWmFZeklSa0pzYW84azkycWdCUmI2R3J0VG01eHJVd2M4?=
 =?utf-8?B?cDFPMFVwUlRWRno4SUZwUHRoQi9yU1pLelp0a1B1Zk9nbytCK3dqWGZiODRk?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16af4262-e018-48c2-8d04-08dae2988ad3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 14:43:22.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIh25Vw8meqS5mIS+Ik60KA6/u1b0f1XeK7ials1NG8nZYmMG5a5iMvJquegNY2RN8r22NpcDwDEgEpR095pMZQaQiIesoE1bLcELCcQpL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/2022 8:00 PM, Greg KH wrote:
> Caution: EXT Email
>
> On Tue, Dec 20, 2022 at 07:39:52PM +0530, Manjunatha Venkatesh wrote:
>> On 11/30/2022 12:57 PM, Greg KH wrote:
>>> Caution: EXT Email
>>>
>>> On Wed, Nov 30, 2022 at 09:10:08AM +0530, Manjunatha Venkatesh wrote:
>>>> On 9/14/2022 8:23 PM, Greg KH wrote:
>>> Note, originally you all were "rushed" to get this accepted, and now
>>> this took 2 1/2 months to respond back to a code review?  Something is
>>> wrong here, when responding so late, almost all context is lost :(
>> Sorry for the delayed response,further we will make sure address the review
>> comments ASAP.
>>
>>>>> Caution: EXT Email
>>>>>
>>>>> On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
>>>>>> +++ b/drivers/misc/nxp-sr1xx.c
>>>>>> @@ -0,0 +1,794 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>>>> Please no.  If you really want to dual-license your Linux kernel code,
>>>>> that's fine, but I will insist that you get a signed-off-by from your
>>>>> corporate lawyer so that I know that they agree with this and are
>>>>> willing to handle all of the complex issues that this entails as it will
>>>>> require work on their side over time.
>>>>>
>>>>> If that's not worth bothering your lawyers over, please just stick with
>>>>> GPL as the only license.
>>>> Dual-license is signed-off by NXP corporate lawyer.
>>> We need a signed-off-by on the patch itself.
>> As part of Version6 patch submission signed-off by NXP corporate lawyer
>> updated
>>>> Though, we would like to understand what complex issues which require
>>>> work over the time?
>>> I am not a lawyer and can not advise you of this, please work with yours
>>> to set into place the requirements you will have to keep this working
>>> properly.  Note, it is not trivial, and will require work on your end.
>>>
>>> I will push back again, and ask "Why?"  Why do you want this dual
>>> licensed?  What is driving that requirement and what will having it
>>> licensed like this enable you to do that having it just under GPL-2.0
>>> will not?
>> Our corporate lawyer suggested to use this dual license for NXP UWB product.
> And I need a tangable _reason_ why a dual license is needed here.
> Remember, dual licensing takes from the community and does not give
> back, so justifications for why this is required is essencial if you
> wish for people to at the very least, review your code...

Sure, will get the actual reason from our corporate lawyer,meanwhile can 
we submit

next driver patch version where we have addressed previous code review 
comments.

>>>>>> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
>>>>>> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
>>>>> You can't stick ioctl command definitions in a .c file that userspace
>>>>> never sees.  How are your userspace tools supposed to know what the
>>>>> ioctl is and how it is defined?
>>>> We will move ioctl command definitions into user space header file as part
>>>> of our next patch submission.
>>>>> How was this ever tested and where is your userspace code that interacts
>>>>> with this code?
>>>> We will share the corresponding user space code soon,meanwhile can you
>>>> please suggest how to share this user space code?
>>> You all have ways of posting code publicly :)
>> NXP UWB user space code available at below shared path.
>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FNXP%2Fuwb-driver-testapp&data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C999fcbfc998c42d4ae5708dae296be78%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638071434311303825%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=1Z4h8OUd%2BM%2Fy5dnVoiBioS1%2FbR4Rqul8tW7OB%2FPCRqI%3D&reserved=0
> And the code there shows that you did not write the kernel side
> correctly :(
>
> Please fix it all up for your next submission.
>
> thanks,
>
> greg k-h
