Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607A5EB7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiI0Chx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0Chs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:37:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD0CEFF46
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:37:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x1so7883985plv.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/XRd/aWBk5jCAmuoAQuPsY7AqhCiNuH6AfOLsLMKTdU=;
        b=AeafmdoMSMHxUt9znzwqN62NCILxYpqTgFHT2ka5g6cIoZ+H7/6Tj+KVUxKXjken3f
         wmippMkRevTMLncHHCjWoC1ug1ybN8fG9NoI1uoYUj1ihA355ms3znvMh8X4zEbzBJHR
         0GY22DFARUMRFn+tuXVBrSvRv+ftAgeDTP8ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/XRd/aWBk5jCAmuoAQuPsY7AqhCiNuH6AfOLsLMKTdU=;
        b=CS/cxmvHkl2I1hMM5/e2oeQd8EojE8BaKBtBDVsnJ4fS7PC49b9vCOQHUn2BJRzjaq
         SpDaBc0Suqq2QMOam5C700qrpv/o9FedVBYJGWegSVSctNHIsNmblVU/JzL6u598Liv9
         2Vm1oTTjSf3lyQqDiuvC8Z272I+VxI/ivFh7fRYTbVaLgwaQtNluH8xKEGvWvurfqPyM
         JRsKjXeHurdLAERCsX+xFXz6DTKm4o/sWp/xOlF6BJBoj/rzN0pwGFa9Zh8nFAtSjCZ9
         79AZ2Ouzay60PdKj3msEzljC/rew2mEZ6XCmdBhoJBYIVtCbXiugLvS36UA2hoI7eCuP
         Xgeg==
X-Gm-Message-State: ACrzQf1wEwzwd2hsWf5ZPSyvgMPb+PYydQuHKvWI0R1bOcI3kCZGMwpz
        2YlUgCnvbIWnV1j1Lot0Nyhl2Q==
X-Google-Smtp-Source: AMsMyM5yLWdhYObdorDIlWiBERwUvOOeSq4ad3HIojfD6Tofme4SaUzlw/sZvWvNi+qe9egrnE0c6Q==
X-Received: by 2002:a17:90b:1d8b:b0:200:5367:5ecd with SMTP id pf11-20020a17090b1d8b00b0020053675ecdmr1971892pjb.165.1664246265768;
        Mon, 26 Sep 2022 19:37:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902b18100b00176e2fa216csm176564plr.52.2022.09.26.19.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:37:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     ebiederm@xmission.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] a.out: Remove the a.out implementation
Date:   Mon, 26 Sep 2022 19:36:33 -0700
Message-Id: <166424619048.1957636.14312901276184216710.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <871qrx3hq3.fsf@email.froward.int.ebiederm.org>
References: <871qrx3hq3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 17:15:32 -0500, Eric W. Biederman wrote:
> In commit 19e8b701e258 ("a.out: Stop building a.out/osf1 support on
> alpha and m68k") the last users of a.out were disabled.
> 
> As nothing has turned up to cause this change to be reverted, let's
> remove the code implementing a.out support as well.
> 
> There may be userspace users of the uapi bits left so the uapi
> headers have been left untouched.
> 
> [...]

Let's do it! It can always be reverted. :) My favorite kind of patch:

>  22 files changed, 1 insertion(+), 505 deletions(-)
                                     ^^^^^^^^^^^^^^

Applied to for-next/execve, thanks!

[1/1] a.out: Remove the a.out implementation
      https://git.kernel.org/kees/c/795d91fe0e13

-- 
Kees Cook

