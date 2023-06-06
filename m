Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013C87243D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbjFFNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbjFFNJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:09:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4C41732
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:09:23 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561b7729a12so107839367b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686056959; x=1688648959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xm/CNMHshFy7bplLeKTHXDpomyMsO5Dg+LOOn87+dA=;
        b=PCXN8enfB5ZAE7Nqy5vzkMW58Wip94mKANs1JvNACWCr1eKbBdZhn2MBubROVtznzn
         3qVg77PS7d9efXXM2Lt9D/dw1Gcwh/TrQ0mYx196SDCL1GXPQlaf2671C3kBrGr77a0N
         liGC80cRfHBhchg58v4vv5ewlo6551vCYgKjekeeGJoOLrRy81dDwVt4XrORhxQn0apU
         +dEnZNO4f6ygRbV+8Wgiz2501s3dyBf5yD9i8VBZIE0oopjQSiLqPax6RC4stTRzGO6D
         JmMiLgtn6HxcnPArE18p6SSrsi6DwsDKZ0TeXwdGJmyuwQWjH7Fse3NbV0lg/omOJtLm
         WOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056959; x=1688648959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xm/CNMHshFy7bplLeKTHXDpomyMsO5Dg+LOOn87+dA=;
        b=BOKejnlfp5CiX3QIHbeogdyLWKTaWdpMl1NWs2nM6CUqs/exBeOTnMBeqmDbmsOa1m
         /nYgvnSkMQtTJDg+NzottPLLs0kOXubn8meqhgnurrkc5CDiaU8p2tHgbK3xBY4Ef0y+
         3sRAqB7oXZsZX5HRXG+HohzH3gQMAuoCZUidXLeoOw6VHplWS0QYYjKXqIIwD7mj/A5e
         XBBS9HCOxTzLoe2bD9ACKUk1wZOhLEYkU4+Pjmi332JgOVw4L4fEZJ6tjgbxm1eq81yS
         Gu0Oz3VMkqh9icml9F5Im14rDo7L5/bkLA0vHDCtzd4rf9Of6CNr761yRhwhDaMMSMRj
         hDDA==
X-Gm-Message-State: AC+VfDw+RnP0QLb5de0PGtdr6lnkA5QklkB/iKsfy33VksY2fY6d6Pur
        OxQwC1MLF+t1n5oAxXxjZ9Z3Bua2RHKLdySMctkR+VzZwTvl9w==
X-Google-Smtp-Source: ACHHUZ6lFQlj+hbY71+oGSNeUY9Wh6K/HSm1LaLwutU9RHllFeo8QrqspBlAwtyrY5cWhrzE7PC3mBuN8AydK5JMQ0o=
X-Received: by 2002:a81:8308:0:b0:565:3215:7771 with SMTP id
 t8-20020a818308000000b0056532157771mr13401746ywf.12.1686056959264; Tue, 06
 Jun 2023 06:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx> <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx>
In-Reply-To: <ZH8pyG1SyfGxQKAm@feng-clx>
From:   Chris Bainbridge <chris.bainbridge@gmail.com>
Date:   Tue, 6 Jun 2023 14:09:08 +0100
Message-ID: <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
To:     Feng Tang <feng.tang@intel.com>
Cc:     paulmck@kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 13:50, Feng Tang <feng.tang@intel.com> wrote:
>
> And I'm have no idea if there is a real hardware/firmware issue
> or just a false alarm.

Is a negative reported skew valid? I don't know, I had assumed so, so
the problem was the conversion from -878159 ns to 18446744073708 ms.
