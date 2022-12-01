Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAD63F980
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLAVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLAVAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:00:53 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC43B3933
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:00:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so7164878ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GjdRTH/tOOqfRcgeR10agDzqdXeX6/1B2Il2FJNpk9o=;
        b=lQLmOg9OjSraxzekZjSgcm0t0iOOSlEZMV9S9mHYGB46UbHRWvnPNYLLg2Pqv5Gy0A
         FazJhKaIxO2+yKoQkR/bHdjEXiSLyVZKy5yv7aiUwvJXuVwBtDkUxF2x4I3SrzXBZIAR
         erJ5ii7VS5paRQ0D2v3aye1xNNntMdS4hBygo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjdRTH/tOOqfRcgeR10agDzqdXeX6/1B2Il2FJNpk9o=;
        b=oHRie2pCfnXPIEXiY3IpjP5gnwVsjgvWQpjUTJLglYbAucCxfhx70bANXb8kSCGF7k
         H9+Zcdp6VnSlfYuYJZNTadx3tN0K2hsvGafm+/TcSdz2FcaomtFWkS47W0QZILXWX3OC
         dLplljxKb30kdYGvSbaiKqPw5aFRNSmu06+3ijytx8rLDVcHa7Be2+EnHMrfSSv9ZfPp
         7VFoCeO7Ex1u3rTrzQvXlWwWZjKmtql0rFCIHfN95I+86JooCSHcxNRWzWI3br1uhiQn
         xx/9krYBPS6LXz+YfIuon/Ys/ek0nPFc149ajDnP5p21Diuonhuadl+LGfYhSsGrJ35a
         k3yw==
X-Gm-Message-State: ANoB5plF73STru0hSQIFGpxTLqhg+10cBH2WWX96VJKsQ/43Z9gZ2IG8
        RgNZUh0sIXwcHxaFVWJgKS+DCjahYVKri1cMKGpV8Q==
X-Google-Smtp-Source: AA0mqf4xWS223It9WE2Z53qJizB+CilQAiqOpQ2gZq3sgi/L6Pj3GgY3E+MHsJOxqyjNQ6hKxA20G2uQ7XLMVzbbQp4=
X-Received: by 2002:a17:906:79d3:b0:78d:b6f7:53c0 with SMTP id
 m19-20020a17090679d300b0078db6f753c0mr44042365ejo.527.1669928451351; Thu, 01
 Dec 2022 13:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20221130231936.1666390-1-wonchung@google.com> <CACeCKad16bs_f6bLthTAoEL28tPvf1S10WDeM7ugeaS9g7R25w@mail.gmail.com>
In-Reply-To: <CACeCKad16bs_f6bLthTAoEL28tPvf1S10WDeM7ugeaS9g7R25w@mail.gmail.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Thu, 1 Dec 2022 13:00:35 -0800
Message-ID: <CANLzEksD=dKgPuCUD74b3YQKCApbZKO_t7Q=tyNKONvAOQ89hw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Create new USB driver for RGB keyboard
 in ChromeOS devices
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Won Chung <wonchung@google.com>, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,


On Thu, Dec 1, 2022 at 12:10 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Won,
>
> On Wed, Nov 30, 2022 at 3:19 PM Won Chung <wonchung@google.com> wrote:
> >
> > Without any driver bound to RGB keyboard, it may not be suspended
> > properly, preventing USB xHCI to be suspended and causing power drain.
> > Create new USB driver for RGB keyboard so that it can be suspended
> > properly.
>
> This seems like overkill. Can't you set this from USB's sysfs nodes
> like power/control [1] ?
>
> [1] https://www.kernel.org/doc/html/latest/driver-api/usb/power-management.html#the-user-interface-for-dynamic-pm
>
>
> Best regards,
>
> -Prashant

We're seeing some behavior where a bound driver is needed in order for
this USB device to properly enter suspend state. Just manipulating the
power/control and other sysfs nodes for this usb device when there's
no driver in the kernel doesn't seem to affect the device's ability to
drop into a usb low power state.

Also, I synced with Won about this offline, but the primary concern is
not this prism usb device runtime suspending, it's actually it's
ability to enter suspend state during system suspend. Right now, this
internal usb device is keeping the whole system from entering lower
S0iX states because it's not sleeping. This driver patch doesn't
address that yet, but I'd like Won to dig down and see if he can get
it suspending at suspend time too.


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
