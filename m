Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E5732D20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbjFPKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjFPKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:13:46 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF71B2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:13:45 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-78f14ef7c75so1266134241.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686910424; x=1689502424;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=KIijM5tl2xHClgzzQoLTU0DwcPby0NnkjLLXNbY257nsFzyc1oBQiXer5nOI3rybQj
         oDdHwzWF+DhZ/I8jySEFDXuW2ptwTUX4hiIr9MtL2q8lXcXJJdrMu0aGAKccAro5a+2c
         XmJ26EPAGI+HyyRaHmScG75NhkRDMJWG5Fb0iuJjxIaES8NgKUK1OSZpd1MvbK3/Hj0f
         wbe2I4qzBXLQ1QD7t2bW4zy8UaSRIx+TfWXBClt8qn6AEa45uYnxhYZByzJBwUz74sce
         Keg1SUfuG2EF5qmmmXAvdY5j6JYCXSSIdaKtHrFOuXNDUtt/ISYNyn4xXa3YZJ5oxBAX
         tWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686910424; x=1689502424;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=FV6ViiJGzhgqDU7EX4loBgtX1mhPkPOfDy343m7xvcp+6cBWv0fWZTuRQAAPkWL3ho
         1WZyVE8+rOgF4VtrUK+hDDB9oO0NCypWyx7e5nLIZjvHdxlLjh8zi02xhjbnNTNddlh/
         3dffyRg9ax6Cob8tu6T/y46L/v15PnevqjYgJ3PZTPzPRHnMQqBxN1cFDjuv55jBz4wC
         RjHeWV9r/7sdqtA8WXXUPAOL/EOWe4jwut0gV0mKG8cqG0cIMoY+2YWDk1psjeqWQTpL
         GjUPS/22FlpoL1DwRM5pQn5hR6W+b41JCYQxw4tFPe0lmIeMWLi8qNwao8EVeDuA/wgF
         2mTg==
X-Gm-Message-State: AC+VfDx52bcff/AcY+50AQ26xF+rbMI9nk0ljdhUKaF7QDUNQ8imXn4a
        UbfE79quxt+in3HHPJ72tY7dK2nCNakiTgypHYY=
X-Google-Smtp-Source: ACHHUZ7ef/G70yVnrvP6tT8rPJxW7T48r4BqdZk0004D4ONP+AO44BoQyq5JSh0fH4tXWTUcpAvIBazPT41E8uBAytg=
X-Received: by 2002:a05:6102:292c:b0:43b:4965:d03e with SMTP id
 cz44-20020a056102292c00b0043b4965d03emr3263825vsb.10.1686910424257; Fri, 16
 Jun 2023 03:13:44 -0700 (PDT)
MIME-Version: 1.0
Sender: princeeminentu@gmail.com
Received: by 2002:a59:b06c:0:b0:3dd:ce52:89f1 with HTTP; Fri, 16 Jun 2023
 03:13:43 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Fri, 16 Jun 2023 03:13:43 -0700
X-Google-Sender-Auth: cd_CyR6E3ZPLG6ZnMFeUwlmTnT8
Message-ID: <CAMB_oqMRBHa-9jpK7Sr6Yc-_60ZoFPjCSneG0gdC6mu7f1ie3g@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
