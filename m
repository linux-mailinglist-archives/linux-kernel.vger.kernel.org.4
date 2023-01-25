Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8967BC89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjAYU1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjAYU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:27:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B47DB2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:27:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so3340133pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qs3vFGx5vjVLb7bTaBqnezUzhWCYDXhW7fyeczk+6xY=;
        b=KqVH0Xk6iVGexG1WZB4xkuFSRHFqib1It4e/xDjyv0qLlogElM6GONXc2aaNDoD5++
         CXBrJ8hHi77JNNoPFrdOSizzsGP1hS2TGimuT2Hqwe/wF4gl88xs6ua+gZivMyd4mZbg
         Jq58DX1Hs32FXKAEcOe7FiDqyGz6Fmeg8snSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qs3vFGx5vjVLb7bTaBqnezUzhWCYDXhW7fyeczk+6xY=;
        b=ndaa0IgeKsKQ5bQ3UXIDZeRsjbbZxLLLg2yQNuBqCb4pfg5pQF7pdapqXKaMquspQ7
         +MaBzEwtCi8xfwZQg4rBuDTzyAm7Ooa6ouQOia1S+JCx7DOM0e+5m7jovLsmy7Xeypb0
         7rdD23dmIcMikjuon0O4yXaDuGWi5OmsiCULvoRDPL/pvT25QKqQvE/fed7eMdIXEHwe
         6NjeSF/6XCeKcOPZMNRN9MBA00tNt32MNO0h5jmvNKwOiTn6QsLsaYCcjFU9qy1B9Afo
         2egDXWssNhOHykLAk0yHQHtgJ5gD37u4TsY45SFCNsFWq631j0LCayhrnr8bCqvRVI+x
         AC1A==
X-Gm-Message-State: AFqh2koMj6wdoeMDU4llHPsejDsPGzc/WHSvKANQwHTsJNCMj9yI5f00
        ffuQiCDKYjFdux2swdqgfzanQQ==
X-Google-Smtp-Source: AMrXdXvhIoganfGBKjMxOiJxe35+/ixuy01Fvm5LFKL9CFzcoC4B+HTAInNsHepgE5z+G/tLG7VNUQ==
X-Received: by 2002:a17:902:c401:b0:194:dc73:5cf8 with SMTP id k1-20020a170902c40100b00194dc735cf8mr33051142plk.39.1674678466359;
        Wed, 25 Jan 2023 12:27:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b00194b3a7853esm4052877plj.181.2023.01.25.12.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:27:45 -0800 (PST)
Date:   Wed, 25 Jan 2023 12:27:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nvmem: u-boot-env: replace zero-length array with
 flexible-array member
Message-ID: <202301251227.3A6AAC1B@keescook>
References: <Y7zB+s2AC6O+CRR+@work>
 <494915c85c52e66aa83fce49556ccf3e@milecki.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <494915c85c52e66aa83fce49556ccf3e@milecki.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 07:41:02AM +0100, Rafał Miłecki wrote:
> On 2023-01-10 02:40, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated[1] and we are moving towards
> > adopting C99 flexible-array members instead. So, replace zero-length
> > array declaration in struct u_boot_env_image_broadcom with flex-array
> > member.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [2].
> 
> I also handled this issue in my
> [PATCH V2 4/6] nvmem: u-boot-env: convert to layout driver
> https://lore.kernel.org/linux-arm-kernel/20230111073102.8147-4-zajec5@gmail.com/

Ah-ha, thanks! Looks good. :)

-- 
Kees Cook
