Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED36DCC45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDJUrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:47:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BFE9;
        Mon, 10 Apr 2023 13:47:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i26so8218032lfc.6;
        Mon, 10 Apr 2023 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681159638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW2CsOzKco12uWWod+vD1N6uU5SvCHMYgWY1z6r3F6M=;
        b=kARiaH+sbyA8AN4sXtY86hjyxA0xBZ2CpHN6GsoQ4XqawGohQKf9bcleripc62j98r
         51+W7GxBOnKKvawhrnucIkpyJ3A05mfeyeh/E0b8Lm3iT/tSNrdoNhbJs2qB4OWtMJJQ
         nJPG2Nh3s7nV55Hwa7PVtHO2vnm0Q6AcX3a9MekSKmVkruEPlMMp1Jp5ljY822nNyWZj
         YM3R0QWN8VcmVK3RaZ1bsIGWqqUDQQac/bbsgHpstpJx+XtFcThw06C2+/r0R4lu1FUy
         DumFfWRhAeFi3mUZtyNB3pnKkW3osBuYCNlV0rhKcS0sZSQ7hxEr1tfj6ciIkd3wJiwX
         ssPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681159638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wW2CsOzKco12uWWod+vD1N6uU5SvCHMYgWY1z6r3F6M=;
        b=Xn9dX6OV2iC5a2SF5zJL8k8mxW3hh+4JIAYdHMtfA4nBY4Kf1ai8pv4qObjFG6fRlE
         IqBWmxAp/qNxj4YwX86ZMYdj8Ufu4mGqLhmX0LenJFA9Yx/qZtqHZKOJ2hpkd95QUzQh
         vL9nK0dR+ZwgKwspHJuMXAK8xqzyLOWne6qxsNL1gOLqYxcIASo15dG7NAZRxCBbo/I8
         aYv+4qeHwu4ImSilTczdT1s4mUCz1Eiw2SBEzKqWh7jMYLdd7oyruAQNkKh5kSbzb8Up
         3treJ00YM999TSQTzppOLFJPuziH4PVORSqSpnD6RBOoSQVdSibZQJ7XoRWzBy8Z7ZzT
         u/lg==
X-Gm-Message-State: AAQBX9cMwaz92+GrrccbU8AFgnldXD1s9odHeDEDUNn563rHwb/fLZPi
        8w6D+bVlInn982HvuYydhJGR/xoWXTI=
X-Google-Smtp-Source: AKy350ZRoGOHgWT/YIps4oRfYxG3Kfq7547hKudtc2Dk4JnS+x9QrNS/nkbYFw1ze1+U5mFuTq2qBw==
X-Received: by 2002:a19:f712:0:b0:4e9:59cd:416c with SMTP id z18-20020a19f712000000b004e959cd416cmr2491997lfe.0.1681159637987;
        Mon, 10 Apr 2023 13:47:17 -0700 (PDT)
Received: from [192.168.1.13] (81-197-197-13.elisa-laajakaista.fi. [81.197.197.13])
        by smtp.gmail.com with ESMTPSA id z11-20020ac2418b000000b004eb2f35045bsm2260850lfh.269.2023.04.10.13.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 13:47:17 -0700 (PDT)
Message-ID: <4017c904-9918-3e0c-b687-f55cfc5c4f4d@gmail.com>
Date:   Mon, 10 Apr 2023 23:47:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Per-process flag set via prctl() to deny module loading?
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
 <ZDQQ0B35NcYwQMyy@tycho.pizza>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <ZDQQ0B35NcYwQMyy@tycho.pizza>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.4.2023 16.36, Tycho Andersen wrote:
> On Mon, Apr 10, 2023 at 01:06:00PM +0300, Topi Miettinen wrote:
>> I'd propose to add a per-process flag to irrevocably deny any loading of
>> kernel modules for the process and its children. The flag could be set (but
>> not unset) via prctl() and for unprivileged processes, only when
>> NoNewPrivileges is also set. This would be similar to CAP_SYS_MODULE, but
>> unlike capabilities, there would be no issues with namespaces since the flag
>> isn't namespaced.
>>
>> The implementation should be very simple.
>>
>> Preferably the flag, when configured, would be set by systemd, Firejail and
>> maybe also container managers. The expectation would be that the permission
>> to load modules would be retained only by udev and where SUID needs to be
>> allowed (NoNewPrivileges unset).
> 
> You can do something like this today via STATIC_USERMODEHELPER without
> the need for kernel patches. It is a bit heavyweight for a
> general-purpose system though.

So the user mode helper would be launched whenever there is a module 
request and it would check whether the process is allowed to load 
modules or not? Does it know which process caused the module to be 
loaded and what were its credentials at that time?

-Topi

