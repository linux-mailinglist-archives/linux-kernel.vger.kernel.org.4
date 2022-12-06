Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6525564423C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiLFLhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLFLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:37:07 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2108.outbound.protection.outlook.com [40.107.21.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDDCE3B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:37:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVJCppWKiui0bcsXRQsM9JJi6m6JfaZ9HwJH5usFnJmn+VVWHB/PortP2T6K9FcjQk/vAXd9rtmkF6wH8lVRNUAFxORu2nnV5AUG6QshFkYBoczL1sEnV4NNyc4zDby95nW7ckVMHTWNCeHBP9v5akh437vlnaDL/N5hNd+6Ct9ajnJ+2IN8lFgKmEicTlUkA1EHftO9ZX6EVF0vpqZyujQWmm4Ba4jKhyep1QGCjcfRTH7SIIVGBCqZLdc4wUOt470bA89RVTV8e4oVCPmWMbdYIJP4i5AGQ8m+D9tN0cNZssylyS7HcBUeTaRaJGCnqw1x9Zllb/t3FwedB44tPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itH3zC3hBn+5fO9ZxqKQ1Ca3nuJm9tamdTyLySDyjjk=;
 b=UAP72EGk3T4py2GKAyY7oz+gSS0uC0UqxxEbaIs61hLiCm81PhuQ2AJAsPlW0sC3XFwsnVmgbjWun7sBIveHmZiNpvQCziPcanb5qH9gRCKE2GT/nCCqHaqOnpxrTj7yfVPEhNSeM3zqAnqVuTnVeEh5qS3JWUK3LRdelmbHB29AIgYXv9WUK7aBFlnNxsObt4sEiG2V68JBj5d3iywAazVQcs10dZgU+r+rh2YXF3E1Dwbq3MMUOKV3hDbJeM6wl5tIHWdsvywxB4AB6mSU9bcAd52KelHrXlcpsoF2GrDz7pbRIDBc1IenjMX9D65HsKNG0sYTkAmhp2j9ErWa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itH3zC3hBn+5fO9ZxqKQ1Ca3nuJm9tamdTyLySDyjjk=;
 b=RodBKMxr3WlK88J8e8N1V2I5bBfTfpz6UnjaPlF7ROqU8zPBi8Kuhh+FJ2TCIA3l5r3merlWLnkZ6n6cxRYKaa7kYs+dxDOD3yuFozUwlWuSR6+y4jyMjdNmWsjnfKFS446i781hCWXu0q0g/BjZ5cO7rG9yK9U39lBpFQ5n0Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PRAPR10MB5398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:292::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 11:37:04 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%6]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 11:37:04 +0000
Message-ID: <208ffab6-a20b-c6f0-7ea7-cb258a7c894c@kontron.de>
Date:   Tue, 6 Dec 2022 12:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vlim <vlim@gigadevice.com>
Cc:     Michael Walle <michael@walle.cc>,
        Victor Lim <victorswlim@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikhyat.goyal@amd.com" <vikhyat.goyal@amd.com>,
        "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
        "alejandro.carmona@amd.com" <alejandro.carmona@amd.com>
