Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153163941F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 08:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiKZHHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 02:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 02:07:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA22CDC5;
        Fri, 25 Nov 2022 23:07:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so9539472wrt.11;
        Fri, 25 Nov 2022 23:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqb9frWMs1FTHmuWJ+6Lz1LpqSCGlAmS4ql2oCxCMaw=;
        b=lJM1FthCAwm8VDVjm5V+bFgVDuFTNZzJ1a7Eg5b6P6Aj1aFGnDi9rDX8s57ImBZu73
         hRaCPXh8z3A9Z9Otn9eTNJre4BXWmdl0/VSlN4thgieJ+bg7laRuW4DvfXpJJLysSDdR
         +mX0yssdY1bUNP8MgF8OrOf/PobTwACI4XuB8PVNs3UjkuGTWDkhz77fxj4QMnNp89cn
         szETNKbUA3zuNNKaePBsFCHFzFwEQIfsnBPtIhRyQcsNgxyTBnhW6isMK/x/cZqmonZF
         kAj6nfuNzNOXunIPnl9evCzga3xt4fRMdOuEmA0Ot9srH4PxwN/bFjkiuY3cKB3vcRKV
         osew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqb9frWMs1FTHmuWJ+6Lz1LpqSCGlAmS4ql2oCxCMaw=;
        b=PAPHifHDngSfduvKxbYnZS+Rkqtd6+G2vgrUnf609Sl0qgRoPpb8fHxjT27vft+9PL
         r11CO7C5STPArWOveL8g6bQCi6ZKolt5zCHO/a+VHxgm0rheIfzDR+rAPbVrcefpr07N
         z8tl6qLWPXb4V60p4AkExIyYkfecK+jaM13aNUYrGLyDGtmj8XuUd6AX9m0ZiIvs68lQ
         D+EKVPQYSDw36AAKw5puvYjl1MWH3jwARs8t1/N6otSBUpcXPReQDRl85WQQz07L8KLD
         tLO8R2skX+SQ5I6prbDQxiDdl6LgMlDEY6ldQJDs+ruilRSPcu/UkeTK9JeP7hI885LI
         TBEA==
X-Gm-Message-State: ANoB5pmdgnPpsSHtZdpf3tCvdYg+zqBJ3O6oyKUgtynQwcLcOR+l32zf
        aJtslg1ReRNV8WNom6bSOgj5gWWzpoU92w==
X-Google-Smtp-Source: AA0mqf404PIvn1LI/sd5fqHbRo2EZHtz79mSKX7vQKSRVlo50SgPI1MTVA0YrcpjvcMffAkUf0+0cg==
X-Received: by 2002:adf:ea81:0:b0:241:bcc1:7643 with SMTP id s1-20020adfea81000000b00241bcc17643mr14674576wrm.673.1669446421094;
        Fri, 25 Nov 2022 23:07:01 -0800 (PST)
Received: from [192.168.0.22] ([87.116.166.89])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003cf87623c16sm13057984wmb.4.2022.11.25.23.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 23:07:00 -0800 (PST)
Message-ID: <353c28bf-8534-e06d-a173-48efccbac5c0@gmail.com>
Date:   Sat, 26 Nov 2022 08:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc:     savicaleksa83@gmail.com, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for Quadro flow
 sensor pulses
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20221125215515.31380-1-savicaleksa83@gmail.com>
 <d9728160-001c-9e29-b195-0cbc82b45184@roeck-us.net>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <d9728160-001c-9e29-b195-0cbc82b45184@roeck-us.net>
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

On 2022-11-26 02:49:27 GMT+01:00, Guenter Roeck wrote:
> 
> I think "default:" is now missing here.
> 
> Guenter
> 
> 

Right, thanks! Sending a v2.

Aleksa
