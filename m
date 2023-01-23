Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFE677D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAWNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjAWNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:54:40 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22983974C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:54:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k13so11499483plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD/8hfxYVyYFbu48JvxARFwdM5FdtUNz3QAClSONFs8=;
        b=ppma43Q03TDBgXLjnuOWFQHxjBoTYuUORi1ipWmU7edjQPATRS5chMc1rzxUaZpUDJ
         B1yBRYFUaK3VN9QxFtr74fVkqnuhYgh400Mwl618f8FJkv4dv3TGJB7xzx4BTf9w8qb3
         GA9obxb5Uw/Bx64WFiZvElYw0wDJTAjN3Tv0xz1D2sfGW/17IcjbMB+J2SEsHqUI0rnd
         M2O2yb/EfonrWAlygsqB24yrcRw8Z1zn5rQmdg9nhGtCqKbY/vy+yAfPcj++r8rAspGI
         We6n1DMk71cPiSljfgpBLIVJeJ0SNV/LVZbppWi69HsNwsiO8DZpO5teZwLzzjY7TVN4
         wTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD/8hfxYVyYFbu48JvxARFwdM5FdtUNz3QAClSONFs8=;
        b=hiZgAKHxKBSR8XufPeY/JTrPnDhnuiRh/x3IIMvLq+xw4qUiTrSPpm10Uku747zliE
         ArQ5iRxvmn+FaFbPNLhN/0jjC3vHJLkOrJ+omcmQKyC50W35Fbh9wFRQgDO8pLUfhMTG
         pqiU2OzyHVJFCNaViT1LmfSxFpZaWleAY7eOdyTnAF+FEj9rxVEiB29uLIuPqKCM5uv4
         v3Z78TH1Pq9J+wl44HlyR5Mp9hjaFviwj9yqfBtJHYpS8pg5/1SnOBVB+4BWUmgQIUYq
         StYYgNCYp+3pqqR7ZwhnIvx93Yc8LJQab8iXTRAi8V7DO9i77ZgeNx0E7t2KmvZFlCCW
         krcg==
X-Gm-Message-State: AFqh2kr44vIYHJZpXKszic41dykWwYXcBBMzbDpmouuw4eSW7Ga1fULW
        emj3gBWc0svBBzjQHJVkPr8=
X-Google-Smtp-Source: AMrXdXuq2/aZ5Rnr9hiDBKqlsrJezA90JdQ7bHWWsCWg5s5AVc46ldmrSfnz4jbdis3ot8pQXrRJLw==
X-Received: by 2002:a17:90a:5410:b0:226:de98:ee43 with SMTP id z16-20020a17090a541000b00226de98ee43mr25320247pjh.43.1674482079449;
        Mon, 23 Jan 2023 05:54:39 -0800 (PST)
Received: from [192.168.43.80] (subs09b-223-255-225-233.three.co.id. [223.255.225.233])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090a670600b002191e769546sm6536326pjj.4.2023.01.23.05.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:54:39 -0800 (PST)
Message-ID: <cc4d80e2-2be8-046d-248a-caeddfaaafc0@gmail.com>
Date:   Mon, 23 Jan 2023 20:54:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] staging: wlan-ng: Fix full name of the GPL
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230122191047.58769-1-didi.debian@cknow.org>
 <Y84wk+sw/gR7gNW4@kroah.com> <Y85Kkax5+U4AUedT@debian.me>
 <Y85Ux0uGYl0c//mz@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y85Ux0uGYl0c//mz@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 16:35, Greg Kroah-Hartman wrote:
>> Hi Greg,
>>
>> drivers/staging/wlan-ng/hfa384x.h (for example) has already SPDX identifier
>> that matches the verbose copyright notice below it. 
> 
> I have no context here at all, sorry.

Oh you mean context in the patch (surrounding text around
the actual diff).

-- 
An old man doll... just what I always wanted! - Clara

