Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841845BB74B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIQIky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIQIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:40:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF218B35;
        Sat, 17 Sep 2022 01:40:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g23so13023662qtu.2;
        Sat, 17 Sep 2022 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9i/qIEmdGSzjwEl9InA+q9QSanWDSVkhjSJ9z31wPZ0=;
        b=dyfJRy24HP23F31C3OFOYeXPqrEiNsdqYY8RmsvRzJEOV6elGRpBs6TDZzNMFVtiay
         HHfExDfea39JwrB7BdyrJ1LLbh8fKT62FwkhZL2eItEGZ/VYmu3XQCVe/NxXoAmq9Vbw
         mo7VVbuGmKz+lV4ypQLxHNO3zrM5ncuZAA9xHm01hyBIxKu/KsNcn7V99+S316Cip8sd
         SWBn7Tyrv3vbFimwj3qq9lyCg16+3RigzjTBgohZAtVyNsmwkWQqTYZmOe76Y4Ruz6rH
         +0arUi/g4O71zojSZErAG0iRJJ0SEe4bQY/7vx+VXrD8TQxfBmWVH81NFUm6d+0Tt+Yd
         c+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9i/qIEmdGSzjwEl9InA+q9QSanWDSVkhjSJ9z31wPZ0=;
        b=KicoU2ff0ZRwvC6WRkR7rB6toR5s9aOHeD54KL7gLkJNIkM8CUCT+2Oz2lIxGzU+EE
         Vlc07sRVw9l6KcovvnOPbDgzwtntBcuF9E8Wk/x/2I/G/OljHZzB5TuE2vP6IxQXrc9n
         DiKOAv6C9Sjq3MPzuiqo6WLUQ8XLdanFTMYf8oJ3cfM8hi8YvjvIa5AtkSq86Qb7ZKu0
         gSwp7HD9WOz/98l8KExgWl93urYVhnjgaPSvt9jRPv18B9nvyj2FZz3IVoiX8HwWkzw2
         pk1XWvHwaEQQjxhimoo1UszzaKZxD/VR0UP61gyGwsb1x9MdRPcBpTRy7vdoR8RFAq4g
         RQfg==
X-Gm-Message-State: ACrzQf0KDuYQ5fWrD1rasdMKznxerlLuMonPTNfyGwl65xKuDCrtYcTc
        R2HPhQo9NrIcCQbaQ6MwHYCA9+wsWV16OzT7fH8=
X-Google-Smtp-Source: AMsMyM5F6SzNVvzf+Q5UfjzMpEt1Why6+pa6Z85XXIcEKS3YmfgURYAZxAvjkjfW0l1bYZWnM8ZMJGA8r9B7TyTtrAs=
X-Received: by 2002:a05:622a:1701:b0:35b:b3bb:7c4e with SMTP id
 h1-20020a05622a170100b0035bb3bb7c4emr7401802qtk.195.1663404048370; Sat, 17
 Sep 2022 01:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220917081339.3354075-1-jjhiblot@traphandler.com> <20220917081339.3354075-3-jjhiblot@traphandler.com>
In-Reply-To: <20220917081339.3354075-3-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Sep 2022 11:40:12 +0300
Message-ID: <CAHp75VdpizVEuWeOpzgizbYRy74b2c7Egx7Qwna=by6rW5Zo1Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/4] leds: class: store the color index in
 struct led_classdev
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
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

On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> This information might be useful for more than only deriving the led's

...

> +                       if (fwnode_property_present(init_data->fwnode, "color"))
> +                               fwnode_property_read_u32(init_data->fwnode, "color",
> +                                                        &led_cdev->color);

Is it already described in the schema?

...

>         unsigned int brightness;
>         unsigned int max_brightness;
> +       unsigned int color;

The above two are exposed via sysfs, do you need to expose a new one
as well? (Just a question, I am not taking any side here, want to hear
explanation of the either choice)

-- 
With Best Regards,
Andy Shevchenko
