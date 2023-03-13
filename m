Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9956B815B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCMTFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCMTFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:05:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9F2917A;
        Mon, 13 Mar 2023 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4AzEJ3Qe17SXNhcHot0WSg36nI+ii6Koqy8OGe6p9o=;
 b=BacdnmFgrdIVt27D3HtciUzCrdFvWFLNdvkhlwOqSblQ9DLED9cxwmpfheIecaWhpwH2eg5XU0lkUO9jlFHUgWj7B6LsVxduFT3ONjcPAWyhIUy04U+9wPNZbcTm2/maVS+nOkZk66vUqCrzf+da7MUub2MwWWzv60x77Usajkwld/v5US22OtIrhzvhMfQNfWJVEVVCJnWO5Kveq8ojAkn8HJqRb2lwPtR6/j0gDEHobaVio6xIH5/vWYr5QQ8DDRUDouE32HRYv9XdTm2n+ShVnsFXMvV/IeLl6GzXRtbmE9mH3mvw0uXslGGKK8wTLm6CbzqUKn4vJnKhMnHM9g==
Received: from AS9PR06CA0275.eurprd06.prod.outlook.com (2603:10a6:20b:45a::24)
 by AS4PR03MB8155.eurprd03.prod.outlook.com (2603:10a6:20b:4e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Mon, 13 Mar
 2023 19:05:11 +0000
Received: from AM6EUR05FT024.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:45a:cafe::47) by AS9PR06CA0275.outlook.office365.com
 (2603:10a6:20b:45a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 19:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM6EUR05FT024.mail.protection.outlook.com (10.233.240.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Mon, 13 Mar 2023 19:05:11 +0000
Received: from outmta (unknown [192.168.82.135])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id F2F372008026E;
        Mon, 13 Mar 2023 19:05:10 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.56])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id EE28C2008006F;
        Mon, 13 Mar 2023 19:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDokef/eryNYyAMMyos6VvqVzByFcC+5E1VAZQk19lIiOK8AzTl1udn3ZUZH3GPU1VtnAzky7MrrIkqKpq9K6SWkHxIlmbjWL3OKVifxLRFhcCnPllIBXWRJa/5EoVs/QYkuzM2g+4u5Qoyj8Kg0Xno11RQuztTv+Jcbl+E+fe7LkHyB/v3tq8+Ib7oRdd6f8YlnGL69ORWSgO7H0GhX398xkvilt2PSOfOenWmMv0kZjh1vDyf+BsdrK5AZiKxhl+gXC9yn48N71wFNqbeyZ/gT8VFmo7r/6Ns3rOCEvvAQggequgPUeZxU/FFs2qkl1VVFfAInvRlRJWZ5lS4Xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4AzEJ3Qe17SXNhcHot0WSg36nI+ii6Koqy8OGe6p9o=;
 b=Hfp9jfI8jkf5dt3BZgWy13TdOCyjJH3WpHIWxcJGKmrX2ehzzuASIs9skyjyZfBpNDprrFsfqXdGxoMlu6z5xKeWCx6CH6DK3AUy5aQuKfOCPxxu8XUZRZUz8lOIaX2HPGt1pK3KuOY1qKOo+v5Aolq0QOFtK50FTsBdQ1tCELoX2vtPwu7QhA/RETPUmc4yhXF+5wAJN2IrV03rdJpZkHy7+HHKof+P3afGeXf8UEgimglXNNLtdDnJyJbKRbRtK6wbfFmPSAywcCg1JyOVJqJBz7cIehtyC6QRnbNt0nfb9604DnAVwjaL6ofIhRpGlVRJjMR8v/8xnGdWnA7lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4AzEJ3Qe17SXNhcHot0WSg36nI+ii6Koqy8OGe6p9o=;
 b=BacdnmFgrdIVt27D3HtciUzCrdFvWFLNdvkhlwOqSblQ9DLED9cxwmpfheIecaWhpwH2eg5XU0lkUO9jlFHUgWj7B6LsVxduFT3ONjcPAWyhIUy04U+9wPNZbcTm2/maVS+nOkZk66vUqCrzf+da7MUub2MwWWzv60x77Usajkwld/v5US22OtIrhzvhMfQNfWJVEVVCJnWO5Kveq8ojAkn8HJqRb2lwPtR6/j0gDEHobaVio6xIH5/vWYr5QQ8DDRUDouE32HRYv9XdTm2n+ShVnsFXMvV/IeLl6GzXRtbmE9mH3mvw0uXslGGKK8wTLm6CbzqUKn4vJnKhMnHM9g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB9591.eurprd03.prod.outlook.com (2603:10a6:10:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 19:04:58 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::dbcf:1089:3242:614e%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 19:04:58 +0000
Message-ID: <78417802-33a3-600d-ef5f-b1d3aa5abb4f@seco.com>
Date:   Mon, 13 Mar 2023 15:04:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] rtc: abx80x: Add nvmem support
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222214532.1873718-1-sean.anderson@seco.com>
 <e029e39b-196d-ee4b-318d-6dc950b2b26c@seco.com>
 <20230313183836e276d826@mail.local>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230313183836e276d826@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB9591:EE_|AM6EUR05FT024:EE_|AS4PR03MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 52aef03a-995c-44c1-1696-08db23f5dec8
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XDpq9YRp1jKklNolPnPJGkZ8nFPVLifGeW1SRMXh52LShOkTtpvzA3VC/bMsDtau/F7M98hrwsyDmdyFPU2fvAeRUNM4RHLyq7QuDy4GgRzyTYIi0+RfdcF/Irm7WjWjxZNcHUFsu5MdV4KLzKJIjcwbE84P7du219at86MeIayQWdBhAuf66H73d1s+q8G8vDl4f4n5lVCQw34zgSjK8aP1JrE6Ixc4VT8yIJod9Z/LoeXbegP616Paf+cvFTSHH4yzd92/w7kikS71OSkuc237YKsarLBsaXf6ZOUea13k0f+OiqMWcxbqi/dPuR69nK/l/VOz9497CUMuBrzSYwFOPRdzKpWr3oLRGI1CWXuqsD8g44FSz/neESoLL26ucVvPx93VKGn5I6Zto/eF7C5cT6WF1gWbw5M4yQrh532i3LkINCSoZhTAGC0MCYRuMHmNGNcG8gajrn5EK0D4a0i4wGByvXwI8xh+TAVJz+9f7xFaUF3cpBI53onYV+gCqQfleLjDYOlp5DjB93pRRYISKY8nm8jZsCmYohAsKGvvdzK09fwyI/M99fU86OXsUO1B6euwvqeM37EXUe5h/LYLY1ZlpFN/mceX/yc8PjGcrMqU8OQwxccjjbrVLYHY8eA0EiMNqck+q6yeqGm0ve7ytfV285sSjpZRJSmTn7UIUX07XWyZDz3A4mpMwg8ymtELjFSReVQ+5xzRWVOujNvY9RpB5qajZAsXjiLq7mOuTS2nCDMibLEugAYt1VAM
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(346002)(366004)(136003)(396003)(376002)(451199018)(31686004)(8936002)(41300700001)(478600001)(8676002)(66556008)(66946007)(66476007)(4326008)(6916009)(31696002)(86362001)(38350700002)(38100700002)(36756003)(53546011)(26005)(6506007)(6512007)(52116002)(6666004)(6486002)(966005)(186003)(2906002)(44832011)(316002)(83380400001)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9591
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cef5b3aa-979f-479b-d45d-08db23f5d6c6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJraNj+hpXkNtcRi5Xo/zdgTJHBJ89tYBdB5GwoX5ghnstlpS2mkTW2Dkn5taDupL9Kmj/z78sSB1+MQ+KjmnNumeWgBW4KukNXmNOFyZeL0phQMZqpIkdnc3w6wLQe9fiFaM0oq0JDnkKfiK8SM0rgExmsIPyLdQIGlWsshcK56kYCmgykB1N81zXLBrAyDHOwWFHlLnBhJCVmnRUNEr2sYjf359HDoAVbUOaybPUUjNCh0IpkYtB1qvvOI1IrdS3h6qZn8Z7+uf/bKuyK0gmkAHTEcMdli35xyH6e/W88mSq2ovmZWoe30cAnQJertVCeUULiqfZ0PlSkoiSxrihoWGQCAxyOqg6F80ZDcugCfuRZP3iVdW/2W8Ot01JbQo3dtT8ue1MfOe2s+wWo7bT/dtajHq055qvMrxkEQ+scumZ0LJyF8lERFnaUcgfNlW/dLMBnbnhF0Qvm4RANDDu0FU4+imPEfYT/VpbH3+7A0e9QA1c1U6qkbHRiotFWgeMn0wtLqOHiCIfNTXjJg/LHrcwwK2xRO/jIRAi2/WHvIWm0wRGFanpUrQoToLevhOlIbo4HvMGEc74tMbRqANZgZ7Xv30cS3XSTlIFrsz8HK2EzXrTnWWxjvm8p/WpXKuoYcrHYfu97qH20tkcTay0Jdw6RIIO0vPVtp0UTa8EjQFNPobkiQrtfDWN7er3ZbyMYhQbFo98dN802lP6eLYwLnCJF/sg45wzn27qnN+0ni6BBziLwTteHwX0k9g0Mh
X-Forefront-Antispam-Report: CIP:20.160.56.86;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230025)(346002)(396003)(39850400004)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(6486002)(186003)(478600001)(83380400001)(336012)(6666004)(31686004)(26005)(53546011)(70586007)(70206006)(966005)(316002)(6512007)(6506007)(47076005)(2616005)(8676002)(4326008)(6916009)(41300700001)(36860700001)(34070700002)(8936002)(5660300002)(44832011)(2906002)(7636003)(40460700003)(7596003)(82740400003)(40480700001)(356005)(82310400005)(86362001)(36756003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 19:05:11.4203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aef03a-995c-44c1-1696-08db23f5dec8
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.86];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT024.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 14:38, Alexandre Belloni wrote:
> On 13/03/2023 11:28:30-0400, Sean Anderson wrote:
>> On 12/22/22 16:45, Sean Anderson wrote:
>> > This adds support for the 256-byte internal RAM. There are two windows
>> > which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
>> > address space) and 128 bytes at 0x80 (the "alternate" address space). We
>> > use the standard address space because it is also accessible over SPI
>> > (if such a port is ever done). We are limited to 32-byte reads for SMBus
>> > compatibility, so there's no advantage to using the alternate address
>> > space.
>> > 
>> > There are some reserved bits in the EXTRAM register, and the datasheet
>> > doesn't say what to do with them. I've opted to skip a read/modify/write
>> > and just write the whole thing. If this driver is ever converted to
>> > regmap, this would be a good place to use regmap_update_bits.
>> > 
>> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> > ---
>> > 
>> > Changes in v4:
>> > - Remove unused variable
>> > 
>> > Changes in v3:
>> > - Use devm_rtc_nvmem_register
>> > - Remove ifdefs
>> > 
>> > Changes in v2:
>> > - Fix building on non-arm platforms
>> > 
>> >  drivers/rtc/rtc-abx80x.c | 77 ++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 77 insertions(+)
>> > 
>> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
>> > index 9b0138d07232..74ff820f5481 100644
>> > --- a/drivers/rtc/rtc-abx80x.c
>> > +++ b/drivers/rtc/rtc-abx80x.c
>> > @@ -11,6 +11,7 @@
>> >   */
>> >  
>> >  #include <linux/bcd.h>
>> > +#include <linux/bitfield.h>
>> >  #include <linux/i2c.h>
>> >  #include <linux/module.h>
>> >  #include <linux/of_device.h>
>> > @@ -87,6 +88,16 @@
>> >  #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
>> >  #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
>> >  
>> > +#define ABX8XX_REG_EXTRAM	0x3f
>> > +#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
>> > +
>> > +#define ABX8XX_SRAM_BASE	0x40
>> > +#define ABX8XX_SRAM_WIN_SIZE	0x40
>> > +#define ABX8XX_RAM_SIZE		256
>> > +
>> > +#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
>> > +#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
>> > +
>> >  static u8 trickle_resistors[] = {0, 3, 6, 11};
>> >  
>> >  enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
>> > @@ -673,6 +684,68 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
>> >  }
>> >  #endif
>> >  
>> > +static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
>> > +			     void *val, size_t bytes, bool write)
>> > +{
>> > +	int ret;
>> > +
>> > +	while (bytes) {
>> > +		u8 extram, reg, len, lower, upper;
>> > +
>> > +		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
>> > +		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
>> > +		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
>> > +		reg = ABX8XX_SRAM_BASE + lower;
>> > +		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
>> > +		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
>> > +
>> > +		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
>> > +						extram);
>> > +		if (ret)
>> > +			return ret;
>> > +
>> > +		if (write)
>> > +			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
>> > +							     len, val);
>> > +		else
>> > +			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
>> > +							    len, val);
>> > +		if (ret)
>> > +			return ret;
>> > +
>> > +		offset += len;
>> > +		val += len;
>> > +		bytes -= len;
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
>> > +			     size_t bytes)
>> > +{
>> > +	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
>> > +}
>> > +
>> > +static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
>> > +			      size_t bytes)
>> > +{
>> > +	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
>> > +}
>> > +
>> > +static int abx80x_setup_nvmem(struct abx80x_priv *priv)
>> > +{
>> > +	struct nvmem_config config = {
>> > +		.type = NVMEM_TYPE_BATTERY_BACKED,
>> > +		.reg_read = abx80x_nvmem_read,
>> > +		.reg_write = abx80x_nvmem_write,
>> > +		.size = ABX8XX_RAM_SIZE,
>> > +		.priv = priv,
>> > +	};
>> > +
>> > +	return devm_rtc_nvmem_register(priv->rtc, &config);
>> > +}
>> > +
>> >  static int abx80x_probe(struct i2c_client *client,
>> >  			const struct i2c_device_id *id)
>> >  {
>> > @@ -824,6 +897,10 @@ static int abx80x_probe(struct i2c_client *client,
>> >  			return err;
>> >  	}
>> >  
>> > +	err = abx80x_setup_nvmem(priv);
>> > +	if (err)
>> > +		return err;
>> > +
>> >  	if (client->irq > 0) {
>> >  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
>> >  		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> 
>> ping?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-abx80x.c?id=e90ff8ede777b98b44611b416b1ae6be94258335
> 

Ah, thanks. I never heard anything about this so I assumed it got forgotten.

--Sean
