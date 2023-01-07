Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8566127A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjAGXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:03:23 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6E34D6F;
        Sat,  7 Jan 2023 15:03:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g20so3623862pfb.3;
        Sat, 07 Jan 2023 15:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ghLtHCxEHQN0G4J8VZiZj3ppzJlMdwxuQQiALlB0bi8=;
        b=PLZ+fpox0EVHAsl/kse4VxOpAI/itllww8vvFZz4QlOJnDgg38OJlVJQTYWeGMI/JT
         vr3rhlMRPRmsyoaj0ymPqZephZ1JzxYx+fouUUF9V24Wem+dY+QWHBddh2hb7dw/Dk5y
         N4to1k0IwLP5M95xE0Czpv+B+in/EvQjr7uUbOFKFRX+S+Ik+Ob3+u2SthZlnG5WEap9
         DxEaZG7oYh1At1gW/Mvgc6BWIUS7UC/8xGJnKmyS/s2OSX16OzDM2QxnUoTAPCGA75oI
         aNBxCLVQtVwUj1cv+RwriCZnQ0i41doPgYlNLFhBxKdw3oS2wI+Wr1CysiDdx7nCXRCW
         5V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghLtHCxEHQN0G4J8VZiZj3ppzJlMdwxuQQiALlB0bi8=;
        b=r/ulGJC+2nILbMMOUUkLI7lPDM80b9bN4TPxlRejPjsV2K3XJV0K8vws927M47vWQd
         W6+TOXmLhlQkqJd1So3ySMDkgAN4+4w87MGUkA0w4FRa6jf0QrSsB6T8PSd1DuVHzBum
         Otpp50r9gYdSNobkbL5/qaowW7BIzviBOrPPrL8z5CVvHSKZUHeWzDbRWH8AV4KFt8uI
         AnxXJqjOa9H46cTYRtU3ajgBo58zzwSi5psQHr4BOyUNKP4LsPucC5DJ3WbRPW2FOTF1
         GtkfSaj/oZhdOFay76BzTlKwmpnqiUx6pwompzvU+pjjqqSfGzEAl6y3woqPa0kFvNsi
         Tlrg==
X-Gm-Message-State: AFqh2koVz0tMAlpEn99XWcWZrJy/Ikyiwt5titzy/BylOm6UD8vEO0jp
        rl/zT2MbRwJEjAAKVjvfr1IOc68/9qs=
X-Google-Smtp-Source: AMrXdXtaYPXPcJhOlF3D5Ggj6ZpYWpwqNOwLh7+OYGnZbLIBfy9qbkqCBj9C7+mZQRJLjw5VkzIxlQ==
X-Received: by 2002:a62:1d57:0:b0:581:6979:5e with SMTP id d84-20020a621d57000000b005816979005emr43365172pfd.15.1673132597170;
        Sat, 07 Jan 2023 15:03:17 -0800 (PST)
Received: from ?IPV6:2602:47:d48c:8101:8a2d:2011:f402:6f82? ([2602:47:d48c:8101:8a2d:2011:f402:6f82])
        by smtp.googlemail.com with ESMTPSA id r4-20020aa79624000000b0056bd1bf4243sm3311428pfg.53.2023.01.07.15.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 15:03:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
Message-ID: <f1de15a5-1713-70e7-81af-a0090583d888@twiddle.net>
Date:   Sat, 7 Jan 2023 15:03:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] alpha: fix FEN fault handling
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y7jD8XDZGnQkTvMI@ZenIV>
 <84c0d4ea-09e2-4907-d03d-939d40fa3c96@twiddle.net> <Y7jdARsEQXPugR0t@ZenIV>
 <Y7nj80buxCO3u69l@ZenIV>
From:   Richard Henderson <rth@twiddle.net>
In-Reply-To: <Y7nj80buxCO3u69l@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/23 13:28, Al Viro wrote:
> On Sat, Jan 07, 2023 at 02:46:26AM +0000, Al Viro wrote:
> 
>> Not sure it's worth bothering with in palcode-clipper - for Linux it's
>> useless (run out of timeslice and FEN will end up set, no matter what),
>> nothing in NetBSD or OpenBSD trees generates that call_pal, current
>> FreeBSD doesn't support alpha and their last version to do so hadn't
>> generated that call_pal either...  What else is out there?  OSF?
> 
> BTW, out of curiosity - what was
>                case 5: /* illoc */
>                default: /* unexpected instruction-fault type */
> about in that switch in do_entIF()?
> 
> All documentation I'd been able to find had only 0..4 as expected
> values (bpt/bugcheck/gentrap/fen/opdec)...

No idea.

Historical git (cd52cb6178a7, v2.4.8 -> v2.4.8.1) suggests it's related to shark_mv, so 
perhaps a later revision of DEC PALcode.  But I have no corresponding documentation.


r~
