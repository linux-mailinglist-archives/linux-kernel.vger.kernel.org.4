Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84F740CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjF1J1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:27:01 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:44353 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbjF1JQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:16:01 -0400
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fba9daf043so14233445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687943759; x=1690535759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01gfdKzfF02P0jmnqST0ihntbXHOlNcCxH5v9bR5r+o=;
        b=TiihWchIG73YfsGlzSKnKEk/8whaxTiSMp79ttuyq6lpSVmQMiCE9C92y8j/eiUvK1
         d8vW4v5ydTh38n7SaL+Mt7yj5jz1sfCEAGV1FIY6CoA77+jMA3Gvqp5Q8uQCf6DZLRmK
         in51an9AdOLRztzhvPOJLpfljISH7ZQlrDZUPUe4Wc3aidR5fNNYBMfolBTM3arZug0H
         lz+doO47P+yZvgIOz3KrYSxbMTo3LOaypxHurl/IA3UyGyHCWHoPdES9GRtG+pWBB5R9
         ga6WvQfx/FOgWKyzqzXRqzYe9rAtxlsbywCXDaM9ZdVqdEFpyYJB58RCaeMWuPWzIcET
         Pcxw==
X-Gm-Message-State: AC+VfDyYvfKPtWw0LRh61/BUqvEZwKrpNYaHcPLW6Uw9fR/InOIIp6fv
        3Qblm63O7LKDkrLfNLnVK5Y=
X-Google-Smtp-Source: ACHHUZ5hsARBwoIr3AF1HaRatYKrAwOdMNB28sX12tsvIXxXoqWb7tG6uwvpHQiXWEZCed0eK0iZUA==
X-Received: by 2002:a05:600c:21c5:b0:3fa:74ae:df9f with SMTP id x5-20020a05600c21c500b003fa74aedf9fmr14272085wmj.37.1687943759325;
        Wed, 28 Jun 2023 02:15:59 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id y12-20020a05600c364c00b003f7f249e7dfsm16262298wmq.4.2023.06.28.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:15:58 -0700 (PDT)
Date:   Wed, 28 Jun 2023 02:15:56 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <ZJv6TL4yH4HbCe/h@gmail.com>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
 <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
 <ZJseCvXVKFHu84Sv@gmail.com>
 <20230627223040.bjacsmaotlderpdu@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627223040.bjacsmaotlderpdu@desk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:30:40PM -0700, Pawan Gupta wrote:
> On Tue, Jun 27, 2023 at 10:36:10AM -0700, Breno Leitao wrote:
> > On Wed, Jun 21, 2023 at 12:41:01PM -0700, Pawan Gupta wrote:
> > > On Wed, Jun 21, 2023 at 11:36:53AM -0700, Breno Leitao wrote:
> > > > If I understand where you want to go, you think we should create a
> > > > single patchset that creates a CONFIG_<MITIGATION> for each mitigation,
> > > > and move get it under CONFIG_SPECULATION_MITIGATIONS.
> > > 
> > > Yes, a single series (or a patch) that adds config for each mitigation
> > > would be good.
> > 
> > I've been working on this request, and I may need your help to validate
> > the wordings and dependencies (as in architecture/vendors where the
> > problem needs to be mitigations) for each entry.
> 
> Kconfig text looks fine to me. (Some comments on arch/vendor dependency
> are down below).

Neat, thanks for the clarifications. I will send v3 later today.
