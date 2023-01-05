Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B865F7E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAEXvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbjAEXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:51:13 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403893C0CA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:51:13 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w203so9898346pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 15:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dUGG4xNbmHxqZEWk1QIkj1J4BmjM8dGcX1VYzdsWsY=;
        b=AkF8e5fzAZ2VeUWgeccokzgmGMkI/xbhVuZWko5E+WUCvTbBhrEKmFzqLouhvH+mff
         qSqo5/ZV3earTqKSCp3SucQw6ZEGAkuyiK3Va6Q3oXWSho1ztU5OiVZ3KGLnymu6SJyF
         yJYorrv3G2fCSumBtEidADBhZh5crz739IbFEP5+7NCyC5U+LgwrtBXkkrYFbt2jOXWq
         Y449etWueBSN1zELXIYwdt5uyRHikVqeb51i58uQwmdHeqEo3o44FSBxNW34TTRgo/m9
         jJH9mwbhak1aC6v/2dJ4HHsUFY3j5uoPORWHh05YdVfKLqkVjjUuMV7nkiWOtRDGTt9L
         MeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dUGG4xNbmHxqZEWk1QIkj1J4BmjM8dGcX1VYzdsWsY=;
        b=xLIF9oDuTo1E0NAqm7t1deVZxxBVW2sbcPXITske4XCj82sqrkPfdlGavvatBwjB8H
         uYppn/7Kq6Wg8+Wy/BnN9tlDo5wOyNNOltJZy1mWwuAlvDbZQoNJ2g3/urHH9XtDaezd
         qLYvibGsZLmwF/ziH/DSczDODX00+Yc53yQtvcrSHtcS0z2wkj5pLOwFCZ/1nqoAZoiR
         Su5E7wD0MwjTxP+ItM2DC+b+yU1a/Zal6B/BwL6rMOr4FbJa0dtCmTVuoDyM/RldPFm8
         vEegLRgzJ/EREnre0TFc9YeXmU/ruSuYVwmc14xsAY3w7VhDZZKpupFx8vjig0szwn2r
         TGPg==
X-Gm-Message-State: AFqh2kolousmTPXgwWAS1agQetND31zXu4veakj3oLZS+4TVD7J3OjID
        1dJOWlhi8j0ppUal6a5lewzIBStFDL6n6At8WwC2JstJQwTP5XLwl2grHw==
X-Google-Smtp-Source: AMrXdXvnfYaDhVS8foEMYOEQlITVPNRz/fxf/qtKT1wYa+88dUuBCAVEBsDcBAahaCKU6vtleoo7q7KppsH16zgzEeY=
X-Received: by 2002:a05:6602:110:b0:6e9:a169:c879 with SMTP id
 s16-20020a056602011000b006e9a169c879mr3296848iot.99.1672962309821; Thu, 05
 Jan 2023 15:45:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:c147:0:b0:304:bdf2:e728 with HTTP; Thu, 5 Jan 2023
 15:45:09 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mcaitlin9999@gmail.com>
Date:   Fri, 6 Jan 2023 00:45:09 +0100
Message-ID: <CAPfBHRZD4pVvik6GendF69T3qA4ykoMKDEioXBhGmcT6ACQgxw@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
My name is Dr Ava Smith.Am an English and French nationalities.
I will be waiting to get a response from you so i can tell you more
about my self and share so some photos too.
Thanks
Ava
