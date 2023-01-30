Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20168082C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjA3JHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjA3JHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:07:11 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439429429;
        Mon, 30 Jan 2023 01:07:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N924+oO7TWmS+zuFQv5SxUsJ8PnuXUlk6Zfm/I9IeBqyXK+Mh/3N39wPJ2TH/O5qLKZEQSyLFQKOi1tPCYb2uLNoNAJf9L0j0Z27wLd3H7oklHdXzNdhXmtDqHkrVhN+uFr+4MlTWhz1mwxdqfrNeQGAxAjPTlitPjamahkJQqHRV48g5c99EvX5Im2rlk9UeynkUYoIwO6XghWbgi2iLki0rolXdUR9pinhzRvxBsN5yzCzgmFvckFRnlWBWOzctJwbLg5d/0gndWQGSR6XQPEJqV2bMQeM8sdn3t5XSuseddF/1Xb2JgDxzfRWn6LSjnkqFZxfjGM9kwPUGNX2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqo8KMIO/IFqQXAQ9BPOwHboqk/gUomZ71uJ/kXbGLE=;
 b=Nv9dThGlsQZLnODkOV6NNWZOzqgu5RqFPhD3SZ9lFUskf69uL4thZiVe3k1fkEsnfE7rAXrKbwr//NFVZV40HYag/ad4o3E/1hXlURIHiw/j1jBovr0/GPs49dafUt8peJ20LfS9oNcAU+aOImvWqFp84UlCH9slJDLUGOO8Es0Z/myb4QyuOXUclYtezwZxfC03gkO4wLeSl7UdTyBe+iWFvh3Cd4tg0hBXCqN/TWNI/NRraX/fuNhqVBMn49GZhJToChpUgcy/2kWKHClNZ3jyf8AKAkjZ6GPmaDzG6YA4XPOh3VRI9lIiOSLqYHifatXV0FwxNKNe5mGuHFZlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqo8KMIO/IFqQXAQ9BPOwHboqk/gUomZ71uJ/kXbGLE=;
 b=L8dLSk+a3RtPitI9bK+xFEvN3lS9kQ+DU91BnXBiD39FDTCsZ9TSzllWXvmkSvkmnVEZGgVdeE1ORmj4PLiZYXjO8IaTWUFc6sUioTm6IY4/pHdxVW3cfhyskzgDXxy3kttDd+gCbqSi4OuS5CV7nLfpE+E8lhnxQIOPL9daFTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 09:07:07 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 09:07:07 +0000
Message-ID: <b169157e-3477-3bc3-b4dd-92b3a69798b7@kontron.de>
Date:   Mon, 30 Jan 2023 10:07:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 5/5] input: pwm-beeper: handle module unloading
 properly
