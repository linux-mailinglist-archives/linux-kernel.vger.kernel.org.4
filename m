Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B6734BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFSGjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFSGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:39:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC0102;
        Sun, 18 Jun 2023 23:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CysCMtDN0c9gh3gv24YClMGTavkP4piL7WCTkEM0C6fbizWKgTCzbS1dCvgpJ6Xni3G/BVQI6eial9R6Cox32tbKq2dXIVkwCfQqseohoy9p/eIGf67QaG6pE08Nc4ACv1eohDRxO7dcHZYI6aoEK5ORqyJFoWJo1lbEGVs888PAvtEfkTNOYh1OrkOEFoyi1umpCm7DlP+aEAngo4H2IGXxeNkfburoqPb5qZDa52xGG3QOyVbxvobXkGzrnljHkyhnypj0A9iOYP+CJb+D1QZKXklJ5ylDVduJ0e63ld9Xtg8NoXiX5iMZl/kdQR+6ClbImvt/js9aBeE3SyCPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXsTn0Ccky6QxK4UrKzmy4o2RKeVKpBQIFZ6MHjHqvw=;
 b=IPLMvNmmrDCzuo6fNDOnCk87EvHnZzCJ+0oLg4czMagwKCaCkwkx19snaJLcRoDKYnXyzqj50wQSAlckLB3f/UtGvxNMD0UnqySIa/L9C/Vd0C4jD1EF3EfyHmfZ4bFx5eU218i7n+lupk2jNmb032cg9PwkUeEeJc0CIGgs93+DJhKWa4AJhMnxoySJx+XObu+G5HFj+57JGuqVRIyzZDj8w+ZnkahcOjFlh0TyFzL3WH2CL2h2apRqDbd+pWB/Eo/XFimHXtULrlGqtjpg6lQiZ8A8mp3s7Xrig8MkJ0nNFdsu79sEJVBOjRazjwn9FV5zmYSpEJ2BQgRQe7Dqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXsTn0Ccky6QxK4UrKzmy4o2RKeVKpBQIFZ6MHjHqvw=;
 b=qJ6Lf8lmpQwaoadcWObG7kvkik1NBQRbDx4CPbnsjMtlGu438z8+rOakacjnftAa2kuJeOk1/chE4uQJuMJQxTrMdhVuMTe71rna4wWCufkZbnlmDpaVyEyXRqRSBdTtn4GbXo1P8OyWcj5BzIZaCWT/jq4okIL0qDTrBvOVQNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 06:39:04 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 06:39:04 +0000
