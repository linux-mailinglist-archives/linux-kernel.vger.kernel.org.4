Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6E6A5BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjB1PdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjB1PdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:33:24 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665A93F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:32:58 -0800 (PST)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8FC2B3F468
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677598375;
        bh=MxHdDFD0LZ4lqDSuQ7dNAtCj1307wWzr5tZplqj4BbA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JnXldQc3fRBqDxMsAWFjL07dsfuMlwauDElCQhakGvM8IBmhh8JdCPX2CO8amcggQ
         k+j+USC+Ln0yu+1Pwjf9lRG0s0s/stYfXckK5rQkyc96IYZzusfzDTjxakSgPmW17Q
         JjgB5qM3Q6glPjuz3+Bprmjvk/b9D3wZtsgkbIw0N1NNv90SVehmUWFQsIr+pLmBV4
         AbbgQg3N+qRcnAqcjwGvv0W98RTtgH3L9RHZKBC6F78Nxf987lD9wkfGxARCJlmk3N
         sCaQVeRVtSPKmi42L2wOH1zEhKUvalxSQgez7EpFnq2VTG0mqV17hHNexq+v4klPVD
         D8zGFbK+22Lrw==
Received: by mail-qk1-f200.google.com with SMTP id bj3-20020a05620a190300b007422ed6c435so6177912qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxHdDFD0LZ4lqDSuQ7dNAtCj1307wWzr5tZplqj4BbA=;
        b=e2ThTQNfuFHTZVvx5Rp+2IS0QhQ14jwd1q785HkbI9gapZPX3Ofzytr+a6XzBbNNOX
         alBlOyr/I6xJlH5IHsYGMFIfo8/cPG6nGr5Fo+vurB99oPgb13h+BixoIle+C3IiYB/E
         qknVaQ3w9mEjoNdr/2vkmb3aXJFOn7i4SQfb14DR9S3skfTOBpaUPNnhC8yR8p0PjPvb
         V9Cbm4pe98UgTXgiSZWxFzRw42CN7aLeQby0cCOD9OY1Y05BX58kn/1iy4ziRIucS2/5
         zYIBmjyIhC96ldK+eW8iq+UTCjzXaU5ff/k78gWJmWj6x+CF/XvKcVFU/i+2vySDLM1b
         TTWA==
X-Gm-Message-State: AO0yUKWudt0+OZKfNkd08wCsCJIlpM5lwmjmdorkOIs9RYFnfSwE5MT2
        Bevu8fm1zkCCRmArJ1j94u5TEBMr5as73qZKfQPa3IkUwMlaq79d7QrlHDDVLDrhwB0P5d++9ga
        1EN3+8aE8wQ63Nqy1qF6/FUSSGHfl66yrHElyIqyI4/jIZIJhg8lLFUOLUQ==
X-Received: by 2002:ac8:208a:0:b0:3bf:ba7f:58f8 with SMTP id 10-20020ac8208a000000b003bfba7f58f8mr920408qtd.3.1677598372901;
        Tue, 28 Feb 2023 07:32:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+vE60RGwdOA8UUFJRwNsAQZ/kwLQYFX4Nc9zP11EaSjRPR4xRHceTxsK0vKVbpvi3VXQAqOdeQU2k/GNXG/Io=
X-Received: by 2002:ac8:208a:0:b0:3bf:ba7f:58f8 with SMTP id
 10-20020ac8208a000000b003bfba7f58f8mr920400qtd.3.1677598372674; Tue, 28 Feb
 2023 07:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com> <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com> <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
 <Y/3coFvMWOLaaY9p@wendy> <545c23f3-1d68-2bff-89d9-584e3ca31044@linaro.org>
 <Y/3hVlp/YPnWHDCX@wendy> <f9e380f6-334f-11fa-1118-8d6c3c9befaf@starfivetech.com>
 <d2aada79-61c4-0cc7-7b09-058564ed9fce@roeck-us.net>
In-Reply-To: <d2aada79-61c4-0cc7-7b09-058564ed9fce@roeck-us.net>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 28 Feb 2023 16:32:36 +0100
Message-ID: <CAJM55Z9G5omehjgDJncPmN6n7zUCVwrMuqDKLXCDs95LtN66MA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 16:10, Guenter Roeck <linux@roeck-us.net> wrote:
> On 2/28/23 05:16, Xingyu Wu wrote:
> > On 2023/2/28 19:11, Conor Dooley wrote:
> >> On Tue, Feb 28, 2023 at 11:57:58AM +0100, Krzysztof Kozlowski wrote:
> >>> On 28/02/2023 11:51, Conor Dooley wrote:
> >>>> On Tue, Feb 28, 2023 at 11:36:49AM +0100, Emil Renner Berthing wrote:
> >>>>> On Tue, 28 Feb 2023 at 10:44, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> >>>>>> On 2023/2/26 22:14, Emil Renner Berthing wrote:
> >>>>>>> On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> >>>>
> >>>>>> So the dt-bingdings need to rename, and which one could be better,
> >>>>>> 'starfive,jh71x0-wdt.yaml' or 'starfive,jh-wdt.yaml'?
> >>>>>
> >>>>> Sure, starfive,jh71x0-wdt.yaml sounds good to me.
> >>>>
> >>>> I feel like a common comment I see from the dt folks is to not put
> >>>> wildcards in filenames & just pick the first compatible.
> >>>> I could very well be wrong on that front though...
> >>>
> >>> First compatible is a bit better, unless you are sure this will cover
> >>> all such compatibles now and in the future. For many bindings the
> >>> family/wildcards were fine in filename.
> >>
> >> Ahh cool, good to know what the specific policy is - thanks!
> >
> > If this watchdog driver is improved to also support JH7100 in next patch,
> > it seems more reasonable to rename the dt-bingdings to 'starfive,jh71x0-wdt.yaml'.
>
>
> Up to the devicetree maintainers to decide, but I for my part never accept
> wildcards in file names. You can not guarantee that all of jh71[0-9]0 will
> be supported by this set of bindings. On top of that, when / if you add
> support for anything outside that range (say, jh7200 or jh8100 or jh7101
> or whatever) you'd have an even worse problem. Are you then going to suggest
> renaming the file to jhxxxx-wdt ? Or one digit at a time ?

Makes sense to me, in which case this should be called
starfive,jh7100-wdt since that's the first SoC to feature this
watchdog and will hopefully be supported in the next version of this
patchset.

/Emil
