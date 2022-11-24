Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0596463800F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:08:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D356553;
        Thu, 24 Nov 2022 12:08:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3C04B828DB;
        Thu, 24 Nov 2022 20:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574CCC433C1;
        Thu, 24 Nov 2022 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669320503;
        bh=AqLjRFqgqFhAgmvM5lie1bZYceUKkJ7UwUOqCB9iVZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P3nMtMWlZuX5SPCqYo2kFm+B0/R9GR4ITfmHWgL233xsH9u+2PvPwumnn2cjhzx1m
         HYFG4vLV+fviFu2mEbWxIAiK+Jfea0OMphXT5Ydq/LVCFMYqd2QOH7ZdXCO0OjWzHn
         lZCFQ6xtJQU6uJvEnYmq89DM1183CtuA79vWRQroo5QqpEPFWRL4BzXVVVtAYBrrp1
         UMpTUtb340YKML8G+exn5jMZ6EP5KJt3pLz9PbVdUV0cq9A2SrcHBi4yZKJ0b6zh5D
         XuAtgM+LvXhgTnlRTDbJnr6jAU8Q24fANiB3gFPvnCMT57u0tNtVSfQ2HbRbFmXlFl
         aL/yUGKs1mb9w==
Message-ID: <59aea5e5-25f1-de8c-9982-5db226f8bda5@kernel.org>
Date:   Thu, 24 Nov 2022 20:08:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/LgZkR1hkblJ8D@spud> <4801607.MHq7AAxBmi@diego> <Y3/OlKI1jyi0eoCJ@spud>
Content-Language: en-US
From:   Conor Dooley <conor@kernel.org>
In-Reply-To: <Y3/OlKI1jyi0eoCJ@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 20:05, Conor Dooley wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Nov 24, 2022 at 08:58:41PM +0100, Heiko Stübner wrote:
>> Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
>>> On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
>>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>
>>>> Introduce ALTERNATIVE_3() macro.
>>>
>>> Bit perfunctory I think! There's a lovely comment down below that would
>>> make for a better commit message if you were to yoink it.
>>> Content looks about what I'd expect to see though.
>>
>> Also both the comment on the original ALTERNATIVE_2 and the new ALTERNATIVE_3
>> should probably be merged into a single comment explaining this once for all
>> ALTERNATIVE_x variants.
>>
>> Especially with the dma stuff, I'm pretty sure we'll get at least an ALTERNATIVE_4
>> if not even more ;-) . So we defnitly don't want to repeat this multiple times.
> 
> Oh I can promise you that there'll be a #4 ;) I do find the comment's
> wording to be quite odd though..
> 
>> + * A vendor wants to replace an old_content, but another vendor has used
>> + * ALTERNATIVE_2() to patch its customized content at the same location. In
> 
> In particular this bit about "at the same location" does not make all
> that much sense. What "at the same location" means in this context
> should be expanded on imo. Effectively it boils down to someone else is
> already replacing the same things you want to replace - it's just the
> word "location" that might make sense if you're an old hand but not
> otherwise?

Or maybe I am just biased because I tried to explain this to someone
recently and the language in the comments didn't make sense to them,
and anyone meddling with this code should be able to understand it?

>> + * this case, this vendor can create a new macro ALTERNATIVE_3() based
> 
> Also, using the word "can". Is it not a "must" rather than a "can",
> since this stuff needs to be multiplatform?
> 
>> + * on the following sample code and then replace ALTERNATIVE_2() with
>> + * ALTERNATIVE_3() to append its customized content.
> 
> 

