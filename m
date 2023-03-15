Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7764D6BBF92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjCOWFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCOWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:05:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D99158AF;
        Wed, 15 Mar 2023 15:05:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r27so26093410lfe.10;
        Wed, 15 Mar 2023 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678917901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l4+bNuApcUZMVNqM1/aVOFmIhi6l3WI/EFGuiIHT5s=;
        b=lPBq8K6lSPHnU13BNwtUgZF8yZpn3aa9oWXGW7t+scEsPLUO0aEWe0dexCBHinC8Mi
         QvvwCys2ZaYd+KFe0a1JnBPmKYe8P1qzfgJ4R7DJkfnMsEj+xDSKMcBqJfjY+sJVCIiy
         BcXBbCgG68NnQ69O0djShaKkPFcT5TJNSWgUdZAzR0k3kk4PHcJ9fEDm7RsOxHgS0cXZ
         d+Rr8wVcOTyxlNHZHeg1o8MyUgaCj9ttqAJwKXn2Ywj8bLcBVVquBPwaG5htO1U+ghcH
         fonNR167QufXdSsgcw4ou7t1GC+ZOPZkAVFw9TnolMS/GUbu3gE7rGukxyk0UO4DDxA5
         hnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678917901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3l4+bNuApcUZMVNqM1/aVOFmIhi6l3WI/EFGuiIHT5s=;
        b=4dqHV36VkrL19H48aKUx5FRI64yMtQBkgKdtOBu44yrCByXoNZijPmvdDE5b8VlR+x
         i+pFDLpmQ2G21HK7DsTF5qIrvUNMjz3qz1CwgfdF8EV+k0m0qb81z8YE8fitohqa4Jvd
         cXF8NCZoxhxQHCsSPJVRnFrO56VeCb/eKZyXtenZapKWjAJ6W82lGMB0wgZy4/97GeKI
         8eFXWdtZSnKmbdkhR9eb72s6RVKLGs+9iNTHmoWdjJMs4JN1MoDzSQb2b2fiDqbA4G/i
         YmgMbHOHM/x9auVbuyplM0XBJS1JqFpfxpYmx5CaRDnqLR0USl63MJpgtONM6ZeJLWzY
         MdDg==
X-Gm-Message-State: AO0yUKWV7CShxGNjDQqNtjSzfeH2awriC9Pf6tmiTe65paahEoyTZwOM
        rN7xPD5ptn3avKD4vfkwJlw=
X-Google-Smtp-Source: AK7set9ug+yX+Y7q2oVngCJjzNN/hA6EluX2l3EnTNPJ0uPESogMnlAMh4FZjR+66njrZVTFeGcUmg==
X-Received: by 2002:a19:700c:0:b0:4e8:a093:5eea with SMTP id h12-20020a19700c000000b004e8a0935eeamr400677lfc.11.1678917901322;
        Wed, 15 Mar 2023 15:05:01 -0700 (PDT)
Received: from localhost ([46.211.236.75])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24348000000b004cb43eb09dfsm953675lfl.123.2023.03.15.15.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:05:01 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:04:53 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Message-ID: <20230316000453.553bf6a8@gmail.com>
In-Reply-To: <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
References: <20230315210135.2155-1-pauk.denis@gmail.com>
        <20230315210135.2155-2-pauk.denis@gmail.com>
        <20230315233054.5ac21db0@gmail.com>
        <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 14:58:24 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 3/15/23 14:30, Denis Pauk wrote:
> > On Wed, 15 Mar 2023 23:01:35 +0200
> > Denis Pauk <pauk.denis@gmail.com> wrote:
> > 
> > Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
> > 
> > Pro A520M-C II/CSM is also tested by Holger Kiehl
> > https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de/
> > 
> > Could it be applied as single patch or need to rebase over "Pro A520M-C II"
> > patch?
> >   
> Sorry, I don't understand what you are trying to say. I just applied all
> patches in sequence as received, with no conflicts. Should I undo that ?
> 
> Guenter
> 

No, Thank you!

I just like to mention that Holger Kiehl sent separate patch with
"Pro A520M-C II" support and it could create conflicts. I have found it only
when I have sent my patches.

