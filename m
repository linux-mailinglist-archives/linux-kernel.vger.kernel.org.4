Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7262F00C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiKRItx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiKRItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:49:31 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2097.outbound.protection.outlook.com [40.107.21.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC71DC;
        Fri, 18 Nov 2022 00:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkUxFzUMSd1nicjJOS31DqacU/f4V9N2YpBqdZa8332RW6Y25ywJstTAMBggFWaHFwt0EBNlNlu4AIZs1j5deL4kUHSK83T52A1siDwUXE/MY8C+l7j6fo0DIDsIM/Eh3K6PqtlT4jCe6N7TdAkB3PRBNYjHIi56Bbz7oQMOp1vY5r7eZY0Cs72Ptz64NPekMk9Jt3xDqVp3P7LvmfpXx498Z6BhLo+SzUnKz+aKv8VbAQX4mL4F340Z8nvWuglhX7icadMI/r/D4WQmP+4ugc/nVvSCcM3P3RhvwnxfYHZgxo7Hlw+5dHz8DC/H03jPDLMvsqxjQoURZYDk7ia9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC057QHQhoclD6CDqLIe4DqQ8iBr9Ld7Ibzdj4b2SwA=;
 b=La5vqZ0nVsmYqNKoiznqO7S6hs6Qls2kvnKHrmcpsmJyKBSKSMzYGO63FT3YmkYJS3JzqjjCwfyNKT59OjcboinHwbV0ISA4ywZKrB4BtTXYLb/8aXmCHEH23q9A1TTp2Z2J3UVjfxakcQcFwYv1iaaV2KAKNMf9ODnLq1HTLNnef1oJDZLkGPH7GpKWaQULfwC/Mu0lcREMzM69uXhEfsEfdnkYXljdnVj86DVxG1rKjUFoaBREQfgn3xk46VHamPyze9A9TATXizM8kv53iEDRSoyqIg30uyTDssWADP/BPkVcYl8DlW4HQEmNhg5Lxz8ZWHYq2JHojFMdH9BWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC057QHQhoclD6CDqLIe4DqQ8iBr9Ld7Ibzdj4b2SwA=;
 b=adB1PlIjcBYpMXKixDNL2zhQpGkcHsmF1jyETW7raTC4xp3fcgBUyMNBN8H5Xo+rKaEiEwY8gdthXl0esrJAcmVHA4forvnEG6D+bGZE+WvoElKz5OpyWVv/zwT1g/3tpkWwQ1NArx6o+6e56l6hdf9nWij7SJnJoKuSG4at3wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by PAWPR10MB7747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:366::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 08:49:21 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%4]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 08:49:20 +0000
