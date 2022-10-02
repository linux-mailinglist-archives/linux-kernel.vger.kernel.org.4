Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9845F25F2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJBWWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJBWVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:21:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC729399D1;
        Sun,  2 Oct 2022 15:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lY3VUqr+ou5JYsTGHFbVLyg3hHv4qmMt0Pfrk6/5vm/Sy5A1Ll/H0MQTiAVdjhNbHidXWQvvrTCBKIq6i+sYfy43N7fphxKofR4haX7uU4PQ18KVbvyQtdv4qIRWXVr341qGDq1D9A6gaJw7gLzB5M6zISeNqkgDwCg5uCzAPwb5E0Ax/WEI4zm06wokaeXkFZlErPwFtScB2QT/rWAtDbXAEGipDPQz/1DU1X8IsTlQnITNBA2zdBuqT0HbNejq9herpwlgS6g03HUPM+r3FrhOI6dueKY5OmO0yCUZPATi/+kzP4W4NhFF3vQ/tp6xmF8EY+V4QQ1/lcK3vfcuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1AWSo2aMvNylLI0erdj8U55sOqliGhmmVaFeHM7lwI=;
 b=HDHM4gdtzrbNrDZIeoCCcJL7lh9Pd7NVzDg+w0denovFKuLxXVpcmX3Rql3Y9Op7Pc8+ZnNSTCnIrTnnqcZqNniUzLUl9RKwKV+vIoOHoEahOCoAz79ivDbV8LdCkM8Nln/5UinR/MuxmNPsY+7NaNeYZGqwMW1vfAY187EKuxp9KjLCQ505T21TUIwP+yzIoF0qccoz6w3W+LPm85WoTkTQgHbch7zvefnfczK3/kCPyawM99ggdmSd9G6H8fXs6oSL4i6VOHhe9oOW9yiRjYrMMVIWW6wjYNXnPwgtmgqXwOotLIMLko8vVoYoDbJVfQxvqKCUQbeWXwBjROQBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1AWSo2aMvNylLI0erdj8U55sOqliGhmmVaFeHM7lwI=;
 b=CQB/02H7kMqp9hO6iN6ccJw1JpOUL5UbWW2XMHR4lv7vNdD1oN0jvXJtK0dTNLlkqSOKf1UHbSGuxCMGUk5Ll8YBMmBFziNIFW2P4FnKwX3sI/pPHcbp1oHfGZrdrnjkpN1wKXhoF0r9ovXZSGWDgKLzDcFoLuCLMqcZbVNJGnYURWHyp7NoQ72Y1Jut1tZzhpj2pfM8VW50C3BeGAYdTuDxBiA9Gmm0MTSrmKK4bRRELEqaZ88QLMAGQ0YloOYIbvc66mEkjHOGmc6IURcZgrIjysC1OfhQAYjSEKaX9VtiZdYgjElZQ+Zr5BAZ78Ultf/1nQGtEuYZndMvS9bBHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Sun, 2 Oct
 2022 22:21:40 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::d69:1f41:4b62:4ff1]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::d69:1f41:4b62:4ff1%3]) with mapi id 15.20.5676.028; Sun, 2 Oct 2022
 22:21:40 +0000
