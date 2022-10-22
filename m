Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA37608B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiJVJZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJVJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:24:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B82D20C1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:36:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n73so4076227iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdgtvDDaY+OxymTESyr2mOv4XwN/dRDwnOgyw9f2CnQ=;
        b=Xf6oCHGd0aoT1O16EzrebZG2Cf+pK0MAesDHXtBSxJJpBVxfms/j6X+NavWb/HVenA
         Ywdm9wxZI3fTm+thTcy0bhASg6o+pqplOL2s2CQ1MG2IUrUBgsmrOVaSsQyHBAAxwQCm
         3W3ynQ0Ang7o0ff5DvI96AtQhhgDprYMYWLHV1qeouIPW5WkX8f3Wpf74lU1okht7Izq
         dvCXAmMs9+BWWzRZrfxrby9cVof+rsLqrxJ6fPTAOoIGGb3EN9/S1nBd0HzA0LLBhs0u
         PgPVbJ3tgijwCefjRTPsLV6uhqOe1GxyiMxoIN56dgXfZAQMV95mOYbI3+iODyUZuz+s
         CmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdgtvDDaY+OxymTESyr2mOv4XwN/dRDwnOgyw9f2CnQ=;
        b=X+HLuma6eq+cQY6wV6t0ZtvOIUnDAplV43yGTBjAnCURc2dtCp3mYzWI/F26McvjLf
         o2ZgT80xEefiEw312Vadmi1YIoseaU3YgjpFx0PQnBUL9eGLDmN0zqO24UaOoc09vnhp
         G2GrIsbhwfqWi2R/Uu2IbsMWFUupUmi1u5rsTW4zPAN7amPAEMEmoBBUxVJr0pyyZZ2q
         rJpQu6cvZ6bTOE4VtdmaKm/5GPGE6QknJkkHX7Gh2DyxONqp0CbxTAijs+pGmvjuLOCc
         A7kLrP88Pm2ln5Fsi+rmVK/Y08EeN/AuuG12rcR1ti0ll0DjBGzFkZTxMhkzCjD/Y3VE
         iKXw==
X-Gm-Message-State: ACrzQf1iQWaF+YyTpFM0+QuLlYnvQIEBS3fOOVUmUIRlZ2UJ4NB/jOJq
        37fOi5Nwp1WD8QfDxj74TClrWOO5+4u9ASoQhFWqo+j+0XFbY6aTirE=
X-Google-Smtp-Source: AMsMyM4b8c1b7RtHVTJFKcyhmRQGIEADeY5CB/g13EEcVRWGt8H7lX3SozFCftDupJHWdzGFGhRX/mRVa//Lj4yyiOY=
X-Received: by 2002:a05:622a:411:b0:39e:354e:b537 with SMTP id
 n17-20020a05622a041100b0039e354eb537mr5728346qtx.656.1666427193238; Sat, 22
 Oct 2022 01:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-3-tanjubrunostar0@gmail.com> <Y1OlmdhJ564Y4H05@kroah.com>
In-Reply-To: <Y1OlmdhJ564Y4H05@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:26:21 +0100
Message-ID: <CAHJEyKVyL5=axmWJw2HxOr2N9b3Tedjd7RXgq-_vAcqKuR64Sw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] staging: vt6655: refactor long lines of code in s_uGetRTSCTSDuration
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 9:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 22, 2022 at 07:06:08AM +0000, Tanjuate Brunostar wrote:
> > fix checkpatch errors by refactoring long lines of code in the function: s_uGetRTSCTSDuration
>
> So your commit to fix a "too long of a line" has a changelog text line
> that is "too long".
>
> The irony is deep here...
>
> thanks,
>
> greg k-h

So true.
