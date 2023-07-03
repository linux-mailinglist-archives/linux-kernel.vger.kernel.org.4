Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2FB745FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjGCPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGCPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:24:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038AE58
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aazQ7eabQiUJNzAxkmSnczO52gF7lTTOlF6wUzKRPVM2rzakvyx/9f/CLxUvPRWr0B6I7DTsG7NEWAiGor5HqNyHvmxVJ0FONlAJsidwBmyiWAos4WYXITw7fsGVjOccEJz1+1+TuS9A29d4eVxuKRwSjkaT5VUS/fUHwXSSMek+hR5FDhojTYUSEai7/GMwyTMMTnswTsSVmXiTt9H/CEB2BkHAdVEtUu+W+bKcomvtv5wE+8XkKpLlWSV/huWDYcmiTKcj02j8DcAyBY8D82ZnbTIC614WAFaHaaXSlHkIm/p6u+iH3OINX15Q5PNKSgF4fKkFJQ60qpNY8apmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GErPHNruTe9Pw3g+MPN9qRz28x523i8aoHYweVLUqHk=;
 b=eBbarf3eHQxF3fUnT4BCsSFnnIW3knfRqI9LIijbt4Q08ekmt1okomZj4+H5N6rShF1GQkJAjqpctvjoSOL9mHAsinaUjZl8R/ODLJYNk7YnkrWjDcN15B9CcjycMfhv0x80hEHRkE+W8pgcF6trPdfx42iQxLUPktqkB51oiQoSbO9Q2m2IGUe0QnSXQ8WRCpy4sSG2XVGmEWdJa7KS3MV7b+ASx9FBHrFsmgUOsH8Wm+rACQTEwILJdWGqz0rTFIa9BAbpR0OXupWIHHZtjL4xcTJD9HyO2wxVx5fm/5NZ+5oQ+FDBgbEy3HglfUAWyXIuH+beCcVmBbTFvNIctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GErPHNruTe9Pw3g+MPN9qRz28x523i8aoHYweVLUqHk=;
 b=1JE6OXnt+1yeg9ecYHH5b1rPdm7+6q9oschhbEpxI/UxUzYH5orguJSfu183JWHLNPDo/P0bbsy1ps01oA1Gm0z40CPrG3wM6SeokA4j36MQtxQA93SwxCemwHDzZSHbBOYmanPEeEUJlVvaS8gkHWnO6A5y/lr1UA7AzNebe+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 15:24:01 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:24:01 +0000
