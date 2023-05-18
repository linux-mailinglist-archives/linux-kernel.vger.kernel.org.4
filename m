Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5187087D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjERSbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjERSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:31:31 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F8D10DC;
        Thu, 18 May 2023 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mni9MiuIiPGIUr7jISvPD1bkM7SMkmuwVcuGaZN+hBE=;
 b=TZiM6+xzKHkcxgHcVMNcl3IEdQgz9gc2Dr2LS+Fq1BmBkhdqh+kO9jglQ2To3Aq9mr+mLUU+R/mAzdfedNzQh+Z9fVJUcgYUW/2pDdjK0hHYJtcz/osnUJgrRhdlSGWq6pJuPQ3e/sn+K9VHDORY5Qn8c3ZaYJPR1QnxckDvZN6oL8WC0Xf5gKTVGt2XOxXZU2g1E5rJ00+zXX1x/PnimH2x54Q7mVF8u7BTi71he82UrZ97DlxQjyljsbWjBdOwHKjHWm3uGgE3uH6MEC58oHuUMZ6KmgIfnrVN+xKVGbcufrpoQIXHnE7p78H0Oa9kdfbyKoUrNQ0YcXNvlauboA==
Received: from DU2P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::28)
 by DU0PR03MB8342.eurprd03.prod.outlook.com (2603:10a6:10:3a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 18:31:11 +0000
Received: from DB8EUR05FT005.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::f9) by DU2P250CA0023.outlook.office365.com
 (2603:10a6:10:231::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 18:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB8EUR05FT005.mail.protection.outlook.com (10.233.239.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Thu, 18 May 2023 18:31:10 +0000
Received: from outmta (unknown [192.168.82.140])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 0F62B20081128;
        Thu, 18 May 2023 18:31:10 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (unknown [104.47.51.175])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id B19DC20080073;
        Thu, 18 May 2023 18:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoU6K1tv9gx6K0awPShqgov3VMnFlY057cSBd3sJ7L6UKwYdqDpHHdpmcc5VazV2IOiD5IFyxFd9HRK1uHR/Jsm7l3/UwvZyAEq7TV8yopvjJ7+/qkWHWkkcVajbgDdjklreX26J0WPvQIiYUjh/qgfYUjdHCOcRSAE1cwU87tRH2u8jlVFP4tlwInyxIWkwyYnnRFtHI4fwPZtc2DrnfUY4KP1Y3gGkq1WeCxdCDAh2ffzqwX8PRPhWzSVlgu6oBnfJd6jTlaK1ohrVvUgEpRvckPIcbU/OuvUcbWM+lDrzUSf+iKUvCnNkRd/eLQiSWmWrSgsJKKnIYeJv13tNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mni9MiuIiPGIUr7jISvPD1bkM7SMkmuwVcuGaZN+hBE=;
 b=atxYYhzHqc6oDzAlK3fUCdGSl+6CeD6fJswsEwvJ2ETG9Jyc5FPKOH3UMuo7y46uLCiKPAEj4t8uYZRYAhCU36nbzyE75Jp0EOMDAnbGv/mz/LXCeJr64EB+txWoavUepg2crtNFDfAe9/Epwr7R63gnwyTKx0+vxrJhjVznvjWX2eeAZGCjAkTiwWYCZHWn4tO/aG4cKaq9Yt5hxCfiAHCZXLLyLFo9DNG+wIgxO1/xv0hi0OsdGmGk+nM4OZVVB0DnPtcuVFpcHgwvhoQl8kd5Vt/68A/DIHLd1OZAdlv7z3zG4ICEFm+BdYpYVTr7gkMaMoHn50/jge0cKmt8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mni9MiuIiPGIUr7jISvPD1bkM7SMkmuwVcuGaZN+hBE=;
 b=TZiM6+xzKHkcxgHcVMNcl3IEdQgz9gc2Dr2LS+Fq1BmBkhdqh+kO9jglQ2To3Aq9mr+mLUU+R/mAzdfedNzQh+Z9fVJUcgYUW/2pDdjK0hHYJtcz/osnUJgrRhdlSGWq6pJuPQ3e/sn+K9VHDORY5Qn8c3ZaYJPR1QnxckDvZN6oL8WC0Xf5gKTVGt2XOxXZU2g1E5rJ00+zXX1x/PnimH2x54Q7mVF8u7BTi71he82UrZ97DlxQjyljsbWjBdOwHKjHWm3uGgE3uH6MEC58oHuUMZ6KmgIfnrVN+xKVGbcufrpoQIXHnE7p78H0Oa9kdfbyKoUrNQ0YcXNvlauboA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7425.eurprd03.prod.outlook.com (2603:10a6:20b:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 18:31:01 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::d632:8122:75f7:7b0e]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::d632:8122:75f7:7b0e%3]) with mapi id 15.20.6387.034; Thu, 18 May 2023
 18:31:01 +0000
