Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85464A52B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiLLQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiLLQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:40:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A54167D6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:37:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so12682432wrh.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rH+nad7vc6EA7K3ETqSp5AKWpi1iWQe2NlaqEfA8K0Q=;
        b=MDnmIaP5XogOAs8wBNdcSSfDn0cyV8chPS19FHHFZhlyE/T3tvknyiLf4ZGxGbOSBU
         W4wfvVp24QBuo67GcT2a7buqSQ9BkwZOyjos0YZrsTdYtKDKMpW1d4wS+xpZ2oDKbcaY
         bCrrMm6AansBYrC+oD5mJ+n5uDlw3D9TP1kc5NtrJ2+DyKPlfcofyDRp/67E2VD4/yk1
         fULS+Dv2f/CJ2hanYcj1hK1TOsj2Wpquaa6Jz1kPUE4xJ/0tS8krYMEeZynSzXPmaPyH
         qN0EFFxluy0msAVc9CluIMvPHwwomFFFkBsAtbYc28FMJJfwmKGOLml5U0BY7jK88fRQ
         qvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rH+nad7vc6EA7K3ETqSp5AKWpi1iWQe2NlaqEfA8K0Q=;
        b=7BWta21uvvlZ+SuydaFr91htsIsMHH3oosBSdkdPmpWmog7wV4cofhR0rPGVp+LzBL
         eNJ76+7TaRoFgGrmE7Rtpd+5ARTEJbS6hu77m8BHklynwZROJW27bOtQWrH6sIMFEI3U
         CPXOPDNH+1ew0ra/4Fz4JjfH47EaCKJ4jfdl15AeUfUSrvEcB5F1dBIqzWoIXr8z2Wvm
         rQyIs4k1kVqbJtJQ5nR8lOlRx97VzUSvt0J+NQsufjoNYZ9sX9nU4MZ6yqVjP8/ylwPS
         XSyvC2sNK6S+SPRQV3uPx7hhkkrB4dUYNt6mNpDsYrGkmEAyydbA2QR9OMsMUnxgPOc2
         coVQ==
X-Gm-Message-State: ANoB5pmR0pFpjLkLoUDckl+YL0rO85MI+G9O2cC/xyuQ9JNRSfhA7Ai0
        ILmSWWm0SnzDpJL2yTJO55hGKPy4NdVOmq86+Pm2MpWLtLM=
X-Google-Smtp-Source: AA0mqf4utxrIT2FMyS0UrJ16JZce0jtQVuLyLRErdFdFhEUF2suOs7Drpv8E/w/AhvzugcclOwqjncD9XRBU+/q39HE=
X-Received: by 2002:adf:df81:0:b0:242:6553:668e with SMTP id
 z1-20020adfdf81000000b002426553668emr10671811wrl.131.1670863070984; Mon, 12
 Dec 2022 08:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-4-nphamcs@gmail.com>
 <Y5UbhBTB2nSMN4UD@ZenIV> <CAKEwX=NwUPShF3zud7kn_gyd4BZy8S6xzm6iFuw0eW=o=3A8nw@mail.gmail.com>
 <Y5dV2jrZGMvgIZCx@casper.infradead.org>
In-Reply-To: <Y5dV2jrZGMvgIZCx@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 12 Dec 2022 08:37:39 -0800
Message-ID: <CAKEwX=MDEE__cQOiDTA1q9s3RFbV6N+pzE=npufmtZ3vdxxGgw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cachestat: implement cachestat syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 8:24 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Dec 12, 2022 at 08:23:31AM -0800, Nhat Pham wrote:
> > > It would be easier to read if you inverted the condition here.
> >
> > Oh I think I tried
> >
> > if (!f.file)
> >        return -EBADF;
> >
> > here, but there are some mixing-code-with-decl warnings.
> > If I recall correctly, the problem is with this line:
> >
> > XA_STATE(xas, &mapping->i_pages, first_index);
> >
> > which is expanded into a declaration:
> >
> > #define XA_STATE(name, array, index) \
> > struct xa_state name = __XA_STATE(array, index, 0, 0)
> >
> > It requires a valid mapping though, which is
> > obtained from f.file:
> >
> > struct address_space *mapping = f.file->f_mapping;
> >
> > so it cannot be moved above the if(!f.file) check either...
>
> Perhaps you're trying to do too much in a single function?

That's fair. In an ancient version of this, I did try to separate
the folio-walking logic into its own function, but then decided
against it because it seemed unnecessary. That was before
the complexity of that piece of logic blew up to the current
situation though, so perhaps it is time to revisit this decision
and refactor it.
