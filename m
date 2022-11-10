Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603C1623F15
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKJJyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiKJJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:54:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F12F65B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:54:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id b2so3593305eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xevay+FatCNgIgOdMn7/OhB2kL2/LvApT07x7t4mx6E=;
        b=C6t5Jyv97v2b3isQhO/pztgaUXISCEyKpDujB5ciUosZXi5q335QRhBRUCQnS8iqWu
         x+n12cSTpCU1/kOGk0NxDvupQ+dktZoVrFFe3SaQpVzY90CXIMSAyYXVZuEvesk36jTn
         qRNTnPjCb0RER1nSteM8XWQA9GfTjO5ahl4osvd2pmmORB0F6GCqPkyjUA+/ISUi/bFj
         wo/9iEoImctmXGfeIZH9vbmGTxhHDt5YPSCC7uSURY2WYUZ26ITOT5RX8yN7BI2iVzq5
         XnejdJgPTJ2xW0NuIiYqKwVvz1oMUoL+MzzNW2tEy4ijj2P9D7AvxHFQcMlpVvS+XONC
         MnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xevay+FatCNgIgOdMn7/OhB2kL2/LvApT07x7t4mx6E=;
        b=mx0OtqOciAKNuP2WN5cx3AKbUW3lrH/9kY2WYcUZQZ//p6KefR8xnNc+fbCYbjcsTo
         DJMF1mH5naSVHj4dC1QR8PxA+mQpAIWvE7szc12jSZXbC/sVo3k4GSvY05gIaquiuEC0
         LblwzFOZSPGrCjk9/A1Y/fsTP9wSBwSaq4/z6TF0QYFm/oZB4G3LKo+iaOHPc7ViIQDG
         Ti/iYp1CHkDPJPKqDnVpA+ZmVfyj7vQZRu4lL1Ypc272rH6cSbMHizutl2JUTtZKF8S/
         u49je4cX+MT3nM8QbKMk8fo9REvGWFUPND/0GJtH5Kq9tzOjtNxY0CbZZgPKMkgbt8y6
         yHrA==
X-Gm-Message-State: ANoB5plEs2KSKFC08X1TSI0MNyJqlntinrI1qxmGswI3IQUR6BtfHZJD
        wC4IZn3AXKI9CTqORvVcktgHrN2SjstSxef0mhJTDQ==
X-Google-Smtp-Source: AA0mqf4F2g8JJZa1qi8tyAuP2lYn+3e3X+vhInrxNn/UiLA1L0u0h/sPC5hycIQFFUMiE2PXsv/PnYirMi06Q4Ks9Ac=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr17374736ejs.190.1668074042323; Thu, 10
 Nov 2022 01:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20221109152356.39868-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221109152356.39868-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Nov 2022 10:53:49 +0100
Message-ID: <CACRpkdb+Sf8un0QkvxVGm_fH0fnC5U60HtUDdXvyyd4o6c=iEg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: Put space between type and data in
 compound literal
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 4:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It's slightly better to read when compound literal data and type
> are separated by a space.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
