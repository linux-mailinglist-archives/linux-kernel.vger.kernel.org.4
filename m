Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D3736B64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjFTLtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjFTLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:49:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3352186;
        Tue, 20 Jun 2023 04:49:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-312826ffedbso350503f8f.0;
        Tue, 20 Jun 2023 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687261742; x=1689853742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KcYpNVQaGyRkwsi0hWgjQRd/rnueYbvh3KZf7v3ooec=;
        b=PSs+fr8/kRZ9Rp/e1xBLEc9BrCw/XN3RVLm9JTgXJoK1c2LeNv/Ee+HciskEgp5C8G
         /0a57Z5WfpEUM98+fIrDLzgnvzFGx1kIej+0xmdEroWMZdbEq0skYJXWrxnHs8vRmaQC
         AOkzfZo489qflGRqkG/anzvKXQsnRXv+ePHOLvm8cKwG8wmG07PHTFZi9tCmi9Z78h5L
         lv0qA/kgCQvOsNKbj+oVP4hXaWYgF31hKGozdBus0FPO9TqGS01U0l8+NlqJ+BKkIxRB
         yt6kK9S5/fvUwtGWYmDprdWCJJN28qiWd9GcuBdzeuL3CxFdT8TpBC5cULW95eeIdX+e
         +PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261742; x=1689853742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcYpNVQaGyRkwsi0hWgjQRd/rnueYbvh3KZf7v3ooec=;
        b=IRSe6EMmE1ffWJTh6vfJC0DWub+dwYzd13SzTsnj7vf9o8QjwlVRkcM/HPr2L4D9qd
         eYhT4/VYoVwNQQZ01w+KxqzcWQzMxWFUM6jF2klmr2FFcZT1n8wVRfPSxt2MGkopQn0+
         61/hqrN20YH64XJSn8ZOjRYJgmEb5OA25BuPnpxQQAvbPuA1hZr2pqjOE+tgdyG+NGfj
         FbchVfa793QLdBdJP4p2cN2jORqYVnfEqR1decNSNcG6O++XccBUkEqlez6XXVFAFYiD
         WH8jmJ6+ohPHQ8yjtHCFXAmVuCiTXPTr+NwX9l6Ou8sL+LrxlWKUlxKmXw3QL21KYpI+
         JS7Q==
X-Gm-Message-State: AC+VfDxZD2390PIVSfoCj5NOBH/aD4XwizupgiLp0YH9+OxsdTdj7Nv1
        JFLSVJggBFK9gaJyq+lf5Bk=
X-Google-Smtp-Source: ACHHUZ7sjaqbnzfBCWe+7Igx4XocK4yNn7Slik/papkIcItK+cnTPMWY+pyjVfzRTeoFBIHvFSVW/w==
X-Received: by 2002:a5d:510a:0:b0:306:2a1a:d265 with SMTP id s10-20020a5d510a000000b003062a1ad265mr5953213wrt.58.1687261742074;
        Tue, 20 Jun 2023 04:49:02 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id s10-20020a5d69ca000000b003047ea78b42sm1820542wrw.43.2023.06.20.04.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:49:01 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:49:00 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
Message-ID: <ZJGSLMfERKxfjNmD@debian>
References: <20230619102154.568541872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jun 19, 2023 at 12:27:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/4075
[2]. https://openqa.qa.codethink.co.uk/tests/4076
[3]. https://openqa.qa.codethink.co.uk/tests/4077

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
