Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F264D21A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLNWFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLNWFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:05:40 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D756341;
        Wed, 14 Dec 2022 14:05:39 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y135so1398335yby.12;
        Wed, 14 Dec 2022 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpKzu7aG3ujDPekivj+JPQB6+3jB4z7ZL3rmRKl8tl8=;
        b=hi6ZQGWA3wU6GVmxcLYtynfzwvZ/FdhnOqMBNkzTOAS9LOO3IC4lTzdNBeLKNQKTEX
         IY9CjGMLbdBg1qj+wDHlu7IdFoEHZumUWPaY/rBzjVjEDK2elZpnAGSzsd5Cuqg+ghFe
         ZNy0XPpz31s4xAMTd/TCmtJ8nmGgoRDa7stXmGiPVk0/QqOnkHTGP0BPGZ4pum6ahePh
         IGcpPL+dGk6PmGGvTLfYBMYWTrdCw63GQR7FepCnjI8OfmMx5sTlkTcBW59emBpOQAot
         Cv3fKXeKO2NesdeKWspD3kDAXyH0ih5gYeMHZdpsL48xGCu3NFTpMAAzWDsTDQLKc6Ev
         L11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpKzu7aG3ujDPekivj+JPQB6+3jB4z7ZL3rmRKl8tl8=;
        b=CUxXtEonr4vzSgJXY1JcGyk+nWQZPV4zxMumfR056WItcjMnmMVOH1YX87BlbEuDbc
         22bH6MGvPg0CnQ89S2ELkcwtEwnCt5XW2/xtTOwxPByJaFUDhAtw0il4Hbm5/ShtKPzi
         XZxaF72VoZzVPwq/PZVnVycDktXzYsYbh4Tj5Ddoz/Y96AJXHRHRAJ3qFUwGhBrRZh7F
         BagorfS1zNkT+yxAnNiPwpF5gQleT/iR+XrAviuUl0b/vWEayijwbsks6KECaDOGSLi8
         Z6xBKUu1EvCHQrirdRYjbUZnHGDfzvRsxOyzVIV/hmcy4Ay1IvQSErdQLUaQXWl7d5N4
         GTrA==
X-Gm-Message-State: ANoB5pmUG5D1i3YqsLIQCe6GPGF0gS7tpXw6seiLiS8oEBHhApFOrT4U
        +HvEL4epwQ+li0dB7pSLHD6sHXI8oHoPpK7EEZ0=
X-Google-Smtp-Source: AA0mqf7k3wgF69TeQYhG+tSTr5IwX5mnWuQUHyQh70Z+MwGNtUDRLrkzVSNqXD4cTjl8p3AiKyzN9Ed6Sp7p4rzmYy4=
X-Received: by 2002:a25:bcd1:0:b0:705:fc5e:4313 with SMTP id
 l17-20020a25bcd1000000b00705fc5e4313mr11143141ybm.180.1671055538495; Wed, 14
 Dec 2022 14:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20221214153908.99926-1-derekjohn.clark@gmail.com>
In-Reply-To: <20221214153908.99926-1-derekjohn.clark@gmail.com>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Wed, 14 Dec 2022 19:05:27 -0300
Message-ID: <CABgtM3ibh0k8LcEnSNUx7DwJBQfMK6K3G_Rhk4GR5oSsx+Rmaw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
To:     "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc:     linux@roeck-us.net, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  Currently the driver supports the following handhelds:
>
>   - AOK ZOE A1
> + - Aya Neo AIR
> + - Aya Neo AIR Pro
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO

Since there is more support now for this type of device and not only
from one brand (even though it seems they all come from the same
manufacturer) I might be sending a patch to change the name of the
driver after this gets merged.
--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
