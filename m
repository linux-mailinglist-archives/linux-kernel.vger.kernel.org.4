Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7C55F8792
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJHVrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 17:47:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7980C13DCC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:47:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id d67so6723450ybf.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyAC9pGA3bM4rM543zM+YmJ53hSTj7w0+tIgvP3ytYE=;
        b=SILWaaG0IZhPvk73BEl6JFXRDlASwUIZ0TOPWnk2MqFnHVODLvk2bEbu+43s2x8iJp
         hE9T7gH2fWOkEIou+pYPdi8xP5g0Z2iFnV5XS6WIya+4rm+KNTnhLVP78qkkmjZq5bpP
         lZ2CwIDPYA1K+dvarfBRnCPBZJTEttgDb1tAnmq7mRt8ig2dhMAKhXMU92FIXSgRCnxv
         JzTCvBC+6XNaIcF3GlDYFXygzLZvFOfbZh2M7fYNtUy6Weu1IHpvVd6BPSzqaz1/ZA8O
         ztCjys6Yp+a1vw2moy08Q0m28zbeCUZQzfRTL4RsHzMaVhGWbuyzZAG942ZoTKpvNoc8
         9FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyAC9pGA3bM4rM543zM+YmJ53hSTj7w0+tIgvP3ytYE=;
        b=X59wL55RPxiFW21tSjj+on34vKD7PTcTugEodrDQax2tCjS8x7it5LA5rnuXIx+EVq
         P+bMDH+HO6uXZdSYZdNoZbpRVkGTv//fAe4FfQfkXI2f3lQqhOAWej8l5iyuDMXsm9PW
         1nTQWUzisvexddMY+6LItP9DOhSSWZeyXyZ7e2IljPr4g/dZcYtdbsisexKISVUAK/1u
         Nl8HMawC/20CGlkc1VQLtd4Gnp/6O5QPuLfBMQSLy0J1MjjTUCv5kbmC4ETj51PsyEuW
         6K7/cf7/6cR8QolXoBaiA48Ne0Qg31CQEs3Ibbt0iAjgZ1MwGqW09OkZNVuSrcYLOeZV
         prGA==
X-Gm-Message-State: ACrzQf2D0XKhaXa2/LRjUNviuulxec68Xb/N0aECI0o4/ZEQQxMKutJc
        XuN531eOHNF5QTIeh7DbnMH8i96e3nJdga6Sn1M=
X-Google-Smtp-Source: AMsMyM5oZUqnUqTdmrdLckam/+Iw3tnMHpN4F4uCqDiJPal7W2lTlNAoW2Qffxvw4i/lLHOZ/52iE4oqtn7yeWSJ+CY=
X-Received: by 2002:a25:3614:0:b0:6bc:3a41:8037 with SMTP id
 d20-20020a253614000000b006bc3a418037mr11225500yba.336.1665265651758; Sat, 08
 Oct 2022 14:47:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6919:2d97:b0:e5:373a:4087 with HTTP; Sat, 8 Oct 2022
 14:47:31 -0700 (PDT)
Reply-To: abrahamamesse@outlook.com
From:   Abraha Mamesse <bartolosimon105@gmail.com>
Date:   Sat, 8 Oct 2022 21:47:31 +0000
Message-ID: <CALmWg1g_2DwiiG5eEmVnR=2bEz0FcumJSz+-6-p8OJNYsbRWcQ@mail.gmail.com>
Subject: ///////'//////////Ugrent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am contacting you again further to my previous email which you never
responded to. Please confirm to me if you are still using this email
address. However, I apologize for any inconvenience.
