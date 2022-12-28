Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277C658555
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiL1Rmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiL1Rmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:42:42 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F76178A4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 09:42:39 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso2769505ooo.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdJW0zFNO7I8CdbGi6ec4i3VeAiyzncUC6V1niYK8jQ=;
        b=P+RN9TABtn7zrlQP9gYBpowkXv1j5CEMhdZM9/s14urNSAzOWgvEluGqgUz5hrIAKk
         oJPOLhQ4bWD1y4mQ/1y6mPUwtXAfGtH/INRXFF1tA2oFTJRg4LmS1ghFQYEKqDKoXwjW
         LViAvg3i09F3qjetes+rpzSUs3dl3zc2vH85s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdJW0zFNO7I8CdbGi6ec4i3VeAiyzncUC6V1niYK8jQ=;
        b=a+g14ibWfUQ0SAG4A52Lyy7B2HafdsK8t8FUOcY4XaPwPlLZcW67yJ51MHFL7oBu+Y
         9yXqsOAxHsPk4U3KmAtC9tc6yxrt13ukJ7lh2klP6Cj9wC49L4FmqtJHnyWIYGD5hwth
         vI42tqZbSFq50VPul/8XA0t8xniHSX/pN3E6ZLiQk4UsE6JNgJSw+pFXkqgo+jVs5sYe
         Z1+LeN4dNvf6jbxF+NFdGJDw+QBXBVifZ6RoihKawsCoLEhT0/pQLRTxXdgBWh7CpMe2
         M9y/IGiw0PDJ4GOSHpcYWrL0J5VgPp0QqYIcRgHnqTxDWygOQD1mO+lE6XUPCaZukfzP
         1Hfw==
X-Gm-Message-State: AFqh2kqajARjXMfzXLqMR2xvyglSmsPL7qEfrr2pS5lf984MxtlIZAmL
        e7IrBqcIrRyefTZtrhVtEl9lug==
X-Google-Smtp-Source: AMrXdXtPdlVUzf6XwhF1skTZyHCzRpQF3sEO53N2Uh800gxau6EksX34u9u+mBC7ouSkTo1k7cWpNA==
X-Received: by 2002:a4a:dd98:0:b0:4a0:1897:d467 with SMTP id h24-20020a4add98000000b004a01897d467mr15368052oov.1.1672249359145;
        Wed, 28 Dec 2022 09:42:39 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id d18-20020a4ad352000000b0049fd6bfde95sm6705149oos.26.2022.12.28.09.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:42:38 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 28 Dec 2022 11:42:37 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.0 0000/1073] 6.0.16-rc1 review
Message-ID: <Y6yADXdrUQ5I6snV@fedora64.linuxtx.org>
References: <20221228144328.162723588@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:26:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.16 release.
> There are 1073 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Dec 2022 14:41:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
