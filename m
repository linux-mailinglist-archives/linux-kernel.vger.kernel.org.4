Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF474D2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjGJKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjGJKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:09:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79203ABD;
        Mon, 10 Jul 2023 03:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU6Su5SvdhEX7u2cQRPFosJ3PVYm4n9zp1h/9mmZLX+RSp0gXYTflEL4gFsb263RtUWRJR8Qfi4EqQWsAd43Gt8Rvwcx6cALgaRQGG9KAEWGNrTV1UIhiIlOduSVyBnW0hemPRU6G/oWTzD6F1S2HzdkJc0QFUScZpTAmpYRdo5qbkOPbUlM9ZhdXfixWH4q1ap4eLufZCtQvp8Bfb1AyviJYN80i5iA66ZrGONOGbRvxYdVPpfDZzdBordrjQM5/cYEK3+PLv7DNCDmgthvk+gDWuPF8P+BczjICQkgV+1R8iQQhDMG6JIOi8rx+QTSodXk+P7AdtR0eDY6vfH/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nXRpra73V670gdGozPJ69rkuJaHCytuPPMUnLvHH7c=;
 b=FbPMtDQHoigRMWOiTUKSh25iKho3LnkDxGzd2giVB6QfPvj8LfNC8kAS+xbCBAMyce8pDIWxm5LdaP94X4ubVPaMQnTov+YJB7KpOXEL4cqIgFAuZqObDMDQK6QFW6++pfgqn92r/TFj63sibzoWKZQbGWV+KdMMouXo91UbXvANs23JedzUtfHsNiD8tnWB3dgbjsrEUr1baCKFUpj+SdWzSs9t8Iwe2j0A6N706pEwUggbIYv1LhSUalejDfsZiwWBAzwsu6QfxX/41VZ7b4A/LMuDHZQ5jdU3jTr4E0yBGALy5jVOFAHdH9saFh1rMAGLWXVYs4OUT98/5k+LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nXRpra73V670gdGozPJ69rkuJaHCytuPPMUnLvHH7c=;
 b=rBXTWErbPjIAbdJJpv+hHLovdVGMBxtR3L8xvD9VeaBJ/nDKzNSuaenRsizg5MKd47LYedj34aEcDeZmxNYRYzFdvJOmRoxxrxfyTDvwfOrsmNVReSuhuQ77HKHSq5lJ18QE1v2qCPscjJTjXTbMUNcBpvPyxNUHngCnmwIuabw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 10 Jul
 2023 10:05:04 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:05:04 +0000
