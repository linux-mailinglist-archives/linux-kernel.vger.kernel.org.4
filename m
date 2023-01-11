Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E0665692
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjAKIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbjAKIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:54:07 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187F10B50
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:53:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bn26so14339046wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7ZKXxds+m1ToRjFrL/N+aqre1KgGndrtfTN0CIit8s=;
        b=XHHHDrQhKlGvPWmc4XNnEMGxL98utCEbip/4LCI7ljniEym7IpDxUK8BxJ+7p5NdCr
         4BOpTEMGIVYn7IkwE8mgzFcGqFg1zSecStlMS+PktmW8m33h4gAm+RZUtrefkE6Vx2xf
         Jcg+NiTYrourEiRHiJArQCdj6W7BWafOq7hXvEMM5/qUS35Jm3Rqlkq3rdPlbYEFFNBz
         lZlf/JqEhvL18r7/2/CuShLPEjQJg5sDuCo/MKJJbg6fdJZu7mDdufy4gGcZkkD1RQY4
         bJnQA3fHLd9aA6qiurp3X5RAdNMmaJXv/ipWIDgC/PPbGbPoAgdL9z90gOMEuVCnlr5L
         A9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7ZKXxds+m1ToRjFrL/N+aqre1KgGndrtfTN0CIit8s=;
        b=TaP/guzPjy6Oizvriw028XQBAVOnWqz3zJhccXv6vop3lI94+hm7+ShQCtkJtDkxK6
         lMplj6gUqZlP/yLrxtonXZ0jZGPYi7TMMfTFCJm+65Sx//jx3otkWBp2sqoZjGKtfaTQ
         m8YNBz7KvrWOWmPfD2bFB9RBSrK5uu8V1e2XhPezPtpR4JazCo2fY+r530qf82PkavQ/
         Uk5agfpVcba4pYfjnOBtlCFZ9UpRqCHi37w7E1mJ47WTVEYJLN1eFuLvf2cfYcIut6s8
         QufIjdLyMwFCNxBJMzh+05WXIfYPKsW7ooFMNNH/rD5bumyC0D1d10/5OZc4R7j6/ogp
         wbZQ==
X-Gm-Message-State: AFqh2kq1Fdu8jy55UbjzvyETexuc+Lj3xfmt/sqMuDXJZHArBh9ZuUKI
        mix4LESiM0ELvezG66vSLWfpeQ==
X-Google-Smtp-Source: AMrXdXtSvUw/ROl85qcQG2OnoAkmXrr7Fjq3EFgsOO+Fd8GkN3u1UpW6ueKal3JQWBwXt4G8jDGyrA==
X-Received: by 2002:a5d:6e8c:0:b0:26b:e7e1:ad03 with SMTP id k12-20020a5d6e8c000000b0026be7e1ad03mr44564208wrz.55.1673427231254;
        Wed, 11 Jan 2023 00:53:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm13442872wrj.94.2023.01.11.00.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 00:53:50 -0800 (PST)
Message-ID: <1301a59a-9085-c7f5-bc1c-ce09766806a1@linaro.org>
Date:   Wed, 11 Jan 2023 09:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V9 4/5] ASoC: codecs: Aw883xx chip register file, data
 type file and Kconfig Makefile
To:     wangweidong.a@awinic.com, lkp@intel.com
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
        tiwai@suse.com, yangxiaohua@everest-semi.com,
        yijiangtao@awinic.com, zhaolei@awinic.com
References: <202301100233.QuEJ8pyu-lkp@intel.com>
 <20230111020233.4306-1-wangweidong.a@awinic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230111020233.4306-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 03:02, wangweidong.a@awinic.com wrote:
> On 09/01/2023 03:00, kernel test robot wrote:
>> Hi,
> 
>> Thank you for the patch! Yet something to improve:
> 
>> [auto build test ERROR on 1f5abbd77e2c1787e74b7c2caffac97def78ba52]
> 
>> url:    https://github.com/intel-lab-lkp/linux/commits/wangweidong-a-awinic-com/ASoC-codecs-Add-i2c-and-codec-registration-for-aw883xx-and-their-associated-operation-functions/20230106-113130
>> base:   1f5abbd77e2c1787e74b7c2caffac97def78ba52
>> patch link:    https://lore.kernel.org/r/20230106032835.141918-5-wangweidong.a%40awinic.com
>> patch subject: [PATCH V9 4/5] ASoC: codecs: Aw883xx chip register file, data type file and Kconfig Makefile
>> config: arm64-randconfig-r034-20230109
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 8d9828ef5aa9688500657d36cd2aefbe12bbd162)
>> reproduce (this is a W=1 build):
>>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>        chmod +x ~/bin/make.cross
>>        # install arm64 cross compiling tool for clang build
>>        # apt-get install binutils-aarch64-linux-gnu
>>        # https://github.com/intel-lab-lkp/linux/commit/63bed80c0eacb29f78eb53987b34863bafd48cee
>>        git remote add linux-review https://github.com/intel-lab-lkp/linux
>>        git fetch --no-tags linux-review wangweidong-a-awinic-com/ASoC-codecs-Add-i2c-and-codec-registration-for-aw883xx-and-their-associated-operation-functions/20230106-113130
>>        git checkout 63bed80c0eacb29f78eb53987b34863bafd48cee
>>        # save the config file
>>        mkdir build_dir && cp config build_dir/.config
>>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
> 
>> All errors (new ones prefixed by >>):
> 
>>>> ld.lld: error: undefined symbol: crc8_populate_lsb
>>   >>> referenced by aw883xx_bin_parse.c:1049 (sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:1049)
>>   >>>               vmlinux.o:(aw883xx_dev_load_acf_check)
>> --
>>>> ld.lld: error: undefined symbol: crc8
>>   >>> referenced by aw883xx_bin_parse.c:963 (sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:963)
>>   >>>               vmlinux.o:(aw883xx_dev_load_acf_check)
>>   >>> referenced by aw883xx_bin_parse.c:1022 (sound/soc/codecs/aw883xx/aw883xx_bin_parse.c:1022)
>>   >>>               vmlinux.o:(aw883xx_dev_load_acf_check)
>>   >>> did you mean: crc4
>>   >>> defined in: vmlinux.o
> 
> This looks like a false positive. crc8_populate_lsb is defined in the lib/crc8.c file.
> I also could not reproduce it with GCC.

kernel test robot almost does not report false positives, at least not
in such obvious cases. Chances you get here false positive are so small
(although possible), that it is much, much more likely your code needs
fixing.

Best regards,
Krzysztof

