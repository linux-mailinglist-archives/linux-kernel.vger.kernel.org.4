Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8665CB96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbjADBjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjADBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:39:38 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B417E22
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:39:37 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so20091629oto.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGPbBPdsp8zIf+EmFg/nOXV2cdecCkjYIO3nEraDq9Y=;
        b=MD+yU2XpDZkyNyPpLshmS3Cxq+jRFNJr4pec7YPTCQoUkwXce2fO92A5btzsgZ3myd
         GYqLETtSlQeZWmoUcHAAb25jk3f/utSVu5Vwmj6nlkPCyHhtiRXN1qREywdcaDQE5MQF
         aydvtCIuO/cu/kFsZEtIw6L3LC1/WbkIwQ+ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGPbBPdsp8zIf+EmFg/nOXV2cdecCkjYIO3nEraDq9Y=;
        b=rHRbliuaayIV0tDIXKnodZRHWtws31rexuK2ud8SKH+5vuYDKu/ScxakhsMRXJZglJ
         BO9V/96dM6D0N63CrAnkGqCOw8tlxgQhC3asJqYP/pwhkEt4MpTtaz8G5jjgksgt1hrN
         iX+pLQ59JmPtM98WFpMwR1NzDBz4kvYGbFpQAlXvqeZkau7BKL1qxetr42Fp+IKYdsb9
         E805ZYj/IsafBVA64yTUWpJel5XRqD8v81BB+7L6Iqv8PLYYgcpClOGHVI/nTYKObh4h
         kneEQ3rp642D2BD90xxmEfQ99MVWW7xUeRnqLAkrhIgdhpDri7Jm2hrtrV3TgSiVhUdn
         ugHg==
X-Gm-Message-State: AFqh2kqIRxBhS6ZiIjfleetqVI3/EgU9HpMS+VXc+j3xsSXaceeiK6B4
        bvshaG53ebZ9Rl9kPDr9779P0w==
X-Google-Smtp-Source: AMrXdXvEQhWHLpe3ZOJFYnCQi1ouodXNJ8NYkBOZ+42TANe2SzsIG7iZ15RliSoUC7TvfiGn4247Mw==
X-Received: by 2002:a9d:2c28:0:b0:66d:da2c:c7bb with SMTP id f37-20020a9d2c28000000b0066dda2cc7bbmr22014145otb.18.1672796377124;
        Tue, 03 Jan 2023 17:39:37 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id w7-20020a9d5387000000b00666a5b5d20fsm15322435otg.32.2023.01.03.17.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 17:39:36 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 3 Jan 2023 19:39:35 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/71] 6.1.3-rc1 review
Message-ID: <Y7TY13wNr/7MQhgM@fedora64.linuxtx.org>
References: <20230102110551.509937186@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102110551.509937186@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 12:21:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.3 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jan 2023 11:05:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.3-rc1.gz
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
