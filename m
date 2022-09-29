Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4C5EF5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiI2NAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiI2NAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:00:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F4A99E0;
        Thu, 29 Sep 2022 06:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S41erJIpovMWjaNN+afEviyV14J21D2cchzUlHXHdckxfZeEVRECKG5rdY+VA1JbxV/ibiJ3XhIuv0zI/D4vPHUVoIQNIWM65xd+UE0vASLUffF6WOoS6kd2nqM3hQTHGEVirn468LRpgNeyWzvEjz2wQC/pYcUQeWtrzwW3zJHan//Vp0cfNb8Cgx0t73MJIocjfSU3fl/9HVBz4N8DjBJ7Ak4fNClDwH7lwtJrkUPFS5vbaU0kEwkjzASYzrcGwIvZFeTw22m7n0j2o5yZJlxzpagN7KbsfRQGwo9xuqfVkLdwDCA6RYaG0auwCBXQqPqmwck7fLE1+TXoRfnk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajo+6cjQOMP/K9O6eDUKeRN1SiGqpWep6/oXBVhc0zs=;
 b=fISVKFksz0Wjb+p+xAdSAs7mS6uUjpzee8XW2SGK3RSlWxj6dZFNDcaJ6aBZG+aX6Sa7slNd4QCacRRkBdQe3efIj0LtU4HSsRZsFRD6rAqQojRvOgDSntyJLW1UDLF7ebpfOotiUIthpsdx7PJ52tW2VT2fzTFxVV3+7ziaQ+5FEVEGPbo2r+ZpmfzWF9iwqYB2lc0A96o3ckp0ReZgcq0AGGu7FptU4FISAF+NWUjp2XrCXcMqG/htGlk2qyRgF/Uat7PDRrTnvLD/MK4leghanokf3GVpi6mkjPRCrbcLuv6rKFAgz449iMSfe0b7oiA+/kShPYxCEmuHIuA+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajo+6cjQOMP/K9O6eDUKeRN1SiGqpWep6/oXBVhc0zs=;
 b=1ckPQtwAeufjsoFjQfjXPeO2W9XIj7HiARq6HWQ4w2PKEkn+JkCavctm/8+mWSosaO5wlHd3uQ0o6XL2GSZMxxz5T8yh1UNG78vHaxULUnU8Wo46V0QukW5RpYU2P5oGE9kS66G00OnXgyuNtiq63aACgKzMa/FkCsBCuW8rmM0=
