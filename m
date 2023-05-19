Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615F70963D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjESLSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjESLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:18:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55070171B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:18:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so2332683a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684495083; x=1687087083;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmxaI1amCfTksu6ynk2557PwK0HJxrBQmYIx/Pz5hBs=;
        b=Wt/WzQmS095ww6zzUgoSSAlrCDxwL2gSoVBMsVxHRKn23YcliDiJyBLjqweTRoToj1
         ufUOgV4j5pHE/9SR+dsRPr9gpju7XpaMYkUmYe1T6vrhoZIvsQDtFJjwfPWr0ZA8MwEK
         A8xkN8RoXHrnV8mxXNMusUB3EToMcUvt2JPOXJbMgVYPwdz45S3ERx+Nyqo+cmGrrOa8
         vd+RSV3BkQDybrevFx7U7UuvnFt+9sOfqdHCxo6t6nUsXpAQmNebiCtg7JMDFdLkqxgM
         8PXBgbynXWRxC6QXqoh8bbtvc/aqA5Z2+Ycz9m8q7U5s8LdUBFb9kcl7MTOhQK2ZKsRi
         q6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684495083; x=1687087083;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmxaI1amCfTksu6ynk2557PwK0HJxrBQmYIx/Pz5hBs=;
        b=iwaVI/I5JyY1KpCK1bviOg+cWdUea06xO31n2qNnkljcYq/Xvo9Y/l0gjCtmwNJwrx
         Xu37EkxxspCCs5QhMu5FElfKTkWD50+r4dLtj5vrgjHbuowt2uVbGvSVy4K0V/plSPGO
         bmF2NADabXZhJ6DvSZXobb5mdm7JXO1i1No6/CFUx8mfZ55nQY/Sp37RByefoDmCkueo
         cex0OgaEgpbZIOzxHImAsl7A5QLxEmEtqEqIuMKEIZzqIphuyqotU4PSM/FR8Y65rRaS
         OE6uMzIX2sJYpXdoiLOlO200RkWaGhFyhBFpbOmQU0CQizZr8CfouDZoPXaWaR6LG3Vy
         dA3Q==
X-Gm-Message-State: AC+VfDzui4vyKFjR+lSTZz9HKWbR3GK35phjlCKGgjkbs5zsG2QatFpH
        qzhisFNC71EN8juNYQ2cquDPobLOhjj72SDzYl2gmjenJef/UQ==
X-Google-Smtp-Source: ACHHUZ4u0RD9o3Kl8FtNeecPkKIUUkqQP5EKCQy8Odb3BCVRQ/plvct7PNXp53hldLkfZ7jyXh0W2roGP4wdAWIFYf4=
X-Received: by 2002:a17:906:af64:b0:966:5730:c3fe with SMTP id
 os4-20020a170906af6400b009665730c3femr1223003ejb.52.1684495082502; Fri, 19
 May 2023 04:18:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:7dab:b0:94f:7d03:8e8b with HTTP; Fri, 19 May 2023
 04:18:02 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly199@gmail.com>
Date:   Fri, 19 May 2023 04:18:02 -0700
Message-ID: <CAM7Z2JAs+q6RsD5Hw352ZDFruUVR5ngjAamir+4ZCakNdZyceg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibal
