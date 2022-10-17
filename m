Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1387A601B48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJQVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJQVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:30:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB744572;
        Mon, 17 Oct 2022 14:30:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k2so27925714ejr.2;
        Mon, 17 Oct 2022 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3O5G0IewyTHyohGin/A1A4nZ3WYozCUyR2cCHU4htQ=;
        b=MIu5jjZiuhW0PUQXMZfYpR8SuixPm4Z1LmAlZJEhojShZrWPxkUVJljw6xXDkWsEJk
         i7+tEmvgruYP+s2H24M6dWWzZt1H3HWoZTY9lK9GrSC8UaCg5D96ibJO2mTNxFYZ0R3f
         Y2UewWDG+1S4oGnFeYZ2cAGkI49Vo6t0evBbvjk6c5zWTg4KO28kwNrzi0ELVNoGf+ga
         kMNmvC605U4YC/lqki9K1MdjaFrj7oobckfVBSQF4nzQlhG0piDwMh+ASJWkXA2LCaBO
         dBXzn7GPNDINTiwY2o0vxr/4dtt4N/WjgZARO997FS3WbCzoFRRPXsnhy/e4Rlpk8ScC
         xVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3O5G0IewyTHyohGin/A1A4nZ3WYozCUyR2cCHU4htQ=;
        b=7tQs9BamrOO9d/f4giEc/gevBMKT4ZCRPlhV5dfl3jXdKN7qOiuYzhPDw+uTUhyCVh
         ly8oCg/ZtrXmUtuja4zmBW28zco18bl0KSq+XNrIpHZN0zWlIPzTN/6cfu4xkK7xbw/l
         uY2QgVdYDebJUTrEIptdxZZm26Ju0wsJh+RD7hJyjVzM4IdkAToWeVaD6ofBuz7zM70c
         6CQmdUwrIydGcI3vniFfHyB9rHCxrdKdH8H4yXvU+J5vcEKQJWmRd/RuzaRxxKiYpylf
         BI9Y6X7mURftJzWrQ7y7ZNHrrqc5/xJvczDbcbiuoo9Bsoj3Aai3GqcOgDl+NC2ZvpKp
         MbGA==
X-Gm-Message-State: ACrzQf2rP08KKJLlyTsA6U/3A6u9n9yQJelsTL50sUf+ZSS8UGref5L1
        y5Fn+8g9CqBbcYw5BubmTGegcu8Wk3kQxnTTm0U=
X-Google-Smtp-Source: AMsMyM7bz0aAR0DCGZaRhxkAdopCSTYsvQmQLywWjSqF4AO5SNRGH0CyB+KjbM87emhhJXSNUD+MB9myD+rL+cSZnkA=
X-Received: by 2002:a17:907:7618:b0:78d:ad63:2828 with SMTP id
 jx24-20020a170907761800b0078dad632828mr10698131ejc.27.1666042202625; Mon, 17
 Oct 2022 14:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220927155332.10762-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220927155332.10762-1-andriy.shevchenko@linux.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 17 Oct 2022 14:29:51 -0700
Message-ID: <CAHQ1cqEAqRx092Ok9uRUpQCuGHAhkq08W78OFst22Ej8ZmmAsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
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

On Tue, Sep 27, 2022 at 8:53 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> As agreed with the author, the v5.19 change is going to be reverted by
> this series, so we will collaborate on a new one in the future that
> brings no regressions.
>
> Changelog v2:
> - added Cc: stable@ and Fixes tags (Greg)
> - rewritten cover letter to point out what the version is touched and
>   what the decision made with the author of the original change (Greg)
> - fixed the placement of one piece of code (Andrey)
> - added Tested-by tags (Ferry)
>
> Andy Shevchenko (2):
>   Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG
>     -> peripheral if extcon is present""
>   Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is
>     present"
>

To spare everyone the need to read extra long thread in
[PATCH v2 2/2] Revert "usb: dwc3: Don't switch OTG -> peripheral if
extcon is present"

NAK, on the whole series. The regression doesn't repro on my
Edison/Merriefield setup and doesn't repro on the original reporter's
HW with my build, so it's very much unclear what's going on and what
the problem is and until it is the revert doesn't seem warranted.
Please don't apply this.

>  drivers/usb/dwc3/core.c | 50 +----------------------------------------
>  drivers/usb/dwc3/drd.c  | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 49 deletions(-)
>
> --
> 2.35.1
>
