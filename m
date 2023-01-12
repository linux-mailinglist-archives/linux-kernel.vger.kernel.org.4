Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF11666F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjALKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjALKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:24:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E5BB2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:19:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkMsCxmXulHrejdBCAd4CfPB3HS/ukb6LnjAkTfOpXloCLImBt4uTisaBfDiBS48UY8MC6rD9TM89UEN7bpviMJw58drmWh+nTHrYk6oz5fzUAnx2Yj9+CbW8di0p9WmGcx4YgDOvTMXDly+Ua8eRMyW67OFj2BqwvJVVeuCp2L+iGHR4RIl3AOGdQUzwadO/k1VixAnfAcWnba4cs/odwN6V5zapF5CGhXu6O3MDmX64nhK9iG95yQDZA7146/xTiGlbIn5Z4FB8DRcrXc+KL9NazfYdBE4v0SalxwC+tY2CyawRB2pgb8dgIkOpDOCrl+QZiQ8sk/98POZVKXR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDttFM7+6mc4aOzqrDMvKNu4cTjm1QMKc3qDWXOqdY4=;
 b=EKq+Zn3EWHiwv2F2q54p4RuKbIGRMCF1SLC/XCsVJT+7uz7COu51xYmXPQIxEVlWLVYh29rorAWZoKu041ED6tkcaY8iJHZ4IZ/tbhBcPSC3dMjqDAc2FijouV1TOQogfxhjyTpBAYe/Q4a4fBkpy1nSQvKRzZ5a527v0QHCsa3Uf13CfJQKLtiEuRyxwvrI1Va1JGnxb+CKJr9wmzwrd/oH+vjmxcnfHOVjZvJ7lsfJ8I599qQBbz6EyhuhJYXSxxRVbERmgqIjSlqybHHu1cCpEWFIOXp/5yvrIE8wvfz1RgJ3h49xPAFwVfPsfaxlnx9RAGwUMdumBVQ524WglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDttFM7+6mc4aOzqrDMvKNu4cTjm1QMKc3qDWXOqdY4=;
 b=iwg7UJn4EQrmf6Wg5h016J2TsQT2TtTzmoUBz7Og65ZitZZqZcW1C+NfYnl2wR/uc7QLIkU961BnyKvNTjQO10l2evAZleUbbweykZl0a/Loo30KHDLquHDCr36BQ/xQXhHlcpxfOleq8A0w7XzyM3hydmt6RT90TLdCkbgvL5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:19:22 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 10:19:22 +0000