Content-Language: en-US
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
References: <20230126091825.220646-1-manuel.traut@mt.com>
 <20230126091825.220646-6-manuel.traut@mt.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230126091825.220646-6-manuel.traut@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0179.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3edced-3be7-46f7-42a8-08db02a15ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/Evr6GXqlkr4JJyYJKRWWfRH9NBmKROs/YvyuLQzT1czCXPAXjXPpz9cbve5NfyIOnbQJJiHfgJTa5xvA/9Qp1FH6hg2s95wHd3Jr7ofBzC+2njNsqRPS98ghOqn6pNEkx31UDndKGmYDa81s++6xz4RWxQZdgFcAsa5vwksfaeTsX/RuKj/7gjB51f5cotauwTnIIj/ynqxMZx1DtTc8+4ZNXksW/ezqvh1u7GeS9+9aF5UEkoDiezWsdUJO4Hr/feVlIUFYzgBAvOLH1XPUcnUWdIeK1QREBWH7HDtngokdjuMX6ZpN7ogDiNg02Ic3jZ6dvcLu1eQhJ3nsEok1K/fdA//QHrPL/1ahJG3WUSQiYclAApLMISPhKwu3EvAzCw4tqG38JhDaGeG0MU8Iyd3thvqAuHi0kcsP+CVsleYShGC8eyiW+oplZLvcchTP7ouRyN3sFYDlL3P6CFsUCV25nJ7AZBXK9iBfYEnoNzvTzkuZGbX9C3cwu3Ksl0WnpRv7HpUNkey80bhzw32QaNoYnMrNXnbClt6XzuUq++eIy4xTssHYabpPUZsqm2kowtMrwxPOTYqaEtqD2HQlLCgLFjiNsJJxj/oIeOy82MVzGEYhIiCOvNqsFTjoOoY2EKcOR9Atp1gMl3MRkhAoG27RpYNDxCcNMo/oS4K3gvtFfcfDUDcfPwwSb9iH9IMM+s3u22g07xIr0xwWkql67J6KSN9sv7cYAOGsQjMyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(4326008)(41300700001)(8676002)(66556008)(66476007)(31686004)(316002)(66946007)(8936002)(5660300002)(54906003)(44832011)(4744005)(36756003)(2906002)(6512007)(186003)(26005)(6486002)(478600001)(6506007)(53546011)(31696002)(86362001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJmQWZseGgwaXV4NEhJVjBVQmJUcTJVbWFsS3E5eXRNS3F4bVYvaXZMNzUv?=
 =?utf-8?B?UHM0TStmSTZPTUN0RitreERkUFIzU3NzVUJpNUJxTitxY0FEb1U1OW1WUjVw?=
 =?utf-8?B?b0RzU0hwTFErd2dmdngzS2JLY0RhV1IrUkdENlFzS293VzhJZzg5RXFzTUNG?=
 =?utf-8?B?dGRwdHRSeWV4VDh4U2E2TGtIWWM3UzZiM0tnZEZTUEtKcEs5QnZMZW9VZmdZ?=
 =?utf-8?B?UUl6R2VKVTdIWTZPUHMvc2M5S3c0Ym84SFI0QTlYaGFsc0wya3p2M3dJSGg4?=
 =?utf-8?B?TFdmQWhSVHdiMDJMaU9pZWxmMHVVV28vKzM4RzlQYjk4a0U4Wld1ZC92UWFV?=
 =?utf-8?B?M0dGVWtiQVBxWTNjTXpFNGV0QXVwd0VJTmd6V2VhbVd0bVA0T28yNTFRNkt6?=
 =?utf-8?B?YzBlTjYyTjdMcFNpeUU5Y1ZCSGlMU0xQdXFVdCtFbWxwS1drb1FPUkNDUHRl?=
 =?utf-8?B?bWFyd0E0a2xuOGJPcmNQbURhOHYxTVhQU1I1M1VKb2dwVVIrbFJ2UTRsYVRV?=
 =?utf-8?B?Q0VyY3VWb0dJMWNpZGZmWmtwbFlIYUVKZ04wdVo3NzJBVVRUc0ErcURhbHdK?=
 =?utf-8?B?QkdPRjV2Nk5oYWlOVEtHei9FbS9lYkZOb21DeTlzTHFBSWJvWUppVkgweEdY?=
 =?utf-8?B?WnBaUWZzOVY0ZXFENVdRRjArTWNlNEp0eE5iRTRJU0VHQzJXQ2k1dkE0ekkr?=
 =?utf-8?B?T3lWbEFXbW5UdFAwUTJlTFVBT3RMemhaNnNCR0xFTHRNUlQ2S2FFUWFVQmR5?=
 =?utf-8?B?RE1neVRub2Vmd3lMWVUwcCsvWXNuRTByWnF4WmtKSktIRng4N3pQQ2psbklo?=
 =?utf-8?B?ekU3Y1JxdENlZUh5ZEwyRnZNSWFpMlUxV08xOElPVGFiMmdSK0JjU3I2aTFI?=
 =?utf-8?B?SGZlMWZLVmJkRUZySDF3MGFqcW81QllKT3BFd2xOb0VhN1dkV2g0aVZpOWRs?=
 =?utf-8?B?UW1NWlNyK2J2M1hKOEt4c2VKbnFKZ01pS1E3cGZabTF3N3FKRHNXQzZoanVw?=
 =?utf-8?B?MmFLN0c3cXlrZnlYN0JLVXJZcGpjUjJCbk5HcEFhRmcrSlNSRmV0d2Nxd0J3?=
 =?utf-8?B?SlpvMEJwTk9tMDlyM1V4KzJHRVAveXZqalQ4N0JFOU1SY2xtQnBGOEJtRGkz?=
 =?utf-8?B?Z0wyV2JuRjN6eEs3WHZZYzlMTkJRb1VEYU02NGllTEJ1MWk3YU5uUEQ5SGZN?=
 =?utf-8?B?Wm9yN1pvUEhOdm1wTHhkWkd4UldSQ0E4SlJPalVna1BpOHV4aWlETkhEcWc3?=
 =?utf-8?B?TWEzWTRlLzNvY1lwb3J2c2UvNko4SWo2aHZ5UXg4aDViT05CdCt6VlVKS3JC?=
 =?utf-8?B?Z01HWWRFMnJ6SnVuL3Zqc0ZNNXNiWDJhWlY1bjc2MTVrbzdvY3ZnZmVsQkVq?=
 =?utf-8?B?a0lJUVpCeDZUZnBZQTMrNlVLSmo2YTFHbjhlMEIzR05NckRWYWhKbzJSZ3M1?=
 =?utf-8?B?bE5GYmhPN2NMYkpMckgwN09SUzhCWEs0YUtUUWVWL3NNWkdwTitQNUF0QVF2?=
 =?utf-8?B?VjlQakIramEyTXRabEhiRkRnNkxXNnlBZHlBODRuY0xVUmdISEdEem05eGdC?=
 =?utf-8?B?MGw3Ynh3eDFkclorWDA0NU5IckpQK0ZtRGh4VFBwT2IzMjlzOUZWbDY3WHJP?=
 =?utf-8?B?ekdHOEdvYzJ6SmdjazRiWDBHdG9kcmdINFMvZnRSZGpjOFgwWnBQcDArVm1V?=
 =?utf-8?B?blZ3bUZaZE5CaWoraTJvWFBSU3lIaTNMa0R2eU12ZjgxTmxwVkVpTlQ1dFpC?=
 =?utf-8?B?R0Y2S2xjMDhRemNtRTFHMWllUzd6U3NGNHpEREpxVnJhdTVJcTUrVW5DRzlT?=
 =?utf-8?B?K1diWGsxQlBiRFBNcnNqeDlYZ1JtQ0xZYW45TFZsOWJQcXNla3VaOHlyWHIy?=
 =?utf-8?B?RWI3emlvRk9qank2UGdLbVFEZXV0QjNkcTd6bzZoY0RMcUQvd0RYOUNCNmpN?=
 =?utf-8?B?Q1g2SlJjejVuVEhYd1VsR3dkMmR3QTVUUUY1bTIxZ1FGNlZrSFNNclFIeVBC?=
 =?utf-8?B?MHluYjBES3hpVFljRVpjTlV0eEppakxNbmRPZ3BINStib1hmd2JzVHdrdGxU?=
 =?utf-8?B?MitYbU5McHFWcWZxbnUxdmpOZnhONHRDTnJYY2hyQ2krQ3BGaVhlN1h2SWlV?=
 =?utf-8?B?MjZMSG9NYUI2UWRERk44Rnp2SUplUlFkZy9URVYzQ2s5OGkvVXdqWkI5WU44?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3edced-3be7-46f7-42a8-08db02a15ceb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 09:07:07.6375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peORFSvU7S7Pvrj2JKXojWt9nlE70jdOigLTDxZ4rqwit5kYwv1DUsjzURLJhQtJS3XeBVuLnlg2V1fllk7zryGLNQfOmMjfA3M7diaKUR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manuel,

On 26.01.23 10:18, Manuel Traut wrote:
> 'input: pwm-beeper: add feature to set volume via sysfs' adds device
> attributes without removing them on error or if the module is unloaded.
> 
> If the module will be unloaded and loaded again it fails:
> [ 1007.918180] sysfs: cannot create duplicate filename '/devices/platform/buzzer/volume'
> 
> Therefore remove device attributes on module unloading and in case
> registration at the input subsystem fails.
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>

Thanks for picking up these old patches!
I think you need to merge this fixup patch 5/5 into patch 2/5 of this
series.

Thanks
Frieder
