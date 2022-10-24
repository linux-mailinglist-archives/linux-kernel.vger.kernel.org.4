Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853F760B83C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJXTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiJXTlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:41:36 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074820BF2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:11:28 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id j188so11682786oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPf6G/73Hd0s0zh7PYg5rvhdRmvS3jQjXsc+lqFusyc=;
        b=VqWBCIK/C1WQ90TmfBoFBitp3JjWUevS28dVi90N6+e5EQ5xP2BQeMzZMbszC+LR8n
         i1M2zTwhKUBuiyQR2d8nC/1gInVUebU0B0kA/5kwcPWNvUGIZ+0vWMhTXQ4+Do4kFLPs
         KqOkvYThZ3gwiMd3SC2693iUUdF22vTeDHmuUxG9bEXubLD6kSR8V7OXBr6goIyRwtck
         O0J5wVfprSGwg4uqxvDk7Pi19d+U6QEadNigKK3afY6xRnuojcypLkMcsPoNK8sbOQ9y
         9EH3ELhR/5a7Wp+l4lyXs6kpxfHTx0uyz4OnsNgGycZSB4iRr1WsnMyXNr9R8mjs9+xi
         w5eg==
X-Gm-Message-State: ACrzQf2uJI79AEaiAuOrqLW7MwYkTrCBlMm7j9OH0b0ueLKq/akUTIn7
        VqBLEs3khbsrJt8hQEybtJa51ejVvs0oN2QDD0Leyg==
X-Google-Smtp-Source: AMsMyM4Gm7Aig8YT5fRJeyMGddzfvxxYUrUEmpPq2PCQ/RGA1i1Qlql9jRoJlFidSVPdqq8RCQds4g==
X-Received: by 2002:a17:90a:fe6:b0:212:bfc3:31f5 with SMTP id 93-20020a17090a0fe600b00212bfc331f5mr25482041pjz.215.1666634594766;
        Mon, 24 Oct 2022 11:03:14 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id mj19-20020a17090b369300b002131a9f8dcbsm1291814pjb.46.2022.10.24.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:03:14 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, Bin Liu <b-liu@ti.com>,
        Helge Deller <deller@gmx.de>, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/17] ARM: omap1: remove dead code
In-Reply-To: <20221019150410.3851944-14-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-14-arnd@kernel.org>
Date:   Mon, 24 Oct 2022 11:03:13 -0700
Message-ID: <7hbkq1hzfi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> After the removal of the unused board files, I went through the
> omap1 code to look for code that no longer has any callers
> and remove that.
>
> In particular, support for the omap7xx/omap8xx family is now
> completely unused, so I'm only leaving omap15xx/omap16xx/omap59xx.

Acked-by: Kevin Hilman <khilman@baylibre.com>

with a few tears shed since omap7xx/omap8xx was the first family I
contributed to upstream. :(

Kevin
