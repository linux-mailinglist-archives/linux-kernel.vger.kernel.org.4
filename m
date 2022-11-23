Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7500636299
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiKWPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiKWPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:01:08 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFB127DD5;
        Wed, 23 Nov 2022 07:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5iChf/0weTUly92Q0QSryvlDH9aBetv+UUGefNoIlveM57yf+SzFdgFxEk6HAGrIOnDoEJUbcZJisQzfQDBQIUaPcYBxuEByFJ+mlmC0TmGKeh7ox3afblhM9w83DgeigwB5TVjEa87iOH8MqLRljWCFK/1DBLlJAyXe0SxsoTjvl41ZIyz7LFp50m6Vqo2ppVRfA7xeNbGwg0dQV5Rj0lGX1C1MyhggKEZWrzBRxyNgmrODMIhkLJguxP5AYC86RlQLUYXBOzmpdJVcg4UOZiqCQxmaixXGZ+sSjlMeIEQCqYGexuANDwKqDjd9wXQih78NqLzgrZ9ClDANWuLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgyBDsGz/WDaO9WwNb4tZmVEDHixXkaGFFfqvtCOs1o=;
 b=JX7eOFRH9H4zytjZnrzjFbV9D3i8N4UVQBc012WCR+CPUTQyXm+/CugTezzislMQ6ZueMKD+jM4voc/ETcl0BUcB3SUf1shsF+TkJ1hsF3FwTX6DiwZhawucjaGDJ5HrcsODV/cbzSwUEPXEr6CBqZmGu0Drf6ypHYxHZWCGxI4HzJP/9imTlMVw0NSjTwMeluWLIX1Kxqx+lMdblixItM/1pHKP52oZcni2OWufiWMQ5FACZ1ap/0A4CRBNJSAb3ywEVJKmuq8ofctdoe2q/cPG87zGm4u+UyqCn0q6m7cx+/UAzQIjstQ/g05j2rrrMv1oozUZdl92zah6Q7O5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgyBDsGz/WDaO9WwNb4tZmVEDHixXkaGFFfqvtCOs1o=;
 b=4vBc3CaSjx/hQt50b6PWY6sucCRupv+YI0o3R4Ahge44A7LKJQ+4qs+dm/lh7YuCNFM2rCaTfkSvm/orGuHY2DBtHCA8noAPE9M13nhNtEvffF6A52mWJf9mRNJx/vK0AwY4lWqDSLcIklKmQwkHsnJS72TA0Fm/45upVdrBmIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.11; Wed, 23 Nov 2022 15:01:04 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 15:01:04 +0000
