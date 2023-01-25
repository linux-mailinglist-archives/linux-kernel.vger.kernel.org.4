Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9A67AFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjAYKhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjAYKhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:37:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CB4234
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:37:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk16so16563925wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9QC/i6xmhCHUxuneWjxZFC7WZ5y2w3dvdc7GpVVl1c=;
        b=UAwOR7+Qlhh5HTzIYefJtlBy2JRoWGZcHJslfyla2ST55gwLn71mqCu3TxcQBdfKlW
         SW5c4zB5CQZg2TU63xZE4dwPkUEtS89ERrMbmRivpGqmYh2Ya/yxHLbnpvPHy1Sm6nrd
         BKHPbvPffr8rfHJrZscqhljn3n7zK/nsc3XcOf7zFDgz+7frvnTngbd9pXW04q7BJb6X
         /Jc3kM2w8SXqxmyTOBM85yIr/JXL6GyRps5RsIeQmLs0wYc/X4jRheE/hxIa7ZzjPtz5
         g3Q5PIWjzMWJFWH91gOgiQCGE4ii9eTHX0WSis7S1FoZeX8An50AsFq3qBmSzaSRg1Wy
         nuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9QC/i6xmhCHUxuneWjxZFC7WZ5y2w3dvdc7GpVVl1c=;
        b=lvvryup4D/e1yI30p3929E7UzQdYV3x17ei4S3TjqLGO21rt8RytLETJedKOVwKkmG
         GaOs+qjEPZHgkokKh1qHdIdJx0zmj6Vr432OtY5NWj/42KQ+tiaOsj2nJFx1/EW5bs2w
         pl/tMVHaKYvqWEaRahTjWhg4tlzkpYdMkmKUSKgcaj3zYh/VMboZAtaTTi+pubp+BEvU
         6N1QcW1D9A4q/TrzeD+klCcO1/+VspQN67Gk6yTa0K1ogdHoI0igVU8AAg6ooivFeGBz
         CtsUcc4+VtAWPk9638tpusutOmvSAeH2eXGjNITKSbW71XJFQjvsadDhXQ74jWUV+0Hk
         Fu+A==
X-Gm-Message-State: AFqh2kqettmrStkUuhEsG5vdFWzYkCznwJgLVJotixHFr7b4fCE5sCsT
        o0p75clpRlsWkBK6jk8RQHM+DQ==
X-Google-Smtp-Source: AMrXdXuBN5fhM0vK+pB5kmPtv4u70RKRdhe/pckq9HzCkxoJ+0Pr88vB9UNHJErnMGNA25VLCLNScQ==
X-Received: by 2002:adf:ed0c:0:b0:2be:f21:6b02 with SMTP id a12-20020adfed0c000000b002be0f216b02mr29296812wro.70.1674643062926;
        Wed, 25 Jan 2023 02:37:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d4408000000b002b8fe58d6desm4039429wrq.62.2023.01.25.02.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:37:42 -0800 (PST)
Message-ID: <32db06ef-e6c1-d8ed-8624-cf91db5b3e53@linaro.org>
Date:   Wed, 25 Jan 2023 11:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] ARM: dts: mstar: align UART node name with bindings
Content-Language: en-US
To:     Daniel Palmer <daniel@thingy.jp>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123151523.369225-1-krzysztof.kozlowski@linaro.org>
 <CAFr9PXn+XMzz8uZzNwDNdCpYeN4Nf6rc6nXWvuf_TCRe2B_PXw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFr9PXn+XMzz8uZzNwDNdCpYeN4Nf6rc6nXWvuf_TCRe2B_PXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 11:20, Daniel Palmer wrote:
> Hi,
> 
> On Tue, 24 Jan 2023 at 00:15, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Bindings expect UART/serial node names to be "serial".
> 
> snip
> 
>> -                       pm_uart: uart@221000 {
>> +                       pm_uart: serial@221000 {
>>                                 compatible = "ns16550a";
>>                                 reg = <0x221000 0x100>;
>>                                 reg-shift = <3>;
>> --
>> 2.34.1
>>
> 
> I have this change in my changes to use the proper uart driver that I
> need to fix up and resend but it doesn't hurt to fix it now.
> 
> Reviewed-by: Daniel Palmer <daniel@thingy.jp>
> 
> But we don't have anything queued up in our tree to send a PR for so
> maybe this should be merged via soc.

I can take it with my other cleanups. Thanks.

Best regards,
Krzysztof

