Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1762C6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiKPR5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiKPR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:57:23 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDFB623A5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:57:22 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so22840785ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YcGysjMEJ/1XfmPvgJmfueJkF7xVkHEadS4R5R2u0U=;
        b=VUuuabh2CfCrMmekmHW5XVeU0falz/E4xBW4hEBJUFBn1LQG+vOh5H6L9kuxTMbjic
         l8PouoREj8ZQ9jem55JPCwiN5zE8mX63xH+LwIqN016xJARuAwdznT1o4dGDF0ToXcxx
         AcboYdgdqwQhFr3YXhDGORXg1hvzc6agHQvceFwdrXt4GEmWHg0MYcDg4uhc50UorG9H
         M2jSVW5unSRBGqZ3e5V+O0Qto0SmHb3goewFX/d27MogOO7fUnJpNcilKYvHpUxpfhXj
         yy+DDUNrayOVkZ4sY3S2er0GXmcvCm/dCv3gIYwVzcZxs3V7D8b7d2239hxMMex0wsuP
         Fp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YcGysjMEJ/1XfmPvgJmfueJkF7xVkHEadS4R5R2u0U=;
        b=suW5Z2JQJlcrm8xn23guEQINevnI7clEbuhWU8RfxpFURqvpG4xKGklFvWYesg30Oh
         MR17N4axjJn5D4Vp0xOY21FbdKWUDk+4yn8VcnC9JaxtwvrVe2FXrqtktPxA0CGNQh5o
         WcNPT6kXy9qG4kugrXbsVtFcD3xVJVLXem5qKuMMhCakxLWuxfHGzBGZRt+8lB6+SKD+
         U74Qi9i4k5E1QkdAcaKURlQ6/lDVIV7EV3nuQHbUSCkLzBx20P15a96KeZEYmhzYtxgp
         Xxfmt4Z2D6+hdByqYQrj0Cn9dV+4JlROTRYLmoSKbvDg8agp9HLDXirsg/I++Mh29Xlf
         34nQ==
X-Gm-Message-State: ANoB5pmZLbRYlTNUIteRLT42yuoTpSW4MXUHY29nnoPgKxds9y19TK2Z
        CIUrY+qDpz6qMxxE+PJSoXIzNecnYUGlP7QmDWfK1Q==
X-Google-Smtp-Source: AA0mqf4GAISq8s7VVhjxgBv2aqVLkEA92icoGD8pQjteBcXCVe8K1maM1mjTfo07wfErKfEOgRGSIX6FQjwxgigEgLU=
X-Received: by 2002:a2e:a41a:0:b0:278:ebb5:ddd2 with SMTP id
 p26-20020a2ea41a000000b00278ebb5ddd2mr7452642ljn.494.1668621441148; Wed, 16
 Nov 2022 09:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20221103152318.88354-1-pgonda@google.com> <Y258U+8oF/eo14U+@zn.tnic>
 <CAMkAt6o-jcG7u1=zw4jJp5evrO4sFJR-iG_ApF7LhT+7c55_Wg@mail.gmail.com>
 <Y3TVcJnQ/Ym6dGz2@zn.tnic> <CAMkAt6qQmkufbuotzMA4bMJaA4uBFMdk8w7a3X+OH3JaOdFepA@mail.gmail.com>
 <bc070ef7-8168-f1fc-f5ec-aeac204f2ef6@amd.com> <CAMkAt6rHTgJX1KTjYmbii6dyG7QMxXJxNy1E_eZ8vRWLK9Vc1g@mail.gmail.com>
 <Y3Udxru8Rivbxsui@zn.tnic>
In-Reply-To: <Y3Udxru8Rivbxsui@zn.tnic>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 16 Nov 2022 10:57:09 -0700
Message-ID: <CAMkAt6r8ocB2b0gympDCX3zQCOOow=N+fGtD0s5jyP3ayt2-Ug@mail.gmail.com>
Subject: Re: [PATCH V4] virt: sev: Prevent IV reuse in SNP guest driver
To:     Borislav Petkov <bp@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:28 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Wed, Nov 16, 2022 at 10:10:58AM -0700, Peter Gonda wrote:
> > I think another comment above the first snp_issue_guest_request()
> > could help too. Saying once we call this function we either need to
> > increment the sequence number or wipe the VMPCK to ensure the
> > encryption scheme is safe.
>
> And make that explicit pls:
>
>         /*
>          * If the extended guest request fails due to having to small of a
>          * certificate data buffer retry the same guest request without the
>          * extended data request...
>
>          ... in order to not have to reuse the IV.
>
>
> I have to admit, the flow in that function is still not optimal but I
> haven't stared at it long enough to have a better idea...

Thanks for all the feedback Tom and Boris. I've sent out a V5. I hope
I've gotten the grammar correct in these comments.
