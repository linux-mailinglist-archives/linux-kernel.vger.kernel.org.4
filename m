Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E099374E21D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGJXO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGJXOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:14:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B40F1B7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:14:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so7675596e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1689030861; x=1691622861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIA0vS9CGVZu/dKUtt1DEeTq+za3hXZ7GjZyvjklTUs=;
        b=wbebkbLh9K+s7RqRbnPjkJnBGX5Q2tQ8wr1xPosokwNjTydGAOTVas0VGA6zyRvd8W
         WPyz+AzJVi309tna+AIGoxvDbPTKSBqHQhlDFTkuO0K7N/LXJ+6lBIA4a0/d9bQl4L5V
         2u5aXF3lCrjW8ZVuffdH+voZjPSyNhDf7YA8Pn5PaW98cNENUYJDCXNaPPMiOVE/owwg
         T1Q5RnfMgUW/9WFfuhI7SWR1RJxpKbsAkgkD+QTqkZ4KScpOELTy7xA1xbGH3aMYFxFE
         WthVHtgBB+4NQP+RVltsVo14IXrQLyjuhWpqF0JjkiE+VOTMeGhWn182IwNCWlc1KsVT
         Xn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030861; x=1691622861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIA0vS9CGVZu/dKUtt1DEeTq+za3hXZ7GjZyvjklTUs=;
        b=aTFiRYe/bpYgPcxIFvAwZZo9seCFWZRAfiBbtrXFL1vnSLCwcuY+CcjI/C3p//R/hK
         DZErG+7ayB4wCTLWvqzYx3bTxBz8rdm5bSBATZZz+LW0JxnCkxQY4UGOf3OjTu5SUuDp
         MESEvLEdusBbEmrzbFJBIkb21UlKpPuDcH5Netj1e8YubRd6nfhUxb8GNs7Qtz+mP2RG
         6AtcIlE7+/xswRI9r9MQgNPuwnbmfljdta//y0y+6MZY8MQr11N5oJMVi/x6WgujcFVa
         XGz5R6cGOaV9npSjeDFkzXSTTy8AoOvxTaqh0OFSyk6tZkhGv22tTXOXSvUEkR5KM80v
         a8mQ==
X-Gm-Message-State: ABy/qLYSiHVfWa/ibq80WbhXr2k9qyE79aMsoEJ9M7GkN4D2YzCtXLJW
        285e1jNLlJRvfPacm/mC65ohkXEl1RJDMNgNRZ2r9iWWs9BdUn157PPyIA==
X-Google-Smtp-Source: APBJJlEcIKfj6d06z0ZSWaBeY8VonHC9pf+QP0h3+s903O5LXh6RbAYPuokBP+PaRwBXogdljmL9fsDD46SWpNIEctM=
X-Received: by 2002:a19:e006:0:b0:4f8:6bbe:8a0b with SMTP id
 x6-20020a19e006000000b004f86bbe8a0bmr10101748lfg.16.1689030860745; Mon, 10
 Jul 2023 16:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230709203826.141774942@linuxfoundation.org>
In-Reply-To: <20230709203826.141774942@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 11 Jul 2023 08:14:09 +0900
Message-ID: <CAKL4bV7eHZerKW5F2_Zx_fEpmotZ3YvGYht1H1Evro6M5CBHxA@mail.gmail.com>
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
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

On Mon, Jul 10, 2023 at 5:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.3 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jul 2023 20:38:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.4.3-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
