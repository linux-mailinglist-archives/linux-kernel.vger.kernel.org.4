Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445155FAA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJKCVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJKCVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:21:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A005C9C9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:20:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l19so8173886qvu.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3oL+ynrOSKSzgOc50W9n/l8KWPjIlHisTCyClwaTFA=;
        b=fqZU7JIN8Ua0+47qZpf7b5Iv7LIYXTRKBYv4oSTuR5naMEraG/aP4+/9lpBn24wSDw
         hPInOT88/NlDFWWgBFf0gaHEGnj3fiWnbCccAveKeuFFaYADHQLlKP6/BNeTLPCeP0in
         O3ctNKdtH2nM43+yYilixvBcqwS0Gvpb+rbdHStq31to/3xNv/JeNkslTZYLITPf9I2i
         NChsO7bAz7V+u3MYATkxlVsw19P6e226GelX+MPpRhRp20YFo7px3rnjug6INthHL+nL
         TKBANoEVGHui+tBg9+kXHzAJnm4+5H+dXW+gIPwgibUiDO19YK8zzfvR9NJjt9YX8mLU
         NmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3oL+ynrOSKSzgOc50W9n/l8KWPjIlHisTCyClwaTFA=;
        b=JRE7WGOTPWztS5/KEihtKka5efo7V9xCOGruqLEJfz+fhMti/ZMA0vj1r95OmcfqT1
         XF2wW9CjH6rh2a6G01rWar6w1NQNO728uWBo9fZhALLanyOFTJeqNGWDjU1F2lTa9fRL
         u2Z0R+m4APFMynqrNZpNfzU/mCf4DDkxLeNX5NWIqI0q2Eyj7oJyVtxUD7AMNJWd4IuE
         NkxDZKqf8EG0HixRhraqy+ZXmQiUOyXmv1APFhXrGa1T9rxFwyM/U/ca0Xso607Hs1WB
         VP1zXTnzQreMr8Mxt68q2GDJ8TJmmXYQAeTVk0p3w5E4a8VPol4KgKLm4pCzYmyC+w01
         vFuQ==
X-Gm-Message-State: ACrzQf0OgoBocbkqCawq9R+09jns+iY24a9Kn/eSvMlHCRADER4wQnJC
        aDOcqM4swtVZJG02hxmIletrKQ3I6jPkivIrW5YH7g==
X-Google-Smtp-Source: AMsMyM6PbsMh8y+8soO6hSNlN7Yyc2jQg8LI939tjIeyc7YZPu33iRasr8hsLGeNcHhE4O8KknfMKQ==
X-Received: by 2002:a05:6214:5013:b0:4b1:877e:539c with SMTP id jo19-20020a056214501300b004b1877e539cmr17187963qvb.106.1665454857580;
        Mon, 10 Oct 2022 19:20:57 -0700 (PDT)
Received: from sladewatkins.net (pool-108-4-135-94.albyny.fios.verizon.net. [108.4.135.94])
        by smtp.gmail.com with ESMTPSA id h19-20020ac87153000000b00397101ac0f2sm8023634qtp.3.2022.10.10.19.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:20:57 -0700 (PDT)
Date:   Mon, 10 Oct 2022 22:20:55 -0400
From:   Slade Watkins <srw@sladewatkins.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Subject: Re: [PATCH 5.15 00/35] 5.15.73-rc2 review
Message-ID: <Y0TTB1jrF+BhN0h0@sladewatkins.net>
References: <20221010191226.167997210@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010191226.167997210@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Oct 10, 2022 at 09:12:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.73 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Oct 2022 19:12:17 +0000.
> Anything received after that time might be too late.

5.15.73-rc2 compiled and booted on my x86_64 test system. No errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-srw
