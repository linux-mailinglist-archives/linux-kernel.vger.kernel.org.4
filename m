Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B665CEC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjADIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjADIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:51:42 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72B1CB2D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:50:03 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id f25so7401805uaa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3m8ypz1fFbj8mPUAsbdHRgs0+/C7FMCVRtO0ZGB+cgQ=;
        b=woUgC7uEewAlc/w1ReOd1/GGUmTkxzjZtRqYhfvs+L8cGq9aOhFh5PA7bfE43XrMBv
         5g1IzuwihIZ+6YaRX7EK4lgnBEyOuJau/F+NwLFUsQppqYvO8SJlBBOvBbI6GOClPIBb
         4xRBzPTtESloEuSOasT+BcITwyUfIvcX5SrH3vYs4leK33BRyz8eHQlqLiCw9ksBek5K
         W/RzQDu+9hkdXxBmXXUP71RSKwhHhs2RBvOBCmrWxM9YT5QADAZuPGAJ3NVufkc5/fl+
         HT8omymLmMBd9zXnn6j/uxVEewt8hvU9ZLHe1zwEAvzqQqVuSC1pgEU8LOt3DbbaJDVF
         oJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m8ypz1fFbj8mPUAsbdHRgs0+/C7FMCVRtO0ZGB+cgQ=;
        b=iFV7jxYjZhmUgfwSudgMgJ5+OKcdFWUtUCSR8/GZilULNFQ2qOcoXmgzcUD8gAZYy6
         MEUL0ZwHb3A4Y7WoahKFavJeqXUhhS8cfemYY/3xlpAY0/EsZHV686CabkPeVPRap499
         /pDdzx2hvt1poqrvHdj8EnjYRRQllv1vFzcIrypioAoMNhAH+8GvBpNiLCdqc2CP9VDc
         OJGROGyXKh3D4WDKNnjJUBnLXIc2xliebL5y8f6QlqiI0FQz+MMyZ/eQA422mIywffFA
         3mC6Z5T3QfGl93baICOF8ClS7CYgkmXTxnlDiFjAhsszo4Tlfz/UYN3sgvAgbwJe/eoV
         25Hg==
X-Gm-Message-State: AFqh2koJFnF7O0ASSpPN5/RwDFWXjCE/zkQwzkY2MIjTlGUB+ZwXvYhT
        SrwGhtyDepLbcyytquc0obXHOQ/TkFP63EbbCqgC6w==
X-Google-Smtp-Source: AMrXdXvYMjy/psxcNCIdxU++pZnMtkdyluLcPesKj857WShO2HCqnJPxwQp9TmaDAXiPKU+vfFA2kYYnp05HHhgTlkw=
X-Received: by 2002:ab0:2bc5:0:b0:536:2116:fbeb with SMTP id
 s5-20020ab02bc5000000b005362116fbebmr1859982uar.56.1672822202769; Wed, 04 Jan
 2023 00:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230102210850.25320-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 4 Jan 2023 09:49:51 +0100
Message-ID: <CAMRc=MevnkijyeAUEv0_aRm+Zf+PToTUeiXwVYGcs_ZhP4DWUg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted gpio_export_link()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 10:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> gpio_export_link() is legacy and unused API, remove it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
