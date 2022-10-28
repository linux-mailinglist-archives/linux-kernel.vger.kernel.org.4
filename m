Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309D6119F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJ1SOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiJ1SOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:14:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6294D133;
        Fri, 28 Oct 2022 11:14:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f8so3968684qkg.3;
        Fri, 28 Oct 2022 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mm2xmltH5cssbfoG7DhNPzMHrojXBex0FsFFvjiLnbA=;
        b=Xh0pirw8ScVQtoFuI5mkHbYhfJdG7ft40xss/CBCZTY9wiS2Dig2U2910H0byfIZUd
         0Kk/lZRwJex/UFE00dvJ99kwvcEd4TQlXXQoRP5NZO4Ws+4B5e8zJXd/WgYFgSXOf9xx
         cGQ4sK19LeEjLg9/HBOBE663TkQx/TypJrlDJbw6kEzvnc0tNd/fZDzqcisL/bWD1Pa8
         16c9AAY1qloOMzLecG7Fgs3vMVFDevT5Sd2Oh8ycPtM4BRU8KCPcmdWekodHqhSEoRRK
         He4NDIIyCbDIZLQ7pz++5iHz4zk9Bbe0W4SJIz7khjQZsk7IoNt1KFX/zgpd8RZ/xM99
         O9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm2xmltH5cssbfoG7DhNPzMHrojXBex0FsFFvjiLnbA=;
        b=cYDi+JMTS8c8tqYpqh+KvWbcKXcC4gC9j2+QNCLmR8Z5GM19BmU56Z9ZHKrnPp+stx
         v+U+ol3C34hH1xaITUlZT6apRiqNvi6eW4HVNuqDUr8ToyVy8T6Eu73ESAtY3HgrHefB
         yfPdDNrwQ3wgeH5Ys0iB2I4R3e9XhaCmKfydO2H1c20C/Ktg6Y776Dnvz+BzM3A55BT7
         Z7c4TI3BdEcO2wxCXminVZfA9FNs2Yc2jnua9n1L+PAtOmMQ4Nfu/hHhoxHQhDswEaoQ
         15BlZ0l12iW7gaiTlHKtRKB5uYcx1DTJGrygiv9obqRj8ScMTCCqjyk8VSjfXD/izgQh
         /JhQ==
X-Gm-Message-State: ACrzQf3TeHmyntDpJOS+bJrhJrSJWbzVT0Iv5LIXz/tEEuyQiVqg/0LY
        iwalAF61twaP7vpXUrCc1WAmHGv+rTA=
X-Google-Smtp-Source: AMsMyM5PIYaZ3lwRrrkaNIKK5fx3FY37HHCsIo+hdulqZccPAIrDzgZN3BrmAexxzlNsEoFwwcXjHg==
X-Received: by 2002:a05:620a:404c:b0:6da:ecec:a072 with SMTP id i12-20020a05620a404c00b006daececa072mr446116qko.358.1666980873506;
        Fri, 28 Oct 2022 11:14:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y27-20020a37f61b000000b006cf19068261sm3271027qkj.116.2022.10.28.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:14:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Oct 2022 11:14:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH -next v2] hwmon: (smpro-hwmon) Improve switch statments
 in smpro_is_visible()
Message-ID: <20221028181430.GA2079477@roeck-us.net>
References: <20221027231611.3824800-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027231611.3824800-1-nathan@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 04:16:12PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   drivers/hwmon/smpro-hwmon.c:378:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>           default:
>           ^
>   drivers/hwmon/smpro-hwmon.c:378:2: note: insert 'break;' to avoid fall-through
>           default:
>           ^
>           break;
>   1 error generated.
> 
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return.
> 
> Add the missing break to silence the warning. Additionally, adjust the
> indentation of a break and add a default case to the inner switch
> statement.
> 
> Fixes: a87456864cbb ("hwmon: Add Ampere's Altra smpro-hwmon driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1751
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied.

Thanks,
Guenter

> ---
> 
> v2:
> 
>     * Add missing default case to inner switch statement (Guenter)
>     * Fix indentation of break in inner switch statement (Guenter)
>     * Reword commit message to include these changes
> 
> v1: https://lore.kernel.org/20221027195238.1789586-1-nathan@kernel.org/
> 
>  drivers/hwmon/smpro-hwmon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 0ffb687b6508c36a17b99bdaf014b38532404182
> 
> diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
> index ee54e21c2c12..a76c49dd8438 100644
> --- a/drivers/hwmon/smpro-hwmon.c
> +++ b/drivers/hwmon/smpro-hwmon.c
> @@ -373,8 +373,11 @@ static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
>  			ret = regmap_read(hwmon->regmap, temperature[channel].reg, &value);
>  			if (ret || value == 0xFFFF)
>  				return 0;
> -		break;
> +			break;
> +		default:
> +			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
