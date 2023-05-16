Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8A705B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjEPXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjEPXha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:37:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E85260
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:37:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f1217f16e9so861e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684280247; x=1686872247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3cyjPKDEETW9BoaEFZPFlkSTqObLADNtxINVLQqYFs=;
        b=sfoNUTG7NcUMYKrPlQ6h6W5SKsRa0vmOp8q/513w0aQHfwXABSOgbZ/0flBuGDfj1h
         N6X0KheevQYPN0GIY/kVb74OJEB9MhsqjFzR1HjeFUF8lKQ8fRjyhRdm4EAw/rt6KhJt
         0nKP/X2QE8K9G32zFaoehnKHKpleay3BM12Cu1DJ1HYyME1n30CAeCM02jHQ4nioAqtF
         7foP51GbGpZTbmLKY6Ig5epxmVaYWZ8Pc7OaO9ijoBYYTflGQYlc/GFXyyCWQD23y36I
         xzJplVx0SmcEawjdUrvg2dZjkIVX6jf11/dM8AlTUeuUdwTSud4ElguaP6EPbJmKHi6v
         QYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684280247; x=1686872247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3cyjPKDEETW9BoaEFZPFlkSTqObLADNtxINVLQqYFs=;
        b=Mu+HprY+pq+Hbp3UR/kL0mk1UkACQBpDvgrT46/NWxd/+JDUx2IuY9QSvxeqcrFOpZ
         it2bVaZiQAkUx/TLC/MFrG+1KFD2ci6CabUt5YcBRfqK95yi2Rt/tdQMRxBmeJ5UWoTr
         DFrhTILWeIccgKKjAbmWknrQmgTU/OcrQkOTQret87nkMFOryIY3Kjcdx8f72zpIwRHN
         7GM50JbFcQ1eBE5uGbT7BtW8ExRYe3PolOeVMpOu9jw+eJfnGjAiJryHBratnFgYnKpK
         a7TYGlYCTMD/LFVNeQyc39ZvlGVZlvzm7iF58nsqo8ep0vyvvMZIANKBUlt6YGqTCFP7
         a81A==
X-Gm-Message-State: AC+VfDx7nPXul9lCBraBD0yNv+mJ1i7bVnH9xVd3GPnRyHl3yV4W4T/I
        wG588Ei/ADxOhyNQEM0Z5OCBLZzr3QKlFoLLawOLqw==
X-Google-Smtp-Source: ACHHUZ7cpmyJObyaViqWzpJRKdk7zMSWg9lLD6ZsxBPhJhsDoJ5qssn7At+CRnjxlB6QS91sb2qEM3QcHU971ozzjBE=
X-Received: by 2002:ac2:4ed8:0:b0:4e8:3f1e:de43 with SMTP id
 p24-20020ac24ed8000000b004e83f1ede43mr25525lfr.7.1684280246758; Tue, 16 May
 2023 16:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-4-jeffxu@chromium.org>
 <78bb0097-7dca-254f-45a6-5cea6baec0c4@intel.com>
In-Reply-To: <78bb0097-7dca-254f-45a6-5cea6baec0c4@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 16:36:49 -0700
Message-ID: <CALmYWFvC55idHEyRiiuAwDOVv+rjP-3DejCfLW8c0iK8AGoJcw@mail.gmail.com>
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 4:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/15/23 06:05, jeffxu@chromium.org wrote:
> >  /*
> >   * pkey=3D=3D-1 when doing a legacy mprotect()
> > + * syscall=3D=3Dtrue if this is called by syscall from userspace.
> > + * Note: this is always true for now, added as a reminder in case that
> > + * do_mprotect_pkey is called directly by kernel in the future.
> > + * Also it is consistent with __do_munmap().
> >   */
> >  static int do_mprotect_pkey(unsigned long start, size_t len,
> > -             unsigned long prot, int pkey)
> > +             unsigned long prot, int pkey, bool syscall)
> >  {
>
> The 'syscall' seems kinda silly (and a bit confusing).  It's easy to
> check if the caller is a kthread or has a current->mm=3D=3DNULL.  If you
> *really* want a warning, I'd check for those rather than plumb a
> apparently unused argument in here.
>
> BTW, this warning is one of those things that will probably cause some
> amount of angst.  I'd move it to the end of the series or just axe it
> completely.

Agreed. syscall is not a good name here.
The intention is to check this at the system call entry point
For example, munmap can get called inside mremap(), but by that time
mremap() should already check that all the memory is writeable.

I will remove "syscall" from do_mprotect_pkey signature, it seems it caused
more confusion than helpful.  I will keep the comments/note in place to rem=
ind
future developer.