Received: from MW4PR03CA0056.namprd03.prod.outlook.com (2603:10b6:303:8e::31)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 13:00:12 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d5) by MW4PR03CA0056.outlook.office365.com
 (2603:10b6:303:8e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 29 Sep 2022 13:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 13:00:11 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 08:00:07 -0500
Message-ID: <e49153f6-d1fb-bbcb-f713-5af7e145e052@amd.com>
Date:   Thu, 29 Sep 2022 14:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <geert+renesas@glider.be>
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com>
 <20220926230438.GA3128861-robh@kernel.org>
 <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com>
 <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
 <5a037955-4832-e42a-eb58-719ed4672395@renesas.com>
 <20220928234137.71ACEC433D6@smtp.kernel.org>
 <a89b8124-78e2-f9a9-c3bf-1e30687127ca@amd.com>
 <CAMuHMdVrQJaBmrWoMp7EFNFhEpamp7qZ-eKqyChVNvr5=BPCUg@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAMuHMdVrQJaBmrWoMp7EFNFhEpamp7qZ-eKqyChVNvr5=BPCUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a21f52-30d3-452c-d276-08daa21a8b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRDI8eAbeM7LD2u74e5axirNYjMfQ38agZoErYPbnN5USDfVq2GFNetGp/jwNM6it7ovVa7uNHCDP0Vp5cERvCi0lNW9XSKT3uTigwah6okCZeA8ARh48BMZeXcUWRcGeX/EdHhylagshOUN78C554j/c0onEsJ+NrzgcZjUj+z/rPF1Y5I2ux3xsTnkAEEipStXUfRf3DeYI8KRsXZONPKD9XGX/NmKK+nKJW/YkYxq5eWe+s7fn2Cmj3FBItt7oDEJhVKnLTIHmIQEK/X7yAQVXD2cW6dd5JVpw6uCVrGHab1VIcNGOR4VFCFJbTzqPEEgmJ8EQyo3LqssOc+g+/NNcvpPFnfJYxPXrD5xA/5XWOMY0LMhiuLHR15zrXI5ZiOkHQ7tJV0vHwdhDXP08lIK976FG3Y6Z81Y5WC9PBIvJ832xi8+EcxIsjInnrWBllcV6xGiGEaAwB7XTR6daPcHlzjyXKoDj63jVfV+IPDQ4bi9j/+uBjaFw9ut/chwgpixBJGTo9gLtWq8k7+iI73Nkrk7CJGgNXQwmVqnS7nUMgmGb11Du6pViHtO30JlD63k8T6lhxwwhQgO8iCve4QHbkmTZVZ3grwu4uNCIjCmHUZJpZHVuNQK1gJ1NTjb9aY6obaOBblGc0eF4WDKmRO7HPsfv2IWHZDBhT86P0HsrchW6zAC6p/VN7ORRigEFiXHREvaRL+pZyRLT6AnOAGP7+Hd51FtGfnZa6Gf4iyTTT9R1tdWGlrfzmZyZv/6T9mQWyormjFznME8sORFp2nL+YGwTQnHtSfzCOpoTqGwZ0RRSOtbFD+llWAE31C2omTVWxE5a9Z7+IBugZKKtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(6916009)(316002)(16576012)(31686004)(5660300002)(478600001)(4326008)(36756003)(6666004)(82740400003)(41300700001)(31696002)(2616005)(336012)(53546011)(26005)(186003)(16526019)(8676002)(44832011)(70586007)(70206006)(36860700001)(426003)(47076005)(82310400005)(40460700003)(356005)(86362001)(8936002)(40480700001)(2906002)(81166007)(83380400001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 13:00:11.5462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a21f52-30d3-452c-d276-08daa21a8b5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 9/29/22 14:20, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Thu, Sep 29, 2022 at 2:01 PM Michal Simek <michal.simek@amd.com> wrote:
>> On 9/29/22 01:41, Stephen Boyd wrote:
>>> Quoting Alex Helms (2022-09-28 16:16:04)
>>>> On 9/27/2022 7:51 AM, Geert Uytterhoeven wrote:
>>>>> On Tue, Sep 27, 2022 at 4:10 PM Michal Simek <michal.simek@amd.com> wrote:
>>>>>> On 9/27/22 01:04, Rob Herring wrote:
>>>>>>> On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
>>>>>>>> Add dt bindings for the Renesas ProXO oscillator.
>>>>>>>>
>>>>>>>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>>>>>
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>>>>>
>>>>>> Driver is also using clock-output-names which is not listed here.
>>>>>
>>>>> ... which is deprecated, and thus should not be used by the driver
>>>>> at all.
>>>>
>>>> Can you point me to somewhere showing it is deprecated? It is in the
>>>> current dt clock documentation.
>>>
>>> I wouldn't say it is deprecated. Instead, it isn't useful if you're able
>>> to use struct clk_parent_data and auto-generated clk names.
>>
>> I am not closely doing clk subsystem but these chips are clock provider without
>> any parent. If you mean calling function like this
>> of_clk_get_parent_name(client->dev.of_node, 0) then it should return null.
>> But maybe there is something else what you are referring to.
>>
>> I see that fixed clock driver is using node->name which is also problematic
>> because node name for these devices on i2c will look like clock-controller@XX
>> where XX could be the same when i2c muxes are used.
> 
> Indeed, drivers typically use the node name or the driver name instead,
> but that may cause conflicts in case of multiple instances.
> So you best append ".%u" obtained from e.g. <linux/idr.h>.

No doubt about it but with 20 clock providers on the board this will be quite 
messy. And I expect idr assignment will be done based on probe order and can 
change across boots.
So far I am filling clock-output-name with human readable name to clearly 
identify what certain clock is doing. Instead of remembering that clk.5 is ddr4 
clock source, etc.

> 
>> And in connection to deprecation. I see only one file which is saying that it is
>> deprecated.
>> Documentation/devicetree/bindings/sound/samsung-i2s.yaml
>> and it was deprecated before yaml conversion already.
> 
> It was deprecated long before the introduction of json-schema (2015?).

Then I think it would be good to mark it like that in schema to have clear 
message to everything that this property shouldn't be used..

Would be good to have any link to that discussion but not asking you to waste 
time on it. But I would be very surprised that no driver was merged from 2015 to 
the tree when I see also 2k lines in DT in the kernel with this property. It 
looks like that it is quite popular.

Thanks,
Michal

