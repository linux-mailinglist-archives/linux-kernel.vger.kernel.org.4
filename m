Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8561E1F7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiKFMEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKFMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:04:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A1C770;
        Sun,  6 Nov 2022 04:04:16 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e129so8143937pgc.9;
        Sun, 06 Nov 2022 04:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WHoM4Iu4fJxp7HgcJoBzK0BlZg2s5EfrY+4N37pGSY=;
        b=Dgepef9Ywlk+Bne97k4KA0Ls1tS+uiI7lvEMTzRG45yu5TaYWrohbVnbOb6yw9Vx+B
         HnvuocWSr6F+xShFbxHBZTJki9hNrS+1n3dkTjUPgE8jRCkJmgoiZgxZ7LtyFO6QQkfF
         KOFdpJziTjOl8ub7InvS3lJjaBdCvIppAVbPgOCE5F6wuPXjWVDcTRxgeI72BdMyM90T
         /9cox17jsFfvAPfTuDllejwMwf5867E6hB+6LV4qXNBC4nNHpw1IGQ0kEeTeBo36L6XA
         ntzh6z5P1Znw5CwEZfIlFPndvJuLCwWQrY8eKKEZup9PSdGN1boS29vlSeNy0bQgjZOH
         lIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WHoM4Iu4fJxp7HgcJoBzK0BlZg2s5EfrY+4N37pGSY=;
        b=df2g8HbSqNzO0X3jJtAHbdqyYMPfssuih8UJZreoXJrJ9vvUTnRaVhMvnSaeunVzrD
         cGkKL5bFUBUnaxP3rI8kJDtD6yJjj9xajNBoQn/EsAp7c69fZg1vxezkabUReBjXsyWh
         5srvESzjn7MC+wd/Dy0Ulcj4vA3/dkxYxKx1yUoP2906yMQ123nFD374D7akLGnO8p2U
         Ye3sgGW6o+zTO7EPfjLOL5omz6cCKIQ1O/vqG2754udW2ICfHKsBSjFoOdcLaqDqWM9P
         T0Y1+RCO/MvXU0ksXswPhn8ualItE2cmsJhGyLoU6SBw0f/zDv2P5AY12tX5CF/kBLb9
         xoPQ==
X-Gm-Message-State: ACrzQf23f4IU3aD8VUSs01W/sTS0dyvuhEwpq9Zw8hwzy0WH+uC09Hq2
        PM2jyHi0uAsUIWu25+RcL3I=
X-Google-Smtp-Source: AMsMyM7KMlfHuBbOBAmRlK/2wwFT5NvjeQ+Gnze8bJIrH/qSzi9yTEp+tAwE1ocYNzW9o6nxzhkapQ==
X-Received: by 2002:a63:6c8a:0:b0:46f:c6e0:8ee9 with SMTP id h132-20020a636c8a000000b0046fc6e08ee9mr29630094pgc.493.1667736255755;
        Sun, 06 Nov 2022 04:04:15 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902c40500b001886ff822ffsm2993075plk.186.2022.11.06.04.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 04:04:15 -0800 (PST)
Message-ID: <07e0949f-fa9f-e4f8-2891-aaf9f84ede7c@gmail.com>
Date:   Sun, 6 Nov 2022 21:04:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     alexandre.ghiti@canonical.com, aou@eecs.berkeley.edu,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221106100239.53704-1-bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: riscv: tableize memory layout
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221106100239.53704-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Sun,  6 Nov 2022 17:02:40 +0700, Bagas Sanjaya wrote:
> The memory layout is written as table but it is inside literal code
> block, which renders as preformatted text. Write the layout in reST
> grid table instead.

What's the purpose of this change?

The tables in html/pdf output after this change are almost unreadable
to my eyes due to the proportional font and random wrapping inside
table columns.

I think in this particular case, "literal block" is the right
choice at least for html output, as can be seen at:

   https://www.kernel.org/doc/html/latest/riscv/vm-layout.html
   https://www.kernel.org/doc/html/next/riscv/vm-layout.html

Yes, these very wide tables need horizontal scrolling in the alabaster
theme (in next), but they look much nicer than your version.

In pdf output, wide literal blocks are force-wrapped and don't look good.
Using some smaller font size for latex might help, but most people don't
care much of pdf outputs anyway, I guess.

        Thanks, Akira
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/riscv/vm-layout.rst | 120 +++++++++++++++---------------
>  1 file changed, 58 insertions(+), 62 deletions(-)
