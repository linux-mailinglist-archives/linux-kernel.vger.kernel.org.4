Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC1659ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiL3REr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiL3REq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:04:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D0C13CE1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:04:45 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 60-20020a17090a0fc200b002264ebad204so552601pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp8DP41XrSw0rokxDPlHiL2vJVa6DK6lhh3jR60QHzQ=;
        b=jQCEnGalnxhHOck1mpzCJTxyEOCEGMM0VObMvYaUwQc2WXxbmcxUI5KtICtKtBGnl5
         g7fyRVxFBJ+z9pjQZE6R9hiN2jSDc8G7vqObk/UDfqKKYnry4EYpkNudJSczMIJYbQGW
         pnqkBL+bWSkZSOsEVUmbf4c4QodAjzr8OgJGzLmBradO2skjYwSOv3cWngR0knKEeWok
         hSoSyEjWF+20dxo3ZdfNhaDBytq2A6G3SttD4KlLZd8D0FaBXicsFioM7RlTX37F9x12
         6UEF48zrn7hR1O086VTgp7fjZn8av6gvfn/NFNYUkId2XNiC+ocU1rXn3UYxa3idug57
         /Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp8DP41XrSw0rokxDPlHiL2vJVa6DK6lhh3jR60QHzQ=;
        b=DDGVcmlSswE+A7a8hQjvrWdNO/zTyoFeKHvO4f+ETiMAB9nP17zAty4f1yHC0X1wlt
         exKHd4WoVn4tOWu45r1Z1ruEL+S7s7L+hni0iFlBg6mXqvrWk1Kj73AOLUwbaFBuyHg+
         3GzzY3HsbJ9XuxudPUU0XTTE6oJwZFAZbS6g9sXhk0GKrGxqvDHTTNpukrpjggXiySto
         gU0STUVYkSCa4s3DVMCEIkpgAkRa3E+DH1x2YGrZpnft7W0bJANbBTvI00c9sDCGRIA4
         P8rBp3RbQz6DikWkW1nh0p2n1qlFqXSKwSGYi4TQyhHE42B9Dpg9a1rzhfH1pz8OwyhB
         A02g==
X-Gm-Message-State: AFqh2krxoFGkC6TqsT2QV+CfrHPa+wQssbEKRBk8I/7w2xbyRfMcG5EU
        2yBQiSvQtv5jlTdWIxricpsxlY+Upw3K8G/dzOqfzw==
X-Google-Smtp-Source: AMrXdXtX6SgWkB8eYBoy55qpzn+bUv9TBTVEu1B6SElDTvzpS2nx6LNeZAYQfbA4yR9RNC/dBQ2cDlWs6+44t/eY99Q=
X-Received: by 2002:a17:90a:af91:b0:219:536b:41ef with SMTP id
 w17-20020a17090aaf9100b00219536b41efmr2903859pjq.71.1672419884549; Fri, 30
 Dec 2022 09:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20221230094107.317705320@linuxfoundation.org>
In-Reply-To: <20221230094107.317705320@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 30 Dec 2022 12:04:33 -0500
Message-ID: <CA+pv=HMf6-d38AJLm4_gO2NOW9SAPJO5uBq59ga+SVFsexOQ1A@mail.gmail.com>
Subject: Re: [PATCH 6.1 0000/1140] 6.1.2-rc2 review
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

On Fri, Dec 30, 2022 at 4:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.2 release.
> There are 1140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 01 Jan 2023 09:38:41 +0000.
> Anything received after that time might be too late.

rc2 - Compiled and tested on my x86_64 test systems, no errors or
regressions to report.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade
