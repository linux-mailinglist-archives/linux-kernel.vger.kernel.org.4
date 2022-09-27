Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212B5ECA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiI0RLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiI0RL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:11:28 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F05FAF8;
        Tue, 27 Sep 2022 10:11:27 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1280590722dso14137431fac.1;
        Tue, 27 Sep 2022 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date;
        bh=Eck36fJJTiT+wQiJhQKQnZ4pYEaB1HgCdALV1W29Tz0=;
        b=WzYYigLu7MMOXaj2JxEb3hLHWYAvdF/4imM1xh01KladdcGNH3UvOmzx5uiQGd0Yl2
         Ag15zOJ9KY2KCS7afDCxyB54zrt+wo/XIibUZT9mpPjfruD65HvDmUNAuD9fOTGSFZaV
         wh+SdY0rlJ7m2uY7/Qvx+4CyNSV2BUa7kmZv9+5N/354VzSryHRbfRMaJUQaGoA0rO5a
         EJONQZr+RKPmA3Kc6VIED1mozoko3EVU6vEBVUx2WaNO32kizmuipXuxSfc5cbxBqWyD
         M8PAWRpQRYUOyVhI68y9gKMKxeaj0Za+5oU3i4d0HCPc8/C78kqNTI/zZCLumC9Hy4Ni
         G5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Eck36fJJTiT+wQiJhQKQnZ4pYEaB1HgCdALV1W29Tz0=;
        b=F3c4oqQwiHtXWh+1BmHZ/kknDz2g7Rl4Z7FOnF7YbL6Bc/+js4LzFUYrJIhD3aFcqP
         U2j4xcN+83Rg9NpefQrdOFLOeJnOnVcueNxlsiC0gwbuBxbqPpxxWuLPVE656Bf80za/
         Ok+gwMC+OMUmGe950cqhoXlsr3MwXw/HiOL9h9yJX16zG+foS1dDRTYbn2um+kmW3UVd
         BuyK0TunEwD/y6w+S9rdaS9YrSvc0un5B/muAdyFABH2J7FsdRSZcez+SVLHNriGqKow
         iIos8qgSdO1Ar3VOGzz1B6i1ESXy1rlfvnjJij5jF+4eBV+KdJJfcMzOzyDu+T3knK9s
         svFQ==
X-Gm-Message-State: ACrzQf18NUINPThfEGcLmlkyN6LyyWB5eDo5wYy2H3dnVQ23b3phvBZY
        MGdDcKhDpj8ollMPDyjsbpjF4pdc918=
X-Google-Smtp-Source: AMsMyM6GQy9bXO8rgl1ev7N7a+iu/CNgNXTiAiyVAJvYk/6WyjbBvSoJOXhHIC/g3vtVSIC6Qr82Ow==
X-Received: by 2002:a05:6870:d0c7:b0:127:9860:95b0 with SMTP id k7-20020a056870d0c700b00127986095b0mr2784031oaa.3.1664298686074;
        Tue, 27 Sep 2022 10:11:26 -0700 (PDT)
Received: from [10.62.118.123] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id ep41-20020a056870a9a900b0012b2b0b6281sm1094514oab.9.2022.09.27.10.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 10:11:25 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6c1ca180-8df7-c4d0-bd9f-d6b70f6c5142@lwfinger.net>
Date:   Tue, 27 Sep 2022 12:11:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Problem with modprobe
Cc:     Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The driver for the Realtek RTL8821CE network card show some asymmetrical 
behavior between loading and unloading.

Starting from scratch, a load command provides the expected results:

finger@localhost:~/rtw88>sudo modprobe -v rtw88_8821ce
insmod 
/lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko 

insmod 
/lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko 

insmod 
/lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko 

insmod 
/lib/modules/6.1.0-rc3-wireless-next-00623-g2bc09edc7fa2-dirty/kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821ce.ko

Unloading produces a different result:

finger@localhost:~/rtw88>sudo modprobe -rv rtw88_8821ce
rmmod rtw88_8821ce
rmmod rtw88_pci
rmmod rtw88_8821c

Note that rtw88_core is still loaded and needs to be unloaded separately:

finger@localhost:~/rtw88>sudo modprobe -rv rtw88_core
rmmod rtw88_core

The appropriate lines from modules.dep reformatted for clarity are as follows:

kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko:
    kernel/net/mac80211/mac80211.ko
    kernel/lib/crypto/libarc4.ko
    kernel/net/wireless/cfg80211.ko
kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko:
    kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
    kernel/net/mac80211/mac80211.ko
    kernel/lib/crypto/libarc4.ko
    kernel/net/wireless/cfg80211.ko
kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821ce.ko:
    kernel/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko
    kernel/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko
    kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
    kernel/net/mac80211/mac80211.ko
    kernel/lib/crypto/libarc4.ko
    kernel/net/wireless/cfg80211.ko
kernel/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko:
    kernel/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
    kernel/net/mac80211/mac80211.ko
    kernel/lib/crypto/libarc4.ko
    kernel/net/wireless/cfg80211.ko

What is the explanation for the failure to auto-unload rtw88_core?

Thanks,

Larry
