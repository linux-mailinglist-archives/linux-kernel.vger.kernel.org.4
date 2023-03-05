Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744FE6AAFDA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCENKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCENKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:10:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31457F973;
        Sun,  5 Mar 2023 05:10:41 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so9328360lfc.6;
        Sun, 05 Mar 2023 05:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678021839;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZpGpbya4cC8VQNzo8570FkIU7Kuap43WsN/Qj+Dn38=;
        b=SiGcrmp1QVUlYYXHcGQo1auWNJ4RbclHtoCVFS1QU9xBmFvhoP9///wXHSA08aOcDH
         dvKW3YDvqHD7rQKQPCcZ02ADkZdrwxDlTcEouYspQ50U4ar/paW75tPkB77Ywy/23rnR
         J4yvagX1vdBFAUgjdSCMXxIib1uWXpEYJCYkExfJ2pGWQeaNfiVOfkWPYtlcykfPVfBW
         p/UH4Q27PW2DdrxYt4aab5AwP28Ig9cDyYJTQtmsKQRX13geY70iQaSQMfY/I+p+y83e
         2LGEXTcLHb/R2VRN8OnFZ5yj7vCCtAnuW7OUMsRswPpdvlf06jU6g6Icf137Tn0GZ061
         y1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678021839;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZpGpbya4cC8VQNzo8570FkIU7Kuap43WsN/Qj+Dn38=;
        b=oQkePdxUemEv6ofIeWW9vDF8WVGi38THB+Hl3BtZXNpzhZWaj91UOFUB4eivtTHTkX
         uJSkKfAFZ64cMAHdFcTy5c2S0/qqj1wlRSeLJZH32p9HXdkyRgGr4ocidFP4yucPdK1U
         D+GAylZ4OBVpUZX5Uz5Edtzi9t0r/PR1zpXs7rHdDyGcez+5tR709AY2rZ2ExOv4DyW6
         jheDnPOaY9IL0GWKcTqYqrsZjt/QMxeYaF18NZJXvwi3MPV69IAtjTYldk2u7hqEWonn
         24OP2HeeRiGouXGQe5NxI4zvdXXppxE/oCA/Z5DUsXUwg1L+0CBBbu02cZ9L+HHJXkYc
         kpqA==
X-Gm-Message-State: AO0yUKV/R7nZxPhs9PGVl5qqLTpLrBllIDu4GHCdrkAy8dbuwuP1BWdP
        lcYE26f0SJElY4+7hEB8izQ=
X-Google-Smtp-Source: AK7set/L14bynE66l+B6jQavDAeILUdr9LlxkHmhCyTnL9Yo/cFSswGu6Qf2GgmEKSBnZsnoaIHdSg==
X-Received: by 2002:a05:6512:20f:b0:4dd:995b:feaa with SMTP id a15-20020a056512020f00b004dd995bfeaamr1944786lfo.24.1678021839417;
        Sun, 05 Mar 2023 05:10:39 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004dc4cb4f9c4sm1195561lfl.35.2023.03.05.05.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 05:10:39 -0800 (PST)
Message-ID: <4beef812-8f4f-3857-c814-efd9173d49e6@gmail.com>
Date:   Sun, 5 Mar 2023 15:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
 <20230304201720.2d554f07@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
In-Reply-To: <20230304201720.2d554f07@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/23 22:17, Jonathan Cameron wrote:
> On Thu, 2 Mar 2023 12:58:59 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> As per other branch of the thread.
> 
> 	ch0 = max(1, le16_to_cpu(res[0]);
>  > would be cleaner.

I tried this out. Comparing u16 to literal 1 results comparison of 
values with different sizes:

./include/linux/minmax.h:20:28: warning: comparison of distinct pointer 
types lacks a cast
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                             ^
./include/linux/minmax.h:26:4: note: in expansion of macro ‘__typecheck’
    (__typecheck(x, y) && __no_side_effects(x, y))
     ^~~~~~~~~~~
./include/linux/minmax.h:36:24: note: in expansion of macro ‘__safe_cmp’
   __builtin_choose_expr(__safe_cmp(x, y), \
                         ^~~~~~~~~~
./include/linux/minmax.h:74:19: note: in expansion of macro ‘__careful_cmp’
  #define max(x, y) __careful_cmp(x, y, >)
                    ^~~~~~~~~~~~~
drivers/iio/light/rohm-bu27034.c:1057:8: note: in expansion of macro ‘max’
   ch0 = max(1, ch0);


I could work around this by doing:

const u16 min_ch_val = 1;

...

ch0 = max(min_ch_val, le16_to_cpu(res[0]));

but I think that would really be obfuscating the meaning. I assume

ch0 = max((u16)1, le16_to_cpu(res[0]));

might work too - but to me it's pretty ugly.

The more I am looking at this, the stronger I feel we should really just 
write this as it was. Check if res[0] contains the only unsafe data 
"!res[0]" - and if yes, set it to 1. The comment above it will clarify 
it to a reader wondering what happens.

I will leave it like it was in v2 for v3. If you still feel strong about 
it then we need to continue rubbing it.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

