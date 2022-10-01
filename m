Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725F45F1C46
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJAM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 08:59:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FDF3AA;
        Sat,  1 Oct 2022 05:59:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x29so1090125pfp.7;
        Sat, 01 Oct 2022 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ffay6QHcfOr0P9N0Cih4/08+TLFhGiExUiJv4lMY7xo=;
        b=pswYYyvOfQfCLRGo1CxUFW2BDZ1clbZ8LgZsrV48O6SJfG7Glp8yoch/EH6mthFqEb
         5bXNf8kvls1aCI5A7C9vF6UsqnoxJmmCc7m9Vj1Wo8lMVzRrtNd7s8/TYkZAnYhY51Fq
         6Zd0qgJ52CRCd3rQ/5m8GyBPKh3XDvPK4bCmI8Zxe+WHLX48au0yKLiEHSfSSLvinG4J
         xnph3dw3bK5x6reLq0TqGflG/iiGxktowWMVxKcjIQggvsLKiz0XO1xOJZIXAggYi3eu
         7pDUEF0QRgRWaOIf/3xtbbgk6UGfEsWG6nnGxp8gw1+DnoKtyAVe66RjCpyfqNn7sIYk
         KWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ffay6QHcfOr0P9N0Cih4/08+TLFhGiExUiJv4lMY7xo=;
        b=w4nSt9zvhoKIovifQpLMCjpTBZIx4zZnw9NMsYLfGgnKSeQ6F1JYv+aojtMz9AFJFw
         VIfYYWoJgOz0DCkRkWwPHgVLF94kvQswlq22KSiy/q+hlNntzVH7V0ivMzsSo6hBY9xr
         qQ09BrKVC3Ba8CjfiSFpfWuHTaY/QlVOvPirooFxDNd+vP7tCIY4KY+fR5S0rHod4XtZ
         7KO0nE8lnYPkbpu8GrY++NJALUl/tyrRYQceBwioQaIoZOH++r7aJ1uI7biQ4Mu4Gu03
         5HueH4IKxOSsFWXfMR82f4iNnaWg1UEW2MC7NgzwDvDbgI/tw77g+79L49mLAH5aO4z5
         5ahg==
X-Gm-Message-State: ACrzQf3b/G5PPN+nYbRZHr4d1y6fpeaaOIYb6oKzA2Lj5lG0Ed8/GryZ
        M9r9szckNkstHkX5led4EMA=
X-Google-Smtp-Source: AMsMyM4peM46phw8DbztZr2o0snwG1Jyq78PMMuOiEZT+gfDnHjnAaYWjBGLimya9RfG8Pl0OktW3A==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr13791536pfb.43.1664629174686;
        Sat, 01 Oct 2022 05:59:34 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78f39000000b0053e7d3b8d6dsm3700511pfr.1.2022.10.01.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 05:59:34 -0700 (PDT)
Message-ID: <594c4afe-17f7-8670-d5ba-ebdeca6a4b47@gmail.com>
Date:   Sat, 1 Oct 2022 19:59:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9 1/9] hwmon: smpro: Add Ampere's Altra smpro-hwmon
 driver
Content-Language: en-US
To:     Quan Nguyen <quan@os.amperecomputing.com>, macro@orcam.me.uk,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-2-quan@os.amperecomputing.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220929094321.770125-2-quan@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 16:43, Quan Nguyen wrote:
> This commit adds support for Ampere SMpro hwmon driver. This driver
> supports accessing various CPU sensors provided by the SMpro co-processor
> including temperature, power, voltages, and current.
> 

s/This commit adds/Add/

-- 
An old man doll... just what I always wanted! - Clara