Message-ID: <cafff012-54ac-2d15-1e76-c5313c01f834@amd.com>
Date:   Mon, 3 Jul 2023 20:58:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: (subset) [PATCH 1/2] ASoC: SOF: amd: add revision check for
 sending sha dma completion command
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Arungopal.kondaveeti@amd.com,
        vsujithkumar.reddy@amd.com, venkataprasad.potturu@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
 <168814485881.50974.4096249135530047142.b4-ty@kernel.org>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <168814485881.50974.4096249135530047142.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 688b0c0a-a8b7-476b-820a-08db7bd98793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elvJ3xKOhz2Z77BaMWMXAHjne9k98zeqtx9hKAb5LLYVpEEY7l0f4qLZzhHj0E4AaNS1fadQyBbOOsNGikaS6E9j/JU1j8GT5R5xkydV5yXFqLz6PXJ4x1wN90d2VJ3zJhGy5gtrttcBwDXSw6/prRcbGjGKWMMkSaDqBGogN278zNWMhPdFRbvMm2mokIJuOE3sLIivPt6jLwsL043i4khXL7QF9jjgsl3+R2SCmHMW0znnc0deIpJqCyTqVzKOoFN0GGMuEihytQ3ejQartWPAdqkeD204nzeLRJMIGon5e6lLKkg7If3yyKflm8TwklNKo+zJQ+Mv62X7ZQcGTw1FFJ+ltOMTjXJKARJQO8JmAa4Xe1Rv1TbpaUc3ZlNgYhU1Qf1Y/fRzLUFTdQqw4NZsa5elQsvYCCXYkS/NA5/OLtVDifaWhQEuBIv+IppgfemxYQvjECQf7/dYWAAFt2LYG2uKznmqtfkqN8IYfJ50W9lEOclytEjxoxXd5pRy7xOpkhcBfKQTlQAWrdBWTie/LD8KkJk30dEPAQ64v2b1vIEh41SCyJvHERLY01tBobl0ximLfUF6ZjtvQ/2H8dt2L412L69+IFoW1zACElKU+66TwBlKMstfuOp26zlIf65p4bjK/MI1IhnE7l7ebA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(6506007)(53546011)(6512007)(316002)(6636002)(66556008)(66476007)(4326008)(38100700002)(66946007)(2616005)(83380400001)(186003)(26005)(478600001)(8676002)(110136005)(54906003)(8936002)(31686004)(2906002)(6486002)(31696002)(7416002)(5660300002)(966005)(86362001)(41300700001)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG5ON1h0ZDg1bkJ2MzVNOWFJUEdJNVJiUFF6N2diUFhVYmcrcnVEdkV0Y2hV?=
 =?utf-8?B?QWxCUTlReFJ2RmIzcVNmbjQ5K0VpSjlXRGc3Z3pQTVdNczR0MFZ2L3lxenJu?=
 =?utf-8?B?c1hyUVlubUw5V0RXSlJqQ3l5eVZhc1dXMmduVTlZNFdhN3FJTDVXTE5mYnhJ?=
 =?utf-8?B?eWlpcE1BTkgxajVkYXFyOEtaTTBFQXpET1JpRG8zZ2R3Vk1QRE02cnIvUzdn?=
 =?utf-8?B?aGJGTEIzVFlzbXg5ckFHbVZjMXA4L3U2ZFZ6c2FVY0ljN0tPTi9RRk1uS3FR?=
 =?utf-8?B?ZENhQ2cxUE5lalovem0yUVZLcHRNVmZUWi9EVUE1WkUzWCtId205SEhlS3kr?=
 =?utf-8?B?R3FWYlFzWmlnZm5UZmM0RlRvOWVMNTFSRDZXZ291SUZqQW9WK1YxditNb1hN?=
 =?utf-8?B?VXRLbFBNQ1M4alJJTHVHVUVvQzZITXJ5azNXRFduQ2plYXovRm5SclcxVWdw?=
 =?utf-8?B?cXF4K0w3TmtPNndESXQxNytMWlMyQXRSZHo5WlRhcE9rNENrZnZTcjhnS2Rr?=
 =?utf-8?B?M3ZrN2REVG1nQjZkMHc4SDRiek5EQTZzY0xib1I3YWNwa0JQeFoxamwyM0Nj?=
 =?utf-8?B?Z1JYUG1ob0g0c29mQXJXMVBmdVh5WmNVbHA3R0p1VzRLMEJ1VFlYVTArWkpz?=
 =?utf-8?B?c09aRXVrMlVUUlRKcGRPT2lseVdybm1YTE1oQTlwaWx5Z2pOeXc3aGkyWlJq?=
 =?utf-8?B?MWV0YXA5V0poa0E3aTk0Mjl2cW5QSzh0TVRBQ1N1bG9TRzZ3Y2ZqazQ1eDFw?=
 =?utf-8?B?em8yZWFVWE9NeFBRNEZra0lrNXVSS0ZBZmVRSlhZMnpIRHpzeFRqTEN0bHBt?=
 =?utf-8?B?R1RlWTgyTWhUWmdpaDNnY01NdnVjWXYwYnV2V3NJSi9TQk4wNUZ1WTk0a3pk?=
 =?utf-8?B?RnNQRzEyT21VR2lMZ0cxWjVsOTRHK2xYK2RBQ3BkdjhUc04wSWZNQU5oTWJK?=
 =?utf-8?B?NXlkMzl0Nm4wckpTWXliRXJxTjBJYU9vSFJrM290UGVNVGp1c28zbENrVis3?=
 =?utf-8?B?UEpYaHBMRUROOEZqZlZHenlsTU9TWVJMNlR3RFZidGgvR0xXN1djaXlDdEE5?=
 =?utf-8?B?OUFwQUZ1UkEwZXV0UmRSYXhKV3V6NnlMQklvTkQzY29IMytQTHBaRmNrcDBm?=
 =?utf-8?B?R3lOS0wwM1AvRVAzdjJUNFc4ckZ6ZHNZUVRWd0NnNXFBcFgxV3hhQ21kSGZJ?=
 =?utf-8?B?MjBFSXpDajkyN1JQUUdiK1ZNRkJRdjZtQXd1ekRiZ0JDWEFSK2NsVGxFL1dY?=
 =?utf-8?B?ZkZjeXphZitLOWJoVUs4WElIRStYblN4SG1IOGdKTmpndllFeGpsQ1VDOXJX?=
 =?utf-8?B?dSs1Q0dtcnRMbHROeUJVbE1EcityR0p1b3FmQkpDa2s0c01BalJVdDFBVGNn?=
 =?utf-8?B?M0xFUUxiS3BJYnZ0Tm0rSlMrNzV6cVlNVE1WVythSVVoMmdLS3ErRzdoK29a?=
 =?utf-8?B?aVUzOFloMk9UQ29rNHUwZlF4VGhDZmJydnRueW1ncTZVTGZEMzJUQnVmWUR6?=
 =?utf-8?B?ZkQ2dnV1VjNwWldVWUIrb3kvUEtUbElIaVM1S0g3Y2VNZ2FrcUUxaVZ1WlRW?=
 =?utf-8?B?d1NySXozd3VURmFzWGk5bTBaN3NkL2Iya3F0MDloTVNDcThpdUcwMEVIYU0w?=
 =?utf-8?B?ZWhlekJtc1Q5U1lsMWFIZXFTS3hyWDhLemZBT25Fbkx0U2hTL3pzaDh3N1dw?=
 =?utf-8?B?NmpFZHlIc3gwSGl0Q2c1RElzZkVuTXF5eFhvRythTnY2bDlqOHpQSXhjYTNY?=
 =?utf-8?B?b2JRa2VMcWVPQlZvNlNzVjBJMXBmcXFuc1gyRGIwSHdQeU4vaEQzc2dBVDBq?=
 =?utf-8?B?VE9tQTBtVktJL3hwdEF3RGlaVHR5bUpsVTV4ZG1CL0JxeGMyc2VtMFltc3ZQ?=
 =?utf-8?B?czNYcDIrVU50TzhLWDN4L2tOK1NSdWd3N1dDcmdNbC9iZnk2cm0vL1pWNnhi?=
 =?utf-8?B?YW0ycGI5RTczYk80ekdaVXRKcWg0R2E0N3ZBdFljYS9nOVBGVy9OTTlwVFBw?=
 =?utf-8?B?QU9FdnZQMXVYa2gxNkhRUk00NmhvMi8wazNyYzIwMFJqcENRNWYrbzVpeEVC?=
 =?utf-8?B?OFgzSFdsR0p3REF5eGlCU0t6TkZ2S3dFK0xKcnJFYmtPRWVZZWtWemEycnBi?=
 =?utf-8?Q?v6N2SBJELhbYedhSQ1QwqBxXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688b0c0a-a8b7-476b-820a-08db7bd98793
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 15:24:01.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzFKmzUGVHtT9Dy0gI3ow40x3Jb6PiFE/9L4NrgaNLbdfOkT4WIfBK1yxPXczVfMUA+TBQvx1rkjlBGRkBkc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/23 22:37, Mark Brown wrote:
> On Fri, 30 Jun 2023 12:35:42 +0530, Mastan Katragadda wrote:
>> ACP driver should send SHA DMA completion command to PSP module for RN
>> platform only.
>> Add a revision check for RN platform.
>>
>>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>
> Thanks!
>
> [1/2] ASoC: SOF: amd: add revision check for sending sha dma completion command
>       commit: b1db244c716fe300e36428aeb0874913d2e0a91d
It looks like second patch didn't get merged in this series.
Do we need to resend the second patch?

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>