References: <20221204080000.4100-1-vlim@gigadevice.com>
 <dee37d18f8de5af7d07388031fc08571@walle.cc>
 <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <20221206091846.02f6396f@xps-13>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221206091846.02f6396f@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:205:1::21) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PRAPR10MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe3543e-2bee-48b2-e871-08dad77e32c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVf46CvFt84DXpe1BnE1V7YzESpbJ5iPZqfWDilPRNHa5VtKV1xmGh6Tjmc+D17XryEHrn+ut3OmptEZHHZkJOEHipNXa5GxKd4br79fyEWsZJKsaC6dQrlatnpYxjldUSaV9yiNfyarfagNJggUd9/h+tfdBlGe4r2nCPEDgjZn5UDjoNhNpBNpR9QnBbX119RolQtdFhh2z9jnm+f/uh9ub3GCHidwQJN9lTAuwExbt8c/oohtZRuyv4GkfsMIXd2Fh5fNyaTai3bWoxBZqbAgi7veWE2DPVEnvWs7r4qrMpX2bEZzxxTigbYzwFG8oeE25MJtO8NKdlIKQwfGx46a+fAH2Q0En8DKFGkcQTEDIn6x9IggozaW+VVC1nvsiV4h3RCep6dZvIeKF08kJSk4DXZK6x7kZ9JAaZ4gxRBP6mUzSmyGCOiernvloOa5IfuD/3yVrb3M+hoypujm0RL3VzBM2VAq2PEwNm+7APT1jtSKRpiJaynFrle0OhgjCPdTmgDx+QoXHDvYwselM5TvyM4eICLf4q3lgLcsNoIm5q8OUlBBEN0qLeVIizWFxo0OV0uR0GSdfofHCOis6mWN0YzPMey56qveZEiQrPi/TLYIGCzNHKWmFoW/KwkQfuknctwE7vkJyFumZC7B6NoXeXqi0zaEYDjqQe94KhaOYZCXNOhJLAl+GFY/wNvr4LtU6nK1xQK3U5QA1kE/8ILSGKin8FxG2r2r0ZJanNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(6486002)(66556008)(66476007)(8676002)(4326008)(31686004)(4744005)(44832011)(2906002)(66946007)(316002)(7416002)(36756003)(110136005)(5660300002)(54906003)(86362001)(31696002)(6506007)(53546011)(186003)(6512007)(8936002)(26005)(478600001)(38100700002)(2616005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVKMkdSYTdHSC80c3pBY0dWM3JQeFRnanhJRS9UTk40QlNXTEIrQnpVaVBv?=
 =?utf-8?B?NGJWbExiRlQ1TzdyRjZJSVhiNjFlcEtMNFhGV3lwSDhmU1ZET0NpdFVvVDhl?=
 =?utf-8?B?OFBsRmxYTHVqS3dwczF0RlMvanJDMUpRSkpuc2F5TzlvSnU1WDhGaGk1VElS?=
 =?utf-8?B?T0xhbFN0NUkxekIwQXEwL1pHVk94eVdtRDVpT3B2NjEzZG9hZnRxd3hubGNN?=
 =?utf-8?B?U2FpdTFkajZiUmV6VmdFQ2FUREYyYnBrZEFCVHR3aG1NUXZPZy9lZlJTQWJK?=
 =?utf-8?B?bVlBVG16ay95eGZhaGlwYkhUV3lxUTZrRmFTY3g4NVZOVmZuTVpBcmE4VWFq?=
 =?utf-8?B?d3BrZjBQYlBRWVRPTU5Qc2hrbEtuWjZYekZwcGNwcTlFUG4vQk5tQ3dYbEpV?=
 =?utf-8?B?bCtwS1VKWnZvRjBVRG5qWi90RVNtcVpSODNPRUc3a0tyN3ZrbTFnT285Zlhk?=
 =?utf-8?B?NlZGL2tYTjY1c1J2TkdSR00xK0pGMjdMaFdWY3IzWVVSeUVhUzNWWWlnS25k?=
 =?utf-8?B?OVgreWxSMVlkSEM2c1RKVnE1ajQxSUhla1pZOEFJZ3hJU2R0cWc4MXVJS1dX?=
 =?utf-8?B?azVnZjc2RTZMNnNNOGVNSUVVeVozTkJtRDVwVzdXQ2hDYTVadkJSUk1PaHZC?=
 =?utf-8?B?bldkaFBhZWt0YUlsNno2OUp4RFNMSzUrb1I1S2dwUDhpMTRCVm5nMVhoQTRS?=
 =?utf-8?B?MXd4UXJySmQ5c0lpVnF6YUVLOXRCMVhQNG40Um9XZERUcjRoVjA4UDVsdEcy?=
 =?utf-8?B?ckdGanFOZDhYNUltYUV2U0FvbU8xTXBTZnVXdEZ4UXdrVkxRQ2VzcmZXTzVi?=
 =?utf-8?B?dUFqS1lJRFZOZFpYcENFT2xuaWxxRHZ1M0FJSExwQ1BlUnRyTTliSjBHQmZn?=
 =?utf-8?B?UEthWW5qY0hWODBCSkpaRis4VjJWVGJJM25qYldWMXF3ZlQ1bG9XemdrL2Ir?=
 =?utf-8?B?NjMvY29UNHhIVkw5UFUrbSs2Y0ZqN0pOMVN5L01MQzRHN2IvejFMeU1Ia0Zw?=
 =?utf-8?B?NWlQdzE2ZFEzWUVqZndiM0RFTHU1U3AxRkRqYno2RHVTdzdXOGJ6Ukw1emtQ?=
 =?utf-8?B?TjBtOWR6bE5xYU5ha0x2L1NGMk5CWmw0RHNIa3J5NFhhOUFPNTZmNlFSTjZP?=
 =?utf-8?B?VGZFNERWT25CM2ZCUjJKbzEwa0QycXg1aXIrZEk4N3pxRGRuRldLV0tZS01E?=
 =?utf-8?B?ODBjYWwxV0xzemtBbzI0RUlaaFpqY3BKTXFSODVXcWkySTlGcktzUUo0bmZm?=
 =?utf-8?B?YUw2K3NKd0liOVczZDV1TUVKUWowWnN5MTg5YjJLOTdKTFFLZjRTQkpON29Q?=
 =?utf-8?B?Q1RpR1pWZEpjdmZnM3lRUjBvcmlaQUoraE1kaHJjWEdSSS9yMlY4ZG9yQTR2?=
 =?utf-8?B?VmJad0dxUnEzaWYvTWhJQnp5dEN0ekh2ZGFqUlU5aW4raEtldmhCTjFoK2NW?=
 =?utf-8?B?Q0FZcVJxQWJJaEJXMUQzV2NybTFuNmZUdGt2emNzYjZtNDVpaXJNcU5GZlpy?=
 =?utf-8?B?bHJCN0Q0OHkxVm9hTG1HT21KYTVaS2l3YUE2RzExOWVpQWl6cU1EeTk1ZEpW?=
 =?utf-8?B?R3pUdmJxQ29BcGJFT2NTNENTQ0Z0WENPTUd6UVhoVmt4bGpsT0hvbEw4R0tK?=
 =?utf-8?B?RWVTeVQxM1Q2Tmx1RzB1RlFOYzAvdHM2V1F6WEh3MGpuaGd3QWF4ZHB6UWFF?=
 =?utf-8?B?Nkc1OU9rZlNoSUZYLzEybDRyS3hLWERudDlOSGN4MTA5blBzN3lMNzM0YmhI?=
 =?utf-8?B?dzFrMlFtZjAralUzM0FKNklOQVJlb3lDcExEeVppR1U5U0pZVW1BVjBSZXhi?=
 =?utf-8?B?c3ZBRkQveUF6b3VVdnJ0ODd5RmVRMWlZQi9NbEJxaHdQdmN5UVptYXNKSjNK?=
 =?utf-8?B?ZzViQkJiMGNRY3A4VHBOTEdyZzlzMFhYekhDNHpvTVUvMXFmL2ErQTJ0bnpR?=
 =?utf-8?B?UHZWSGRxY3NBOGVsbllDelMxeldJWmhNNFN5UDNCeWUzdy9JM2pBdEhHOEpZ?=
 =?utf-8?B?cTBHQ3RHZXJPYlBBNEloWmowYkZqWGFBeFhqRmZVRm5JN094dmt0L3NkZDF6?=
 =?utf-8?B?TWhDWVplVGdnYWxTVzVxUllLdnJOZHYzcFJ0ZkxVMWR2NGlwOStGbkMyYVRk?=
 =?utf-8?B?QTVmQ2Z5TVBNUTB3SXlaR0pYWmNZOTdOWWtZRkprcUtqOWpIb2RsdkpBQmpY?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe3543e-2bee-48b2-e871-08dad77e32c0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 11:37:04.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmNkZQhTLWGzf5/1kcoBdVbCPGdutkWDVylGFpf8p99oIxE83Jt28BzYHRlpLGfDsWeqXIB45sk0VUAmjRStD1RxyZV3pBrDolXG1PuZEwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5398
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.22 09:18, Miquel Raynal wrote:
> Hi Vlim,
> 
> vlim@gigadevice.com wrote on Tue, 6 Dec 2022 01:27:13 +0000:
> 
>> Hi, Michael,
>>
>> I will redo the patch following this doc.
>> At the meantime, can you point out a few mistakes that I am making so that I can correct it in the next submit.
> 
> Here are a few:
> - The title is wrong (git log --oneline <file> for hints)
> - The commit log is useless
> - Don't make unrelated changes in your commit, one change == one commit
> - Don't change how the code looks like for no reason or justification
> 
> And please avoid top posting when answering.

Here are some more:

* sending (almost) the same wrong patch again ignoring feedback from
maintainers
* not using version prefixes in your subject line (PATCH v2: ...)
* not adding a changelog to your patch
* keeping your replies off the mailing list (probably your @gigadevice
address is not subscribed!?)
