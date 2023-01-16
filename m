Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1266C07F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjAPOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjAPOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:00:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E722792
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:59:43 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 9so12895753ybn.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1ttIi9T1Jv8lKb+okwnGnQ8m/nJSHvTSd4dWJNzDLQ=;
        b=Vif8LIymrEdQfoBLSAnJaFmS5DhkZq2YJmQ0WHNKcOqgrS7vhbUV0ke5i7dnazftGr
         OB90m+1apbLbt5NKjRx3VF9QdlZzIMi+TIpsSaiYXIVygs3RH+YqlDQPvJBw26pw8cO6
         cgXec2cKjPCRY5rCPgrAjsPf7vnhhU6Ek0POsodoMIW1PbKdBXueB4TAqxQ/FI3uIeM6
         YXEl0RkchaAqubP0snNSXzucBZK35DISeNXKLMutsu2JQECylXQv4jbrBA3fzt86SltE
         1nT9tN2+5WDu7yQBtrnLl2FdOi0gvzAqFrE4X9J0w0bHW/OCOtheCbLlpIQXIaQXkm9J
         IRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1ttIi9T1Jv8lKb+okwnGnQ8m/nJSHvTSd4dWJNzDLQ=;
        b=UgCECPG7a1HIeCd9hvX1jwYHM3U7ZB1DkddljA2wf8Zhryt9ah/yvQ6tCES39vlrIt
         HrCq9z5Y3ZItYdw9eDGCG+2RNT8auBcEK3jzY7UTnZXRvkL4q/MQVgWZ2Flv9xDx+u8e
         zcnQ6lJD7ZLxHdFLrfQgSO8+gySBjGqFNMgp2cWnkgirpgGu6V2hMlQl620W/SoY1VXW
         LuPHG75omSexyYQIHg89Tc47ccxds56yjZeWi7R3wxdvV+3WkWffiBRmmHY2Goykq4bN
         YIBr6Ib5MLsKCvWRsmks6yS2rkrxLVLzxzFlDFwtjLoanUW9V8Txz53tSC5Fav3DXB5p
         ashA==
X-Gm-Message-State: AFqh2kp8uuhb35S9UdVYtuC4MRd0SjTKOi1NQQvKsTv363GBeK6WRv8H
        QCZI352gcTU2MJhY6I/py2Ojv1wBT0aACBEUAoES/kpmU6eeQg==
X-Google-Smtp-Source: AMrXdXuYW9CqEWNtglBTG66rTDEihKTr/73litVxbhWFGCXJq+pZNNR4vVLxhzq7EJdQ3J84HuKxTZXJE0NHL9kP708=
X-Received: by 2002:a25:b07:0:b0:7d0:afc9:d194 with SMTP id
 7-20020a250b07000000b007d0afc9d194mr1183633ybl.341.1673877582408; Mon, 16 Jan
 2023 05:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20230112134849.59534-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112134849.59534-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 14:59:31 +0100
Message-ID: <CACRpkdZbkKzcB-P0g_-QpbL6Bgd0XQ45Ax=7WP+nNNZzLrNQ6A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: samsung: Do not mention legacy API in the code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 2:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Replace mentioning of legacy API by the latest one.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
