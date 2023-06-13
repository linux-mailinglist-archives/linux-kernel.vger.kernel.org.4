Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F1A72EFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240473AbjFMXKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjFMXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:10:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEF198D;
        Tue, 13 Jun 2023 16:10:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6658b869cf2so1920487b3a.1;
        Tue, 13 Jun 2023 16:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697836; x=1689289836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ6Cg3bDybB3rKuX66HF/Ii9wDRwcjD3MzlNm5ib5YQ=;
        b=NsFfUT83da31OxlXbYCfFG2PF9WHE00I99WNc5I11Yh9uVuLN40OPumEt+WE6uf1Ej
         Gyz6TT++jDCrpzZ02joaoT/ZIBzjxfwaVMA8rMXxYprLzRGh076tSJTDFATJC9wIKi7V
         skPWkFV1lsJvJ8m1+70OM7kByCpP/qQRDQCEIlNV8olIhBjDJRhxKwa47yz8bLDh4YTO
         5jOpfs500TqO3BTfFU2ucrX1kEg+rG3W0rcsDz6qXlG03HyliY7ArMrrN+T6mRBdCtqW
         fP+9Z2wAIqrZ4qqu7Czkkp4ivDLjOXFW0/GgsnatNcR4fuK/rG2laPJ3xgJ1/vOZG5Kx
         pkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697836; x=1689289836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ6Cg3bDybB3rKuX66HF/Ii9wDRwcjD3MzlNm5ib5YQ=;
        b=iOtolDNCWC8QrziVvoI1c3apxsh9Eld2AhaGNkkufl/RWo9nra2esGlO+wH4i2LxxF
         V4GzTsbX4/Mmv3oIQe2hGsVQOz8QvOmneOhHRbj2mrV1easdoNneTFqkRWxihDjtWNZN
         ELUpBKU1sjwaxNRrfdNmBsI29Od36otFz7SY/y+lsV9B9E9quySPfooIsz2k4TQu35W1
         CW4JB2qG49652LfkWRmZBzs04nKkIKoE6ysBoO9CB3su3eG2cfW021oLh9l0AeiYXQGg
         bjggUjI2t8TjKXKt7lJLp8qQLBR2FQsInNaPkefS5Xww30Mg/kPcDmtz3JaliOtmCYG3
         SCIA==
X-Gm-Message-State: AC+VfDzoNL6WG46RJswv5De0dW7qszvEZsA8rcu+9bTvr4Z7/mm0XGOo
        VdveNhGh2m8ed8X4WXUj2s/n44pdIn8=
X-Google-Smtp-Source: ACHHUZ48P1ywZ09tUD0p5alet+xyWeoVcjK7Qit73VOn6d5QI3yfJIRH/jJJQN9/ZBBGUceMpvN97Q==
X-Received: by 2002:a17:902:ce12:b0:1b1:99c9:8ce5 with SMTP id k18-20020a170902ce1200b001b199c98ce5mr12023515plg.16.1686697836666;
        Tue, 13 Jun 2023 16:10:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b024ee5f6esm10772751plh.81.2023.06.13.16.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:10:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:10:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
Message-ID: <70dfbfd1-70c5-4960-ab14-94170508b553@roeck-us.net>
References: <20230612101710.279705932@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
