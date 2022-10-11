Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04125FBA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJKSat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJKSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:30:46 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771184F390
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1665513042; i=@lenovo.com;
        bh=sxjV5Aklivh+1GpA6ms9mBprbpXBpHn6XvyD1DSVA7c=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=qKXP7nfrk3MsmZjOgqOEHU1xUedeWPmtjYAOJ09fVSLZkScvrQLDr6ER4AEksk6vn
         5NNZNtAO/sqz6lSJp7UXJePVacRrjKbmwTdaHa6DjP6Z+/GMOh2smFrvNptY+Sh7LG
         qVbkNrcoZSg2Q5i4QbB4nMLKyDQ6L1cMlOpTGVgIWllwDS6jAOu0vXO/VwZkWOCIf6
         pPBVovPKU+HRAPpRn4MAE6YQ+JsUa7mbl5+gF4HcXfYuf9Wztb1GSAJrqx9oZVIfVz
         0sYSslNLmxgUFlzHwLJqhnPCB916tEIaz3ldMRMhaXzt611CXKHkMwmp5cUimhoAjV
         2Uuyw/wh8Tlyw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJsWRWlGSWpSXmKPExsWSoS+lqRu4zTX
  Z4E+rmsWVi4eYLKY+fMJm8e1KB5PF5V1z2Cw6d/WzWnzevofZYsP3tYwWt7oWsVt83zCf3YHT
  Y8PnJjaP1kt/2Tx2zrrL7vG45wybx6ZVnWwe+94uY/NYv+Uqi8fnTXIBHFGsmXlJ+RUJrBlP9
  x5gK7gsXrH4xnfWBsaPQl2MXByMAkuZJfov/WeDcBaxSjyY+pcJwmljktg27w4LiCMkMI9JYs
  2uD0AOJ5BzkEniTLcNiC0hcJxRonuVO0RRJ6PE7q0/2CCcSUwSGy8uZoZwnjBK9H98wArhPGC
  UOPPhNDNIP6+ArcSzPYfAbBYBVYmm2zcYIeKCEidnPgHbJyoQKbFv5RmwZmGBmYwSqy7+ZgVJ
  MAuIS9x6Mh/sXBGBz4wSSy+ehTq3gUmi4cgadpAqNgFtiS1bfrFBdHhLHLj+DszmFIiV+LLlN
  lRcU6J1+292CFteYvvbOcwQrypL/Oo/zwzxqrzEvlUHWCHsBInmKUcZIWxJiWs3L7BD2LISR8
  /OYYGw7SVaVp2AivtKPHm7DGqOjcTbG1ugbDmJU73nmCYw6s5C8vUsJM/NQnLeLCTnLWBkWcV
  onVSUmZ5RkpuYmaNraGCga2hoomtmAWSa6yVW6SbqlRbrpiYWl+ga6SWWF+ulFhfrFVfmJuek
  6OWllmxiBCbBlCKX7B2MrSt/6h1ilORgUhLlVelxTRbiS8pPqcxILM6ILyrNSS0+xCjDwaEkw
  au5EignWJSanlqRlpkDTMgwaQkOHiUR3vebgdK8xQWJucWZ6RCpU4y6HFe27d3LLMSSl5+XKi
  XOy7oVqEgApCijNA9uBCw7XGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzPt1E9AUnsy8Erh
  Nr4COYAI64uRVJ5AjShIRUlINTN7Kqk+0WfYaCHMfbZ5VsSx3z/OD5UslHW6/W7DNeZJgq4p+
  JXv1mcONTyYeiJjGv+XQ8XfN3tZnrurkMzWEKbSelPfMP7rle4O6DV+5J2Mv75GjKvp9UVdOS
  37L2bSmK4vF69ZxL/9PojYxeowe1h3/o7cs7TCylH1Uto+lJr5rslHlIpt5m3a5nT10NeNh1R
  qBjveX97t/tVTdkt/y7HeJwKIdfoFLZwRInVq0netmSyfPdItdh6r4GNTnf5+/vqlNxuxXY+2
  txesnC20y6pJ+FGXybX7k54ufry4/+49VcMKrCRudZv5dcP1e81nV5C0tJWcW6gtstk//xR/r
  9vNTz7FtL16fs7iusvj61VlKLMUZiYZazEXFiQAYadMtiQQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-2.tower-715.messagelabs.com!1665513039!408909!2
