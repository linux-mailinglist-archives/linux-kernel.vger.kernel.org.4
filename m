Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB550747B68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGECJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGECJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:09:40 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A410D9;
        Tue,  4 Jul 2023 19:09:39 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-565d65adcf2so3659148eaf.3;
        Tue, 04 Jul 2023 19:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688522978; x=1691114978;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSyXr8wt2ntmASjlaftTJycTyU0JD64M/HgW/H2pOqs=;
        b=eZMqo8/SCRBx5qfVtU5/iGPTggyMi+m6cvjFi6VIFC3wQbfjLBH07alAHk0k6kOL7/
         9YO44QJhs3uBCHqXAzo38gf8pQNnbckirskhI8w3Q5ZWPxI052rpYdw36oxCwY2tG6OW
         vjw1xbjF2vL+O3zwy/rbXDRgZUehItq02WQmw0dejStm8lZg9BxR7lDBo5BGRdOq3z3i
         t6z7Gzu63q1Ko3Q8GwnQ+y4DTgQXp14kSS/nccmHtKay1vHOsI/FyKcvJFPiJGd6KbAA
         ah57Rfte1+BGOOrhmzK35ecaQWdJZTzFJjV94lkVIiBX3m/RzlAQTNPPU+8nBYGJ2Ygw
         nLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688522978; x=1691114978;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSyXr8wt2ntmASjlaftTJycTyU0JD64M/HgW/H2pOqs=;
        b=XBvnoBRxSBU4V9QAVedcHyVfpIv1S/8g1PmejitMs3Hr2gA6n/oIFr3qommrgnhVT3
         bKOyb5rS+VuIRFz9yDwe60/Ud8gujruoQuvcl9SU2CWtGx4HgIXeYpi6uzpzoKO5jahH
         Yhh8ISCNoq5IM4nZc37QkQrp5cuL+yaLX2ADlXALe7DRBX7oLYuU8NBFmuJhGDn5rnlx
         TkFRby4RGm9EKPleq1CGFtDfLRSRSQWzAyg8xgywbFq1IInEZowtH5kwy2yb2R/E63hB
         KLviX5qXgE8O2/cE4l+CohbMCSHRlqZB8Zi3N+B9uIregYUwUYDnzcHNvHBvmIUPLA0D
         L6NA==
X-Gm-Message-State: ABy/qLaKNYvP2eUpz4pmCnju4USQsVku+6pT4SUc6OFXSLOjyHsKD9aL
        BT+nm8DznzwEVOga92fjCHw=
X-Google-Smtp-Source: APBJJlHvCc3Ope5BY4FwHT0Mr77Uxm0rAhl9Pjar4p3dMmGJVjndYQeh1/V0YNqIdcAhmb2VdTgwmw==
X-Received: by 2002:a05:6359:201:b0:134:f326:e819 with SMTP id ej1-20020a056359020100b00134f326e819mr10789439rwb.29.1688522978371;
        Tue, 04 Jul 2023 19:09:38 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79109000000b0066a31111ccdsm10139786pfh.65.2023.07.04.19.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 19:09:36 -0700 (PDT)
Message-ID: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
Date:   Wed, 5 Jul 2023 09:09:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Dave Jones <davej@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ross Maynard <bids.7405@bigpond.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
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

> The following patch broke support of 3 more Zaurus models: SL-5600, A300 and C700
> 
> [16adf5d07987d93675945f3cecf0e33706566005] usbnet: Remove over-broad module alias from zaurus
> 
> dmesg and lsusb output attached.

Because the description above was vague, I asked the clarification.
The reporter replied:

> The problem is that networking to SL-5600 / A300 / C700 devices does not 
> work. I cannot ping the devices.
> 
> The error is occurring in zaurus.c. dmesg is missing the following line:
> 
> zaurus 2-2:1.0 usb0: register 'zaurus' at usb-0000:00:1d.0-2, 
> pseudo-MDLM (BLAN) device, 2a:01:39:93:bc:1a
> 
> A patch was created in 2022 to fix the same problem with the SL-6000:
> 
> USB: zaurus: support another broken Zaurus - 
> [6605cc67ca18b9d583eb96e18a20f5f4e726103c]
> 
> Could you please create another patch for the 3 devices: SL-5600 / A300 
> / C700?

See Bugzilla for the full thread and attached dmesg and lsusb.

Dave: The reporter asked to write the quirk for affected devices.
Would you like to create it?

Anyway, I'm adding this to regzbot:

#regzbot introduced: 16adf5d07987d9 https://bugzilla.kernel.org/show_bug.cgi?id=217632
#regzbot title: Removing zaurus overbroad aliases breaks 3 Zaurus devices

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217632

-- 
An old man doll... just what I always wanted! - Clara
