Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591C46A5054
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjB1BAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1A76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:59:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684D29411
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:59:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvQA/Zt8D3y2VuvI9yOPQGSFcPh9JzL0BOz3XWCWOMn4SG/sqL/OvUUUzImjLvTBHNvosbZWCP7at7kkTIHk9dbTXe0dl7rrnc9Df70pvagoKpBzgphfGx9+XM39lTIxXBW649VqDiVIs3HyvZYt8gQ2lpj7X6mENptLJ9n4DzvasRQPyaLLdGQrjiZ732cOgGxY1Qkxsnlt9RpkIcXZWec8GZQeiK/FlKCvh6EPV1T4eHoNQUnYW50hFewPCEsImVhsib+A25ewc3Q+IQQ0Hwo6ipO2iLMHcVyRSm99NScuALZbR0lLNqKInEt8vG53ppY8MTui4/IO0/ZC+TExeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo73tznIKtC4KnxNhrOrxWVt/64P3jqvc5cEwhJ6T3c=;
 b=ASY6U7HUAEtGDIt9NpRzXRuXL3feC/Zl8o3DB7fAi4FuN+925Oelpl3yxIzCOCcyg9MsSpkNf3gl2bqhbDpHMCg7pLABRlcr0tIpKsrWFU70aE4N+CaKIMng4OXe0Sg5xriBKR8A39wEPp2BnCoXOkSJlc6szoNTQVEbSMSlCZgE9ZIlCCAATiPc0W8XXGIN2OtVKhOXsP8/85V39uO13Nrp3zRrRYYdiKwz+seoVK4OvYgtYQPHSA+kEfEW2EBecdMS8MOrFKq25Mtx21MGVsibpjYeGQd0kH66rsL/q+tWnbeQf+B60pKXsoKiIwKFuX879Hcq4H9YnPvzmF6xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo73tznIKtC4KnxNhrOrxWVt/64P3jqvc5cEwhJ6T3c=;
 b=Im042UNlb4P3kGNV5xrgjwB8cGH9ENGbFeSVoLhePCuwDKDINCr3s7rGjwkug1NtMbu2PZ5VsJW1dlagyD6oditAAGEN8rkGi23mCLbTPPm1tJsy+gjwH1n291w2ArF5rj7Xdk82OX4nj2ZlsMZ0AFCPXKR0zL7vAC0YqHTkM3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 00:59:54 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 00:59:54 +0000