Message-ID: <90e0cc7f-1cad-bb1f-448f-673dcf25cb15@prevas.dk>
Date:   Fri, 18 Nov 2022 09:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Coverity: add_early_randomness(): Integer handling issues
Content-Language: en-US, da
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        coverity-bot <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
References: <202211080929.F5B344C9F@keescook>
 <CAHmME9o_vJL6YstAGutZNzQ30EmWQ5vcYqbeFYoSvPm3CYeXzg@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAHmME9o_vJL6YstAGutZNzQ30EmWQ5vcYqbeFYoSvPm3CYeXzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0070.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::29) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|PAWPR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a23e64-5c81-4aa8-429f-08dac941c8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrIvP/gg19ssBJ1Mg95A2po6kIRjUgfBNI3+us9ZEhoROL2t4Dng8MFMQ90YwFQB5IVT2ktTvj8xy252orcKkfHAlXUyaFM6JVh+EEMKV/pwjNPypia/zrKQWiTwCTPHUgUQXNPUm9DA0sqits7SLyG0qc6Dzefv38323KZ9jIJEPPyIeQJ6AyzxqcS2YrS80VUJ52np6oj8Ix4XOtdkfOJrJKnGmuULEH/1aetY8wIS9vx0TjBtyMC1kCpS7lbNS9j3j2r/TEZiJtlcu38NH90uLHshhccYTc7YJ9cRCRU9GZUL15lhqibemM++26PaJKONSAWFV/TzAmX2Epvuqev4V/y/wXm2pLaoF7aluh2HhB/46sxeAnc6ZHESJKwuP2X0vkzJZMPZeVhadrsBFjOFq470dPxcc8CUX5JB/Tmuu8FXCe43CyRhbyoQOP9wd5rmFr4mAyvnUR85Tu6JebWGC61zKwR8S/c+DGYc+R5nfCJtWoISYmLWDzZQKmlMQQWyENGLbCxRx8WPBVNUGbUYizkCElMTTE5xgMpLjMzHiqzZg2T1/zYgry/prGRQ5Biwsom08ttIxVuQTugom8sScIPFmao+ygJ5FP3HRVdjc++QpKE855lh7TwY36YeW5WfMQp8Cc2Z7hbBPBeUaeXNt3rKcx+TKqQvUsBJmBNGWGZLQW0MRZW7nrspUldYMUzkl//wwycNOWxGZMki6Y1G2g047gJtGStKnaVXz08+lnUiqF5OqIMOADBvb36x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(39850400004)(376002)(136003)(396003)(366004)(451199015)(86362001)(66476007)(31696002)(6506007)(36756003)(2616005)(8976002)(66556008)(66946007)(44832011)(4326008)(4744005)(38350700002)(5660300002)(8676002)(6486002)(6666004)(478600001)(316002)(41300700001)(52116002)(7416002)(110136005)(54906003)(186003)(38100700002)(6512007)(8936002)(26005)(2906002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDlNdXVPQWErMXptU2xDN3htTVJRYUp4Q0toWUExUFhpc3NSbWNTYVl0ckdH?=
 =?utf-8?B?RWpaZG5WaDMwaU1NaG8yTWZ6anBpSXdOYnN0YTVQQ1VrV21XSDNqMEpvRzZw?=
 =?utf-8?B?dWxISHM2cTZIUlZqQ2pUU1p5cXBwUnhja3pCWW9ZU0gvRnZWa1FaejhKR3JO?=
 =?utf-8?B?TzhlejZuTXZJY3hVbDlGOXVPM293RzAraHdGSTFMSHZMMXVvejJhZlZHUlkx?=
 =?utf-8?B?UVQrZ1dnazRXb25EME1tMnIvaGJPelhnR01EYVphbmV2T0VMakZlNmp6VWk4?=
 =?utf-8?B?cVRScE9rSVErVmppVHd1ZWoxRXFJZUdHNE5uM2t3cHN1M0YzQm91enpCNWpY?=
 =?utf-8?B?M3M4Mm1qL1cxbFB2ZHdHbnRyVHBTdWtXQmhoSDZhVGx3MjJpU0JwOGNUWm5r?=
 =?utf-8?B?NytPR29SQU1KYVUwcXV1TklIeitQOEpXRks4ZHVSL3lZcmdRMHFjUDF6akRh?=
 =?utf-8?B?TG5GNEFKQTRITFBDY1J6eUlYdVpmb0Z4REtOR2IzTGJ5N05TVkxWUzZmdEFa?=
 =?utf-8?B?Q2F4NDhaNW14YmE1M09lUW9XQ1pjRUVHakJGWVBWTm5jcm04UTdJNXJ3aEdq?=
 =?utf-8?B?SFV0dUZLenRLU3hkUWMyL1FGRGVWOUxCcWxuV2grVTIxNjlrNVdzYnQwRFJ4?=
 =?utf-8?B?dTZReWtPTzZOQllNejB3T1ExZjYwSS9TNU5KY1IzRnJqV2dCSS9oZFhISHlE?=
 =?utf-8?B?VFNCUDQ4V2crbUcvWjFYYzVwSk0rUXFmSVlKbFNBZncwQ2hiSUg1d1VubGdw?=
 =?utf-8?B?RDdnSTNic1VnUmdYb2xieUZhdjlWS3pQZnRNYitSUmlFamhiS0FyY2QzK3o1?=
 =?utf-8?B?dEU4NzVjZFZQOU5PZUtJcWU0U3lFU09obmZsN2hwc25nSjV2dkZ4b24zcXRz?=
 =?utf-8?B?SHhVY2tBOGpDVTY1Z08wR0lPR01oVlVndXBCT3pZWlBtZ2ppbE55Yjh1OGJu?=
 =?utf-8?B?ZzN5RW9oOE5zTzM4S005ZitnR2FwelVYOXhjMjliZlVNZGV0TWM5aEtzQjBr?=
 =?utf-8?B?UWIvb2xMMUtmdTFrU3IwbWl4UkxIemU0ZE9HNERzRllnbld3UUVEdkpQREh5?=
 =?utf-8?B?MzFrTDEwLzBhYkovTEh0QWZvRDU4WUQycWxSc3BrdUEvcTdRQlBVTHBUTUFk?=
 =?utf-8?B?dG1WWmh2THg0VG9laFZqaFVVZlFBNGdWaDNPOEhwRWErQ1ZuMytNQXVjbi83?=
 =?utf-8?B?Nk5ZNkJ3SDZVTFRkdFVoY01wVWhqVDRBcG9jKzkvd0I0aWRZdUxyVStJWkNN?=
 =?utf-8?B?NFFuMVBJTlhWWXdtRWUvbGsxZWlYNndpVTJaMHBQeW45NzhwVDNBaHhaS0NY?=
 =?utf-8?B?R1cyQkt6MDc1S3BSK0hTdTBDdTdzUWYxV081dCtvUXZqL2M2R0hwODJBQyt1?=
 =?utf-8?B?ZDR4aXdSNk9SNkxhcVFWTUYrUDRHWEpEdHViV25xNWRVRS9BaEhuSWhYbU1P?=
 =?utf-8?B?VzEwUWZDUzhneDJLc0t5SkVFUkx3eUpmMEp5L1ovUkI0cDJVR05lTlM3Q0ll?=
 =?utf-8?B?bklWOVVtYXBlZ2tFZm9OQStqcE1jRlVzeWZaY1NZTkhDdGVlZFZUT00zTHVK?=
 =?utf-8?B?Q0FRWE9MY3ZBRDVuc2VxTVp2OGdUbmcrMHlEWmJLZ0dZK0pqNms2WlhTcVJU?=
 =?utf-8?B?a3o4dWtScWp5VHlkTkNKY2wrbjVYWVhuMjRYK0h3WnR6SGY2akQyV0RLZHBn?=
 =?utf-8?B?QnZoUGZSWE5iUEtvd21vUEpaRzNvSEh1OVhBUzRGYWRMbmo0OVUrK0NXakd1?=
 =?utf-8?B?S0ZSUzdlVGR2RXBIbzJDbm5obENpcFVtdmYxSk9oK3d6aHFlMVdFLzZDU1dx?=
 =?utf-8?B?QWRPQWYrVklNTHN0YTRJakVpcTlJK2VjSnQ4d3ZJUElyci82RVZMaGJIMGVL?=
 =?utf-8?B?UHF5eXdPMWorVTVOaFlCdW1CQXBzeS9HaU5UK2xwR0RyVnp0ZWtMQkJRVG5R?=
 =?utf-8?B?YllsMGQ5NmZuYU1QaFVjbUluV05EQWZDbFFtVU03OGtBYnY2UlhYckZsZXlm?=
 =?utf-8?B?eEh0U1VBTGR3aDNSdjU3c1F4NDZtcG9Ma0dnRWVkZndTbkdjcVQ2VSt4ZHFo?=
 =?utf-8?B?VGtqSzlzY01FZjlWb0tucGtST1BhdXhXQ2FwalloSFpNYkU3b3hHb1QzSTVT?=
 =?utf-8?B?c29td1Z0SkltWUlzY1pBWU5xeVJDaTVuR1BoVkY3RERwaFhTZXBTN1dobGxP?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a23e64-5c81-4aa8-429f-08dac941c8d4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:49:20.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pb2tiEttHhydlX20tT33L9NtJlHZhjug2DeqsQyDy/XdFRbVYbC0AU7HLvJFSr/YAY8KYP1IzgT7XGx6h7jWk9apusrKl275+u9LbiKIKFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 18.31, Jason A. Donenfeld wrote:
> "If "bytes_read * 8 * rng->quality / 1024" is greater than 0x7FFFFFFF,
> the upper bits of the result will all be 1."
> 
> Except "bytes_read" is an int. So false positive.

Well, the automated report could use a better wording, but just from the
types alone there's nothing preventing the "bytes_read * 8 *
rng->quality" expression from mathematically exceeding INT_MAX and thus
potentially becoming a negative value (so technically of course not
greater than 0x7FFFFFFF, but the point being that the sign bit is set),
and then the result of the division will most likely also be negative.

But what actually saves the day is that I suppose bytes_read cannot be
more than 32, so the multiplication is indeed at most 256*U16_MAX. Too
bad we don't have a __postcond(@ret < (int)size) attribute we could put
on functions like rng_get_data() to help static analysis.

Rasmus

