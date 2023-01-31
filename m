Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD1B682AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAaK7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjAaK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:59:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2127.outbound.protection.outlook.com [40.107.8.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F03433D;
        Tue, 31 Jan 2023 02:58:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfLd24w2+lKJjjMg1edaBU0I9Sinkm18QnpccE+QYca17HGP0B1Lou1/2wmT7h1L/+Oaab97xF72YAqGHIajQmVW/zHwLicPiLYhWBNIIDUXaml7ofLZuFRASu110cvx1FQ/sq+S46p1DCfa705XRR9n95q/LmbHCwVPt+tZxS4Am+hdlZaWIkN7HCjLU9QsBUM9N1m6pOuHj3aIDgJ65htTFxA10nOOxdz12u0BeGrz7Fo+ICNp/fYh8M3MMWIY51NPkwDvplnmRVAIWaF4uzk5+Okcj5vna0dW5Z99u+PwZhBvOedrf0LTxNwS+loRiHfihN7fEapIBqwj4IlOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU2nQAausTJtJJhwWBmTv5SiqQpfG+DCsDkVJDAF1fA=;
 b=j+A60xOEHN/Ose17odpl38Iy6MUEUSZM0hHYqMC+QQe80O3wPXHGLJVM2vlwvPUpUzB45nT4pTPhgkhOGRBz2eFfnvURgAauivpZElZJS++WFl9UK//k8mCXinKHA+wgL3S6o+xbiu2Ca7jNb3XzPAVvmBzoklz2qpzBpA+wIkOOoFyER0nu9TX3aphojTLsOEqDqRcA2ZkOScbvkmy1ZgradssT+mRzASl/C2g8FYZPUZDJN7BOkDp/t+MUN5mdbdS7mPb95CNkbTdCyHQi4PyK1yAYDAG7aRTyMRELtrO7tWNrS5olHdgiJaQsEVPyiV4n+fXsfNMtQ5/1ijlpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU2nQAausTJtJJhwWBmTv5SiqQpfG+DCsDkVJDAF1fA=;
 b=KRkaehagzH27YAJfHL/hJipxQ+2uwN47Pmr+8kgRe7xhf6FwAELk0hrlFhbv+tMa1AjoBhPHF0BeYj9YOLzhvnSFUZlPz2f7VjZAmE6qJ7AAqkxS8kFwHUAfAlB75GJnUmm4wvFcUclag4NYIQXtYK61F3ku+HiVZ5n5OLCUE0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AM0PR10MB3652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 10:58:57 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1286:27db:9d8a:4b72]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1286:27db:9d8a:4b72%9]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 10:58:56 +0000
Message-ID: <fd1ca57c-1ab7-fa4f-12ba-4e8fd5fef6f9@prevas.dk>
Date:   Tue, 31 Jan 2023 11:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH resend] compiler-intel: Remove duplicate RELOC_HIDE()
Content-Language: en-US, da
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <35c0fc4ba93b11c4b8a55c2907f736a840cd12a3.1675161286.git.geert+renesas@glider.be>
 <9d2450ce-6ba2-49eb-9f00-bcb1b8590eeb@app.fastmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <9d2450ce-6ba2-49eb-9f00-bcb1b8590eeb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:205:2::20) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AM0PR10MB3652:EE_
