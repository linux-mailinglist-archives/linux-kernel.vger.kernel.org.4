Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097C369ECE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBVChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:37:02 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366B33468
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:36:59 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bq17so6627365oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKmcGsNQ4fhRrMcdXSSRjVajCI4KB45b/EODQuEUJ6o=;
        b=EiBnREc+YVTdZou6w9ZUQ+E1ddVihBHRah8AACvFOaSKA+k3uOiJ2iWls/5bmzGYGy
         Ko33dd0T0sq4VFyvmbj0FfX2dG3pzb9bVqa8T0tTjn3tYkr2WkzKtIvddfryWtrgSLeL
         sbV1h4XlxAUJNf4OoJji/wnV2Y9KjwnXQGdNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKmcGsNQ4fhRrMcdXSSRjVajCI4KB45b/EODQuEUJ6o=;
        b=NZYgV1wr3dRP58zbg4FTHnnOLbePUU9lffoBEBxuPe7Myn1sOj4sSzQnpvtBkb8zBu
         03EKMYS/IbVPr7QGAVpEhyLhYolQv/aD8paSfRsW7dk2Tz02PL8snm6herTa8ccy/UUy
         m/UOvrseDQQNGpe+EX3gFqUJ86KY+kJy1C7nETN9rH1xgbD5jjUADwK+hwZqps6oFlTr
         jqTJlqMtg7MefmTu6F28onOg6PbDjWo6bjPVxtsfb6KI4y+IOYzaLl/KASkQNk+iLwGY
         r+lxZNGswqOCpw/yy4inUryR9HGaytufwHQIDqYCNc4FVQArva8FGHDmKhYkNAXxaL0P
         AFKA==
X-Gm-Message-State: AO0yUKX+lZ3ubMT8BqNlLVfwquAGOORfZObmHh5/DmWmlaCQMh0W1q9n
        juASCcvA6oPziWXSBJHXB2hclQ==
X-Google-Smtp-Source: AK7set9ywrkVYLikZ7VBGdXshHd74At4agEypcKsPCYfCyAxbVz5UaR4M3Nm7uYG2rSL8VNixzM95Q==
X-Received: by 2002:a05:6808:347:b0:378:8516:5c80 with SMTP id j7-20020a056808034700b0037885165c80mr7524686oie.43.1677033418886;
        Tue, 21 Feb 2023 18:36:58 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id w187-20020acadfc4000000b00383b371f2a7sm1456578oig.42.2023.02.21.18.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 18:36:58 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 21 Feb 2023 20:36:56 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/118] 6.1.13-rc1 review
Message-ID: <Y/V/yFI7N3BlvZ/k@fedora64.linuxtx.org>
References: <20230220133600.368809650@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220133600.368809650@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:35:16PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.13 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
