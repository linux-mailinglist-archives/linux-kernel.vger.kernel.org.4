Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC5B73785A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFUAjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFUAjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:39:22 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7948A1986;
        Tue, 20 Jun 2023 17:39:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b57d9043e4so2227588a34.2;
        Tue, 20 Jun 2023 17:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687307952; x=1689899952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfFk33JPiu5SUkSbaXOEsTyCLjYQF4FOsYyjMoeQTcM=;
        b=NgpXZFxlsiWlQ1BD1WSCYVxBiO7p2B+3PlF60QExYxY7/EomTiYaiGct3OrkWlRgRy
         zZpehOMJjLiTqhbvmVz2Yw4I55Q5CBkkZSpYH27JWHSOBbrY418zNM3IqskiKnTz8FMg
         YMHlsuALlleadrdVmUYQrMj//fwyQWc/jeuMUiXh9wUK8XBr14jVnxOTOW/WeOYyKh1l
         U27cdAbl/4PeeK5iXFTn5JZ5e2HGwbLRWUilKltsvGQxqDmrZpiedq3XgTO56+eJCAHP
         CTGMrvCgundBy6AQHHN/OfJlXceK/kc7dr4stEweOKizYBGRIQyqwf072exokhFTJjdp
         5wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307952; x=1689899952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfFk33JPiu5SUkSbaXOEsTyCLjYQF4FOsYyjMoeQTcM=;
        b=XvfvZteGJVyThOcSHWAlRAQxQV5DJ484ixm4YEJ5rqIV43PmAbhKPlM5MzeWO5SNL4
         mTJrqqWO3oxHmZpS4s1bRa4SLnIx8dfa6eSjiBHIqy2Gd2LqNTV3uzGvZEbuKpODN2AB
         RAKpgHkysklxXJIPVf2fDJb/jyJDQBwD9J/oXYw44wRrr1M7LTo2Ep8H4IBxUHN1819V
         sTnDesxVsvB15qhWom+yWK8MF8yaXkWEWbit/VA0cPatsmMu0/8XE+n9UAelzAsYqnp2
         pNDpUIbitvSxayIKrs/PfNveviXN70abqWCXBS2X/NJPt8Yh7vRv7vWVTvnMo6EZ39Lt
         zyYQ==
X-Gm-Message-State: AC+VfDwgIQFCKv7dLWlSFZ1aOBqsHJMe+pPJkHZHouBKHVvHQj9eEYOf
        X5+NXxbGVZyVmVM3QqS0lmo=
X-Google-Smtp-Source: ACHHUZ7v+UFkOUJX3kItkD9CDJcXcN2MvfTbWPS9AL78RMeXyU5m/wHdQibEmVQWqHG4HVHd7W79/g==
X-Received: by 2002:a9d:6acc:0:b0:6b3:477c:c725 with SMTP id m12-20020a9d6acc000000b006b3477cc725mr10693386otq.12.1687307951713;
        Tue, 20 Jun 2023 17:39:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b001ac937171e4sm2112422pll.254.2023.06.20.17.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:39:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 17:39:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
Message-ID: <00866956-184f-44ce-a690-674d8482605e@roeck-us.net>
References: <20230619102141.541044823@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
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

On Mon, Jun 19, 2023 at 12:29:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
