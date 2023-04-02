Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33C6D3ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 00:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjDBWRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 18:17:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58E6B46F;
        Sun,  2 Apr 2023 15:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPwcUg7zfTETgsHlACwWLfEjFCmEwJwMBwFZq1onYDuuETcBjZ1RPL46zOHTrwSn4AasgOvjNeOpQFgyS4dxxom6oloIuBtUMPmTfckv8p+Ff06FWuJD8cLOPliFCdWkBSNqOg5JrBTANi1h37ciE7w7hDKH+yv22rJ3kmZL0w0tpjZts3sF8qJi+pEevE0u+abI+XRjBW8zMR2Uy9Y4bi1QOt0kd5C9D/emWS8RfWVM6Et3LTepJLtKqPJiFVGTHSDsWS1zf2n9IZ7zDrSQYSLOhHH154mmHjCMI8M3OwT5gMwx4h0kJ7EldizgDZolwVNxV+P1qRCtgZLsZgF4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oYgyFwhdEufHV0LBJlpgkwYK6MPgNymjSFb5ka4USE=;
 b=RIoS1ajqcz2CbnVGy2hHuo03niIqAvTpk2pM9mvJLbsdbfMve/YrPOE2oV53Yq/bA+6f2yo6xxR22iTUUII1VgP7RdJTZ9UXn9QZOarCLPNcHxCIB8n8BCCffBtJzYxzvIB+VIMWFf3F9vbUVa8ydozUSkwDTJWbo81sH/4PVlWKW2oYfE5Heyfq5sTS8ZDmFyPEv1Wetj/HBOX91H0Ey/P7bjk+SeD1BW+cqgvh7PwDz2gU//7Eu0GBS2cxLf3xrBdisMKa+y+iiPol880nKmt+bxsBQginrSnO4GOtz6s0KhAgKOWi6zkAG4Pmgo4vhg2IQh4lxvu40bmSzFfssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oYgyFwhdEufHV0LBJlpgkwYK6MPgNymjSFb5ka4USE=;
 b=lQFXHU1gO5+wq/d0drNF+zUoSJ4crG58PwUUub7pHAMGrFJO1lvc5HbiKRys9EnF/D9GgafpeVR7lskYbYwx60OAkyArcmZCGrATamVRrWhitlmqzK3DcbgRel+pdnEnw/q89vlnhLIeWvtU70oYhXybe0PTlzAEtcD5npUxGi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Sun, 2 Apr
 2023 22:17:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Sun, 2 Apr 2023
 22:17:32 +0000
