Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCCE611331
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJ1NmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiJ1Nlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:41:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B11130D64;
        Fri, 28 Oct 2022 06:40:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j7so1080091pjn.5;
        Fri, 28 Oct 2022 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37381ZjzNUNheurS/QoSHme74FvETCXKbgHKbrj1KGQ=;
        b=kpPWRPRK7Q8vibv1p1wC4GSSS3Hp68Sl2p74QNnfmtmThT21ofwWw+TDo9nO+/3WXk
         H6G4T5wGiRbPccDoyDmxLP+XJ9+fgV0l72RySY7K892spBgL9ln8/W/UV6TaI3brAVmU
         b2GPwaLxJcohieoJNHpRTzlFOCOGOxNg7ijY9wofNRvS+7wSURpxucpFpsf7k6VEz5PW
         f5rjeAaNgqhFT5ON1KEAZoaIvFUHknHqKNGxskKbEtls0UasSLR8O9nzBw/qUhhybsuw
         QZuKrDBeY9ikjDr77201NGphlrpLq55zHVy7A5Rao6LXYCVRvzS8/PXVnIiSkWICgeuu
         uMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37381ZjzNUNheurS/QoSHme74FvETCXKbgHKbrj1KGQ=;
        b=v8j8QwA46G2cv50eVu3/ktb96KQKcltM40JCmGI6V44jk8YkqNVlGRhW7xPYtegHYC
         llbgpBVPzVnkacbgxeajsn0hr8U1Gsq9e9ZIeyVqSbKruWntBV6Gt4t4xqqnYi31Amxt
         CIJ+3Lx7+SETZWmAPc3v0avtOcuNvAt0teiRRNcFByqivl2RdMItvYwrtpoHXVMBERFY
         ewcrjfwSkzZmJqw1g7OqobmxJ/FQjOKB861Pc32IpDuQDcELEhSAR0iAnHAwhXsnuJ2c
         6VEWzEcR8zkp2MDKIlPTSKNAGKvWl/M80zyX6j2V/44V8FOY9iW/rUvs9uSi8cTubNdl
         yRNg==
X-Gm-Message-State: ACrzQf1hHkI8qzUbFqeykt5oj+6VBGIHHy+Z6KoZl0pJGNA5W7vTPhoI
        3T8rFcdO4ltHIFsmNB9DgV0=
X-Google-Smtp-Source: AMsMyM6+0hzOtzd03SDLXSOs1lM9cNlH6GES4LBpcnLdhnHN2+gXKjLLsWlef1aoSHLMHosaZi7+FQ==
X-Received: by 2002:a17:902:d510:b0:185:480a:85d3 with SMTP id b16-20020a170902d51000b00185480a85d3mr55576769plg.4.1666964434934;
        Fri, 28 Oct 2022 06:40:34 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b0016d9b101413sm3106773plg.200.2022.10.28.06.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:40:34 -0700 (PDT)
Message-ID: <c806071c-05b9-e2b8-c58b-9d0a6e869f2c@gmail.com>
Date:   Fri, 28 Oct 2022 20:40:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 07/15] MIPS: IP27: clean out sn/nmi.h
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <08c138e14f71c207c4428df9fd31154744be9d98.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <08c138e14f71c207c4428df9fd31154744be9d98.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> Lack of QEMU support makes this unvalidatable without the hardware,
> so leave it in

Shouldn't this say "remove the magic number" instead?

-- 
An old man doll... just what I always wanted! - Clara

