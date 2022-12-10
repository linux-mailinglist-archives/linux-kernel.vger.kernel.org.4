Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B364903A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLJStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLJStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:49:46 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDFC13E86
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:49:44 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u10so5425973qvp.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ablfdmY03Ea9GTLSkqMwJpBVKZvdQsehib9c94blHYs=;
        b=JOuQsmw9aW/cx4whcihflYgsHezy1KRnm/A58lPJb29l16SsgW4KnlXhXJoymlMi2t
         GD0Q8wizuDvklR31FtkjJ9EGNziYaEaW6xu64QrYyifkTpu3NYnvvdBD60ZmmacpZRxG
         Z9Zwx266pARymIJkDxkKT+wTwSiX6soBSYS0MXwzS895l5jdAgwfKe+Gw9ps6/ThM94z
         wV+mfqomqPMXOqPsS8n0zkqcph8wE78IbNnAkQ52gbXbP6ibJdG+DPYirSmbaJX/6b5e
         aQ3doCuc8Mk09v2AglnI0IpFZJ4EsELEuP+Yh250LmwgRA5XkAk2ZklqX558D33eW0oX
         4lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ablfdmY03Ea9GTLSkqMwJpBVKZvdQsehib9c94blHYs=;
        b=L5W/gxuFmO3QE4DWPD2R1E3lCEs5mCfnvoIL4QdJI/IeyjIr1UIPxLAafOW3Ho8Zfd
         t3eZD0TLwriAfA1A08c/mn0TPsXotbKrBPKssy/WjPrVeqPNHlrr24gm89BVIFj6Y1G4
         27zLHTX9avTbEcjgzwbk4fVY/WAB8vvHI5BWWtS5RAqWrR1KoSRW/I3/nmJaj25x9IJx
         u6Uk70WNDHHKXYDtvuu6QejjAHqUZEqMknCFux8Rxb4Tku4jtJdpLJRVErHxxKDpHXGZ
         j4NrVT+nFZEp1ZHoNdPkoA4QkthbfgKdtS70aSuQiz4fob0iX46UQ+UaeOGslmayB9Ll
         OuRw==
X-Gm-Message-State: ANoB5pno7SzVXqpN1GAsG37keeLyaJx4+cFH8EYaeWfOUzTY/0/TcwvE
        vBw931yNgRDbWXXWRVzt3/VEx9oN6kspgMpCxWU=
X-Google-Smtp-Source: AA0mqf4V5ROk+UJ1/9oXYU85GzIbvUv8pHf51wZgKpsHnpNQL4ChY0xJ0CmLKV7O540Q7fHOV0ZdTxohr58HIthHm3k=
X-Received: by 2002:a05:6214:5ec4:b0:4c7:837f:5c0e with SMTP id
 mn4-20020a0562145ec400b004c7837f5c0emr8944563qvb.74.1670698183135; Sat, 10
 Dec 2022 10:49:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:5bcf:0:b0:3a8:1024:4e23 with HTTP; Sat, 10 Dec 2022
 10:49:42 -0800 (PST)
Reply-To: n1a1t@yahoo.com
From:   Lucinda <akumemercia52@gmail.com>
Date:   Sat, 10 Dec 2022 19:49:42 +0100
Message-ID: <CAL9fJ-u8+FMgzU-uNPHSdR3T-M5otf6-t3pUUBXW8ES3vP1NZw@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear, I want to discuss something with you now please
