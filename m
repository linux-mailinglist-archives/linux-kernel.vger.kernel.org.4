Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5684E5FFCF3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 03:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJPBon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 21:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJPBoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 21:44:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417910B4B;
        Sat, 15 Oct 2022 18:44:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h13so8215928pfr.7;
        Sat, 15 Oct 2022 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNCr0cT7SRDicJHh/1Ct4baNI13cJ8oHw3VPXGfKCnE=;
        b=YeCSgFwRBwDtQo6TVk10KGxK8lywxBYw06xVlXjZL6F5MP5WKobTSGMfQ1L27vlh78
         iRkF0tnEjZYiHq5RJ+h+8UOc0QYmVU9TaZFFTEQeY2S+Zdbxlfrleqn8aZI1yQTNmIkb
         7aFiA6TxJBuHjphcBVXFjK35FgrfmTENrYr2bQhxR9zNN366semr+n5jVo0glNZeFp5i
         5bCs+5Di1y2HUxu5RAu3AY9waQceicJc/UedpI42Mlp/8WmuTyrlHwKqSUqwgVrkOrES
         6zvUrak3GmUP+2Q7zoIpdf7fFXkH1Bd3nnE2mPV0gVKtd9qrAS5uDAgVs/6zMrpR/6JG
         zweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNCr0cT7SRDicJHh/1Ct4baNI13cJ8oHw3VPXGfKCnE=;
        b=UCZb6SKS3Vh7rt8EPJS19kjJfk1rYk2MFbZr8Nt8dYDL0nu9cQNvg/3IWJM1hawlJz
         2uE06iyvqv3muOUx6tjxjjvb1U5Tcc0YgzhyNMiVZfdpNZB8xLnM0Zsb1MSxyyFwWMvR
         9UgQLCDC9QioyJ5JZKMKdfy0AjVvmZaJFDk2z+1oJ8A/w14l211TZk1TS/aQIQ9Zf4/c
         8f1OfQ/4WgJr1UQlRmnk0Vm/AejNDosLxQeEkMLjbcM/BoOwd2ap2BQYPmi58FF644dG
         cymFTvQXOP571tEmTZGC48sfhlMfqYrOTV7v0lec/+il81T2XpJQtoF8cXnT0HdnqmWI
         Tvbg==
X-Gm-Message-State: ACrzQf2ZJop1aU3cz0YUAoynG+wuunON4bZplFy+zRHpgvxZdqszEiSG
        eE9FH2+VBss5Z7ne6uNzRgsDcdmo6C7boQ==
X-Google-Smtp-Source: AMsMyM5ZRkCW7mRi0jMiqq0TOtOxceKA7RloDRkmptlyNLmXZRC0Are4FLQKcCDPo3EsaUL+Y0Ko2w==
X-Received: by 2002:a05:6a00:1487:b0:563:6367:8a17 with SMTP id v7-20020a056a00148700b0056363678a17mr5382582pfu.85.1665884676955;
        Sat, 15 Oct 2022 18:44:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id mt11-20020a17090b230b00b001fdbb2e38acsm7194279pjb.5.2022.10.15.18.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 18:44:36 -0700 (PDT)
Message-ID: <0cd7ad6a-7b70-2b09-9f17-40ffbc17a7fa@gmail.com>
Date:   Sun, 16 Oct 2022 08:44:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Olliver Schinagl <oliver+list@schinagl.nl>,
        Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
 <a4803f2e-2e46-1c7d-0e89-96f5cbb0ad11@schinagl.nl>
 <00604162-9157-3862-b463-de90cb17c69a@schinagl.nl>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <00604162-9157-3862-b463-de90cb17c69a@schinagl.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 21:16, Olliver Schinagl wrote:
> As this thread kind of went silent and as the 'big merge' for this feature is getting closer, here a final plee, inspired by this slashdot post [0].
> 
> The post in itself speaks of a new team forming on working on the Rust styleguide, which in itself is still evolving. This makes sense, rust is new, it's not very commonly in use and as with all good things, they evolve.
> 
> One comment in that slashdot post [1] I want to bring forward and quote a piece of:
> "i created a new repository, and thought i was being hip and modern, so
> i started to evangelize spaces for the 'consistency across environments'
> 
> i get approached by not one, but TWO coworkers who unfortunately are highly visually impaired and each has a different visual impairment
> 
> at that moment, i instantaneously conceded — there's just no counter-argument that even comes close to outweighing the accessibility needs of valued coworkers"
> 
> Visual impairness is a thing, it does not make someone smarter or dumber. Helping those with visual impairments should be concidered, and not shunted off by saying 'but the rust guys came up with the perfect style, so we should use it'.
> 
> Find attached, a diff to the .rustfmt.toml, that should keep things more consistent with the current kernel style.
> 
> I'll leave it now to Linus and Greg to concsider this, and will keep my peace (though I hope they actually read it :p).
> 

I have to say two advices:

First, don't top-post. I don't know what context you're replying to
(in fact I have to cut the reply context below your message).

Second, please post the patch inline, not attached. git format-patch +
git send-email should suffice.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

