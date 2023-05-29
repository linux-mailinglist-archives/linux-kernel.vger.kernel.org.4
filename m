Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC1714DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjE2QJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjE2QJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:09:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D19E8;
        Mon, 29 May 2023 09:09:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d426e63baso3938999b3a.0;
        Mon, 29 May 2023 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376562; x=1687968562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiS2FFWs4WwYbdRa94v54Z+BvgoGuQrPEURj3HPmPzE=;
        b=OWdAuHIllii6Lt29LD+o1tATMbArgPIuifwEazV4pxi6IpNH6fXsFgeXvT3ReSCT30
         LjxL+yJ8MgPzesNcPNk/toGFfU9z2p84iT9W9TY4AzSEk4TrMIr4mb7MSzt4yAzyvKY2
         KA8V8S+vXmLv0bjVdVYUk9shxDwsoSfldU5Lltj7Ih18hMbUCI2itLKkpb3a+YWsCGIv
         Ba5kjZXOp5cc8ZL2KquBUb0avALaR7nW2dvhOEcS8nzw/jVIr+bZvcgxZLHp7BVh++GL
         KA9sPCcWe1pP4fIVrXUbO/V7HeWkdG8jym3NUvZTPc6qbXp7jSOZcRLfmrfEX9hHeaQW
         KY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376562; x=1687968562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiS2FFWs4WwYbdRa94v54Z+BvgoGuQrPEURj3HPmPzE=;
        b=OEgu3rGa8cDf1z5PrWAIjLwzIFfD3VwkwXE/Avx3iRVNWSd1Red17XA1WP7bMBmcF2
         ez8kMOjeYj9DCDrKrmPlSdktkvUePE6xlh4zqy+5x3UxitWT6NJSy/0QN7nB5jOHIzJ/
         1PJwZKQYGrKkRBAf3OnMiiRKyl7SGcTasPKsqbvlY2V7XNGj6aOvfP5e3cUsTeC8jvsE
         BKvNw6rZDZpATECkSsfsFJWwSxqvUSHLV980kRTiWZcv5U1vkHzir7p6/sfd3Oosqiqq
         BK/scMXiMwm7hIL90+RXxJSziwUgL3yWkBTgcXcauNVW4V8pAajbEKeePS8RzAbiZvxI
         dB2w==
X-Gm-Message-State: AC+VfDyoRAbMzkZyWhOHKkXVOcQKmsx3DiVWS6oFVX5V8MjONmEh0BpU
        kxzQOy5vCSStqQW1F9YLgWU=
X-Google-Smtp-Source: ACHHUZ6EoU+LOF1JeVhzD7mo9RrE/6RRuP2ICQAffylOMye8t4xMB2YQrE9RhtnoR/awMGg67z7SBw==
X-Received: by 2002:a05:6a00:881:b0:64a:f8c9:a42c with SMTP id q1-20020a056a00088100b0064af8c9a42cmr151341pfj.18.1685376562264;
        Mon, 29 May 2023 09:09:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13-20020a65430d000000b004fbd91d9716sm6417751pgq.15.2023.05.29.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:09:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 09:09:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 000/161] 5.4.244-rc1 review
Message-ID: <48589bd0-755c-4c11-8483-04e115dcedbe@roeck-us.net>
References: <20230528190837.051205996@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:08:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.244 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
