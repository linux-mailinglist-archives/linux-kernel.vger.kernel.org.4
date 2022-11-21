Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B876322D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKUMso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:48:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09720B4830;
        Mon, 21 Nov 2022 04:48:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g5so1853946pjp.4;
        Mon, 21 Nov 2022 04:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CD45poBiHioVMndl+YIuWBdAcu+6EbHvtR808B7LZEA=;
        b=ayhywpp3ObtSZJBjbSWWRNUB+ZrQKYX85wWBoa8L8/KZmJ3imMPMbtsQt0V+gdkhyO
         zEc3ZfUZ+h+w4DWst+Jno/WqlIkqOQJR5sK38JANjx1etim/f56svAgBBnK3CR2vXgzz
         dUZtr3rGcJsq+1RDkJKUofWcWuOw82hEeG3p0+fBfr4aV4D5Wdn7CPWEN0O1Y9J5JLf3
         iQzAhpr3BSZh3V7iKOzrJA7YO4Y3xSJoXCpAhHfBDwbQezZFDi0qqtLQV0EN2Me3u6Z0
         DiWOmbw66PDfiYs36Pe3iNIR4KWdvdTiLE1Ie43QQbWlkCjOvaN6NmM+G79GEsCvEJvU
         uvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CD45poBiHioVMndl+YIuWBdAcu+6EbHvtR808B7LZEA=;
        b=HvJ2o8iGjnvT5fvdfxVZ4Qd8SIXcxaPAt9QYNWxPABkZ+H+xgE0pAQgbaddJSg3Kq+
         WgTznYvLWg8+l1bN136lkcq7GH6Dfx9DjjLO4N2NH1D4g+JYF5bejEzP0qClFiQ99uvX
         gV/0aWorlJsZPwx2zPSOXPM/NMyZGE8SSSgSEvDvRjqewr+wZP71hpS5Vfy+TxBes6Lf
         VONQPKG8Xy6qP6u2a+UeT7fwcW15p3lEQbgWIOO6dkyZFOkk9J50y3LYQm7cjDF7YbjC
         pIkf+1GCbNJ2wWCJroKRa0ik3vVDT/sEucTMVqNfbJu2WHtWF0C3pr4XJrzWb3G9+qB5
         VHRw==
X-Gm-Message-State: ANoB5pklqJDv9XC+nMwIfv2MsZt0meVaLSEumv7L5NDeoM4x+9WAsnad
        v/Ib6eL6lfy4pQQZnn1oz0/h3BSJn5P7KU7y7+g=
X-Google-Smtp-Source: AA0mqf53o7pOYJpWpVTHWLgvW6H1ruUOInM0L/OZwG8IRQCU6lpPMnugC/MRaHpXsAIf5Jf9WAh2WQMJi/3FC3Te4/M=
X-Received: by 2002:a17:90a:7004:b0:218:ab86:3acb with SMTP id
 f4-20020a17090a700400b00218ab863acbmr6195776pjk.195.1669034920365; Mon, 21
 Nov 2022 04:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <CAOMZO5BPtEU6VCZXRk5FTHXDad6cegF=+oHTTA0wgjBuoh9-rQ@mail.gmail.com>
 <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk> <CAOMZO5AXSSkHpeuHNRQ6qkFoe2uiFLVxndz1u7_y7s9cLD9ppw@mail.gmail.com>
 <8cce4dae-c653-515b-1a5d-024986afbabf@rasmusvillemoes.dk> <CAOMZO5CpFXjm1a2C01=uiHLjcNSe4MzgLUyfDvK0LCdQ8+KNEw@mail.gmail.com>
 <2cb72f22-3e9d-c146-734a-ec0b306bdeb1@rasmusvillemoes.dk>
In-Reply-To: <2cb72f22-3e9d-c146-734a-ec0b306bdeb1@rasmusvillemoes.dk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Nov 2022 09:48:22 -0300
Message-ID: <CAOMZO5DZwFq_g4PCdAUNnwFGyvMFsEb3pBFbnSAJFVdYACf5UQ@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 9:29 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> Thanks. Does that mean I can keep your R-b for the patch as-is?

Yes, please keep it. Thanks
