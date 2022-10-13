Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B075FE415
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJMVQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJMVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:16:38 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249991838E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:16:10 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1364357a691so3775367fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYh/T8GIXt/8dRfDL05pkWnOGPY3vN2VxsT9aCfQOzw=;
        b=FxeLJP0dRwDGs1+ifNhEGBvpa8CanRt2dqcRSBDc40Lrwgm0rg43BRsuAlmTCY8E0d
         iFxsMbEfwGdGAmXEjqdS4Qxr0xydStLFo+mrIaKMUeKqiC/+vyHfl9JvNRYvfdrfwbL9
         hadPR9JC+TaJD4qy7QgMIKsllg85/CrbxNZ1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYh/T8GIXt/8dRfDL05pkWnOGPY3vN2VxsT9aCfQOzw=;
        b=Zf3TsN/aI4NN1/a0H+xbLO1qVXkQbLg172fMR5jWaWHag53556aEsjOMDzniavmOFT
         GvjDi90kvybY5XnLhCHSet42QZwfunXex8lLZkS4Fl6YaF/QVfiYFzf/rAKwXN1EJ1/Z
         D9po1rZum+C3tPGDtFFFK5iEHurEgmCKAN4pGJUAwMT1yP6qxeTVNK73zBMrd61gwW/F
         8wWryHd1DIj8oyhMrJN2m20JPBvikK1nAG936v/2iRF4YtQEV7v3YlPN3AzJgtn9sykz
         3BgrvR3IgqfDY2871AkmkuuGyewW9f//EWtsRQB6Ps2IOjvWwpIXyA2NUDuj2cBpHdLQ
         tHgw==
X-Gm-Message-State: ACrzQf2cAwQmM90E/buwMlyuxCCBY2lyrDb25O0t/IX2cRFQY887Y9ZT
        z9lzx6FL6Jzi9Yt4MlOuFsvFXukX+G3K62vv
X-Google-Smtp-Source: AMsMyM6B/9KxtwQkLWFdK44OB7vV2Mz+0dbglQ7RhfGfu3CxaeKaZobo325yEQkLdID6R6+Scsp05w==
X-Received: by 2002:a05:6870:6025:b0:132:6b0b:abc2 with SMTP id t37-20020a056870602500b001326b0babc2mr6294592oaa.177.1665695671149;
        Thu, 13 Oct 2022 14:14:31 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id m67-20020aca3f46000000b00350743ac8eesm318376oia.41.2022.10.13.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:14:30 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 13 Oct 2022 16:14:28 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Subject: Re: [PATCH 6.0 00/34] 6.0.2-rc1 review
Message-ID: <Y0h/tAtz0kntPgun@fedora64.linuxtx.org>
References: <20221013175146.507746257@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013175146.507746257@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:52:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.2-rc1.gz
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
