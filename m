Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB266DE81
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjAQNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjAQNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:16:11 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD253AB3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:15:57 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e130so4421978yba.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=speSHNYY7UY/VdkKSKSzAPd+LB5tLtqCK38I+sQK0WE=;
        b=iuY779kCZkgs1i3TJHyaoB2OYp2y4UXVeAhDi5HqtuGQfjKC4jG8HrnzdB6SN3EkR/
         2nYFg5Zh5RbwdAQZGyYwV98xO4AgZMxYK3B1mx4o6KgC1XnnhnFP6AiB0VEVt/YxERde
         flKtvACWDm+891ml32I3GsO2iYHLgotbUxkvM8kL3CQOZ0u2UkENSHolMuQMLhMKE/xe
         LTQmekU+6z1QwVRup+9f7At80Pf/R1cuRMQW/4eoFu2M13dTL4WwmITVWqu5r14EUtAA
         Yg75DI449A7EfVw1LH1SuSVZpyOLLnOtCnVf2xcq6lyTfjyN/95YcJ4kwMkwfwb7yYF/
         YFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=speSHNYY7UY/VdkKSKSzAPd+LB5tLtqCK38I+sQK0WE=;
        b=SNzbb+NY86vN7+U66h54Sp6zHoY9RKMaxXXsuNs+o1TR6nK3FxjcinCIkdtOa1b+Cv
         g0tF+O4Ny5VWMVhc0lv/Q33cXW4fQgWnd3jtmU2Ci9HsuD5J1gp9wAsx+Od98XhtDJUU
         GPARLquH6OZsZ14ZuISneHo8pJaMN1r1/TqIm2SxKPJurHQEr6yb8ahLhrW8igDfN0DF
         4vzwmAvIBE9VF3T6c/O4GZ+r7WvY5AbZvwcLQ4+Ae975gZxtr6hUfbVG7G36Pc520frE
         dyXU3MC+Es5bANldnnuHA2IXqOEK6qUbPW19ZGGdJd28Mv9D+0cWVSo0p6b1/QNQBWgb
         4+kQ==
X-Gm-Message-State: AFqh2kqzsRpKrwuWNNu2+K6rtfhz2CHJAXksh2Eq3dzQ2xJBcJHlqF4a
        RzpvbTNr+bwZ/ybZ39J1zXo+LQAvXqiOtsptmpk1yw==
X-Google-Smtp-Source: AMrXdXtQJRhkiJoJn3gtcZ2O1RYFepN01V3AepnypVv38ICpDuM0Nw4YvhauZDgojFLioy3ywrONiSypPavhEKGex/U=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr320846ybp.520.1673961356936; Tue, 17 Jan
 2023 05:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Jan 2023 14:15:45 +0100
Message-ID: <CACRpkdbVa3XEDzcuy7iCqx0cvj4trzPe7N0B5PswA1mQ7O+GtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: Proofreading and updating the
 documentation accordingly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 4:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Proofreading and updating the documentation accordingly, i.e. fixed:

Both patches applied! Thanks for your usual attention to details.

Yours,
Linus Walleij
