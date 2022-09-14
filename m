Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA815B85EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiINKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:07:55 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C741758D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:07:55 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k2so15305374vsk.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=fWf2wq9Hqw6sg8Czf0VOPiSIroBaqjeAFw4xV6RpzK4mIWk0bupKaIq2A3VuMvKahL
         DvxlZPJ1+sOd5gn+fdxxn/t65cggIpFFykusMcBKIhAWAE/Gt54FMpG1AlP17BXk4YWh
         iYH+l8fapffuLF9H0FbV1st7WH0fb9i5LZBSofpA3FkQo0/iMauIKJmCQY+jtkG+vqoc
         WJRTsTGerDT+yaDD7JaIIzWyaIbuml+xSDqTeqUkV99RrB3vDbh0oy/7AVO+mesk8Vp3
         0GX8GmkJH2sX9qkhmzhmT5NcZMZL36vSBYwjLljWVuDHgo+AzTLS6CRMZWnL6/QFdbvE
         4jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lb7mKHsaIcUxW+3Jy2BJQ41sCMA+sLqu9myEjLcTq6E=;
        b=Mjsy6nG5k+tjvZdMDFvLQXn27qMzSbxrub99TSWk2kE4waSYBvVEoRoIzTNWV1fwCz
         kUA6lTdRYMpLqJ2ARQHkfsUJtBye1jk39of5WJDXnitjdr08A1NAvmuBq+cKc01l8iiS
         cZMTtRm52cCaRruWUxYw+UTjGcCYA0QFQ+uMRMdDrafoDMh6wtbznGuR9RCmZ9iISX6K
         OJ3TLpWdTB7IsmTneIoYReWSz6MoVqROggdGEA2onVhsEq0F2dWxPLJjMX9udUFpDLYG
         YZqpKXmiaLbGWNH46SabVvBbzsVIC6R9+CHIsZILjcpjCFUpDgVRAIRBpiUjFktka68P
         zsbQ==
X-Gm-Message-State: ACrzQf0wt1gnFacMmIkRwtmHM8CCMEQIrv7zkPWuGQJW7grPHWGRubY4
        qaq3Wu5hJI2nie0WsfbCw8bdC0oJCKF+Pu6Cqvg=
X-Google-Smtp-Source: AMsMyM4NsSsJ6ELBc7LbIChJHmco0ZCqM6OmZPUHteFnhElXIhPiFkI+qKgFHZ2zLThXKq11sHXakNhQK+LeZlKlImk=
X-Received: by 2002:a05:6102:5714:b0:398:cc62:333a with SMTP id
 dg20-20020a056102571400b00398cc62333amr94732vsb.76.1663150074133; Wed, 14 Sep
 2022 03:07:54 -0700 (PDT)
MIME-Version: 1.0
Sender: mo933472@gmail.com
Received: by 2002:ab0:324c:0:0:0:0:0 with HTTP; Wed, 14 Sep 2022 03:07:53
 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Wed, 14 Sep 2022 10:07:53 +0000
X-Google-Sender-Auth: kWtwInm9pzRIzEAjgQ58QGVjYh4
Message-ID: <CAHbkfQzowcSV48Spx-ZfhKFD11QsJwRozya6mRF2XZUApd13pA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
Did you receive my mail
thanks??
