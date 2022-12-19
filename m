Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D865159C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiLSWgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLSWgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:36:43 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99641CF8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:36:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so7210966pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJLcLAIWjT3AbAwa+yUACoDWvr87LtfOapEiRZ3XG00=;
        b=bJSrWtMm1cvqM7vvB2RD0G6l5waC1sCieeY9+JGOdwVnPClrw3FHtkPerX9L8nJsSi
         4S/ibHP/dCXfrLS5J8kD4yVz1DMDt8ZU68nf1G4iO5BxAvLkib5avDSUaaag6asHqkil
         EL0jLOsHO1OUfCUR/inH9zEgWegukYi0C+DZSk+4W27hZaPiXx55tIgyp6WNH6ldmt9C
         kzgK0ZopXE910+QAwH4Fgzdi4iZbMJ+Li0n6HI0/u86euaPNdb+5b0LHCugO3Xfydpck
         /qAdE2LxHr6hECV01Hk4M7Jffyb0T70iMp/uogdvI55nmQgBoRBeO+fi5KOw7KKuxDY2
         oO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJLcLAIWjT3AbAwa+yUACoDWvr87LtfOapEiRZ3XG00=;
        b=SrUFe9WPnbMZm4v1AaE0tZEZgVDUpeymkO+R44dcy4T5Y4C44V46aHnRV1iUZF11Fn
         KTmk7yLootcB0v3EjQ2voiOpp/fx7E7KA1TgmN6fFWE6LeSVxPAFO2FvzA8I2oVFfRyi
         dhrcyemIX1ixvP7DGufvcKIv8ZNnZoSgicp1W+DniAGObzgIBxBrq0X5oZyZ9C4tnukY
         VaIfUxRDiI/zocp9qmfb8WlY1ztWR8f7sjtGhn9DL8PoV1lvmOg2gjiBBPmNo39Yy/8Z
         ogOj21uPCJL3sb/AkFz8Bq0pm4gUIRoWeuVFVuIK8HLKjvhyR8BDtofIdURWEVBRQPPz
         sYLg==
X-Gm-Message-State: ANoB5pmecwEbpWe98lF2csUZDn7mVFqQHoB6qFHZw2zxxuVSFEn2kqQt
        imBZx15tEbdnx0iABgxufhpXrFvv9s0nMt+FaiBPzQ==
X-Google-Smtp-Source: AA0mqf7JcbOfcsXCrsLrkkWDc913LEYj2JTFH09eq/X+rLDCOCVY/5O4RcseS0xG6QmNdsyFSj3/8sE0xy07Np7YtRc=
X-Received: by 2002:a63:ec04:0:b0:479:7f1:11a1 with SMTP id
 j4-20020a63ec04000000b0047907f111a1mr5249389pgh.412.1671489401081; Mon, 19
 Dec 2022 14:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20221219182940.701087296@linuxfoundation.org>
In-Reply-To: <20221219182940.701087296@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 19 Dec 2022 17:36:29 -0500
Message-ID: <CA+pv=HMdmd5E=yH-1_dbF316EQ=KkriAPgLg8e+7m6wbinchaQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/18] 5.10.161-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 2:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.161 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.

Hi,
Compiled and tested on my x86_64 test systems, no errors or
regressions to report.

Yours,
-- Slade