Message-ID: <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
Date:   Thu, 18 May 2023 14:30:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>, palmer@dabbelt.com,
        conor@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230518-hammock-doornail-478e8ea8e6a7@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:208:134::19) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM9PR03MB7425:EE_|DB8EUR05FT005:EE_|DU0PR03MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8343e6-d81c-472c-cd36-08db57ce0d81
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EoEsg9koKbLFQEsCxZiQ7Ys0VldzAtWlNZnp/y7S3JjBI9DDnT2KS8i264+qsoYrJvZwwO3n6UY4PUERPIdqE81z3P6H86kbhBgPJdG4wG6otFSbH6ARYqqjUwSED9YN1gG6mN2XdkzHNmJ3jjwGyl/7bQTFRj24hv7xiibiQx7MOEP1bQz1rUBZsd1oxNXcigrFikYn6mhBQXKJL+iqFND3/emXrDv+HALs9WIUSMSmsffTlL+3my4gKbx0NDjJhAypj/wcy1MD2PGgiIZ0PHg9ObgJSgnl396wuoVYeYe1Ec+rRS+ddFIPAc+fIQ04VbGBlqyOfleM7J7LMpjTJ2wwiFNYlFUXnhfeDBP8zHwsKh9PQc5jEgYTr7Oaz7z7OSyFFyeOuuVf9uY3OaHJd+3y8GP70+87/zzl+0/eunRSiaVHJmHTNjluP4Ktp/jXnbev0iZTn7h/kmdmzsNEB/S1wrdugzEuMA/It75CNrMwafPoq/SIP29qnA2EA3Cv5RD2AiTk7slabDcm2kzgNiqVU3wW61HMPjssInNGV4mFvthTn8aFYja3s8Wxqn0Zfh+eKOl9o84btVV+atS2duTJED07vWdy5//bJ5B/INYrGcUGdPQey5QurAkVlyG6WiTanSVcLqq6xGitc4Lb8t9FNEUX9i+gi6IjvbITn64KTd8/DP1EfwArlNODbtoI
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39850400004)(451199021)(83380400001)(4326008)(26005)(186003)(53546011)(6512007)(6506007)(6666004)(36756003)(52116002)(2616005)(966005)(6486002)(316002)(66946007)(66476007)(66556008)(2906002)(38350700002)(38100700002)(8936002)(8676002)(7416002)(31696002)(31686004)(86362001)(44832011)(5660300002)(41300700001)(110136005)(54906003)(478600001)(45980500001)(43740500002)(569394003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7425
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT005.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d2a735d-d17b-433a-feaf-08db57ce07d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5iszdJK/TN3LHXeAk1mVQYoavGtajUrm/7Znr/1SOfYuMF0TCNtUujNHI/VgKtOQD4t1u3v5WwXM9pCKQtbgZFiBMI1jEWtEeBUjUHZDICs3YSfzHobcaA3FS3Oy/2SRkxnG7bZGRiTRkqRDVDdi2NeozFEnhksfF52WfoMLr2iT+MP8mW5Mw7c+XSGO/A0REysJ7SkD+vxEbq8Nr5uLxg9sTrnlMsZRqwZm9PURd5vK6zMA4UDSwQGxeavdE1q9390Dl3hbWkVPPJQLd/EqmKcApF2bfKF2JWrK50mLW/hLGTnSJkBwxwSWP5Er9Q+L59JXXdUVKqxR/eTU5EGwEv28sysTty/zhmB6IS6XYL42BbLQooF/L99/vPXyrJkNvMVOg4LYkgWA8a1CFsTrzV2rLF4hsO3fRGAG+kS6dg74yXMKcBeladwHe+oZUN/b13gE0WvNLIc19cbSKmOmH+JNhcEsyrL2jTAoB3e1myb1MBU2sgEUpBtVx3IgaV3ooLjTq9T3q0TEVpvlsP1dAsiy8dliuX5Ido4EZjYFtbp5W+kNnW+ga5vkgaxnfocYfuEgeuslwJn4kB41hj5kWzLzqDPlxqFevIcjcax7WPJAssdl/3oEEempQx3sVjJYvBo4LPaj6Wo2e1+5IPOOGEsOs2O4pN/apXyp0B+KPEyGEd1XJkI4sjUzePbbcvbpV+bZRojuQqU0/rgiwx1GhiIfLPOLZmrNihZW4uD7jJQQVu3NDIC2CFct3I/ecEsAstpjZlDXOraROfQfLtJBDznpeSIhXDoR4K/NoYrOC0S9UPw1o6XK/CgDg4o/zIW
X-Forefront-Antispam-Report: CIP:20.160.56.87;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(39850400004)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(7596003)(44832011)(186003)(34070700002)(966005)(336012)(47076005)(110136005)(2616005)(54906003)(478600001)(6666004)(6486002)(6512007)(6506007)(26005)(53546011)(8936002)(8676002)(5660300002)(36756003)(7416002)(82740400003)(40460700003)(40480700001)(7636003)(356005)(82310400005)(41300700001)(70206006)(70586007)(2906002)(4326008)(316002)(31696002)(31686004)(86362001)(43740500002)(569394003);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:31:10.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8343e6-d81c-472c-cd36-08db57ce0d81
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.87];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT005.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8342
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 10:06, Conor Dooley wrote:
> On Thu, May 18, 2023 at 07:13:15PM +0530, Anup Patel wrote:
>> On Thu, May 18, 2023 at 4:02 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>> > On Thu, May 18, 2023 at 09:58:30AM +0100, Conor Dooley wrote:
> 
>> > > -  riscv,isa:
>> > > -    description:
>> > > -      Identifies the specific RISC-V instruction set architecture
>> > > -      supported by the hart.  These are documented in the RISC-V
>> > > -      User-Level ISA document, available from
>> > > -      https://riscv.org/specifications/
>> > > -
>> > > -      Due to revisions of the ISA specification, some deviations
>> > > -      have arisen over time.
>> > > -      Notably, riscv,isa was defined prior to the creation of the
>> > > -      Zicsr and Zifencei extensions and thus "i" implies
>> > > -      "zicsr_zifencei".
>> > > -
>> > > -      While the isa strings in ISA specification are case
>> > > -      insensitive, letters in the riscv,isa string must be all
>> > > -      lowercase to simplify parsing.
>> > > -    $ref: "/schemas/types.yaml#/definitions/string"
>> > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> > > -
>> > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>> > >    timebase-frequency: false
>> > >
>> > > @@ -133,8 +117,13 @@ properties:
>> > >        DMIPS/MHz, relative to highest capacity-dmips-mhz
>> > >        in the system.
>> > >
>> > > +oneOf:
>> > > +  - required:
>> > > +      - riscv,isa
>> >
>> > This is the part Anup keeps reminding me about. We can create better ways
>> > to handle extensions in DT and ACPI, but we'll still need to parse ISA
>> > strings to handle legacy DTs and holdouts that keep creating ISA strings,
>> > at least during the deprecation period, since ISA strings are still "the
>> > way to do it" according to the spec.
>> 
>> Coming up with an alternate way in DT is fine but we can't deprecate
>> ISA strings since ISA strings are widely used:
>> 1) Various bootloaders
> 
> Aye, for the reason, as I mentioned earlier and in the RFC thread,
> removing existing parsers isn't a good idea.
> 
>> 2) It is part of /proc/cpuinfo
> 
> That is irrelevant.
> 
>> 3) Hypervisors use it to communicate HW features to Guest/VM.
>> Hypervisors can't get away from generating ISA strings because
>> Hypervisors don't know what is running inside Guest/VM.
> 
> Generate both :) As things stand, your guests could interpret what you
> communicate to them via riscv,isa differently!
> 
>> In the case of ACPI, it is a very different situation. Like Sunil mentioned,
>> ACPI will always follow mechanisms defined by RVI (such as ISA string).
>> Other ACPI approaches such as GUID for ISA extension are simply not
>> scalable and will take a lot more memory for ACPI tables compared to
>> ISA strings.
> 
> My proposal should actually suit ACPI, at least for Linux, as it would
> be a chance to align currently misaligned definitions. I won't speak to
> GUIDs or whatever as that's someone else's problem :)
> 
>> > Also, if we assume the wording in the spec does get shored up, then,
>> > unless I'm missing something, the list of advantages for this boolean
>> > proposal from your commit message would be
>> 
>> IMO, we should try our best to have the wordings changed in RVI spec.
> 
> Yes, doing so is beneficial for all of us regardless of what happens
> here. I do think that it is partially orthogonal - it allows us to not
> design an interface that needs to be capable of communicating a wide
> variety of versions, but I don't think it solves some of the issues
> that riscv,isa has. If I thought it did, I would not have gone to the
> trouble of respinning this patch out of the other approach.
> 
>> > * More character choices for name -- probably not a huge gain for ratified
>> >   extensions, since the boolean properties will likely still use the same
>> >   name as the ISA string (riscv,isa-extension-<name>). But, for vendor
>> >   extensions, this is indeed a major improvement, since vendor extension
>> >   boolean property names may need to be extended in unambiguous ways to
>> >   handle changes in the extension.
>> >
>> > * Simpler, more complete DT validation (but we still need a best effort
>> >   for legacy ISA strings)
>> >
>> > * Simpler DT parsing (but we still need the current parser for legacy ISA
>> >   strings)
>> >
>> > > +  - required:
>> > > +      - riscv,isa-base
>> > > +
>> > >  required:
>> > > -  - riscv,isa
>> > >    - interrupt-controller
>> > >
>> > >  additionalProperties: true
>> > > @@ -177,7 +166,13 @@ examples:
>> > >                  i-tlb-size = <32>;
>> > >                  mmu-type = "riscv,sv39";
>> > >                  reg = <1>;
>> > > -                riscv,isa = "rv64imafdc";
>> > > +                riscv,isa-base = "rv64i";
>> > > +                riscv,isa-extension-i;
>> > > +                riscv,isa-extension-m;
>> > > +                riscv,isa-extension-a;
>> > > +                riscv,isa-extension-f;
>> > > +                riscv,isa-extension-d;
>> > > +                riscv,isa-extension-c;
>> 
>> One downside of this new approach is it will increase the size of DTB.
>> Imaging 50 such DT properties in 46 CPU DT nodes.
> 
> I should do a comparison between 50 extensions in riscv,isa and doing
> this 50 times and see what the sizes are.

Why not just have something like

mycpu {
	...
	riscv,isa {
		i;
		m;
		a;
		zicsr;
		...
	};
};

?

--Sean
