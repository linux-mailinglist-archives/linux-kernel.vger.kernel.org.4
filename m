Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AF36E0292
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLXcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLXc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 19:32:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193544490
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:32:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j62so6283440pgd.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681342347; x=1683934347;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zS7KNTV0HyeorkDDGwxB1AV6enuRKzO5rthkhdHIRnY=;
        b=LCT+MO9g3rjuaomrHKGDNNyTZj+P6Rpl2X5zalGZNofCMQ591G3CTrnEpsde0rPJVI
         EhpkZmJqZkszxXPt72ZFUURGqKHUGHzphBxxBxNbfpDQ1DDJ1MSzkK81/uwZzc41xr1J
         Z/bQV8CRpd8uKwRuRXVcJNxYiBYPkHFgrCXAjxm7B7whRd3Pz/gRfHg6qNNNtetV1c84
         7It2N3+anGYFMQtO5cTp5rypwVqfDDasq1Z+b8g2u6H0KcqxQiMWHDw6FzKEyOTGjkne
         0v3TNTMP/CPYqDXwjLTWSOl62Sv7leywLvcIZdxQiEgOxD7WfDju7aloQTDr7qfZLHkb
         aQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681342347; x=1683934347;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zS7KNTV0HyeorkDDGwxB1AV6enuRKzO5rthkhdHIRnY=;
        b=CVp/JEmqYK59i3t8On6X7DZ3jFJPMbdGGt0iRU0JbBifNroa9M0NXK/mA9i+8RkE41
         pCnfdiubcjrmb38EBQpDy5/pjDqcpl1J4wAaUR1gjQhu65/mE1Evh7VH49rg9E8kwh+O
         roI+9n9Sf8Z8RCleD66Gkf4KQS+wUEm6Q/isJ1M59++g31Z9ABS4BP5IeDiSzY1lqdqG
         WEeatggejCc9m79Y4AUQ4++kPTMnVjqdU4xqz0JVB9VMZrSsJI5mWZXGxopFBy6y+mYX
         PdSDKHhn9mBFBWn6sYahYAiDeim8Tfv1GcmIOldPTsZ0de+Yv6xouZ41nzktGuTwefGS
         zsmw==
X-Gm-Message-State: AAQBX9fy3kExI4D00Io5SCtLmHfdnDKnehNGJ+h56o0DBocoE0n+PHqf
        MblYtbxCJQR+lEtp0LeaET8CmYBKInaCwtMv8ag=
X-Google-Smtp-Source: AKy350ZdCQNww4Y8ShgufyUS2kpuYJ1Kb07MX5IKLALVGHueU/BDBkDGSgKECMxeM5w0wqgpsq8ht1Fu8tH+bC+MH8Q=
X-Received: by 2002:a65:6419:0:b0:50b:eb56:b675 with SMTP id
 a25-20020a656419000000b0050beb56b675mr2387002pgv.7.1681342347560; Wed, 12 Apr
 2023 16:32:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:678e:b0:3bc:b835:6dd7 with HTTP; Wed, 12 Apr 2023
 16:32:27 -0700 (PDT)
From:   Florence Martial <florencemartiaal1@gmail.com>
Date:   Wed, 12 Apr 2023 23:32:27 +0000
Message-ID: <CAEJyxWhXrZ_+2HF5eWc6xkfigf8Yegq=g_ofpKqV1bgsbcoXDw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello
