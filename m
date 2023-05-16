Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082A37048FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjEPJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjEPJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:19:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B12D4A;
        Tue, 16 May 2023 02:19:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f475366522so45196635e9.1;
        Tue, 16 May 2023 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684228752; x=1686820752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3MkdtHJ2Wn6h9YsBmYWmD4vsSF6yvzo+NF5U8NDuFA=;
        b=hFh/MCjLptpQwDMiF7H3IKYj9HR6c/PLjm63ECA5NSQN6FEIN8BL4ZOUSNRDwZekBA
         bs7Uyrpc1YT8AD74aMHC5fWvW3rdPBaK5gifHRuktsAcpSvmZnxKIREl/6y22XbB3eRe
         S0mz20yLu/ayAMLVszs6jFC5mCPnVp8bhmVkCZhVx7XTVNqScWDWSoPflEXChscKwRZr
         7YTqOYSJ+cUKWnN0ew8SpyHoejAgkEVeVQ7wBNux8XCNwcl/LoPY5wK/KBNvFW0WsO1m
         s6XUtWQMESkI8UBQT6oRX0ax7D/SfsJYmoi4kfI0YGnUCpdp2Fk6TmqPbjvjvBdRvBZp
         80kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228752; x=1686820752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3MkdtHJ2Wn6h9YsBmYWmD4vsSF6yvzo+NF5U8NDuFA=;
        b=GR93MN1Dz6aQatInNAnmPtQbx8U2UziX8LybElYUjiF4XbesEJL532r4Ff8HGjlexV
         oseoSHKJaJJDyWghaGH/ldpXeNaAanX3YPjMva/R4B+9BZL73AHHCibXgRhWYrLdY0vk
         kUMBy1LElenOXRkyu2CYi/Zg/kIcLrKLY6CIC4uWJWXLTLaKvmDILoyD0Z1L+7xR72aD
         ITC09xy7D+aFE05JJ6+lp5vWC7YpQ5aWrMCaAJCJUpeR6S1iqlVEF+ZGbS+daCPTdGi3
         6fsZ3SObXVQS9YhtUlQwGRVtPUEH01IgYfXEAX55SBbhdeLwbHqSDCWvhUbMxbKQEfix
         L5Hw==
X-Gm-Message-State: AC+VfDx2FYI+EbYxFoc8vViaRIJMRLuR+t+Qo9w4BoLo97c0N/wTSgK3
        OyHN2r8YxPzPD4dy4Jk7F2o=
X-Google-Smtp-Source: ACHHUZ505uRu6aCnAjzxPjg3zmhCDP2VDUbzyaYyhVG1tTnQMVN5NkjnjklVdIM7B2nUochZAOCRMA==
X-Received: by 2002:a05:600c:2149:b0:3f5:1240:ace4 with SMTP id v9-20020a05600c214900b003f51240ace4mr1589722wml.25.1684228752006;
        Tue, 16 May 2023 02:19:12 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003f50e88ffb5sm1664081wml.24.2023.05.16.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:19:11 -0700 (PDT)
Date:   Tue, 16 May 2023 10:19:10 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
Message-ID: <ZGNKjkwrGvqGRv1U@debian>
References: <20230515161721.802179972@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:25:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
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

[1]. https://openqa.qa.codethink.co.uk/tests/3537
[2]. https://openqa.qa.codethink.co.uk/tests/3538

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
