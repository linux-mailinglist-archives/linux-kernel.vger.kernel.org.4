Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF9734976
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjFSAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 20:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSAYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 20:24:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC91E4D;
        Sun, 18 Jun 2023 17:24:40 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b44b5adfd3so1936147a34.3;
        Sun, 18 Jun 2023 17:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687134280; x=1689726280;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEmDS2p8yjBfYlfB/iT3dpocB29HdgNOixmRsTqFoPQ=;
        b=n01n1B1tGlntSnuy4b1JwNT5ifgmjeITHLn0NlkjenDrw+PEQuhDsEKetwZmQAjRLf
         uiC0DCHu4cfleoVBIoAylHp9h8acVV+VAYgFr3zdUk188yMvVFT1XJTdbvBLXtFsWLLj
         lv2xHB2zoFSqwpcLNEZ55g1hOZ0Dn76eHzVDH0cg3oE93MpOEuaQQgO+somBdZixKe3s
         j4dNkUe9I9hhg7l4Ft9pK3VYgU1cIkKvmQvKP6NBXBShvIa8gKB9qT6yK6HU7tYwv6vJ
         STpWZ4ER0kaTXEH7Q68FjzC8gwy2ig7dggl3jZosVAib9tVkliSyPZxboWi+t/1lGIxw
         jiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687134280; x=1689726280;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEmDS2p8yjBfYlfB/iT3dpocB29HdgNOixmRsTqFoPQ=;
        b=F80eFJuN4HH+Q5IstfySpw3mckmpa/j7vMZOmsn+Rigfs5EJVZ/SqZXIJCwYh5UkmP
         7IAwiO9Z8zp6L7u+yjKPdAgpd1mkk427rkLFh7Vt76OAMPfOAwcvZnSdmID1/8V1nwID
         Q38Hw4mzgOb9znO3xOqJemkaHkvqP8xVzyAL3fjYMlhyWG52J55hnB9rgUhhFBZ3F7hj
         YjEPo4K+jqDETfMEuWXRl0DiGFTPMdrhPa176W0P1UVbwFuBJHz7uNZubvpdUdiVCpNu
         nneUV2xrHlMhvd3qB6Hz6m+yVhG0MrxatwOVJ4433dgsoX6ApP7t+OLK6v/C/SpV790C
         l+JQ==
X-Gm-Message-State: AC+VfDwGIBH+PH4XrX2odRzJ57lLIDuhlLfhxeCQWIIpcQgUIKJTSgbx
        cK2hV4Ci/8vuiquk1D0i/A0xmhYSg/4=
X-Google-Smtp-Source: ACHHUZ5o2qY03OHoswZtTdeRjesgO49FTz2FBobZYESYSyBx3gRmEcK2lJYL5q5kz256+OENnWC8fA==
X-Received: by 2002:a05:6358:cd1c:b0:12b:d79a:d433 with SMTP id gv28-20020a056358cd1c00b0012bd79ad433mr4383161rwb.11.1687134279460;
        Sun, 18 Jun 2023 17:24:39 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i25-20020aa787d9000000b0064f51ee5b90sm6335043pfo.62.2023.06.18.17.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 17:24:39 -0700 (PDT)
Message-ID: <a7f997fc-e7cc-cf67-3ac0-80ed30346511@gmail.com>
Date:   Mon, 19 Jun 2023 07:24:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, rouckat@quick.cz,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Media <linux-media@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: in linux 6.3.7-200.fc38.x86_64 goes vlc in time to switch tv
 channels to zombie-process
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> vmlinuz-6.3.7-200.fc38.x86_64  and vmlinuz-6.3.8-200.fc38.x86_64
> 
> in the switch tv channel to another vlc stay blocked and and the loading of firmware newer ending. power must be switch to off.
> from dmesg:
> 
> dvb-tuner-si2141-a10-01.fw
> dvb-demod-si2168-d60-01.fw 
> firmware version: D 6.0.13
> 
> restart of dvb modules is impossible, They stay working. 
> 
> kernel 6.3.5-200.fc38.x86_64 works  OK. I don't how works kernel 6.3.6-200.fc38.x86_64
> 
> this same error is in vmlinuz-6.3.5-200.fc38.x86_64 and earliers but there is the occurence accesptable.
> 
> listing from 6.3.5 kernel:
> 
> [ 3378.026035] si2168 7-0064: firmware version: D 6.0.13
> [ 3431.891579] si2168 7-0064: downloading firmware from file 'dvb-demod-si2168-d60-01.fw'
> [ 3434.037278] usb 1-4: dvb_usb_v2: 2nd usb_bulk_msg() failed=-110
> [ 3434.037289] si2168 7-0064: firmware download failed -110
> [ 3436.085265] usb 1-4: dvb_usb_v2: usb_bulk_msg() failed=-110
> 
> lsmod |grep dvb
> dvb_usb_dvbsky         32768  2
> dvb_usb_v2             57344  1 dvb_usb_dvbsky
> m88ds3103              49152  1 dvb_usb_dvbsky
> dvb_core              192512  3 dvb_usb_v2,m88ds3103,dvb_usb_dvbsky
> m
> 
> modprobe -r dvb_usb_dvbsky
> modprobe: FATAL: Module dvb_usb_dvbsky is in use.
> 
> ?????? The problem in dvb_usb_dvbsky or firmware ?????   
> 
> The answer from https://bugzilla.rpmfusion.org was:
> 
> If it was working with previous kernel this is likely a kernel regression. 
> please forward to the dvb sub-system maintainers.
> 
> this problen insist a long time (years), but not too horible

See Bugzilla for the full thread and attached dmesg and lsusb.

Thorsten: The reporter can't perform bisection for he has problem
compiling his own vanilla kernel (see comment 8 on the Bugzilla
ticket, albeit with translated make(1) output). Can you take a look on
it?

Anyway, I'm adding it to regzbot (as stable-specific regression
for now):

#regzbot introduced: v6.3.5..v6.3.7 https://bugzilla.kernel.org/show_bug.cgi?id=217566
#regzbot title: switching TV channel causes VLC and firmware loading hang

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217566

-- 
An old man doll... just what I always wanted! - Clara
