Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E521681F54
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjA3XFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjA3XEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:04:07 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFD26872
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:03:12 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id k4so31096544eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07VDJ5elyFb8DCNtKRtQSNQC+aoUsg3svdwL2SSVLNc=;
        b=LCcFWG8FE+1gDq/Xv3rOMz0d0y+lQwimcuMaLx+GnAAOtn3jAsKUoy3LRhfdesuMpK
         3vFTeD7p9CVaNG0huZCNphhe55rf5jttXYxXnrBA9W3yjx/R7OjK5pzCe9H2G4CRZud5
         NeVb+zA3mk2PFVworUBkZ0Dc3gvh2pMlEVj8M+KcBU0HvHPVVXGNKqiGClpGIczvHllu
         x8C0igS5iNsjlndNyvSP+l18NoL7rdNaAyuKZWUZfkfypnma2HahE2nbffjnHDh72fLX
         RNkjROVzhuLnaSzvBCctVLpjSXR8SQrQXFA99iIKdvxh6i0HLIqdVG6qw/1RKOZE0JQ4
         M2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07VDJ5elyFb8DCNtKRtQSNQC+aoUsg3svdwL2SSVLNc=;
        b=EEcq9NfKvqW9OPXzc0faCvYFFYgr7HbDpQ8HBO95B5JHuUv+LNzuOZYcJ9ZPW2rwR8
         5O2trDmzUmETfacgQBZX6oFDT7vGqUl3xRETY/KEpIrwMJ7W3k20P2T3xzLjJv6AoxPr
         j1+1DU/b5ZO7hh1iWJj70J/sWwTOL8KEAmpYc9MawyNXT5JazpRVzpgsJk8nmokD/Uln
         Lv9Q1hDtR/fjDAMD+q+VMa1GBSNvjwuRUaxxzdkplSP7hg+hS+K84ib5k0hAsRBpPAiS
         ivIemMi3kXEXV/NHa34BaFe6gh9c6mjnkCSPfzGc9kazaFavzyw735OtyAAu7VLzYlx+
         WCgg==
X-Gm-Message-State: AO0yUKVyuovPrjdOaL7XW+uHqHhZCTiRhsaFFILuvepKv+Q8dKxjZl8I
        lrj535DaF3my6C30jwY74rbttfex/YD7WDoDU9pGBw==
X-Google-Smtp-Source: AK7set9zqShyRJKOoelppWcEvIaO9rdtE83U/S1EjREGsVqjb7pZ0qQGTNK5qxq7uieb9FNjZZLOvFW8hEhI+k1Mb1g=
X-Received: by 2002:a17:906:4950:b0:88a:b6ca:7d3a with SMTP id
 f16-20020a170906495000b0088ab6ca7d3amr782284ejt.1.1675119636354; Mon, 30 Jan
 2023 15:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20230130181611.883327545@linuxfoundation.org>
In-Reply-To: <20230130181611.883327545@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 31 Jan 2023 08:00:25 +0900
Message-ID: <CAKL4bV5CcJPtP9fyxYwkk9-C9PkgeydqiCeCirb8L9ShK+a+9w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/313] 6.1.9-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Jan 31, 2023 at 3:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.9 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 01 Feb 2023 18:15:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
6.1.9-rc2 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Nano Gen1(Intel i5-1130G7, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
