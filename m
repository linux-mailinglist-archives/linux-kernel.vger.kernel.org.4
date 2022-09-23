Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBA5E7BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiIWNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:25:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4047B109124;
        Fri, 23 Sep 2022 06:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHwRzMLXYtiro8FHA0vifnZL++rUIk8rW1hkUEzL06RR8Ug1361jykB0kw8k9oItEfQSlTLCZ19o4RCR9/+JTj1G/cZcrbe3DQv7GMnNYzWda2NevGnmpwagNIxoqfy+BtmSsATdEGUlTsT8bGZMRYxFmqdNFxaykPP5vPLLA6+9wvjkR3t9n8iywXygmsKuu2aO4e3zQ23d+RkILclDHqdaFPX1ZdL86NWbAlx8cMQfVOGbWYJSHIK93R1tt7a1uLoyUG6G7TVTIgq/Zng3ojhyr9OoiW6BphRImUVqhSkXIp9TfKUff01E7rwYr2SA/VH0CTZs6WXWabfC2K7X1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S31c+t19SRQ4xEMSLtXDmv4ANK1eezjvDbn/qZaF1Nc=;
 b=VW2BV5MDZu6SdSoObsYc+gXg9OeXEfeo0L9C/0X78sOY4edMYE4jWfr3mpjqNA2/gRrceFRoj8aIlr5hTts5AG/u2FxiXQtwmVFivRl7diW5rq49iqO/D2zozTxY3N0x5Z0yVnI/lEZZE1gme2zUE3yOrkDBsmMnHefEqK4IRJgn0Y6LtIg22F5bGZ1f18mbUsuJBiObVnODC5z3b/LQ1wNDvOgchzxKzdEIFpsFEr8H14Kc7ijn93Iv7Op9P4rIxv5V8hs+MEW65mjnhHr7nXsTnhKeOcqy2SYhWD9SUEWgxpbbucXsHlMnan0f5ec0uJHDM4m7M2gSYhnW3Gk/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=balbi.sh smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S31c+t19SRQ4xEMSLtXDmv4ANK1eezjvDbn/qZaF1Nc=;
 b=lz/tY5I66fj0tvmaDsoGn4mWhVGBTbOjc34n+hs8xz4+mQ2PcWvIRIpvTztVhnfIH5whlOSNGxUPaHVlpUHgp+qETtC6TuFWT5XiKfTnpcDEqbmobhuo5weTXnBkct2BFDse/KoAE5ik+m1lE4LA2zN0xCKNQ1PqwSJ1tLf+6MQ=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.17; Fri, 23 Sep 2022 13:25:40 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::25) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Fri, 23 Sep 2022 13:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 13:25:39 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 08:25:35 -0500
Message-ID: <e4dfbb55-c8ae-e98c-89c3-4bfb54311a30@amd.com>
Date:   Fri, 23 Sep 2022 15:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Content-Language: en-US
To:     Felipe Balbi <felipe@balbi.sh>, Piyush Mehta <piyush.mehta@amd.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <87y1uab6re.fsf@balbi.sh>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <87y1uab6re.fsf@balbi.sh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: e914c189-8685-4df3-5fba-08da9d671bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4guJfy9YdBLlKh58imynI2Cs+N4ZKPgjZ5sI2mu1+SJqJW6492o9XQbUulHi6COz9kkrcaCLS703rpfSWnSHAbayio4cXcvd+56mc2KfH3pbdOyAgphBVnCBS4NVwZNBwSd9Lt0m3hlc4JFpB3LUeSWUwb5lJiPnvd2HmYEA9HXaZ5A1IfTMh6TOQ1DYKdMcHq/95X2Hhv/qVmqpcz2nHDLnEKG414CGjRjoR1LnhMNnA9//W7WoGxb52wwcdHdrQKcOId4zBmnPUhC+doJUR1HGcLr9lwa+J+DuhhxUJRrghWERRhG8BMNAZsDYPR6yU3oQopLehRTaU84XA1wF4w8NNy9wavpfkHI4bs3odbCPbM3NBVnubbpupjDl124D9U9kYaEJLyXWUNlGFrgU8EeqtKlNSZjkBaJTa7KnZfnnMI/Af+f6esSQahegGOzMvTfoabzg/h6vpEqaMtmj+DEa560owB4m+6ucUGQUsTSQZL3V+4Lc6SzvIMHGzo6JhTS6TaO8gZHy0l5vhyjAYwDPYIghA+2VWIxYZd1qSwFC91V5u33XuRLG+Qjinl5yMzvc5duzdd+zCGWk9t3OhfuMwuG077iSGNUOTDsezE8XjjO20kj3hW2xQicSIX33MRzIO8EsjDZycc5fLYVJX0kmVz5shm7wajWM0Ssz+CyLVEiTF0x9HtHd/GA/xz8yCGV19jeQGVwrIDHw8w6dJ3UoPtGAfP6BI4AUkoiKTWLAtMDkASMBa9YwpMFpbcKXvGlkUtgpOLxgoY417HdujYjF/Fr23lRuE1scoDqqWRfvRAEgOs8fvaeBX6kKuG8UvaUMwt9DO5yWK1+WqyAKkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(110136005)(316002)(31686004)(40480700001)(36860700001)(356005)(478600001)(31696002)(4326008)(6636002)(86362001)(107886003)(8676002)(54906003)(82740400003)(36756003)(426003)(47076005)(44832011)(70586007)(26005)(81166007)(41300700001)(5660300002)(2616005)(336012)(2906002)(82310400005)(70206006)(40460700003)(8936002)(186003)(16526019)(16576012)(53546011)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:25:39.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e914c189-8685-4df3-5fba-08da9d671bdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 9/23/22 14:43, Felipe Balbi wrote:
> 
> Hi,
> 
> Piyush Mehta <piyush.mehta@amd.com> writes:
>> From: Manish Narani <manish.narani@xilinx.com>
>>
>> The hibernation feature enabled for Xilinx ZynqMP SoC in DWC3 IP.
>> Added the below interrupt-names in the binding schema for the same.
>>
>> dwc_usb3: dwc3 core interrupt-names
>> otg: otg interrupt-names
>> hiber: hibernation interrupt-names
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index 1779d08ba1c0..618fa7bd32be 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -53,6 +53,8 @@ properties:
>>         - const: dwc_usb3
>>         - items:
>>             enum: [host, peripheral, otg]
>> +      - items:
>> +          enum: [dwc_usb3, otg, hiber]
> 
> I would spell it out; i.e. `hibernation' instead of `hiber'.

that wouldn't be an issue. What about that wake-up line?

Thanks,
Michal

