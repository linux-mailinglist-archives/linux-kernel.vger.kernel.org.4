Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE26DC850
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDJPSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDJPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:18:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAB126B9;
        Mon, 10 Apr 2023 08:18:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h24so5055795plr.1;
        Mon, 10 Apr 2023 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681139911; x=1683731911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mZNcPr+y8/9NjCaWwABJXLJwupkaQ1Z2WNyPOrf8WwE=;
        b=jgaQXxIHyIWuIAEj9p4DjxTrEnsP0IoU5gMNUYk7ZDSEFhjZlVBWz18Yb4Aj4JSsRC
         4tHoJEWhqC7fbgUGNhXWEr1tfF6ru6kN77WmMzl+/3h+2ONsFoLDLq8gK5a+e0Zu+nLP
         kB4MKBzR7bixSSHSUqD8D0139p6F9ueVpwqSFx+FYcRB56YGIJorVznmRE5kojSRKecZ
         GDzyUbOEKl+Q9gQwpV3yJ/OFq48V6HCbKRJV639xV2G9jyLPwbj92nKuIkVs0IHdBuOJ
         qqUGB2/EfqA3amxl4DoeroVN8mTeRrvsxnMg0+rHOsHJEIAWXv3mjxkNWNFTIxDu37Ov
         I+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681139911; x=1683731911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZNcPr+y8/9NjCaWwABJXLJwupkaQ1Z2WNyPOrf8WwE=;
        b=NJu0oraSgU89bwHOXSDhRJRclzZ1QbbnbSJ6nG1Hl+d6rsiYn71OV6P8NaoeKOIo0K
         DZt6CXjsyUWcjxFywARgVfwvy/nxrfqK3d/fdxs73hgMV96wXnZBJ6f8ugvVWpvrwvBJ
         mRtw1q+dgPgzERn3zg4BbZ59WqYC9IOTbSjpZLY4glIsFmC1pfpWxOnS8aSfSOo7+bTs
         V7zrnoDarMBAcQzJbG42DvzqLYas8dkn4hNorbFdcsL8+pUzUeqDBevAOt5LDVoC+pmu
         TKavV4od8OYVN/cDPeZyQ40sIolMKoTZAWx5gBzN/5wzX5NhKBp3G+GOs32fy9Gvmg2r
         QS8Q==
X-Gm-Message-State: AAQBX9e2Po+n78hDAxynfA/r/lympA836j9NHtGCgB/yxWY93uY5loJg
        D2xP5XH9tSAW6Jj7Auo3DTOlW8YA1/4=
X-Google-Smtp-Source: AKy350bJpZHoiKVjNW7hcYRnpF2BcmPV5YYQszQbXeTdqc9G5ortDpbma31ImOOU93t7c/+ZxREU5g==
X-Received: by 2002:a17:902:f90b:b0:1a5:329d:b975 with SMTP id kw11-20020a170902f90b00b001a5329db975mr5414040plb.66.1681139911590;
        Mon, 10 Apr 2023 08:18:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a63f306000000b0050f7f783ff0sm7104508pgh.76.2023.04.10.08.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:18:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4cbe67b2-51a9-e5cf-640f-9db77f8ada55@roeck-us.net>
Date:   Mon, 10 Apr 2023 08:18:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Mark status as orphaned
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>
References: <20230410150536.3168-1-william.gray@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230410150536.3168-1-william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 08:05, William Breathitt Gray wrote:
> The current maintainer no longer has access to the device for testing,
> the original user of this driver indicates that they have moved on to
> another device, and the manufacturer WINSYSTEMS does not appear
> interested in taking over support for this code.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org> > ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..8ef060ef48d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22514,7 +22514,7 @@ F:	drivers/media/rc/winbond-cir.c
>   WINSYSTEMS EBC-C384 WATCHDOG DRIVER
>   M:	William Breathitt Gray <william.gray@linaro.org>

You should also remove the M: line because, after all, there
won't be a maintainer anymore.

Thanks,
Guenter

>   L:	linux-watchdog@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>   F:	drivers/watchdog/ebc-c384_wdt.c
>   
>   WINSYSTEMS WS16C48 GPIO DRIVER
> 
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

