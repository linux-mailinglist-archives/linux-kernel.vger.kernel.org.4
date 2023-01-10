Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACB663AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbjAJIYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjAJIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:24:34 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D6444349
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:24:33 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4bf16baa865so144462867b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VsxYooBopMhkLQpN5cBLVBKPwsYnLnhSjEilG/xMas=;
        b=H7pDvZDQ1MfoFeaazIGBoScW34THvY8lDhkMwO3zzNGgmqIyFn+oi35rOuV5XxI5Wz
         s8l73v1+CAEh++7BZLbRN/TiGY9JuMbdDXwlAyfr2fVbgkcrfJgZrrcV4SDixVk+sab9
         3NK2FFrvo8JtAtuiE5YDYVAUollGzaWJjgrJWsS+P5TE7umW4Jmhb/S4zh9FgxtjsJhu
         mbMmlsMDcf37/YX6QcXT9fJ0pympHyPEj1j3kC25/RZkiNxaTdGu9HO53T2hPalazTX8
         DSEk7PYZXiDu/ocWiyd/k0/bzquhaWFkznquFIo/cecBnnKLNSwF4Suc01J93bBTKc4n
         l/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VsxYooBopMhkLQpN5cBLVBKPwsYnLnhSjEilG/xMas=;
        b=eH/ePJQSgHBPVHs+qql7F8iOvd/pgk1xl6hvE6Muu6JizHE2w/jAaS/ikcns2Q+EAc
         e0pRCXDs0YiIe2Un0dL9PxacZ4sdAsVYcaIKg0qAneczzO2mSk0dDoFFGKs+HB5x1iSW
         5JQ5R/AAAL7sV+f7AtEn+YIRlSoJJ14qjjCED6iuwBCAuHfrS8IXeTej0/+93Dlww/NF
         uj30vIhu3R5QKfczGAxLAdhbjq1jS26NNNcqXryxcJZV57AqsdPZhERQmCf7Dpbfjq7z
         eNvfP17xAoln3uIH2wLOijljJR22QXpP2NLS/EeoeZ+3Wqa2iHrvcYXjJykresO5N7m3
         0L7g==
X-Gm-Message-State: AFqh2kohdAh6df3xrd1QLWEniosFpiuRNwG33B13NiNJftaTEWW5iPqQ
        1sfuPLhlpRgIkFeFdZwtPqvb4uAAkQFIaJIuGaMHew==
X-Google-Smtp-Source: AMrXdXusbX6v2C5N8FwrOyY3GS/HBT2amDYOSb1ETSnQ6xhO925pkhWgsMl/OjRO053TEXNMRxeCO7ZwYhiRqSpRHUs=
X-Received: by 2002:a81:7784:0:b0:461:49a3:db6a with SMTP id
 s126-20020a817784000000b0046149a3db6amr1721899ywc.185.1673339072305; Tue, 10
 Jan 2023 00:24:32 -0800 (PST)
MIME-Version: 1.0
References: <Yhe0pCpfeCpyfPWg@orome> <20220816102725.14708-1-pshete@nvidia.com>
 <CACRpkdbMnRNTLcCtqNjKpxWxMbAXLssnuBEuNqAfgDfj3XVfXQ@mail.gmail.com> <14dbbfdf-c096-439e-41c9-71e083138560@nvidia.com>
In-Reply-To: <14dbbfdf-c096-439e-41c9-71e083138560@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 09:24:20 +0100
Message-ID: <CACRpkdaBY31f6R3TTD-5iRDdKV46tY5GK-Xvd=exwZ4HeCTYAw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO driver
To:     Jon Hunter <jonathanh@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Prathamesh Shete <pshete@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, smangipudi@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 9:37 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> On 08/09/2022 14:21, Linus Walleij wrote:
> > On Tue, Aug 16, 2022 at 12:27 PM Prathamesh Shete <pshete@nvidia.com> wrote:
> >
> >> Using this patch we are adding PMC compatible string for
> >> Tegra234 in GPIO driver so the IRQ hierarchy can be set.
> >>
> >> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> >> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > It also has Thierry's ACK from v1.
> >
> > Yours,
> > Linus Walleij
>
>
> I don't see this one in -next. Are you able to pick this up?
>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Bartosz is queueing GPIO patches right now, but the mail has the
wrong address for him.

I put the new mail address in To, so he can pick it up.

Yours,
Linus Walleij
