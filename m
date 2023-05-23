Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F470D978
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjEWJrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjEWJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:47:45 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A3A198
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:42 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f3af4295ddso4697155e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684835201; x=1687427201;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jX16/0rr81PfoyBcbhxvSU8kcPmdWqcVtTOE6rNVtKA=;
        b=EY5l+r0xz+NAiuduyh4wKecXT7+gMK6MNDn5rmz9/kZTp3Rne4Sd1nK3hALIDICkY2
         1b7/IQ7TVetGW8A8zs+oSSEAX8aBA2yEvGf43iBh5x8tPtCbjd+70s/0aw0+6UFH+ytr
         Bbo9ywpheDhgXFt/5XF7aVCwGhA5aC9rwGZfZPPQLVwd4vEQAOV0ITZDYz1948GBbrNN
         +n1lkH/w9rU0SOaM1t6VjOBe0rxx+nzmnSuKPyoMwKvAO3uFqll4TBAXTnnLI1YMEovD
         fdOm0GyT1roMY+jd6tDJ3vF5I8QSBFQQqnAGAAPpK12WJQGP8WXaGs+AKGuTlmVLage9
         wmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835201; x=1687427201;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX16/0rr81PfoyBcbhxvSU8kcPmdWqcVtTOE6rNVtKA=;
        b=HGJjkQzE0ZzkRoXkrmdjO/F7r1VrWRI+eF+j8qEtESr8C4tVItMH+nYroVLijxWCdQ
         Sj16L3SrSJxpk43GS1u3YG3oAVgAAdm0PSyCPounjFh+z8YYdi+pE7MRfXfnRHMrV4lC
         68e0TUeBZTEy7qSlWKPpybG+XC/p8FSsl2dR4G8EaPP4wjWqYD+ZsPY7B4BskSaTiI0G
         1dEVQzdgdhRPPbEB7VqvQDoKRkprQEtetGhiAfN7s2j0pH+31dDCw6qOmmbixfNuzaUs
         KxR9JV2MslCGy0/GqI9wTLI3ei4Q8O+rhlnhaF76eQcHuH80SNhCe/yb1bAtpoLSGCuh
         l8Wg==
X-Gm-Message-State: AC+VfDwtaRVpIIn6Nqss2u3lJfbwgF8O7EoSMHM2DstJsUog6yqzoDS6
        MGL0vFYsd+cadkmT4QlAEDJ63VmN7jo=
X-Google-Smtp-Source: ACHHUZ4ZhxHDMYjlNF24azrKOrmoZqMQf7u7GvXlcuG4S59OoYBDLZzPDeQ2bBpSIHxPKF/+EkVXdg==
X-Received: by 2002:ac2:5333:0:b0:4f3:a4ad:ef30 with SMTP id f19-20020ac25333000000b004f3a4adef30mr4807032lfh.22.1684835200676;
        Tue, 23 May 2023 02:46:40 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512006f00b004f38fef80e7sm1285953lfo.208.2023.05.23.02.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:46:40 -0700 (PDT)
Message-ID: <9641aa06-4925-051c-2ebe-22e43bf9dd4f@gmail.com>
Date:   Tue, 23 May 2023 12:46:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com>
 <20230419-dynamic-vmon-v3-1-4179b586d8a1@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v3 1/5] regulator: move monitor handling into own
 function
In-Reply-To: <20230419-dynamic-vmon-v3-1-4179b586d8a1@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thanks for working on this. :)

On 5/21/23 14:39, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Similar to the existing implementation, the new function does not handle
> EOPNOTSUPP as an error. The initial monitoring state is set to the
> regulator state.


As far as I see, this changes the existing logic. Previously the 
monitoring was unconditionally enabled for all regulators, now it gets 
only enabled for regulators which are marked as enabled.

Furthermore, if I am not reading this wrong, the code tries to disable 
all protections if regulator is not enabled at startup(?)

I am not saying this is wrong. I am just saying that things will change 
here and likely to break something.

There are PMICs like ROHM BD9576, where the protection can not be disabled.

For example, the bd9576_set_uvp() has:
         if (severity == REGULATOR_SEVERITY_PROT) {
                 if (!enable || lim_uV)
                         return -EINVAL;
                 return 0;
         }

I am unsure if we might also have cases where some regulator could 
really be enabled w/o core knowing it. There can also be a problem if we 
have hardware where monitoring is common for all regulators, eg either 
globally enabled / disabled.

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

