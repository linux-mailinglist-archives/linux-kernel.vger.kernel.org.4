Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6185964BAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiLMRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiLMRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:18:02 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E113E3C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:18:00 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p6so2031557iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qTFjyiSnCqLYqAWj+0eGtZebhl1ojJPI8tNnCqLlTE=;
        b=HB5/saVepTV9HjHxz7WHFJyxL9CfXUD3huZ49GaFiQcsING5TyFfTQoLKoRlXNKe4l
         dUwCO06hJh4pznQKBQ+TjXYHH4OOJDRsPLsQL5T/98ksbk0iK4SKEJ27IiDT23rNKACM
         b0CDh6Eq14nAbpY33R1+HSpjdKbqPJpsleYT4GM8cPcegtuEN5gJtsjMLhTn+ZDcXsE5
         +EMf/JuZUUbR6aJ3fqOSx82arSBf1NkRdVzA63tLRs4g2SXZkBb0sesn5RI6GSUYg/pr
         g9Ucrb/nLtoVlKSr4O/XGERFEaxvJTwuH+iMw+hO7wfW8NQoSBbonsB/X4hUScm9xfvj
         TkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qTFjyiSnCqLYqAWj+0eGtZebhl1ojJPI8tNnCqLlTE=;
        b=TW4RPhrC5a5JuChlLMfuCrjpKJCfDDRBXlr1DckFYfWInpmH+zotFT8O7NBcsM8IpD
         ShVz3ccsdxIzrG6lsJuijtR22QRuAUIlxvMj3P9MNIYlzCEfGbv3+KVLI8mg730tMvYx
         dKnXKZ9TKZHK+aimTIEY+/aSWhY4kYPmg6rrAH9zxNWwHUPSg/wUeFWIr0PJDH37Wkpa
         1kJWqQLN/YXqnUY6YVEH9AVGZA1ndSjy2oNdEJXyv3mvrxcmVWVTlaQjG+28VDJrC9xE
         OO6aR0+GHlXMcDejgJCgM0uQZdsIC2Kck4XtVxNuu3P47kvSCxNZZzf7FTf/UCnlZV0q
         XGGQ==
X-Gm-Message-State: ANoB5pkCxBP+kUhhuWUZQnLhUfcE8StarKGLGmbZwidgyEUIARZSvbtB
        fl74NDtg8EU5U+AMOw3YsSTjWA==
X-Google-Smtp-Source: AA0mqf4SVR20qmTHEorZ05ywtYmpbvZg4FRoaQP1RNvXJbBX+ojDS1Hbn+T5mHLEJIVtKm1mRRyX5Q==
X-Received: by 2002:a05:6602:3283:b0:6dd:f251:caf7 with SMTP id d3-20020a056602328300b006ddf251caf7mr2220206ioz.0.1670951880188;
        Tue, 13 Dec 2022 09:18:00 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w14-20020a02968e000000b00389b36027a6sm993360jai.92.2022.12.13.09.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:17:59 -0800 (PST)
Message-ID: <7125ff61-bf11-6f8c-8496-f2603371c214@kernel.dk>
Date:   Tue, 13 Dec 2022 10:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Content-Language: en-US
To:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
 <0bcf7776-59d7-53ef-bfd0-449940a05161@kernel.dk>
 <PH7PR20MB50589A941F3F5A50C872E264F1E39@PH7PR20MB5058.namprd20.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <PH7PR20MB50589A941F3F5A50C872E264F1E39@PH7PR20MB5058.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't top post...

On 12/13/22 10:10?AM, Arie van der Hoeven wrote:
> We understand being conservative but the code paths only impact on a
> product that is not yet in market.  This is version 10 spanning months
> with many gaps waiting on review.  It's an interesting case study.

That's a nice theory, but that's not how code works. As mentioned, the
last version was posted 1-2 weeks later than would've been appropriate
for inclusion.

-- 
Jens Axboe

