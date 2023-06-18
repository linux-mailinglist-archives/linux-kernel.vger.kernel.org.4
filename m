Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C5D734759
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFRRnD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 18 Jun 2023 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:43:01 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05F1BF;
        Sun, 18 Jun 2023 10:43:00 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-570114e1feaso34071417b3.3;
        Sun, 18 Jun 2023 10:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687110179; x=1689702179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLpx9nbtGApdAP3oWuubaSztjg6fg3+1+MFFJiCzVks=;
        b=UuSOFhDN3AXPVa9A169V+3aNaU1UZoOiKTeUplT83KwkewbICliUELFj1HrE8Va5cd
         3QQR1hqXg8OeOHxZ2xpl6L7agJ2bH0JFmUrIxsJNj2H4fw5jDDymbderuen0tSqE2ep2
         Iz4bXKhnZQSnBBvKq6chPqO6uobkMYyaSk6AfPyuJaCjPsBjHOxO5wKsdmT9u5dBrGva
         gF1Z3Tlsa1w8VpTypZuRG9i+f6hz1V6RZrJLwPLAqcbgknZnL4om++Bct4jvoo5hQinF
         UCkrq4wphI6nlz7Goe9CWKOErLMzDDPPZXCoe4O5NzwDrcFb//9U/1y3PDDBHvLagyqS
         wJ+w==
X-Gm-Message-State: AC+VfDxWrE+Wq/4nQu/EHS8SYoB/NZNQaqEgSdSAAVAMk72N4ZHGdUVM
        hbzwn5bZ37kKlAhbA/1dAqQNzsRH+dmznM+J
X-Google-Smtp-Source: ACHHUZ50wFH3Gg4eWi5NnP7Se5q70MRkKrqZ6QFbz5WhYG7VuCS6xaItJDKw7heJ9UxYmHasfarwNA==
X-Received: by 2002:a0d:d4cb:0:b0:570:77b3:1c78 with SMTP id w194-20020a0dd4cb000000b0057077b31c78mr7263165ywd.25.1687110179316;
        Sun, 18 Jun 2023 10:42:59 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j62-20020a819241000000b0056d2d227c37sm1774587ywg.83.2023.06.18.10.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 10:42:58 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-57012b2973eso34088467b3.2;
        Sun, 18 Jun 2023 10:42:58 -0700 (PDT)
X-Received: by 2002:a81:a0d3:0:b0:56c:ff9d:8cd9 with SMTP id
 x202-20020a81a0d3000000b0056cff9d8cd9mr8570801ywg.7.1687110178437; Sun, 18
 Jun 2023 10:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230615182938.18487-4-tanure@linux.com> <202306161946.Kk7xeos8-lkp@intel.com>
