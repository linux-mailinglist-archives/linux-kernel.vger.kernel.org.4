Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF62B6829ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAaKG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjAaKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:06:48 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E54B8AC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:06:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so40069565ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkw9ssCWJyclisbP9nCkp/nTlcXWXM8FpBUVmi1FLp8=;
        b=F3O/hTi2OdGhVbsp6wAE3zXX4ww0RuFrx7DQFNPnvthLyF9Sr6AUdHZ/WiuFfErBXi
         alvm5XJJ18R8XqKwGKfh3/hxEv9wmqQ0GzajLZNqhVDka56IBjS57hLr27HSWPP5MePj
         LEABo7NzS5eUxWfvv752DRbE7wC9G49nVC0c6IS8TmKaBWi/NruZMJCljW40awXw1CY3
         mx0nd2zOt7W9Qb2ZKDHpKSPtfxNII/Ly+vaI9w/sLPppKRbMDnrFJhOcWV1H+RVV0jrm
         gLxGQR6nm5SG6omCh7opXFF7TtKSTdSMNyeNNwaq06Nl24wPGtsz9jN12ojdxcq5DbFj
         KUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xkw9ssCWJyclisbP9nCkp/nTlcXWXM8FpBUVmi1FLp8=;
        b=1KJBGKkLPsBipHOogpet6IbYYlXntSKXDwvOR9UewK/PN0JdeUorHX44mVpYcopoSD
         LDY+CMgGfN9qxbJNJ+BbC9smkImj7nuzvxJe3QMqKo7+WxnLRqlynHa1zDEsoir51H9N
         VDw0/ZjbZmR0a7TueneFw7XjMcBFYWPnBbsAY1FGIIiV47/qMqOsEoLCNRn3ViJDnE/D
         ogvstm+THDtq4dK5j05JkORVZCiPxcUe3kW9Gf/Emub46R2wovDFGfEC/jqEolnE0CUz
         /fuIB0js+yLlePfQeMzUFaJVE2S70Fvld7pk8YiRvpBaAMb0Cj3XRTFVpEKgeo8JgWav
         IzyQ==
X-Gm-Message-State: AO0yUKUPL3HoWWSzkWCGuX8lNxdZoiITEdrp6kmAEI7z86VDaeY8VRU2
        buIjApH/KNytYHq6zNgibse/MrlI/uBOgjTJP2FPAKYH1Blfulbl5Oo=
X-Google-Smtp-Source: AK7set9RfNpPl1SDeMeR6WbkTsxeGy/wDlqKFk6JaKuxcJ1m6+ZQ2J0rQE5oO9OSoJpCExplhpYOJ7Y3VUnjmnrEYQs=
X-Received: by 2002:a17:906:4950:b0:88a:b6ca:7d3a with SMTP id
 f16-20020a170906495000b0088ab6ca7d3amr1183718ejt.1.1675159605583; Tue, 31 Jan
 2023 02:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20230131072621.746783417@linuxfoundation.org>
In-Reply-To: <20230131072621.746783417@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 31 Jan 2023 19:06:34 +0900
Message-ID: <CAKL4bV782_oo+2JpTrNqGuxMh9kj2vo-9Ra3gDpDZ9YsYSeXTQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/306] 6.1.9-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Jan 31, 2023 at 4:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.9 release.
> There are 306 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Feb 2023 07:25:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.9-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.9-rc3 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Nano Gen1(Intel i5-1130G7, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
