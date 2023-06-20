Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65506736C62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFTMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFTMxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:53:20 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76C19A9;
        Tue, 20 Jun 2023 05:53:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b5422163f4so29130645ad.2;
        Tue, 20 Jun 2023 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687265590; x=1689857590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36Q0E79+X6bNneD5gDA+F7nctDYtSY+gSKV0kemn51w=;
        b=biZQsAESZ+D1x6A0v1zqe/1e4BZaCgoEsQ6FzOWn3p2nkjLod+TPsvmNIIUxxx7Iqe
         4O/qBQKOMyeabo0VPCOC47R1gnS90F0ofGDSzSXP48DlY1zcoyGnK1r8rCqIsJDJb3+D
         GCD1mSc94t8CYjOkmzNoqpxK7juIAsKqDHHDQ0Qw6vsi9vYHjacSGB3jHKpiaPtthleY
         nUkUFUbE6YQcrCrquSVTk7vNL75h9BkYG7MP4SMrNfP5CITzWgENVOUlSUEmoIlqdPEO
         3j88WEA6pWnbcK4ZFw79uWx6NsrHJ6RcVDDC1CCiIZzwJ1ap1yt8Ri5ruSrsYshYrNxo
         Yrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687265590; x=1689857590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36Q0E79+X6bNneD5gDA+F7nctDYtSY+gSKV0kemn51w=;
        b=L+eYbB81kZGz6nt1qCiMGgesh+rKXS8rGY2KG+ceJyFq6nFc3nwNBTHy2jLYeMYEYW
         93dI0n5Nvee+uPsFCGBFEumSnTUMuLlX0ShBR/2EgymJApt+WF1vv6LjALBU6y6dZDvX
         IcqWMigCvjpy0ug7vtlmZU4bS59RyfOz8Q4yNBc9JiEyWohQ/m0e31UZkrVnXyIDcMTz
         aCFty+noEKfSy03G8/ZT4XqzoyW5GzuBJLalE1UgHUyy6Sm22bAzlgiDtw8PuanRHbTE
         6EccWOfW1y+NEI1tK3nBYl7aeLUnr8pfWPSBjQRwiP3PyR8iKZch9ea2ZjpWAMlUVuAN
         ymuw==
X-Gm-Message-State: AC+VfDyGD8O5oHZ9UXKM9ObNl3RH5ishjpsqnSSbZiqysqqVRO9Jd+ID
        UpfdJaiKuCSM9YHFdhUYaQ4AbKXf2pcmp3X7HI6lvrwgtC9uSw==
X-Google-Smtp-Source: ACHHUZ76WSq5RGqhOitBXAkf/k6nPDKOSPAANQfs50njYPaQLIfrVUw7wInfRGDjJSuF2kvn1h1zEc7LSN9LNzG/6k4=
X-Received: by 2002:a17:903:41c3:b0:1b1:ac87:b47a with SMTP id
 u3-20020a17090341c300b001b1ac87b47amr15870276ple.65.1687265590088; Tue, 20
 Jun 2023 05:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230614134716.1055862-1-a1ba.omarov@gmail.com>
In-Reply-To: <20230614134716.1055862-1-a1ba.omarov@gmail.com>
From:   Alibek Omarov <a1ba.omarov@gmail.com>
Date:   Tue, 20 Jun 2023 15:52:58 +0300
Message-ID: <CAKyg=SXGbk+rtH_-PVbKgdj1LoWSxuq0=SU6FQH_U879fMeY9A@mail.gmail.com>
Subject: Re: [PATCH] clk: rockchip: rk3568: Add PLL rate for 101MHz
To:     linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SCC_BODY_SINGLE_WORD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bump
