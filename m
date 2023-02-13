Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21E3693FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBMIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBMIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:33:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93820AD36
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:33:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id by3so9938310wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEuMhDtTRyInCB0boBwGOOTw3vKK+wSd5q+B5cK43j0=;
        b=v/qvFBSOYuV+0xErSQhuo4flcS7Nd+4MGv4eNJpeljpVKcRVlO0ImzzeV4V4yRwQDF
         Rd00rcR87JGhvC2jqwzWH91C1SwN6pXaMmyOt87Q5Luc3G/DWsvu5KUm//tIV6xCUcuz
         EL+y1i9zIm03AVRkrsnatQgxoltZyzzhd8Wee8Z802osB5V2mbc2Zu6yAUaOQFf5tccs
         1nYkBvfv2jKY0oAS12RtHa1CXZvZpy1rD1csBDkRwiHvz39z+ODBf7r5GOL77JomYt6y
         Uv4P4qybjKyvFOPM/99NSJwtMnSlLQc1fhUeoOJY2nL05UXGYNQnbYYHJWpxcAaex/iz
         k6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEuMhDtTRyInCB0boBwGOOTw3vKK+wSd5q+B5cK43j0=;
        b=Q5dkV6G+TmowwJaPPG//nqlakjWOB2sAjAuoenwqPFpwrlhcJEO9x0VogQhgvW/wc7
         sp3FfsBZ4IUzrB3PbeJY9raPgk/y8oCqtk7FSh7zRhkctaSXPO928Mhexfj1DTQPB+ho
         JTu1SJRuEzg3H3qq+IKSJaGHskHr3/DJfkJ6//WfVYhZhGW18+v5iH5sRdc+/DsibJ7N
         BpxAZ6gqn8lt2NUmz94k1CNraWq8Ds4iGTJRgsao4gcpJx3UfR8Y0qgl921HBtn/lkVD
         vS0uLV+kukDDCWPA/BSNf6jM1hy3VtYW0AfZuPVLaXu0BsAUBx3uiCcZUK9tgbQkq+S9
         v6Mg==
X-Gm-Message-State: AO0yUKVtsJWN/kLxjciGE0zpcFNouVlwvEBB3Wd6H42N2/zyTaJONoyE
        OauC2qD658Wtxr0F5bYXByNgkQ==
X-Google-Smtp-Source: AK7set82macE5tb15uEC+cZmeEexWQ0A9YHhP1uRG8SIw9kE96Oxcd3ctJpgCaP9KHVdVj108eHEZA==
X-Received: by 2002:adf:f34d:0:b0:2c5:3fcb:681e with SMTP id e13-20020adff34d000000b002c53fcb681emr10489748wrp.4.1676277211159;
        Mon, 13 Feb 2023 00:33:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b002c55ec7f661sm568329wrt.5.2023.02.13.00.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 00:33:30 -0800 (PST)
Message-ID: <b59c8885-562d-f680-622e-3859bf7ff8db@linaro.org>
Date:   Mon, 13 Feb 2023 09:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
 <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
In-Reply-To: <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 10:12, Krzysztof Kozlowski wrote:
> On 10/02/2023 08:26, Chia-Wei Wang wrote:
>> Add dt-bindings for Aspeed UART controller.
> 
> Describe the hardware. What's the difference against existing Aspeed
> UART used everywhere?

I expect the answer here. You are adding duplicated driver and bindings
instead of merging with existing ones. That's common issue and
explanation "it is different" is not enough.

Best regards,
Krzysztof