Message-ID: <ea9b0d97-ddf6-cc22-652f-dde1ec6c1e89@amd.com>
Date:   Sun, 2 Apr 2023 17:17:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] platform/x86: think-lmi: Fix memory leaks when
 parsing ThinkStation WMI strings
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
 <f2bbd848-2079-d5cb-6a59-9040708dc429@amd.com>
 <dfd65bd6-26d8-4ef4-8eaa-3cc412f381ec@app.fastmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <dfd65bd6-26d8-4ef4-8eaa-3cc412f381ec@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f34af79-be80-4863-8dd5-08db33c80dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzUSYiun+6b+iWDHURzO8qKHB/IrgY5TmRwfPjKM6mJt25x1HUrn7u4opNpvByZKe7TkJQ67WRtKERDjv9JM+7zfBEkdWlIIxoZL0h0Db23oEwJB7VqemEZFgKLJKGxjRmXm5TlhSEm62rm9ekl14GL+iG5GpE3fRpn/E0vQ8/Y84w954bsmV4KLMnB7mxaIFJkgD5gHcsVmwqOngm2ToIgCzldEzXuqFskM4bkFg+Mojd6EPN3f2HxLOHfRP+hxvy11UFcmc2JXmq+tCxKCx15z8s17nmShMG2RK2OrvwFivxCexuRVTU4hzA92Y8RcYzHwSep252vvgjGqvn84vHiA85u0D/tKq1tgmmfP9qn9eS56z9V69zenGvCLPQjzYHqE/3gytT6gu9Un1HpIp7Ea2aOgiNe0gQYe+Bl9RuSa2ULg6D3GeSypiZCrhfJXmuPSPTc/udlsuKFEQ5lyrYCTKL10WHypQdJmAuvLsloSYMCPtNWkFTt7E/+I0wGzIGt3WR1Zp2UCD6MHvFP5gvTyqBSm2L9MK2ad1h1UYf7tqzFPK7Dn7H562r7VqNbYAv8ylesKl4L6J+1g2B+6SS5eE2PZ0IGFUARwdR4WlEXPzNlfefmzo7D3V9qxei9Lj+warXE9+M7MWC4pJEu8JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(5660300002)(86362001)(2616005)(31696002)(186003)(6666004)(53546011)(26005)(6512007)(6506007)(38100700002)(8936002)(66556008)(478600001)(66946007)(54906003)(966005)(6486002)(36756003)(4326008)(6916009)(41300700001)(8676002)(66476007)(316002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhqcEt1c2tGbWNqU0VCUnlTcUhEODZMOThac1hSZGc1NzQ0U1hzem80T0dm?=
 =?utf-8?B?OW1qRjlaSDU2Z3hEYkNjdytqUTY1dStKcFBJWVJoZHIvOFpHNDBUMURvY3lU?=
 =?utf-8?B?YWxsd2l1ZFo0a2thT1hkbWp4S2QveHl2UHBCRE9jVzh6U2FKZDUxRGNpbWlH?=
 =?utf-8?B?TmFwWXRGSHRQWWVEZzhJdTNEVjBBbkE1MUFvYzlXRzVhVmpaNGV0TTN4RmZu?=
 =?utf-8?B?MDE0YzRCMm9aODBZY3krV0d3MS96OEd2dUpBSm0zYWQ2SnRwblFPN291bk1M?=
 =?utf-8?B?MnpRcGQxb2JINlRmeG05L010RVpaR0VVM1pMZXBsVG81b0Y3WUdxRCs5L2pu?=
 =?utf-8?B?MkZVaURLT2tpTEwxZzJ0aHR5anZDMnhyM0YxQW1oVlZ4c1hWUDkvak1lL25N?=
 =?utf-8?B?Um05RUFTT3lkcTF4Q1lZMkhkcTg3eFZBMmhMVkVPZVRaUk5MZjk5Qzh3Y0t6?=
 =?utf-8?B?YmJrbFJnRUVFcXBsaG1LeEhzZWVQZVBSZGhmcVY0cUMxMlBEWGdZbW1Ca1Uv?=
 =?utf-8?B?Ym5yeVpLK3ZOWUpzZGtqQzV0dFZUeUFPV3VyZFNOZCtUWlJpYk5KZE8yM1ZK?=
 =?utf-8?B?YjF1c0U3NDRZTE50REdKaEZmYnpMMnRmMXpaUy9HcmxFT1l0RkgzS1hxNGlR?=
 =?utf-8?B?N01Tb1BXL09RUTNjSzBMaXRSbzlSR0s5V3g1WXJZM00vMmU0YVFCZTE1NnVZ?=
 =?utf-8?B?UXVBTytJeXFZUXYzeTI4V0lLTXcwQlFkdmRKaFc5QU54cmFyTUpOSWlNdnJw?=
 =?utf-8?B?aEthSm5RVWVWTzFXUjVUSERUTkRuNXJlQnl2eE9KS3loNXdQVzg0NW9Na0gz?=
 =?utf-8?B?bVpNZFBlY0RNWGxodVNBbUVETE5XYk93NDJNc3JqdmN0aVorK0JtOXRiRkhT?=
 =?utf-8?B?TnJuWTl1a3pKR1RJY0pLV3kzNFRBc2NSczRWZ2pSQmlvVjMyeDBqSkhDeU5S?=
 =?utf-8?B?aE5jeno0TXpza3BIdXlWU2VGbk9qb296cEFTSTlpUjV0Wk9OU2FBNDhrREs1?=
 =?utf-8?B?ODBLdEdZNXJsVXI0UVNNOEtKRFl1M3lkdEJNbHVHQzI0S1ZoNjRneWt5UGpI?=
 =?utf-8?B?MnZQcFd4Y2g5VE5IYlByalY0a1YraVpUbVNDbFI1YzJwOFEybVk1TFBBYVls?=
 =?utf-8?B?VWlZOFJ4NUNJR3NQQUxtOTRsb2o5YldWbFltTk0xMGxldmJEUS9uZFFEcENn?=
 =?utf-8?B?RkVRTE5QK2dtY3FqQWV0eERmNWlCQ1ltTnZQeXl2UW5TMGZxcUlJaE5zekM2?=
 =?utf-8?B?THlibmtjK2lmZFRyRjBnakEyVHUweU53bm5oZkc3YzR2UWlFYlpja1U1dGp0?=
 =?utf-8?B?TGYrRUs3MDBjNG1WOGFhUFQ0SUM5N05pdlB5eGV3bzVnWXRpbDIxSUlLVVBT?=
 =?utf-8?B?dDJKaUl6UW9IcE5pdmpxbmxhMzhxTFpjaFMrTHN4dUtPNkhLMUFSMU1EdHoz?=
 =?utf-8?B?Vm9WWXFYN3hsbHErMExRbzZXQ0JPOEJCUHI3N0pkaDhOZUxwOU1kWjR4cGta?=
 =?utf-8?B?dDNRWmdTeUpOVGc3bEVEQ3pyYk5HQ2p6ZGNOZU1NZzlrSEczSG5CM2QrZmpI?=
 =?utf-8?B?ZmJFeXlEZ1JWcWh1ekVkbExDWXEzV3NzdU9iZ09wYXBiNlZlS1QzQXJWWWsy?=
 =?utf-8?B?dmVKNzM1QVlVY255Mkd3NkczZ00rY2VUdEFaRHd0VTVYbXZMSkx2Q3NwcHdW?=
 =?utf-8?B?NVJ1WUFxRXcvaTdUQ3oxY29vTTl3eDVXelZ0RjBOWmltT2pnYjhiTEo1MU9i?=
 =?utf-8?B?REQwSDB2Y1lLSGFNRy81dHlKZjJDYWJjZmNyOTBHUVcwdGpJcTNnMGJHQnhR?=
 =?utf-8?B?SE9DNVI2TkhXR1FsWGFKUTdmd3JlZlh4LzQzdkk4Um44MWNvTVkrVDBhT083?=
 =?utf-8?B?b1dmL29BYXRhY1BKZXc3QkJDNjVGRzRHQm53UWx4LzRIdFkySWQzdHpES05U?=
 =?utf-8?B?d2M1MWlqbEpkSEhWcmxvMlN0UHZwajFOUXBWaVBqSTRwaHV5dkdnYWRsdEhz?=
 =?utf-8?B?ZndMVzVkaUxIeURzL3BqQXAxY3lQMjA3MGtvYk9uL3ZqZGgrVkN6a3dEUHZo?=
 =?utf-8?B?UUxqNThDNkpCODg5N0g1VjJXNjNXU0E3MnA0RytnQjY1LzFyN29NVUZhS3FZ?=
 =?utf-8?Q?WCmV9o3qY7dnAjq5MPFfNUCQv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f34af79-be80-4863-8dd5-08db33c80dbe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 22:17:32.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eJN++TlHf4O4QP8adVDbhYsCVAYWMl2YTylrR4KtYtzVOC/D1lJu8ujyn4HHs+KBbS+0rTbaDU85Geb8/8eqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/2023 14:23, Mark Pearson wrote:
> Hi Mario
> 
> On Sun, Apr 2, 2023, at 10:04 AM, Mario Limonciello wrote:
>> On 4/1/23 13:43, Mark Pearson wrote:
>>
>>> My previous commit introduced a memory leak where the item allocated
>>> from tlmi_setting was not freed.
>>> This commit also renames it to avoid confusion with the similarly name
>>> variable in the same function.
>>>
>>> Fixes: 8a02d70679fc ("platform/x86: think-lmi: Add possible_values for ThinkStation")
>>> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>> Link: https://lore.kernel.org/lkml/df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de/T/
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>> This patch series builds on top of the proposed patch from Armin Wolf
>>> "platform/x86: think-lmi: Fix memory leak when showing current settings"
>>
>> Which version of the patch did you do it from?  I tried to apply v3 of
>> Armin's patch
>> to Linus' tree and then apply these two.
>>
>> The first applied, but the second had conflicts.  Here was my base (with
>> patch 1 in
>> this series applied).
> 
> I was using v2 - but there shouldn't be any code changes between v3 and v2....so I hadn't re-based.
> 
> I'm working in the fixes branch from pdx86.git (with the aim of making it easier for Hans to pull in the patches). It's possible I've goofed somehow...though not sure how :(
> 
> I'll go double check - but likely won't be until tomorrow I'm afraid. I should probably just wait for the patch to be accepted and then work from there....
> 
> Mark

Hmm, I just tried on platform-x86/for-next.
commit e3271a5917d1501089b1a224d702aa053e2877f4 (tag: 
platform-drivers-x86-v6.3-4, platform-x86/fixes)

I get the same problem there.  I just applied Armin's single v3 patch 
and then tried your series.
