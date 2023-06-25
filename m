Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224A73D1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjFYQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjFYQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:02:41 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4913E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:02:40 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-471b3f3b989so637177e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687708960; x=1690300960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cIbCR/JI3IGiEKrtW27iaY9wrqECrQtHtHpkt5T9IE=;
        b=jzefFfEo88PNIA9Z2VlqncJnraG19PtjDZhYcITBgwLJKjjUAi1BzmShQ0POHrUMwA
         hdTuxTey47409eI8Yu7D/uQVaobAhabS6g86GnI9Nf1GwUOZo9Vo2Rnv7k16ZKp47s5H
         fHWvUaxV1HHagRyCZ5QO0d1LNoC5+5c/JMfoWBCOQjaUs/s9TJD6PtDTTKRBEnSI5Xy5
         PMfYqiaGRmouPDW06QctxNyCtX9+NSX6rJeBC6HK0bH4I61iOES7P5J431L0VXTOz39+
         q3Wao5iCb9+U6HoWmESlTlL51E7Dir1ok0Fie7QXz2SS2io0dF+7lFccZloX+gUPrPxi
         KCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687708960; x=1690300960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cIbCR/JI3IGiEKrtW27iaY9wrqECrQtHtHpkt5T9IE=;
        b=NYsrhTii6D/yv8zd0F968UGAa0P0JzSmJO7wHsZwkEAYKZ+1QamJ0FKo7eI8UOUtRc
         viu1tpvRdn82XU4bmQ9bWbVAfdU8cJdCDpN+MicBCgy39rBfx4vigezdzqT8UMslZQz+
         xuY38OX4s/fpwDB9q1mxBTVkUIAMAK2o/jgMrNrCWzhGpUOKA3ZzCkYijdLKryM2Lg/t
         GZ5vjvsC+EgUjv7i6nOiCEPwKqTYIf6YLeyFWMVICMcEUjv7v8p0jGo94BJAPIZwwwN5
         aHmWcWiE5MCQBDSJ97lhWdDP0EqIEUOTnEOWU0yIqp5VhQijirOz4M027hbWKa3sdYjF
         KeKg==
X-Gm-Message-State: AC+VfDwaiGfXjw0RhBGMABye50lVMBT+OfuUtmXGeZoxDAuBw6m0ohDg
        wqvcEt8doOvC0NhFD/ao7pzoatEAYirp7yiCB5c=
X-Google-Smtp-Source: ACHHUZ7RvdHZvUIQzmb71QDFLCudHKYlWndu7sMUcNX0FhIwE/lK8bXB2rq2dtsaoDXtv7fjblADh6kr+EPRSLPC5pk=
X-Received: by 2002:a1f:bf92:0:b0:471:2aa6:41f6 with SMTP id
 p140-20020a1fbf92000000b004712aa641f6mr10707773vkf.2.1687708959979; Sun, 25
 Jun 2023 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230625155632.32403-1-franziska.naepelt@gmail.com>
In-Reply-To: <20230625155632.32403-1-franziska.naepelt@gmail.com>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Sun, 25 Jun 2023 18:02:29 +0200
Message-ID: <CAAUT3iM3k3iVx7UOQ-s9OJ=aVWarAp3rEDNTzSfY-m3yJpGe4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix some checkpatch issues
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, eperi1024@gmail.com,
        hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 25. Juni 2023 um 17:56 Uhr schrieb Franziska Naepelt
<franziska.naepelt@googlemail.com>:
>
> This is a series of patches to fix some trivial checkpatch issues. Not all
> issues have been fixed. I intend to submit another series to fix more stuff.
>
> Testing:
>
> ---
> v3: Series to contain only remaining patches.
>
> Franziska Naepelt (3):
>   staging: rtl8723bs: Fix space issues
>   staging: rtl8723bs: Fix alignment open parenthesis
>   staging: rtl8723bs: Fix remaining blank line issue
>
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 164 +++++++++---------
>  1 file changed, 85 insertions(+), 79 deletions(-)
>
> --
> 2.39.2 (Apple Git-143)
>

Testing:
* Build the kernel with `CONFIG_RTL8723BS=m`
* Boot the kernel with busybox in initramfs
* Load the module
-> No errors or warnings