Message-ID: <64888213-0fc9-cea4-fdea-fa51bdcbf0bb@amd.com>
Date:   Tue, 28 Feb 2023 06:33:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V4 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-9-Vijendar.Mukunda@amd.com>
 <82c7303b-131e-0633-2c08-5b4b414ad941@linux.intel.com>
 <acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com>
 <3a6d02a6-0b1d-6e9e-2f14-337373edec48@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <3a6d02a6-0b1d-6e9e-2f14-337373edec48@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL0PR12MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d729b-3963-4bc6-8119-08db19271890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ci+hZ4L5c4rvwoGtmfQIPeqM93Tg3rcSfCCw+p46RreWwxvaDqido4w4unMrg/HMfxXxxBMOGSIWeU3soH0sOIuoFpCWvDJhbnEEkXAM3ao29G5M5/vQ34UWAIesLy4xtHX9bMo6dNUj5Fq1jg7L75cE3+mdU5R98dDqQ/jT2YYhxjYsCK7lVcNn+SVsisRSaI5eAuIT6pg9GZW1QoZlkqYVc1PFmHGnLvOF1j7duQGoIBaGWbu9IO/sV+EIOHfGJ96rNdiChRyMZG0BZfjfyyMEy6w7V4FKRQebtnzaN9ddP+CpUgTAUl76yRyHT5X5sIGUbCi62SfkpZMKny0MhYF8Oa1XAMZmDBfbgQazGiomxquaekl6LD8rZ533t3/we9OEnHLG5ajc1Dr0ICo2pTS87USkg6USRei185G9VbJdXLw/1cWsdpUoOQafhWaq24kGIiEHqqBV6pePXvqimiRFyo57joEAfLVx2V5/0BtQlheM0H7usJGGFa1Y6NwgOVuvUduwj/jH8czebdJj4V+RccWD1p0MpIywm+NkuK1yzr/HYvXceZGTF3rfY5T31jhsvb8Z75v7NgPmBGKKWo+I1wOsEg2YO1Sny9KEyRA+PpBm3UfgtbJ/Kzl1R2o1pBaJZfajMnCSalB+AzEYyJAA8RPhfhtl8UUhAof7U+EcOy4OkekbmJhQcVOM52MfnLUmVa5vWFUnTioAA4P9OlP1Iwbt4ZO093EfhY/LYqm+MHwR8TeTnmxDFkdc6UiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(2906002)(31686004)(5660300002)(8936002)(66476007)(36756003)(4744005)(54906003)(66946007)(41300700001)(86362001)(31696002)(6486002)(966005)(478600001)(4326008)(66556008)(8676002)(6512007)(316002)(38100700002)(6506007)(53546011)(186003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmYreEdUQlhtRmtWQWJoNXdvdzRUZ1R3anp2bTZkOWJIR0l6SEtsOG5nQyt4?=
 =?utf-8?B?dWhoWXh0cEp2Q1haNUpnRlhVY1FyaTBFZHdzaFQzSE1OWGl5WnJFU25aOFNa?=
 =?utf-8?B?U0hoQm9jbHdCaDR0blBlclBqQXV4N1BXbk5USlAyT3d6cUZhY3hHSTh5S1FT?=
 =?utf-8?B?ZHdhaU1HeHhyQmkrdHdLSjROSU5UMnBGYUpQZU85TW5DdUxNRXhkWURZN1BF?=
 =?utf-8?B?MWV5dGhaeXJUTmRCTkNMM0xKWnVJRjJ0VVNpNkRGczZic1BBL1d6cWRyTkVv?=
 =?utf-8?B?RUwybXVlUk9XT0lNY2pPUGxqU05jUzEvS0NFRUtaQ3RMZGdSZjd3SXU3U1hQ?=
 =?utf-8?B?NHhUdXRVUTNwNm40eGFhT211QUhCTjkyZWJnZ0NqRFc2VVRvSDhIb0ZCV1I0?=
 =?utf-8?B?azd5ZDRnb1FjRkV1R0RFRXVjRXF3Rk5pcUhlK3RMYnRoTXFaaUJzSngvMlh1?=
 =?utf-8?B?VTJYQWV1VDVsbG02OGZDWGh3c3M1VThvMUF1WGlDK3F1QUZHSVlzSGFEQVY3?=
 =?utf-8?B?cG9vYVBSMHhncGZuUzl3NlRtZit3TWxDekhkQlMrOWlsN00xdFNiTk8vdHZE?=
 =?utf-8?B?dVlHaXBHaVZCVWNlTm81RWtuaGdpYm1tWHBWQU9qOStPK1F3TTRqOGJoUjYx?=
 =?utf-8?B?Yy9acmJmKzlPaEtGbkZaQS9Jenl1TDhXM1dLWUY0MzB5QWFCZEtrQkVycldz?=
 =?utf-8?B?VlQ5WDZWTGdNWm9BenBkMlNKNlJkTitXWE5aRGZxN1ljTjlRaXlwNnQ0SVhr?=
 =?utf-8?B?eEdGdGFxUkpWaEszZmNqMDRldnhidzhIQ0Zoc2lDS3hzWTllak9xaHlkamZY?=
 =?utf-8?B?ZjhDWWYwa1hCTHU5aDhUMTJoOEhTbGo4TUkyNnRLT0dHTzFhUmlmcERQVlNZ?=
 =?utf-8?B?clVoY1lpUWVmbU1kT3BoYXBSM0tOM0ZHak9QaTg1Mnp3Y21FalFKK21XU005?=
 =?utf-8?B?SHB4bzBqdXJHNzY1bDlPamIxM2FQbnQ5WE1CYW8rM0d0U2FBRDBrTU10QVhk?=
 =?utf-8?B?YkFtRURLUE8zUFo5ZE5IMFFvRVFFeC9YSjMwRHQ0eUlOVktLa1pxc0luQXRk?=
 =?utf-8?B?Ri9rN3V3amxEWWlBUDczMUtRK29FZlJCWk05R0Q0dERkeHoxMVRQVVJMUHJK?=
 =?utf-8?B?K1dQS3lReE1lVDR4ZnN0QWczYlIrZzVaNytpcktQVDgrWG9XQ1hsVndZYlB1?=
 =?utf-8?B?RlhReWNrYmErWkdTV2Z1QWcvRTFVMmlobEY4Z1J1dE04TjMwUFExNnZMMlhP?=
 =?utf-8?B?eFkvNFNNeXlMZ3pEcit5WmVFQkdVSzlKL3JNc0RkU1lZSXVGNnYwQjcySGRi?=
 =?utf-8?B?VjRXcm42UmNvc25MdmdMTmhVa0hZSjBxVGw3bWZvalcwZkYyU3k3Z3RnTTUy?=
 =?utf-8?B?eVh6amxlSzB5SnVLZG4wVEpXNzhTVFFVQ2Rxa1lNQnRQYS9aMWxnTjJmYXFM?=
 =?utf-8?B?NzdjY3U5UTQwdVVYUzFUbXpZRm5jL3cvZHZWS0VFR2tVVzBxd1FjYU44bWdk?=
 =?utf-8?B?QmVaTDBPZW95cDdiUURzMUN4emNsVVlRaUg5V3p1RmRnd0tDWkZRcmRsMFZV?=
 =?utf-8?B?cVVLVmhFV2JRNVlRZmg0MWt2cU5RTFJGckp0K2hudmFUd1RjTWNNbzM5Sm04?=
 =?utf-8?B?QkFBamQ0UkdJcTNqTXVJVnRBOGVadk1TMFJPYll5QTBQd0NDT05KaG5ldWhx?=
 =?utf-8?B?UDlqMXdLSXFWMWJLOTI4Z2RDbmlvUUF3QllnZW1EQkpWemNONmVwRVlTVENM?=
 =?utf-8?B?VVJlNEc1ZlFQamNsOGNLV1NPbFllbFdwdTBFMVFxWTJwcEFVNzNDeXdhZ3pp?=
 =?utf-8?B?ckF2d3NCR1k4WndFd0M4UnVId0NQUThGTVoyQzhDRnFJK2l5TlRCRFhGMzE5?=
 =?utf-8?B?L1EwMlJKdE0zaVRaQXZsYk0wQmxVOFg2SzlSOUEwbUowQ0plWWpPczhxbVU0?=
 =?utf-8?B?YkdtN3IxbVZDZy9SQjFPODhPYzZQTUFmcktHZCt0bjZPQWtJN1JpdTlNWjNC?=
 =?utf-8?B?TUh6NXFXUjc5c09xVUQxY3p6VmJsSXR5OVVoWDUvanB4SWlLaW1mcGVaL1Zz?=
 =?utf-8?B?T2JNNWh4cE1EUm1GelNidUR4UHorZ0hhVWIvaG1zc0hkQmt3disyV3FLUlBI?=
 =?utf-8?Q?LSzM+NxXc2AVEOoadgs2iCj+a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d729b-3963-4bc6-8119-08db19271890
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 00:59:53.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iatg8+Tr2zFdJzcGXA+2Fy/Dw/XgzTTxEADjgEe3Vx1DtQiIN1HqYst/7rYe9tfRi9WSyg4t73R2YLBIbNweyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4961
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/23 01:10, Pierre-Louis Bossart wrote:
>
> On 2/27/23 13:42, Mukunda,Vijendar wrote:
>> On 27/02/23 22:37, Pierre-Louis Bossart wrote:
>>> On 2/27/23 10:48, Vijendar Mukunda wrote:
>>>> Add pm_prepare callback and System level pm ops support for
>>>> AMD SoundWire manager driver.
>>>>
>>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>>> seems like you missed my comments in
>>> https://lore.kernel.org/alsa-devel/7d32d552-6ca0-3c40-11ce-c8d727cadc05@linux.intel.com/
>> you missed my mail in reply thread. That's why we couldn't
>> get a chance to check your review comments.
> I don't see a reply be it in my local mail client or lore?
we have provided replies for your comments in below link.
https://lore.kernel.org/lkml/acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com/
