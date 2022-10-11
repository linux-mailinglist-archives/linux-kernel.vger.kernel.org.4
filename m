Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498925FAA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJKCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJKCIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:08:18 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B34753B7;
        Mon, 10 Oct 2022 19:08:18 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0C7BB401B5;
        Tue, 11 Oct 2022 02:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665454095;
        bh=4WO49grOBiJl/rCd0rQT7UkOwQnggatViyK+FXpwnNE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=at/Rgt8prKMh6H7gS5msExDuUtmEatDaXOAoCMK2ys5hi1eXwx1nPmnbf0itOxEzg
         SCPiuNM+CP6bgoP1+9jQHlsl2X6zsoDOdoR2gXNYtcjNmRKXxJiSJfcFKuanAETG5Z
         zZHAvhBwMpUPPZ7rF559H2luJgojkVOagWEqk5vCfx7jTQGBI00tuFM8boo1MZjA4n
         AbPcw1WDoC1GfJlrHeVuFuDaYo0GZL772mlV8XCI1pUWu5rlOP9Vc77uQf6EqmjRKF
         PQ9SkrqeZ7E63IgJf7o6WTuHy2wvhOd96qFbpLbRgQD3Jjch0H5qDh8ttmCKJDqlCW
         krv5UxkWF9o4g==
Message-ID: <3f84d6aa-f472-a1dc-dd05-a32267a6d074@canonical.com>
Date:   Mon, 10 Oct 2022 19:08:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] AppArmor: Fix kernel-doc
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221008063411.14829-1-jiapeng.chong@linux.alibaba.com>
 <20221008063411.14829-3-jiapeng.chong@linux.alibaba.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221008063411.14829-3-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 23:34, Jiapeng Chong wrote:
> security/apparmor/ipc.c:53: warning: expecting prototype for audit_cb(). Prototype was for audit_signal_cb() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2337
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/ipc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> index 1d4099385bdf..5acde746775f 100644
> --- a/security/apparmor/ipc.c
> +++ b/security/apparmor/ipc.c
> @@ -45,7 +45,7 @@ static const char *audit_signal_mask(u32 mask)
>   }
>   
>   /**
> - * audit_cb - call back for signal specific audit fields
> + * audit_signal_cb() - call back for signal specific audit fields
>    * @ab: audit_buffer  (NOT NULL)
>    * @va: audit struct to audit values of  (NOT NULL)
>    */

