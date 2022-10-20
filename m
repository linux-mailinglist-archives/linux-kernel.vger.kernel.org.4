Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C26055AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJTC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJTC4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:56:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7917C550;
        Wed, 19 Oct 2022 19:56:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so1794139pjl.0;
        Wed, 19 Oct 2022 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IneXvEA4RXH8O3z+9PeiWh97Dt1+hev7jQD9p0XzeCQ=;
        b=SmBwQ77iZ8Ell4qr5KbdljTvp4r4cGxKZCDwkAFbSWKbQ/Jw9QUmvEQlxbJaQZB3/z
         OGGhBqx74RZBIGGlcN58OJb+hs8lKmWFVPz0SluatE5URXeQ6IVfaiiCBrNz11ldHwvl
         /w+o1gf2atrIlyaA+A4lo5lMSgs1R3KbwhFUAR27FWWRZRnZLPIZEjhLIKysFMuoXD3N
         9k2caSY6y/LBSMWSNA7XQ1jHgEtMpPDObcX1cTBPyOfO4pgXzBNjloP7VW1pyg21VJgu
         SuEbhguW143KfBaW3Wxfcu62sWnvMimbbLO6PFFv3WRCrl1HCcOidQyJXzEVksOaZSA6
         hCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IneXvEA4RXH8O3z+9PeiWh97Dt1+hev7jQD9p0XzeCQ=;
        b=S6etHXG4Wv+H+NNmz20VcvxVSWD2W/wq9TieqHtxSDBM9pJ5ysKWhG5SdSzm8G4WSB
         oM7IetF301UxqAXzc4UWsfrN6Ge62OJaKrKMIYh0HsasSaUQRrKBSP+ymJMDX/nkq/2L
         8Kxa7PTbel+Dvhem0xVaVd/Usi033/TXTv82vUIbKIrWlD1/5iYaX7FlYwErWlc36/v0
         KgEembKnZnUwSnWyCtPJGxf+HkqzHA36xKXZV/XbAEAwlsw2f12jax2oUe01J8hsbffV
         dAhNTyH/WYZ81J/HsnEYQjQkth5JZyJS3UwF4QBtWfflX4BSj4cLupjH93FkTxa61LyL
         OlEA==
X-Gm-Message-State: ACrzQf3KoZ/iQdcC30ilnmbP6BfvPaf2po86QKpUoULN9vqTAt1SbR3O
        oftYxLCjZVDISAyMSEg6IWo=
X-Google-Smtp-Source: AMsMyM7LZp9fS9+vT58YHx52jB1RTGgNgVxo1udLEaQ8USN4foa5Vjg5y1BPMVCO88Uiyq+LsLKUIg==
X-Received: by 2002:a17:90b:2243:b0:20b:42a:4c0d with SMTP id hk3-20020a17090b224300b0020b042a4c0dmr47402403pjb.123.1666234566534;
        Wed, 19 Oct 2022 19:56:06 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b0017b5e1f486asm11652518plf.211.2022.10.19.19.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 19:56:06 -0700 (PDT)
Message-ID: <25e6e305-69d4-f244-c255-3e832edc2f28@gmail.com>
Date:   Thu, 20 Oct 2022 09:56:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] doc: phy: Document typical order of API calls
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221018175841.1906611-1-sean.anderson@seco.com>
 <e002248f-7070-3f89-04f2-e7f694fad5cc@seco.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e002248f-7070-3f89-04f2-e7f694fad5cc@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 01:01, Sean Anderson wrote:
> Hi Vinod,
> 
> When sending this patch, I noticed that Kishon's email bounced. Is he
> still maintaining this subsystem? He hasn't been very active for the
> past year.
> 

He's now using @kernel.org address <kishon@kernel.org> (see [1]).

Thanks.

[1]: https://lore.kernel.org/lkml/20220928102431.658-1-kishon@ti.com/

-- 
An old man doll... just what I always wanted! - Clara

