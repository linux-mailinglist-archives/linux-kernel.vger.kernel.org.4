Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47162698934
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBPAXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBPAXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:23:53 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268A3B659;
        Wed, 15 Feb 2023 16:23:42 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v17so578066qto.3;
        Wed, 15 Feb 2023 16:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiyfxnZYKa0ejr4Vi15wMWJbfw4gJ50Ts+oiXnH5Ts8=;
        b=MZYsVkLpqEu4J/ZAhHgFeo3l/5dngnOlkJxzysI1JlCvv6sKZt7Nkh/DiJpzRodaCh
         n0WqTlCNxbQZjtAE20wwKz3poYEGubhRVsreSxvQEC15ufwN0aUnu8baX8PlFMV2geSh
         0EIGnJp3f/QzEWb7IuEkf/VVFR4tDuHfd1JWW+rY1en8AjbUL3OlpFh9cqOw0gnSlyQv
         aOiyNj3v2I2F/r1UiPuULG38593xK5W5oXbQQIGiLHEdGgyFS7un3+p5pg3mkgljG2zM
         wYWesyRIVG1ggec/u3tp+wIKIX8oGd4Wdqmpvp00lK3RPNwlxaUJSN9DU+sfQ3Wypy49
         WQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiyfxnZYKa0ejr4Vi15wMWJbfw4gJ50Ts+oiXnH5Ts8=;
        b=j4efDXyj2NYIWIBnvJWaJniiGrj9ct79rRXH/r5iJ+hgmO5nnLWh9m9hDwiunMCWzu
         T2Ar77yWXCrFpe9E8jqCL0JwHRL+v5f3YF3KBUWA2ktE/sEkkOBes+bvYda2hEpRZKOd
         +D/1GMPSWTO+Bw38AdwvPn6FTR4MMbWmjZARtpBxjrGGm5JvquG9u+a8pdE8vHA4Zwgk
         O04eptA6UyN+8+RvE7AXmb0nS5Qge6J/Fow1rjjA90gGQmcrxKLgW5EGoUGnVFC9mTMR
         jG+fX7FMtGeiaRFBbEbUWbS7aGZxFwJeuQf7HlapxucFB7732v3HekWugr56FpB2EoQF
         fAPw==
X-Gm-Message-State: AO0yUKUqdxfj0veQHp9UXTmaZMkUEv8tuWu/IPeHucPIQaxNi9Jkxp3U
        7Zde/IxJXqNCegJKaw4xj0I=
X-Google-Smtp-Source: AK7set9aA9YAe2RxaEDoDvH6GuIeEUwDt1kDnJlVo80r7irVOZ/HSf/EZeYC81fG71CKyUKUA/e24w==
X-Received: by 2002:ac8:5955:0:b0:3b8:2ce4:3e9 with SMTP id 21-20020ac85955000000b003b82ce403e9mr6319623qtz.32.1676507021262;
        Wed, 15 Feb 2023 16:23:41 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:f01c:d6c6:bce4:8b35? ([2600:1700:2442:6db0:f01c:d6c6:bce4:8b35])
        by smtp.gmail.com with ESMTPSA id x12-20020ac8700c000000b003b691385327sm244476qtm.6.2023.02.15.16.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 16:23:40 -0800 (PST)
Message-ID: <6ce9aa75-28d1-9702-c621-845cd7196789@gmail.com>
Date:   Wed, 15 Feb 2023 18:23:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] of: Add of_property_present() helper
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230215215547.691573-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230215215547.691573-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 15:55, Rob Herring wrote:
> Add an of_property_present() function similar to
> fwnode_property_present(). of_property_read_bool() could be used
> directly, but it is cleaner to not use it on non-boolean properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I plan to add this for v6.3 and send most of the conversion patches in
> the next cycle.
> ---
>  include/linux/of.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 8b9f94386dc3..b3e04021186f 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1537,6 +1537,11 @@ static inline bool of_device_is_system_power_controller(const struct device_node
>  	return of_property_read_bool(np, "system-power-controller");
>  }
>  
> +static inline bool of_property_present(const struct device_node *np, const char *propname)
> +{
> +	return of_property_read_bool(np, propname);
> +}
> +
>  /*
>   * Overlay support
>   */

of_property_present() needs a docbook header.

Otherwise, for patches 1 and 2:

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>

Test was boot of 32 bit arm devboard with full devicetree unittest
