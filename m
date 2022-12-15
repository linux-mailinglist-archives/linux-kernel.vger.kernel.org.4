Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D622B64E417
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLOW67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLOW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:58:55 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010295C746
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:58:54 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3e45d25de97so10725757b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0UUZcz2M6JUovGJxizjQWESY/vxVUxzAMePTGkmavQ=;
        b=EdSH76dSor7phZGQyOiwpRrYz2IYRV2FrdAcs8yfb2GL43X/HGKqd2Y74yO4xc25Pp
         yrZurNWm4B6wKF+8bBgMl+33nDH2coVPGXm46TNi6eT7YVDO39ctrQTcSMF5qrVrFWYY
         TvShntjwr6bFx3HhLCfu3Sr1oCzQmHxFLqVRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0UUZcz2M6JUovGJxizjQWESY/vxVUxzAMePTGkmavQ=;
        b=DKL1lFOiUCWFXxGxVHLRs9hBf+xkIvU00LcPp714dcuTCyXkLi9VixM6wAkjwWLsoS
         Gz8+jXH9qBnHoD/q/ldL2M4ZQG7Gf3xNlJ2l8NLI7y+CIdyoqjEWe/UHl3DQav/UF4Ab
         bYE+VG5sxvgTa/ZxKMdoJ/UiWjJCV0zzdx9d2uVFDq2+ZhHrdweWMPghAWv+Yb7eukcB
         bpkqNRFcuK0jNOp64vLxWjqOEAgyWsH23CeUjV6QWQUygTHc72z55IIvgJBZPoo3vTZY
         2OMtijBkwgBwEA6/VDYtstR3TqGyWsaQm5rlithukyx81ujTu/AHOsnveZQHDAaebvL3
         fPGg==
X-Gm-Message-State: ANoB5plCM+arFQXY4Gnsn78ttlkQhGPr6G0m4pyB60dVEjbFY9Fqq3Pk
        nVGiO/bQ3euf4JODS3d8oPGOIsXyPUoGbZ9gaaaoXg==
X-Google-Smtp-Source: AA0mqf6Xuhli+7ti+l4aYdZwyYygJLY0D+mcLV3NEWJ8pbkP3gOxmcy3nkpAnxrwmTp2ZPuKJQFoyTwPxiLz77hRStI=
X-Received: by 2002:a05:690c:909:b0:368:70a8:9791 with SMTP id
 cb9-20020a05690c090900b0036870a89791mr19619784ywb.197.1671145134170; Thu, 15
 Dec 2022 14:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
In-Reply-To: <20221215061550.18993-1-joewu@msi.corp-partner.google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 15 Dec 2022 14:58:41 -0800
Message-ID: <CACeCKae01WNKbP8wWONdpbNJQjLWFF67AFay0kwA_zmoaUNVUQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
To:     Joe Wu <joewu@msi.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-input@vger.kernel.org, Derek Huang <derekhuang@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev,
        Douglas Anderson <dianders@chromium.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Dec 14, 2022 at 10:15 PM Joe Wu
<joewu@msi.corp-partner.google.com> wrote:
>
> This patch is to add extra 3 buttons: 'brightness up',
> 'brightness down' and 'leave PC(cros) mode' to support
> monitor navigation function.

nit: Please use the imperative form [1] while describing patches.
In this case, that would translate to:
"Add extra 3 buttons..."

Thanks,

-Prashant

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
