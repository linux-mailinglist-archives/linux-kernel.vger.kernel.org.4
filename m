Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19E6CA0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjC0KLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjC0KLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:11:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E184C3A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:11:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k2so7922438pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679911866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twtYyYoF/UoDm5Qj11L0J6nePz6i85dUG0Fo6yWWqTE=;
        b=bdQCIspE58G9YPUxsP9y9uqVhsHZwYTBZvh4rAbqE8SOypIyj8N0eioOD3sfhurSxo
         7LDACP2ZgZke0nlPoD/AKq11KfU0NNQViIPLnFQphxtRrMPS82r5eDFy05S1nUA0xF+M
         FfD5OG/PzPrqQuf0V5EDV73u3ZLhIg5kgD68LQGvSOKXvwX1sIinZqXZXk8CRhKKNNRG
         q9KstHuSQc4T+IVKkA8gkDy1ADLVTRMpuzIsGwwuBVgaA744iHiV5r3Lyc0T0XC9ylTR
         yLA2QEebEB87GnmDalG2YoNB/NablHzPjQc/aPOKjm3eyLcZGMDobrPHKAbYwcbz7HVX
         s5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twtYyYoF/UoDm5Qj11L0J6nePz6i85dUG0Fo6yWWqTE=;
        b=D8M5OfmGA99fiHk4P5lGOlkM1unf5xU9cbU39Q8yl9zX8b0FekIQEt5zHgkthynNs3
         klYbRaQDnhtvlyr8F4nuamZwIPjUMRvWxjincOJUDpO1RqvvVRC46+A3G84dXOLB9HFu
         qbDxWNU+KWD+hFDSiSGcsjva6gXnSHGTC4hbcVJ2s66molOxzvxFSickMEJniBOdBXAw
         tsJUHpLg+W4R+ZGAQ2ExaN4oNihZph4MGs0fwvwz98B3Ki1UYGMtbhJhNQnVYEmc1KSU
         2V4HwVUh1ANnpKIkijEBXNcwC/FwXGY6/v79rjjEaXH01Ev5h3W5tEE1CoxnXyVoR3t4
         vrXw==
X-Gm-Message-State: AAQBX9eBLcEo9vYp+18DKeM6o2z8HXu5StrR6lkT9h66LrsRryiI++HY
        HfZ4pRKqmAkHqfxJnjH8jTIsdl4nprleom1BmFc=
X-Google-Smtp-Source: AKy350ZhejNcYVfp5WFMIO22GnZjqYTTIAQAiwm1yYquX65BOUfzXeBHoRbZ75q+AEZj/mnFVY/Z2tWYx0OFRXkYXK8=
X-Received: by 2002:a17:903:2290:b0:19f:30be:e9f6 with SMTP id
 b16-20020a170903229000b0019f30bee9f6mr4136675plh.6.1679911865764; Mon, 27 Mar
 2023 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230323111924.102541-1-peng.fan@oss.nxp.com> <20230327051409.GO3364759@dragon>
 <DU0PR04MB9417EDFAD943EBF9F0EB2A35888B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417EDFAD943EBF9F0EB2A35888B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 27 Mar 2023 07:10:55 -0300
Message-ID: <CAOMZO5C-x6WVd0xbKej7OaPS0BdhKXOb5QLgQmGu-MyuKNChiA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-evk: update i2c pinctrl to match dtschema
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Mon, Mar 27, 2023 at 7:00=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> > i2c2gpiogrp
>
> Sorry, I not get your point, I already use i2c2gpiogrp.

What Shawn meant is that there was a typo in your patch.

You wrote i2c2gpriogrp instead of i2c2gpiogrp.