X-Originating-IP: [104.47.26.41]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17156 invoked from network); 11 Oct 2022 18:30:41 -0000
Received: from mail-psaapc01lp2041.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.41)
  by server-2.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Oct 2022 18:30:41 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUjqDylr7K0ms72i1Y2mnIPUwuGT7FC5RztuOTMdYs+DB1+A9g3oMScLEyDa6DZDKc2w5yRO7TG+PQ3D7dWXyLdirPFi9C6TL6svG0VCaSxBoT/P7v5zKEHn+CpO2qo1/Sa4xKNwU7JhMpouxcDLgWkIwaM4g5JuwnGG4hkn4iv0OMcwQHlTIXubn40Tu1XFqtjDjLfcusEJBfs6Dn+TCa6pSbcRQYv/QMHH+OT26njPykGTF3KKTO2/HmyN9TIVaDAk3pur9veORIlzFaj3kpZ/STHXqV6WSz27gI1/4K2R5Z0/GfzyIRLVHy1hyW2HQxE3/5I69hDSQllabv6K3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxjV5Aklivh+1GpA6ms9mBprbpXBpHn6XvyD1DSVA7c=;
 b=Cdd8eCww1TPI7iUPC4QmJX3nUxbEJdnhkAwuaCpr4Rp4nq9po294hEFanpE7BYdORebQc7S2G/nr/PGKDuoaT8yBE7BMugFABO/CiJOIBeiPicbdZEoNEWfsmkKNecHpHdtOcbUyyhEQQpRp8oKW0IEXBIJ8akiPiI6MvHYxO1eelPBz7aMxt7MKWSO4ewJjdS42tPnH3OIb2vg2M3FoYdI6pq7tojbFsE+byz+jkFj9Io4PHMzGRxq6OieIbRh+6srM/nPoju3R92otQ8cxbxFvDkY1deAt0YkO5uOg1cIB/GN2oytHDzzkZx7rcY77+ogcY1CYkliVHcVL8j4G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from TYXPR01CA0053.jpnprd01.prod.outlook.com (2603:1096:403:a::23)
 by PUZPR03MB5824.apcprd03.prod.outlook.com (2603:1096:301:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.14; Tue, 11 Oct
 2022 18:30:37 +0000
Received: from TYZAPC01FT052.eop-APC01.prod.protection.outlook.com
 (2603:1096:403:a:cafe::70) by TYXPR01CA0053.outlook.office365.com
 (2603:1096:403:a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Tue, 11 Oct 2022 18:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 TYZAPC01FT052.mail.protection.outlook.com (10.118.152.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 18:30:36 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Tue, 11 Oct
 2022 14:30:35 -0400
Received: from [10.38.96.52] (10.38.96.52) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Tue, 11 Oct
 2022 14:30:34 -0400
Message-ID: <8c7cb257-3e88-e299-5e92-a44cea06d771@lenovo.com>
Date:   Tue, 11 Oct 2022 14:30:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Fw: [External] RE: [PATCH -next] ASoC: amd: yc: Adding Lenovo
 ThinkBook 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        <xazrael@hotmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <Syed.SabaKareem@amd.com>,
        <Vijendar.Mukunda@amd.com>, <renjith.pananchikkal@amd.com>
References: <MEYPR01MB8397A3C27DE6206FA3EF834DB6239@MEYPR01MB8397.ausprd01.prod.outlook.com>
 <MN0PR12MB61013CCC5DD10347C3FA3EECE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
 <TYZPR03MB5994C7FD8582F831A69055DEBD239@TYZPR03MB5994.apcprd03.prod.outlook.com>
From:   Mark Pearson <markpearson@lenovo.com>
CC:     <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <TYZPR03MB5994C7FD8582F831A69055DEBD239@TYZPR03MB5994.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.96.52]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT052:EE_|PUZPR03MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 447c8877-2a64-4267-8236-08daabb6b127
X-LD-Processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZbWKv0LjuiQ8vWzevhjLGOaHX7rkIglf9y4d5BXRguwDyTjS4YYaEpaU8yiZviifXGIXDJu5E3vQPw+hTKMSURnbPfMmhq/iOpTtfWK8FtX16T2b5svr1neYWzD0DaRa6ikfNn0tP25Ht5zQu61jGw8NHufsq5u54IWgOjtm1BzYmozNhKGmO8dNUD4PFkVw84IA9oloThOiIXP/JXe9c1lc7tafmZnBj03HUr2A8HT6CMEfQR2xDt43g3VJpoZZ9E1v+eiMWUxZ4SFRmWxOhWrOWA+OK/zCgds1ai/hcBFiGB8JpigNBRT4JfNwx6DKiQy7RTuBskGu9SiLWZPFHZt5zNBPBIdjhf4swWR4V3us6PIXxxnMk+qoR1K5nSz9v3R/k2XtE2YiDZOp/JJ3OoBOUmhKmTo1FJgsBkT9xeBmuKA0YmFzt6r7btPFoIDfotnMpejQsXrCFqZDx6LZZZIaig3hz/D/uIhoEg4MAtPsvKOtcvPkJ/w5650g9C3BCM89JjhyHzG9/tbcyaSgK4avh1pDFuMG+eEMQAcn5YbLYwNt1KX3J4ibVjdVbvkw4wk5OqQ4Q9BXJ5D+xn59ZNeOFq8kkE1/8ocWgOOw0E+NbGjaTkoFf3AttTdnUUeayO4leUVFjMV9x9CqzLVVFhmibRo9B0SuxoKVV5sIVVteSjzVzYA+ctxum6rRVS7JkiXvoGl3Rc4Znu68SbHGun3zQrsv4sT+eZw0gGRnYRzJq/0v/WmpYU1BLpNTHBbA1WKMMp7CRgXWtkD7dRc+fu9Y6Y2QMCUjOGKsWwy2F6Au+3jkcI0OG7QjQmUty1IHSg5cyPlXNqufq0NNU74meAZ4oDTOl3ywtO7Q0RZVvdjyZaM0JHPzWrzYvP+FGQa
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(31686004)(316002)(16576012)(54906003)(5660300002)(186003)(40460700003)(16526019)(82960400001)(4001150100001)(336012)(70586007)(26005)(70206006)(31696002)(36756003)(86362001)(82740400003)(2906002)(7416002)(81166007)(2616005)(45080400002)(8936002)(40480700001)(8676002)(4326008)(83380400001)(36906005)(478600001)(110136005)(82310400005)(32650700002)(41300700001)(36860700001)(53546011)(356005)(426003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:30:36.6995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447c8877-2a64-4267-8236-08daabb6b127
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT052.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5824
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<moved to my more open-source friendly email account>

Thanks Mario

On 2022-10-11 13:14, Mark Pearson wrote:
> 
> --------------------------------------------------------------------------------
> *From:* Limonciello, Mario <Mario.Limonciello@amd.com>
> *Sent:* October 11, 2022 13:08
> *Subject:* [External] RE: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 
> 14 Gen 4+ ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
> [Public]
> 
> Cc:
> Mark Pearson
> Vijendar
> Syed
> Renjith
> 
>> -----Original Message-----
>> From: linkt <xazrael@hotmail.com>
>> Sent: Monday, October 10, 2022 21:52
>> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
>> tiwai@suse.com; Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linkt
>> <xazrael@hotmail.com>
>> Subject: [PATCH -next] ASoC: amd: yc: Adding Lenovo ThinkBook 14 Gen 4+
>> ARA and Lenovo ThinkBook 16 Gen 4+ ARA to the Quirks List
>> 
>> Lenovo ThinkBook 14 Gen 4+ ARA and ThinkBook 16 Gen 4+ ARA
>> need to be added to the list of quirks for the microphone to work properly.
>> 
>> Signed-off-by: linkt <xazrael@hotmail.com>
> 
> This patch alone makes sense to me.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I think it should go in as is, but it prompts another idea to me I want to run by
> Mark specifically..
> 
> Should we just drop this whole file down to a much simpler DMI match prefix like 
> this:
> 
>> +     {
>> +             .driver_data = &acp6x_card,
>> +             .matches = {
>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21"),
>> +             }
>> +     },
> 
> That would allow it to match all the Lenovo Rembrandt systems presumably and
> can stop touching the file.  This only makes sense if every single Lenovo 
> Rembrandt design
> uses a DMIC from ACP.  I don't know if that's a valid assumption and I think we 
> need Mark
> to confirm it.
> 
> The DMI match "technically" would match some of the Intel systems from this 
> generation
> but this driver is only "loaded" on AMD Rembrandt systems, so I don't think it's 
> a problem.
> 

I love the idea but I'm a little hesitant as I don't know if I'll be
able to confirm it authoritatively - I don't have particularly great
levers to pull on for platforms outside the Linux program. I'll try -
but I think chances of being able to reply yes or no with confidence are
limited.

I think it's relatively low risk for breaking anything on this years
platforms - but may get more interesting for next years. If needed can
we then just quirk any platforms that come up that need the logic
reversing or does that get really messy.

I can confirm the "21" match is going to be match a ton of Intel
platforms. For the AMD platforms - will this be limited to Rembrandt
only or will it affect any past/future generations?

Short answer - I'll see what I can find...but no promises

Mark
