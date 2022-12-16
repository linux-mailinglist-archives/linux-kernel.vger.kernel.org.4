Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6764E904
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiLPKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLPKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:02:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ADD4A063
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:02:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 17so1879783pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FP9LJMDYntXNXXevgIOUHTB1ze5iCC1u3bRVMjKPtEQ=;
        b=DPapAx5OjERByaIzFy2dxneEocIRIp22ontAn+A2LLl/l0fJXWsXoNKum6ClbjoKjE
         +ymAIryOTyF3fA3opSBgYMDqCk8AiaLWz8W7uB+Z6xP6NtQIku9faYGyr7FHDzaLGSX6
         eTF4XmsP76VM2imwrkcTp6LRBP57cclridIv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP9LJMDYntXNXXevgIOUHTB1ze5iCC1u3bRVMjKPtEQ=;
        b=Js60aKYFI+Ud1IGSk1LJRFJqGrYuPWzkQGIIhe4Uh86SYdh55tfRmxh7nruP4AkUKf
         aldoDfYywSUm1h4LPh8mwLIZCdL3rXraJhsh+tmNqNxlyo+Q9/z8Zt3uPrcbuU1dsfXR
         4eJMNyQatwGvkZg/nSuGoyxrKRGB+NfSL5d31IxL1/j4fO5A/j82VAqXm2uOPwUIzDAr
         EuZzZBP8wgebGto+4Mz0EgP8sk833dGJb5eMHXT99hNyc59R3Io/UJPjeeR1p4ExjnGA
         qhZiSf9dh8uqd+U+/YZ5oixz4Y0CX07YtBaU3gkAWhbLdfU5Qu4z9siCsprDFxz3rfAV
         dmlA==
X-Gm-Message-State: ANoB5plzKuBgccHJHyuNPxDqfctQpUmDRDjP5V9La9Fuk7bXSgTt0TYk
        FCwIZW9d4Fw7R95Be2ABDZ5ZmQ==
X-Google-Smtp-Source: AA0mqf70/ynGFAS3PgdTEeblJ6xC8/DMQr+bqmM5hCQ42dFjxw2wMIT8EpmcBEwD6rUDrFevMp8rzg==
X-Received: by 2002:a17:902:c141:b0:189:6e2b:b742 with SMTP id 1-20020a170902c14100b001896e2bb742mr32615957plj.43.1671184965790;
        Fri, 16 Dec 2022 02:02:45 -0800 (PST)
Received: from 5c08d17891b1 ([220.253.112.46])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902cf0c00b001895d87225csm1190232plg.182.2022.12.16.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:02:44 -0800 (PST)
Date:   Fri, 16 Dec 2022 10:02:36 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/15] 5.10.160-rc1 review
Message-ID: <20221216100236.GA971897@5c08d17891b1>
References: <20221215172906.638553794@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215172906.638553794@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 07:10:27PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.160 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.

Hi Greg,

5.10.160-rc1 tested.

Run tested on:
- Intel Skylake x86_64 (nuc6 i5-6260U)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
