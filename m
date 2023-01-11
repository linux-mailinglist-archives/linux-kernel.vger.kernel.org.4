Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756E2665173
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjAKCC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjAKCC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:02:57 -0500
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56516EE0E;
        Tue, 10 Jan 2023 18:02:52 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07457647|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00142299-6.55096e-05-0.998511;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=29;RT=29;SR=0;TI=SMTPD_---.Qpjh-Tl_1673402554;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Qpjh-Tl_1673402554)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 10:02:46 +0800
From:   wangweidong.a@awinic.com
To:     lkp@intel.com
Cc:     13691752556@139.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, cezary.rojewski@intel.com,
        ckeepax@opensource.cirrus.com, daniel.beer@igorinstitute.com,
        devicetree@vger.kernel.org, flatmax@flatmax.com,
        james.schulman@cirrus.com, jonathan.albrieux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        povik+lin@cutebit.org, rf@opensource.cirrus.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, steve@sk2.org,
        tiwai@suse.com, wangweidong.a@awinic.com,
        yangxiaohua@everest-semi.com, yijiangtao@awinic.com,
        zhaolei@awinic.com
Subject: Re: [PATCH V9 4/5] ASoC: codecs: Aw883xx chip register file, data type file and Kconfig Makefile
Date:   Wed, 11 Jan 2023 10:02:33 +0800
Message-Id: <20230111020233.4306-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <202301100233.QuEJ8pyu-lkp@intel.com>
References: <202301100233.QuEJ8pyu-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 03:00, kernel test robot wrote:
> Hi,

> Thank you for the patch! Yet something to improve:

> [auto build test ERROR on 1f5abbd77e2c1787e74b7c2caffac97def78ba52]

> url:    https://github.com/intel-lab-lkp/linux/commits/wangweidong-a-awinic-com/ASoC-codecs-Add-i2c-and-codec-registration-for-aw883xx-and-their-associated-operation-functions/20230106-113130
> base:   1f5abbd77e2c1787e74b7c2caffac97def78ba52
> patch link:    https://lore.kernel.org/r/20230106032835.141918-5-wangweidong.a%40awinic.com
> patch subject: [PATCH V9 4/5] ASoC: codecs: Aw883xx chip register file, data type file and Kconfig Makefile
> config: arm64-randconfig-r034-20230109
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 8d9828ef5aa9688500657d36cd2aefbe12bbd162)
> reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # install arm64 cross compiling tool for clang build
>        # apt-get install binutils-aarch64-linux-gnu
>        # https://github.com/intel-lab-lkp/linux/commit/63bed80c0eacb29f78eb53987b34863bafd48cee
>        git remote add linux-review https://github.com/intel-lab-lkp/linux
>        git fetch --no-tags linux-review wangweidong-a-awinic-com/ASoC-codecs-Add-i2c-and-codec-registration-for-aw883xx-and-their-associated-operation-functions/20230106-113130
>        git checkout 63bed80c0eacb29f78eb53987b34863bafd48cee
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

> All errors (new ones prefixed by >>):

> >> ld.lld: error: undefined symbol: crc8_populate_lsb
>   >>> referenced by aw883xx_bin_parse.c:1049 (sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:1049)
>   >>>               vmlinux.o:(aw883xx_dev_load_acf_check)
> --
> >> ld.lld: error: undefined symbol: crc8
>   >>> referenced by aw883xx_bin_parse.c:963 (sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:963)
>   >>>               vmlinux.o:(aw883xx_dev_load_acf_check)
>   >>> referenced by aw883xx_bin_parse.c:1022 (sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:1022)
>   >>>               vmlinux.o:(aw883xx_dev_load_acf_check)
>   >>> did you mean: crc4
>   >>> defined in: vmlinux.o

This looks like a false positive. crc8_populate_lsb is defined in the lib/crc8.c file.
I also could not reproduce it with GCC.

Best regards,
Weidong Wang
