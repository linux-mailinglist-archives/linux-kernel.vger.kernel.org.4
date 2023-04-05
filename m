Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16E6D75BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjDEHnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbjDEHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:43:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF31A1705;
        Wed,  5 Apr 2023 00:43:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g17so45495324lfv.4;
        Wed, 05 Apr 2023 00:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680680609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMV6Kvqpqf15LLXkZfaS1YQSCgbm+tGgQhSsnurFVJI=;
        b=UBqZw9jeyp6EbVR0W4Skbu71MdWtyVoRUEyXWsGKg1iZRQEom/kkJ8/jS4wfdZeAAm
         G+aYozqJiC5ffI5alyIqHj2zV0uOVN6WXIiquVLN2RKvTsZ7n3BaY96fLJCzbshSlaar
         au8tp/WIfCKQr9QbemytyIJgHiP5mWdyFzHkM/9AfDN/QxjTDaWthVj9tbq99VF4qH6F
         fO8RN/qeCpFgGvZFNbsSQmNvygo3jVGEqCU2EEwEJekySBfhMlfSyApHdlCHuM43TcII
         jZgs0cAXScYBdAuXILxzt+/mK7yiAF1Gufd54+UlqFKcwj/u96ZGpnPNSqDsZsqePJF0
         jbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680680609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMV6Kvqpqf15LLXkZfaS1YQSCgbm+tGgQhSsnurFVJI=;
        b=w0Jc6RmMlC1Vj82rMKxfG/o1yRbQxKRTIqRgSNzZCjSWLO02vxUmFavg9Dx46T7Jg7
         MuzcNQmwHU1Xrd8A6uVPAKaUv7w7uNWCYlBpcJPd4O7cuEK8VZvIY/jHotRgy0P+JvN3
         GMatvNL/H5LFNRX7PtBSWkV4KlOMNaDmei95Be+yJXEgWTNGPEPIeM7fjg4/H+9X/xiO
         CIoq08LhVzR595t2E/BtMf0a9aHnUqYVoM3sypeC80GJFbdN+as7+N/LVz6GltovbmJu
         M2MGeM5N+fwQwwXtYysIGvpLLrgwUTw62kElPu23pLY4ksV4nCROwRQDK6ES7D/pQMAr
         xgMQ==
X-Gm-Message-State: AAQBX9exVb8ZgVR/lJi+jgGW8Q7k2W3EA3e6tZQ1BBy/GYaHQr/FpDAG
        q/Kv0hymT85YdvQL8hJpixg=
X-Google-Smtp-Source: AKy350amEsGRR6DFEbEZxGOf0MvUew3ajkt5VXkCvIOw52if6Q5iLjuNnSGzEuYCWTyrytpMSDGUSQ==
X-Received: by 2002:ac2:54b5:0:b0:4db:3605:9bd3 with SMTP id w21-20020ac254b5000000b004db36059bd3mr1137702lfk.17.1680680608938;
        Wed, 05 Apr 2023 00:43:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q24-20020ac246f8000000b004db513b0175sm2693866lfo.136.2023.04.05.00.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 00:43:28 -0700 (PDT)
Message-ID: <615c87ea-a5f9-d339-eedd-39e4f24d539e@gmail.com>
Date:   Wed, 5 Apr 2023 10:43:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: dlg,da9063: document XVP
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
 <20230403-da9063-disable-unused-v2-3-2f1bd2a2434a@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230403-da9063-disable-unused-v2-3-2f1bd2a2434a@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 08:29, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Document that the da9063 only provides UVP *and* OVP in one, and
> therefore requires both configured. Add an example for clarification.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

