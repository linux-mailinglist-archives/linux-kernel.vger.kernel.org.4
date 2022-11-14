Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361DB62766E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiKNHdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiKNHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:33:46 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8586925D0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:33:45 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 7so12417193ybp.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=fnIJexOrurLq8LJxVcXEJiknMA3dW9UhnBApnJkZZdOQZ7GQAbmzYeMl3RpkpcK9eN
         ssGJDVCSM/G66oN3l/9N080U0aODjMhnMZCqEBJm9ZMYaY6Aggifa5zAaA7tKIRyCrEo
         D2OZ+7x3ZXtx+jsJEQPygmnZzCeWOa6EsxMTsWNehw/8wkeN7nHNiyvKiNOZmL5XCLFG
         sAimVVkazKNjpsa6O+fJ/wFU0daCv/tJgODcigKC8lxyiUaUz4VEamAoi4IarXnImxnh
         5UsDuqaUIs2ZCBqRhz0yMBCcKzxexWPh5f3wCcSGmA524XDXyHtFFowQmf2vo/n/6G+F
         GuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=4fF5/VJA8Fibjd8sEotKoAi55Pg1QFJQB1fGm6QyO5F8dLGsW2gUqDcEtXIbv9BgOf
         lWp6XdWHD5FF/yuHFOk15FBf5MT+5IJnQtLOhGniX6BboYlIu7IiJFkxEXT7KKuYMw5Q
         PM0kwWBCL17el1x5QiyhCFATzNRL0OOLW2rw+wj21U9/K/J+ZH4g5EMQr9iG1pSg4GCK
         VIBb+2rCILUddi+j7v5KQ2DI4Ali86MtleNSsLoK2rLx4FTRLeXR2Lps1uaBaGxEVez5
         MS8TTFGUcG8v/wNm5d7WNJktdNmgkUhRC8I/sd0SCg5+tUFmtnRIryi3pwWjsKxgzo99
         g3nw==
X-Gm-Message-State: ANoB5pmSluSJb7Qd/qJ9Heb3UDYqAUbTUSR7L4lWgv0cSVMSmYDPWLgi
        /1a/a03gDo4LU/O3P5kaWDxD12RqVrpRkjU4MWA=
X-Google-Smtp-Source: AA0mqf7yCCMH9O+fvwLxmis2Mymu/MG4XZiNMTatfeYXBnL4w5KvOb71VTFOHBPJLX3gOceWwAZkMF+kleiY4/TRE9U=
X-Received: by 2002:a05:6902:118e:b0:6be:92a9:c9a8 with SMTP id
 m14-20020a056902118e00b006be92a9c9a8mr11279033ybu.408.1668411224576; Sun, 13
 Nov 2022 23:33:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:6a91:b0:313:c00e:5dfc with HTTP; Sun, 13 Nov 2022
 23:33:43 -0800 (PST)
Reply-To: seyba_daniel@yahoo.com
From:   Seyba Daniel <abdoulyameogo1234@gmail.com>
Date:   Mon, 14 Nov 2022 08:33:43 +0100
Message-ID: <CAA_gp0f4vhLGTqGEMmgnXVWgdUvK_4i1Q2UA3G-mH2uF_FRAKA@mail.gmail.com>
Subject: Seyba Daniel
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it, which you will
be communicated in details upon response.

My dearest regards

Seyba Daniel