Message-ID: <bdb69723-269d-3c1f-2501-7db0e6246890@suse.com>
Date:   Sun, 2 Oct 2022 15:21:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <11a582f0-723c-95e1-0e44-0a19e1a8a9a8@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|VE1PR04MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4268e265-67c8-4f06-8c90-08daa4c47a6a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/8Czh4DkKYc9Eyj1bj2jne5o7cTTcRFxv0DC5fAG7SrLjaaD4g854M6NhNzzU8oXUMzfl61BMTFZp0h0Wogym01K+pWlap0aGxkhAfUpiY5Jatpvxb7VXRNNzCeihfjQmIdgZWawwdZnAOn0dyWoVVEQRnZQi1+nsGQb5ffVWrgq4K2i5UC/NqyyMZaUcuziQPR02pLM9k9FnYlRTLTrBFfO+l8UlUSr3dOytQb/0GgLuVVVKETrHYYo6T/YG8l+YIIphMBw8lAoIVCbnzPyp3HcvN4SfUz2Z8alcjoMCv1cCH46STxybykHOr/uXHqBuVydCcJcr/Fy2b2j4z1csh8g2LCSarJfyrnqjrNepp4SgfYKmV/XpbhX+ZnyCmZ/6Ff3CgbhQwGutlE/AD6Vdi9MNeOxHwr3BLRt86a/RoKz63l2pnmp52F8M9eUY2CYFIh9WzQcBw5IwNSNVVo2suIVGA5q9EuGEo3VCKPhzEeds/YkvovVw64xc9Xklue0le12D15bTKhlG9lHX8jfzgGRMysIWbLM+eLIcTp5+fuojGdEwkiAScpJAPqoY7VgIBDdK1U8463ERQ/a8H0z/RzeSvw0eOlEIKc2URKmCUtj28uVihmBhG21soAbARIUIf5+LpV61jgpq/6S8lm6BWjbdc6kksi7Mfp3Aah9paTAyi/Jd6Z3T+5Jqs/MwLhdYeYAlGLLXGoMFQw4YRWieeiZViTKTlH8NjBeHc+zyA++IrN6sRO1mzirlkXm6FnwX66wnqzPfq1OZOheXhudAxqI36j71HlUhT5mfsL0Bs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(136003)(39850400004)(451199015)(66556008)(66946007)(66476007)(41300700001)(8676002)(4326008)(6666004)(38100700002)(186003)(2616005)(2906002)(83380400001)(6506007)(31696002)(53546011)(8936002)(36756003)(86362001)(6512007)(5660300002)(26005)(31686004)(54906003)(478600001)(110136005)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1YWDV0Zk8xaHg5VGZyZWI0UFV3KzNlQW1rRkRIdldGaDRVSW5Td0hBZFpu?=
 =?utf-8?B?eEI5dUwrb0laenNRNzZBOWtzWWtlTjhCMjhsOHI1YTcwVTQ2YmpNVGVwbWN6?=
 =?utf-8?B?MW9RTENaZzVmNkJuQXN0UW9Bb1kzczhOcjI4OFMzaStUMHNlK2haVU1FZERu?=
 =?utf-8?B?R1h4eGdFWWNuK0xzZW05YVEwQzFGU0JnWDlySC9uOGNPRTd4SWtVT0FLd2ZR?=
 =?utf-8?B?L0NDSGVKbkhXUWJaTGlhRlM5dnVCWkR2REJMTjJ3UkNxVEVUWHN2RGoyR0JT?=
 =?utf-8?B?YlJBK08rdmVjdXZiTGZBNVZnTWJURHJWMzlka3MrSG1PS0FEZXBCdVJpV09V?=
 =?utf-8?B?Zy9RZnFsaWI5WUlxbWZ5L1lSV1lIcFBwQjNwb3JGOEFIT1RQSzB0WEJCWThR?=
 =?utf-8?B?NjFtV05RV0QxMThlY285MUUyb3JPTFFvRXl3NDBmeHZob3RkdS9ub2U0dW1N?=
 =?utf-8?B?QTBNbFp6NEY0SnNIU0hFRWR3SU9PM0tucEdFY2Y3YVJPYXlWMFZOek1kWGg2?=
 =?utf-8?B?cmJFNVZRRk1RN2FxanhoUGxydEFCQklBOVozcEllKzJzcUhFNlRwSjVlVm0y?=
 =?utf-8?B?b1FpVi9QZjM5dkJMc25iaVJaTTdKc2UvL0dScnlUL1ZZYTM1bk90WFkvaFow?=
 =?utf-8?B?akE5L0tSa25oTHc5VWIvb0hZb2ZUNGtHckFzVEh3ODVyZUk4RGhOdW03NGNS?=
 =?utf-8?B?NEtxTnFIbUZldFBsSitFVVhmYVNXeTYrU005ZjJrUERMc20yS245Z0kvU1l0?=
 =?utf-8?B?c1JCSTY5WDdPVVJWWE13L0FiOU1VNkJGbmZkeG9kUDl0RjRLRjB3ZXhiMGhS?=
 =?utf-8?B?eEUxdjlTbWNBMGk3a01aelNpZzNTZkdIUXpNd0dtU3FIWEV6ejgvdHVVaU12?=
 =?utf-8?B?TkV6dldnQTRRN3FLWnllbVBYYmNybkZDNVlvNEw5S05YdGJSRWh5UTlsQXV0?=
 =?utf-8?B?ZDNzTWRhTnA2anlId3hTWTY5alZzYnFld0J4OGpTc1N2NmNLMXczUUpIMVVy?=
 =?utf-8?B?a1Vwb3FnK05qK3hoWCtaYllFb3R6UnhLVW80R1FSc0lONklIWjViYTJoa3Zn?=
 =?utf-8?B?WjhORDhIVElzZjZxdGlJTjVpTnU0c1VITnNIL1hWWGRmcm9pamFQWnFhbFV3?=
 =?utf-8?B?TXV1WnRvdzZSSDJrMFA2YWZQWURPdjE4WVYzR2E5UXBsNHMyVkRHNDQ3c1Fz?=
 =?utf-8?B?a24wb3IwMTRsK1ZGQk5VTVVmUEk3aVg2RGJiOHNtWmJheGlkTTV5TUVnSjJs?=
 =?utf-8?B?T3N4dlZpODJOWjlqeEJVckJUb3pRNGFBOUNBNENLVi91QzlUWHNVNFZ3VHhY?=
 =?utf-8?B?RFh5Ym1pUEZVTlBDTUhoc0NMWWlyQW9ubU1PeWtkYVlLUlZLWFZRZVZmbnlE?=
 =?utf-8?B?eVAwVmN4ZmlwUkFYMGQ5VThIbng3djE2R1E3MVJjWDF1VWF4QVUrRHF4SVpQ?=
 =?utf-8?B?akJxc29FdFdrUmo4V0JBZ2ZJNUxHWDBzaTJSeFRETUNNZkY0YkRaSGM5S2Fs?=
 =?utf-8?B?V1EwRUx3c2ptWS9oRXZvZTc3TmdtNjFOSWdKYkVCaGlGYnB6eVBzSkMrK25h?=
 =?utf-8?B?UzVsQW1OY0FNZGI3SnVUa2VOQnZnZnpKems2NHJCU09VUlR3MHhtYjdQMCtG?=
 =?utf-8?B?YkNlblJicFM0NzBMRmYxcE9lRGRwSFVPenJ4REQxZXR0ejRHNXpRUUd6TWh2?=
 =?utf-8?B?S3BlSGdNak02c1l3b1RBNTNyY1lNMHZteWM2NlBoT3RPZy9EcldEV3FwOXcx?=
 =?utf-8?B?cE9rY09idEkxd1FOdm4yQ2VHMWxMMk0wNU5NTERYYnJMV0lHcjdOQWtzK1Fp?=
 =?utf-8?B?RlNxT0lWelQ4QU9WOW16WSs3RUYrQjZJQ0Vab1VTS2tsYkY0a3F5VnNReXg1?=
 =?utf-8?B?Y0p6bkVXRXVKMjJaZTdML0tkS3NBUVZvbkVtZkRVbTY3QmN5YWJybUtvL1No?=
 =?utf-8?B?OFRiVmF2VWtxTVFrc0R0OTJqUm1zTXExR1ZEOWxzbkFxajY4TXg4Z2tmMFh6?=
 =?utf-8?B?SVZ2N2dXMWZRZ01LNkNya3lNU0crUnRTMHZodHpaaGtKNjJhZFhnUHJTejcw?=
 =?utf-8?B?TGQxdk1iNU9LWEQvcHF3c2RzRlVnVW1lWC9EdU5yMFJVd0taV3laMFRoRHUv?=
 =?utf-8?Q?uab08MwlPoe8WOe46ebvObyoF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4268e265-67c8-4f06-8c90-08daa4c47a6a
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 22:21:40.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOEui0IhI1/GDa8GvzGhyaHShQ95p38Izl2SIHudSynsxM7ogVXr66IUJlm/FriMSELvp2/8E3NgWms0qBjeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/22 14:16, Bart Van Assche wrote:
> On 9/28/22 11:13, Lee Duncan wrote:
>> From: Lee Duncan <lduncan@suse.com>
>>
>> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
>> (front end) do not like the recent commit:
>>
>> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full 
>> page")
>>
>> That commit changed getting SCSI VPD pages so that we now read
>> just enough of the page to get the actual page size, then read
>> the whole page in a second read. The problem is that the above
>> mentioned hardware returns zero for the page size, because of
>> a firmware error. In such cases, until the firmware is fixed,
>> this new black flag says to revert to the original method of
>> reading the VPD pages, i.e. try to read as a whole buffer's
>> worth on the first try.
>>
>> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full 
>> page")
> 
> Hi Lee,
> 
> If we introduce a blacklist flag to skip querying the VPD page size then 
> we will have to find all SCSI devices that do not handle querying the 
> VPD page size correctly. Has it been considered instead of introducing a 
> blacklist flag to not use the reported VPD page size if the device 
> reports that the VPD page size is zero? I am not aware of any VPD pages 
> for which zero is a valid size.
> 
> Thanks,
> 
> Bart.

