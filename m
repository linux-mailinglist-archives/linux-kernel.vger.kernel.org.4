Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1237A5F68BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiJFOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJFOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:02:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA8AA3DB;
        Thu,  6 Oct 2022 07:02:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 207so2364954ybn.1;
        Thu, 06 Oct 2022 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ItWFOLvZ7RFflQ0r1IJBOW8mA5I5+0QaLapZDNLKRhE=;
        b=oBOCdlgXZ+gUdiAGOyJsqVoyjgq6eHLXeCRDoVkCtiyYLLgR7+NMgu5YNNcNw/bCth
         QHycWXAuQdhfAQ76ghOl/v4DKvBGckJMxx6Xp8tqOuyKiXgQqNNr01kFXjPVFEoNeuXz
         lPmJYfoh0uwYkFMpC6fWXDObwUBgLMLQLEdXD1G6QiKqeq7NAtAjzmpIfObcHtZOvP6T
         2lzLEnw5RyLLUvilQM7Kmc/nOs4RQYQCyqMLKhylJ2tdq0r9Ovx7qBnBsBwDz+tRXApB
         OMwd3sqZa6AbIF3wyO1tibMTVOzAk3oq06VbzvfgSz5GrmvEaAq3eTCZ4LmF2MYxTZDT
         UDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItWFOLvZ7RFflQ0r1IJBOW8mA5I5+0QaLapZDNLKRhE=;
        b=zY69MuUjeSdmm818Oise4Bx4d5ENoD5Ku9amE/p6QgLh5LS9JrvIw2ODZap32J9SCR
         I+yoPHZVEBPfwqE4JXxayzIRi/fvzan0lD+owJ4nMwCvfPZAwyKt4Lxj40o/5F7NU5KM
         DGRtECCp5k6VYpgmITtTqqTPhgzBg59G0ICY0b4Ld0/Afe6XpcS+0S9A6CXXHfS7mVfN
         PcKvddbybmEi1gPQFc2B4nJ/Sm0R8vL6yiGuoGB4FrIPdIuJ0HV0LrItvPFx8s/K1gaK
         8DlenrluRv93g2ZCnLvwdx7UEOi3Q+4YKGCJiaXwrBjABvCO/zTVNtLzP7RB1YgUqLj4
         YyrQ==
X-Gm-Message-State: ACrzQf3wwbEQMllfQG5Jvbhu80myEX4QTll6QHRUm3ldnjNyHex1aven
        AuPYh7beGJU9cllntNpGnFclRm3Rb8DMaDIqozU=
X-Google-Smtp-Source: AMsMyM56mR1HqiiPqGdZ0c1dRHFoDsqqTGpmBS5/fAbT67ZCeAs5xE/XFyi7Yc/9Hm2awykkfyphOLhb6NpCOUfcfz4=
X-Received: by 2002:a25:3ac1:0:b0:6bc:d21:a35 with SMTP id h184-20020a253ac1000000b006bc0d210a35mr4487401yba.526.1665064928544;
 Thu, 06 Oct 2022 07:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEc3jaBiN_b_AJGugkYSwxF-ZWHzD6ib4r99tm9Z4RwN2=bgzw@mail.gmail.com>
 <20221006132240.3706-1-hcvcastro@gmail.com>
In-Reply-To: <20221006132240.3706-1-hcvcastro@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Thu, 6 Oct 2022 07:01:57 -0700
Message-ID: <CAEc3jaCgEB5=3ATdaRXozMT3HrC1JeQVsY_HVF2VgY2oajzyow@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: hid: warn feature report 0x81
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 6:22 AM Henry Castro <hcvcastro@gmail.com> wrote:
>
> Unfortunately, my PS DualShock 4, does not support
> the feature 0x81 to get the MAC address. Instead,
> use a unique hash to fake a MAC address, so I can
> use DS4 to play Retroarch :)
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>
> >> I see in the other email. If it doesn't support this request, it is
> >> likely a clone device. We are about to submit a brand new DS4 driver
> >> (for hid-playstation). It will use a different report (0x12) if I
> >> recall which does the same thing. That's the more mainstream one we
> >> use.
>
> I have 2 DualShock 4, I did not notice but I have one DS4 compatible
> (clone, I guess).
>
> The DS4 Sony -> returns -ETIMEDOUT
> The DS4 clone -> returns -EPIPE
>
> Look great the new DS4 driver :)
>

Just for reference if you want to try out if 0x12 works, you can try
this code. This is from the new driver (ps_get_report is from
hid-playstation, but you can just use one of the existing hid calls)
if you wanted to try.

#define DS4_FEATURE_REPORT_PAIRING_INFO        0x12
#define DS4_FEATURE_REPORT_PAIRING_INFO_SIZE    16

    if (hdev->bus == BUS_USB) {
        buf = kzalloc(DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, GFP_KERNEL);
        if (!buf)
            return -ENOMEM;

        ret = ps_get_report(hdev, DS4_FEATURE_REPORT_PAIRING_INFO, buf,
                DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, false);
        if (ret) {
            hid_err(hdev, "Failed to retrieve DualShock4 pairing info:
%d\n", ret);
            goto err_free;
        }

        memcpy(ds4->base.mac_address, &buf[1], sizeof(ds4->base.mac_address));
    } else {
