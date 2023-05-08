Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F116FB379
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjEHPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjEHPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:10:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6584210;
        Mon,  8 May 2023 08:10:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6439df6c268so2477730b3a.0;
        Mon, 08 May 2023 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683558601; x=1686150601;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSylYoD+qttl7xRZ7brp3i6yMB7BIlgJJas/6/1hMcM=;
        b=IDcUd0djX0LZEYsra3ZmzvjJ6cDAOIE5/KMToPd1I5LlwCstPUXxYLO8aP+iVwqPck
         9+eQbKApBEiZXze/DzsbWH2dNu7itDNS/dXR7lAcjKND/2xsKFE0V6KnCPayR5OzVXUm
         kH9fXKr0lawHwM/rkfsAQfTI5s85AyI6bPfs0T3mT7xCzYqpmStE88QfWvbgeB3FLS/9
         bNusDWvsj9uA85TuTao+yNH9Th19Wu5ZWd31YmaJbwh9IRx/uoIjP38/ceIUeTwHw8ur
         wL90W+RYFqDZFuXQlJLpkrupEfbwc2Yue4+s7PA1a08OLHQQjowVNLl4nvk4TrV7tcIJ
         TSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683558601; x=1686150601;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSylYoD+qttl7xRZ7brp3i6yMB7BIlgJJas/6/1hMcM=;
        b=lEMVh1KhFmIwzTKf3jwFR0vdg+eYfJhpTl2V1ftcmg8CtMObaeDRVley/0OOAfIboA
         MM1UaH3mMPjl/6JC8LSe8pE5zStu9cZFnHOHE5+Kj36kf2JcN/csZqDu9XKCRfkIO4in
         qjwmgLs4gm7/QkRRybECcgAIDQHCHNFrL3WtAWEDys60dWB8XYY+AAZXDEvdaiIDXqZZ
         KkCxLD16zl/CQyDylrTye3VZPlwtzl/DBgKXvVNA1hMjGY5WXWAQ1uPYw7Inz8hTEYSV
         evx3UOtXz+yFMz520d9SVsbRp0rqRjXN6nq85tvndKDY9swXdoUW+Hwn4/JfvNYhdSAy
         E//g==
X-Gm-Message-State: AC+VfDwG4qqk/ekMf6nZDVyeulzcmAnHyP5qPoYM2H9m6SB9OCO92WlO
        zwFyiTypSqBlURfFADE8Hrg=
X-Google-Smtp-Source: ACHHUZ7SpQbNuEhuLR29p18l5dgrcV1c7qAmZjCT0hJ487WYIGDBGJagKSFZXDr1YME3Jj0Twrbm5A==
X-Received: by 2002:a05:6a00:2e98:b0:63d:2382:4948 with SMTP id fd24-20020a056a002e9800b0063d23824948mr12487711pfb.25.1683558601268;
        Mon, 08 May 2023 08:10:01 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0064399be15f0sm48621pff.183.2023.05.08.08.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:10:00 -0700 (PDT)
Message-ID: <ff9ee361-cb1e-26c3-c14d-f4bc1c1a9059@gmail.com>
Date:   Tue, 9 May 2023 00:09:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     bagasdotme@gmail.com, rdunlap@infradead.org
Cc:     devicetree@vger.kernel.org, grant.likely@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <ZFkDce5ISNEu6nsp@debian.me>
Subject: Re: [PATCH v2] docs: dt: Make references and mention kernel
 abstractions
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ZFkDce5ISNEu6nsp@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Date: Mon, 8 May 2023 21:13:05 +0700, Bagas Sanjaya wrote:
> On Sat, May 06, 2023 at 03:09:11PM -0700, Randy Dunlap wrote:
>> For @linux-doc: Is there something in ReST that does auto section numbering
>> so that this renumbering does not have to be repeated in the future?
>> 
> 
> There is sectnum:: directive which does the job. In the kernel docs,

Just for you info:

In Sphinx documentation at:
    https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#directives

has a warning which reads:

    Warning
    Do not use the directives sectnum, header and footer. 

Sphinx prefers the the :numbered: option of the toctree:: directive.
See https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree

This directive applies to the documentation as a whole, not to each .rst
file.

An example is at:
    https://www.kernel.org/doc/html/latest/process/development-process.html

Just my two cents.

        Thanks, Akira

> however, it is customarily used together with contents:: directive to
> generate toctree for current doc. In order for this to work as expected,
> you need also to rearrange section heading levels, like:
> 
> ---- >8 ----
> diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
> index 87f522d5feba81..890dde293540f9 100644
> --- a/Documentation/devicetree/usage-model.rst
> +++ b/Documentation/devicetree/usage-model.rst
> @@ -1,5 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. contents::
> +.. sectnum::
> +
>  ========================
>  Linux and the Devicetree
>  ========================

