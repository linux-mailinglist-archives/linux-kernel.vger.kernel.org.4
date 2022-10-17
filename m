Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01F5600C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJQKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiJQKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:09:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130615F9B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:09:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so23761408ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYlNpP2yjuaN1s/0GSGSvR/4nmMU/j9YNQNQQpMCen0=;
        b=oZoKJjjfO5FspRdoxdL2uANtPdoBw5drTem2Nu0XKEMpfDUzx0TroI3BQseDtZqp8p
         SON8Fkilm37wNDTCjWqMfHGh31X6cAi74/akiK9gyONpvbNfDr/EcBDYcimuxdigJJw8
         T6DxD49qhUqF05JfiXcRjbebsZ1+hZXCksJ6f6csULxBwXrTQvFqwsSgWogk++IBYi7b
         zmd4WEGga8QGXTyyv51XlQOVxBZHK/5SXSYu+3VLOMulfq6yLYMgnxi4ezzaJprIDeL5
         /a+xgzykxz2/CX0AVAZqsAqPno9T4Fykg8UC4qqyYQ6czZ7iOPirVaGmIUlA4i2Vcna2
         BbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYlNpP2yjuaN1s/0GSGSvR/4nmMU/j9YNQNQQpMCen0=;
        b=fMujHHoMEcKAWHsTP56mSGIhyHmFqpaBvj4itqCsUW4nlt1iXXmjOcXXdQx+pDXkEV
         p6U3gKsjFZWaukU0O9vbVrovgvtJKb5WjH+V5VEv5j8scKd7PkXzgAHhwpnIi6qJb4G2
         56Q4q96WB7D1kz05rrtihZRf9H8SgltD8U4B5RZtA+ow6kaWFJj5mD9nLJvZgMhDWl3G
         DsCyZes30LJ9V1VcOV+xovkrdjkYUYETenvID6qN5JH4VpKMRZCC9EgtFSUTBiso8srr
         /OtsfQw98jCBIFOlubfAJ7lpJJLnZXUZ79bsxKZguGd7iOnSPUYF0BbhgA9fXqDnWrwN
         7geg==
X-Gm-Message-State: ACrzQf2dPHK3vLOhmgHMk1T7cQaYs/sxfeqPBPbjRjhY3pkijlBci8A+
        jGaw6MgFsLIgyw0cvDYjZHXBuXFvq29wdVTIe7i3YasTxpvsDQ==
X-Google-Smtp-Source: AMsMyM7CfYGIBACp5LKxkb/LipLw+lzRqIwClD7Vd43soIZs3l5TGz2NezqJSA7FslOlqykmU4zg4CP4AQesbbM8xTo=
X-Received: by 2002:a17:907:a06b:b0:78d:d25f:b726 with SMTP id
 ia11-20020a170907a06b00b0078dd25fb726mr8058069ejc.203.1666001352390; Mon, 17
 Oct 2022 03:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
In-Reply-To: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 12:09:01 +0200
Message-ID: <CACRpkdbEm6ZOTkXFkfxHzo6ke2SLowkxrNvUFyz7ba_BBywAGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] gpiolib: more quirks to handle legacy names
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 7:54 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> In preparation to converting several drivers to gpiod API, and to keep
> existing DTS working, this series adds additional quirks to locate
> gpio lines with legacy names.
>
> Additionally the quirk handling has been reworked (once again) to pull
> all simple renames (ones that do not involve change of indices or other
> complex manipulations) into a single quirk with a table containing
> transformations. This should make adding new quirks easier.
> When using legacy names gpiolib will emit a message to nudge users to
> update DTSes (when possible).
>
> Note that the last patch requires the following change from the OF tree:
>
>         88269151be67 ("of: base: make of_device_compatible_match() accept const device node")
>
> The change is also available in mainline - it has been merged in 6.1
> merge window.

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours.
Linus Walleij
