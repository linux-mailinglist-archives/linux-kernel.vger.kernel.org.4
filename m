Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD4F605EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJTLS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiJTLSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:18:52 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7191B76F1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:18:51 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id n5so260580uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4yNfgdYt57OohzxwCH1esBxLVu69+vmUe2ikK/4LWY=;
        b=49vtJf0c5It2Iknt3l/k7+opjdNuUF0nINt5E5Jy21NUgXQ1441CnbelIb+Zb8Iei7
         tbadreJlDzHpoy9h6p81ZK959n3IfECQX9ifwUelTq3Vn3krsB1RSrDzt5XhNOzqLBWB
         RLwqkOxaKd0U5WSQEyvmtJXOf4eZbSwo+r1a1HEmJG+kpflgcYM8RHdJg1D8MfrdE/ar
         PngTM8W/U0BR1Fdoekw0M+/ghlnZCqvnq1Wn5VEVkLLB7rh6gjALftzuadmFoLHngmpl
         K2ID3O6/sb7ssamZDFSise9IRPr+GL1uxwuMFn/yS5vpgdhRlxNBuLmOYlchGGlpJW4b
         DV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4yNfgdYt57OohzxwCH1esBxLVu69+vmUe2ikK/4LWY=;
        b=HAxASmBBlCam5ecQAQln7ASUM3ehVZ5tpZXtNc69y5RiJkWYryNSGtflBaAtUOijSa
         GpP6TgqOdksHxGW0LHboEcH0wXSHhE4EcTmaB98Yj4ICfZYuJBgtu6svSTMklYPxboKf
         8S5v+zD4yYZnwyTmBc8IsPYTazVZJ8k8VDtxUtam810Pi8SFUDe0beg/4XUaHlruIC1N
         N/9RefxlQc2oR9UqPBOwnosiG2rhXJMOW8aRdKwbgWWxsu6lVkWfPf6VyiBw27dwg5AO
         BoIBcTTJYnzApcqvNUOnmKUXQ0JERShidfgoNC6wUkk+bXNnM8sHhcXYjnO5dZBC0L2z
         haOg==
X-Gm-Message-State: ACrzQf01kvFSjm+E26SF3iazTCX8YvtiH181XsvqoHYP85jOcOrgfQhN
        rpTxo/MWc0BCZ57j8f0f8PXZggY4Zr2zPxzxR87H9Q==
X-Google-Smtp-Source: AMsMyM762bnsENd96YRg5cs5iK+jXaUnjmTAxCH71GWL6OADkqGRfA+/Q9MVteIpYcE1xjQ6HSh4XXVvA4ehsuW7v9c=
X-Received: by 2002:a67:ab02:0:b0:3a9:9953:6471 with SMTP id
 u2-20020a67ab02000000b003a999536471mr4291701vse.47.1666264730567; Thu, 20 Oct
 2022 04:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-12-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-12-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:18:39 +0200
Message-ID: <CAMRc=Mcph92ir5KgSr5C4UHAwCz8MkyykR2hBfgv4NS2rMcLHw@mail.gmail.com>
Subject: Re: [PATCH 11/14] pata: remove palmchip bk3710 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This device was used only on the davinci dm644x platform that
> is now gone, and no references to the device remain in the
> kernel.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
