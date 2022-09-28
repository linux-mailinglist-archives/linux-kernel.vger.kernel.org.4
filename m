Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17B5ED572
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiI1GzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiI1Gyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:54:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DF5464F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:53:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so18930368lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Qu/VhJX92VKSX7l7z4v5PEDwp2MN2vUwxA8YDbW68bI=;
        b=huE5HIYJVftNh0Ht149pZrcZeVpIRE7lwIVErV+J8poZ0DN6ypAtmdgke01Au2FIsM
         V3lQMuxJwd6/tjGrUhFMPNu0xVPkjIWDDkzrX/NyjvCkVZ5f6nuGbBlILnLk5pMzRHlb
         RDlmtN/FyP79gtSnkhf5uMbkaFXcOo0AhhbK7/YXVhdg6rcQy1sOvH3FFRdw4oUEdzTc
         8KjDuJBjO9uCKLXvxbWnDrJF2Tm3Me6ZHXfc0FRo0SQ2GF3++ApWiTX1xcwcJWaBYwwi
         Yz4DXEDYhxDsUkaegv4rY8awqArRT9xXXgIlTC7oNk6TF2vXVCBDOWl9wShz3houGgzQ
         ddBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Qu/VhJX92VKSX7l7z4v5PEDwp2MN2vUwxA8YDbW68bI=;
        b=VnBu0lDqu9PpeA+duP1yz4sZfA7eoh+NfKAOEjyezokW6xywSS2mHSlPep5k2GYcon
         yG597w9EdkIvBEyCkhRHii82GNzDRB3J7rvEPkq7gnhFbEf4r+Pp6vZXXk+bCU6MIawB
         457yKkzQpZRn7OgUdI3wJ4nk64BkCgxeNW9aqHhI2IEU5jaESjcytXCiCCAffYN9HinB
         BRxLafoyS+sau1IFNkeEMMDm4kdZ5KqxQrTgsF7h8Jw0U+iQmcSczhWtSJMYEyA9WGy2
         lsC6s5ucKf3/lknzqE82n1uqH7zD84njOp13X+LDuY/Hn3d05cM+Fi3l6vfp+7ANc1Tf
         WTyw==
X-Gm-Message-State: ACrzQf3g8lp/gMZ+BQvB5R2iDwc83zUrOGVZ9fr5G7kH5pIJpViB8FPa
        qg1NaIuOlRp4eBrQKxM15lw6kQ==
X-Google-Smtp-Source: AMsMyM5EQEAIm3/ZUzrpf8ztO/R91GxLCmyhIVlFSiK9YN6SkEdDDvuYoxqffnMejtH1y+ttQwmvXw==
X-Received: by 2002:a05:6512:c0f:b0:49b:1e8c:59fd with SMTP id z15-20020a0565120c0f00b0049b1e8c59fdmr11920138lfu.426.1664347987465;
        Tue, 27 Sep 2022 23:53:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020a2e84cc000000b0026c41574790sm358109ljh.30.2022.09.27.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:53:07 -0700 (PDT)
Message-ID: <f74a9883-3a9b-8606-b20d-f046835fb827@linaro.org>
Date:   Wed, 28 Sep 2022 08:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, corbet@lwn.net,
        linux@leemhuis.info, konstantin@linuxfoundation.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220928003006.230103-1-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928003006.230103-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 02:30, Bryan O'Donoghue wrote:
> Recently when submitting a yaml change I found that I had omitted the
> maintainer whose tree the change needed to go through.

Thank you for your patch. There is something to discuss/improve.

> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be49d8f2601b4..5f97379da41da 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -227,9 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>  to code that they maintain; look through the MAINTAINERS file and the
>  source code revision history to see who those maintainers are.  The
>  script scripts/get_maintainer.pl can be very useful at this step (pass paths to
> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
> -maintainer for the subsystem you are working on, Andrew Morton
> -(akpm@linux-foundation.org) serves as a maintainer of last resort.
> +your patches as arguments to scripts/get_maintainer.pl).  You should mail
> +everyone who appears as "maintainer" or "supporter" in the
> +scripts/get_maintainer.pl output.  If you cannot find a maintainer for the
> +subsystem you are working on, Andrew Morton (akpm@linux-foundation.org) serves
> +as a maintainer of last resort.

That's still a bit misleading, because you should also send the patch to
reviewers and mailing lists. :)

Best regards,
Krzysztof

