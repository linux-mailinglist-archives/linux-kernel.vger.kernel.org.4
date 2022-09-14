Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515F75B8F32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiINTNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:13:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3F82754
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:13:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v1so16090010plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=S9L54d9ejf1NmwAUJDCigQttDKda2K6sfA3rObHzMpg=;
        b=c4hDS2zVBu9ei6ererX584QnTMU4ialGRb8hnZiD1e3jQuwv1JWFp9QHAvikvqEl39
         ZAnOR07KIs+mSq/734pcyXR9Vl2gV7hqDv5drUjZdLJD890ni9m2kiL2bKZoNS56KEe8
         QHmOU9EHw0fw0g7awK975CXDVvaP7ooYE5Gn1Hgb77HMtYvfZsEGUuYtnj1Wa1jZBNUt
         i4XHe6ReITMhxzY4tJnVT4WmbXiwVeoo9G655/n5tMa/1QuLotr0n9ZOcFL/9ed4k+8x
         Dc0kPWNsG/Xjozt/+GjLJnL1aeX+1PZTXrxD6MsQRu3s1Fyst7x5BqjiiD5EbcdtuGTy
         Q8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S9L54d9ejf1NmwAUJDCigQttDKda2K6sfA3rObHzMpg=;
        b=63kUhKsuc0mnRm7EggasVxJFl8jlmdZOLKpLBpi8mUJ37eKNiOfLlctWx1YTa7ov5E
         LFhp6h/yl0DwJFf1RBvPnPBvPRIS/yW81F3yFuE7Wl0ARLLbD26zf9i+29hnkG+Wg5BZ
         oYODuuaT6xKoQ8K/u5wPDe0WRWUFQjSzAkVkd7QMhOeENMWfhVWVm2vVmy3S0w16a2Qx
         DZtKag1qt6MFvuSgvyfrnrfNpdDU9bhocKkf/8EAuL1HHb/HQGNpz4oDMBV7ZT/mPxH6
         M4HERQcffYCIw1ZjqvbU3jtdQwg+DOrse2kbW6n7bvGB2/B8MlNg27/i02BYgYcgF4Z8
         37Kw==
X-Gm-Message-State: ACrzQf3B9AbA9k6iAa/5IfjRjaGw+RPM+nVlLV1x/UN0UW3H6osxiOD2
        gIKG2k2tAGqt241Tsi8qmQoWhs5yTkaukRodj5ET8w==
X-Google-Smtp-Source: AMsMyM5fHYc+9/PnP/ka9LKtMpxpCAUVFD+ABMudbEnATQqSfJ7PMh0Gh0dnoR+kbfgy/nNV/RKHgcL9W2zSnT40pV4=
X-Received: by 2002:a17:90b:38cc:b0:202:e0e8:e802 with SMTP id
 nn12-20020a17090b38cc00b00202e0e8e802mr6469336pjb.121.1663182820042; Wed, 14
 Sep 2022 12:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-3-vannapurve@google.com> <20220905074609.ga4tnpuxpcgppx4r@kamzik>
 <CAGtprH9Kaemwupgoo_kgM-Ci2cnN2kpXa+ZwEymSnYNFhS9Fsg@mail.gmail.com>
 <Yxpc8NDdtdOl9wpH@google.com> <20220909070125.dtqfa6neq46fvns2@kamzik>
In-Reply-To: <20220909070125.dtqfa6neq46fvns2@kamzik>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Wed, 14 Sep 2022 12:13:29 -0700
Message-ID: <CAGtprH_PaAWqvT+89nhUbBV3QjO2b0i=KS4s6dL0ZxZA3WZ8GA@mail.gmail.com>
Subject: Re: [V1 PATCH 2/5] selftests: kvm: Introduce kvm_arch_main and helpers
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     David Matlack <dmatlack@google.com>, x86 <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Sep 9, 2022 at 12:01 AM Andrew Jones <andrew.jones@linux.dev> wrote:
...
> >
> > void __attribute__ ((constructor)) kvm_selftest_init(void)
> > {
> >         /* Tell stdout not to buffer its content. */
> >         setbuf(stdout, NULL);
> >
> >         kvm_selftest_arch_init();
> > }
> >
> > Per-arch:
> >
> > void kvm_selftest_arch_init(void)
> > {
> >         /* arch-specific pre-main stuff */
> > }
>
> WFM and I think that's what Vishal was suggesting as well.
>

Yes, this matches with what I was suggesting. Planning to post this
update in the next series.

- Vishal

> Thanks,
> drew
