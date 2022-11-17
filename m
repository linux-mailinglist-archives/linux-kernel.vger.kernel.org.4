Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21B62DCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiKQNdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:33:23 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB770A3A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+qBLtn03a0+ndnHWxB90txpYFAiWylJqiOBvX/6oEQ2CIAGudvmD2D+L1lTgnCF4+J4DfIBgnKvxruHtCGDnOq8j/ChPLNmFNbRPaCALFaiVxjAtK6SIgAWT2Xwot6lcNeJ80X9C72nvGKOa5r4IAzf96TWNFp5BXL+Pwy4hWOvn+q3yFtSBu1xebkCcAQaJwQO4PV+Rl7XJJaPMieuWtT3Y69l5FY6nt+Rj3ih0n+GvK5NoxnnP2s1344CkzETK77S4uJ8be0f1qQSh9+NnDDFxHb+pndWfQqr/7HBWREs4gwhcczulrS51+aYL8R/T2kdzcYPjbVQgV5nyl0QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ogx26bF65DqYPWtbZlo99oztsooSlTMopXO4O6WJnE=;
 b=eL/2/9+G7Hl//x8eIWIGwk5P47F3NihfEfyEwW8uKSH4dVGtZ5/9y4AflHykHkKUsN5YlQJe8Tkuli9HGgY7Xz3LbPo+pkaGBEUSE5JDSkEZo5YMsxl+2BmcIfivFK9QH0jCMXls2X55qnJyKD1SnwXfOTpO8ABzynKQau9YPeYnSpeH40xcsE79U2M2YphrtSTeEvWeSnDJ4WbT+PZCot3qeNpXAu+9mNLJ/R/rK/qJcavYKHepUucALe6FcJQin7DuIA9ZLUljcSCUAvt2S4vXVckBXyIaiHS400gXeTGD9SogL9JwdJ/P69zUJh5V5kbB5Rjo6JbmZA8oEiuPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ogx26bF65DqYPWtbZlo99oztsooSlTMopXO4O6WJnE=;
 b=V7NaT7apK8kVaIDtdtiBjUmHCZJsrPjcAUZB5myGIn8oIZcVC/RnJ2ExgqbOXvF56YddOou1U6WJGxhOPubQgLUkyI8UtHwmtAnc0is9Bvk2wIAdZ8E9SJHltWgl8UT9gNKDTJn0yCe6VsEVrTRfJQ9tJtcPj9/tmn65iQJLTrWLCHN0E6xiIKyuU810o6zNjGTFOyZnHwGZhbhu3fXYK9rSzjGpGib7vjd6DmSq9jm9e50RaJOVdWMITegdmLllSq2qQrkKqX78HxR4+gAOLvAo26APz64xR8L8e29HZxVThLfGW79GxbPRMcsQvPruA51BbYLm1jsqnd7BmT9VgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM8PR04MB7971.eurprd04.prod.outlook.com (2603:10a6:20b:234::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 13:33:17 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 13:33:17 +0000
Message-ID: <a84234d8-9f48-4b8f-e171-599c34840581@suse.com>
Date:   Thu, 17 Nov 2022 14:33:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL bit
 is cleared
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>, David Vrabel <dvrabel@cantab.net>
References: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
 <0afe3f35-1b25-d1c6-89bb-8dae7a4070e9@cantab.net> <Y3YzY0aUc42cQGk/@mail-itl>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <Y3YzY0aUc42cQGk/@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM8PR04MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d888d9b-49b7-4b55-6932-08dac8a0493b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR0Nsdkf6UPFGVUWIopx/RwdcHK6zHtnpNFUD4cGaGmAh3M5SHQhu29/aQdTk7x6jHhHUwmXF90DBrjca5r4Yp3bOKbmb4EVtyCvK2LHZ/wv9DVFnxE8PLkAHj9C+PeCUED8FbgZCEAT/A+lOqrAgUCkoYFgb39i2rXs1cW4r4VGQxu95aS0uzqQ2RdXJUmfzG5ykJxB4t7bEvxTIIZvUG6EkOGAhuVq6o+YqpyU5MJ/7w/9kRzmoiyVJ2puhpiGnJn6IPd6gOU9WPQGnTE75QH2mBBWh6KmVDCfmwiGsoVGP6BaC/gghzUefADAbCHyQZgUTe5JgmTxVqOCYGRfDWG9rVq5rEiA1MsogvvWQtmnBREXlMXPYTsMH6nhrW9ikJOjo9CcMukUbKFajW5wzsSZc2mLRy+avNT2yHeC9R644CjuycpyIgjM77ZVPSeugeV7OeQ9tn0YzmlRVDw0moHFCS93ZSu49dV428Zta+8mmHM2WJhA9iDrxjDRDlFZWliNEvnwGebx7PcPgwGDhl3X4S84NKjAgOf2QUQ9k0s+eYkeZVYAxvUfXhzbE5vZHkLGET5HNEQfQ3H7cczREsihQrQmYnrhjcbn+7RvEopQjPKalnr82IrkVFyMlixxRt5WHTQK72iE6O5VqWfHGUWsOJBgQdictFWEGuZ2C8JkdCdLJB6pgRjHWZm6O1+WePs9qXl/kUbMeeAEKCsdh7FU7YNIRm+L24i8I2aoBr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(2906002)(38100700002)(53546011)(26005)(2616005)(4326008)(8676002)(31696002)(66556008)(66476007)(6916009)(54906003)(66946007)(6506007)(36756003)(6512007)(186003)(31686004)(316002)(5660300002)(86362001)(41300700001)(478600001)(8936002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnVnSUVPam5kTFJFTzBYY1pkTTdLbnNBTndOQjJ2a1Fxa2ZvOUtsQXRxeXRn?=
 =?utf-8?B?dVNwYm5hc2l5b0kvS2YxUmhwNFYyRHNKcEVabnNCRjIxa0xQb1o4MzRjNGhV?=
 =?utf-8?B?N2pIZXNaR0t6OHZuVERCeHppN3EzRWttRzRieCtHTk1mYTY5bENmY1dCekp1?=
 =?utf-8?B?TUdBUkJUeGJydW5zd0Rwd3ZDdVNITis2NG9UbTFMRzJtelU0V2xuQ0VXN3hs?=
 =?utf-8?B?cXlnY1ZqcXBQaXZ2YWxmYWgxZkVybXZoSE1Fdy91KzcwUGQ0YTMwM2VnajNv?=
 =?utf-8?B?Ly9vdXlUN1Rwd3VVVnM2NDFHazNLQzk1U21tdmM2Y1hkTXIxcUlIdzBNWlBR?=
 =?utf-8?B?ZStiaVVrZTVDN2FPaVY5Y3JoYVBWaHFBWEliem90QXpVcE9IQ3h3YWxVbTFK?=
 =?utf-8?B?L1pJazRGSVBaVVZaZXBhSFJUcnl6M1BVR1dPZko0VFoxTUc5ZmJJRWJEekhC?=
 =?utf-8?B?eHliU0lKVzcyYzVUVGNDcS9FQUlwVHE0Q2xYTGo3Tkl0eExVNWxaa3I3K0My?=
 =?utf-8?B?TmsxZVJzU1RDb2xyUk5rejlobVJSOGFtY0NUeU10aFdYQ1ZTWmRQbVdCOW40?=
 =?utf-8?B?R3VWdTg4eG5Zd2ZCYjB0QlFreGpnUWM2T295N1Y0T1FnZ2VaRGVvM1VZT3d6?=
 =?utf-8?B?YnRtUnBrODViQ3RYN0Rwb1E5MDRVS2JwNUF0VENSNkVKQ1o3cGNTZDhxWTUw?=
 =?utf-8?B?T1VXdFVzU0V2elhYWHVQQTFsYytlUnR2YXVrUEJxWEJGRmtNTDM2MUJhVVBt?=
 =?utf-8?B?VlY5blBsSUxZWW8xbFlTYnZ2TjlXRnhtaGhIUU4zQnBLbjJSVTdUcU01eXJJ?=
 =?utf-8?B?WHZXakVlM3E4OE5NblJjZlFjd002T3hIYnpkN3pYdDNIZzhsMEs4WG9mMTJx?=
 =?utf-8?B?T2svZ3RjOFRZNEdlaEp6MW1seWk4eTVOVml1d2VQRDlEendsNGE3TjNJQkd2?=
 =?utf-8?B?RjVxc0pjVFZ5ZGdydU1UMUkvdE01U2RXaWNYcUZmM3pIazcxU0FtWXJoMHc3?=
 =?utf-8?B?N1RremxCNmlUVFprUXZuWEN5UmxBL29TSEV0Rm0wTytaWENtQmJYNWlWLzBS?=
 =?utf-8?B?MXI1TDRRSVhJK1gyaWpZa3RYUkNjd1lVbjFGNEZVWVJnb0RSQ1BKSklmVmRR?=
 =?utf-8?B?UTcwKzgyWUxDanBldEVPWEdZUFplUU9aM3BoVUxBMVZWWVA5S2IyVDVpRDZw?=
 =?utf-8?B?QVcxUFRxVUI2U29wSjBCNC9iNHBDNHc1aW91NkNnQTNNRkFhckVsU1VwcWhN?=
 =?utf-8?B?SEcvRGx3T0FlVU9LNkhMVmt6WEFEYTJzOE1PQml0cXdFZTd0Zk50T0VVbnR4?=
 =?utf-8?B?T0JNTlV6bmYvamMrTDlJa2lHVHg4bGphVllZVnpMS0lGSC9ENmp4TW9uT3Jl?=
 =?utf-8?B?T2RhU1BNdzBJOVBFYjBmdXhMTG9uTDBJb3JRdGdFbU1rQTQ1YmZqQVhRem53?=
 =?utf-8?B?ekNZdGF0TmR3eFhiNTc0SzRYK3JTUnFhZVZiblByaGhNVjBKTHRNYVQvNFFh?=
 =?utf-8?B?NVN2OTF3Qnd1bnZhdC9JbnNqa2NPWUltdHlDSThzYi9CRjFwbVU2WS9Mc0Yv?=
 =?utf-8?B?QXZ5M28yc0tlT3hmNTh5aXljb21Eam5GRHMrYlFxaXoxakxBY0psTXJYZWgr?=
 =?utf-8?B?RjlaeVpBN0xhWktWQ25Na25EMk5vbit1VHQrZWY5dUt5SXNXQzlwd0pxMmlX?=
 =?utf-8?B?NENKZk12L2k5ZWZzYjFEUDRVc1k3alpwVStwcHdRWHFYbTUvYW0wWmlEbDlu?=
 =?utf-8?B?bUNJeDM5cHVkdVlTMzVWUE4rb2FzNkFEeUpXS3AzSDl6akh3eWl3aUNySFF0?=
 =?utf-8?B?RzV2Q0hlN2s3aXhVREFSQWRyaW95N3Era25qYjd5d2F2UjNZaklaM3F6bVho?=
 =?utf-8?B?UUp6UHR4YjhUSjFhVEE3NFowcnRiNzl1c1Z1TEJ4a1VPampDN1JZdFJ2a0tu?=
 =?utf-8?B?YmQxdTVPNDQvR0NMNEhHczhCZ3NTVGE2enk2bndPVTdubzFtNXJyaGxpc3Vl?=
 =?utf-8?B?S0MyYWFNblNpRFJmd0V0b1E3NFJmeFlvbHpEYUVuN1JwMmJxZE9yTWkyelF1?=
 =?utf-8?B?T1kwbUlNWkorTzhpREZXVGtoUW02RDVXNHB4ZHpkeVE2bVB6cEJhU1AzK1Nz?=
 =?utf-8?Q?cXz1tHgZwogKylfA5X6kEy998?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d888d9b-49b7-4b55-6932-08dac8a0493b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 13:33:17.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99vQkEgnb4jXBL1nbHzBLeD5edeAbb9R79vb7m2f5urie7131cN70xSgcOzXkOBNgEIUJeCC8Pbz5agHX29Xcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7971
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2022 14:13, Marek Marczykowski-Górecki wrote:
> On Thu, Nov 17, 2022 at 12:54:51PM +0000, David Vrabel wrote:
>> On 17/11/2022 11:41, Marek Marczykowski-Górecki wrote:
>>> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
>>> the table is filled. Then it disables INTx just before clearing MASKALL
>>> bit. Currently this approach is rejected by xen-pciback.
>>> Allow setting PCI_MSIX_FLAGS_ENABLE while INTx is still enabled as long
>>> as PCI_MSIX_FLAGS_MASKALL is set too.
>>
>> The use of MSI-X interrupts is conditional on only the MSI-X Enable bit.
>> Setting MSI-X Enable effectively overrides the Interrupt Disable bit in the
>> Command register.
> 
> That means the second chunk of the patch may even drop the '(new_value &
> PCI_MSIX_FLAGS_MASKALL)' part, right? 
> 
>> PCIe 6.0.1 section 7.7.2.2. "MSI-X Enable ... is prohibited from using INTx
>> interrupts (if implemented)." And there is similar wording for MSI Enable.
> 
> And this would mean the 'field_config->int_type == INTERRUPT_TYPE_MSIX'
> part isn't necessary either.
> 
> Jan in another thread pointed out that disabling INTx explicitly is
> still a useful workaround for a flawed hardware. But if that isn't
> mandated by the spec, maybe it doesn't need to be enforced by pciback
> either?

Well, allowing a device to go into a mode exhibiting undefined behavior
is what we ought to prevent when it comes to a DomU doing so vs overall
host safety.

Jan
