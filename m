Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB476A6579
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCAC2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCAC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:28:38 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B335A5;
        Tue, 28 Feb 2023 18:28:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so1114pjn.1;
        Tue, 28 Feb 2023 18:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677637717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmN51dbTFHg3aDziTv/V6yP0O0YxrV+csosShMWfGa8=;
        b=YcxlEshvRD8BweKoqE1QAItpsAUCITBLZQ01yn2ta1gEVGD6kRKtCp8JpP3cHs32rK
         uecMypHqfzH4QIr3gm5+aRv7IMD27HuU/73rQHNnxPLzx76ZQM2X7dDXXSiOBaENbR+F
         Crtym58y7CSoYRTWkJQoor/QA1gBoWbLZVaKGlZXPYwqFI92bHv+IdhpEsXRUqMx/3Pp
         y4S2BMVlJ4OvxLEwRwcxc3YEUuerRfk79Yo/7bz+JgbGLca7vzwWxr0qdk8MNcJXEFtn
         yNVllbUpQuAMlzvSGd84jeJn/qvw5XVh8NJZbPz1hHoDPKrVFBVcoLlQLQzgtQDUNmuu
         19xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677637717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmN51dbTFHg3aDziTv/V6yP0O0YxrV+csosShMWfGa8=;
        b=p7Bb6pWBAiEwjZ6DpHAjEb4N59oJz3iEaeyUkHFNn4k0p+LcdM7gP0O33daiulDQK8
         l12rakH7ZATWljnMcbER5IaER0TldZNR0L3dAMjiZOv0UFIbms6SsDUJFR0Ne7Qo0ZWL
         mDiIqMPlph/Cvm9tQ47Y9XLZtbA30c7QPbUlxTWSx0jAHKDOswboaBTyHnHBSpCONqmv
         gkSukoVvX2Hz8FV2GQT39Jqw3Y+6hJZok+Fx8VskF6eJhyxQkDLIZCsT5fLCCD2rEhla
         85hbY8uBgV9YrMEO0gGRXXUu9RzXTGc4uwuCeodoqPPOlLFU6ganhOs6gsvQOmlELJen
         tvRw==
X-Gm-Message-State: AO0yUKVwYFmvdTmwtjac1GJiTdGZ67G5LEL29LO6pe3Tv5IRNzXy9Ss0
        gJCoIaCrZQ9UbW+9FoJLS530XxV23Sw=
X-Google-Smtp-Source: AK7set/JuvQ023i4V5p8CHU/gOaHKbdFrG2u5t7hs1h6e1UMq3d8K6oa0b7Zn02nh11tSMvjXKNjkQ==
X-Received: by 2002:a17:903:32c4:b0:19b:78:539e with SMTP id i4-20020a17090332c400b0019b0078539emr5366834plr.68.1677637717031;
        Tue, 28 Feb 2023 18:28:37 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b0019ca7b7a684sm7142317plq.161.2023.02.28.18.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:28:36 -0800 (PST)
Message-ID: <45757233-6152-9971-d987-e0ce27f92fe2@gmail.com>
Date:   Wed, 1 Mar 2023 09:28:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] coding-style.rst: indentation: Clarify tabs text
To:     Bru Moreira-Guedes <codeagain@codeagain.dev>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patch Watchbox <patch-reply@codeagain.dev>
References: <20230228222035.k227xb3okt2lbksn@guidai>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230228222035.k227xb3okt2lbksn@guidai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 05:20, Bru Moreira-Guedes wrote:
> It might be misleading, especially for some autistic readers for whom
> English is not the first language and whose tendency to interpret things
> more literally might be present (i.e., my very own self).
> 

I'm also actually autistic (∞) :) ...

> The present patch clarifies the tabs text on such aspects.
> 

Clarify tabs description?

> -Tabs are 8 characters, and thus indentations are also 8 characters.
> -There are heretic movements that try to make indentations 4 (or even 2!)
> -characters deep, and that is akin to trying to define the value of PI to
> -be 3.
> +The Linux Kernel uses the TAB character for indentation, as in the K&R
> +style. Tabs are meant to be viewed as 8-characters, and thus
> +indentations are meant to be seen as 8 characters as well. There are
> +heretic movements that try to use spaces for indentation, or make tabs
> +viewed as 4 (or even 2!) characters, and that is akin to trying to
> +define the value of PI to be 5.
>
  
"In the context of kernel code, tabs are intended to be 8-characters
indentation."

>  Rationale: The whole idea behind indentation is to clearly define where
>  a block of control starts and ends.  Especially when you've been looking
>  at your screen for 20 straight hours, you'll find it a lot easier to see
>  how the indentation works if you have large indentations.
>  
> -Now, some people will claim that having 8-character indentations makes
> +Now, some people will claim that viewint 8-character tab indentations makes
viewing

>  
> -In short, 8-char indents make things easier to read, and have the added
> +In short, 8-char tab size make things easier to read, and have the added

8-char tab indents (for consistency with above)?

-- 
An old man doll... just what I always wanted! - Clara