Message-ID: <8484786c-d146-dfe4-9bc1-af562e91382f@amd.com>
Date:   Thu, 12 Jan 2023 15:52:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 15/19] soundwire: amd: add startup and shutdown dai ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-16-Vijendar.Mukunda@amd.com>
 <512a60e3-8194-c3ab-99a3-4443db2255a1@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <512a60e3-8194-c3ab-99a3-4443db2255a1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b658291-8ee3-42f7-c9ab-08daf48678df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD5KWgbS16p9k0Uwz4XL08H12oPkY69q7qp5z1z9IWzIYnbgFlPoavJnngPLukT7ehYlHfzsUP3hpVJ0MhbGc72g/FAm6CGnFPOpiS9PmKIbv8q48oCiXHhm2Ee96FC1mBbTDGbfjEAMg9bD8LwBtK34FKUs2ySXzqwsI+TBQbUtd5qahhB7mucI0PGUJMmxE1hhvzRg73OvEEGtKztq+vGVCCEQeYcw6LWPa4dUO8Tyft8Kpa529DBAlL6wMOAwIZBKAHq2qAap+w62fVYwLVvYDIp9gcT3W8xJ0hVMVAcODHrorOQJEXPT7Y04OOBLHYb5NIEe8aURmC7UyzVwDgqLIgB73vngBwI7/Pg8Ad1B2CKXK+a5gbAP4fNFw1gamFd86wkn+Ye4Ckd2CYBbmYPH5DXjVoAElNNtWdhPC0aoQlFCiYr2L1Z2RvYUR7xb92TNlRwrHM8CFuXw6DDIOn4PHOQRXYl6v8Rdu3GcoCBtRSQ6GPMArCbGrOksbO9fgnUH0QDYSKO4yNxjCFRn2RiDHM/Ssw89EkmHaEbugGnSo3CfADaZ2u0ELOpp20iLpsOjqXU4BvdR2uI5165tWJIRaFUd6wYIXiZOUVDe1FnAD6F2fP39cv/vXueycw+oggwzlZaYczsPGi+w0617ZzP/PPSlKDJSZbxo6BT4fmLiwMsiEf2sUjU9AybIAY5J+Afg4BCIoWsBI6skn8fH8oHE5eTQeDM+5BrgSSW9Y2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(41300700001)(4326008)(66556008)(54906003)(66476007)(2616005)(316002)(36756003)(8676002)(66946007)(31696002)(86362001)(4744005)(38100700002)(5660300002)(8936002)(6506007)(2906002)(53546011)(31686004)(6486002)(6512007)(6666004)(26005)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNnREcrWklZOHp1RzY3ZVAxK1pmMWlESDQwREMvNm1oLzdJdVdvTnV5ZVh4?=
 =?utf-8?B?dDZxOHB6VWZhZzlrU3ZUNHB4dURnMk1EM1hyZCtTOFUrQkMxMW4yYmsrcXIr?=
 =?utf-8?B?TkxkaDVLcFdPZzdrZzlVREJqMDJJYzRJbzdpTkhJVGFSeDlXM2NxVXBxVk9a?=
 =?utf-8?B?VG4wL0xQdEhxdXE4VWJPVGVySDMyU3VBY3B6SWE0cnNhclVVRThuMVhVQ2My?=
 =?utf-8?B?SWpzeHdmZnhmbDJhWGNsVHFYeTBsOGY5S2IvWk1wYkdaQmhDQWN3akkxUkw5?=
 =?utf-8?B?Rm9OV2NJek81aXQ5TFhrZ3lEWnFKQmI4cjlOUWRqOW5FdTg5Zno2eGU0ckJ2?=
 =?utf-8?B?dDVxZS9yT0dheWFYWGtiaGl6UXR0MHBuRWJoaWNoVEpTUk1XaEN2U2xzdWE2?=
 =?utf-8?B?cUNaOXQvWlpYMGVCbTJBUTc0YjVvTGR4R0dndElhdHAxYjNpNlpyUG5GYjNR?=
 =?utf-8?B?c2NhTkY2ekpsUW1mb0U1VWR5N0lLUmh0YXhzRVhiS3dMek9OT0hNYS96bUxG?=
 =?utf-8?B?dHVERTRzVmhsSXBaWmFGb2RwQlpyV25RcW44REdDSk9mNVZYMnRSR1lyQmVX?=
 =?utf-8?B?WHlnN1VaemRCUmpOb0szVXJRb0dmcEtsWm8wVHdISGxnUXpyWlNDd0dqMW9Z?=
 =?utf-8?B?OTZhLzZmTGlMcU1QaEpwMklyN0tMU3NNdUJhR2FYLy9DS1kybm1DUHc4bDl5?=
 =?utf-8?B?dDlLelZFZ0hCMGVwL2t6bGNUcTcvQTU0RVRCeVM4RmJqVll5NEF2RGhUYTBj?=
 =?utf-8?B?N0ovWmcva25iRFpCcmx5WDhGWGVmQVhWbVZvZDdpb3ZKdXpTWjduRThMT0ZP?=
 =?utf-8?B?aUxsTStFbEJyajAvQ0xtNkcwNHpHQVo1SVh4KzFwTjRIT2F2NkgvWGpKZzE1?=
 =?utf-8?B?T2FyTGN6V292NmNzRDNWZEQ3NlhYWnFRZ2FHbE5sUUMvNVpEVGxabjJUOFFv?=
 =?utf-8?B?dkpVV0d4RDBtSGNmRDVFVUVhcEZERVU3blp5N2ZPdFc4UHdaVjFsSWxzNlVM?=
 =?utf-8?B?VFZsamdtTmJHV2k4eFJRaWV1bjNzQ3IrUElhb1AzVUtidWMvaW9DV1l4Yldu?=
 =?utf-8?B?WkNwMmpMRURyOWlLQUdvZFhFYU5uaURuMm9QRHVwOTBtS0oxaUFjU0I5QzhD?=
 =?utf-8?B?Z0o5KzRyc0o3bEg4YXd5RjB0QUVXWVhhTUpoeWhJRUkwY1lQbEhQRCtueW14?=
 =?utf-8?B?dGs0TUM5ZCtMTnRiT2pPeVZ0RTFydktpZHp0cnE4elRaSnVmbjVlTlFUTlgw?=
 =?utf-8?B?RDA2Smgwd2FFaHhuejFvUVBTa0VwUEVReWhUR2h3emZrZ1ZtdnJxYTNpajRw?=
 =?utf-8?B?WnduenJzUi9RRVFuMHdqNHpZWk44OS9CZkUzTW5ORVlnbnk0NzZ0cDJRaW5P?=
 =?utf-8?B?WUprbE43bkhjZVV3blVJdC9zOWFqRlExVVBMYUJaU3VYck1ObXJtNEd4V0ha?=
 =?utf-8?B?SytGVTlBb3VGeTFiZDVpcnA2am1kb3BzMGxWMktjV0t2Y0dESmpZZTVXM1VZ?=
 =?utf-8?B?TURXZmxFT05SNFA4dlRiTmVRd0NjMndjbkp0cWdNQjFjNk93aWMybVFyb0w3?=
 =?utf-8?B?MnBjRVMybHZ5MThxZE1aUG5CWWpnSHhPRnZacmRac0FPTktCSFJaZWh3dk41?=
 =?utf-8?B?YmpTalF2Y1RSVDJTWVVXYmxBTklBLzN3Q1RjZzI0ZGFGaWFMWWFLSDFiL0NB?=
 =?utf-8?B?OS9jcklUQlpqVU9WbFZXY0pjNVFZZVJBdXpGQVdkdmdwODJYeFFyZG1lbkRN?=
 =?utf-8?B?cjk3cWliN1ozUEQ0b2owWWVwQVA4aXlNMTFXdjY0MG1uSisxWDgwVWUvRThh?=
 =?utf-8?B?MkpTbkVGTHlpUDhvcWhGcUxTaDkrQjM4VE9sM3F0NFVnU0Q2a1J4Ny9lU3VI?=
 =?utf-8?B?SG1DM3RleDlXQ0IvUjdwUWEvSGZZNWJhRmhpZFpwODg5QXdCN2oyVHFKalpw?=
 =?utf-8?B?djZGck9DeWpMZ1c2TzlaWVE0Nm5pMlAzRmVMR0dEUVE4amFWTVYwMHhTakR2?=
 =?utf-8?B?NzU2ZlFyQ1o3dkJvbm96REFMMENWNWhQa1BidEduSGZPQ2orcEFVMjNReFJl?=
 =?utf-8?B?M25PakJZNVpPRVhrOEkxZzVVbE1ZZkZLSGRIMXI1ZzJLQnJ1QzJoT3JENUwx?=
 =?utf-8?Q?Is8uHWP0ISTbDvSxKhEcG0CHu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b658291-8ee3-42f7-c9ab-08daf48678df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 10:19:22.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nlmGFsI8hquz8+G81Yj/YMqXfrJZUp+OUeLxDqL0WbLTJFAX/BiKsaOBCMffEJiM6hMg1RtSDs5E7hA3e9fUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 21:19, Pierre-Louis Bossart wrote:
>
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> Add start up and shutdown dai ops for AMD Master driver.
> I don't think those startup and shutdown ops are necessary, we removed
> them for Intel, see "soundwire: intel: remove DAI startup/shutdown"
will drop this patch.

