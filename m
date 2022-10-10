Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7545FA77E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJJWFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:05:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981C5050E;
        Mon, 10 Oct 2022 15:05:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l28so1759260qtv.4;
        Mon, 10 Oct 2022 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWAsdgnnawBoZ65SH2j/k7iEWFZqWyRw16cN8vo6Ia8=;
        b=ZPl6i0S/+7XnGtMwxV+PbH0Fvbd/Vt8P4qEZbORIWPV+ynjRxst5ReNfb6f15tuO1d
         u7QTyrCmk0qkHyB99zoMBH0pY2tG3j2UX/mcS8qGXsE+PftJlTSk3XT2OZHjFwvQwwXU
         ZuqDwtKVXuvA8yOKPmHR8/7TL8cWLpR4jlCdbupGFpbUYCrgRvrmIa5ngMqr9bRsVB6E
         9eWEf5AXrhdjVILlOglHF2sRSRW4SKXvkZJw9GGOAZYxUAuCd3Gg87At8sQC3HAqCvfQ
         fNO+9GUz13Kv7rpGwVFsXoAu54qmr7IyRU2g4bfckY2/jjOXChaHu4bh/GCjZiX6YX7V
         xhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWAsdgnnawBoZ65SH2j/k7iEWFZqWyRw16cN8vo6Ia8=;
        b=Zkf5GccVUlmdCZ6vqrJo7FKbqSpajayZq4/V5anhxBCx7YPfSdMpZVEn8wAYJqj73T
         PlyK47p3YN2AcF92GVYOmIIMSmVgQ1qKOyqQow0D+ChrfTvhZEuob852TtXorYXv2Bve
         fUmhnlZGaXheLVgefFnWQK/+yzmCxqLhojwcv3evj5Oq6Ud1irNMpkRcTb7lT4yzjX5V
         4AgnaUgk043wmz6nUsGVNBwh3/yupgpGrrv3HdzQPWqjdBPIeV89Jz+AxRgk0CxyGC8a
         BuP2+RnYcidk0z4GN+ZF3YMUYool0sq7hC3PI55utMctnh1KareINwhpMEcLVn+uY8ho
         NL6w==
X-Gm-Message-State: ACrzQf3L3PcURrmaEw9dErrW5j0a72Xjx4A0CJfa5nB41gRbrIDbFZ5d
        duuHwGXJPkESppeMqPDGzDw=
X-Google-Smtp-Source: AMsMyM7l8y4h2T+lQI+ae1q7fEHCrBms1ypVoZ8DTrcYxOtwM5hNUjGgMgjX9qeh1YYtoD/Fvxy5VQ==
X-Received: by 2002:ac8:5cc3:0:b0:35c:e1b3:78c5 with SMTP id s3-20020ac85cc3000000b0035ce1b378c5mr16905606qta.228.1665439532183;
        Mon, 10 Oct 2022 15:05:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u1-20020a05620a0c4100b006cfc4744589sm11455192qki.128.2022.10.10.15.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 15:05:31 -0700 (PDT)
Message-ID: <70991b49-fb31-d220-44a6-5ab6741c8fea@gmail.com>
Date:   Mon, 10 Oct 2022 15:05:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hw_random: bcm2835: use hwrng_msleep() instead of
 cpu_relax()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y0QjkjU4bsOHWFOd@sirena.org.uk>
 <20221010150607.720600-1-Jason@zx2c4.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221010150607.720600-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 08:06, 'Jason A. Donenfeld' via BCM-KERNEL-FEEDBACK-LIST,PDL 
wrote:
> Rather than busy looping, yield back to the scheduler and sleep for a
> bit in the event that there's no data. This should hopefully prevent the
> stalls that Mark reported:
> 
> <6>[    3.362859] Freeing initrd memory: 16196K
> <3>[   23.160131] rcu: INFO: rcu_sched self-detected stall on CPU
> <3>[   23.166057] rcu:  0-....: (2099 ticks this GP) idle=03b4/1/0x40000002 softirq=28/28 fqs=1050
> <4>[   23.174895]       (t=2101 jiffies g=-1147 q=2353 ncpus=4)
> <4>[   23.180203] CPU: 0 PID: 49 Comm: hwrng Not tainted 6.0.0 #1
> <4>[   23.186125] Hardware name: BCM2835
> <4>[   23.189837] PC is at bcm2835_rng_read+0x30/0x6c
> <4>[   23.194709] LR is at hwrng_fillfn+0x71/0xf4
> <4>[   23.199218] pc : [<c07ccdc8>]    lr : [<c07cb841>]    psr: 40000033
> <4>[   23.205840] sp : f093df70  ip : 00000000  fp : 00000000
> <4>[   23.211404] r10: c3c7e800  r9 : 00000000  r8 : c17e6b20
> <4>[   23.216968] r7 : c17e6b64  r6 : c18b0a74  r5 : c07ccd99  r4 : c3f171c0
> <4>[   23.223855] r3 : 000fffff  r2 : 00000040  r1 : c3c7e800  r0 : c3f171c0
> <4>[   23.230743] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> <4>[   23.238426] Control: 50c5387d  Table: 0020406a  DAC: 00000051
> <4>[   23.244519] CPU: 0 PID: 49 Comm: hwrng Not tainted 6.0.0 #1
> 
> Link: https://lore.kernel.org/all/Y0QJLauamRnCDUef@sirena.org.uk/
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