Hi Bart:

The problem with the broken firmware in my case is that it reports a 
size of zero, but it actually has the data! So the "size" returned for 
this one VPD page is just wrong. And I haven't researched it yet, but I 
assume that this hardware returned the failing page in question as a 
page it supported. In other words, you can't count on this hardware to 
report correctly. [I will check and update this email thread if this is 
wrong.]

This broken firmware was never an issue before commit c92a6b5d6335, 
since we used to just try to read 255 bytes, expecting that we would get 
back 255 or less. This worked almost all the time -- except for buggy 
hardware!

I suspect there isn't many pieces of hardware that return zero length 
incorrectly, and that if such hardware shoes up then they'll be able to 
use this flag to work around it.

So, for my hardware use case, if I add my commit, the VPD page shows up 
in sysfs, and before my commit no VPD page showed up. [Also, reverting 
commit c92a6b5d6335 made the VPD page show up, as a side note.]

Lastly, as for pages that might validly return size zero, Hannes seems 
to think some of the older hardware (under the older standards) returned 
zero as a valid page size for some VPD pages. For this reason I decided 
to not use a simpler approach of just trying to read the VPD page with a 
size of 255 if the "read length" returned zero (as in this case), i.e. 
since Hannes thinks some hardware might legitimately do this.

-- 
Lee
