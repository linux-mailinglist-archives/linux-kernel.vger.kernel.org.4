Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13F3682AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAaKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjAaKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:39:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3165A5F8;
        Tue, 31 Jan 2023 02:39:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw12so24375019ejc.2;
        Tue, 31 Jan 2023 02:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbpzSrkDvZ+O3U1R2gkZ8q145/ganRKDqvC/xmnbE40=;
        b=CFwvhRlgd3EJKCDVmPccyV4ndF3iNiQbNtl/kkDLBh1rbLn9hq6YA7vKNkHpoXunxx
         9UWMuPaQrycb0/xEBRVFC90V3tpWfX7geKY9LdzkAVF9DrQ7929b24f0Dcp+Qt34TGPR
         en2PiwKNjkYUqad17tawZtVTm6Avd+hosMAGir8ASqaTkxu/FKQkvztqm7u+Vlc5hT36
         KvXrl6WXCJFK0YtFwivmPiN4fBjtmr4QZNIR3Mvhp3YXyyWTmaKOtbbx5YkyeIFG+NkM
         BFmcUlTEGYAPHgYOaE6ZZezWEImxSQsheJ29y9YVh6QyD+y/FF0o421nhVREuDrVrwAU
         W4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbpzSrkDvZ+O3U1R2gkZ8q145/ganRKDqvC/xmnbE40=;
        b=NBLxjKLVJwqLmKu9oR8WFa3aKjVU/okFOSpkK6PDtFrHwaGLf9C+FwsG3mwFh/f7R4
         uY/AVkbvzqR+yWeaCsIpzKr7X8AmEsP8CAKeF88esMoBFqYdkr2aifF2zxycz0uFSr6e
         PoxmQZDCAKEBphNi06ow7mJrzk6JYh9Bhd6GfBqVQa82iemN8xMWu1S91e7EA/f/xfDD
         6QO7Elt/hP3JJ92tFNjQAkrkigfugt5QMTiLa2DgJ6LQoFfPT6N/AKcSA3dXJoFb9PnL
         iO1zUWzYz6fZ4aea1P5rwccHSh1gfIYchg3vcqqu2HT2i2GeUpnn3rwBNuRDC0oatkuB
         LHuQ==
X-Gm-Message-State: AO0yUKUDtkTko7tZ8T1DbdCiangbevf6LDrCS0eB7etCAzWGc7eIT7gT
        fmSTWaFAwpR+h4t4kgRtjIc=
X-Google-Smtp-Source: AK7set87n9Vfg8hL/wOt1VTr60pE0bO72l9Og8zMg5sPwSjDV4cOjbpe0BRvjYS7/khoR4jWpG6vqg==
X-Received: by 2002:a17:906:30c4:b0:885:fee4:69ee with SMTP id b4-20020a17090630c400b00885fee469eemr8357176ejb.59.1675161588185;
        Tue, 31 Jan 2023 02:39:48 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bh13-20020a170906a0cd00b0084d14646fd9sm8108521ejb.165.2023.01.31.02.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 02:39:47 -0800 (PST)
Message-ID: <8c33967b-1b91-42d2-879b-fa73dd8ecbeb@gmail.com>
Date:   Tue, 31 Jan 2023 11:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1] dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml
To:     vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        linux-phy@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh@kernel.org>
References: <99794484-d67e-ee1f-4e76-200de20a879c@gmail.com>
 <167320365145.195794.14991903357914132463.robh@kernel.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <167320365145.195794.14991903357914132463.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/23 19:48, Rob Herring wrote:
> 
> On Thu, 29 Dec 2022 12:39:17 +0100, Johan Jonker wrote:
>> Rename phy-rockchip-inno-usb2.yaml to a more common format of
>> rockchip,inno-usb2phy.yaml
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>

>> Apply after:
>>   dt-bindings: soc: rockchip: grf: add rockchip,rk3288-dp-phy.yaml

Hi Vinod, Heiko,

This patch has been acked from the device tree side.
If it suits you is there Ack from the phy side possible, so that Heiko can merge it to grf.yaml in the order that he likes.

Johan


>> ---
>>  .../{phy-rockchip-inno-usb2.yaml => rockchip,inno-usb2phy.yaml} | 2 +-
>>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml         | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>  rename Documentation/devicetree/bindings/phy/{phy-rockchip-inno-usb2.yaml => rockchip,inno-usb2phy.yaml} (98%)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
