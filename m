Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B383F6B7A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCMO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCMO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:27:51 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0BE36097
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:27:50 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g18so12841638ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678717669;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5ZrXU5jgXQn0XVrjMqAH34ooe0I0t296BlYZYfw7/M=;
        b=TUFdsPkGYbb2K9ZfyLveBQ2bsppQktqUvLeJFssDXiWIB8chLaOfbmahB+SzEzP9yV
         7yuHsxvGNSfZ47+FfuImgyTfsLQ9FENyv0anw/A/UAZ48SVWmuzAlLKCq+M3j5GS50TE
         HaIYpFWgPubIyTMpcKH0QVxQyeCZw66ExxSbo7iNLSvOq9RqRm67J7iuogkvNr8l54Is
         d0+Su73i4oq/DLJkhujRsOgee2ss/tJQw/4LEr6Cllw8ozmkFczEM73f+XnEmLTIDHjz
         wxs6idU/27qIgFJ5icvGAogMaLrcX5rzWgvnugngYsyFeQ/fl938bTwnjfNtpiJG06CT
         2eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678717669;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5ZrXU5jgXQn0XVrjMqAH34ooe0I0t296BlYZYfw7/M=;
        b=ecscUZdSveyFT2m+iM7+Q2BGVxDdx9hc4d9TGR5By+fn8vZUTAceVkW3jw35jhSjHE
         t+p4HmS35bOz6m5YiQbAW0OIZCGl14F20y9uXsX9BOGv6ZGJNhlsps6+pGKIISGexnsy
         ocHx4dcaNYfx+jo6oltkug6FD5hORetVZH8WHdU5ilpNdZl0/WC9WuR9FOM9BP4rnjff
         P6vEU/h9MHHQ4oBgvaVPCyDiNV/HDp+h5j3ND7CqEFKI3hgOzLhnY/JLnWw15mwakXwb
         9LH9+/AHLS7DGs6sHvsjYkSSU3yzYU1O+HB+A81qnuatuUl45TEpF401T3etQLU9THyh
         HtQQ==
X-Gm-Message-State: AO0yUKWJPZ2GHljh7eyw3+vKXpHKRT1raH5P9LhhfGthS0IuHnUaP1kP
        sAmmeYOcP2cYLvkzMqJdQVH51gHXEEx2zLeXzrE=
X-Google-Smtp-Source: AK7set+z4pLi/7zpsJrio2wgpI0hHi69q0yVpE3Sm/5jD6qu3iXH4Q/daoM9M6GIvxr7p5dHpNqpJ8JSN8U/La+MKh4=
X-Received: by 2002:a2e:a36a:0:b0:295:9040:fb0b with SMTP id
 i10-20020a2ea36a000000b002959040fb0bmr10814629ljn.10.1678717668773; Mon, 13
 Mar 2023 07:27:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:529a:0:b0:21a:d6b:4ff0 with HTTP; Mon, 13 Mar 2023
 07:27:48 -0700 (PDT)
Reply-To: enocvendor6777@gmail.com
From:   "Emirates National Oil Company (ENOC)" <pavlovivanov2@gmail.com>
Date:   Mon, 13 Mar 2023 07:27:48 -0700
Message-ID: <CAJaMezdNiQaBygRCzyqSW21XxFVY7REs2ujGKK1oA3-SX=b6zQ@mail.gmail.com>
Subject: Emirates National Oil Company (ENOC)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [pavlovivanov2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [pavlovivanov2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [enocvendor6777[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are inviting your esteemed company for vendor registration and
intending partners for Emirates National Oil Company (ENOC)
2023/2024 projects.
These projects are open for all companies around the world, if you
have intention to participate in the process,
please confirm your interest by contacting us through our official
email address  project-ae@enocvendor-ea.com
MR. Nasir Khalid
Senior Project Manager
