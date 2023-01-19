Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29173673392
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjASIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjASIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:22:53 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ABD94B4A6;
        Thu, 19 Jan 2023 00:22:50 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jan 2023 17:22:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 374FE206CB0D;
        Thu, 19 Jan 2023 17:22:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 19 Jan 2023 17:22:50 +0900
Received: from [10.212.156.59] (unknown [10.212.156.59])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 65BA33D4D;
        Thu, 19 Jan 2023 17:22:49 +0900 (JST)
Message-ID: <0c5d917b-5cc9-2b09-390c-8888a1de2a48@socionext.com>
Date:   Thu, 19 Jan 2023 17:22:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 00/17] dt-bindings: soc: Introduce UniPhier
 miscellaneous register blocks and fix examples
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221219154948.GA1439405-robh@kernel.org>
 <96590704-fc2e-5a30-15b9-32fda9cb571e@socionext.com>
Content-Language: en-US
In-Reply-To: <96590704-fc2e-5a30-15b9-32fda9cb571e@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/12/20 10:13, Kunihiko Hayashi wrote:

>> You sent this To me, so I'm assuming you want me to apply it?
>> Otherwise, it can go via the Socionext tree. Let me know and I can fix
>> up Krzysztof's comments and apply the series.
> 
> Currently I don't have the Socionext tree for pull-request,
> so I'd be happy if you could fix up the comments and apply the series.
Could you please do the above?
Or should I submit the fixed v4 to soc@kernel.org and request a merge of
this series?

After fixing the dt-bindings in this series, I'll continue to submit patch
series to update the devicetree.

Thank you,

---
Best Regards
Kunihiko Hayashi
