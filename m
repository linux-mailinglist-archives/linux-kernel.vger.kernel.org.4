Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5180D6E20DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjDNKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:34:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D61B0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:34:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y187so3538097iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681468471; x=1684060471;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=KWhYz31v5M+oSUQ9s3anmV8D8GXJSwiAW2GxMwNzluGiBCxUYamNma5TauwlzqN8Xf
         NHgcjl/KMffzIroVzZcw0kdHe0tHYwz6qBFRlQrjz2l3pGjJ7u6ZgdjFDkYyeznl5Afk
         i5HmfnSVEvKSZiqxRilZKR2pTa9e2opAaAWWDjSKfYE3Wyaut1Io1QILl3ruwHwv/eS5
         HmMIvXrv10pRfiFJWSYGMNGOx81AQgfJ+yhRWyuPdmZMQrygKuvuwVBa9boTI6N8fNx7
         A5SgGLhOEDeESzNgQRafG9nVJIcKhzJI/G9jxsipqcGs/wi4miWP5JcFVuzYYVHpr47X
         qHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468471; x=1684060471;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=W8Glwks3S/A6H1WCJGN3PFYJtW0VfikY0HRBZZffJdt8KsAgvmTwLuHIoRzfdXo15a
         wtfOY82yY/TprvNZx/cBDi2C8K2rPdEpSc8/A0nTyknyGjalU0wP38R/x6LoXuOBpspv
         HTyP3jnbEsrhMhGbps4Vv22UfYztUFy6w3B6z2ShvVZFDe+zvv9syYNS5+MGdY7KtP99
         3rjw6sdpGjwjyxgJX6JufVHNApwCqutucOCaCyDEx5bFwDR3zSrRvM48fKEtFPsKX+Qn
         YxdpVsNM7l9Quwzr2t6/8EfKoQKObvpUL3h1gT3RTtr07SaHWGn/L/Xt7aDGRYO1MnTQ
         QX3Q==
X-Gm-Message-State: AAQBX9d9e2toyKjxch82pzqa2DAlQGunbrJt8un66UwOTT4kCbVL4F2B
        6tPMUhZyT86XHehFEnz5/if7fU7G/YXJs+VmhXc=
X-Google-Smtp-Source: AKy350YVUqN6ch6m7oy+dhlHDhQ2OLxpwSd4iwsUWeAwZxLTtu0gVIPa9aiXdulzZrX3eTbeHUClmYXZm1CcqKKIRy4=
X-Received: by 2002:a5d:9c14:0:b0:745:5dec:be5b with SMTP id
 20-20020a5d9c14000000b007455decbe5bmr2209459ioe.0.1681468470814; Fri, 14 Apr
 2023 03:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:22c8:b0:40f:7aa2:5a4c with HTTP; Fri, 14 Apr 2023
 03:34:30 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <wertew30@gmail.com>
Date:   Fri, 14 Apr 2023 03:34:30 -0700
Message-ID: <CAKBYrSd3v4LQdGiCLuVGm58yutJLLL8MkOtMUj0qqUSCQ_4=8A@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
