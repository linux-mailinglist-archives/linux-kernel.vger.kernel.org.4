Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD89720CCF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjFCBHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjFCBHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:07:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC4E44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:07:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso3809179276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685754466; x=1688346466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLmhMV9XyKKiYsG3/7lQvDrFcS37TrSgO5kVnY8wmfU=;
        b=QWRuhagCLE/Tq56L7GKOFndovl7SmADq5bx8vX2d9wjMIiG1pLdM8q1caB2LrAqejB
         jX01JEAPdRkkQWqMZF3YKsKvZOMnS4SJjHlrELoLV/jeFxMSJsSKUOnuOgjk17v0Conr
         p8OsbCcG78PpMIrcILc4BVhAWW9TePFjXNQ3S2It65uxWNjSdEnMx/m5s6uR1UonyNT4
         +UOkC4clwURUoMb34HeQEXoBDwkZLK7t4GFBPdemscWMMZwQTbSdC6YluSz8Lb1VbvYP
         QE6qhORivpJ89wcdeyMuLGYthxwu+r4gf12HOKXapYl1vzjv/Sp10oHvKUyP1KDBHiAC
         Pl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754466; x=1688346466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLmhMV9XyKKiYsG3/7lQvDrFcS37TrSgO5kVnY8wmfU=;
        b=KsohGgOdWVwS+0M2u0p6iVXpE1G1i2O2nQj2rMFSOWtptSUVVUZ/+LmT0HJTwt7QrV
         e7vf0zdo7vizgtg7eHZ9/LRhz8Xcu272l5DWsTGnWXkK2sCXq1uSrYYoMHHEhnszOuRq
         wzXJzj1BTUGhsFES94GdfeUO6lIMd6/rDCiku6PKlQWwh6sLIiGlXKzwL/RQe03ohd6d
         WyrOPJ4bspp8IxdugOPTO8EDxZ19lyg3OLipk6mNG3e83e8gSkgE/bjGB9tzeefj5rSy
         mVpU9+uLcOnzk0QCrmoNCh+uMpXovitwsSBkagfSk8Zv4jIalCZQ1XOspCQzvC3fD6iP
         wF9A==
X-Gm-Message-State: AC+VfDyP2eD+k+PKu4J21iFGo2FSew8QvUj2KY3ldutXN3Z+wXwhAr7n
        YGMN/PRu0hJTm18ED6aa0aNCdpZuMtE=
X-Google-Smtp-Source: ACHHUZ7Z1bFovuXnK1rJp6WzZr5U8tmJNDQrbukR97I2kVZw99w7qCw4MTune9Xvec+/orZpSb//4fpc3WQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1206:b0:bac:f608:7113 with SMTP id
 s6-20020a056902120600b00bacf6087113mr2948690ybu.4.1685754466754; Fri, 02 Jun
 2023 18:07:46 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:07:45 -0700
In-Reply-To: <20230525153204.27960-1-rdunlap@infradead.org>
Mime-Version: 1.0
References: <20230525153204.27960-1-rdunlap@infradead.org>
Message-ID: <ZHqSYbYscprsU2qT@google.com>
Subject: Re: [PATCH v2] KVM: MAINTAINERS: note that linux-kvm.org isn't current
From:   Sean Christopherson <seanjc@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023, Randy Dunlap wrote:
> www.linux-kvm.org is not kept current. It contains antiquated
> and historical information. Don't send people to it for current
> information on KVM.

It's definitely stale, though unless Red Hat (presumed hoster) plans on decomissioning
the site, I'd prefer to keep the reference and instead improve the site.  We (Google)
are planning on committing resources to update KVM documentation that doesn't belong
in the kernel itself, and updating www.linux-kvm.org instead of creating something new
seems like a no-brainer.  I can't promise an updates will happen super quickly, but I
will do what I can to make 'em happen sooner than later.

Paolo?
