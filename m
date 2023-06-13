Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83A72EFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbjFMXLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjFMXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:10:59 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4510C2;
        Tue, 13 Jun 2023 16:10:58 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-55b8f1c930eso92714eaf.3;
        Tue, 13 Jun 2023 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697858; x=1689289858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGbbjXN/crvc59oMheelamvmeF6LUTy2pn88QOiGH8w=;
        b=LcT9ZFoqQsWDsjMQq00tcthHC3hGHT15aJmiOvTQfd81qF7dR2S9G+roEvMpyVASPc
         35ZlYyUbzSbT4Vw3P9Z3Mc7WJGzPRQtz1WZWOvoxm2ymAx6I8bN18K4hY//JcSsNFW5Z
         U2XWcBmbe6PmgV0+3w/EKla62syx84BC/vS4b+LrcmZ0JYwQZ7muRrVhHtcdtw8YlmRB
         Yz/mfyYP+XRFUO5scJOI5q+C2WbGdQQtDbVmQXzV9T4B0HHa6AsmwmQigPgRMwRwLAhx
         SxvrPToMda2TIqRbT5GOO+bw+/GXdGcTYoNZn/TEyj5gOLCZleUegfuAHFvn+8OouB0R
         ltiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697858; x=1689289858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGbbjXN/crvc59oMheelamvmeF6LUTy2pn88QOiGH8w=;
        b=D/q7N0iitNDHn8c2kZdvT+L8nqzEqw7HY0bxtS+SSEL7voDCT5CntGFKeRGwuMNUCc
         eluU8uEoN3Bqtzo4yCqqWhNKud7TeamlWzTNEs45H0rkaTAy3fdnZryV3RWliLf5+MJ+
         3ZBhEoJykk861BbedLwifGW4CL59a1+/tFUS+Mc+rrLdUPRu8bswn+2PmLNa47jZcS6X
         QV6CECw9FlMbhNWtUrI/W9SdgjauLzI3aVf4h28GU5UFrMhZTmb0MC6UHLtfeUdvkNMs
         AkR/btyAoWJ1dAhtHEJdvzmuVLFEaXzSVDPAs9luFKQ/xO4Ak2Z9SH8g8FvwZejfIYAX
         /KbQ==
X-Gm-Message-State: AC+VfDzPTWjiDFz/UOj26Bmck4fDtL8cPL8z/0nwDmFNi0CVFyvBxYRm
        4H22SgYB4G1eGDHBbZRQeLs=
X-Google-Smtp-Source: ACHHUZ6vmk5nAB5OTM4ohimtJnmJRT52OmC+SYe2CrEewD9jQnkbUwfqb8D1bb9uWZaW579bD7IiWg==
X-Received: by 2002:a05:6359:29a:b0:129:c3a3:5efd with SMTP id ek26-20020a056359029a00b00129c3a35efdmr6807107rwb.24.1686697857811;
        Tue, 13 Jun 2023 16:10:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9-20020a655a09000000b005287a0560c9sm9089916pgs.1.2023.06.13.16.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:10:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:10:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Message-ID: <51551bd1-425a-45be-b3f1-76cd96761910@roeck-us.net>
References: <20230612101715.129581706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
