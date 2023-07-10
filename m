Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC874CC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGJGF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGJGF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:05:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E510D0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:05:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992b2249d82so535548066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688969128; x=1691561128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/5sXBX6w+tx4fzz42BcVYvkT5fYXODw7taXVRoe5E4=;
        b=VZPa7xtNdgB2TAHCpqnZpgTYHg5TAPiEGf5ws0Sz3CMZVM3Z0gXNkTttmrHBn2LAz8
         dTg1/TKtwHNAgu5Vs9xKfyy4yKcVojt+4g1yCBD4+5Ius8IgrZvXKgnPgOf13fyKbZI+
         yDy9qXQ0t6i6IaVXWCCVEQHo0fFEfnqU0BaoEsokcHkl5Lx5akcBrPgehA1pqrXoI0Hk
         7L9xEr25Aw7MGz67Aenl1sHh65VJgJCKwAz5zUEkItpz7AsrwmfAi8Wx8C2YatGfcu9/
         oBVpMGjbGhAJylf1uJzQT5G8CQwTWmxP6g0j7WMjmdFYs5KTXqFQrzsDO28yOLKnpGo4
         XAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688969128; x=1691561128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/5sXBX6w+tx4fzz42BcVYvkT5fYXODw7taXVRoe5E4=;
        b=ixt0jBhVUA+x9vALCIuAF9u8eYnfc63qJYHa/u3u56siXWnWMdpZ+l+jhsYJxOfnA4
         vQ2ipVo89Dmy8NSPdlsqSn6ZXoMVyvxzUAjjliQKJlR0R4JE/BtkExv4qwFjwUDfug/C
         cj/CVu00zhUMRBACHvhGw2xfbdUiqSrJaXDxFNb836suCGhjZ4Tq64BMEMgM8kFuuI1D
         tvuO/ptkEMXmG7AyWjOKCRxjQdV9Amsk9c4YOaGYSNeocr4VVYUE9/fR8q2tpbLJFjKP
         9HKXygGDI7kp7YP2ycRRPU5FutHNwD8vc4ZAfDxnIq3L9z39ry85wNYq17KBhaklSr02
         cVsg==
X-Gm-Message-State: ABy/qLbucLqDNvurXwbQfZXthpiK8MQdQ2jyUIA5wN1uaDbUYfPyf0x6
        RWeL14kRNtKsemeH+2/bcMPIlQ==
X-Google-Smtp-Source: APBJJlEAeqh7WntGsbBW64VEcC+MW9HxtmE6MYzXkcd/We3xh1O8zeXD5iFrXnlmwb8Jb+WPICf/cQ==
X-Received: by 2002:a17:906:7a0f:b0:974:1c98:d2d9 with SMTP id d15-20020a1709067a0f00b009741c98d2d9mr12858788ejo.3.1688969127746;
        Sun, 09 Jul 2023 23:05:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090638cb00b00992b510089asm5639601ejd.84.2023.07.09.23.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 23:05:27 -0700 (PDT)
Message-ID: <6251cf1b-6428-81e5-50b2-d65cd514063a@linaro.org>
Date:   Mon, 10 Jul 2023 08:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, lkp@intel.com, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, robh+dt@kernel.org, krzk@kernel.org,
        conor+dt@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
 <202306202006.FUjZfd9O-lkp@intel.com>
 <TYAPR01MB6201668A86ACD9794B2E3A5C9230A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYAPR01MB6201668A86ACD9794B2E3A5C9230A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 02:16, yuji2.ishikawa@toshiba.co.jp wrote:
>> -----Original Message-----
>> From: kernel test robot <lkp@intel.com>
>> Sent: Tuesday, June 20, 2023 9:58 PM
>> To: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
>> <yuji2.ishikawa@toshiba.co.jp>; Hans Verkuil <hverkuil@xs4all.nl>; Sakari
>> Ailus <sakari.ailus@iki.fi>; Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com>; Mauro Carvalho Chehab
>> <mchehab@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzk@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
>> iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev;
>> linux-media@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
>> Video Input Interface driver
>>
>> Hi Yuji,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on media-tree/master] [also build test ERROR on
>> linus/master sailus-media-tree/streams v6.4-rc7 next-20230620] [If your patch
>> is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:
>> https://github.com/intel-lab-lkp/linux/commits/Yuji-Ishikawa/dt-bindings-me
>> dia-platform-visconti-Add-Toshiba-Visconti-Video-Input-Interface-bindings/20
>> 230620-120839
>> base:   git://linuxtv.org/media_tree.git master
>> patch link:
>> https://lore.kernel.org/r/20230620031111.3776-3-yuji2.ishikawa%40toshiba.co.j
>> p
>> patch subject: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
>> Video Input Interface driver
>> config: x86_64-buildonly-randconfig-r001-20230620
>> (https://download.01.org/0day-ci/archive/20230620/202306202006.FUjZfd9O-l
>> kp@intel.com/config)
>> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git
>> 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>> reproduce:
>> (https://download.01.org/0day-ci/archive/20230620/202306202006.FUjZfd9O-l
>> kp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of the
>> same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes:
>> | https://lore.kernel.org/oe-kbuild-all/202306202006.FUjZfd9O-lkp@intel.
>> | com/
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from <built-in>:1:
>>    In file included from ./usr/include/linux/visconti_viif.h:12:
>>>> usr/include/linux/videodev2.h:2464:20: error: field has incomplete type
>> 'struct timespec'
>>            struct timespec                 timestamp;
>>                                            ^
>>    usr/include/linux/videodev2.h:2464:9: note: forward declaration of 'struct
>> timespec'
>>            struct timespec                 timestamp;
>>                   ^
>>    1 error generated.
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> 
> I could not reproduce the error with the steps had been specified.
> 
> * archived config file didn't compile Visconti VIIF driver (at least, COMPILE_TEST is needed)

That's not true. The config has enabled CONFIG_VIDEO_VISCONTI_VIIF, so
your reproduction steps were not correct (e.g. wrong arch, compiler etc).

> * the error message didn't appear even if I add some options to config file.
> * Environment:
>   * OS: Ubuntu 22.04
>   * compiler: Ubuntu clang version 15.07

Different compilers can have have or not have warnings, but it does not
allow to ignore this warning. You can analyze the code even without
reproducing it, if the reproduction is a problem.

Best regards,
Krzysztof

