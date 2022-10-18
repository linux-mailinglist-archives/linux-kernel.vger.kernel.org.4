Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FAB60259E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJRHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJRHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:22:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F11AB80A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:22:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cl1so13098843pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuC2u8JFBj5aBto1I57uFCGMj8aA6SvkPGDr21Vsm18=;
        b=nogYsolXRwDmj3kSODI4WsB8i6jRSM7IotIlqcdOmhXjOprssKP129Dcnh3XehLRBK
         qsVaY5JHIeTGPsilErJrgu6xEmw+NNg9Nfd1XedLjzWypKIyFbr9M4ARtlML3j8wQ1Gc
         iSgWMrLrDR0lX13lQVRGoJBxCOA6IZrg7B+bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuC2u8JFBj5aBto1I57uFCGMj8aA6SvkPGDr21Vsm18=;
        b=P6e6a73PEPI67wxBFdn1j2nIB9IcSeGvns8VfpeyJq0O2sz7PA3uqSoI/o+rWrQFO5
         ZbCmWpKLw/yQRf0Qu6EYxU74eLd36utpc1yOYc25aEehUJ4ZR8/o74bkc4pHWSusfRVV
         LyjloSY86Is49KxhcvzVE9+V63p2YBurm6z7fzAlE/SXkq4ZBA5rRtAjYoeRg0DJiEi7
         bA7/bmQy8eo4b6V4rZB3xWkMOujoXvMsshykftLyF7qsQSyAbrMZfrhihHLg4Y8adV1Y
         9oEWGUXozWS0ZZlU+4jc7zFutY5bdtvozb4k+e4zAkE4/HBrnEh4ZGCxWmDq/DC+BMlA
         v5fQ==
X-Gm-Message-State: ACrzQf2ByUUX0YCMxOMNnC0m5hJyo/bhqxzn1jo/5nl3NKo9j781lRJJ
        0+Yxhep02KbO3FfgTNqm9HG45Q==
X-Google-Smtp-Source: AMsMyM6onBfVVsToaqLZ7OZhSdCJc/BgFa6yiHoN3qZTXqMw/zn7OCh6rNuz3dDo8g+HKAdJmMPheg==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr1562942ple.21.1666077751606;
        Tue, 18 Oct 2022 00:22:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b00172f4835f60sm7896045plg.189.2022.10.18.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:22:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     eb@emlix.com, ebiederm@xmission.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] ELF uapi: add spaces before '{'
Date:   Tue, 18 Oct 2022 00:22:08 -0700
Message-Id: <166607772208.3775126.8911298240981358816.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <11563980.Ss37MnutNL@mobilepool36.emlix.com>
References: <11563980.Ss37MnutNL@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022 12:25:40 +0200, Rolf Eike Beer wrote:
> When searching for a struct definition I often enough end up simply doing
> 
>   git grep 'struct foobar {'
> 
> Sadly some of the ELF structs did not follow the usual coding style so they
> were invisible.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] ELF uapi: add spaces before '{'
      https://git.kernel.org/kees/c/5ce85ed9d20e

-- 
Kees Cook

