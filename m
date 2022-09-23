Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243B5E7747
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiIWJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiIWJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:34:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B454D2D76D;
        Fri, 23 Sep 2022 02:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2LgslB7R6h6jX4u04ntw6wRjhZDFHmhIzvHeiwEPZvDkIzNlltzglQ/QOFFVoICD/UcebXbDyF+Gk6n9iwzpSuxpP1mPCcCDoA6Ok71MP1V5IBmDrU0mDRQII608lN7s2yPto5GVEXX3xf3S5Dm1Pd1CWEwJYEiR/ZFm5Az4NueQqY7xnr+yq8HXCLDAsMB+/HQFCwkUCLMoIu8pYSRU7rRVK9YtpW5DKzb7MLaPI022bzJMF9+XiGVYmPQuFTBFoLolftVKgf+C570kTvdbRkfvy3J3fKlJYzSA6v+fQRTXdNz8ASddeG/lLnyRTzQj4XBiHUB4GYxrMQ5HODa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTjomR2zftsGqsMksO4QVehnDcwfkd9eTMIqQ0l0rtU=;
 b=Koahasbpr8v38p3lSBFzQ2w+sHOXTO/qOje1khEO8XGNYDr8zGdTyidrA4nzLzr1GlYfOm3SdZFHaGHtZdiY9H96NUk1dR6agOxEZW1gkkF4tNz328Rh9yfhAEvoWIXfJQbarOiOppggCG3OhtIrxEkLrS8gPi0QIBs4W1UMiw1vIkjcPvBRS7XhID4WF+yaR5h4CFsFyxgUd1wKCHGvPhjSTHoEAKEsq+eWpN+bdEUIW7l3b29cINCVp8menxWjaMZVXacLIuGdzevOwhPnveCm02SwoPtaRrXF/w91gO+nb9txeLXlgmw0JMm1aws9Q3UBQSZFvCM82r8BpajOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTjomR2zftsGqsMksO4QVehnDcwfkd9eTMIqQ0l0rtU=;
 b=1Xy34pApRwnU23NDpUP3s0cJ6yJLxOJVd9bCENmv1DA5LxhUjl5LCscdLvWdymTtDcDral8iXYvZSUGDSaAe/Ned8d9c4DNX42Zvuoiz3g7W+LGRHgjHwC5RwotGsF3+UA7BJNFxMUDBa1E9rpV+rfUGzfQcCTYhGeDEP0M5fFs=
Received: from MW4PR03CA0227.namprd03.prod.outlook.com (2603:10b6:303:b9::22)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 09:34:39 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::b) by MW4PR03CA0227.outlook.office365.com
 (2603:10b6:303:b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Fri, 23 Sep 2022 09:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 09:34:38 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 04:34:33 -0500
Message-ID: <83c104d1-6c09-1744-0621-a50a745a0744@amd.com>
Date:   Fri, 23 Sep 2022 11:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
 <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
 <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
 <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
 <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
 <MN2PR12MB4333EBFADEDD7DB623F4634188519@MN2PR12MB4333.namprd12.prod.outlook.com>
 <a127333d-cd25-4fa3-a12d-9c3cda05582f@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <a127333d-cd25-4fa3-a12d-9c3cda05582f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 624f6f27-ba4e-4a18-1d12-08da9d46d5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRTDFNmv3Uh/bZgGCbkT8cC0upaQMikaZmgwLzFlpxmaaIMw9LZPzcB79sBOJTdyuPh3/9MrVqsOS8wqxSZjTc3TfnTIq8wOVNpYCSlxnNOFbuyksDCFvAJ+mRzlUxR3MGLBRLZX+4tmzebUX5UhPq3jpiOXswE7gZrahpenudCVjjv9dVsDrZZXY3eLoOgCTyIAUIp+8uk1c2Pmuq8PSzejgRzR1YBHjM3PQ2kQZSQ/JTiiYHvftJWrxtRYr15dhwCtnJHXXNHeMo2B8FVYCiHzxRX15LuVWP5Hz12pMQIJh1OlO8WALG78fi1708DBiZVQqfilZtJB3jJfM8w9a3Ck40EZ7gyDfFRqn2oQTiLbVjNGoFMzwsG/AFee1fdgle1P1/QZXaEQ1TEzsivmXXpfbZ4sSvY5JEinRkDkXGijMs9fGxQGOiJhN1FQ1iT8iq1eoo9VwWXVMkz5wZqT3p8Npu5oeb+Gx/ri+cXhSUOZLW5G4ZuE4JCO2SNjxikJnqzVuAOVKWSOtpFZTkt63bEmVGUyOBiIc/rNemVsxmZJlzn3P3RrAVhWUkStuoqTPPb62hbjW5Rtiwp1Fhe57q62mEA3AKhQsJjC3nwUtepORGqVYdIJNV5Da3RVJFL6+bPYQwtaK0Yds98pL27k2RC9r3MtkRpp1GbRMO1xbZwtUjp7E2mL/P5Yd3qU9Dz2cujBFSLMGbl9pVGavKearz73lybxA3+bZOVtIo3ABweJsZDUUG5lV7iOkhXi84VN9WpBuXprau019EWfIqRu9dsUpi2C3aO7N4fUPUmD58r2FnfO6+aogxk7x3hc+tzHs7Snp0T68os51MMcvffG1SJbHuYmdYyYeHxCSG7dR0l64Yhe6XRFpJjE4fu8Mco+lEuNjnNxsnvP4q5gFRacqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(16526019)(356005)(186003)(81166007)(54906003)(110136005)(82310400005)(336012)(82740400003)(47076005)(426003)(53546011)(5660300002)(8676002)(70586007)(70206006)(40480700001)(4326008)(107886003)(41300700001)(8936002)(86362001)(31696002)(2616005)(966005)(40460700003)(36756003)(16576012)(316002)(26005)(44832011)(478600001)(2906002)(31686004)(36860700001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:34:38.5574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f6f27-ba4e-4a18-1d12-08da9d46d5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 9/23/22 11:22, Krzysztof Kozlowski wrote:
> On 23/09/2022 06:38, Mehta, Piyush wrote:
>>> Thanks,
>>> Michal
>>
>> Enabling wakeup in zynqMp we need to put the core into hibernation, as versal don't have hibernation concept, but we require interrupt for wakeup.
>> We have a versal platform where we are not using hibernation, but system wake up we need the interrupt. For this interrupt-name enum would be:
>> - enum [host, peripheral, otg, usb-wakeup]
>>
>> zynqMp :
>> - enum [host, peripheral, otg, hiber]
>>
>> Versal:
>> - enum [host, peripheral, otg, usb-wakeup]
> 
> That's a different name you use now...

It is small confusion.

We have dwc3 in 3 SOCs. ZynqMP/Versal and Versal NET.

In ZynqMP currently we are define it as
interrupt-names = "dwc_usb3", "otg", "hiber";
(https://github.com/Xilinx/u-boot-xlnx/blob/master/arch/arm/dts/zynqmp.dtsi#L996)
where I think we should be able to convert it
host, peripheral, otg, hiber

And Versal (Versal NET is the same as Versal) is now using
interrupt-names = "dwc_usb3","otg","usb-wakeup";
https://github.com/Xilinx/u-boot-xlnx/blob/master/arch/arm/dts/versal.dtsi#L597

where it can be converted to
host, peripheral, otg, usb-wakeup

but the last usb-wakeup entry is the problematic one.
You mentioned before if this is SOC specific maybe we should consider to create 
new compatible string to match this.

Thanks,
Michal

