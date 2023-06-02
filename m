Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB3720BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjFBWd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjFBWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:33:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977AB1BB;
        Fri,  2 Jun 2023 15:33:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3982f09df74so2134081b6e.0;
        Fri, 02 Jun 2023 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685745233; x=1688337233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJtFZPHY3MGVr+9DX8nPaWiMw0hM/7qSMyJJSj5f3GU=;
        b=JTYpHL2Zd+/ADHGN6l0wYbuYTELLHOM5zRgoIoP6S5hBK52uu+drS10+JhMZvbSFMt
         ZVfIvX1TvY2LdjjriYTetweAikwNAVE4MujYV2noWbFsn3SFuzF4j99UivdzGKTsKA86
         YOaPNz62x779P2cK7yAzNx405RRKanbOskY/DuIAGxtyL3PYfESQmAX2C8C656dtLOCQ
         Dh3PnkcbKXRuqXnX0Wfk5dLrCQnjjg1AAzZ5P87yp2U4nTvFUSI2b2cwE9a/B1nqoHI8
         icZBMnB6uyu1U4+wb6lZZxZh9g+9CA57BMWZzcSB8XQ0FnTwTaGjoNGzyzEDRC9MZStN
         mQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685745233; x=1688337233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJtFZPHY3MGVr+9DX8nPaWiMw0hM/7qSMyJJSj5f3GU=;
        b=IQ6PJ9zlhlCr4m+DeF6k/hcLd0rujb7irAWHmsOuQ6DRaGExjxUW5qpUHdPj570YmW
         vtrAFspZFtWhyZ5ge/2wHF0EGNPoQaZjrL6rGf1kLA6b4ybXpVy6p2zMVfdUZvOfNxrU
         paSmt+4wv0GEFsxRIuInMAkNNaWzEOxtrD0FQt8XpBI7sfUT/N5kwgzo4/Tj3YnBJgv6
         lBcY6hOvZzMQdqCSCHq6z20m2/vKRkT1E9nhT3fx0i7gm/GCUtfWrZ1zh48WWItmN537
         0cm3x43pUay+4yMalXGsKnNLFCUKGsXcpLXexi1DKlK5IDPUPBzZnkcxmud89pccPnJF
         ncbA==
X-Gm-Message-State: AC+VfDwopG5fYE+BpbM7B7Ffpo5X7yX8NYjf+TgyUhO4kLOa2Ny9upJi
        CrQ4710T+g7nil3rrE8fTt0=
X-Google-Smtp-Source: ACHHUZ56/4rheRxPYByafkdjKLl9/nvdKD6Fq5YsLQn65EIyVQxinecVmTCs3U36mxmLw0QvNUAW1Q==
X-Received: by 2002:aca:f18:0:b0:398:2a8a:1e02 with SMTP id 24-20020aca0f18000000b003982a8a1e02mr1320924oip.45.1685745232865;
        Fri, 02 Jun 2023 15:33:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902c19100b001b0358848b0sm1839375pld.161.2023.06.02.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:33:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 15:33:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/16] 5.4.245-rc1 review
Message-ID: <c6bee3f3-412a-4ab0-bb9a-983e029fdc5f@roeck-us.net>
References: <20230601131931.947241286@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
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

On Thu, Jun 01, 2023 at 02:20:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
