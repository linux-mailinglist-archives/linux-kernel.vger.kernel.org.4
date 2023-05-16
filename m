Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6ED7048C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjEPJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjEPJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:12:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A155FDD;
        Tue, 16 May 2023 02:10:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f415a90215so113132745e9.0;
        Tue, 16 May 2023 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228244; x=1686820244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3WrC4UijnYG96Kov01kzkQuuInDDpJVntlVXwo/6hA=;
        b=Ostie82+eea/bStS2f/B7xC02Hn0Bq8os2kFsYXwx7eYnHni65/Wef6GcUWdkWcL2K
         uoURmp1GjKLISQ8j5Q+EigxL1KyZeq5m3bhOOMjQIuU5oF0nCOWuuCl+EgoSzNpQfyOD
         6KyaBn78Mw0hKWcGtJmuL8ID0KdoS8EbYfZjM5/aeOwVmfWr/oe9xpFlsa5zqu1ubvyG
         d0vIx1MwAuvejni2h1IPCwDmJ5q7AxLM7Ap4RhJRzSQrffxgebg4Ojik6HmNREk6U1fV
         4PrzbJaH/SYV2acQ3EMP93ToPtXmmWXCEd1OPt2LemzNErM+21/iWc2u8BwL0kn4vBGy
         4K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228244; x=1686820244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WrC4UijnYG96Kov01kzkQuuInDDpJVntlVXwo/6hA=;
        b=R+wEWRzLRfYErTfM4JkjE+h1BwxUYhnk9aNfmJ38be5XxVwkVx8a+XmOsViHpFC54t
         02wwUFXkLmKTVmqoR28agZ1tVynoPSpW+W4dS1E7K7BXD5W/QUh5g/8xH3jELZLMmTYC
         ljgScDWWloHvLKaiCeHyuGB+YVuN8zBp2L/ozLo4VA4iEzEEGORvZ8ZFPdCV74e/HwdC
         Prv/g5VkJf84muXKx63YlWCbO2VQqMSPQyICrfQleE1qgyd+0CtJNR8tIAM0IpKAoz4K
         XFPOPkKMSi0HpEIHjY9oOXeOP63WvEGNgAX2LvWZ/zDjJJUGYgIN19HvfmoLQ8osgc7p
         HBLg==
X-Gm-Message-State: AC+VfDymAYb05n7Vio5BRTZ5Ap8pwVIT0yM/ENcGX0WK3skwCp7N1ddv
        DCddh2tvGW5TVbklRVNKNajlyHhkeaQ=
X-Google-Smtp-Source: ACHHUZ7kjXJzpiS4OttX1ykp7R4nHgdaGWWYljgv/ZxeWcC6TV3lT1cWq7MSPB1cxzUxU6uEXeqySw==
X-Received: by 2002:adf:f946:0:b0:306:32fa:6750 with SMTP id q6-20020adff946000000b0030632fa6750mr23213600wrr.33.1684228243591;
        Tue, 16 May 2023 02:10:43 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5592000000b00307acec258esm1927828wrv.3.2023.05.16.02.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:10:43 -0700 (PDT)
Date:   Tue, 16 May 2023 10:10:41 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 4.19 000/191] 4.19.283-rc1 review
Message-ID: <ZGNIkVKpO2/uddsq@debian>
References: <20230515161707.203549282@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:23:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.283 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no  failure
arm: 115 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/3527


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
