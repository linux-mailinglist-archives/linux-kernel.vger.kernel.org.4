Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563AD729324
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbjFII3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbjFII2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:28:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2132.outbound.protection.outlook.com [40.107.7.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332F3C3F;
        Fri,  9 Jun 2023 01:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+d4nZb54imSSko1sqAlpcjjma7xuQi+2ix4wy2bU9QaYb39yIfRFCAONRuWbBrhre4Yw+I5HX/p9qqDs2Zrk2JI3dLGQgG4ZVyFe6g66FtGvu0eKurhYIkF0d0/Z5CtFr4xiaP6U+Rb6Zdp9nbRA9nYoVCUX4J5fvpH2K2TBxwt4eMawpLKDKq/42Yxq2+9I1hmIZ79Mv9l6nNAOQ8wLxxFCmwy+T8pfhshgGwa49sHNH2HjP9QUj25ZwWrWDMn6vRHkTIzT6UdVvQpRc5yj+mDxTAm9jKFdi+9SNLFCZF4uSU/YrvhznRixrOQPvjMmTF60tKKj/orl2ZY8eJURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jnk6V6l4VZzWX/CCOXDPPDhm6vbEW09oQTB6rEB48YU=;
 b=VcCN5na0kASXckFriImxYJCbG87MqQfEn2olO3H1t78GKWv2JVjQAwEYF2moOqmv2N79bcLqgIA+RGKWqGuPESEMZ96iQ+2RaaAma9y1J8JuACY77BWm1Mh5zm+fYmvyeWrc2WTHrRI2WC+PNAIfkNPo1bbgZCaxWteAjEqK5gyN0PvCmBtotk5LLNj9VqjC00CnHw0PDSM6bcLoj8z6dQa/1ilSEEroy5PaqXnx/aqB8wHBQonRCCgX0/CSkhZ4H9sYBRPPtGwhM9YQjNPlZOkNgWygKNam3wtVK0kMGJniUSErwDNnduP1TfL1Kw77MKxH06+ZxdUPqcJxxXgXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnk6V6l4VZzWX/CCOXDPPDhm6vbEW09oQTB6rEB48YU=;
 b=Pooi72U++gp5RxUnDwxp9CxQzYNBXxobn1W6+6gHPxKd2smNRTD0/6QBwvF7w5L9uxH06yO4x+ZdY4bKTshTSmeqPHuD+ydH7gPKM2Amv73c4bYpypTimqo/4mt7czzlPDeim94uJE9kgVVICKkoAD6Swc3ClqFqK8XcEc0TOOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 08:27:58 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 08:27:58 +0000
Message-ID: <113b1654-9fc1-50c1-fdd0-cac9574420d9@prevas.dk>
Date:   Fri, 9 Jun 2023 10:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Content-Language: en-US, da
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
References: <20230526205204.861311518@infradead.org>
 <CAHk-=wg2RHZKTN29Gr7MhgYfaNtzz58wry9jCNP75LAmQ9t8-A@mail.gmail.com>
 <20230530092342.GA149947@hirez.programming.kicks-ass.net>
 <20230606094251.GA907347@hirez.programming.kicks-ass.net>
 <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0103.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: f915f0b8-f5df-427d-123d-08db68c36e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZ8iU5+AnijlM882B3x+6qnvpF8MX4l0XEEQ1v+6KOVihAx2V7bNUr1bl0TPzleo/0tc8UDuGJmjheCxSFr6FCpGwuePmT37w6YzSEoZ+XiYfCf37p0Dp92jKjjsW8ATkDr689Hoj3z15IqQrOYKUPkNwXHEbfTFk+MMLqQn2LZEbKHrAcTwqMcvfF7+ft35cQio+D2Xn3GZzLoIX7VG/g+6pYOUYfyT8eOrvZQy9NqFceKG23zsGRjVygfR8g+Q562Z69IzgJ6qoQIRuRsoAwJWGyPbYsZsm6exUipRV6Fw5xb91zjL2BcYJCJwrkF2zdznDFNJ+bdAncS4TRgli6KrawBhYRHG3bmk+4u6ajkw/VthatUtgPtEcuCELSY5pKVqK5aVoZchJ4KMVLZ+uWxllgwu+xEBxgGq59xnvh/eyMMnCBsjUZCX7NMS2O+/uVM98gxy/9jn1kCDdMs+8BMekmVGW5x7cPrY3Y1btGSTHKeifi6QgSti+ofxJkzhBUOI3yiu1IhcLTPbm5QbyLueLBMt2gawVcPfzIypkv+LRjXBsTN6JxmbLGhfxgvdX/THV2vjL9vX4fzRrenI9TzonuKsOEareImCBgnpOEuwHBqlNPuRgJnxcbsEqF8L9TvqTiQ6NyuTWtNC5mNZvh1BsY1GrwaWSuH8WIgT1Y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39850400004)(346002)(136003)(451199021)(36756003)(2906002)(44832011)(86362001)(31696002)(7406005)(7416002)(5660300002)(31686004)(966005)(83380400001)(52116002)(6486002)(6666004)(186003)(26005)(6512007)(6506007)(478600001)(110136005)(66946007)(316002)(4326008)(66476007)(38350700002)(38100700002)(2616005)(66556008)(41300700001)(8976002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ROek5jU2ZCSVllYjUydzA2R3pyQ3hDTnpERWRkSE9GTVc5S1BPQmVtekxs?=
 =?utf-8?B?ZWluUUZKYkZsSCtWY05CSk5TaFNxamc1RnIrTnBqQ2NnSjdJeUpSb2hyRFJv?=
 =?utf-8?B?SERNTzRqdXJPd1NiT2laWlI4MmJQbWl5WWlBSWJsV05PclpGSXhhU01Xd1px?=
 =?utf-8?B?S3EyM3RDYy9GZlVTL1h2ZkdBV3FMMVYyRjAyNDhSTHg4RGpUclJMcytHbXNy?=
 =?utf-8?B?TFJQNTJoNlNRdDU3eGF4Z1plQldybmlkTFJaa3ZRVDRwUjBwdFZvZE1oR1Bu?=
 =?utf-8?B?T2FhOG9HR28yK0RvMWJEeTR2dUk0emlxNkt3cndKdEdpbmVkN0FBMTNQdmxz?=
 =?utf-8?B?U016V0V1RGtFUXVxMGtZMnJBZmlpTG8wbm5DcE5wK2wrM3VLaVhERzd5MlhL?=
 =?utf-8?B?WmRtUkpNejhoRTVZa1JyS3NKWFFUUXlaU0JjSzBjdjQxNy9PVlEyS1ZqSGlu?=
 =?utf-8?B?TjhWcm1Kd0JkVUdpMmtudGlsUkVwd1NMNGlhY3hEdWNTa2JNWW1tZ2thNElo?=
 =?utf-8?B?K1FXeWlxblp1Q29jb2t5dWtXQktjUWhQYSs5SS9UamYwQXFHZ3ZNV291c0VW?=
 =?utf-8?B?UVBkNnhFdkdtMGJ4UjdDVDdNa3ViZzQ3dHNpRUpLWVVnNjJsYzVFRzl1b0Qv?=
 =?utf-8?B?a0tna0p3b01NNEk5ZHVDK2c5b1ZqRy90M0M0R09CRnVvNmJRMmx6d3E3eW9O?=
 =?utf-8?B?SjBZbERKY0JHZHlTWTR6SWhrMnA4eGZKVTd0TUtOQkRJSnJxd2pTdGgvakEy?=
 =?utf-8?B?K1UvVHNjYmh4RmpQYzRPRFR1SHhFVWRLRStsN3pWQndwaTM4OHAxaTBJMnBx?=
 =?utf-8?B?a3Vwc0s1YVNyMmtnSXZiYlcvYlBSOXRNc2xoeGtMSXh3TmcydWtNWG51WWVl?=
 =?utf-8?B?ZXZhbHd5TEZBK1ZwV0Q3VjdyQy83V3FIZFgxeVBwQWxpSzhjcGRWYi9HeDl6?=
 =?utf-8?B?UXU5UDU1Zit0MUVZOFRua3NoZDlCdmg3RDlBK3Rmb1Q2aGtvbGsyeXRNSjdK?=
 =?utf-8?B?em5jbzV3eW5nQjZRT00yK2xHWHdDcFF1RW14ZEJIZTc2ZEN4cUlzU1FoL050?=
 =?utf-8?B?YmN2STZPVXRrK1RnbFdRWUwrUWV6cnRNZGpaRnpYVzNIU2ZrVHNqclVweTll?=
 =?utf-8?B?WW45Q3NQOUplZ0Q2Nm1ZMHExMnA0T1VHYjJZNXZFOEt1WDdZSGFTdW5ORlQv?=
 =?utf-8?B?ajJFME10bmZSVndzYm5KajErVmhvNDVJSm1ub2ZjblBYb01CWldodi8xUXJt?=
 =?utf-8?B?bkhUYklCMFk1cnVycjIweDRQTnRZOUROaTBUUk14UmpWa0xhZTFtWG0raE9k?=
 =?utf-8?B?SUU1Z01JalRacmtoQW9BQ2JsanZvTnNIcTgva05IcjlZNDE0TU10SVJ3ZHJI?=
 =?utf-8?B?ZVo1Yno1cHYxLys0Z1BWQUhrNnMxaEJMZXVrL1ltT0RwdnFkVmZoZ21Fa0VE?=
 =?utf-8?B?Q0pNQWZ5M3lkMWluMlRiR2JDamVFalRWZDlYV3Z4dXlSell6QVpPZVA5RnJW?=
 =?utf-8?B?bXc3b1pHbVVuT3Z5SytDTnErR3pEUHVDTjhOK0lBZVYzM0Zuck1aQmVaZlhO?=
 =?utf-8?B?TE9oWHZjWGx1SnhUY3VKMGlrWUd4d1dOMlYzM1FPL0F5S2pRN1lwcGVxVnpk?=
 =?utf-8?B?eDVHcnMyZ2pQeUtHR2NQKzhLanR3VHVhMDc0Y2l2UHhPUUJDdnFEM2NqYTNE?=
 =?utf-8?B?S0NOazJ1dU1WdVRUTG1HK1A2Q3k2SU4rb1E1cUprekVGNDMvZnZkRlZpWTdm?=
 =?utf-8?B?eFlPaGZia09YTGhZdU4zL3hMSXN4ZjlKRTdTOXVVYUlVbHFRQnlDSW16Q0ox?=
 =?utf-8?B?K04wSXdYUGNVRGl3aS92cjJjeWhWR3ArS0pVNDRIQVplcmpwRm5ESUUrZXBa?=
 =?utf-8?B?SjBtcUl5dHNnNnVNUEJLNzFkNG54aGVpbGtZMk9RaDZWUmNrTnJUbmlaeExX?=
 =?utf-8?B?RUdyc0dCeGFIVEpMemlUTmI0WWsvcU9lL3Q4eUVHdTJQRmVnd0xqeW9rb21m?=
 =?utf-8?B?Wlhheld0eXhkdlVGOXpyR2ZtR2FkVVgyb0xXSFBIQyt5QTErMk96Ymh6U3Ns?=
 =?utf-8?B?ZXpObVVqV3kxTlRmR25KV24yL0MvWHg1YWZ2bG1CYVpyNDlwemlJTGZFWmNX?=
 =?utf-8?B?N3hSZ0FZcEkvNTVDSGpvc3pOcDRmbkF3My9wMG8wcHNXMWNBZDViWEtVS1hG?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f915f0b8-f5df-427d-123d-08db68c36e2c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 08:27:58.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99duQ7i33+7MKXxemJbgGFvLj5jX8/2F8prK9LnQRTYofiHVxfGUx7rxAmrDT5FMceRvjDV449DpPtC1wZE9N6fOBdmSLJ0asj0PYaItesA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7709
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 17.45, Linus Torvalds wrote:

> And no, I didn't think too much about those names. "__automatic_kfree"
> is too damn long to type, but you hated "auto". And "no_free_ptr()" is
> not wonderful name either. But I tried to make the naming at least be
> obvious, if not wonderful.

No opinion either way, just throwing a data point out there:

So the systemd codebase makes quite heavy use of this automatic cleanup
stuff. Their name for no_free_ptr is TAKE_PTR(), and the verb "take"
apparently comes from Rust:

//// src/fundamental/macro-fundamental.h

/* Takes inspiration from Rust's Option::take() method: reads and
returns a pointer, but at the same time
 * resets it to NULL. See:
https://doc.rust-lang.org/std/option/enum.Option.html#method.take */
#define TAKE_GENERIC(var, type, nullvalue)                       \
        ({                                                       \
                type *_pvar_ = &(var);                           \
                type _var_ = *_pvar_;                            \
                type _nullvalue_ = nullvalue;                    \
                *_pvar_ = _nullvalue_;                           \
                _var_;                                           \
        })
#define TAKE_PTR_TYPE(ptr, type) TAKE_GENERIC(ptr, type, NULL)
#define TAKE_PTR(ptr) TAKE_PTR_TYPE(ptr, typeof(ptr))
#define TAKE_STRUCT_TYPE(s, type) TAKE_GENERIC(s, type, {})
#define TAKE_STRUCT(s) TAKE_STRUCT_TYPE(s, typeof(s))


and then they also have a

/* Like TAKE_PTR() but for file descriptors, resetting them to -EBADF */
#define TAKE_FD(fd) TAKE_GENERIC(fd, int, -EBADF)

with their "auto-close fd" helper of course knowing to ignore any
negative value.

Rasmus

