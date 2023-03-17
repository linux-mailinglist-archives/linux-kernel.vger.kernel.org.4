Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B946BE145
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCQGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQGae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:30:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7596773C;
        Thu, 16 Mar 2023 23:30:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ix20so4327860plb.3;
        Thu, 16 Mar 2023 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679034632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QowYjOwpVeC+cmhtPU+4JUq/a+8cTteF1DVyYYSO1iY=;
        b=l2WwTVnblFcR+NDGUILKqhkLSo/PPXRbUyCP3ps08M59W/rMYB33ormF3RBDGAs7WE
         L3o95/WlF2oe9GVEtLGtmbXPobglas+d2YGJti8Kpg9N7n6B9sv74E/g33k2OQy3lFQP
         9xfRxOZDwAibCIvDT7nKYUEXxxcUGpewRLGEfDY4mfW8rmjrrJMiS0MskiFU00C8Pc7j
         TS0CQJ9hPdqVKoOb6OS5ZNtbo5X3skRjpif5GRgJU6MX+il0+OE6HtY+bR+RLb5o0t/8
         Ee6MhertRAcox4n7aJxVGqrPsMKLiP8CGT5AqNeiyYiS4rrrOAjiC9oV+fvX6mpWfXym
         rToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679034632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QowYjOwpVeC+cmhtPU+4JUq/a+8cTteF1DVyYYSO1iY=;
        b=zN/X6w5t+SChee6wmbkf5+tPo953gVeHru/YzwGIUmTy9U0fVmsJdlOPUXrVM8Yif/
         cXoJJ00aMDB37av4XQURs7KChfgIt6R47gdrGuxNavEAUpy+iiIE1Hc7WawvumMNxbZe
         hg1UkyJisf+HxZyrgD/17Oi71f2R3X4hJgzyzyWtPkLkeZxBv/cqp4pk0LwTOO3ekgid
         ZuBX1OEsm12+Y9UqQnqPlQNneymSNdLiA1gyYeME+7onerKoSJPVi5AOSAjPhb6MMG8x
         Cy+NIwYpkii/lBNAaV2fhr1p2A+7xqyst1g9sa7F7qua/Xj45alrl+Tlk3XMeBco1Dr9
         STQg==
X-Gm-Message-State: AO0yUKXwXPI6/aBnNYFDjknb9BXKjeXPGmYghkCPbt1oSomsyqyAZx5H
        +k09YqU/LNlyi3CZjYp8yms=
X-Google-Smtp-Source: AK7set/jCr8RT3wJrihBeThKo6LPb99Ma+fIdEQqKEHJqXbq96VBfVdC2af3+6srNdH8FfiZFXd4QA==
X-Received: by 2002:a17:903:2283:b0:19e:7c33:3722 with SMTP id b3-20020a170903228300b0019e7c333722mr7617579plh.40.1679034632455;
        Thu, 16 Mar 2023 23:30:32 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090276cc00b0019abb539cddsm753773plt.10.2023.03.16.23.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 23:30:32 -0700 (PDT)
Message-ID: <1a1277ac-4ae5-eaab-01c3-0242c12be76b@gmail.com>
Date:   Fri, 17 Mar 2023 14:30:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <f2699aa1-4d8a-48c0-b332-484db0b04252@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/16 下午 10:05, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This patchset adds initial support for the Nuvoton ma35d1 SoC, including
>> initial device tree, clock driver, reset driver, and serial driver.
>>
>> This patchset cover letter is based from the initial support for Nuvoton
>> ma35d1 to keep tracking the version history.
>>
>> This patchset had been applied to Linux kernel 6.3-rc2 and tested on the
>> Nuvoton ma35d1 SOM evaluation board.
>>
>> (ma35d1 information:
>> https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
>> MA35D1 porting on linux-5.10.y can be found at:
>> https://github.com/OpenNuvoton/MPU-Family
> Hi Jacky,
>
> Thanks a lot for your submission. I saw this presented at
> EmbeddedWorld yesterday and asked about mainline Linux
> support, but did not expect to see the patches this soon ;-)
>
> The easiest process for getting the series merged is to
> have me add it the entire series to the SoC tree after the
> individual drivers have been reviewed by the respective
> subsystem maintainers that are already on Cc here. When
> the review is complete, you can add soc@kernel.org to Cc,
> so they show up in patchwork, or alternatively send a pull
> request for a git tree to that address. Until then, you
> can add my own email address to Cc so I can follow the
> reviews.
>
> After the initial merge, the normal method for additional
> device drivers is to have them sent for inclusion to the
> subsystem maintainers. The soc tree and soc@kernel.org address
> is then only used for changes in arch/arm64, i.e. updates
> to the dts files, Kconfig, defconfig and MAINTAINERS,
> as well as the drivers/soc and drivers/firmware directories,
> if you have anything in there.
>
> If you have any additional questions about the process,
> feel free to also ask me.
>
>       Arnd

Hi Anrd,

Thank you very much for your kind help. You explained it so well,
I have understood the process. We got a lot of suggestions for this
patchset, and there are a lot of issues to fix. When most of the
problems get solved and acknowledged by the reviewers, I will
add you and soc@kernel.org to Cc.


Best regards,

Jacky Huang

