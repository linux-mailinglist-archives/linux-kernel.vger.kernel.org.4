Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A465263B4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiK1WQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiK1WQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:16:19 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1C623BC5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:16:18 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a7-20020a056830008700b0066c82848060so7935665oto.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqG8mR48ufF4QZryMqsz4SLXFPU0+jzsEM9yxIdhBnE=;
        b=El0+fAlP8dSJ6gwIndEIWnvcvzIVvk+K4BwvkYakv3fKbR72VUeKDjBhteZIngF9TP
         f7In1tBKXxuxMeko4vdj58VU5ttDWO+9MoLm/owIqZF8dBSg7C+y5BAwDZT/lDBwukGA
         SXOLhYD/blo6dcwcpNDugDZ0VNwbq4cVS8CqsyMjlFu6uFo2iUErVZ05yvI2ygTmgg9Q
         LEHoc16iF/utN8VqXQ1QnrLjnZrFw/XnOtCb1F5JXKz/Z5SpeKxtTGqy88Ytjak6lzmM
         G87lrimAypxyYCxFNALqW73t6D7+8NnNNBGEl7dEmXKNx4mdb8PaIhv60ISDJVO6HUTI
         RdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqG8mR48ufF4QZryMqsz4SLXFPU0+jzsEM9yxIdhBnE=;
        b=6ytPtSgJyWwckizCVror56aPA/3NXz6PmdnMv/zF2ny4gbKipDivJyRa0hNLDMm96Y
         jTm9ILh7JTKuiqiJbHl00ktZ0VFZTsx/fAshzwmx3ozrMtD8Y0m1upO3HuUIJPy6Ie++
         DiVo0m80mhb1ki2ha5rSR4+HPWnjSx0a1I0K0qDEBiRy1ZapwDsB5IENs+1zdzgz7HOz
         m/ivpzmhA/wQUmKvlYvzyjS/sbszgoZ6bv5YWhBdbm15eVYApW9Sm7/vPBwyvimGQqo8
         K5rRV65a1tJG5oLpkefFn+B8pLWueBGkIw+SVxpBiv19S3QlJWhVdmiAYlPw9smOvhXy
         0OgA==
X-Gm-Message-State: ANoB5pnpxTrZlElFj1Eqf36/QWfowO3LRoLsdtnP6hrMYmB/3DGiQRTA
        4ntwfIYT3vdQDZR7IAuRpFA8mQ6SobQ=
X-Google-Smtp-Source: AA0mqf48BATiFVmawlxUWRfe3gMFLdURS6Gc9vFPtAi/s3uFincZGNH091EPQEawjBiS3HySvX+WLw==
X-Received: by 2002:a05:6830:cd:b0:66c:75f9:29fa with SMTP id x13-20020a05683000cd00b0066c75f929famr16867638oto.221.1669673777400;
        Mon, 28 Nov 2022 14:16:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g8-20020a4a6b08000000b0049f44db7b41sm4749617ooc.5.2022.11.28.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 14:16:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Nov 2022 14:16:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.1-rc7
Message-ID: <20221128221615.GA1882123@roeck-us.net>
References: <CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 01:50:22PM -0800, Linus Torvalds wrote:

[ ... ]
> 
> Anyway, enough about the next release. Right now we're still in the
> last couple of weeks of this one, so let's make it count. Go test, and
> can we _please_ just start calming things down? Don't send me anything
> that isn't a clear and present bug. No more last-minute cleanups.
> Hear?
> 

Looks good for me.

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 500 pass: 500 fail: 0

Guenter
