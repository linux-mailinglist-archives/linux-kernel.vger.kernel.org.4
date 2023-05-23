Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD14670DA09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjEWKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEWKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:11:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D0694
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:11:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so1223748a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1684836675; x=1687428675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ijudp9Skl+/hs6LWpF+HBcWDTyNQo9dZLQJN0P0dpY=;
        b=OlsHHZ+ZFshfg4doBhBO7bFHKerast6jJS2F+kf4fzdm/OxntZK8BUHlVngzx+9d01
         KI0n9KUp3OIlh2pjeaBmVMh3vGJL2LiyrvXoMKjTllim2ffpFY3QGrI8nOTc1/Ohp5an
         xGFpMimtSEq4EsqYieO//USw9Mh6iKCmGwGHMU5P8H7vqWkH/FSi4JQ6dCdj+xaLF/D7
         c2lISgb47P5h5nzeK3ft0q2nui6VexpHRcmHWqtT+aNSRQHKlXbQEMTrnLqVrLxQ/0d4
         ExiKTGhi7jmlFkEaHBVNksHpm8MSno/DghUwesTE5SPyx61vVSMO6trb4hnD41W+k0HQ
         5pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836675; x=1687428675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ijudp9Skl+/hs6LWpF+HBcWDTyNQo9dZLQJN0P0dpY=;
        b=MO/XzQWZuIkc1urun7OnkduzfIoO6qwHmHavjF4h89rJw9OL7RrjAulk4opOWSqG3b
         2bVTvDtIcovXuEzJ90lb29VGxAEJqmcJ4FujaIJ6UMgmy/mwqc+a7/WShwHf1pRRw+B+
         5rpZoWVPNh5A+VZ91PElkl1dmUk3U84tw008s4tCRGefYhgHicPjarYEGkyNKh5n/x1j
         6Wa9mWqLcuESxD/oSBAN24b9Shja4/C/o3nSNpLpsks52v9+OFEHaB90grfnIPjYSase
         2xWUBhH/eELYWv8OHieEl73Y2fICWR5+TNUa44flW1mGsN0spaXXebLk3OnZVLBP0zkk
         MvLg==
X-Gm-Message-State: AC+VfDzI8IaBZIArRQ497HygmMws6fhbM5Ix+fswi1hstDbmewNvOyPf
        19t8o6dAc1zfP3uAQ9NweAkM06XmTDDLiUPWVLl1fw==
X-Google-Smtp-Source: ACHHUZ5iZ5hWmJx6UvpfTPUcGeGBx0h4ALR+xxYj49G7EeE3YFmWnbwM7CBo5BW8uNNQmbAUWXXkvAW85AbrBN0a1t4=
X-Received: by 2002:a17:907:7b9e:b0:96f:b58e:7e21 with SMTP id
 ne30-20020a1709077b9e00b0096fb58e7e21mr10380440ejc.52.1684836674758; Tue, 23
 May 2023 03:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230522190405.880733338@linuxfoundation.org>
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 23 May 2023 19:11:03 +0900
Message-ID: <CAKL4bV69TwgqL0GBe6NwxhpOzJhTMthQQbbx=Yc8TwOp=2J6dQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, May 23, 2023 at 4:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.30-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.30-rc1 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
