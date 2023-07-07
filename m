Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FED74A8AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGGB4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGGB4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:56:47 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D6A19B7;
        Thu,  6 Jul 2023 18:56:46 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-47e4d002e0bso565086e0c.0;
        Thu, 06 Jul 2023 18:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688695005; x=1691287005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GVrjzhB6jW+MELZlDWpD9snVHwu3Y9sqKf3tzEuK44=;
        b=MV5stPNyloZVMitcziY8nhPCnIFhSujoSKmNdhwOa9Sbgd/t9b084lK5I5hoyn8NCE
         pcQWhClVACtndEfWmmSmTYjGytpHH6irOAJJWEEH8Ct/31r1bVFO7yK6enJEbmrV4ESb
         fHhXBFpzlsBHqMCT8S5+wtoZCW7OcgZpDl5ZMsL/xp0IGcNGhuwjS6FggyS5HMrbkry2
         j0abu4oYVXwvus7LZ2HxkYGvLT3tu3fGdkKQIGOxLqg93dHBA3QCPpO7wIDLKE24f9ro
         BAXfIXfoaXMkVpPyUUIIUMukmO8zq7otmikj08S2KxKKeI7FOUfE0kAkpfYfiBcBTMLc
         z9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688695005; x=1691287005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GVrjzhB6jW+MELZlDWpD9snVHwu3Y9sqKf3tzEuK44=;
        b=BhFH5w25ZujgJ2GGrDZ6yZDzebPy1eHwlg6rkHNAVSHWRVFU9LQmrTG5us9XjxkzBE
         U0tKX+o+bc15uqD2kz5MiekpuO5IrpV46mkcMT8uy10WK2R0KDVhVS+xwsEWM1ycyzpm
         FC/fi+xAlN+nqbtPmJPQty086JeXJetxjx9O2CLXcluWx1UF5yNDKUBfEDW3/xq14kSY
         NJ6hJG76lGfYqB+3NPjiETvGS2Zneh0xnZrMs1oL4jCoGZ9ovXHiuvso2mxrp46e9jYJ
         Vjmak1HrEoImmzdt24D0eBEJRzEoaqjJtqs+hUqTgXvz+iLDQBGdvzc8r6m+pkztclJn
         pPkQ==
X-Gm-Message-State: ABy/qLYgZ/2vfrGYBgTfraRSrlLYIhF1OgmT6Y9pyC7yRLNfAecQ4Ump
        c92XFSkWD0nhRtqkc5XRFDFknljGRbyBcCRAhEM=
X-Google-Smtp-Source: APBJJlFvss+N6tGmF1lydqS+w3Igp/aaRoOnw3LWGedovndHvat2xXGT1r3PKtZxk667gqBXLMtlkzF4gK9mmbTFf7Y=
X-Received: by 2002:a1f:bfc3:0:b0:463:12f:d38e with SMTP id
 p186-20020a1fbfc3000000b00463012fd38emr3215232vkf.1.1688695005294; Thu, 06
 Jul 2023 18:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
 <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info> <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
 <64b8732f-6319-9f10-b82a-b4a3dd8d4b8e@lwfinger.net>
In-Reply-To: <64b8732f-6319-9f10-b82a-b4a3dd8d4b8e@lwfinger.net>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Fri, 7 Jul 2023 09:56:34 +0800
Message-ID: <CAAJw_ZvZNQzrFyQizJnKe5PerqqAUOmPYd6cnjAcvs68xNdwSA@mail.gmail.com>
Subject: Re: Linux-6.5 iwlwifi crash
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lkml <linux-kernel@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 2:11=E2=80=AFAM Larry Finger <Larry.Finger@lwfinger.=
net> wrote:

> Fow what it is worth, my 6.4-git (6.5-rc0?) commit d528014517f2 (pulled t=
oday)
> is working OK with iwlmvm. Lspci says my device is
>
> 04:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [8086:=
08b1]
> (rev 73)
>
> I think you do need to do a bisection.
> Larry


Larry,

I did a bisect and here's what it came up with ... reverted the
following and iwlwiifi worked again.


19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 is the first bad commit
commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Jun 21 13:12:07 2023 +0300

    wifi: iwlwifi: split 22000.c into multiple files

    Split the configuration list in 22000.c into four new files,
    per new device family, so we don't have this huge unusable
    file. Yes, this duplicates a few small things, but that's
    still much better than what we have now.

    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
    Link: https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d=
341ef1ddc0531f2c9aa30d30536a5d@changeid
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

 drivers/net/wireless/intel/iwlwifi/Makefile     |   1 +
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 939 +-------------------=
----
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c  | 452 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 523 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 214 ++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |   3 +
 7 files changed, 1206 insertions(+), 928 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/bz.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/sc.c


My best.,
Jeff

>
>
