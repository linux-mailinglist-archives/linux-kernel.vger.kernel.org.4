Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA036DC980
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjDJQre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDJQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:47:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95381FCD;
        Mon, 10 Apr 2023 09:47:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso4977904pjp.5;
        Mon, 10 Apr 2023 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681145247; x=1683737247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX6G983IOsO4LeBFZ2W8dXRHd1jWabfUcIh+Ab+jJN0=;
        b=GgkmGFBXbEQ3apfV2tzZswmfhrnGz1zPslCIzyMysTsu0Q0aoNQKX2qDv2y7u15311
         wUS7AYzPOdNOVvlPE4VqvIL1FSZUgwtX9oRx8I1bZ9/REQ5VPJ5znkHnmQDgWGsEuDFB
         O2fp2p8m9jfh5iHpyFJXDhXLkwsmygxCHX0d643sE2kx27hWjDBV8cLeksVqznTLfnSd
         QLz5pMB+gqSP8pAeoRWPS3WOccm7Vrw3il22PPjmn1jLgkI7UTkDHFgzaTF6kbNDluSw
         g+VmKFQ2t5qkaJdx7y0vBEtDyK6Hw6TtIs/23CtKHa1XPGEIZAX5JxzUhT+oci0YbFfv
         AWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145247; x=1683737247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX6G983IOsO4LeBFZ2W8dXRHd1jWabfUcIh+Ab+jJN0=;
        b=G4uZFuiyssiFOauUGiZKvNwOB4kjualLbTD5Bp5BsxEnBK1XYivK8OOVCAaeL5LdT+
         Knx6Htnb8qNq8L51tWQfmRik824megZcnSBOZGxJWGZE9pIS+1ZtQBSECkuHDvDEh5PF
         PCTevNBMGtXNM2UQSrd/0ph6D80BaA4/ABokAOfXcWiIh3o7f+84HDlVNkzaNiXkQNLj
         EVHX7V7JNdr8pnSGzbV4A5aLxTvNenckr8/bQdNjrCFRCWyIZ1IKLbHG1LqoKIsMkze9
         2ev9QgAIhEpigibZjhQBHQzGDeip277y7Tt6kqsjJdgjlSLVromfmeWxT00SJGHQzKZY
         rpFg==
X-Gm-Message-State: AAQBX9f+9Upqc4C19YFQGeq0Ri1G22uH7WhV2Y9U1OGnlArp7UnNi7x+
        s/0WcVO4hFuc0ipftPrk2dU=
X-Google-Smtp-Source: AKy350Z1qVhIudcRbsfTnkwB1F1gA7KQ7uRQcFIvA0GCr1SAxOpiiUqDA3r9onYfLVCXESoEqcL+/A==
X-Received: by 2002:a17:902:c64b:b0:1a5:27da:538c with SMTP id s11-20020a170902c64b00b001a527da538cmr8290529pls.26.1681145247062;
        Mon, 10 Apr 2023 09:47:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jn18-20020a170903051200b001a221d1417csm7988828plb.298.2023.04.10.09.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:47:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <51d125a0-3dc3-48b7-c4af-c37e826e2736@roeck-us.net>
Date:   Mon, 10 Apr 2023 09:47:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Mark status as orphaned
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>
References: <20230410150926.3354-1-william.gray@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230410150926.3354-1-william.gray@linaro.org>
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

On 4/10/23 08:09, William Breathitt Gray wrote:
> The current maintainer no longer has access to the device for testing,
> the original user of this driver indicates that they have moved on to
> another device, and the manufacturer WINSYSTEMS does not appear
> interested in taking over support for this code.
> 
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
>   - Remove "M:" line
> 
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..a1f44c4d40a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22512,9 +22512,8 @@ S:	Maintained
>   F:	drivers/media/rc/winbond-cir.c
>   
>   WINSYSTEMS EBC-C384 WATCHDOG DRIVER
> -M:	William Breathitt Gray <william.gray@linaro.org>
>   L:	linux-watchdog@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>   F:	drivers/watchdog/ebc-c384_wdt.c
>   
>   WINSYSTEMS WS16C48 GPIO DRIVER
> 
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

