Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33026B5D42
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCKPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 10:15:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBA29411;
        Sat, 11 Mar 2023 07:15:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3DE360C7C;
        Sat, 11 Mar 2023 15:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B67C4339C;
        Sat, 11 Mar 2023 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678547714;
        bh=WRaPMgPwoMyVfWOrMK/gri/pJ94fL6M3Kw9x+oiTxO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gZhJB2F9iy6FmxvX8SyqZbZ4M5nomLJ55sweLYLeFmKNlVXuX4g39QyJWygTVktxi
         9OxR1w1ydSBoi5qTew5drMKsPV6cT2lCPDxk5msXp29XkKDKx8cBQxkMzOoXoR+zeo
         PPK7LDTAizFwRw/rTsNttnxVIEHxkpEQhNO7v+8QT7s8zDtOdPf96ixtiMBhUvILP0
         r63pglxm6Y7OBB+OX7bDX8oFg22wJ2/hI3kJYkb6p39hlC3FvVkYAoyG2+rgouCL73
         nc7DqlBnuPv36ND4fYSQLCCVuqiyg/7L2dYz/BiczwCi+pyY0hScAXtq+IOhhFQTdi
         9yYijtH2oeWbg==
Received: by mail-ua1-f52.google.com with SMTP id d12so5480102uak.10;
        Sat, 11 Mar 2023 07:15:14 -0800 (PST)
X-Gm-Message-State: AO0yUKWO48Qey0ZNQgrmGYp3ybuv4/Ds8WTbH09a9isFdmKvKqOOnjK6
        00FILDrfA8pYqsuwlYj1Eiq4cxYW4XO6gr+NAw==
X-Google-Smtp-Source: AK7set8bzSrdqy8+6YvY1DEekvcd7XPtfCqoKUDgoIQxF8sLBXDP8W8tOeQonNhJP3Pia6+DI8c59rOwGnTGo0UkVGw=
X-Received: by 2002:a1f:6d42:0:b0:401:b9fd:7053 with SMTP id
 i63-20020a1f6d42000000b00401b9fd7053mr18828740vkc.2.1678547713018; Sat, 11
 Mar 2023 07:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20230310144729.1545943-1-robh@kernel.org> <202303111229.3Uuc8JQV-lkp@intel.com>
In-Reply-To: <202303111229.3Uuc8JQV-lkp@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 11 Mar 2023 09:15:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kE3v+=WptWet=JHp2-FCOFah_YzWHFbbfSH-Wh_0o5A@mail.gmail.com>
Message-ID: <CAL_Jsq+kE3v+=WptWet=JHp2-FCOFah_YzWHFbbfSH-Wh_0o5A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Use of_property_present() for testing DT property presence
To:     kernel test robot <lkp@intel.com>
Cc:     Russell King <linux@armlinux.org.uk>, Helge Deller <deller@gmx.de>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:41=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Rob,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on drm-misc/drm-misc-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/fbdev-=
Use-of_property_present-for-testing-DT-property-presence/20230310-225754
> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
> patch link:    https://lore.kernel.org/r/20230310144729.1545943-1-robh%40=
kernel.org
> patch subject: [PATCH] fbdev: Use of_property_present() for testing DT pr=
operty presence
> config: arm64-randconfig-r032-20230310 (https://download.01.org/0day-ci/a=
rchive/20230311/202303111229.3Uuc8JQV-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 6740=
9911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/c013f4111f36b0b43=
27e7fbf46c0dd93399e9209
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Rob-Herring/fbdev-Use-of_propert=
y_present-for-testing-DT-property-presence/20230310-225754
>         git checkout c013f4111f36b0b4327e7fbf46c0dd93399e9209

Looks like this patch was applied to drm-next which was/is based on
v6.2-rc6. This patch is dependent on a change in v6.3-rc1.

Rob
