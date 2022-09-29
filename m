Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B885EEE80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiI2HJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiI2HJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:09:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F7533A12;
        Thu, 29 Sep 2022 00:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eel/3b1Nqez88prSHKaMrXNw4nQ1tJrU1B4aRFHFgHo1gjRRCrq1Ct8qDE31ZSOvFdgIxiPBe0VKb1kGNlMvuv6ndvwE9WY5gDN3JJIJCYIX/Ozee0NT8Ko1zP+6TkQP3BWIsIJnlDWUy9kFjquZDXV9tukpHkepavke+1pY3+YVXaV8iTUBoQfagP77DGfFUk+qrwR27QTizWLRb9l7OSvc3AZhQ5wQ5IHey/MbHnpB9ZwKdkO3RgfKbugt0HX0DrAMfxnqgJaDx0BzXcceGqfViNtuekHerIrw2Z+7d8+1QTv+IOiAOprHRpJi8Qxw52c073QhbLM2N0HctDTiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKR4/fPMjwzOEEtojeWIv1ux/SYRoCv8jyMQF9irRBc=;
 b=D4pEryuyXywg/e4WHJxmvbJnZWZ/dSMHPUvdzBC9tXV1k0nsAm2v4mSldGxcd/3R/soJ757pC5MdZS0WBN4yZPebLOwWCVWzMzK9zkVxP3F6HgpPZie0sJLS/WnPOx/xyej9dUJocCvUpnyuxQW1Q0lQySeftAS0RWUOVym/aJYKWbbDByDil7lTxibKdUs3A2hLkRh3te7/dm90u3kHL7JO0OD18yLKdiV90/V28s8Mf/+CWFx1RLh46MF/UKHQOPZ/3bjmYzNblnQfwMrXglGGeWsCtH5Qjv/vgQT/zaH48Uw7DAyz1ScduY3NmqzIU07k0xTMhIeNfCzb7Sd7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKR4/fPMjwzOEEtojeWIv1ux/SYRoCv8jyMQF9irRBc=;
 b=DLs25qjU/yqXr0ZQmJnwiIHb6CWH15SwNJHHs4SZ3+NIUROAeUYE3yg0bKlrB+cFS2YjCMlRjQT2lA+AWn3+xEvRDqDZGpvst7dKrXbPDAX8wCKgYoPPIKzatrIuAoXn7k9BQKW5u87rzyF9n5ucXE9r5hgDpuYN/rktSUrdP4M=
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 07:09:13 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::72) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 29 Sep 2022 07:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 07:09:12 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 02:09:07 -0500
Message-ID: <9b7fac69-265e-52f2-21e4-83d9da0f257b@amd.com>
Date:   Thu, 29 Sep 2022 09:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration
 support
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "Kannan, Arun Balaji" <arun.balaji.kannan@amd.com>,
        "Mutthareddyvari, Jyotheeswar Reddy" 
        <jyotheeswar.reddy.mutthareddyvari@amd.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <YzRvEPUWUXP4x7+h@pendragon.ideasonboard.com>
 <YzR5ZoAbaYONnmPS@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <YzR5ZoAbaYONnmPS@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: e156bd2f-1305-4a1b-cc92-08daa1e98341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Edit3xWIKF6cbHoBo+hbL/R7cVOOQwdPTzJIFLH/5giym8QNQCUO/p+0ttdl7xrAPVSSYH9+/cNd5GfbSW4e5IwHiiMnca2evSimJRa23uHpVue8JMeBhzYiOSqB0vcLTl65RHOlao0Mo0OPc5x4gIjfaqB0if0nv1764ReijS210YGPzkkrLFd4owrKLLfpsgK2pvEwRDfsfWm8eS8vYEv9ZVvohDTePC8iLbmJNDYM+qRBUDIiDHcxd36WxK5iWf32gmrRrMR+7w4dAwf6pdP81AYmOHxZgAiXRTyaEme4+HBxO9MZTygVfLIhirT7m5kqknrq5PrL2waqRDy4LQRLF8AIUIqporcjfLQIsnrFvsjKZmLhr2UbHIT9VNEtkBzOjVtX8VclOQwxA0Cy2Je4lEYOiZz71YeexbcEBAdDDbkN7wSa/OvwSxhpGQ68DqjN61NL8Oudmh/K6rtBDzgoCy++7uHJOqSyvUDtYkpksXZsQ3KDVPMAUztzuQL+7qFcoNVGc1nPpySmjumO7dhl+ethyldPV1JmWq2Z0IDuFugJ/kLTvQaLV+Hcy8SHNHKuORMQTMD5umCnFY1BIq5to7bA7nJbNM3/MAmeQge5k8vcKAoB3p0GkJeLO+AUP+IDINU4oHLyM4/aMDYAA6skvJora29IZEpXT8hLGmbEozFUVXk1ZI83LjjzpXFgndXw/jolhLoA0767b/5G6xvVbzrZXsL0bCN/PAMqNrLTEgdRO5XV+hXQlnr3Q4S+ckh+kWuqkcbzvNSxGtyhVIYHWmvV4WQIXu/jVDdT0qb8g9me0XHzFMWSlyrrvLZ3V9Mv7VLBpYLZEh1KCP3DsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(6636002)(70206006)(44832011)(5660300002)(8676002)(4326008)(8936002)(31696002)(110136005)(86362001)(2906002)(81166007)(36756003)(356005)(40460700003)(82740400003)(336012)(186003)(82310400005)(41300700001)(40480700001)(6666004)(478600001)(16526019)(16576012)(54906003)(26005)(53546011)(47076005)(2616005)(316002)(36860700001)(426003)(83380400001)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 07:09:12.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e156bd2f-1305-4a1b-cc92-08daa1e98341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 9/28/22 18:42, Laurent Pinchart wrote:
> 
> On Wed, Sep 28, 2022 at 06:58:10PM +0300, Laurent Pinchart wrote:
>> Hi Sai,
>>
>> On Fri, Jun 17, 2022 at 04:16:55PM +0530, Sai Krishna Potthuri wrote:
>>> This series update the Xilinx firmware, ZynqMP dt-binding and ZynqMP
>>> pinctrl driver to handle 'output-enable' and 'bias-high-impedance'
>>> configurations. As part of these configurations, ZynqMP pinctrl driver
>>> takes care of pin tri-state setting.
>>> Also fix the kernel doc warning in ZynqMP pinctrl driver.
>>
>> I'm afraid this causes a regression :-( With this series applied, boot
>> breaks with the following message being printed to the serial console:
>>
>> Received exception
>> MSR: 0x200, EAR: 0xFF180198, EDR: 0x0, ESR: 0x64
>>
>> I've traced that to the probe of the UART, when it calls into the
>> firmware to set pin MIO18 to high impedance. According to v1.7 of the
>> ZynqMP registers reference (UG1087), there is no register at address
>> 0xFF180198.
>>
>> I am using the VCU TRD 2021.1 for testing. Does this series require a
>> firmware update ? If so backward compatibility needs to be preserved.
>> It's very late in the v6.0-rc cycle for a fix, a revert may be best at
>> this point, to give us time to fix the issue properly.
> 
> I've now tested the VCU TRD 2022.1 (which AFAIK is the latest available
> version), and the problem doesn't occue then. It thus seems this depends
> on a firmware update, which is impractical at best for all old designs
> :-(

That's correct observation. Supporting these two properties requires newer pmufw 
or that message is received.
I will let Arun and Jyotheeswar to comment it. I don't think there is a way to 
detect which firmware has implementation for it available.

Thanks,
Michal
