Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83055F477E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJDQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJDQYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:24:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7521CD1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:24:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a2so9889073ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sEsPgA5wrzbM9ymT5egG2ZU7pLgzhO3s+5Nr2f5tB/I=;
        b=JFMNPMh1KgFZlCHefD1dijhVK0VLYqgoiFsx+UXLH1eth77mE6sThlkGeBD4FOvJEj
         ZTzF5HltpWez0APf8qNULNypOmK3a3PnAGiE6KDd6JHQoybD+V5z4YWvSCJQtgwmlChl
         hspbB3dQHJ1hZv2HMr/nsIXUIiqIHYgNTvFJDemB+Doz5EEG+sGyYv+M4N4dcEV74Zee
         PfMTTIWPCfDVVYyqx/fgkYb1Bv+mnOMEhRIdUyLams3CDhGRcJM8KLDwlNjc+/kH9WyL
         PTjWOsasf70avWVAiNcu2r+gsZXR1Qyx2mJl9jR6Y4teSgGuFyqADh+qyne1ria9qnFd
         vGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEsPgA5wrzbM9ymT5egG2ZU7pLgzhO3s+5Nr2f5tB/I=;
        b=7BTfP/+HWkiSHWOS3Kb1lA3hiLM/K34/k5lXIXmf8VKv4we0yGVH7zirV+Tb2yFNbh
         AskH7UqpLn7Xu7la/Gf1PPhoRAeR1liQLpilRTn5Aq/J4nXaaSOGW0hnViFijDW/i4RV
         GDoCiwot3EZfuciLfAhgEu4ltm59cOXB6kzXiGdGi1t9i5IoAB2j63afLis7JwTQA8wi
         vva7MDVrstdwUjTVnfdaGyf3COPUByPJVhQgczvxBxp/6wahuq8BfP8gMhiJAtRMVjDI
         UtP2/jLzJuoj8TlhOZmek7iYzXC39lJiHOSD5M0XCp5IX6CV9hFy8u+Lsk1MuvOH7wKB
         PBHw==
X-Gm-Message-State: ACrzQf232laFgicNV3NbA5rSJANhnZ7ncI5XlBNBoeNmAtEqVIaiLrWy
        RbAWLiHxMwqQoZMR0jRIfRtRN+jZQ+1iTG5XJD9WemZUyAITWjeZgw2v1nXu
X-Google-Smtp-Source: AMsMyM721EOPd6PGxPWakaumyEHXpQfGzYg472jm5xXOENmGVjwjuAz4lIs+8ry7Q5MJmtV7JWDpDlHBrcHWeWFPplg=
X-Received: by 2002:a17:906:9753:b0:787:8e6a:103c with SMTP id
 o19-20020a170906975300b007878e6a103cmr20066555ejy.337.1664900676327; Tue, 04
 Oct 2022 09:24:36 -0700 (PDT)
MIME-Version: 1.0
From:   Troonix LinusTheTraitor <troonix20221003@gmail.com>
Date:   Tue, 4 Oct 2022 16:24:38 +0000
Message-ID: <CAEyKNRtb6pvJZHtTMx0Kk3wsoc+zEv8UO3dDNzzAe2Ns8BhwiQ@mail.gmail.com>
Subject: RIP Rust in Peace Linux Sept 17, 1991 - Oct 3, 2022
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds and Greg Kroah-Hartman have sold everyone and their own
morals out for a couple sacks of cash. Notice how Linus doesn't even
speak up anymore after he got temporarily cancelled by the twitter
troons a little while back. He was put in his place by his new
masters.

It's better to die who you are than pretend to be something you are
not. The troons know this, that's why they're 41% and rising
themselves. Even Richard Matthew Stallman was willing to stand his
ground and be twitter cancelled than accept something he is not.
History will remember your failure Linus and Greg. You still have a
chance to make things right.

Let's see if you are still man enough to stand up for what's right or
have the Shekelberg "doctors" have already given you your new
Frankensteinian gender reassignment surgeries? Never forget that Rohan
and Gondor put aside their differences and stood side by side fighting
the common evil. That being the troons and twitterfreaks in this case.
Do what is right. You still have the power despite what "they" have
made you believe.

If not, once $GME MOASS happens and BlackRock and all the other shekel
hedgefunds are smouldering ashes like the apartheid state of israel
should be. I will be using my newfound wealth to hire a team and
maintain a rust-less fork of 6.0 called Stainless Steel 1944 (SS-1944)
for short. C++ support will be added as should have been done to
mainline now called Troonix. We will not ve aftaid of getting a low or
0 ESG score like you are because BlackRock won't even exist at that
point.

Again, you still have a chance to correct your mistake and unsully
your name and Linux history before it is irreversible. As much as the
crazies on the left and troons think, math isn't racist and you cannot
rewrite history. So make sure you set it in stone properly.

"Arise, arise, Riders of Th=C3=A9oden!
Spear shall be shaken, shield shall be splintered,
a sword-day, a red day, ere the sun rises!
Ride now, ride now, ride! Ride for ruin and the world's ending!
Death! Death! Death!
Forth Eorlingas!"
