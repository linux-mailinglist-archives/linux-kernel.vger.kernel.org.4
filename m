Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94D65F720F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiJFXvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJFXvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:51:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4507B60480
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:51:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w191so3477171pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flatmax-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb0bMzq7CzIxn27Bm3qAvEt7vJtMj9Hk4nZZ0L4qohs=;
        b=q4540usMviIDIHmpiRUMzOa910OncxizTkP+E/hL5zNuXzop6odk7tuyzVEDTHNHIX
         X/3uM3TDImpdIbf4DvksZX1syZyFsZK4mB3ANxxnmaqVDlvw1/wVxyOEI0siPqwKhj//
         MhmpNxgQNCEdGkfr95TMowoeyKvNWZ3P/PQorHxYmfj7BdtflyblEDl1m7lL7Jhi68xG
         14UsSIp+a9qRu7OCnaVXbOiV2Lmlvr3FgmmAjn6SB5AnbePu9oqN+FuzvjjsFrf43ntO
         5CD1mkbnRzyAk/OlS3YOZRbiQ7NAowFqbYUOK8b4Jad8rpaydFC3a69hOF6gUYrWiX4m
         o6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb0bMzq7CzIxn27Bm3qAvEt7vJtMj9Hk4nZZ0L4qohs=;
        b=qdEY8ybZwxm2c87lCGmxhpja80qnT5bQBRI83vM7pW7y9/UnRGRocShiP2/FI8Tg9j
         mi47cKPDGkzEZKVXubiojwGFJ2d9diPlTXB8r3TlujG7OpCseAf1IG19nojcVUqfOhI1
         +rI+bOMZKGqNoYA5vekxZowLGtN/ontFzIaT4lQr8xaTXJgUot1oq9QAHQ3UBl8iArQC
         UWR0a3bhvDl4W4ajZBg+j4ZkEu7hS5yRu4pNhdI72aZC7clGhYlyFq2/fGfECPrwLW69
         x1Z2ZYuZJY7Pyej1dAJnmBQk9xCeammNtaAFgmTbLEjWf/DCSkJf1Hockor7deQq3u0k
         ibsA==
X-Gm-Message-State: ACrzQf0m2bD+KDAEaZH83iv/F6FHEexobv6RIGPTTjGgOy7Owym7J02a
        r//GvQ2fzbsRIWdmxUz89bspJw==
X-Google-Smtp-Source: AMsMyM4oijrcSQd/dKg069SIlyyV2cQasyARBrPUoBqyO98yId81kE4Hm2QtLr3/SKm6UV/Hq/309A==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id k17-20020a056a00169100b0053b3f2c3257mr1946901pfc.21.1665100275607;
        Thu, 06 Oct 2022 16:51:15 -0700 (PDT)
Received: from ?IPV6:2406:3400:213:70c0:9df6:7e57:88ce:1bea? ([2406:3400:213:70c0:9df6:7e57:88ce:1bea])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b0017f92246e4dsm176326plg.181.2022.10.06.16.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:51:15 -0700 (PDT)
Message-ID: <4f2e69e1-c9a2-0197-341c-c8c0bc9fda1c@flatmax.com>
Date:   Fri, 7 Oct 2022 10:51:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: sound/soc/codecs/src4xxx-i2c.c:28:34: warning: unused variable
 'src4xxx_of_match'
Content-Language: en-AU
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202210070151.yWxzUNdm-lkp@intel.com>
From:   Matt Flax <flatmax@flatmax.com>
In-Reply-To: <202210070151.yWxzUNdm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can this test system be updated to catch of_match_ptr usage ?

Here is the decleration :

static const struct of_device_id src4xxx_of_match[] = {
     { .compatible = "ti,src4392", },
     { }
};
MODULE_DEVICE_TABLE(of, src4xxx_of_match);

Here is the usage (in the same file) :

static struct i2c_driver src4xxx_i2c_driver = {
     .driver = {
         .name = "src4xxx",
         .of_match_table = of_match_ptr(src4xxx_of_match),


On 7/10/22 04:21, kernel test robot wrote:
> Hi Matt,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   833477fce7a14d43ae4c07f8ddc32fa5119471a2
> commit: 4e6bedd3c396014ba70de2b4c9995c8e024e82b3 ASoC: codecs: add support for the TI SRC4392 codec
> date:   8 weeks ago
> config: hexagon-randconfig-r045-20221006
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e6bedd3c396014ba70de2b4c9995c8e024e82b3
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 4e6bedd3c396014ba70de2b4c9995c8e024e82b3
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash sound/soc/codecs/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> sound/soc/codecs/src4xxx-i2c.c:28:34: warning: unused variable 'src4xxx_of_match' [-Wunused-const-variable]
>     static const struct of_device_id src4xxx_of_match[] = {
>                                      ^
>     1 warning generated.
>
>
> vim +/src4xxx_of_match +28 sound/soc/codecs/src4xxx-i2c.c
>
>      27	
>    > 28	static const struct of_device_id src4xxx_of_match[] = {
>      29		{ .compatible = "ti,src4392", },
>      30		{ }
>      31	};
>      32	MODULE_DEVICE_TABLE(of, src4xxx_of_match);
>      33	
>      34	
>
