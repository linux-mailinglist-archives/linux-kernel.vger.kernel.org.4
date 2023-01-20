Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275D76747CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjATAD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjATADf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:03:35 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25A0D94CAF;
        Thu, 19 Jan 2023 16:03:04 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Jan 2023 09:03:04 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 581442059054;
        Fri, 20 Jan 2023 09:03:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 20 Jan 2023 09:03:04 +0900
Received: from [10.212.158.61] (unknown [10.212.158.61])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 923227363;
        Fri, 20 Jan 2023 09:03:03 +0900 (JST)
Message-ID: <57e8020a-d05f-16a1-55f5-d65fa3bef4a0@socionext.com>
Date:   Fri, 20 Jan 2023 09:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 00/17] dt-bindings: soc: Introduce UniPhier
 miscellaneous register blocks and fix examples
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221219154948.GA1439405-robh@kernel.org>
 <96590704-fc2e-5a30-15b9-32fda9cb571e@socionext.com>
 <0c5d917b-5cc9-2b09-390c-8888a1de2a48@socionext.com>
 <CAL_JsqKPEeQW3WER+K0UgWp8yx_Fh4OB9o1skU9mndM-=SYV7g@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAL_JsqKPEeQW3WER+K0UgWp8yx_Fh4OB9o1skU9mndM-=SYV7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/20 4:57, Rob Herring wrote:
> On Thu, Jan 19, 2023 at 2:22 AM Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Rob,
>>
>> On 2022/12/20 10:13, Kunihiko Hayashi wrote:
>>
>>>> You sent this To me, so I'm assuming you want me to apply it?
>>>> Otherwise, it can go via the Socionext tree. Let me know and I can fix
>>>> up Krzysztof's comments and apply the series.
>>>
>>> Currently I don't have the Socionext tree for pull-request,
>>> so I'd be happy if you could fix up the comments and apply the series.
>> Could you please do the above?
> 
> Yes, I've already applied this.
Thanks a lot for your help!

---
Best Regards
Kunihiko Hayashi
