Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F125B5FE3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJMVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJMVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:07:57 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21684183DBE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:07:54 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1321a1e94b3so3795235fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVEUKlqWo2ttd10gQh3gawam9X0cvCfnEg2BZkSEor0=;
        b=HJeySj+BDWcYJMKmqAj4xZ2JSfBiTiBaTnEUBFY83WIfVa+3LzILeNtjf8pXD9kyJW
         RvoW3x3MlFnSKRB6GfX2xAKb4mEQKOZFvsVq2Dr6ZzPnSSMdDSIix9tVpECs37Wr/UEW
         wyWklMlNOJCzxr4ZdW2EC+DkqBcPiic1kh/JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVEUKlqWo2ttd10gQh3gawam9X0cvCfnEg2BZkSEor0=;
        b=ETBi52BRcxhH5IvXyfYkKFllR9DGzwZvfdotiezJYIWX9KOU8ZRTsTHMaewyxTclBk
         lyc+Ko5PGa+6uXCg1KWJyilH97tUDJ9NI1elxqiNlhkBLXl5LJNPIGkmHtBOGTeYUWr/
         zBLJKvwUDoRc9t5I0NsVuEhiO+fcmZPVBRWdl/1mCeGs1af0Pc+e0JHScfqn1t12Urra
         dHXuu8GV13LQskj3yumZRXv/9hc5MuSMKg0vJM+m3AhEHOnDQ9+5Ct6lxVqpakHqycQ3
         7SI0pWHnGxiRgM5i1VteYHSrKDujOVLO7OMoZxW0JyHDNt2fr6HWF7wvkTepvNn0tSjp
         q4IA==
X-Gm-Message-State: ACrzQf1ANXcI1mz49PYoxb3QSlj96Ka+rIK/+YJL6L0Tkm/oGrIlDGXm
        Hn11CphqINAJW+cuzlW5DNB3Gg==
X-Google-Smtp-Source: AMsMyM4xBIf6fZEPKvGGyT4fORjzrVpM0TNb/dbjVSNAoLpFpy/MJCYEdG2B8VpeArgPwDqIuBOzAw==
X-Received: by 2002:a05:6870:d1cb:b0:12a:e232:688e with SMTP id b11-20020a056870d1cb00b0012ae232688emr6604562oac.24.1665695273421;
        Thu, 13 Oct 2022 14:07:53 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id e24-20020a544f18000000b003436fa2c23bsm352449oiy.7.2022.10.13.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:07:52 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 13 Oct 2022 16:07:50 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 5.19 00/33] 5.19.16-rc1 review
Message-ID: <Y0h+JnZVQ3Fk3UTw@fedora64.linuxtx.org>
References: <20221013175145.236739253@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013175145.236739253@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:52:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.16 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
