Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34220672EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjASCUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:20:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BB34A1D5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:20:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g23so941141plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWzi4FszPCAYHVAFXqTsDuOwUCZez6D/LJNzjwyCvFU=;
        b=i0XzXpg6JrMy9+r3izMeYrgcwoZbymgggdNx6nMke8jH1Xfmlbr3sYavNml+WVYemB
         Hv2U4OExsUUK1VweQWSyxURTiPEzXHESs+oUlzUd2OMEwNC3VvAjMO+cjAZ9eh6TOyJ+
         YNzdFrLR1z1icOoCDN5GbGX6pDax/aHf4/ji37l07sYcrV0QpuXPseub2KDafexP30R9
         8GbrK2WGbNfn6OtdgkkeUskglxjOXMbZkbFlff0k4+yolnC9LgbNaF2KGz+2Oky6+XFH
         DrChoe5AyQap5qAkHv9lNnAwOL9TbDOxNKJ2C40COXkZJPn/iZ8GtHEt5I2N1XDukGCG
         jrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWzi4FszPCAYHVAFXqTsDuOwUCZez6D/LJNzjwyCvFU=;
        b=MTTfOEZTykoyAd7pfphB3NoguS7Fda/Am7H4k5RlWzeR2g9QbgLUNk1wDf3O1XxkCa
         nHVc//Zp52r1AXZLZxIzIIPBQwr9ItxS7asKC0c8oC76LQytyePe9ccRObBv0+EfuZ8r
         GWhKMYzqo5eB7NlD5fjXT+J5lU9RDLgYUyrSe0NGv7NhdQIk0phk/emgFk1dhISfKTRx
         cTBiLqujLLOHMfgvtW3pOw8T1U46UH9vywjB85iCUF4nAkpvC6KS+GDys+lXArtHV2Sa
         FbVGiG7uDhB+EIcWUUgoAEsdjMN8PxNEF6Kiee92n/5C5sOy6TAFGT3xIB8nebV7x1nE
         Zj7A==
X-Gm-Message-State: AFqh2kpGpNAjUvYCM/KrF/dZaXbSHpUgrT2ophzLDj3bb4ND4xDw882x
        SmpzeOkUD7qkAwvTnrIzlV8=
X-Google-Smtp-Source: AMrXdXt6yFXu4C1N8gCSSU981KFlQ5pqSACckmkgevCx5e0mjAO83uzOzWj3Z7Ycoj5dF/lFfc7t1A==
X-Received: by 2002:a17:90b:2389:b0:225:d190:f16c with SMTP id mr9-20020a17090b238900b00225d190f16cmr9431574pjb.21.1674094838110;
        Wed, 18 Jan 2023 18:20:38 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-70.three.co.id. [180.214.232.70])
        by smtp.gmail.com with ESMTPSA id r6-20020a17090a690600b00226369149cesm1962568pjj.21.2023.01.18.18.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 18:20:37 -0800 (PST)
Message-ID: <91f39075-f26d-9f4c-6c7b-4056b769d32f@gmail.com>
Date:   Thu, 19 Jan 2023 09:20:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] Fixed typo in comments
Content-Language: en-US
To:     Semen Zhydenko <semen.zhydenko@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230116222254.74479-1-semen.zhydenko@gmail.com>
 <20230118220828.85115-1-semen.zhydenko@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20230118220828.85115-1-semen.zhydenko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 05:08, Semen Zhydenko wrote:
> To change one typo in kernel/time/timer.c
> Typo is "aquisition" proper spelling should be "acquisition".
> 

This is v2, isn't it? Don't forget to pass -v to git-format-path(1)
to mark it as v2 patch.

I have also Cc'ed the relevant subsystem maintainers.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

