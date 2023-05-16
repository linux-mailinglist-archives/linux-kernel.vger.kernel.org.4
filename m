Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE152704B31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEPK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjEPK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:57:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5D1717;
        Tue, 16 May 2023 03:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNrJ1Na37un4ddpyoVT7TUq8o4LItJ6y91mjMtPbK+84urxZRV1/4D0mxD9UyYx4UPbK4tf4vLdCGRqoHYb9kpJKSv0qSXoB7GtzNJyq8ir9zWL1egquUaqs6FTsEzvFLqd+F0GE3yQD3T0sYBoGpoHUlPQAVo5a9JZxZaD4eZR/sDTUV9rolp++WaIkFETdjbzPX/bqQr2xYggl7FWmZFbzk1uh30QqqZZc4Fe1mAXfx/I2EVV7g1Ke3fH0eKjYKdCgfesQ+Ujspn7KAtKWxEt9YyXbgaoAs+yNbN+rxSbYQJtLtRg0WHyCMyrkuqPPG/3opKdRJnkrkaF6B3OaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zKjLhLOHnVKK751uZtuRz+L8xspRujePW0PlkSNdXA=;
 b=A4Q+HbeLn1wS2gAByY70qWwRljeExLNBCXokL/9thlQwmPnSqDAPFybmliGHefHFK7uSDaMfpPp+0qRQpId6AnElj1YfrpJPjZAuv+1i1mJDviudB6+Av0ztpd2K8am+p2ebkEzc5u1xc+6zgZNgZAAdeWwxDIBxknbEIVhCUk+iB0jtvrfusQApV6ISNIZnm2gsCAK9h3JW6EhRUrz5HXE//KauNe7RHhMGyKGIQA269ip8lazmT/4nfkklgDWqDFegFtjv+en80lB7LKwL8a9ZOOUD6li6pAgpo0KRzFzGPGOf6FIzYwQFkHa0OAHeDJjSGZ3PqlgvvvHXsWK9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zKjLhLOHnVKK751uZtuRz+L8xspRujePW0PlkSNdXA=;
 b=DA9SlqL09Ai/BdXVP0srtKJqaSISt0HKY8i/avYC+GZl2Sg1EIT0/bkGtetyN/9QUYvmWbvCiG3Dth6487g4TmktAFRGROPAXRvc/9atyJEbI4/Q289BN4m4lVd747WE361PRSMwCQD8mbfH8KfzIO2FqMc6FqDjSuG/hKogfb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:57:14 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 10:57:14 +0000
