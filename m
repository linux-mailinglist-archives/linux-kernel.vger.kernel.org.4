Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99F666C213
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjAPOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjAPOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:18:43 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F59032514
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:06:20 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 9so12921123ybn.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIzh1XZQ1xje/NcjLF/uLjottU/dnzXTXWJdLcBuc3A=;
        b=rXgECtma3T+rAd5cu+dqZedQoJdF6ebIZslaSvJdjFtjyWPCwpu6qE8d/9tBlLQ4wN
         WtmN+TrihEfGZhd4gjRO8EnYTPJczr5D73Q1JC3pxFGt+/RoNlYQGPuwprnay+RHwS5E
         QorPh7mo+W6FuLR3615X5FhOUU8C9nmdmDWhwz0e1NFhpLqX7RVA2ZWWK4CKI8I8PDmL
         OpuTgK8s5oXCPlR72oL9xeRkl9drnaH5E8zyWnz/Vovzz8Oak7gWURJS4T0j0l8FpvnJ
         3MAE0aakGpeF2HNHIJgimdiM0EkOr8zAqbA8FH6T0P/EgJ642J3ySWRdSx40kt6jFngy
         fqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIzh1XZQ1xje/NcjLF/uLjottU/dnzXTXWJdLcBuc3A=;
        b=vUwNPPowWpDsoY58MBkcK1v+fymcbjLQO/K2F/0W5ffjLdeDJHvRBETiFfzwN49jL+
         hCBvdDmILlVq7Mx3ZsfUQMwB4g9DABCchueo3SRglOKxxQ+C9OkCX/aqnwOVqxGHx+zO
         mDF/UHmQOMjxGba+JZKXfgYn9N0ao9m+BV8kbAKjXQcPPyRPH+tnVAmoMXRK49y8jMjN
         T9IUiOPrQJwqO1fR/BJMGK6M368seqMA0t8juRQpONJAMMyaBYhM519OPZJzYBvBwK8j
         zwEyCAZDWWAidJYWo0IiwK3OSUMk4bDaKhA0FKZvcnF5XKo6AAi/8/cF0cyd9qUxP1W4
         VMqQ==
X-Gm-Message-State: AFqh2kpk1NsrWJSnSpVZukTpn3g/hP6v88uI5LFyBXa150IdnvGD6QSN
        s89kIx5ZR8zuhohgA87biln5x7mR0xOhD5ar8xh5uA==
X-Google-Smtp-Source: AMrXdXvToR/HI1vmbVfGgRIUnBxWvezJbFl0uotbDHk2xQ7EEBk7DdMHJhP3LxNaPJ9726VFqavB1HbFpKIZ7z+Duzs=
X-Received: by 2002:a25:4fd5:0:b0:7c0:acd2:6300 with SMTP id
 d204-20020a254fd5000000b007c0acd26300mr1832961ybb.520.1673877979741; Mon, 16
 Jan 2023 06:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20230112184823.80349-1-andriy.shevchenko@linux.intel.com> <20230112184823.80349-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112184823.80349-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 15:06:08 +0100
Message-ID: <CACRpkdagk78QRRxXkcH4OtaqZ54T61=1ytuVWmsNcm23qjyYiA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: digicolor: Use proper headers and drop OF dependency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Jan 12, 2023 at 7:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The driver doesn't depend on the OF to be complied. Hence
> the proper header to use is mod_devicetable.h. Replace of*.h with
> the above mentioned and drop redundant dependency.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Both patches applied!

Yours,
Linus Walleij
