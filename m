Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5926FD9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjEJIqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjEJIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:46:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B81708;
        Wed, 10 May 2023 01:46:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so29740375e9.2;
        Wed, 10 May 2023 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683708362; x=1686300362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCPafpW7uQ83hGVCzhke2jlh3dmPbvqOP9zS3Cs8m0Y=;
        b=gAZr78E6iYV47qcwBsipvHYBbNpJzVDC20crMOT6gMJjOCSA6ITLt4cUdaT1Qhl1H6
         eZN6nwL1qWznrdUPaaq9car0Q/mzfu13SApBl+lbUysO9E6VoMLWNPMH8V/iM4AlhNZh
         W6/2XQrpxw18mDmNN65O6QIdlDV9g7W03qTnD0s8cvZqLESkmfLQzLxq7kQxolEB5/4s
         LXiJQxD7BjqGNAagAQ5c6QE5BkMAKeNsxilFE3iW1ptyZYHIJvbyAjWC+tm/Y3a9a/8U
         l9NDg92df3qXgWluZr+GHu2jQ7fSX6mThIYKYVY0+Wf/nslEd04yr7fyzaObAZpZdITW
         KXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683708362; x=1686300362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCPafpW7uQ83hGVCzhke2jlh3dmPbvqOP9zS3Cs8m0Y=;
        b=OiszTJzN5W2YSAxrM4abuupEujw+J8F5kOkj35fd2HjOHTOcSv3TiXGv/WXyTOmwU8
         gXONp9+4AA+5TiBZwD63jOjb8GlFFrFMPA+F6Tn3nUmVdBDV58AEyV+Wp9hEhFNjX+c4
         alyQno7QwTYofI7BdyVeFYaW6ofqemqiopGfjqPC9QGaSsSdHVs09pdkChRYddyAwdT9
         0k3T9tK+k9+KBw6lZHaPO2zNla5527ScTTc8uOwWusE2eSXEeQmzdvw9eat8LmxM9KUs
         COVY3UxPwiPjA71mmsck7a3X8Jig9oLhVfycUyuIuv4A3xrX8hFhiXDTCSSUroYAKFOJ
         50+Q==
X-Gm-Message-State: AC+VfDwhCBF3R+7nKBpsUl8hp/3HzIbsHlGvKW0Wwfcm9/jtZ3NqF9Im
        IU6TECEAj/GC4LPYuFhOZ6+W/LzQHOw=
X-Google-Smtp-Source: ACHHUZ5OLxdFx18LuUykzc6Z+H0VtF0Lbx148HhoR4ru4qxPQKBLWmqtYQCQUBQbQcAwTqd5+ZbyJA==
X-Received: by 2002:a1c:f202:0:b0:3f1:75b0:dc47 with SMTP id s2-20020a1cf202000000b003f175b0dc47mr11589425wmc.15.1683708361869;
        Wed, 10 May 2023 01:46:01 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b003f1978bbcd6sm6389336wms.3.2023.05.10.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:46:01 -0700 (PDT)
Date:   Wed, 10 May 2023 09:45:59 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/662] 6.2.15-rc2 review
Message-ID: <ZFtZx1iSv7vdEY64@debian>
References: <20230509030701.507375024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030701.507375024@linuxfoundation.org>
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

On Tue, May 09, 2023 at 05:27:04AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 662 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.2.1 20230501):
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

[1]. https://openqa.qa.codethink.co.uk/tests/3492
[2]. https://openqa.qa.codethink.co.uk/tests/3493

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip

