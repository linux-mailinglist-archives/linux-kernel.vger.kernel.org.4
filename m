Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1073E609
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjFZRNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFZRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:13:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1E10CB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:13:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53482b44007so1712303a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687799617; x=1690391617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFA2O0087NjvyF0S8z80vIbG5VDSf/bqj4h/bFzML38=;
        b=JbE9+VbXHtv0KaXgv8REdZPmNZCdym4muJIwo1avxe7YnLPOVhuCTngHxzR6LhnUaL
         8mgRNK4mi2wp25WOg6OQJpa/L2qVAgloBqhdi+L71OHMt/AeCi+b1kAgBhe4bOutjJZ/
         9yN/tbqmrk4isFmrPiQ7bT5bMugSCQqvFDpht+pQ/hsOaD+bRtCzkYDrCGH9mkIFNAcO
         OED2MdW4AQSjB/TLds5FMzIMsTB98yWJy1+IAJ3+eJ1atPzX+/bb3iCYfztcsSG/sleQ
         rg/yyEPB0ZX76v/dRVRWuCALQxaALnOsGumZ7VRVjVQ7U7ZxmYoeVcq7U5xjMaczgGpm
         pRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799617; x=1690391617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFA2O0087NjvyF0S8z80vIbG5VDSf/bqj4h/bFzML38=;
        b=e6mW/YOlwbFte7+/CDcm/n23PEKQXWf3ZP8Q5zM76kVt49icI6o15e1Ujom7MOnc5z
         D7SVosRXmIWesEXgmzuo+eoqSPk6Y9TjR80BjgydLUSLApSdYIPRrr9bghVPkiivS09D
         egtmAvn2aPJ7UKA7IMOWE6KjysX6qdddk8OB2bt+GZXR5c4biMAeowEqJstVCkmk0zwA
         QlIy2pOY1qaSAEcQGDjRqgO0t2VgIJpM2PWAgk34r4pYO8LDaw4fkHNwEVA2ryN/o1dv
         hv75bOcWcB6BDsM2qYRaGG3RC5d6oSCJoQfJe0bGN0gU1Az3kSG5aHjvWL1ZB/uf2xTf
         mXTQ==
X-Gm-Message-State: AC+VfDzTtuyD4ZH0FdybXJlL+ezZXKg1fCOvMY6mNMUlxJN7Vd+EhRn1
        M9if0eIKDRvN4N5Xo1aBGW6SFbep5M0=
X-Google-Smtp-Source: ACHHUZ4dXhOCbjlSYFXgM89GNkYYkb/dD23shwvEkg9d2j5rYrUfNXMnT6vMeFxaH8n/9N+rlS4XbQ==
X-Received: by 2002:a17:90a:4e:b0:25b:b2ba:2ff4 with SMTP id 14-20020a17090a004e00b0025bb2ba2ff4mr19276461pjb.17.1687799616908;
        Mon, 26 Jun 2023 10:13:36 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:9abd:c54f:4c3a:e10a])
        by smtp.gmail.com with ESMTPSA id ip4-20020a17090b314400b0025374fedab4sm6413464pjb.22.2023.06.26.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:13:35 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 26 Jun 2023 10:13:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexey Romanov <AVRomanov@sberdevices.ru>
Subject: Re: [PATCHv2 1/3] zsmalloc: do not scan for allocated objects in
 empty zspage
Message-ID: <ZJnHPdJVbUyq06k7@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-2-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624053120.643409-2-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 02:12:14PM +0900, Sergey Senozhatsky wrote:
> zspage migration can terminate as soon as it moves the last
> allocated object from the source zspage.  Add a simple helper
> zspage_empty() that tests zspage ->inuse on each migration
> iteration.
> 
> Suggested-by: Alexey Romanov <AVRomanov@sberdevices.ru>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