Message-ID: <4698d52e-e026-d3c8-4216-be6f0d839fcd@amd.com>
Date:   Mon, 19 Jun 2023 08:37:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fcan?=
 =?UTF-8?B?OiBBZGQgRUNDIHByb3BlcnR5IOKAmHhsbngsaGFzLWVjY+KAmQ==?=
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "gcnu.goud@gmail.com" <gcnu.goud@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
 <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
 <PH8PR12MB667577C4800ED8E82C36D57DE15AA@PH8PR12MB6675.namprd12.prod.outlook.com>
 <d12e3d8b-20e8-48bb-84d0-3fe7d3502c83@kernel.org>
 <PH8PR12MB6675D75114C7EE280235BE8CE158A@PH8PR12MB6675.namprd12.prod.outlook.com>
 <8555c686-c663-767e-ce1c-a3b76fdafe05@kernel.org>
 <ef7e8e53-4e7b-8384-6518-68657474db24@amd.com>
 <4b66f578-b6c5-5d3e-98e2-d034fabb366c@kernel.org>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <4b66f578-b6c5-5d3e-98e2-d034fabb366c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: cddecf31-62b2-49e3-8405-08db708fdf93
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4QSIrxwwZ4YwhuyL25pAbaqUtFwqr03c8s7t7SVYPUYbTsWvWEjcRxrefddQ7TMwVMX7wDco/CIOXtS4us9OaTM1Dm08s/Hsya7MnLFjmt/J+FBOuPXojJomoA9vSmTgf/NL1WiLKYSKCgG/lnrQV0UbSGQcAMZHX6mQu8YKW1A8yQoBPVE9iAwYI2LuCdRWIJKqIF+d7o2ejGoZ7DA85pDqylEzTAfKFYSrGhc44o8vnPR7Eq5txMvokGBZer+kOxC7qRe/+JAVlF6LguFIU9YwH9JhpF8v18JP05ZCweyVLaDsn/YXfNe//boJsesgcK4blB91VzXzZGG54kTQpi+sFQFTSjmBR54/MwfA5wsqYrm51UEPBwkYxn/2KXa6t2Ovy8rpJERdhrbaPdH5CLRP8JxD+sdi0MvhzBgFQZVNsAsAsMWOq5HzLPhGhk6D9AlX5nbipBIAm+GPj75Y9X194j2w5G48JIADR/ZJxZozxCmRlYZJ8QTJgivYegjcn3NaDhNVjqkEWfzFSXvgtm2AeBdfVviirwHvOZ9H6QsVgigU3AoGASfsyNNKx1iPJcFnkZbiFpklhKyG5c4W2cAJbvuAzLZBhCO5MVeg8OCZV7JGxSPd5Dd5n0zEyS/yU+vIPWanBu1W/OIQV4iDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(41300700001)(5660300002)(7416002)(44832011)(8936002)(2906002)(36756003)(86362001)(31696002)(53546011)(26005)(6506007)(6512007)(54906003)(110136005)(186003)(478600001)(6486002)(6666004)(66946007)(66556008)(66476007)(4326008)(316002)(38100700002)(31686004)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFCR0ZYd1ZBZXQ4NXU1Zlh0M3UvbEpRcW5wRkEvc1FIUWRoNGsxNTNBc09U?=
 =?utf-8?B?ODFUdUFEZGpKdnE3VVFoVTlMVEprWnFkdWk5aEJCVzI5ZVdnMU5oMVFhdG1J?=
 =?utf-8?B?bW9Xak9SKzVjM05CT2dCZEdWZ001SkI2ZENkSjR5b04zODExRGI5bU5OdlB5?=
 =?utf-8?B?TU1FOGY1Q3ZDbTBvYk02bTE2N1RBakQ2RU94WEpydHh4ZjdxL2ViV2VYUDVL?=
 =?utf-8?B?aXBsZnBDNXlZWHU2RHdlN2ZkSTdOQ0ZRVmRsck5UZi9LK2F2SnhvZkZEblBQ?=
 =?utf-8?B?cGUyYlM5OTN3S0wrTUV5UFVBSlYxWlk2QnJnaHA3UEZtT3BPSHp6Z0ZIcUhS?=
 =?utf-8?B?UDViVHJmaG0rT1Y3c1REaUhHUHBpOUJNc0dXV3JxZEdrSHVnaEsyczk2WUlI?=
 =?utf-8?B?UnNNNFg2MlMyVFFJK2F0eFdCYUZOMGcrbnRHRGw1SjEwdnp6MlFoYzl6MTJ5?=
 =?utf-8?B?cXowQnZMeDRzUUNIY1E5RlZrd3c1MTlDcHhHV0VkVFU3alhUK3R6aE1WMjNP?=
 =?utf-8?B?WnJEdjNjelNpU2kxbVIxZzhUZ20xTmU3cy94ejNwTUVTcTFVT3puL2U3Rm9U?=
 =?utf-8?B?UVoyeGdhdVk0MXlpK0c2VDlvRWloTDNrYzRFQWg0UDRGSXRpbnNUR2lkZHM4?=
 =?utf-8?B?a3ZJQzdEZzc2eEI0amMrSG5RZ3lRV1Q3QURpekN4NldXZ25JaTEyWlJxZFlj?=
 =?utf-8?B?OFJaT0tlYU1BaHoyMVlNSFFaY1lDTkhpZmFoNFhnM1ozMjNLVDBuUFIrVmhh?=
 =?utf-8?B?a2RYSHpScXNFWG1GUEJaRUtnZGtQWkQydndPMmVKOTNuNjhGQnNMZHlDTmFp?=
 =?utf-8?B?YWZWMFM2bTZQbzRFQnREbUVuVndtUkVFRFppUTJIRG4xaWdmZWx3WHB0ZDNF?=
 =?utf-8?B?ZHF0Y3dTUkdzNmRQUXdJa09NMGwzbFdVVkRKZTYwamJjTlBIdEtzWnJNYWo0?=
 =?utf-8?B?N1hGa0VPMlRSR3FZY0QwSHVyclpmZ2doSWNrNGpXQnQvdnQrOXplcGllb1pC?=
 =?utf-8?B?bUFmSkwrQWphQ0F2emFGTGlsL3lJTEVMUDRuRjEvSDdPcUdJRlVsKzRzc0xF?=
 =?utf-8?B?YlRxWkhzRm8vVUJZYlhOb01yUS80TXBnSHFCMzFSd1FNaFJ6cE1aZDNhNXBO?=
 =?utf-8?B?TWdGWGNoYlVKTkJ3ZFkyMVIyQ05oWkh2TnNPRW9ZN28zOTBtb2lNOTh2MHkv?=
 =?utf-8?B?elRlNEp0ZFZkc2g4VEdxMi94TWwwY1J4Yk1QYjhHUmE5anozNVErekQxWHQ5?=
 =?utf-8?B?M25idzAyT01xeDdPbktMRCtOa0dRZG81OHhUbGpUalluaWg3TlFCanFibTl2?=
 =?utf-8?B?aUhGellLTWRTdzcySGdITEVZTlMrWWNGVjZVZHBXRGNXZWp4K2FZMlQxandT?=
 =?utf-8?B?UVFGR1FXdjdBcWtuWFl3RDRQTUJZdUtKTFRDUyttbm5VcDZaT3NZRUM5Z0Nj?=
 =?utf-8?B?eGl0cExzTG1ZWk5GNmtEeEZzcVZyWE1qd0djZkxNaHBqZUQvbXpkYzRsUGFq?=
 =?utf-8?B?Y2VGTC8vTTd1OVlPb0hCQy9iNGY1emtGaVBWS0tyMnFpQnJwTk5wWDZPV0N1?=
 =?utf-8?B?YVlzUnZSRThWclV4cnFDTzdTVHBHa0dWemJJbkM0NXN3NmFseHQ4Vi9kQklD?=
 =?utf-8?B?ZVJjY09ISlRWUDhsaEc1TVgwNENOaHVrUTBNY282WkFTSmhibG0wYWU4T01P?=
 =?utf-8?B?WW9RUGtQeU5RUiswTGZ3MGo1ZStHWGxTNExzcDA5ckZNUmhxZHRDQmVOaGd6?=
 =?utf-8?B?TXFtOTVoNHpySUtTZk9kWWdmQ29Va2xCaEhWK1NFcU1QUHdOT25ydmh3Tllh?=
 =?utf-8?B?Y0lNL1VZWlpiMFhIbUsrMGMwMmhFNWNlRmx5WVViRWpoajZRRmUxN2ZLblFI?=
 =?utf-8?B?VlZseHBvSWk2SmdpZFNRZWVLUm45eFNSRHFBSmxobFBxdnZhTlVKbkpuOGNw?=
 =?utf-8?B?bVNVdnFqTkdBSlB0L0hzREp6N3RyV0IvNE5Ha28rZm4rMzFUbnhqazVINFFM?=
 =?utf-8?B?blY2TnRlNkVQVVJxN2tCVVZITFl5MWpTNjdDUXR3NnNxZnp1a3ZWSWo1cUdj?=
 =?utf-8?B?cE05VVZuOE8zTHFNeVlob202MURGTjJXVHd5SFJ2emtiYUY3SUQvU3VRYUV1?=
 =?utf-8?Q?5Bu9G3buLkU/t/3q8hSlc2MIr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddecf31-62b2-49e3-8405-08db708fdf93
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 06:39:03.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmAumsOPwxVe5vafo5iHZQ+x2UspceFlu6KT88/lQFIcNAZ+XKs8n8KEuhRE1jnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/23 09:31, Krzysztof Kozlowski wrote:
> On 16/06/2023 12:44, Michal Simek wrote:
>>
>>
>> On 6/16/23 12:38, Krzysztof Kozlowski wrote:
>>> On 16/06/2023 12:13, Goud, Srinivas wrote:
>>>>>>>> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
>>>>>>>> node if ECC block enabled in the HW.
>>>>>>>>
>>>>>>>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>>>>>>>
>>>>>>> Is there a way to introspect the IP core to check if this feature is compiled in?
>>>>>> There is no way(IP registers) to indicate whether ECC feature is enabled or
>>>>> not.
>>>>>
>>>>> Isn't this then deductible from compatible? Your binding claims it is only for
>>>>> AXI CAN, so xlnx,axi-can-1.00.a, even though you did not restrict it in the
>>>>> binding.
>>>> Agree it is only for AXI CAN(xlnx,axi-can-1.00.a) but ECC feature is
>>>> configurable option to the user.
>>>> ECC is added as optional configuration(enable/disable) feature
>>>> to the existing AXI CAN.
>>>
>>> Why boards would like not to have ECC? I understand that someone told
>>> you "make it configurable in DTS", but that's not really a reason for
>>> us. Why this is suitable for DTS?
>>
>> Let me jump to this. This is core for programmable logic where HW designers of
>> this IP added couple of feature which can be enabled or disable based on
>> customer need. It means it is not SW option if ECC is enable but it is HW choice
>> if ECC is present in the HW or not.
>> Selection if ECC should be used is up to every customer to decide.
>> We are not able to get information why customers choosing ECC enabled/disabled
>> but I can imagine that with ECC disable less fpga resources are used.
> 
> Thanks for the explanation. Apologies for being picky, but you are in
> minority when adding such properties with true hardware meaning. Most of
> the submissions of such properties add them to control the bits in register.

No issue at all. We are talking to HW designers to change their mindset and help 
us with automatic detection of these features but truth is that every such a 
feature means fpga resources that's why they are trying to avoid it to save them 
and help customers to fit as much as possible to their fpgas. Because bigger 
fpga is more expensive and also consumes more power.

Thanks,
Michal
