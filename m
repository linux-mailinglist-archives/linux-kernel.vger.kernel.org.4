Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112663D2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiK3KCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiK3KCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:02:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CF30F66
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:02:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z4so26262249wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Th+G2QFbGAX06mg1aIwvVRiXrgkLj2KZ0HoeEj27hRA=;
        b=pw41DPeJAsKcNYldAFTg24MhaGfwshAzcYKiZbqZqJmdSwOuXMkLjoCdXUhwZkG5RT
         CPIs04hKIwm4hwfVp2K5mZB6gAUt1db/G/CY3Lf2r+iZc7dZIwdMjr5b5hTBO7EZ315x
         qqEugUkQGaDIiVPCfRcLpG84VeTCWVjGrsFEb/yspNupI1for3jqwZypBVXTj3PAKUL4
         QL/xRlT/I2Dt5qMY5q9HWtS6tFq6jzUaTu7P8egkufx1BvaJWDiU6t6+ZPwA0s3OzDWX
         U5Zgk1liqUPGWrmVPa4EERuePj6EkIrFYoTfN+FPwLQ1R+ZbdDjTqghm6LN55QhCiXuD
         U2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th+G2QFbGAX06mg1aIwvVRiXrgkLj2KZ0HoeEj27hRA=;
        b=1DZCGAnRD+AnfwkEsVacwjjwLZ+FPwhP9Xm2r8WhrpnknijO79yDUJameLojHEdplr
         pOWRmKqsVF7saeBWgbJpIEoTMu6CR/NVI5sBKO80xoqFMyFJHgM8gmgeYY2cL+mJPi3F
         mzy91vWHLzzbvBVUrnYVRDkGqGv3qiPuxOmCz84KKdykhn7mINBoMkwatLWWsOxqr2Bl
         qpEdWGYmmYWAhTYseuaDIlVXky6LN1CL23I+7zBnBStmCCVSUxC5znpBX45IjrYsqJYt
         zyAbcOml/17YEReh7u9DUgb1u5DBsM/eTVq0/W/H5GcKmLnL1kDTKH4AQWWZJC7tAkCh
         z5Ww==
X-Gm-Message-State: ANoB5plSVHUumQDY0cBdmxQR4XPFlyYcN++3qVwm5tFy1TVF+XTIsMhO
        q09I4a8TSG+agikUQoRkfF2E089R+MM3gRVYHm8=
X-Google-Smtp-Source: AA0mqf5eIe/vjT0QZnqyNgfDckx1jHTDcz1VOke7EieK+U+dsXVwDwPF5xjMmYE78CfE/bYMNTupKbBBuyDB3IyMzJ0=
X-Received: by 2002:a5d:4a85:0:b0:242:2d83:3333 with SMTP id
 o5-20020a5d4a85000000b002422d833333mr957970wrq.584.1669802527305; Wed, 30 Nov
 2022 02:02:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1366:0:0:0:0 with HTTP; Wed, 30 Nov 2022 02:02:06
 -0800 (PST)
From:   David Alex <davidalexman56@gmail.com>
Date:   Wed, 30 Nov 2022 02:02:06 -0800
Message-ID: <CABYJXBZ-m52cseS7F2cSZ3zsm0NbWNxw0xyso-YOqMRx1R1VJw@mail.gmail.com>
Subject: Re: I donate this money to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY,XFER_LOTSA_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my name is David Alex I am sick ischemic heart disease I read
about you on a website. I have a few days to live I want to send you
my money I know you will need it $5,000,000 I do not have a wife or
children I lost my wife 4 years ago..I want you to take this money and
use it well and also help orphan children.. If you accept my offer
please reply me now.
May the lord bless you as you do this
