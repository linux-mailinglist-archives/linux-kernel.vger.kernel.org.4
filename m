Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302056A15A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBXDsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBXDsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:48:00 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392410249
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:47:59 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so3290066pgt.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvnJfAXN7dbI96u1aUOT8Uz8u1lD2ldVL1eF7bXvzTA=;
        b=TZaziYMrTFJ/Emv9HOlF+iPYrj/mP7EZltBXnnJBhkLJXZlhenIFz0VeZuZxB6kNOo
         hsNE1TQy4Zvojni8+OMNjNgX8YE3a7YeU9BRzyWADX3MgGtD5x0feifjW8NFPRlLJipJ
         35ZyYOz6V9816hVGgZTm65Z0pComE9sGtvJ8YX9aL5aNFG3xZnWWTMa5umj/NcdNA29J
         UN0bnW5bRKeizDw8Mj54lALifB+gtHsIWqGwAeMppkVh/2NgrOd7i5amH2q6paQd4KIL
         Ik+nLrQ2Lyl7UvzoApnzEWXwYHjP1RV1608yPr3sydcuSK/g7tSOh7rPW3ouEksl3sUh
         O9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvnJfAXN7dbI96u1aUOT8Uz8u1lD2ldVL1eF7bXvzTA=;
        b=Rw+M59hCYHKIRi4f+mfsp0B55hqQzDGF/HtVMR46h9WhqE0jOHmy3bmPIeVqESCI59
         et16EoTQlzkTADd1921tU7DT6pZu38Fi6SaqdS1c/+nOPi2HjGK7xN2DPnSPppmRdDdS
         UvJCAAVeBCZ9R1/uGfezlKrkmWSeyyb4t+BD8WfmCQ7EyljZZpFMJrK8l2VKZf29lYzc
         M48iRjeNcj/AcJBszvYydDTbXJno8uvP+myuy8M0OelKrimSOBFps/yXpiC1UfkERhk8
         wE/Kml0/2zyoO2dhKO8jA15AicI/GmTbkk7K0zz6OVcHOWaJim/WHUAZ+IGgpYx0C/D/
         hPzg==
X-Gm-Message-State: AO0yUKUed2BLqV/l2rxOO+qfA2vHdxBBl0QL+YoIHJG9yTMd8TEPw5Ao
        uZMTQkufiNmKRXAZCDIvBCF5dbCmZCKqp2PKqOfg8Q==
X-Google-Smtp-Source: AK7set+4E3qR7YRqGWtswOJsb0v1VH/9DZqSi2xOqMlQBKbZalsC7ksSWhaJHGLddEjfxmY1fXyfL1g8iqLGEjnpbCE=
X-Received: by 2002:a63:3ec3:0:b0:4ce:ca8b:ddc with SMTP id
 l186-20020a633ec3000000b004ceca8b0ddcmr2447500pga.1.1677210478555; Thu, 23
 Feb 2023 19:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20230223141540.701637224@linuxfoundation.org>
In-Reply-To: <20230223141540.701637224@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Thu, 23 Feb 2023 22:47:47 -0500
Message-ID: <CA+pv=HN-M8Pp+qY7=nsi4tXOjtFuL5nhTyUQ3chtR+GZvDf3cg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/26] 5.10.170-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.170 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
> Anything received after that time might be too late.

5.10.170-rc2 compiled and booted on my x86_64 test system. No errors
or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-- Slade
