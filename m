Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022F6690603
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBILB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBILBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:01:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D7F1A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:00:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hx15so5111230ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEiNvwdsh50/luN7kcdBw0tT4i5v1/6EEunHYjmNZXs=;
        b=Cc5tn2CKinqZh1y6GDQOh3jtJ28lfw2AwbOsVKLtGeveXXSVLDmwew92x9ux+0z56F
         OfAYNU/fNb6jcMpYuzPpdqEP+cy1mUVEFyu9uOmyx9g2lYIp4o9FqtnL+bv04Ojl193D
         BUU/NFJ8GwOYJ8E7P2goc0AceLXUIIbs8jlTxm6w9sRRkXKfV1vviPHYRD543YgiL4Q4
         pivztwB4TrK7gBRgy5u2ivXhVjbx3SNjI2kr+zn2GO8xZ7oLhCjtviVLKl66WkEaViyu
         pujsrnKl/l5Z4xl0Dd1Wm+OgAfj7DVpTK6iyBB+gyKK9YmCSR27IIyhsIaAbHQGoTTLm
         z1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEiNvwdsh50/luN7kcdBw0tT4i5v1/6EEunHYjmNZXs=;
        b=C4QHHfBXDYn+ti0P6rbfk9fITS7uGvu7z3Hv0Z79rP7ZuRAew29T+c64+1PdayKckH
         MmGp8mfZVPFk9eyhV3k4yaNzWsQP3QRQtg4+z3nU6ebUXt7fQyRu2m8QfsW1QL1ZQ+CR
         T8m/Ig7Pmx1D/25/QKOdFUybJZbzNWZvzZcLo6NdpVdNXeqQelwPuEpoB5yGvdhLjHLJ
         OnfAy2b0+67aTyirp9TArwlz11EH192cz6DVCfl4T+TDxbO77PaAKR1CjfKtnx9b2C0K
         ZfNQWSsXcP9vk8Gr0evhOHkzo0/pi5gKIpGHxD6QXyACgoA8ToaCvxrs75RlTt78DtF2
         ct/A==
X-Gm-Message-State: AO0yUKVTIhx0fWYgWrJX2kWc/fks1z/jli5ZZgZkCKORP10yutLV78MR
        iKdDr61pYvZgxKAdW4si2oYFuBlBq6OyyBycWAAL7Q==
X-Google-Smtp-Source: AK7set+RaPbg+SOCzwGndo1Wa91cwrheg38QQCBg99GhoVwyzzAvFtOaofSU6Q5pBzPM0CXKp4JFifhFaFx0rd/k0bs=
X-Received: by 2002:a17:906:ca04:b0:7c0:f45e:22ff with SMTP id
 jt4-20020a170906ca0400b007c0f45e22ffmr2702674ejb.104.1675940443471; Thu, 09
 Feb 2023 03:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20230207130958.608305-2-bchihi@baylibre.com> <202302080018.wNeWiKqz-lkp@intel.com>
In-Reply-To: <202302080018.wNeWiKqz-lkp@intel.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Thu, 9 Feb 2023 12:00:07 +0100
Message-ID: <CAGuA+ori24xtbHnzYXGVSUOiU-T+V=33DPsHnsruGnP5Y_L7ZA@mail.gmail.com>
Subject: Re: [PATCH v13 1/6] thermal: drivers: mediatek: Relocate driver to
 mediatek folder
To:     kernel test robot <lkp@intel.com>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this warning has been fixed by this patch :
https://lore.kernel.org/all/20230113064449.15061-1-rdunlap@infradead.org/

On Tue, Feb 7, 2023 at 5:14 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on a2c81dc59d41e92362ab7d41d0c15471ea50637d]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230207-211351
> base:   a2c81dc59d41e92362ab7d41d0c15471ea50637d
> patch link:    https://lore.kernel.org/r/20230207130958.608305-2-bchihi%40baylibre.com
> patch subject: [PATCH v13 1/6] thermal: drivers: mediatek: Relocate driver to mediatek folder
> config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230208/202302080018.wNeWiKqz-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/0eb89997925c0d7b47bbeee93016146fc660b259
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230207-211351
>         git checkout 0eb89997925c0d7b47bbeee93016146fc660b259
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/thermal/mediatek/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/thermal/mediatek/auxadc_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead
>
>
> vim +562 drivers/thermal/mediatek/auxadc_thermal.c
>
> a4ffe6b52d27f4 drivers/thermal/mtk_thermal.c Michael Kao   2019-02-01  551
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  552  /**
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  553   * raw_to_mcelsius - convert a raw ADC value to mcelsius
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  554   * @mt:     The thermal controller
> 3772bb422072d4 drivers/thermal/mtk_thermal.c Amit Kucheria 2019-11-20  555   * @sensno: sensor number
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  556   * @raw:    raw ADC value
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  557   *
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  558   * This converts the raw ADC value to mcelsius using the SoC specific
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  559   * calibration constants
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  560   */
> 54bf1e5a629dfb drivers/thermal/mtk_thermal.c Henry Yen     2020-04-30  561  static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30 @562  {
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  563      s32 tmp;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  564
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  565      raw &= 0xfff;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  566
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  567      tmp = 203450520 << 3;
> f84514766985d3 drivers/thermal/mtk_thermal.c Michael Kao   2019-02-01  568      tmp /= mt->conf->cali_val + mt->o_slope;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  569      tmp /= 10000 + mt->adc_ge;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  570      tmp *= raw - mt->vts[sensno] - 3350;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  571      tmp >>= 3;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  572
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  573      return mt->degc_cali * 500 - tmp;
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  574  }
> a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  575
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
