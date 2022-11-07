Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4D261F6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiKGPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiKGPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:00:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E9DA3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCJVAzUcyzvx+PslODXwQM7xxBKjntGL4cF9DAzphmrPFk6HWhr6dr3AhKQUg/WIf5alBJijV49p6rDD3xcsqqA/Tdw2jh864XfiMLUAR6LYjIRj9ZOB6dxmWOFMWzCmXaqTtxg2wwu5Bnjni51oeoFmhncI4+2GbRMjuhpzL8udxMjcki7l5+5HrKdwnpMdmy24EtL6z3ONKK1uGL4Ea6lToJgFFmltJlKHAV3lC1tLrD/Ud/zullagYBjbsOkXWEfVJp449IZMx/tfal8RTCarTld7ka1qXcGm10X0tXqvmBteMpxlaZUHabmmQKvDSVcdMpaApT7jWpCNs7aAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WbV/QFv1A/Z3voWgv+cceWbK3Ohk/6zKGFi3LXookM=;
 b=aj12mEZy2z8y4BOSLzR/GeQGOikOllX2NwWdBO5x4Ofd1U4PMCi8MAK8NV/e6eHNtq+hjhEgdztZmqkZ/XScBU5olDxSSCBq9mlLZmci1hbC6KVHxLQbEfsTIb6Yng0wqynP2VwPsG9iw+ml9eFFiG47CbM4nCjVFJnJZ3HfZEBYj3dCMLMMW3DAAxIvpBCejPdooNdKdOinJilQ1hwzAjbJHJmnzPjTFTu/Nd3s61vjArSSsZDbuBqTRWnbIMkOi5H4AdX08OCfKdqISd9c+TA/HaUV2Y+zhvq196zZh4D1Xf32VJk5NT8/FiY01b7BJsEcHAdaOreD0vvHUtGelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WbV/QFv1A/Z3voWgv+cceWbK3Ohk/6zKGFi3LXookM=;
 b=yWCF1xPbtywbaetKCgagQEv5/tbGtic6fYqdMaAxlqmF9L5vMylVa/u6WfZFUdQmwnoCN/PScJM5aSKOZPrCN7QITVU18lsMa3uWoNnp6MftA3nLWGoHy47PObf4iyUUy/DPpPdQDvCGiNiBVBHk7krCyhajVpURNxZIu9NSV+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 14:58:20 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::43f5:9df3:a0ef:3da3]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::43f5:9df3:a0ef:3da3%4]) with mapi id 15.20.5791.022; Mon, 7 Nov 2022
 14:58:20 +0000
