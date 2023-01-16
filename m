Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5527D66C23F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjAPOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjAPOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:34:10 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57C22035
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:14:50 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id t15so30409830ybq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/09gLXwoG4pnHvQOJK2RBXoPYQTRN+xyJOqG4otxtzA=;
        b=qF3H4qd0qbZvaI0F7/U/6HISbmGzqLg6lwWyoc6pzjfR4TiTB1mgiPk7WWHnuD7xuF
         bGVNmiR58lEt/Idi8H0d2gQmOGSw4rIYh767HjvUFhglbYD3elxoRA1E12UsJpibkDIf
         rowmOw4K4hsACdk4OWGedpEetBFMK8AAoCArKu45PsIUzUOBwU7jSlkokQmL9PdIsJ/i
         k7YiNSCO5uKL+Qsg3vsp2K7Z48JMq79rDda6RSO+AJ/gVdsLA6/mVdt46bW0bS58XVPo
         IHPombyteNHaUKk6EPTHVOM4L0fezJmjEL+qbX51vCv39Ql9XTCN6M1MPTrhIH/m2DP2
         QohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/09gLXwoG4pnHvQOJK2RBXoPYQTRN+xyJOqG4otxtzA=;
        b=SNrpTyyuwl7prIhwVyFqCvG7IjauxEeEQBkeaay5pjfAWynsZdDGBB1NRRR5bQMTS4
         6haT9F/izNzT/8D+Pspll18sKy2BzEX+X4Qg1Mw7GDmf07Mp/ngiZdsqEFd6M1kNex06
         h3ABByp3Z/9bRQcVk5XPjp3DmvdK9vDUVhFpCsUQz1/my5/Q2pdOZOum6YhyMP1fT7md
         fbk1xosu9Cp1lx6UBs9lHcuTyiMQlTz7WnuJCc9ut8vd2oF/xmvFXTsA9HosAAYbdgOF
         QTleTf8PO6mbFdVpVfJYEkblx6I87E/RIuwbofAfCUGsOjknPq/mv76zo9RdEffH/Kr4
         +sTA==
X-Gm-Message-State: AFqh2koec/VVohIVuiuq67u382VHdCt5e0J+I+ocKxqgFLCVP1h7TCOI
        DA5ZJl+WUPMTfPg/wFYIxmwiv8xjE0ECH/UmFTI53rbxL4dfQQ==
X-Google-Smtp-Source: AMrXdXtwDIdGASmF5sGOm3jBmrI8A4zqup0YGH7e18pQD6cYN/+zeUaONWesRVdKaM0GHXdcYNoN0U2nfd5+TFo/M6k=
X-Received: by 2002:a25:c042:0:b0:7e4:fa1:b33 with SMTP id c63-20020a25c042000000b007e40fa10b33mr279618ybf.460.1673878489316;
 Mon, 16 Jan 2023 06:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20230113143640.24302-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230113143640.24302-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 15:14:38 +0100
Message-ID: <CACRpkda66+a0A2Ho4ndTnzZKeQG_rR2wWNLE0xTD1QoGwd3bUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: digicolor: Remove duplicate assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Baruch Siach <baruch@tkos.co.il>
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

On Fri, Jan 13, 2023 at 3:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: added tag (Baruch), avoid confusion with previously sent patch

Took out v1 and applied the v2 version instead!

(Hoping there is no v3 version I have missed too...)

Yours,
Linus Walleij
