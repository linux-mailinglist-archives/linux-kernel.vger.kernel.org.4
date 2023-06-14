Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B974C72FC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbjFNLSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjFNLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:17:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F52693
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:17:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so5234205e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686741457; x=1689333457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqM7S8NVl5TgVH/SCkBnKovDNoLn6CHQRP6NUvEVbFA=;
        b=QOBvNJ4SK+SNbyk8XDYPoIiRQQGEReadorv2ByIf2r/Pgn2pEZzITLNMrdIZW4Uja1
         FrPl+kL8JMgwnFvefo4gM4ADtDjXYBkoOJsodiAp/P4NWHr47LelPoqg5Z5eIZPbl5ed
         W+A/T2K2m6EepXPnoOFsFcNjYboMPE6S5vb039RIEtYnbJEHi+qcmJOuHNQ9Z4kyLIDn
         h3yI9XWwjJpwSdLsfp4+8K7SkLOYf7q8jLrVDRDO5cnHRdpbQS4PxIclh/2KWezLs+Pp
         AEPdwu44Gi7WPkNp8s+L3l6mY+YlZ+dvDnubAgTdRxAOQJHTLNoCdo+HmjJBvjqPeCYE
         jZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686741457; x=1689333457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqM7S8NVl5TgVH/SCkBnKovDNoLn6CHQRP6NUvEVbFA=;
        b=g28c4GOwnjbEel5nZy7Abk9bDpc1PzZ3tu2e31VSXvevDG3Yit+OzmbzbNEco56Hnl
         qwM6BK4OKxTNAFe1FKly57Nlx5x0iDSNW8RU7hkvOE2uDefYaamX3a6BAxQfDMFxpP8N
         tRQmJG2yfN4i8DHTPCEH1VSXpvg3pVx74CjekR5OrQezsa8CuU/UfbSRb/RvW9iBVUjP
         Rtrlsv4OGoQBMNHj9meTgqGGYnIGURu6Ops9rzHrDXFhd4MVLdC6uXkDdlbjA01ehlFH
         cTTd2g0D/bCX4XxRht6g0gRws8fLlYsF2QPQVtVUBaJyfDJt99lkbL+9TfCv3h0MpNL9
         fNiA==
X-Gm-Message-State: AC+VfDwPt/tZ1MRCIvXVfy29k+AmP2TiAoielAH3wwnhUN1kicSTdXyN
        aCk90kQJ8T45kWNEEUnosMAsIw==
X-Google-Smtp-Source: ACHHUZ4VV/u+wNY65vkMGqcqRpOJrnrIRBctK0IPefzUqdfJtG2Faq8wP4fbJml7xLdM6nEjARrruQ==
X-Received: by 2002:a05:600c:2212:b0:3f7:865d:ce63 with SMTP id z18-20020a05600c221200b003f7865dce63mr10498832wml.21.1686741456811;
        Wed, 14 Jun 2023 04:17:36 -0700 (PDT)
Received: from [10.35.6.111] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id x25-20020a05600c21d900b003f60faa4612sm17154520wmj.22.2023.06.14.04.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 04:17:36 -0700 (PDT)
Message-ID: <f993a71b-69ff-3047-9a56-d04fd583431a@sifive.com>
Date:   Wed, 14 Jun 2023 12:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 10/10] pwm: dwc: use clock rate in hz to avoid rounding
 issues
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <20221223153820.404565-11-ben.dooks@sifive.com>
 <20230216213927.r3lvjz6u7d62y4pb@pengutronix.de>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20230216213927.r3lvjz6u7d62y4pb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 21:39, Uwe Kleine-König wrote:
> On Fri, Dec 23, 2022 at 03:38:20PM +0000, Ben Dooks wrote:
>> As noted, the clock-rate when not a nice multiple of ns is probably
>> going to end up with inacurate caculations, as well as on a non pci
> 
> Given that such a non-nice ca*l*culation only happens in the of case
> that is introduced here, it would be nice to move this patch before the
> introduction of the of-support.

I've moved of support to the end of the series
you
>> system the rate may change (although we've not put a clock rate
>> change notifier in this code yet) so we also add some quick checks
>> of the rate when we do any calculations with it.
> 
> If the clk rate changes while the PWM is on, this modifies the output.
> This is unfortunate and so it justifies adding a call to
> clk_rate_exclusive_get() when the PWM is on.

I can't really test things any more as the hardware has been returned
to the client and I'm technically off the project (and awaiting this
email address to be closed down).

Could this either be solved by the clk_rate_exclusive_get() or adding
a clock change notifier? Either way I would prefer this to be work for
another patch.

I'll send v8 out later as it has had some re-works due to moving
things around.

Thank you for the review.

--
Ben

