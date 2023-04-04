Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53406D5694
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjDDCJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjDDCJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:09:17 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA5C30FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:08:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17aaa51a911so32941367fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680574107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fk2M5hqyrQqjp1Jy11fiEYB/sjwVhqsm+ktwQKrJVKU=;
        b=DN4v1XQZOAL7dovNVhE8B+xpL6etxxRuFni2Rwfv6xBNhbnTVqFu9FQYAI3gDCrNPd
         2XtMuOt29AfFAJzg6eCX83/3QvU6TAlPp8LIk4w+GqaKez0St/NzeXaFu+Kv5nnz+FqJ
         xQzRw4NoOLJ7kjBMqTCdNge/Pd7BJ19LslWrK1ti1S4AlYX8pFiDmTLYkqE7wQ6JrtUL
         QH2cqrCnaGhBr8tSLYNO2eq9kenZIN6kQJUqjcjau6BV0nQxwy85hArwgVwTmFZfkmtE
         g03bd6qaOXzPjt5MOqZQGN668RoypnMOJbEud7bU78XOtyJu3HqqTpAfcEhg3kBfadDv
         6+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680574107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk2M5hqyrQqjp1Jy11fiEYB/sjwVhqsm+ktwQKrJVKU=;
        b=Mr8Jv59aCKg7I+vaw9voFgRFFRqOmQt8A/Cg+pkE+IwByYe4svFeGd/ZHzJKWjZz2T
         kN9dPjGiWV8IDats/i+eyOswaax09B0Bzy1M8ogQpwWQD9Z2lIBqfhg3H9Lelo9v963M
         gIQPVbsEx8X2ApxleHlAkB9G8OttDaFOtEEHoa639TUK76Qgq+AQHGuY1CD6g5fqMMcK
         lUDl20n4kyzKFClPO49mmYKisB9XoUkKoXIHdvOmwCgDloG02tKU+yC0Zpce4/3YCk2O
         BGcGua71WzwfPPowHNJRz5zguU23ehTJ2O0ffXTiZaXxzzOImwOnoh4lA7R3ehf6RIM5
         taNQ==
X-Gm-Message-State: AAQBX9c84pbqLu0I98cHux7Qvd05rjAOQrQBmVnN2xHGCEbCn9ZteiVx
        e23aKzdHciZNtRKBCUdNYX4e0RF1Xz0=
X-Google-Smtp-Source: AKy350b28e8397XDLxUDPvgzcLoHXJuAR0lyQpQggIcf+Pbi6+kbOKnBHYLmBCD7O3g1gcZtPfGgwA==
X-Received: by 2002:a05:6870:e993:b0:17a:a1fe:736a with SMTP id r19-20020a056870e99300b0017aa1fe736amr768669oao.54.1680574106779;
        Mon, 03 Apr 2023 19:08:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id tw16-20020a056871491000b0017ae909afe8sm4244534oab.34.2023.04.03.19.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:08:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 3 Apr 2023 19:08:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc5
Message-ID: <f78f2735-b533-4912-8cbf-0f545ce23fcf@roeck-us.net>
References: <CAHk-=wi92YtfjcczOm20_mYkWZwKKjn+dCcrx8BL9n9f55MY5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi92YtfjcczOm20_mYkWZwKKjn+dCcrx8BL9n9f55MY5g@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 02:53:41PM -0700, Linus Torvalds wrote:
> This release continues to appear very normal and boring, which is just
> how I like it. The commit count says that we've started calming down
> right on schedule, and the diffstat looks normal too.
> 
> Of course, there may be something nasty still hiding, so you never
> know, but at least for now we seem to be all set for a normal release
> in three weeks.  Knock wood.
> 

Finally ...

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Guenter
