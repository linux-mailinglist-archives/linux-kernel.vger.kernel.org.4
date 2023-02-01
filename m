Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A06860F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBAHuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBAHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:50:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BA3AB1;
        Tue, 31 Jan 2023 23:50:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so16741415edb.7;
        Tue, 31 Jan 2023 23:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glBN85Rt3ApOQsBFR19xGhWj23PUZkptYN1w7e3kzW4=;
        b=DRyUlm1zhhpn43neHrYjlg1b7J90De88ZvLd1hZBhVaMTp21J2NQ9m1HZ7w7kpp0VQ
         NDDpw2l+K+2ZJEGSrD7XHt27GuJeipn56IqMuAKTXvqn7U9fBL9JwpgzlVja45KvQN5o
         hAuKoBbDfOLSW5FaFeJB+gXrw4UziIvMc9Xff6MM4kZgDsnmfNlscfq+CZEj37TT7jzj
         dDmO9SewftPPSYv41YLasOzkiNc48pZXo/G8Swq6HdSL2EfAk0Y1DJpPwrKTxUNWz+WG
         y3BtbhV2F8SZ0Kjv1sBtNbEeu6JrGovtJe2oauq8vgytAt7i6t/+yDqBi2beNtO34/WZ
         pgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glBN85Rt3ApOQsBFR19xGhWj23PUZkptYN1w7e3kzW4=;
        b=h22DE/Mhz85nidZwkVaYVOUbpj48u7tTgX3oR8EEpF8PS6tgY0pHc9sKpaIzgzS5ci
         0sTGSplumJC3wVvAb9MbwYOegJzmJSGNYkQHa62q+hZKJeU8KXTaa+8Tpq3mEgBSK6cA
         3neH88Bflttqgww9+op6x1N9EX7w032uxya94CKH9aO5SJdwFI7jl+K8Pjl5vwszS/yj
         dzmylKw/lX4gK02uQWPi6r5UZoOvc1glhlS5HymUpYZBYjKZlk/hqNpqGyBIYSvVAEmH
         m/9ojOWvCWJn9O3A2nDCQmpz/N8p4ORuHyt5RL0jR5nVbIJRFYtNkg+k4MDCmtn2pNyM
         hGXw==
X-Gm-Message-State: AO0yUKXuvT5DFMk7Brb1LmnNVk19GErmHq5TYSn4Pv5nDkSbYm5aolNw
        G9aPgKA3LBj8PNPWbn4bQNA=
X-Google-Smtp-Source: AK7set9udwASp3rHYU+1pDsFfYldkdqc5fY3QHy8XaG+oyWra3rErQfyAuhCrcpz5D0ySJ2Dxu8iAQ==
X-Received: by 2002:a50:d79b:0:b0:49e:5ffd:5be2 with SMTP id w27-20020a50d79b000000b0049e5ffd5be2mr867638edi.40.1675237845584;
        Tue, 31 Jan 2023 23:50:45 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j6-20020a170906474600b0088ba2de323csm2565358ejs.181.2023.01.31.23.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:50:45 -0800 (PST)
Message-ID: <0750dcbe-6035-d49e-9d2d-93a937b5c15d@gmail.com>
Date:   Wed, 1 Feb 2023 08:50:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 0/4] nvmem: add and use generic MMIO NVMEM
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230201064717.18410-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230201064717.18410-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.02.2023 07:47, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> MMIO accessible NVMEM devices should be simple enough to allow using a
> single binding & driver for them.
> 
> I already replaced two existing drivers. With NVMEM layouts introduced I
> can also replace Broadcom's NVRAM driver but that work depends on my
> pending U-Boot patchset (it provides required helpers).

This was meant to be marked as V2.

Changes:
1. Replaced io with mmio to be clear
2. Replaced 2 existing drivers with generic implementation
