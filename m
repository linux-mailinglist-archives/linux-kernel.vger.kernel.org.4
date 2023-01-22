Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3567721A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjAVTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVTpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:45:20 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDB1DBB6;
        Sun, 22 Jan 2023 11:45:18 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12c8312131fso11927660fac.4;
        Sun, 22 Jan 2023 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxMGAEAUSXQNoU2iAORiSh+x/TTDGnNFEWHhhKKV3H4=;
        b=KLAv9eaznnVHS4p9in5cI1K9bj2HIHFEBpT4KhAChkIWJbTeJGdAV8EJSX8TUknTQh
         VthHJ89cH8lzQnh/WLSl1EXxOEqe68hWNox+hFrqyVeHQR/aaxgWkWG3UYpfOWo5qXVY
         m9Jp9vFhL5W0xSOrxZF8SQkwE1NS8rFjrj87OFTbiMFt1aeQrzmXHPr+t3OWj9bye2j4
         QfUl/LuQO5uMSReU3USgLtURvfPEY26xEhJ8VWtDX8AMqVH7v11f7Ve3bHk0Ey6B++Ba
         0nsDV3p7r5pb8++77qN7YcpCGCyQzEpPDTbES6so5YN1e6SwqyG/KVsSxbmh6fmIN8Iy
         n16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxMGAEAUSXQNoU2iAORiSh+x/TTDGnNFEWHhhKKV3H4=;
        b=2tzlLQVGSOlqYTwSUa8313S8xdWxTMESNrWs/7LLgxz6hFk88UQJyCrT17fVM0xbLc
         AsYy/WbluU9ZBmlS7xP2n9QwsPua9TB1kEm+UUR4+4KSwbWZhknadebGkqgbztGVpqpY
         tn1b92JIO67eDpYQewdOmzZSZvO0AbAPuDMFH9PrGjyHz3vjhx4VT1bzAbLxvnTf4XTz
         xf6IH3HCjhQV4AQJ3QiXime1kECL35l/3HJCveqiaVxxkKOSrca+pOsjJby4TRCwj3Zk
         MVphyoUyG+3hCPUuhCmISrWBW0mSVRe/DfenpnTOk6xiLSUjsyhYccxPaKDQuF0waaeG
         XFsQ==
X-Gm-Message-State: AFqh2kqgF1Ss0Xv1txZbyZdKu4xaIpyXXWJ460bxYTD5PY1paiHifNzQ
        NIAHnu092IwbDG/EurVC+mL5zzaXVbI=
X-Google-Smtp-Source: AMrXdXs4KKV1QR6pguOyaBKmP+Ng+ykDDRAFBjQSH9WljBk35l1J/hzCND54M7ZCje4Q1Z5xZe3X+Q==
X-Received: by 2002:a05:6870:be04:b0:15f:9cbc:da9b with SMTP id ny4-20020a056870be0400b0015f9cbcda9bmr8245063oab.18.1674416716867;
        Sun, 22 Jan 2023 11:45:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 66-20020a9d0848000000b006865246ace0sm8028649oty.53.2023.01.22.11.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 11:45:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad99d227-ce82-319b-6323-b70ac009d0e7@roeck-us.net>
Date:   Sun, 22 Jan 2023 11:45:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230122191345.58989-1-didi.debian@cknow.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: Fix full name of the GPL
In-Reply-To: <20230122191345.58989-1-didi.debian@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 11:13, Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>   drivers/watchdog/ibmasr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
> index 4a22fe152086..eee1043acfff 100644
> --- a/drivers/watchdog/ibmasr.c
> +++ b/drivers/watchdog/ibmasr.c
> @@ -7,7 +7,7 @@
>    * Copyright (c) IBM Corporation, 1998-2004.
>    *
>    * This software may be used and distributed according to the terms
> - * of the GNU Public License, incorporated herein by reference.
> + * of the GNU General Public License, incorporated herein by reference.
>    */
>   
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

No. The only acceptable change would be to replace the text with the
SPDX license identifier. However, the code is not specific declaring
_which_ license is being used (2.0 only or 2.0+ or even 1.0+).
Given that, the only entity who can change the license text in this
file would be the license holder (which is presumably why it wasn't
touched when the SPDX conversion was made).

On top of that, include/linux/module.h and other files also refer to
"GNU Public License", so I don't really see the point of changing that.

If anyone is still using this driver, it would make more sense to
convert it to use the watchdog subsystem core.

Guenter

