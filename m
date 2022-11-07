Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723C61EA31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 05:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiKGE1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 23:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKGE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 23:26:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02DE11C0C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 20:26:50 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so12254712ybb.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 20:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=NOvWTa2ZaI42fdJnpA7o8Jn+Xothi+I6cRGYHX47wDh8/SKnr8NmgjQnfbTE6LB+nc
         z2RL54LdGiq4BcDHaMDLSu7OCzg9++PgCShQVE9O/JUh8bzZwg5alTFpBecyYbGifSuj
         dHPq1GYv4c0cM/+Vi7M4VRRNHI8hOBMVr3zHkfFohyCPS7JxyjArWGMV9CpmYCv99KDV
         4yCQf+d6m3t4SEwjz8glN63FjMmFoV1DMZc6d22ovPG4c5ePw2I0T4XMGB8K/EiDoIqX
         B483e9J2ZgP3UhIVSJZ8EIxxQ3AlHR24IpDPF71kPWpWrzJ4yJmp5UAyYVwLtQNNIyHf
         dTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNFhsPbkfGfOWNF5M4aRb8nwKD8L5aVj2WV/H46NM8s=;
        b=OrjZTxqRCatCdiIpv18xD4gYxhgHrYNSBtJ+vecuxg+MCrpCndfkt9mnKtAPsEOyzY
         raRFJfiOO1xeH9GaKWYJN/ElmmpH+GY7LeqRJs0RX3voIkdw7fE1VOfTc+o4rYD8hIlL
         vns8awbqLwf+XnmFUK81GAmtWwasCjfXYNIIcfuts9nLmc0aG3ZNLoAgTMaAEyhkTtu9
         IIMwTQ+smLkygOAlC9mS4hvyUEKky5nrBZWCg097cUFyAJSyEfrKZdQVXANdrF2gC4gt
         tlHp1TWh5C0kYuAk5avgrCipoA/vzC14gbdTucA3pwJkIUwxdFApAz95s9E8lY63tl5u
         VWug==
X-Gm-Message-State: ACrzQf3vgaiMSDYak1AaCKASlEJrAt8O6NXIpQMKU3QNAWoex2WR5X4g
        KmXSEGgf5oqdC92/3JvtJsSSQbMMn2onapv/5Q==
X-Google-Smtp-Source: AMsMyM61KZr/tbn+OJC+e7NwbjNDaZsj34pkZv0yskETmC7SIKwMC38mkZBvDx6LWhndmz8bGV5MCcyGCmpfdUZms3c=
X-Received: by 2002:a25:4dc4:0:b0:6cc:d497:5d91 with SMTP id
 a187-20020a254dc4000000b006ccd4975d91mr34653442ybb.430.1667795209073; Sun, 06
 Nov 2022 20:26:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:6149:0:0:0:0 with HTTP; Sun, 6 Nov 2022 20:26:48
 -0800 (PST)
Reply-To: engr.fred_martins@aol.com
From:   "Engr. Fred Martins." <deliverycompanypossacourier@gmail.com>
Date:   Sun, 6 Nov 2022 20:26:48 -0800
Message-ID: <CANPQYVPqwDsAs6uTY0MgMAoCCFT7St-UTSMH+cZ6qmfYr4geNg@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,
