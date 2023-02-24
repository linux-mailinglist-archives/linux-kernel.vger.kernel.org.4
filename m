Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5593D6A1E46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjBXPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjBXPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:15:12 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BC1026A;
        Fri, 24 Feb 2023 07:14:30 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id v27so14282121vsa.7;
        Fri, 24 Feb 2023 07:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLFJlemgxUP4zmekRB5aWOhb6GtCq43P1e4KVbVEABM=;
        b=PtuzvOm8AkxjcsL/YFTT9kogXXLdyIiVdJmOBdcOeONocpAIHeKODBomb/Y7d5wmEs
         fJwir++HOqAZ/FgwAPVT/gXpO1MqrZbJfZQWL7LHupSYskx6p+X48eygUVdJCFJSbhQs
         +lpYs+SW0hvwlDqLPfgQigx3TDguk5StAp2ZHh8VbcAJeYfJrwaf3EH74/1ln1kkPGNj
         k70a/cnFjB7xgRYjXQl/DTqMj4QnQcUWXTw32MtsdT4MDjLoqy+d0KiA1w1Vgk0oirTw
         qI+TVs7h5VQ+Iv+KQaLmUO7TvxEeNyeYr7lYKQ/fAtm+Z1u0Pd5WPLg8vRguD1Qsf/a2
         RiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLFJlemgxUP4zmekRB5aWOhb6GtCq43P1e4KVbVEABM=;
        b=5nBXeg3t6OWsVItwzXuaSSuMtrNijBqOjia54BE7WuNp9xeQyqcQFbDC3A8yzQ2S6s
         YIddDtzxrlYo7MDAZ7kD58sAfnHSenzFAmTbEqo6E31Cw5Sa7OFOfdHh1JxQvRLAxh5g
         lKcvAkHFmhsT42IxJM/JEtHq5vRxfPAaWT5WfU9+4gxAVk4VdZ9jx2oaM7FvB/nZPNy7
         c2i1MgIELX7db7e4m4fc4v2MLppD+uMkbAzs7YplBeS+07Gr+5LQ1lxDHb0ifdzQuZ2z
         8IoAgdS3fbRK7X/ekGpKUdVSEqJqVPymx0EoFFVh4AUVId691U/DwNXUpIwXzWIQ4sPq
         tB1A==
X-Gm-Message-State: AO0yUKXf2Bxdr6cLe1cLBEMB6fDZQ18ajTXo4e1pld8+uQ7gY/PHBNPE
        Q3vPu3FFwAuAdEz0ffjK9FRWuCvstmxPEBU4VnE=
X-Google-Smtp-Source: AK7set9LiZ49vpiIkbOHzXWEtVIW0PGqKOHz9mI8lvrbqokCFJ4vRaSdLiHwvYoaQ66Rte5CpIaJJ5gZ6XJ42U+Mb8g=
X-Received: by 2002:a05:6102:3676:b0:402:99ce:1d9f with SMTP id
 bg22-20020a056102367600b0040299ce1d9fmr2533581vsb.4.1677251667429; Fri, 24
 Feb 2023 07:14:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
 <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com> <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 17:13:50 +0200
Message-ID: <CAHp75VecFVO4jZa3T7P2N5u4fSb-ruFBv9juyCaHnj8HVTPvtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
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

On Fri, Feb 24, 2023 at 4:42 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

>            Package () { "gpio-reserved-ranges", Package () {5, 1, 7, 3, 11, 31}},

Side note, doesn't it the same to

           Package () { "gpio-reserved-ranges", Package () {5, 1, 7, 34}},

?

-- 
With Best Regards,
Andy Shevchenko
