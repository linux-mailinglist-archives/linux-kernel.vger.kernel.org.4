Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70F631EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKUK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKUK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:59:52 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E759E95F;
        Mon, 21 Nov 2022 02:59:51 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso1747138pjq.5;
        Mon, 21 Nov 2022 02:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BA5PxtGiUsCZ9o2M8Np4MQIC5EXCplZc1D9t1PWgXsQ=;
        b=iZBBxT0FR5nFckpM99wxqo3CAphNatCWMTcU1iWUpPdbj27cSn8n6RGaPL0/0wO3k8
         k5ctEC6rc+D3qaadbYqjuCwY4+epWxeW7VdSiRRZ5XE4NX1BYgZGlm9BaGBQNow5v7Dz
         8icNDgC6+YHCTwXXZD6GKtzd95Tm+w4tgVJqc7pG71lfHwEyaJ3BqXo6BH/YutbngEkb
         CFDu/rxFiHGpogPZ/lm9O4nZI2rNOGDSfDabF+tiGpfOoqUVg/GQUygQAz34/I3WXlHC
         uNZmstvLqObxV6u+DioyjG3CkchBx7IPOzwK1zaa0UFaTaobd+ij06APCFu2iGu9iGzR
         PJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BA5PxtGiUsCZ9o2M8Np4MQIC5EXCplZc1D9t1PWgXsQ=;
        b=4BBFBlLZmbGi2cWCN4L/ASbAWz7P01hZAeaMjI9W4Ahveb3B97/xeVViGAWGhcfYM/
         MEmly9rSRJWe3H3fqxDylBzTc7rnGUOLixzaEDuYAVHU5B15wLR+S3SpeYLkJsdYfVS0
         iTKR5pBMnoVyo+O+g+bfgqSeqhWomBAqb4fWML5Pq+cP8IBLV/KzWzvLwZ1zR+CEPOaW
         etNAeiZ6vRzflOyKI9Ys4jVWWpg4IQFZ/GpibkeeCBKlDG2kH9UpGNvx+d66BHV0vVns
         CNMaVyGXNu9kjnV9+uQfhMJD3TyoFEX0yZgCY2AKBF1S0p7x8LbO04SnL7wD2n/BXGkP
         Mbqw==
X-Gm-Message-State: ANoB5pnU2kTwzNokx1Hphh6Qzg5boZT88/hLq+f77mY0akYYTa19XPwU
        bZXn63DqMEe+WbpnbjCovB6OnzTYodZRVCAfJ+K3PwfE
X-Google-Smtp-Source: AA0mqf4YnjqRjHru/Zao3sO2SqSc3fcg2mA+nOGRKm+vwVpRuwFVR7hucvrKPDC+d4lLJrc9fuulPcZQEh7/WfXecL8=
X-Received: by 2002:a17:90a:7004:b0:218:ab86:3acb with SMTP id
 f4-20020a17090a700400b00218ab863acbmr5765589pjk.195.1669028391342; Mon, 21
 Nov 2022 02:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <CAOMZO5BPtEU6VCZXRk5FTHXDad6cegF=+oHTTA0wgjBuoh9-rQ@mail.gmail.com>
 <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk> <CAOMZO5AXSSkHpeuHNRQ6qkFoe2uiFLVxndz1u7_y7s9cLD9ppw@mail.gmail.com>
 <8cce4dae-c653-515b-1a5d-024986afbabf@rasmusvillemoes.dk>
In-Reply-To: <8cce4dae-c653-515b-1a5d-024986afbabf@rasmusvillemoes.dk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Nov 2022 07:59:33 -0300
Message-ID: <CAOMZO5CpFXjm1a2C01=uiHLjcNSe4MzgLUyfDvK0LCdQ8+KNEw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Mon, Nov 21, 2022 at 6:44 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> That doesn't seem to be true. To test, I just built the imx8mq clk
> driver as a module, and I could certainly both load and unload that on
> my imx8mp platform. Sure, no "bind" attribute shows up in the
> /sys/bus/platform/drivers/imx8mq-ccm/ directory, which is exactly what
> one expects, but the module can be loaded just fine. And since it can be
> loaded, it should also have a proper __exit call for deregistering the
> driver on unload.

You are right. Sorry for the confusion.