Message-ID: <3ca31647-3f19-a9ca-c6b9-d6eba2014f2f@amd.com>
Date:   Wed, 23 Nov 2022 09:01:02 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] docs/sp_SP: Add process coding-style translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu
References: <20221115184737.712625-1-carlos.bilbao@amd.com>
 <87bkp09fkc.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87bkp09fkc.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:805:de::31) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b46401c-29c2-40e7-0228-08dacd638ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBR+yFdI78f3zp/vJBiRFWCP9mN8cJc/Dnh+sYxIRS43bZnVMGsWehjQemJ1HmqUbcmbMGl+E1S/nAfgw5ZRC4TjQ908zV3AblFuzEO+tzzeZ8cS3921V9Ezyf6y+RcKObBMKfxUgd7/6w046DPtIffAX7AzG/Mt/rfjpOlq6TcWbu/uQ/94fHKlZIzqezkrOXany3ruz4E+lJc45auHScrYOJbtMpXI30wRX39fNru6jXJRshVu8s/0LS85GPZ8DbbAoFWRK8YCq/7g+KAj7xYuCJeYO7nrlKVV/fwU3eRlzTSgdfiY1oLSwzjJjrk9hxT0OpQsC6HDw2gdevP3ADIFGs82WIssYveRYghf/LOVaG9BKS7O/Xh4MvmcV5kWqg7EQ+smQ/iKE+AKK3JPL+YzS8yj1FmQGROj717agAWn5jozXCqg5BVrq59CAz1H45G7GjmggSXebGxxUZBylNTeFlzA0Q02sWqufIOviTzZbITsh8cBeYOpozZq5MO3oZn0dfMXV8HnBGmTio/lJpTFam3q+eJbOrzuO7oXYgeDJCXRxhDF41HDac/bSqs5In6ABUm6+9v6ToUadxngcn0FBOOx+sBpcFe7tSjjeIvOgcauDRSyaRjYQVnttcI6QXW5XlPwmQVkyTe85p7gJF11VzZDrCvoCXGZqTxByKJKJYzvatzsB5UGwz3zb5nWM+mM1GzspUMawEW+qSekFpoP58Z4nlRurv0cmt7MP6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(66556008)(8676002)(6512007)(316002)(66476007)(4326008)(66946007)(6916009)(53546011)(41300700001)(2616005)(6506007)(36756003)(2906002)(6486002)(44832011)(38100700002)(83380400001)(8936002)(478600001)(186003)(5660300002)(31686004)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2taVmtuTDBDSFkxWC9HdmxGWVd5ZXZaR0lpYi9yMTVObzhuY0VYc213RjFM?=
 =?utf-8?B?SkpyYkViWVZKRVp1dTZHYThmMkU0c29nZ1RVZDVhNmxQbmwyYWFpS3c3blRS?=
 =?utf-8?B?R2h0cHQ4Ryt0K2FtazR5L1c2ZjVES0JwMUZuVDRLNUlIWlJDOWk2cUZYRG5t?=
 =?utf-8?B?NU9wS0E4eThxL01MdzR1VHB6clJxa0grU0Z5TDAyVEo4Tm9VVUMxNDAxUnpI?=
 =?utf-8?B?TnhpR1gxTDhQTlJUKzN5dEt6US9rNUpXSFVEZERlMDhpNWNDTXVZVVU3NXE1?=
 =?utf-8?B?K1l6WGE3d1hoWTVVaFRBRXZmbHpvUUNzemFXeXpmRmFNQWtMdEo5QWpMSmIx?=
 =?utf-8?B?N0I2QTh2RnJWS3A5SnFGMFJmTFhEeUI2ajkyUUkrM09TWG1aWXBpbGwxRDkz?=
 =?utf-8?B?WXFsdUJDQ1VWNHo3ck5zN1B6S2plLzhHdm5kdXM1N1NWYVpBZzZuVW8vbzJC?=
 =?utf-8?B?V0lZTjNBUzRtbGFxZmY4R2t0dmVFeXdiUTJVcGdibTRxZHUxTTR3MVR1MTQ2?=
 =?utf-8?B?N0pWVWJTWmNjNGpjUmw2TnhuNS94SjFpSnl4b2U4WmkvYzBXZld3Q1hjUFBV?=
 =?utf-8?B?c3RlZjMrY2xRSGhxcldCQmJETDRETUh4ZGFabkNHUnk1bkc4aWNzUUNxeTBh?=
 =?utf-8?B?cFJEM2tvL1dkVENReVpRL0NrcFdIaFAyMHFGZXc0Y1BYVW45MHVrbHF6ZG1l?=
 =?utf-8?B?T0h4SUo3eWI4cThJSUtIdGNQbWdTNHJ5SkFYdFp4bzI5MXlEOFd5c2VnalZP?=
 =?utf-8?B?N0g3WmIvdVJZWDV3UkpQdUlsZlBBZStHNWIzb0tMTlZNQTA1VlRrZmI0dDlr?=
 =?utf-8?B?TlE5a0RxUVBGYXIva2NJWmlHZDIvYzg4L21OMi9RRWcyQnhWV045WGRvcCtz?=
 =?utf-8?B?WCs5MkowQXNKcHNjWFhRVXdDUDJjcXNqUmFDb25BWCtsTDM3akpCQUdmaTVP?=
 =?utf-8?B?Z2h2TDVFZWR1a0FKK3dBK3RFbkNvcXlVTTUxVzJhWVJDQlBSZUIxM0dsUFdS?=
 =?utf-8?B?dTNEUWZjSlZlK05VN1JvM3htVTF0bmhMbTlEdk1aWnhtOVRJMkZBaFhKVi9r?=
 =?utf-8?B?MThsRTQwMTROTEFHSTFzWWNXREg4V1J6elFhcFEvcE02bTVjNmk4K0VVMkM1?=
 =?utf-8?B?a3FhODhVMXdUUlRuWnVtWVhhY1ZXb3gySFpMejZTN0NEVXdDSmI4djhwOHVD?=
 =?utf-8?B?M29DcWpXMHRFOWV0SFlhK1FrbmZJQlVBUEhZaVFUaXdLcVUrM0VhdkhqaUNY?=
 =?utf-8?B?bTZYYzNETEpSZnlXOXBqK0JzUU5VSmlZZUlSY244T0kxTW1YaHRZVno4U2NV?=
 =?utf-8?B?YndRSFNUd2tGakw5QTVOYTAyZUNYR1ZkR2J0V2ZrMmxZUnd0eTk1MTA2Witi?=
 =?utf-8?B?aDhjT09qaTFYTTBNZDhFd3lyODR3V09RMG5RZFA0NWExTDcwNkN2UTVhZmVO?=
 =?utf-8?B?K3lKVS9VdFV0bEw3U1BYMksxNGdnSjVaOC9hVDY2U1BkTXpBeS9VUWlSa3hE?=
 =?utf-8?B?NkYybWF0dzZrVnlNS1ptdGZnOFR4cHMrNUtqV00za3ZlVWNpSWFoK1VtdlFY?=
 =?utf-8?B?bkkrWTVYN1dsdURDV2Z5RnlFaGcyL1EwZCtSSElBbUFXNzdsSnVCVGx6c2ZJ?=
 =?utf-8?B?M2dIL2xsTk9WSTdCQnpCTjhtRnJCSzRoL2NmWUVJQkNKVXUrQzA2cU53ZWN3?=
 =?utf-8?B?eWcvZHJVUlZJZlRhYUpoUHZKZjVCVmhYSnJzRm1OYkJ2Z1NYSlI4RW9kZC9q?=
 =?utf-8?B?c3ZaeFJkOEQvc2tMSk9SU1VDRDdBSnBGTEloZDRUS3VyRXdHRzJtd09OZVlL?=
 =?utf-8?B?d0Q2ZnlZZWUyQ2xDYWZhY28waVc5RXMxRDVEZUwvMlF2SmVrN0E1a1NxaldH?=
 =?utf-8?B?WThLcWRuSUhjS0hYT1MwNzE1Sno1ZjJYWS84cHJOb0ZtQTlwbHdaVEZmMjVw?=
 =?utf-8?B?djNSdkNtV0pYWmNJclNkMG9zKzI0S3dpYVEzRUkvQ1ZWQS9DellBSjR4ZHI0?=
 =?utf-8?B?bVg3eTY1SWhmbXp2TjNyVC91ZzBZNStYWGM2dGIzVDIyQVJHNEVpdUxBN1d4?=
 =?utf-8?B?VExoNUpQVTlGaVNEN05NQ1EweWU0eFBZZm1mRi9TcHdtTVk4V1VvT1BzRW9O?=
 =?utf-8?B?ZHhBeUxtNjVmRGI4c3RldWRTY2JxQnBzTnNLSEtxeElqZTVNb1RSa09sZENM?=
 =?utf-8?Q?ETf9g7I/PYEECwt8CIprhLDoQxVdX/OvCW1LRMRglDlS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b46401c-29c2-40e7-0228-08dacd638ae0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:01:04.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8VpOBgvoXF36HsDvOLI/oFMd4pYauiDCe7226y/fBUO7TtWsr+9cLfPG8l3Mf5qtKsvpEB0kZqpKAxCpcPRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 3:13 PM, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Translate Documentation/process/coding-style.rst into Spanish.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  .../translations/sp_SP/coding-style.rst       | 1315 +++++++++++++++++
>>  Documentation/translations/sp_SP/index.rst    |    1 +
>>  2 files changed, 1316 insertions(+)
>>  create mode 100644 Documentation/translations/sp_SP/coding-style.rst
> 
> So I'm kind of slow, I'll admit...but I have finally noticed that you're
> not preserving the directory structure used for Documentation/ as a
> whole.  Is there a reason for that?  We've been (slowly) working to
> organize our docs in a reader-friendly way, it seems unfortunate to lose
> that for the translations...?

Yes, you're correct. The order I was following was: "If I didn't speak
English, what document would _I_ like to see translated next?". The coding
style directives seemed to me like the most important thing next in line. 
Following this logic, I was planning on translating
process/email-clients.rst next.

What would be better? Perhaps the documents of process/ in order of
appearance? I don't know what would be preferable in terms of organization.
Perhaps we have some data on most consulted docs for the Documentation
website?

Whatever option is best to order future translations, I'd like to get this
translation added, if that is okay.

> 
> Thanks,
> 
> jon

Thanks,
Carlos
