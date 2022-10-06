Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A035F6B17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiJFP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJFP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:58:47 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3469F762
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:58:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p186so1603318iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhfplkt4int0OXXl6rOA5hvgku7UzcUaHFHCqkD9WDQ=;
        b=d1DWscygXlo3PoeyVccQSrzoJHOnje53fYTZ1t8qmkHliszq11Knz6TMRtygq5OelH
         7ddkvAXtmLywBKK6M72UXjyXLuaFwGc62wwx8UOk/7g88tIG1YCuDvoF11y94OBsIHEE
         k7VSzZXsnargQ5mWsTpL3RhLbX7p/0sdW+M17PJm/wh49hfzTLo73hgmbZUCLMnZXPDS
         IoEaL6rt5HrqGbroAL4K7pXBC7iNi6P1aAcakC4O/ZIE2zSgFo+NuXv+/aRCeMOUEM5S
         Os5OgrpB9zfd0zDnW6BskEbT7IkiS4LWYppu+fyX32n9U4PDrFkLhQ3BX03mpH2aUSj8
         G2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhfplkt4int0OXXl6rOA5hvgku7UzcUaHFHCqkD9WDQ=;
        b=0GdCVS7FbY256ZsZuYzCBJ1h7y/1mnjQin36+hJg2M9SGM4/tOpuctOs8fhk3uNoU6
         HE4JCtbR4MNJPYWbfwaizA5WwQjPhovpiqIj7dIiZEqRzYJwug5ZfuLGLL037eOkE9DJ
         WPKXVxfjUOItOW3LuFUbzyhP8SBdrleL6iLqyaqBWB07ePTCfIqx/4BcRxfQozdhAAEZ
         pJtebx0kqGhHKDj4q6Aa7q6Mb5G6CDPxpJ+mXknM6eChhYgIQKudYFshWCBv1nug7Lue
         XYdJplH6qN08KonwODIPDAYjZ+Z8DFZUf2r9an2xYQ1ivI2R1Cj5OYCgSkcLYiMaqPMp
         11MA==
X-Gm-Message-State: ACrzQf1iARVUyyohPCmj4b6J5nqIjhMRgT2mDUXEAkQmMn9hK38qA39G
        GgZ/+wSGFNGBf+xwbeOlOsKvP3i11rV6O5IL/KoWWQ==
X-Google-Smtp-Source: AMsMyM4wHpflUDYQvQGGzTCGRCkmR/BY1OyBbZ8N7MaPUBqMSy5Cqgx91FqU7v/SLmZTt88FcRAh3vD1Rbn3IfaYdDE=
X-Received: by 2002:a6b:691a:0:b0:6bb:635f:b615 with SMTP id
 e26-20020a6b691a000000b006bb635fb615mr230925ioc.56.1665071925610; Thu, 06 Oct
 2022 08:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com>
 <Yz7316NubHtw2xCa@nvidia.com> <CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com>
In-Reply-To: <CAG48ez1Oz4tT-N2Y=Zs6jumu=zOp7SQRZ=V2c+b5bT9P4retJA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 17:58:09 +0200
Message-ID: <CAG48ez2sutJOkHvaPzA8hNhYQrea_bUxbWq3pTO1qqJ1JKBb5Q@mail.gmail.com>
Subject: Re: ptep_get_lockless() on 32-bit x86/mips/sh looks wrong
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 5:55 PM Jann Horn <jannh@google.com> wrote:
> A: returns physical address 0x000100020x00010000, which was never
> actually in the PTE

Sorry, typo, that was supposed to be 0x0001000200010000.
