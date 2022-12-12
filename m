Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6E64A8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiLLUeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiLLUeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:34:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E063E6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:34:22 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jl24so13315297plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EG+8sQHvJPbtrrkYHAC+tfjYrSIfB2UDjEMcjm63I78=;
        b=mTLlJZmBierMpq/dmjA1zjKGWjS1eGv43PXRPUxT7W+Dg9PnwYv+inzAyVQWPHcX2p
         zIRimZwAnnAvS0I4dKj+6PWfjBXxOfhHyX8V+VOxMrxk1kZfNwmEH6X2Sk8BHcQlbCDT
         0JdOoAkdKnOEsuqcCzpiDnaf00+29RnMjHvrXtUn6e17rPlA0KXiDHupLDb95QFt5ysb
         /SFshkgaLvugT9piYuGzjChFqXM2T/2YQpHDIKVvs++DNVlv3e30TuGG2M/+2s7PVDzX
         ty/ZKzNcHgtCKILHGpRwnWihXoTO6ly7ca2DylbcYEm5GKCUUjx71gEKGY2ouW86///J
         UYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG+8sQHvJPbtrrkYHAC+tfjYrSIfB2UDjEMcjm63I78=;
        b=KfnqvxjdV+2Qi65N7gGVL/aehYdyitWJA+CJ6POL/+1iPBExmFFn37Z8i4wGPoSLPD
         Rd0evw2YtZ1cod6z13Yt8ULhZZ5TP2JB64kRSLYdnQlb8QXDQIGKEDkoLfoQtSprbhBS
         TeIZpmTrSYIXkfEIN60dgosPvavEwpkaBBYsD9/mzn/UhofkNS0f7Ya7a9IVbJd068CU
         AGkAy9eXPkO5sWDXY3Pk1D0UHejkNJM8wAxKbOsnEokbtXsccAFVcQbpgezpnkuBMmt1
         I9uMl0yLj9pH0/hOwWw9EKPl6v7CD+giMuNf8nTy7ntFBRlmtSMUDdvrWznY+VZw0wRO
         l2Bg==
X-Gm-Message-State: ANoB5pnph5hCqRC4LGQZ2RnISCYRcgXaYPEkPKLibMPLg8063aYwZgRW
        tWUwvEUMjPSN6Oi8TnyWyr5CQupMP41lzz7fU+4bkA==
X-Google-Smtp-Source: AA0mqf7SuOeIWIhn8efmmXZcIVZ6SpxI8F+ZrxR9F+9mHJCFkJ/Tsd/MfsBf8d5r+2pa/wVIIMOJyg/+Dkyny+KseZI=
X-Received: by 2002:a17:902:8bc4:b0:187:2790:9bc2 with SMTP id
 r4-20020a1709028bc400b0018727909bc2mr83155150plo.61.1670877262347; Mon, 12
 Dec 2022 12:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20221212130909.943483205@linuxfoundation.org> <CA+pv=HOANBfmAqBLi4wyeejs0W1BsZtbhcHqsNmhs2WA3YxGzQ@mail.gmail.com>
In-Reply-To: <CA+pv=HOANBfmAqBLi4wyeejs0W1BsZtbhcHqsNmhs2WA3YxGzQ@mail.gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 12 Dec 2022 15:34:11 -0500
Message-ID: <CA+pv=HM=kZnAYi31OKFopMLDqNc+pK_W=xTLouJc5k1vVcMvHg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/31] 4.9.336-rc1 review
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

On Mon, Dec 12, 2022 at 3:21 PM Slade Watkins <srw@sladewatkins.net> wrote:
>
>
> 4.9.336-rc1 compiled and booted on x86_64 test systems, no errors or
> regressions.

Apologies, for some reason my Tested-by: didn't insert within my
script. Aagh. Will fix that now.

For now...
Tested-by: Slade Watkins <srw@sladewatkins.net>

Sorry about that,
-- Slade