Message-ID: <bfd404ba-7e75-eb74-8e41-ac4d858eaf49@amd.com>
Date:   Tue, 16 May 2023 12:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/23] arm64: zynqmp: Add resets property to sdhci nodes
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <8f8592d6454c024c8f8b92e56c9009c65ad1d54a.1683034376.git.michal.simek@amd.com>
 <20230510070234.GG11711@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230510070234.GG11711@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0203.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::33) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: a06543e5-ac7c-4d5b-75b4-08db55fc4e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3T1IQrRWsB+lmpAQshTRiszLZO2KWzsVaF232HAc8b4o17IYusTnU3PW7b7w1hd0/V+QQejP0O+e2/vumGIj5rie1zZWjXiIG4wkaAUZcZ+QrPTnIePF+B5SOPzL84NvJu5v16UO+Ge627H0DDQPWekbGuGYf2z6pHh50VtTPuS2VwcBTHx5JprsUbEP1+XGmiXL8Fo2BnxKWyDPvDYKepRAk8UaBFQ5wH4On2ndMPXteB7KbYQiiEs7zXeo3BWlWzjNWhgYawobn8xSsrey84XA0vqX9t7bgFzS6z/gOn7yhvJxWp+9ixQs479JN49VcZ/KKNN5/RQOGwXL+kP/c9NngzZurHLsVCnZ3O8myM5ubSOgE+p55vprjSx5lVjHfdlKlU2+me7bpBgNMnDyM/OnEX7Dok+aaYyJ0Oq5Tsl62oJvdGj7kB8aDkqWPIfLSslYUx7ZoVFCpP71FEzRNa3RV4a0PPmwwg7Muwd0VUzEUvJ4WrqCD058YGcz2kt9d1RUabR5U2CHIYom1sv/Eozid325yg0c+G+ADqiVmPCbNcWbujdX4zr93tMq3OlyvgEKMY5oMaQMUgL1aP4v34rdb0RDfzUJeHN7JEKqmDXPu0HKtaPOq0wwh1nj8vSMjG9/accRluXbMLinWTlRXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(5660300002)(8676002)(8936002)(7416002)(44832011)(2616005)(186003)(26005)(53546011)(6506007)(6512007)(38100700002)(54906003)(478600001)(6666004)(6486002)(31696002)(41300700001)(316002)(66556008)(66946007)(86362001)(66476007)(6916009)(4326008)(36756003)(4744005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZWUFNEekdZL2NraEhhcjBrYmlwZWlnTHZRTjJpWlczd3BOZzQ5TWJXTzF1?=
 =?utf-8?B?R09EeGw0ZUJxT2Z3OU0xKzhZU3ZHMkMxT2I4TVhTNWU3Sm81VHNxZlBYQWNk?=
 =?utf-8?B?bGN6eVFlaVdKcjgzSUpFOGV0QUY1cjNnOWZVdU95Y3VCOG4wZW12RnlyTlBQ?=
 =?utf-8?B?L2U3MjFqbmZocURNWk4zRTR3THdDdmZscnhxM2paMVJuUzFIeWUvNFJScnZB?=
 =?utf-8?B?RFZQTmd1UXdWQlNIeHBkb3RFcFpSVGF4ajFmMjdFd2VBWE95cHdZMlkyTUln?=
 =?utf-8?B?MmY1QmRFWFlRb1dXaFVScHpXVTNmd3gzYmhMZHEwcEpLMWc3WTI4YlRoMm91?=
 =?utf-8?B?V3lDRDRLQytDYk03cWhoNWtmM3Z5S1BTQ1NXcVllNE1DMFRoRGdleGpSaG4x?=
 =?utf-8?B?cThPWEk2NnNmL291K0R2d3RkekxOQUpxS2dWN1AxaFlpTE4vWm5JQkxoQjBW?=
 =?utf-8?B?S0srL2ZPT0tJUmFnY242K3lRTVlNSDNqeFBSQ1ZvQ00rUVkvc1hsUE1HVUVN?=
 =?utf-8?B?aE9KQWcrWDIzTlp4L3RNSFBkc0l5dWhlSjdsQ0tXUDJnRE04b1VDNGlLYzRX?=
 =?utf-8?B?clBtcjV5SHZFdURVb2EraHdHUFFDekJpcmZHYitxOG9Fb2RNVHdjdCs0ck56?=
 =?utf-8?B?RE1Gdm9hYWRhZTJZandweEMvbHE3MDNvOXpLVFlCeEJVYlhHck5ST3hVMVdV?=
 =?utf-8?B?aWdGM3RkMkg0WXlLNHZoZWp5ZTd3TWZKU0o4ekRVZ3NXOHNhUFNpQU9EODJv?=
 =?utf-8?B?M01ybys2dVJ6T0lSZWZ1REMyTDNvZkdpUnh4L2xsYTBaeVc1L0owa0xscC9K?=
 =?utf-8?B?UE9qQ1dha1F1N01KNmJOU1lLSGQ5QUdkbUUwdzR3OGVTSVZtWDZia0FkcEh4?=
 =?utf-8?B?eGViM29TV3hNdEd4TVhvK3NLN1BjbE93ZU51R2pTVEJOR2x5MHU0KzllcmpC?=
 =?utf-8?B?RmJLcWU3dlFqeE1ReXA2L3RmOTJrUStiNmRpRHZwVnpaOWJoWGNHaEw5WnF3?=
 =?utf-8?B?Y2d6YTFBSHNsWlVtWHJ0YUlOaHBIVjNoaWxvbWJKUFhxMTVrNWp1SG1BSVBL?=
 =?utf-8?B?TkZ1R01uaUppT2ovcHU3c0FaREpxQ3ByQmtXdDIrejExaEFyWFprcklVUGh6?=
 =?utf-8?B?ODhpNzNJRHdWWm1wQWdyVGM0bHhZditlcHBLdEtKeEMvTGc0V2p6TmQ0dzRn?=
 =?utf-8?B?bFRtNnRFS3pWUlFPQ09XTnRmSFhndnJwKzMwcnpLSTNiR2JxRHUxOUp3dktx?=
 =?utf-8?B?OFBETnhXU0tuUllGRGMvenRyODVxL08xUnJPTmVmck1aNXYvZEtVYmEwaEVs?=
 =?utf-8?B?RHU5SXl3V01HK2Q4bUJWaGlraXd3bDFiSlNUcHc1akpydlB0bFd0bUlOZmk4?=
 =?utf-8?B?QldpOSt2U1BXWUE0QWJDcmNGa0NOcXJkaDFXZnJ3OXBLUDJJOWcrZGkveUpD?=
 =?utf-8?B?ckRtQ3JOeE9rR0dBbFhFQWJWT3FUV0VGZW9mbzBWMzh6MGFuY1JEZnNSRTJa?=
 =?utf-8?B?dHEyNmhWZHNtaWhLd1ZrcUNtOHlCMU9GN0QxcXM5M1VHZ1JVWHJWSzQ2azY5?=
 =?utf-8?B?Z200NjVBdURQd3RvNzZ2N0krZUpwRFJmWHNLaVE3VHc1dmxGY3ZBcjVZK1Z4?=
 =?utf-8?B?bDRtQ0EyQkdraGJzMjNmZ3BqQ1crNy91M09tOGdOQkRScEZ2bUtnTWZaSHhy?=
 =?utf-8?B?UFNlV1ZHYzlsc1AvVTJtS0Q3QUxlM0lUaXlyL0Ewc0oxdkhzem5GR24zZk8w?=
 =?utf-8?B?OVhHb1VZK2g4c0czVCtOcGcvNTk5cDFtM0lQMkZNbmhESjFEeTlJZjl5WXVH?=
 =?utf-8?B?TTV4SW83K2ozcHgvUXhxaE5CUzZDb0hWdWJpMUk1TE0vbCtzNVltdXozdjkr?=
 =?utf-8?B?ZmhIUS9jR09GaDdNbEhOWjdaTE9qWHBPRndHOGh3TEJTR0M0TGNESy9NVUow?=
 =?utf-8?B?Vi9IbFJFRmRYZThycGZ2UjlFK1lnV04ydE1lTGpGTmIzOEoyQnZlcHJXNGpJ?=
 =?utf-8?B?dFRWZGdvN1BacTNWb3IyYjRKS2ZEaFBLbmdDY3ByMTVpUENtcHBjcUtHQ1Zv?=
 =?utf-8?B?Rks5NzZIdmdldEVYdC9RNzVreDRwVi9VdEYxZklDN3lZLzJNMVMvMThCbVJn?=
 =?utf-8?Q?A7INkofRQfD+gyTraMRAHdnsb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06543e5-ac7c-4d5b-75b4-08db55fc4e9a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:57:14.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqH2bTgWMedqStAszW1gZPBoXzzotHz+WS+mURDRNhXP76RVDFQGB+xaqxRK6Yn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/23 09:02, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 02, 2023 at 03:35:36PM +0200, Michal Simek wrote:
>> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>>
>> Add "resets" property to sdhci nodes. Resets property is used to reset the
>> SD host controller when dynamic configuration support is enabled.
>>
>> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied.
M
