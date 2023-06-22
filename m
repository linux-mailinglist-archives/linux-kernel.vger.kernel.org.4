Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AF73A123
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjFVMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFVMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:45:30 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245919A6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:45:29 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-47169fc1a40so2143151e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687437929; x=1690029929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IAa9QbAg6mMlY1K9iZzo0KBKDVgETeE7PvH1uKY77A=;
        b=ncXLWJal2QgP96Sk787g47rL08o41YhaHQkUsKss+1kCC6ddUpEN3L55GGmCxBJq7F
         jhLgPPCkkFrxAovoz0yCGZOurSHBbjZJH7RTzW+o4/SBHJeLrmyEgvRhOG9c7vjH+l1f
         tIh2gE6ytKG8pXPhioIiUFU/Lkjy5DkK5Ql9cI5UUQry8f/0GwgCxeJXcG+HIFEJIayN
         pz139igKWI9WVrCMytz7bSK8HDx7gV5r0ezX23fP4R99kw9787UalhuapCb+AsqCn5mi
         WVQ8HPq8DJx0GHz5crnpzn51ahg5tzD/M6mR3ElNs3vw9LF8DwH8fy6plHGKinBHQH9V
         yanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437929; x=1690029929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IAa9QbAg6mMlY1K9iZzo0KBKDVgETeE7PvH1uKY77A=;
        b=Kdh6gPhMcsitCWFMUUkB1fNRnBNQMICzeM7BNxmqjC52dqorLYkTm9wcrRfdPXKhRD
         nOakQiD46w33Ki/Uhlw8nL0jeTreQshI5DrsCQvxp4Pz4GXUCZSDnd3q576tQYSbX9Ss
         LSgf52A9I0gJtBXCUiJbVzFv63voRugck2Rx2Ciw2x3e3YWYXGAoGGNz1q8PPP43SC55
         6skU1QG9oNgFAEc7RtOteD42sklLpaGip2I5AppSMzNE/iXT8xezsVJGmV4Z3D/ByRp+
         A2EJPpEISTW2rBlo0wsT4GlN6Z40AZbup9J/jDWzaUNmfcjq0fVt90/sg8FZuWcxjkZy
         v/xw==
X-Gm-Message-State: AC+VfDwt01EQrr401g9TBAfMTqlnpLpj8ZByb/HzJlriISKiSkQcdpg6
        YwYnfbLjzcosPht2XZvYVe57tziqjPuh4ewB+FdFrQ==
X-Google-Smtp-Source: ACHHUZ5/jzxo/ijO8rlAjptGql3tzGDgmPaiskSoOAANtplM754UorQOZnV5cX2QhyZ4FbjKszM2FRZhAFgxM5gtNns=
X-Received: by 2002:a1f:d103:0:b0:471:5cb5:11f8 with SMTP id
 i3-20020a1fd103000000b004715cb511f8mr7797350vkg.15.1687437928832; Thu, 22 Jun
 2023 05:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230621153650.440350-9-brgl@bgdev.pl> <202306221025.K6fKRmj7-lkp@intel.com>
In-Reply-To: <202306221025.K6fKRmj7-lkp@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 22 Jun 2023 14:45:17 +0200
Message-ID: <CAMRc=MeWBh-uWDJTLwg5uzE=-Q2jTnSg4Gw9ogh-9N+WUntSwg@mail.gmail.com>
Subject: Re: [PATCH net-next 08/11] net: stmmac: platform: provide devm_stmmac_probe_config_dt()
To:     kernel test robot <lkp@intel.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 4:49=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/net-stmmac-platform-provide-stmmac_pltfr_init/20230621-234133
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230621153650.440350-9-brgl%40b=
gdev.pl
> patch subject: [PATCH net-next 08/11] net: stmmac: platform: provide devm=
_stmmac_probe_config_dt()
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230622/20=
2306221025.K6fKRmj7-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221025=
.K6fKRmj7-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306221025.K6fKRmj7-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: vmlinux.o: in function `__ksymtab_devm_stmmac_probe_config_dt':
> >> stmmac_platform.c:(___ksymtab_gpl+devm_stmmac_probe_config_dt+0x0): un=
defined reference to `devm_stmmac_probe_config_dt'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I added the missing stub for !CONFIG_OF to v2.

Bart
