Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32125BA591
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIPD5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIPD5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:57:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417045789A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:57:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sb3so16932498ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date;
        bh=c1vZW1LkIQMh3JOE9xbbE+19WtGE6qQmH/1emm+6U5c=;
        b=d2/rprdjdnImplKdu8NBdSV+1xD3IPFZeqzJ0of6mRnPxEhxvUAm4T2+TncWmulXf7
         f2WC2ob7+sr93maGwxitexvGNVLGvnGKorpC8c3faD/icpE4ff9VzoG2zYYHDtHudpi2
         YyW5gsyKTTdVYKgDfrtKbGseYGLbvH47gtme8Qa37v+3h2koXzHEcFJqU5U4Ul/Un+MJ
         q/OrW2uPckQ9oAm/tdz0a5t883DmifvrYMw5RFfhq+3FX7lOQKpK/6+Hmj9einawQ3Pa
         m0Xh5aLcMhCPZgUFx5nnevMepxkCHJoO81F8qgzVthYFLp5XaEF8QV74NoToroPTy7KE
         fnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c1vZW1LkIQMh3JOE9xbbE+19WtGE6qQmH/1emm+6U5c=;
        b=zw1bh94VP6dfUzhLGZqQNJH+Xsvo1zvlb5x96jtqniaFAQcMsc2PlNabnvTc+7QIrM
         /tlSsqegq14QGgH4l58FNPltgevds/HuIGs2fPhGeUPbnwfFa0HTwFWVAg0V7dinQwUZ
         dtOU51/PwfWc1G0eECq+QBnfXopoR9pSEEJaOGHQpmi3H5GD5VTwv78AaJYvdtIfBUPY
         HmxFLQN2IfEmER36tqmiayghM11N29ge5qdd9aHyEYx+V9ACHXz6Wo5yh5a/dfQn08uS
         bWFDgM+JCt+CNy29UvP6zoQDC9LISWXoj2dpqNzzEHfV2WrtNVpXpvnMRoo11sW73zPa
         uZug==
X-Gm-Message-State: ACrzQf0OF159mpIex8Caa99cXr4yQnEgJRLR8gnIkwTxji+6MqFwM5lA
        unhboBJWT88WpN+O0yDUeESc7QzWa0d5B5adoWU5KCpZHvE=
X-Google-Smtp-Source: AMsMyM7naKhKCDwgYhvanZve9GKBuMXBPsYRF1E9dqQQEa4qD/5YVfF5q3XBVAU7Lq8fA4GUcxP9Lqh8Qgj7ykWXJ8s=
X-Received: by 2002:a17:906:8a4b:b0:780:a9e3:c042 with SMTP id
 gx11-20020a1709068a4b00b00780a9e3c042mr399335ejc.307.1663300620145; Thu, 15
 Sep 2022 20:57:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: teko1maeva@gmail.com
Received: by 2002:a05:6f02:c088:b0:24:5ba6:ae9a with HTTP; Thu, 15 Sep 2022
 20:56:59 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Fri, 16 Sep 2022 03:56:59 +0000
X-Google-Sender-Auth: 2-60GifSl6WqAGEmwz48Fsq4gJI
Message-ID: <CAC6HqnptkZCQV4ToO4b2AbvJYG=7ATMj1GSQt_tQZN6HBi8O=w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WGluIGNow6BvLCBi4bqhbiBjw7Mgbmjhuq1uIMSRxrDhu6NjIGhhaSB0aW4gbmjhuq9uIHRyxrDh
u5tjIGPhu6dhIHTDtGkga2jDtG5nPw0K