Message-ID: <6bd1233f-3b09-27a3-44f1-92198dc08aa9@amd.com>
Date:   Mon, 10 Jul 2023 12:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/1] arm64: zynqmp: Misc zynqmp changes
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1685964230.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <cover.1685964230.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 661044d4-a955-4e73-0cc6-08db812d21af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MPViva0M6Mig3RkB0ZMZKJZ9oHnq55q4jDPbvOKxuyN4wzMsXPDEh0nqJ9q4lsL7B9YJJ7jg6JkMU0xKVIAGqO/Gsj81B6CXgCpSZ6GIRpZTRbT702s3ih+uNv2GSBReoOi72oqDMqb9P1sG4lF0k43J2EfGD/jJtddvc4lyHHdcNZD8H4902jtW+k00Kg3K/bejeslLicA5/dUsW1zEPI8cVH9bmm/0HU7wBrat99E/ffejIl4wsMlFoiTs+oIbKvD5pt00L6CVe7Dz4KzEUaguh1lFVRnuIlRyv1IMclmguFkqUNDvqoGQ0JkX0XVkh4ttsQ650toB0shKsjZCXsRg1lFZNpKl1NGK0DxJAdd+8Inj9WK43z9SPkjZQVfU2IQMB7BssQvh7myMSn5NjmtcHdlJ3a+xjnIKqFEu76q/5F/HbVL/AWjB/H/rl/ugv5ESOKap2Wg5jgc7Qy5tYjWbvPngMvw8IJhRbfWTgL40NVTIB7Gra0mFPC/x/uf4QE3BhCiVSX9/bdcPHaHOv4a/D2dXTjPGw/pJiS1dTwa7Mz8SytxhyF3w/p4S42ZReRqW0Q5xRAe5muePZVVYmt/ka10mASMJxCXqj/gAgDKRFG363zB2GloM/TpaiI/ccP1KYqFkjRppnFtvgauemcHcxVDnW+KQeOsiy8EOBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199021)(44832011)(4326008)(66946007)(316002)(66556008)(66476007)(4744005)(36756003)(7416002)(31686004)(5660300002)(8936002)(2906002)(41300700001)(8676002)(26005)(31696002)(86362001)(6486002)(54906003)(478600001)(38100700002)(6506007)(186003)(6512007)(53546011)(6666004)(2616005)(83380400001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHFYZ0lYL0VhRUxpUWNMRGNTUG1rVE1Hay9ORlhtTUh6S0RmbmVTTzF1TVI2?=
 =?utf-8?B?VnNDRUF2djhvVXIwT1R3SC9KQ0JZTitzYmZCNlB2Qnc5Vk5mamN0aTI3TTJJ?=
 =?utf-8?B?bU9UeW5JQy9xcEZWQlMwcm5pU0U3cDJ5Yk9tV3FERm9PTnhqZ1lEbjM2RldK?=
 =?utf-8?B?empVVC85NVhVbUJyWjg3N2pRT0tjcDQ4TXk3RE5aNmRhQmRCR1BXM2oySG5O?=
 =?utf-8?B?V09MMGE5ajZjRVJDb2dTV21rQ1lMVmVzMU9LMEF6eXA0UkloL1BJZWxRR01L?=
 =?utf-8?B?M3hWOW1YU1hSTUhub21kelIrd3JwUmh4RHRXeDQyWExCcjRMdlZBa214YTMy?=
 =?utf-8?B?TElUK00wbWpSM3kzVkoxSko0V242VUVlNXIrYWhsT2lXYkRhTDQyVkdWc3Q3?=
 =?utf-8?B?SUpJV2cveDVkdjJjYVd1TytXcEZ6d095RVRQWWIvbzFVcENPenBpbE9jM1dQ?=
 =?utf-8?B?UUJneGJDNGo1YmRpVWc2V3dlVlI4blMxdmgrRHRZajlaZktPOUt5K3Nyb1hX?=
 =?utf-8?B?R1JaNWNrRW84LytQU3V5RXRRbmd4RlFSNzZkWEF4N0p3UGpSQkg4V1NZU0cw?=
 =?utf-8?B?dVppR2xBcFAzZ1l3R2VlNUQrM254Q25ScEpTbzRTZmhCaEI4Yi92Yy9UT1cx?=
 =?utf-8?B?T0F3WmQrZVd1ZjdMQjNGT3pRTzh5YUZMMlFwQzd3MkttQThodHZ6UlQwRkpa?=
 =?utf-8?B?MEpVNFJxU2ZxNXQ5UkJTNEVDUTlyaFYxVCtVclFYM2VrQ2NUcWJXVDdFSlhX?=
 =?utf-8?B?dGZ6Um4zT0EveXVncE9HL0xJY3piajA5VHVjdk4wVm5hb0R0R2crZjY0M3ZY?=
 =?utf-8?B?T1RGQ2xmSEhaQ0tORm5ucHF2TnBXSXg5N0puU3V4RmY2MVNRZ20vTXpiSHla?=
 =?utf-8?B?UTlIMEJ5N0o4b0pQL1UrL0NMN2poT3pNelZvdTlUUU5qbHVwOTAxOGs5MkhX?=
 =?utf-8?B?TVcwNXNSVVV3Z09FMEtoNmd6WUs1Ukhnd2NUcjZDVGFXS3ViWnR4YnI2a0F6?=
 =?utf-8?B?ZzhRbVNxU3U5SERYaEJ0VzkrNmNuTTBocVpRdXUwaWtnb2lSOFdZT1ZtNm52?=
 =?utf-8?B?RU9JNlF1bE8zcjFLbVEvOGJ3K2Z0MktjWDFwZy9ZbTdaNGRPOUVVL0hrL3RZ?=
 =?utf-8?B?Q25DaVRacGIvcmQvL1BlUWthVk9uWmY0Y0FlYWFwd24zMk9xV0dZN0w5eU5B?=
 =?utf-8?B?UXhGUW95WFY2TmhWbnAyd3ZmTnA3UzNIM0UzVnJkcEJXSGt4THZ3SEdHZjhk?=
 =?utf-8?B?Vmlzck5PbisyTDkxdllpM0piQjJhQnBIT0dPdnQvZE8wd2ZxWjVuQjZTSDRo?=
 =?utf-8?B?SitpQ0M4ZkhOQVZUc2lVYURMTG9CWlBUNFFCNXU4bXp4UVpJRDRUZE5CQ2Fm?=
 =?utf-8?B?ZHZKUUt1TW8yK3oweVd2ZHJNMnFiZmVJT1B1TURmeXVOSm5VNVNjVUZIRUI2?=
 =?utf-8?B?SVlkWXYrOVFPdy8ySnZJOGY5bGEyeFZDbnJZd1hLWndtcGowVkRSMnB0UUJQ?=
 =?utf-8?B?MlpTTllTWVJYQ2pXckFGek5YaUtRUHUvVGFWR29LY203MFNUTFFLKzFYVmxL?=
 =?utf-8?B?Wis1dXBsNmdGYXY4V2p4dHlJd2daS3Yycjd0SGVOT3cySjVMelNjK1dLblVu?=
 =?utf-8?B?bVVjUExGWmU5MHp1UVlSWCtkcHZSWjM4MloxWi9KTm92UWgrRGhubkQ2MWFv?=
 =?utf-8?B?YlJMcjlGT3VSOVpNd3R4S0NxTVVhSWhjTmxnOGJmN2dMcDhKYjZoemMwSGRn?=
 =?utf-8?B?Tm0wN2NicG9PVlM3TnppWitzd01vSERoVXVBdjN2ZE9LQ2hmdW51TUwwMStD?=
 =?utf-8?B?bFJ6cm9kOFpBTDBJRkZxckNrUnBsc3Y2M2lRb1dLeTNNRnd0K1d6LzBjVGox?=
 =?utf-8?B?OEUzbFNXT2RYSjlOYU8wSmU2bytEOHdIeG9Vb3FHaHF4TkJSNnZaWFR1bDIv?=
 =?utf-8?B?S0hqTWFNUVNmMkZpNW5GT3RMRXpxcWhyMjh6SnRRRXB1RmNkKyt3b0hIa3pY?=
 =?utf-8?B?MVJ2eEtNc2xQU0VqdkhzKzcxL29WcEdXWDlMSVUzVlNFeE9GZ0JKcW9oMFZZ?=
 =?utf-8?B?MC9vaGc0dDNHdnFBYmFoeUZEMG1zcW02a3A2ckpXazEzNjJoTDdnZDRIS2lO?=
 =?utf-8?Q?s+7CX7UNpcHM9z5DYlbCeaKRP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661044d4-a955-4e73-0cc6-08db812d21af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:05:04.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luS0I7P7ziYrsdJ/8BfCn0752snV+mUtTGRrN5f/7yQ/sirjt/wqS3NyQLj99rYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/23 13:23, Michal Simek wrote:
> Hi,
> 
> the series is syncing the latest dt changes based on board status and the
> latest DT schema.
> The patches are based on
> https://lore.kernel.org/all/20230321070619.29440-1-parth.gajjar@amd.com/
> 
> I have applied patches which were reviewed already to have smaller series.
> Patches can be found https://github.com/Xilinx/linux-xlnx/tree/zynqmp/dt
> or they are in Linux-next already.
> 
> v1 is at
> https://lore.kernel.org/r/7d034b9e-e4e6-5d72-8b37-78e25918aa59@amd.com.
> 
> v2 is at
> https://lore.kernel.org/r/cover.1684767562.git.michal.simek@amd.com
> 
> Thanks,
> Michal
> 
> Changes in v3:
> - Add missing cache-unified
> 
> Changes in v2:
> - Update commit message to remove Linux part - reported by Laurent
> 
> Radhey Shyam Pandey (1):
>    arm64: zynqmp: Add L2 cache nodes
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Applied.
M