In-Reply-To: <202306161946.Kk7xeos8-lkp@intel.com>
Reply-To: tanure@linux.com
From:   Lucas Tanure <tanure@linux.com>
Date:   Sun, 18 Jun 2023 18:42:47 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+2Jr4CHHbzy+d5wNgrEsU__EFQr_y0PZvLdb-uEp+H6eA@mail.gmail.com>
Message-ID: <CAJX_Q+2Jr4CHHbzy+d5wNgrEsU__EFQr_y0PZvLdb-uEp+H6eA@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: meson: t7: add peripheral clock controller
To:     kernel test robot <lkp@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oe-kbuild-all@lists.linux.dev, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:23 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Lucas,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on clk/clk-next tty/tty-testing tty/tty-next tty/tty-linus krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.4-rc6 next-20230616]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Tanure/dt-bindings-arm-amlogic-add-Amlogic-T7-based-Khadas-VIM4-bindings/20230616-023038
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20230615182938.18487-4-tanure%40linux.com
> patch subject: [PATCH 3/6] clk: meson: t7: add peripheral clock controller
> config: arm64-buildonly-randconfig-r004-20230615 (https://download.01.org/0day-ci/archive/20230616/202306161946.Kk7xeos8-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230616/202306161946.Kk7xeos8-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306161946.Kk7xeos8-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/clk/meson/t7.c:7084:51: warning: initialized field overwritten [-Woverride-init]
>     7084 |                 [CLKID_VID_PLL]                 = &t7_vid_pll.hw,
>          |                                                   ^
>    drivers/clk/meson/t7.c:7084:51: note: (near initialization for 't7_hw_onecell_data.hws[93]')
>    drivers/clk/meson/t7.c: In function 'meson_t7_probe':
> >> drivers/clk/meson/t7.c:7946:36: warning: variable 'mclk_data' set but not used [-Wunused-but-set-variable]
>     7946 |         struct meson_clk_pll_data *mclk_data;
>          |                                    ^~~~~~~~~
>    drivers/clk/meson/t7.c: At top level:
>    drivers/clk/meson/t7.c:689:37: warning: 't7_a73_dyn_clk_sel' defined but not used [-Wunused-const-variable=]
>      689 | static const struct clk_parent_data t7_a73_dyn_clk_sel[] = {
>          |                                     ^~~~~~~~~~~~~~~~~~
>    drivers/clk/meson/t7.c:93:29: warning: 'meson_pll_clk_no_ops' defined but not used [-Wunused-const-variable=]
>       93 | static const struct clk_ops meson_pll_clk_no_ops = {};
>          |                             ^~~~~~~~~~~~~~~~~~~~
>
>
> vim +/mclk_data +7946 drivers/clk/meson/t7.c
>
>   7939
>   7940  static int __ref meson_t7_probe(struct platform_device *pdev)
>   7941  {
>   7942          struct device *dev = &pdev->dev;
>   7943          struct regmap *basic_map;
>   7944          struct regmap *pll_map;
>   7945          struct regmap *cpu_clk_map;
> > 7946          struct meson_clk_pll_data *mclk_data;
>   7947          int ret, i;
>   7948
>   7949          /* Get regmap for different clock area */
>   7950          basic_map = t7_regmap_resource(dev, "basic");
>   7951          if (IS_ERR(basic_map)) {
>   7952                  dev_err(dev, "basic clk registers not found\n");
>   7953                  return PTR_ERR(basic_map);
>   7954          }
>   7955
>   7956          pll_map = t7_regmap_resource(dev, "pll");
>   7957          if (IS_ERR(pll_map)) {
>   7958                  dev_err(dev, "pll clk registers not found\n");
>   7959                  return PTR_ERR(pll_map);
>   7960          }
>   7961
>   7962          cpu_clk_map = t7_regmap_resource(dev, "cpu_clk");
>   7963          if (IS_ERR(cpu_clk_map)) {
>   7964                  dev_err(dev, "cpu clk registers not found\n");
>   7965                  return PTR_ERR(cpu_clk_map);
>   7966          }
>   7967
>   7968          /* Populate regmap for the regmap backed clocks */
>   7969          for (i = 0; i < ARRAY_SIZE(t7_clk_regmaps); i++)
>   7970                  t7_clk_regmaps[i]->map = basic_map;
>   7971
>   7972          for (i = 0; i < ARRAY_SIZE(t7_cpu_clk_regmaps); i++)
>   7973                  t7_cpu_clk_regmaps[i]->map = cpu_clk_map;
>   7974
>   7975          for (i = 0; i < ARRAY_SIZE(t7_pll_clk_regmaps); i++)
>   7976                  t7_pll_clk_regmaps[i]->map = pll_map;
>   7977          regmap_write(pll_map, ANACTRL_MPLL_CTRL0, 0x00000543);
>   7978
>   7979          mclk_data = t7_mclk_pll_dco.data;
>   7980
>   7981          for (i = 0; i < t7_hw_onecell_data.num; i++) {
>   7982                  /* array might be sparse */
>   7983                  if (!t7_hw_onecell_data.hws[i])
>   7984                          continue;
>   7985
>   7986                  ret = devm_clk_hw_register(dev, t7_hw_onecell_data.hws[i]);
>   7987                  if (ret) {
>   7988                          dev_err(dev, "Clock registration failed\n");
>   7989                          return ret;
>   7990                  }
>   7991          }
>   7992          meson_t7_dvfs_setup(pdev);
>   7993
>   7994
>   7995          return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &t7_hw_onecell_data);
>   7996  }
>   7997
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I will drop this patch and use the S4 clock driver after it lands.
Thanks