Message-ID: <02a0dfa6-fb6a-25cf-4111-fb609b9b6b68@amd.com>
Date:   Mon, 7 Nov 2022 20:32:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        Vijendar.Mukunda@amd.com, vsujithkumar.reddy@amd.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
 <Y2EttkwUvMReQcqg@sirena.org.uk>
 <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
 <Y2JVWmJsprt0xnKH@sirena.org.uk>
 <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
 <dff6e7af-6a07-587e-79d0-706fe7ec6504@linux.intel.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <dff6e7af-6a07-587e-79d0-706fe7ec6504@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 06434253-875a-4f9f-c921-08dac0d0825d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZrkk0RMkthf7l2vaNDEMHX9M0k3e/T9blwoG3l55+G/mazXKdUhwi143MuSh/4JdmFLyeGq/UHQV0y0Ty+TbjH9Gf1IH7/qCMVkm6Nk5bYkeBMOZL5BuntFqBimyNZy8u7wxb4l8i5x+hLrpBPGIi/P7jhKGoG9+vgQ9Y58+odx4YUwf1tl/4kCUSJM9Ynr7zyw59dqimj1/v36q0sS9RyFIxiaxvQ1UggjlADNQ0Y5lvGHQeQ0Y1vyqaUSZK2ZpzahmiR0/1obwvx43Wma2UUGwwJgZG3ds3KdgXeRWPPhKak4uyZD760hoIkjMKbWDC/Dq4fHSo91omn0hj0vusW4GY8XJqtYfDFRf0VmzxiGgcuPpjfU7Uv88rEGNfguYEMkHqqJgUQDZhz1yzYv1mF5bQdZgmnR7xOYfLPupMSLKzbI13NqXKtxsgrzC8xXPp/OVEUh4Kl5V0/l6FRdMYcV2iItUVxu6J8oIhSByta7XWPhT8Hdcyn924l4ViAbZsDy25IZnHu4lh1MoWo+WHIsAHaBFGcuWgalw5jot3qUieJb9MTkcPXzZ4DwCWAx+1lU5fYOTX2rtS5yIituCBaK95sMPkFKlI9XCW+JWUrqWMqZ0+YUrMDAG9n7pm9bs2h6KdVJ4MqJTDp++2Ca4stVTJXyQyKeMzhLyjemeAo7FL79bAud8LlBGZL2XQ4L8vYpB1EbASrcLQZV1oEq2P6r6kCaGPMT+yiKJtmxSPd3HMiaSjDo/ZmULkw1YNGaw52aSWRtFUilL2WNDct3eLxMRjYmCW4E4kTP9zt9pf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(31686004)(36756003)(478600001)(26005)(6486002)(8936002)(38100700002)(31696002)(86362001)(53546011)(41300700001)(6512007)(186003)(6666004)(2616005)(66476007)(316002)(66946007)(2906002)(6506007)(66556008)(5660300002)(8676002)(83380400001)(54906003)(110136005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVJDck9rZ2tFbXIyZE4zbDhrYWJ5bDE2QkFHUitONWcrNks5bWFRNERJRkE1?=
 =?utf-8?B?MGJSSXJzMFErb2N0a3lOazgwMjhXdHpDVERzdDhXT0x6eEw5RXpuSE4venlO?=
 =?utf-8?B?bzAxNnRiVGd1OUxZWnBzeURSb1FTbUpnSW5HeEFadGpqOUg3c25PWndkU2VC?=
 =?utf-8?B?OGxhSWRZTU4xN1IxcTFUc3hmV2J2WXpTZ1pvSi9pWDBNaEt6THlsY0NOOHJV?=
 =?utf-8?B?VXBHK05KbnRsMWpDN0FqL3c0Y0JvcUhmK3loN2lPLzQ1Q1VvN1gxVDlYZlNw?=
 =?utf-8?B?U29NaWpQUUNIWGk3cTNSL0ZuWmVqbS9samRyYUJqRllZWVlUVW9GY1A2dWNC?=
 =?utf-8?B?aU1tUHZTblczcDhMYWY1NjJBZjhMRHZRQXdFMDYvWVFlSlorVUxJT3MrZkgw?=
 =?utf-8?B?VE44aXdPN3RIT1A0UVVqMEtkVjE0Ymd6RlZGSys5dlBDai9GUlBLSVluanRT?=
 =?utf-8?B?K1A2RTc3dFJZbFFkOTNTL3JWZWxsaDlXakQrNXpFOWlRcGFQMVp0R0cxOU1J?=
 =?utf-8?B?eDdqanhVZXVFM1J1ZTJqWTQrWmNCQ0NOaGgwUnNSdW1ieGZpOS91b0UxdTZn?=
 =?utf-8?B?U0UxT3NhUnhIZVp2YWpVRWllaUJOQTY5eFB2ZWFvSTZueXM0TjhhYVFVTktW?=
 =?utf-8?B?MTMrc3l3eXgwY1lKOEhlaEJ3OEdRZDhTaHYvUFQxUWxDNE9UU1MvdmZpbWgz?=
 =?utf-8?B?bUY0SGpUZld1T1pWVThuWUpmQXBaV1pPWlNkMS9vbElVNEI5alcrdFVndkhZ?=
 =?utf-8?B?c284OVY3UUl2Z1lKWnh1Mi9wN0FtWHJ2aXJNVHJOak5ldi9HMU83ZWFxOUNu?=
 =?utf-8?B?OUJZSHZsaW5NcEJvL3ptVmNBTFF0VE9jUGZQRmx1V0h0RDlTL0JzREdGWERy?=
 =?utf-8?B?KzNDanJoSXcrWTRpa1BDNyt1SVR1S1NwS2gxK1ZXY1habHFIUUwrSTFZeDVw?=
 =?utf-8?B?cDB3cW9aczltUkdLWTQ1TWVMcXJuRzVpV2JhQzNoc2Vza2FSNkVUUXo5OCtD?=
 =?utf-8?B?ajQxTzBZNERBR3NjQUdLd1RuNnVWbnYwUWJLdWQ0aG4zOTNwd2E5RVhKRVFZ?=
 =?utf-8?B?VU5FUjlXRVYxSVczeVVHVS9QTElhY2ViRU84UWZnS3BhT2dPV1gra0lZM2Zx?=
 =?utf-8?B?ZzIzQVhZOGwrLzJWMVpzQjc5bnJUSVBna3haMHNTK2xJdkt6alA0M295NWpV?=
 =?utf-8?B?Y1A1bjVDblQ1TzQvRFU1TzBmb1pVeEEyWEwzbFdhTkw0SndPVUp2cExrSmVo?=
 =?utf-8?B?NEEwZTNxNTRKR0xJS3E4S21adG42cEVVMFZWdXpPSHFDbkZLcVNhaTVRY1py?=
 =?utf-8?B?V1RFTmJtclArb0M2Y1NyMG1CZWhhU0dGRTdTbVNSWStRVDQxL1RYMGFsQVBU?=
 =?utf-8?B?YUZWbWFmWWs5dGpZTXhwWGJSVjBVZVFMaUY2UGErWEhqZmtHWHpoNGJZT0Iv?=
 =?utf-8?B?amZvK25rblNndG92UWtrbjh4UDhmbmNUdHJXK1ZUK0syMWI4N2N0ZTA2ZzdJ?=
 =?utf-8?B?bmJiMWliT25GNHc5MjdodE5jZVYyL2dNOERMQjJ5M2ZkMFhUazU3MURFUktF?=
 =?utf-8?B?L2gzMzZ4WmxQZEFkN0d0VVJ0Q0ZDQ2JtREJhODhIdXNDNC95WENvV1pCRXYx?=
 =?utf-8?B?TWh0UFUrajY1MWY5VVlRQ3dMV1N1OC9ZUGNuTGh4dnliZnlObk1iQ0dabXlz?=
 =?utf-8?B?V0FpMFJCdVhZMGJtN2o4T0RjVHlpZjIxb29VbzVEU2hWdVZuNERvYnlablZH?=
 =?utf-8?B?NGVuRERDNm9iMkpib2VTeENDeG1RZkFjQlVtRnVKSTYzV2xQQWxGcFY2Q0dJ?=
 =?utf-8?B?OTZUUm9Eb3hwc0ZoS1JWY0VmVXNwT2w1ellSWFYvcnlBaHVHN0UzMkd1Q0tj?=
 =?utf-8?B?bmY0QTN4NlkzZmpENDc2UWZLVVVjVGxiamtwZ2xVVnhwQUQ4clYzaGJLWjBI?=
 =?utf-8?B?SlFhQ1JZMGc3UmpPMlRFMkh2MTQwc29TdmJFQ0lLQThmZGtEY295MlhtSjdI?=
 =?utf-8?B?VjRIRjMwbHF5NVpvNk1sWkxSSnBIeC9vWEVqeGpuK2lNU0krL3RxbUJMd3VS?=
 =?utf-8?B?SnBna2xNMVR3Y1MzRGkrUnZVTzAyblVKVmxxNW1ENVIzSUpXYzE5SDRFUWJm?=
 =?utf-8?Q?M8YzPWPZV2z/JPPIR+Ry3kXDm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06434253-875a-4f9f-c921-08dac0d0825d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:58:20.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecHOeg3zJ3z4lmS7E1v1i4i+7eOCHZdtcUIuXbXRHb3ItMiQchFKp0yFqndWDLe+Eotr39vvUHXxrBFyfSqpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/22 19:44, Pierre-Louis Bossart wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On 11/7/22 04:34, Venkata Prasad Potturu wrote:
>> On 11/2/22 17:02, Mark Brown wrote:
>>>> On 11/1/22 20:01, Mark Brown wrote:
>>>>> On Tue, Nov 01, 2022 at 03:15:08PM +0530, Venkata Prasad Potturu wrote:
>>>>> Right, that's what the code does but why is this something that should
>>>>> be controlled in this fashion?
>>>> This machine driver is common for TDM mode and I2S mode, user can
>>>> select TDM
>>>> mode or I2S mode.
>>> Why would the user choose one value or the other, and why would this
>>> choice be something that only changes at module load time?  If this is
>>> user controllable I'd really expect it to be runtime controllable.
>>> You're not explaining why this is a module parameter.
>> Different vendors/OEM's use the same hardware as one need I2S mode and
>> other need TDM mode, using common driver  to support  I2S and TDM mode
>> with this parameter.
>>
>>
>> static int tdm_mode = 0;
>> module_param_named(tdm_mode, tdm_mode, int, 0444);
>>
>> And this can be runtime controllable by setting permissions as 0644, we
>> will change and send next version patch.
> kernel parameters are difficult to manage for distributions using a
> single-build. Either all platforms use the kernel parameter or none of
> them do. That would not allow a per-platform choice of parameters.
> Using DMI quirks or ACPI identifiers would be a lot less problematic, no?

All platforms use the kernel parameter to select the I2S/TDM mode.
Runtime parameters are not required here, by default it is in I2S mode and
when the platform needs to enable TDM mode then pass tdm_mode module 
parameter as 1.

