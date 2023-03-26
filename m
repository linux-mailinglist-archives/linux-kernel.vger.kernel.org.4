Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B936C920A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 03:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCZBVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 21:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCZBV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 21:21:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FF8AD1C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 18:21:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ja10so5391985plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679793688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn91PEQBBtzBIF5yw02fLm9aBhJmSzBAGB+JbnA9xHs=;
        b=eJDY02Td5Fjm9U7zfHht6oNEQbU9XeradX7HhcGr43QWfhhda0+gyLTxcXGSzMqqk9
         VmJ5T+NTESwAf67T4ehr9LHLr+5SJMk5wmCXsnYjh3V5mQWcIYKOOFivcFxITMFzlm5Y
         bRUp9ApLTJkVZdogvSGRbbfaGzdwT5zf/+xeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679793688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn91PEQBBtzBIF5yw02fLm9aBhJmSzBAGB+JbnA9xHs=;
        b=WNxS5MNtmSFGeFwYRRpw/vhk7LyB1KfJr1nxr2MlDQwxI/YjLlTPpK25nBM63s5Oya
         1DFBZRioviEQ4W5xRlzfIr7zNCJ3I9rkYaZ+2vk2L1GqQ81MKKFLOjqvCZTORxGin+ZA
         KqP+E4gm2YUiCao8FT8TE5q/g/EusgMzkA4JMRFR+KZNo6nnamJ77ni6qNYTTjPPyCFQ
         JM4ZVK9gXjy+3DyTFmJlKtlFWegdB9qxMt+Q1c2VBSHphVWN6G4jIfRs7rBLKbSJ3wlD
         zIVvyzPt3v18p8NqaYjkNS5V27k6ckbCb1bvW9qguTWmh+vlGH4TETjWmM9UgFNMKwQe
         MCkA==
X-Gm-Message-State: AAQBX9cGenKkbUsPBs/PU051e8VAaMqS/zUXaRTh6qEdULP6O2iQLo0d
        oF5G+VpqP4B3Du7IwyB2/J+Ezg==
X-Google-Smtp-Source: AKy350a6cx3SdSyqHaF5NDakY1EZYnfrlQusqy6CfZvfb/N6PdaKRFyYtLB3pBIncvES1Km/vlpOZw==
X-Received: by 2002:a17:902:f353:b0:199:1160:956c with SMTP id q19-20020a170902f35300b001991160956cmr4579240ple.31.1679793688012;
        Sat, 25 Mar 2023 18:21:28 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902a3c900b001a04202f781sm16492807plb.264.2023.03.25.18.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 18:21:27 -0700 (PDT)
Date:   Sun, 26 Mar 2023 10:21:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] zsmalloc: minor documentation updates
Message-ID: <20230326012123.GB3269998@google.com>
References: <20230325024631.2817153-1-senozhatsky@chromium.org>
 <20230325125419.1b86c2331d94f86bad30d2aa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325125419.1b86c2331d94f86bad30d2aa@linux-foundation.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/25 12:54), Andrew Morton wrote:
> On Sat, 25 Mar 2023 11:46:29 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > 	Two minor patches that bring zsmalloc documentation up to date.
> > 
> 
> It would be best to keep the in-kernel documentation accurate
> for the kernel version with which it is shipped.  So can you
> please suggest a Fixes: for these two?

Sure.

For zsmalloc-document-new-fullness-grouping.patch it's not very trivial,
since the patch covers several internal zsmalloc changes: new fullness
grouping and new zsmalloc classes stats fullness format. I think it's OK
to just say that it fixes patch that converted zsmalloc classes stats to
new format.
