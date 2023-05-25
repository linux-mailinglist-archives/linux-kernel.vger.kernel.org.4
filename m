Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0543C710A55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjEYKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbjEYKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:52:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5290;
        Thu, 25 May 2023 03:52:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d293746e0so2319693b3a.2;
        Thu, 25 May 2023 03:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685011929; x=1687603929;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKxz95HpCbuh/D0m8xyBwXgcATYmLHxvtvHZsmTAjvM=;
        b=MWrsouSOOS/cmfHAbtaBDlA5hu/Zsz8eQpc0ejq/r1lHJ6zWF379v3eijhTI/KVTpS
         1C7+Mciljxexh94Kx57j0geBMnJLzmolaCy026y9US7G8p/pc8tDP4gaZVSg3nQmUFMb
         p5YhDE5Om+Vw35b25srQIuABNbDm+ziiuaseIo2mPO6ROWPkW6HwVKyj5sGXWePXNU7o
         w2ZeKQfs+OykPZX63MPepCJC4yqk/MewWKh8NxfCDfUMDTC84lt1Cpi96jkU22ukBHN9
         CJyDZLXT5XP7ODQyj9PFsd08PcGDBEiyW4SohPSK/SPmau/sPhFcfOkgbpSUuxA4KIgs
         CFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685011929; x=1687603929;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKxz95HpCbuh/D0m8xyBwXgcATYmLHxvtvHZsmTAjvM=;
        b=fYyNxyGUqvLzsIX+Cydtj7t/ziVlz+A04GfeaVq6qr7EJJISkDdwUwkmzPNZNyNEgw
         UG7v4boVGp1RdjbqqapEUIIwE9CqGITlOZgLfhxi5HhFmqXNPa1pJN9H2b7Aith9XKTQ
         be+jo2CRgl9zPD+M/2aZgAzcgdxERb2hmi0Elw1tatxTCFhMTSwm+Tgh0ZZcEWYouYWD
         53WRyIChzrVIMJOZI50nIk49uLoecuhVb/W5i7SicDZOl3CBiZrjLJg1N8kwql8jMuMu
         QSaYynoq7v1WiDf5ll8GVINsPcHY0Q4qz18mWmmNyTKC+pyx/e5REKILWyk0y7/wa8gD
         ciqA==
X-Gm-Message-State: AC+VfDwkfmxgSnxWQjFdM0fN718bphre0P0VKsE8Q4PKdn4BT6RkuGcy
        8/RIQU58RpYdaZQq/7XiA1uATVxVwhM=
X-Google-Smtp-Source: ACHHUZ4t3SiYOJoolZUCHAT1XgTAYYbV/XtXlsKSF3tKEyR9blhYcZ1CFakdTFQ200+G0aZdshBR9g==
X-Received: by 2002:a05:6a20:8413:b0:10c:5ff4:8bb9 with SMTP id c19-20020a056a20841300b0010c5ff48bb9mr10574335pzd.58.1685011928691;
        Thu, 25 May 2023 03:52:08 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id 18-20020a630012000000b0052c9d1533b6sm905392pga.56.2023.05.25.03.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 03:52:08 -0700 (PDT)
Message-ID: <e8f93560-a2f6-8e9f-031a-88d333482a31@gmail.com>
Date:   Thu, 25 May 2023 17:52:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: absent both plymouth, and video= on linu lines, vtty[1-6]
 framebuffers produce vast raster right and bottom borders on the larger
 resolution of two displays
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Framebuffer <linux-fbdev@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Nouveau/NVIDIA <nouveau@lists.freedesktop.org>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Antonino Daplas <adaplas@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Felix Miata <mrmazda@earthlink.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Original Summary:
> absent both plymouth, and video= on linu lines, vtty[1-6] framebuffers produce vast raster right and bottom borders on the larger resolution of two displays
> 
> To reproduce:
> 1-connect two unequal native resolution displays to a Tesla or Firmi GPU
> 2-don't have plymouth in use (I don't ever have it installed, so don't know whether it impacts)
> 3-don't include e.g. video=1440x900@60 directive on Grub's linu lines
> 4-boot Tumbleweed or Fedora 38
> 5-switch to a vtty, e.g. Ctrl-Alt-F3
> 
> Actual behavior:
> 1-Both displays utilize the resolution (same pixel grid) of the lower resolution display
> 2-Lower resolution display behaves as expected (light text on black background)
> 3-Higher resolution display uses same pixels as lower resolution display, with light text on black background, leaving right side and bottom raster instead of black
> 
> Expected behavior:
> 1-Both displays utilize the resolution (same pixel grid) of the lower resolution display
> 2-Lower resolution display behaves as expected
> 3-Entire higher resolution display's background is black instead of portions in raster
> 
> Workaround: add e.g. video=1440x900@60 to Grub's linu lines, which causes both displays to use the same nominal mode on the full display space.
> 
> Typical other linu line options:
> noresume consoleblank=0 net.ifnames=0 ipv6.disable=1 preempt=full mitigations=none
> 
> My Tesla has HDMI and DVI outputs, tested with 1920x1200 and 1680x1050 displays.
> My Fermi has dual DisplayPort, tested with 2560x1440 and 1680x1050 displays.
> Occurs Tumbleweed with 6.3.2 and 6.2.12 kernel-default, and with 6.2.15 on Fedora 38, and (partially with Tesla, right side only) with 6.2.12 and 6.3.3 on Mageia 9.
> Does not occur with 6.1.12 kernel-default on NVidia, or with AMD Caicos (Terascale2) GPU, or with Intel Eaglelake GPU.
> Tested only on legacy booting (no UEFI support).
> Others might describe what I call "raster" as multicolored snow.

See bugzilla for the full thread and attached dmesg.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v6.1.12..v6.2.12
#regzbot title: vast raster right and bottom borders on larger display (two displays with inequal resolution) unless forcing resolution with video= parameter

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
