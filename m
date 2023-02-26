Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252316A2E36
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBZEjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:39:38 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A5CA267
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:39:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c1so3567092plg.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOQpym7IsO3779xgYY0pHM+JqHC/4Xc0PPMOaepB0YE=;
        b=fqqQqWZeVQO5k4ExZdnq+Cciyn4QJEBUe649W2xFzKhR26mBUMGaRZF5RQvmi6pIEr
         0V0e+6kxIbRwuUwSIg5gLWdMQcIxNiilV8oLhLLuVCxFSAYMWxlFuDGkKG5kdxZA4PkB
         lzHhnIRRV/QK2VRpTj1ObE0V3DgicUAnXZMek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOQpym7IsO3779xgYY0pHM+JqHC/4Xc0PPMOaepB0YE=;
        b=cE4JUEUGdpHcHMWu/A9FRuH3aoKgkG7E/kCX6gH/i1GeN8mmeHb/mI3Eu9hBSkdt7Z
         EvdTUdioGf0xrU65ui9tPZSrW5N9cGXk4ry5d4kv/wsQ46FZjJjOSuI32gU/0tMLlhaB
         tMcYtCH4ELAoaRMA+jCLbv8PENs3U10BAODPrG1L5seqn4rdi8tX/U6rxZnwf65DTHEe
         igWQKErDk7J1LbUbQudcIFEhOmiyJtzDwDYJ1jQnOxMWYAGXKYthSK3htDcswXLEol60
         2YZiFjqXp9YH3LapIu+lPJhH+MBhLWF6S+806l4RxKU0OwaxWysi3uymGUfpPbj/hQ0G
         r6VA==
X-Gm-Message-State: AO0yUKWX07w/CqB5SgsV2t6JH5ZSvUMgutZvOYhB/+LhopRUMXlNRBVy
        6b90gEmWFw1sO4T8vMkg2nDQH0z0ITRbqeAz
X-Google-Smtp-Source: AK7set+PZKSjhJKCODDCBaJ1JPON7xxnPEGUlCBy3K3ZBlAfijERRQLTLrwItdAibKJQvdBDDCSrRg==
X-Received: by 2002:a17:90b:1e4d:b0:234:d3a:2a38 with SMTP id pi13-20020a17090b1e4d00b002340d3a2a38mr22225323pjb.43.1677386377213;
        Sat, 25 Feb 2023 20:39:37 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a6-20020a631a46000000b004fc1d91e695sm1707618pgm.79.2023.02.25.20.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:39:36 -0800 (PST)
Date:   Sun, 26 Feb 2023 13:39:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 2/6] zsmalloc: remove stat and fullness enums
Message-ID: <Y/rihMSIo+Vzzg4z@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-3-senozhatsky@chromium.org>
 <Y/fyn1u5RhDwgG1J@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/fyn1u5RhDwgG1J@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/23 15:11), Minchan Kim wrote:
> 
> Using define list instead of enum list looks like going backward. :)
> 
> Why can't we do this?

I replied in another email, just to keep conversation in a single thread.
