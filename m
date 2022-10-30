Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACB6126EC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJ3Cn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ3Cnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:43:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D5481D3;
        Sat, 29 Oct 2022 19:43:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o7so4549479pjj.1;
        Sat, 29 Oct 2022 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ggnKUyDGzSh8VA712RZdHnC7EeozkTTB151R7EI0vc=;
        b=AxktH6M6HembcbtUcw2e7dm1jU4rZ4V5w1dInI2pOM7Z3MVhPI/5TE8H7ZYg7qrk4+
         eoshHs40IrICubHsVpLVkhysyXK01MdJkh7zvVUDBTG2vJqy2S2jPKsINmWZs4Dt2tAs
         WI1YKzKPhMGCfG/lx+hWcI+J+fW0xjcgTVXwfLRepKil45VlhXJ33wyYxYuWYqLZLHbj
         myPurIu/gBKT/wOSOx3FhkrRwP9cfpQx2jZZu2MeurxHd7wibY6j6v1kGFiq3tNIUjL9
         dg/piWbIbs/Vb+Kw4nFLNWwu1AIJqCKZ84Zn9RVncfaWaycGVIDlnpwexv0TmAlfabPy
         c9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ggnKUyDGzSh8VA712RZdHnC7EeozkTTB151R7EI0vc=;
        b=3kqhdIm6M/ptP8f08TKOWwNipMZHoInm0biPDk752HkKIsvDzaDdBgUjw4RSlSXq0d
         Yxpc6KWDUVlbXZo7JiozoRSSg75N3AWwPKdzf3nX4C3Nr6PzAe/zfsonZBtKvSbLl/Jy
         8eZI6J2r1MTCBjOlvXPT2ZwlZADbKyURRehr0lh6ivVtj6VigqZzZSc+qBHYIEQXCOgo
         2Nznf3Q7gbOc91l5DBcHBSu22sgy0LjFRvs4zm31tM7bxN0lXxBU6YTX81Oc9JnyrrWo
         jkJaivRoSPywRPWGaBXcNKR4jMGB9dhFuXMLZujSgw8Ont1n8x3h/dxkY3fIC0IHcO8D
         /awQ==
X-Gm-Message-State: ACrzQf0uCUMLjzqWALHJEThCGVcfHFaKCvpywEnkG4ekcGvNGDWiRbkA
        VhOicoh29X+s1X75hd+QXgQ=
X-Google-Smtp-Source: AMsMyM4JhLEMjvo9skcbp6g+szVwSDHLrkiWnVSk3Y+eTN1lvn68Nr0kdADV4KGqo4Rh48PyOwgqAA==
X-Received: by 2002:a17:902:b601:b0:186:9f20:f6a4 with SMTP id b1-20020a170902b60100b001869f20f6a4mr7380307pls.38.1667097832539;
        Sat, 29 Oct 2022 19:43:52 -0700 (PDT)
Received: from ?IPV6:2001:8003:d90f:f801:7164:b4e6:b90b:c4d5? ([2001:8003:d90f:f801:7164:b4e6:b90b:c4d5])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b00186e34524e3sm1924242plh.136.2022.10.29.19.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 19:43:51 -0700 (PDT)
Message-ID: <b874e6ff-6a19-410f-1fe8-2334a58f503a@gmail.com>
Date:   Sun, 30 Oct 2022 13:43:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: vchiq: add 'static' to function definition
Content-Language: en-GB-large
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221022043548.1671644-1-scottjcrouch@gmail.com>
 <Y1Okpjbi2kKU2GFz@kroah.com>
 <52599d6e-dc16-4186-9fb9-d17ce428fe9c@app.fastmail.com>
From:   "Scott J. Crouch" <scottjcrouch@gmail.com>
In-Reply-To: <52599d6e-dc16-4186-9fb9-d17ce428fe9c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/22 01:08, Arnd Bergmann wrote:
> On Sat, Oct 22, 2022, at 10:07, Greg Kroah-Hartman wrote:
>> On Sat, Oct 22, 2022 at 03:35:48PM +1100, Scott J. Crouch wrote:
> 
>> Nice try, but this breaks the build in a very horrible and strange way
>> that no one has been able to figure out yet:
> 
> I got curious and figured out what happens:
> 
> Without CONFIG_OF, of_match_node() always returns NULL, so
> vchiq_probe() returns -EINVAL unconditionally before calling
> vchiq_platform_init(). 
> 
> If vchiq_platform_init() is marked 'static', gcc's dead code
> elimination then eliminates it, which in turn means that
> 'g_fragments_base' is never initialized and gets replaced
> with a NULL pointer.

Good spotting.  Actually, I was clumsily learning how to run sparse on the
staging directory and wasn't sure what config to use that didn't involve
enabling everything manually.  But from what I can tell, it's OF_OVERLAY (or
something downstream of that) that gets rid of the warning.  BCM2835_VCHIQ
requires BCM_VIDEOCORE which already depends on OF.  I'm confused because I
don't actually know how to reproduce the gcc warning without manually enabling
the module such that OF is enabled but OF_OVERLAY isn't, since allmodconfig
enables both -- maybe there's a way to do that.

I'm also confused why devm_rpi_firmware_get() doesn't have the same problem as
of_match_node() just above it -- it returns NULL when RASPBERRYPI_FIRMWARE is
unset, but gcc still builds without the warning.

Scott.
