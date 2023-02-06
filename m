Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623468BB76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBFL1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBFL1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:27:06 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA60125BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:27:02 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5258f66721bso102265527b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJR7iIBYxeHMKeEYc9yJlmGGl4YAGtrHLk1xmdfWkjY=;
        b=cEiqbsgShNHfgqVqwAK88z6dPmS5LNgW4KwIyRVk3eWmxUXP0lv1ECQABJxp4IuAW4
         08SmBAO/PDsRaPrMqDLjT3iOOCqXXb/OLe791QjQFGztN3jDiPclnERlhhuQg37GtVIK
         uruJuMVn/c+RFufhHvA1+2oVj6SHkahm3MvAtdj2UdPrjz981YKz03DmWmA/Mml3Ebo2
         vgLuq6z4a1wu8/LSs5sn3+RErEjRdU1L1PTnIJqzqC0aArFJrsaTANiqN1TlCwSK+P+p
         k+lZZZF0sQH3lVORlgXpVQUkbl1FE8R1/ZFV35uUjtD4VSBn4jrBaeuXzuqVkGAB60uh
         pFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJR7iIBYxeHMKeEYc9yJlmGGl4YAGtrHLk1xmdfWkjY=;
        b=QGPS+BBEEdbuPQyEwKONzl7Zs+ZB9UC9DGJDy3qJEuze/lObPubszovUi2xeHLCzqr
         wEb4pwZLHQBO2xE/xcT7XH+YpB55jqMXLuYwPjzKxE2cHrrX5o/8rvG0uGE8G6yK0E8v
         xUv9f1cvmq+1rS694oUy9Bhhk+Hc7rYTYRJKxc3oxHz4UuwdNr4e3cNbi7agJpUqlk0E
         LjnEpXhR+RVTxmYu5k5ayLu+Zgso+odN8TywMszUX6ZcdRSEtjZxjE/AD2qh6f78WzuD
         Q1iezntir7BgHX2xqtbVMW5860CJGn0SYWK5iHymElT8W26W2NtTn4kNp/2Yg1CGJ2D0
         iArw==
X-Gm-Message-State: AO0yUKU1IouN/kqX55EtD/6bJvU5JM5hPYA0kzw7Hs/gcIinpEqE3GiH
        vZXfjaKTUHo52/0/d+nUbwHB3e3WLZQi6Au6dZ0ysQ==
X-Google-Smtp-Source: AK7set8L3VLeOObm9qWRrIhVr41MTYoDvVibtG9Ay2RHWLmtjUwNSvhhckk7653hSCZoO5nkPQYJMfhJ+CrdMrR5rTM=
X-Received: by 2002:a05:690c:b18:b0:4f3:8d0e:edce with SMTP id
 cj24-20020a05690c0b1800b004f38d0eedcemr1702307ywb.185.1675682822071; Mon, 06
 Feb 2023 03:27:02 -0800 (PST)
MIME-Version: 1.0
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com> <137b56f0-8e86-f705-4ba7-d5dfe3c0b477@gmail.com>
In-Reply-To: <137b56f0-8e86-f705-4ba7-d5dfe3c0b477@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 12:26:50 +0100
Message-ID: <CACRpkda3TNyLqy5ZSKMsp8E+Tzys8o1h=q6qSoBCta+08BYZ_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: pinctrl: rockchip,pinctrl: mark gpio
 sub nodes of pinctrl as deprecated
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:08 PM Johan Jonker <jbx6244@gmail.com> wrote:

> Mark gpio sub nodes of pinctrl as deprecated.
> Gpio nodes are now placed in the root of the device tree.
> The relation to pinctrl is now described with the
> "gpio-ranges" property.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij
