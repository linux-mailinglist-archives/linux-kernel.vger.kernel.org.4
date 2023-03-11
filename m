Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE096B58CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCKFzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCKFzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:55:43 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A93125AFF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:55:39 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id bm20so5901990oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678514138;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=o7Z8x9ucZHcPB7d2SzwabPiTEhPvjweRXEzZN1I+ZccUu+4Spz9Hsw60A/s6jgs6aU
         9MFtk8NZnNi3u5XFMyrnzjHJga+AUG6cNq4+VMxnF3Y+LpwsIDXhF8NVDjKFunQuwKDA
         HVfwqbzRQwgMSSknn9/X6Xd640xoryS/GF8QpfxMjQSKzEDlbfAEVJFvmMpDMQPnY0I8
         Dy/u8Tydx9wZXxZGSxaQgvz+ZehMDKDLJ04DGwbm3Y9V4nH6WEOv0Z8wCpJpHg9Q6R9v
         CjSPD+3xNUeT+lSIDK8abWnOcUlsstkGtvdEyYjLaLpL8KN+kyTJAQNjxQBULko2e9mn
         KP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678514138;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=3LQ8MLWTrJlBtaV9fy0+oEe0G+OxLYE9ZIitaMyIknWkrneKFPFJ5FABwk1sPriSiY
         zSMrI3ycWfU3j18dWUxyA7sdAlhJ9z11S81sR3T9C34Hjj4jwOYkEI45v+WaVbYYVFwM
         vt5QHc6MotTaiumUYdptFQsMQIxKdc+n/GM+/BOr0Sv4Nbv9GJiwkGYnu/H8GQASh7Ro
         d0M2HVNn0y77OylqkeJLYpu4lw2YQjGzf4B5ntUtnh4iyfxjDTgIUcO4yeYvZc6FnKgT
         IZy/sdqNuLHBeGzsjLlHQtnmiJ4goB5bPzh0Ax/Xs2RQccDLUAarKiTCO9EWBW4q+K4+
         /ppw==
X-Gm-Message-State: AO0yUKV7tz5zzmNsdyBDAL5XN+maGk6G+DVYMSzD7HnJKEM/rKJ3G9o+
        9METBMVo9pgPEaie0PJyXmoc/EpESQCI+Ei4riU=
X-Google-Smtp-Source: AK7set/VqXWuGh6fjJqetYy141NHQlg3So3qENZmsTRMdmXY11WvygESIEEHqPYhEE1jCl2I/wp7VeluD0rsYBq7+Cs=
X-Received: by 2002:a05:6808:646:b0:384:8b1:215c with SMTP id
 z6-20020a056808064600b0038408b1215cmr8586924oih.0.1678514138203; Fri, 10 Mar
 2023 21:55:38 -0800 (PST)
MIME-Version: 1.0
Sender: mrsnicolemarois10@gmail.com
Received: by 2002:a05:6358:9ac1:b0:104:2ec0:e81e with HTTP; Fri, 10 Mar 2023
 21:55:37 -0800 (PST)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Sat, 11 Mar 2023 05:55:37 +0000
X-Google-Sender-Auth: jBAYIsPh2o9DGqYqepGt925jYA4
Message-ID: <CAPsswJKgifprbsb2n7j2ctBywdLrAUGqqfhSKc3dfQk9g2kbug@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
