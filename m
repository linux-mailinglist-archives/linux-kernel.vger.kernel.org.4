Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB325F8BE1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 17:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJIPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJIPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 11:12:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC827B10
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 08:12:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so11170020pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2hBQdaFyitVR4o7VAQhi1z5vf0SoViuC4mH8i4th+A=;
        b=JToBOpJUcGPwEp0K/SG/cfexHuQEzvqjNItWRsyrhrfn0i9LV+adrin+Tz9xESErUK
         5+fnkZWHpewPVUp4rz54yojsMWsOxmncmUhd6noH5Dgc9B5sJ2KK3BZmGZIlAW1KNhiX
         4JTXBxMb2p8kDI87YFLMY7Vs7/rYyWcHrBXBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2hBQdaFyitVR4o7VAQhi1z5vf0SoViuC4mH8i4th+A=;
        b=L3zbzc+HhglDMpKFjCv3k4mtWSVZun7RRa2+Mp6K91PCerOcmCGaS+wEisYU2/uYgm
         s5KTljuAp/DDjVUqjdgT7g4b+9D+lGoU/Gubu1PfiooxT+/gL4Ll9aqKcoi2IZHkW9qa
         IGni1Xv3Ud2UNRoFykvEF98TYqyGPlbBzbxVEHxHD0YieGlgULolDsBXJbtDShZFp0lT
         /ERcgZmOAu4ysByJD2epoXnzuC7f6MVI8TzFsZccg5Vagp/gPiWBwPedc9VKtSt+Vgcg
         XHJy86UWg9oB1ypCEPYtymJu1OpX0xKVQOmmuIxvI7Vp3wntkSJp03PwJBVtByeeciiB
         lA0A==
X-Gm-Message-State: ACrzQf008eXnubrzTWXo0j0RsELZHKxIydZecjRHIGljQ5kBUx93Bqtj
        iG9jFJVdKF113Kj8+Ot9JZGopw==
X-Google-Smtp-Source: AMsMyM59yi9b9fPwsKMyrqyI+LdLnFv6GH5a1TuUrCzG1uUibfL64xbFDmAt64nP0dHQaIogGkxA8Q==
X-Received: by 2002:a17:902:f602:b0:178:9818:48a4 with SMTP id n2-20020a170902f60200b00178981848a4mr14430380plg.148.1665328332721;
        Sun, 09 Oct 2022 08:12:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm4853779plg.205.2022.10.09.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 08:12:12 -0700 (PDT)
Date:   Sun, 9 Oct 2022 08:12:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Remove =?utf-8?Q?unneces?=
 =?utf-8?B?c2FyeSDigJhOVUxM4oCZ?= and '0' values
Message-ID: <202210090811.3C43AC2BF@keescook>
References: <20221008093026.4952-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008093026.4952-1-zeming@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 05:30:26PM +0800, Li zeming wrote:
> Remove unnecessary initialization assignments, which are used after the
> assignment.

They don't hurt anything, and in fact show the intent of the initial
variable state. Additionally, the compiler will drop it once it finds
the later assignment.

-Kees

-- 
Kees Cook
