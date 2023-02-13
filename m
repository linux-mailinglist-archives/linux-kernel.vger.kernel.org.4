Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923DA694C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBMQP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:15:52 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2119.outbound.protection.outlook.com [40.107.20.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66A30CA;
        Mon, 13 Feb 2023 08:15:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxnbdDHjavCUTdtpZCWclSnuyzgBDuqn3y/x5xnnOMBIvh5Vq97B6M0BYwKHl1Hi93eU93gIIYHHH2T84dWDI0SL1+WVdBoDE2Um05w98wtoAeSisLEBsJUV8x6ZradeChgHWwL8JSEGAt8a8qYaWpEoYj8jUr2P0Vdb9vDJPhMCa/0aO5bVwA9II/tn4KuUzRSjo5Fpt9yCVZ6M3SmkBMuhvvADf1Bm+H6jttaCyMPpggRuLZmy96XRXepevOCbQXySKSmVkPBWWUTplkE4qciw4wpZZa55hk1hbp1LFyMrBFNZaD6AK2nwfHtPljJGk05lryTZ+sbLi1DgvsnJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0vUO1nUdqi9kkB/PZ30Nm+TM8UPvN2TPZ3qHNCIHBc=;
 b=DM6ImAhvGWhqO4eXdQBZiBv+tkLsgUE9Havi1w4dkQp5qqDxandYe9h6H8UgG2rqjyMd7OL9VLHW/djbQGCbFhYjAz80X5OuCWgVSiHpcViTXR9zjrMbyv51MAkgYBt438ZjXRZx87SNzaZ0kjnYmDrNj0l3Uf9MyAA0rlb4J+BzYfK1Jgo75qSn6ZGT+5FW4zH+HIVcJ7taeYK49ipZDXIqzl7VbSQi58aD5Q5bnEe8D2t8tt7LZBb5fwSiSC5zdL/KN7WJcFXjiFoc0tZLfuqaqojIWnzlm13cS3YVhIrhsXqy5lGBBGLJwAJYjNX4/ILjSqsQVpSRv/j0QRjteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0vUO1nUdqi9kkB/PZ30Nm+TM8UPvN2TPZ3qHNCIHBc=;
 b=oPjLDVMIwiOKmseeUCO346TxrtQd6nwys7mCVuCOMQsWSW8CpMOfi9L6bqpa/iEEpuz3HObigIGFmmgjyXyUKNGhAklvSgvu3v5P+vb/w8PHNHvpq4toDUBP2Ojgb7qsOVaOc6xF36hfszaRIfwr5X81+WyIPbm1+5m5xeuT4ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:404::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 16:15:47 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 16:15:47 +0000
Message-ID: <f819ed93-67fc-d052-36af-142c0c09683f@kontron.de>
Date:   Mon, 13 Feb 2023 17:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Frieder Schrempf <frieder@fris.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
 <7b1a8b7d-2269-7ff2-d480-ae5de8c4cc4e@denx.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <7b1a8b7d-2269-7ff2-d480-ae5de8c4cc4e@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: b01e8ddc-e853-4ed9-245b-08db0ddd910e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHKVildi00O70JoAmfkQUp5RZZoN/ztQPzqJtlw0W/WaZze+g2Y3lln8ql8y1esUAXaOlbQ11WlPcvn8gWotiuLl7xFAY7imHJPageXq/h/Bgehe0w8N0Pz3tHe1NpqWq9sQoNPx3CEvI7MUfaMFqcJg5iAXuoY5yqlkwqEeOQix6oHjh7wJe4EDDcw2+yxZnoN5isOKqzkCB8CZl+VTReHTYQ/T5GtaqCCAh4uM3CYWtz4PEm/IRqGnsOi1lu2W81T4xcn1KHTLs/Xi4TD820ik/mM4pd/PHrUdTmHZ/jraPVTr9c+839ucvrUR0HqBe8f3/R+YZPaSiv23nLWMFdhtqw6qMKI0IkXEB4/gcqClW7rF9EENqYooBRKWBHURQvBM33H4GHo/OYlVRxGYvphrUEa+gfa7tcoelQ1OmUDzemuatoyDP6MCmmrtHbO4GQ3cRFZLclsvGW88Sg/6j/PQUofQ1YnBNQu8gtComtgi6TeEjIz0eWYtxGfH3gBm0ZpozNQJxkg9MhMg5RmP513wUhFUOv2gjqAxjL7DuajzB1Dy51AjKTYYJdB0GvAzboX+wGJYyJNxgQB5BuRl+jaX39stfo69KkeXS5Bt6oOd0DyloV/R9m1vHTsudvaanPqzmeI2wLDCq2WkUWjDXUKVDCmJkRLDv9GlM194s/EunvTNWzd8vodgGdNUYtvbtrfVmExJgYbnyHDZYyHzYxQgEnNacEFKCaJ+UdfXFOotCW/jLjlmUP7VcaL0gLrt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(44832011)(38100700002)(316002)(2906002)(7416002)(66556008)(31696002)(4326008)(8936002)(8676002)(54906003)(5660300002)(66476007)(66946007)(36756003)(41300700001)(110136005)(478600001)(6486002)(83380400001)(2616005)(186003)(26005)(6512007)(31686004)(53546011)(86362001)(6506007)(6666004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHljWXFrS0hBcXkrTW44ZzNEdmMrRndOcEQ1N3dNdkZ0cVZvTGhJV3RQRDJO?=
 =?utf-8?B?MWJlMllBelRUQlJ3a0lidGZaL1JIZ0U1QjhkTC9aUWR3eWpZSHFaVmpNSzVJ?=
 =?utf-8?B?eFo1eFB5RHFETWZINFBQSWFKdjJvYVlNeFRkQVpFTDVPRGxUNmJxZEpVL0FD?=
 =?utf-8?B?TVIyRyswVWR2Y2NLVUgxUUpweHpmc1NLNkJsZ2ZpOXNsNlBEYk9ZdHRCVTA5?=
 =?utf-8?B?Y1IyTkZaQmpwUStyeFRKRXQyQ2YzMXhmWkxQakZibGxzV0xCUjZWbEkzVnF6?=
 =?utf-8?B?UWFnbVFOQUJBcjc5bFFoYXFLanpUazZ0aTFwSGV1c08vaUFGOUZxck4yR3dQ?=
 =?utf-8?B?NWdvU2pEb3JFZkZDbXQvM1pMV0gyaFgyak9UYXNXL3gyRk15YVdDUVNCRkFx?=
 =?utf-8?B?K25wZ1JkdEtCQ01lTld6OXhrMTlpWm40c2RIVEpWZWMwbUdwZFpWbGJLYlN4?=
 =?utf-8?B?a3E3c05BeVppcUNZYWRjNnZtTVpjWWZNYXpKemZ4NFBFQ0R2NkdBdDJWZ0tF?=
 =?utf-8?B?bG9lRTVmdDQxWXhpWFBjZmNFeUFITUpZdDRYWnY2b2pLSjJUOEd2Tko2bWJK?=
 =?utf-8?B?aUVaRTJudHRVM3k4bm1wSTQvMXhsM25ITFUwVURpUTNDMEVUbis5RjlzNDBh?=
 =?utf-8?B?dkJRU3FmNFB3czJUQTNMYVB1NHE1eXJUUjhhbGd2NldlaDFab2xHK1dibkNU?=
 =?utf-8?B?U05PVG5wZE4xOU9zdDRqd1dxbHBFQkgxWUUwWkZPeDNrZFdrdlVaNHNCZGJH?=
 =?utf-8?B?cnVJZktEUjhLUzZ5aVBBcXpBS0RyZ0hpTmY3dm5ZSFJJYlFhZlB4cThnZEV2?=
 =?utf-8?B?LzBBYmZLaWZBSCtZeGNrUURQa3NCVFRjbFhqK3FuUUhUZVpDMkw5L1dDQXVz?=
 =?utf-8?B?OGVmUWdkSW9hM1pGZXg3K3Jpc0lQeDdGK284SDhIbjh0QjVPV1FjY215M3lZ?=
 =?utf-8?B?azNSbGNMd3NCYVBuVjFYYzV0WklhVk1jWkcydGhPMDM5Z0UybU9jWms1dXBL?=
 =?utf-8?B?cWVuWEU0Vm1SVnZVbkVCd1pNbDQyWW9EbU5ickFadDNyVTBEK0cvWFpzb1E2?=
 =?utf-8?B?bFRXK3E1b1F4bkdzY29jN1hZY2VnNVkyM0s2UXI0Zy9IczR5OStuRkFzQTBE?=
 =?utf-8?B?UzROMlE1MUxKMWROdG1Yd0t2S1JwTys5ZSthK0JLTEp2VHFtRWx3QUw1YldX?=
 =?utf-8?B?elFTdVdya2lFZHo3WGlyVGgzNEUvVDVWeHFvd3NsSHpiUHhTSStRSU54QnhR?=
 =?utf-8?B?UmhnejBWNmcwck5ORmpmUGpyaHZpVzdZekE3dzF2bEs0L3c3eG4zY2htTEIx?=
 =?utf-8?B?SzJiSjJDNnJEek9QZlhzSmMxMGxyZXMvQVB0OUs2M2hISlArdUFCNnRLbUkw?=
 =?utf-8?B?ZlRwZ0NPTWRpdGc3M2IrU2pacEJEZGhLV3BDMG94MDFZcnlqak5XNSt4MDVF?=
 =?utf-8?B?L3dqVnd4eGlTWFc3MVBCMldka1E4WE1LTVE5WksrZk1ZR2w4TXd2WDh4bGlh?=
 =?utf-8?B?cTd4a1lBL2VpVmxLcnoycy9Dc011aXBrZ2FvTzhIUUc2RG1jckI1Q1ZwKzhw?=
 =?utf-8?B?TnlZdEZNbEdxVzhhK2VjbCtaVmRnSEJvNUJCdDNGMlhhVzFNM1RBRkFJbzFR?=
 =?utf-8?B?YWtJcjdWblM0TytSbjFMZ3BBU3JLQW1jRitsZ1Z2MzVnR2xIMXpQZnIvY1Vj?=
 =?utf-8?B?TjNuMjN2WTNlVldzMklyQjRySlA1VjNRcUU3VlhEL2dkT0I4OGFYc3cwZzhD?=
 =?utf-8?B?ZTFmd3lzR0lYbXRzekF1K0gzUTQxZG82TzhxR3cyWW1USENXZThWVTQzK1o5?=
 =?utf-8?B?SVZiZys0akJ5SGczZWoxNGh1em9QVzVFYWJIYnlTczVvYUU4clM5RlhKdFQv?=
 =?utf-8?B?RXE5U0FxRmxBUHBpWG5yZ3pxSzdOdVZMbUppMkpwOGVUVzhpb1l5bW9nMjdJ?=
 =?utf-8?B?QmJuMWhtQXVHMmx0cTN3alcvUWhIdlh3WE5PcVN5V0tRaDJIUmRJMUFkQUxr?=
 =?utf-8?B?L3ZsV1I2QjFzTGdnQ1hSbFVNOGt2T2twOHc3ZmVPK1l0ZjgxN2xmVFRiMkFB?=
 =?utf-8?B?TTc2SDdGQnp0UTR6SnFzYVMyNVhPTExISlBPSVY1RjVGSXZ2RUdyT0VBU29l?=
 =?utf-8?B?c0Era0VLellNdDFuTTRudkZJSW4rRE1BU3lkajZBaUJHOUlKc2pWa29Zd0h6?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b01e8ddc-e853-4ed9-245b-08db0ddd910e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:15:47.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRXaUXGxkejcFUh7l7eO+AdrqkadGKvllDs2dhkVxNocYOGDS2nxbdOPryr18szDBkYIl03KVXsh5Vzpycoy+w8K8vBfR+9PmS8s1QI59W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6512
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 17:08, Marek Vasut wrote:
> On 2/13/23 16:58, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> This fixes the LDO5 regulator handling of the pca9450 driver by
>> taking the status of the SD_VSEL into account to determine which
>> configuration register is used for the voltage setting.
>>
>> Even without this change there is no functional issue, as the code
>> for switching the voltage in sdhci.c currently switches both, the
>> VSELECT/SD_VSEL signal and the regulator voltage at the same time
>> and doesn't run into an invalid corner case.
>>
>> We should still make sure, that we always use the correct register
>> when controlling the regulator. At least in U-Boot this fixes an
>> actual bug where the wrong IO voltage is used.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> I may have a kind-of obvious request, since we removed those SD_VSEL
> very recently from other boards, could you just revert all those patches
> and only fill in the SION bit in V2 on all those boards too ? That way,
> we fix the LDO5 regulator for everyone who used it before.

I thought about that, but as the SD_VSEL signal is controlling the LDO5,
I found it more useful/correct to have the sd-vsel-gpios property inside
the LDO5 regulator node. Therefore the old usage where sd-vsel-gpios was
inside the PMIC node isn't compatible anymore.
