Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A06AD521
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCGC60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCGC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:58:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D52684F;
        Mon,  6 Mar 2023 18:58:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kb15so11904176pjb.1;
        Mon, 06 Mar 2023 18:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678157882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZG9H8kJCK6WYwRPdpe8Xhn57MezozsZ/GiZoddNadUo=;
        b=eMu1WXHDVsaEZqx58s0fbo89SuPSweqXF8VArjA18ypdz+WK9HYC+qeF01v/VxFutq
         40G7EQfVkrArxG0lYsdVq1+aeyZVCPtLQOleYt6NTfyyn2dWauL94rXf81rTGrPhw00P
         5MWx3n8KYTGt7mH7qy3TeYpY3GEIJ9x81ycdsa/xxyedyakrtZLne71q8FwxN5iuEvne
         cM/epRuPbomeYnz/6yhSOX2ghgT656w13Uu0P/chhlWqj8BOuZYdQzMQzodXi1P9IGw+
         qukbRip9ScaZQWpQMluK6pMZai20XhyAg9QWHaXSTPBOLG0lmVP/XNFWWDwfRN1dCxaV
         FgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678157882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG9H8kJCK6WYwRPdpe8Xhn57MezozsZ/GiZoddNadUo=;
        b=OD6sAZLQomeR7vLwTbfCJC1uO6agbPakcNMSt4M8HDJOzRGOnRcN538JsxtkYI2pdS
         PBocINPv0Pof1YJ+fEbYpn4qeNXTxb+51v47DiC/Zg4Z8Z1CriHrS1zDZXx4puHBIZwv
         BVUd4UMtOC3oG/jS//IYIeWk+0qYjsdKLxSeLRV3ukFU7Y7vUBIxTva0nEQewbmj/x5f
         CnCxhDtP4SSBazTTaoh53ZXcH0MctvdMTdikSyZ6BuSpScOLSDV3XMdfbgewZk9liATC
         DD70nFd4UwbASA0xZUh9XVWv0GDDc/EOzMS4/OK4JBtlWO4IjreMr1/zEJsacEa0AKCZ
         OihA==
X-Gm-Message-State: AO0yUKWFmDaRgJlmG0H7p4+3wrsi4l04lYCEp1J19YUHk7UrZamwSkmD
        fg+NlVskil2xcnZFyhLDetMSe7F3OaE=
X-Google-Smtp-Source: AK7set8sebQi6ka4Uw0tIudv7vur/G+YowtMa7d1No3GHx7jRxgAdVzieGfTZ3qknMwreU/Tot+KJg==
X-Received: by 2002:a05:6a20:a025:b0:cd:9db3:a7c1 with SMTP id p37-20020a056a20a02500b000cd9db3a7c1mr11838174pzj.44.1678157882389;
        Mon, 06 Mar 2023 18:58:02 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id x6-20020aa793a6000000b005a8dd86018dsm6971769pff.64.2023.03.06.18.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 18:58:02 -0800 (PST)
Message-ID: <2d1362fd-c109-1d8f-5954-3d60475ed907@gmail.com>
Date:   Tue, 7 Mar 2023 09:57:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <ZAVp6jdeWzYcisUO@debian.me>
 <3d6a30ee-f093-f5b6-a193-cd86320f9452@leemhuis.info>
 <f53f84b5-9da7-0726-2e1f-f7e81e8ecd24@gmail.com>
 <b12d433e-62ea-3ac4-dd97-be0288f1335f@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b12d433e-62ea-3ac4-dd97-be0288f1335f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 16:07, Thorsten Leemhuis wrote:
>> I think it depends whether someone would pick from /proc/config.gz or
>> /boot/config. My kernel configuration have CONFIG_IKCONFIG=y but I
>> often copy the config from the latter instead, since I booted with
>> arbitrary kernel version when compiling two or three versions, and I
>> want to ensure that the config used is from correct version (i.e.
>> I use /boot/config-5.15.x-string to build 5.15.x+1 kernel).
> 
> Well, I'd say for most users the file that was automatically picked up
> by olddefconfig/localmodconfig will be the right one. And for cases like
> yours there is already this in the text:
> 
> ```
> The make targets try to find the configuration for your running kernel
> automatically, but might choose poorly. A line like ‘# using defaults
> found in /boot/config-6.0.7-250.fc36.x86_64’ or ‘using config:
> ‘/boot/config-6.0.7-250.fc36.x86_64’ tells you which file they picked.
> If that is not the intended one, simply store it as ‘~/linux/.config’
> before using these make targets.
> ```
> 

Ah, I don't see that feature! Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