X-MS-Office365-Filtering-Correlation-Id: ae40d3ed-b133-4137-1173-08db037a265e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vx3RgliL8XEE8bExDTtJio4fxVsM1WYkeLbnS15EHx6h7fRom7fss54AgYLZD4OceZURMfVxn7wD6YIsWiYAKR0Ag75otdRBSSI30af5txYPQlJJsUgJFNwDAqOg+C2Xrt+dyx6PhBu7FaYi95n6c2pQ/OmjcpmsA0mNFBsBA21mV/D/H6zgcKyp33Dp8/CopAwb3jjH/MFjwaAfSwKTsLIHdQ9O9/FPyz+FqZyIxKCy5vZJgm93vlG8MfSh2yHN5efS1j12LNt9YRYhZPmegBsPP8STOWxBDBQi4sLo8CgCijcu30mVU3erggFKiJMWqlLg6ef+oYpqP/wZPwzrJSW+wdTLC8M21mh82GZDOemk6vEQAJ1JN+ydNcXmYUYqae4UpaT2UOzRR27cE8Kh+3W8sx0jVcysQIQbnuBbFx0+7N4UX1iQGdcnGYMoI/yW02/JqG34ny48gylP3reT4GouKGFurRxiG6LslObFGn637WQeej8y84WKXBev7XkuUknkxnnnT9Cwxi4AuGoQg41jA2bwQDpjNVC1cqZZd43KMg7pl4ykcFiGL0hhxzcThe7bHnNhlxrFrOVMht3QwUjV4VQgjq+9Kimy1s+FI3jOoP6sPu3zyrXGcwXhODB08ok5B9ODe9IGDmHhVIMhsE5rqczfYcMy7BgiBNI/LC20isSitZ7qjA4P1Zu0OVVe54OMaqCbVn/zys4ViAzTyeSVU0vf1U93Kl8otldOVEZNpsIM3YeSHywVNDqqN2xsDzucPpcrGMscnNgSKZ3nVa7zw1SPQ0j4IBoeAoOjb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(136003)(366004)(346002)(396003)(376002)(451199018)(2906002)(31686004)(4744005)(44832011)(5660300002)(8976002)(8936002)(86362001)(83380400001)(41300700001)(66946007)(6506007)(4326008)(66556008)(110136005)(8676002)(36756003)(478600001)(6512007)(186003)(26005)(52116002)(6486002)(66476007)(966005)(38100700002)(38350700002)(2616005)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitnZUUvQlYweW9UYWlQMER6SXNMQ1ZyRGZXU0NWVnE2MWY4U3diNjV3WUZl?=
 =?utf-8?B?MHAzcGJCOEd3T3N0OHYzVmFWWmxrWHhaakloMXBpMnJOZHlBVE5NY2dQdFR2?=
 =?utf-8?B?VG9nTk1KRFBRSHpiMnVqV1pPK0lSaWptMmVndzZpSmFyMU1mb0hlRDVaTzdn?=
 =?utf-8?B?dGlsWERXUWlVVCtyTUx5dHJzcDJidGR6dGlUTUNvbVpHekNyZUtVQ085bTg2?=
 =?utf-8?B?OEFQSXAyRDk0YWFBRnV0MHh6Ykh1YU1HRU1wbTI1NlNIM0JlbkZKL2RlUWhI?=
 =?utf-8?B?TTR6Ymk0a3RvUm9wWFlMTXBoWFA3MGNSb0xNaS9iVUNIa041RzdsYzhSUGhD?=
 =?utf-8?B?VUZWWmZKRnBaT1VDOFN2Qkp5eEo2RTNNbW9RQ2QzcHZUVTFlV0JRT0RlSS9V?=
 =?utf-8?B?NnIyZjJHR1VPeE1TT2lBSDFZSWx0Z0RzWk1tV1p6M05MZjh4Ni9VWGk5M0FM?=
 =?utf-8?B?SSs0OGQvUjgxeXdmYUpaTG8yMCtnTldKQko4a25lUXFLS2hTSUxjOWx5N2NL?=
 =?utf-8?B?N0VSRGIxTTl0dTFscHdaTkxoQjU3bXQ3RE1ZcGRNRE1ZV0lhdUJuMVozdXVF?=
 =?utf-8?B?Z0YzaEQ2Vm9zd3NmSXFEUFRLdWJFSHdYZFRsRHNmTWp6UnJZNmRicXFjU1NT?=
 =?utf-8?B?K3pFemZFUndkTDJZZ0hUM3lCVXFCaWhJR0FFREFxdTFZQ1lLMWE1R2Jnb05q?=
 =?utf-8?B?ZmwvSXV6cWVXSU9adzhIbnAyTUdEOWRhWHhzZktBN09Bd2I2UjA0WTIwWUhZ?=
 =?utf-8?B?TFNKaWZRYUR1Q3Rob2JYMk1BSUYycERPam9CamRyVWM4UzVNQlYvMzNvQmpT?=
 =?utf-8?B?WTVvK3h1Mlh4UmhCV2VtQVZ3OTFKclYwc0RYYkhYNzdpUEQ3UXRxV2wvRWtl?=
 =?utf-8?B?NHBOSG1KcVBnNFk1T1pENnh0QnRydzZrN1JqMXZ3dkRjSmFZdjNVTnYwQnhu?=
 =?utf-8?B?NWJ3eFJpdjdqd1g0WXJzdFd6RzZuU2pSZkc4N2FGWFRmNGpkKzdYMlFWd1Ny?=
 =?utf-8?B?cE1NNUYxenZjbXlicTFEVEt2Vms5T3NDTU41RHBUdE5ac01WUWVSWXgvcHVz?=
 =?utf-8?B?VWQweE9iQmt1SUlFMUhoVzNzcjd4V0E3eHhWMWVqK3Q1NzFsZjRUNGZpTEJz?=
 =?utf-8?B?dUw0ODQyaFJYWC9aZVBycStWSzRJRXg0eU9UbDFtVzhudmp5TDVrdVo5WFFl?=
 =?utf-8?B?KzA4WTlDRHdRWjBBa3l0ZnUvU0xTRWJCUnNKVXlPRDR5eG1ya0pYaCtoREJp?=
 =?utf-8?B?YVk4R0N6K29GM3lXVEdsU3p1WW8wcU5GZHRjZWdINzBVZklMNDFreGhXSTdh?=
 =?utf-8?B?NHhCbllnd09BdjRtWThidW9vWXI5OE5qMnpnMlJSSmJHVXlHK0dxQ092MFdK?=
 =?utf-8?B?TnQ4TlArS1Y5MEpiYk1ScEVKQUlvUTVSak92MjQ5UDk0bFc0TldreTVFMElY?=
 =?utf-8?B?YjdXUU0vQzA2OXljeHhlTjU1Q0xkbXF6eVVRd0cvOG14VDdmbENKUVNDZDBq?=
 =?utf-8?B?dWZLUndNU3B0ZC9ZOVFvZnZRKzcxK0lUWHVQN1l5eVRPVEd1VTZFSldCODQv?=
 =?utf-8?B?elNJRVhYT1FHemJnY3A0UVdIdnQ3ZW05ZmZIU2ppTmVrUmlhQjMyaCs4ZG4z?=
 =?utf-8?B?NHVNRWNEV09veDBYVWEvbGdPY2p0UjVIbmpNZlpaemNQY1dHL25vRTZCQVB3?=
 =?utf-8?B?M3RBT2o0aHhPbEhHQkRMb05YZGttS1dwdDM2R0dwbkRkZFZMNGg3ZXozS3VC?=
 =?utf-8?B?UnBndWM2bTlCSHZEbXpZY3UwclBEZkNJSzh3Yjd3OHZNSWE3c28xdWs0OHI0?=
 =?utf-8?B?L0w1ektuY21WV1JQQUxseVRISjlwNFFNb0ZqNUNGL0dNSDNKTWxnTVl1d0ZV?=
 =?utf-8?B?NVpyWjVwc2ZVS2ZZY1FJS2llUnNKNDlRUWNjYWVIeFo2dWpuanNlaFBIRlhE?=
 =?utf-8?B?MGZqRFVuSGpFRWVEV05BcXc5a1ZQSjIzb1RzRXZTejYwd2RsUHljYjVEYnYx?=
 =?utf-8?B?dnF1L2V3ZWNXSE1IMmx3NEgvd2JKNVJDREpyTEx5amRZTlNGalFnanorWGxB?=
 =?utf-8?B?Mm12djAwdllsbzFDVGdyMm9LUFN3LzYrUFJKMU5RamJNclVmWlRoYTJoTHN6?=
 =?utf-8?B?VS9Ob2pwdk5Xa2RnTmRjbEh3UFVGTE9Vei9IWHJiRGVWY1R5UGFEci92eFlW?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ae40d3ed-b133-4137-1173-08db037a265e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 10:58:56.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hNrRxXYsCR5RTH6xG733rkwQmN5z7rbxQBkTbMwo3Dl6lmfTHst3+7TR3u1zvoLc0DSVGUkA28OSaIr1s1ln34bogNttHJXIhSWUDfeaUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3652
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 11.41, Arnd Bergmann wrote:
> On Tue, Jan 31, 2023, at 11:37, Geert Uytterhoeven wrote:
>> The RELOC_HIDE() implementation for the Intel compiler is identical to
>> the generic version in <linux/compiler.h>, so the former can just be
>> removed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Not even compile-tested.
>> ---
>>  include/linux/compiler-intel.h | 5 -----
>>  1 file changed, 5 deletions(-)
> 
> I thought the entire file was gone already. I don't see anyone
> objecting to the earlier patch
> 
> https://lore.kernel.org/all/20221016182349.49308-1-masahiroy@kernel.org/
> 
> but it never made it in. Maybe we can revive that instead?

Yes, please!

