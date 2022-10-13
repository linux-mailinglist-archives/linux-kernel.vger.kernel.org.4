Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC25FD42A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJMFR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJMFRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:17:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4986DFB4F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:17:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso991774pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgmqesKftHWSE00KVINL+qar8kr975tlk3Np4LjyX8Q=;
        b=Ap67t8eBPka2yMd7er9LDEs53x9v8JVEDtBdMR14a5SlrrytCuZCiyXjVhUVmZeCOE
         Y+P8ejPt2qamBIN0SlFvfbWOfI1+7X/fsyDYM++cnobTCDK3e5M142w4mRYlA8lCSSd1
         NxAAsJbOaZ+NHaii/y2O2oK7LdXxvmrjDHGwVROe+OklbH7ywWZyDesmK8fsFT2ZJeN2
         rUdJwKU4hY32fcKMCix/GVwYKw6z6Ge30bLaKQkYjUc/aTKiCN2b9ZtFbtzONnx8TMmj
         jGppR2hoMipONWwNwyacr2pI07px6dIozZPD+zawdGUpwc9raHrn4jVntGsgkhllI6wp
         7jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mgmqesKftHWSE00KVINL+qar8kr975tlk3Np4LjyX8Q=;
        b=zoyChMHcw9XRI7nF4kgsvHcDZ7f1mcbFQmPgVxAz4t9v75hq6e7o97hc/w0Fq3mOlt
         TSMgbVtR0hPHaEEOrivl6viPGnI2XjtjMg26E2WskdsRjNqHvALoxD9UgJK5WXx14GZE
         NEa13o3IUpONXQ+hPo3NK6S48fwUKKvjz0rEo+VqSzmmLUK9TjlC6InDCOqEJoKPzk0G
         KQV0N67L5eXyiA7JZAyaulovY8pEXq60XAEgIXdnxUEg/9q+aqBWlL4tMKfxis3yfv8A
         qREfsnv0qCND7wgHnWEPEZRSoKH6ACDfbSB+vMAPHQGBRDVPuFp8HFpGK+wjcm9e7Tio
         pyCA==
X-Gm-Message-State: ACrzQf3uA3T8XV/IZPp5Gx9OdM1d6RtSVutbPdmCOzCPsbEG2EYpnwIH
        X6o+S0PP2QF/TTzu7xVIGuQ=
X-Google-Smtp-Source: AMsMyM7jUL85MKl03w4acrGr8UP5tMKsHerd1QVIEu6aZ/7f6V3fHuV49DgjCHZWgFyNZtXTFja00w==
X-Received: by 2002:a17:902:e552:b0:179:e795:71c5 with SMTP id n18-20020a170902e55200b00179e79571c5mr32627906plf.57.1665638271270;
        Wed, 12 Oct 2022 22:17:51 -0700 (PDT)
Received: from localhost ([202.173.165.98])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b00172e19c2fa9sm11720893plh.9.2022.10.12.22.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:17:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 Oct 2022 15:17:37 +1000
Message-Id: <CNKJHFYTRLX9.1OXK4PSAZ6J28@bobo>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Cc:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <ajd@linux.ibm.com>, <aneesh.kumar@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <christophe.leroy@csgroup.eu>,
        <cuigaosheng1@huawei.com>, <david@redhat.com>,
        <farosas@linux.ibm.com>, <geoff@infradead.org>,
        <gustavoars@kernel.org>, <haren@linux.ibm.com>,
        <hbathini@linux.ibm.com>, <joel@jms.id.au>, <lihuafei1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <lukas.bulwahn@gmail.com>, <mikey@neuling.org>,
        <nathan@kernel.org>, <nathanl@linux.ibm.com>,
        <nicholas@linux.ibm.com>, <pali@kernel.org>, <paul@paul-moore.com>,
        <rmclure@linux.ibm.com>, <ruscur@russell.cc>, <windhl@126.com>,
        <wsa+renesas@sang-engineering.com>, <ye.xingchen@zte.com.cn>,
        <yuanjilin@cdjrlc.com>, <zhengyongjun3@huawei.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.11.0
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net> <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net> <Y0b3ZsTRHWG6jGK8@zx2c4.com>
 <20221012174826.GB2995920@roeck-us.net> <Y0cJfoPLGeuzm/gQ@zx2c4.com>
In-Reply-To: <Y0cJfoPLGeuzm/gQ@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 13, 2022 at 4:37 AM AEST, Jason A. Donenfeld wrote:
> On Wed, Oct 12, 2022 at 10:48:26AM -0700, Guenter Roeck wrote:
> > > I've also managed to not hit this bug a few times. When it triggers,
> > > after "kprobes: kprobe jump-optimization is enabled. All kprobes are
> > > optimized if possible.", there's a long hang - tens seconds before it
> > > continues. When it doesn't trigger, there's no hang at that point in =
the
> > > boot process.
> > >=20
> >=20
> > That probably explains why my attempts to bisect the problem were
> > unsuccessful.
>
> So I just did this:
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 2fe28eeb2f38..2d70bc09db7e 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1212,6 +1212,7 @@ static void __cold try_to_generate_entropy(void)
>         struct entropy_timer_state stack;
>         unsigned int i, num_different =3D 0;
>         unsigned long last =3D random_get_entropy();
> +       return;
>
>         for (i =3D 0; i < NUM_TRIAL_SAMPLES - 1; ++i) {
>                 stack.entropy =3D random_get_entropy();
>
> And then ran it, and now we get the lockup from the idle process:

Yep that rules out the random code. And really if it was calling
schedule() it shouldn't be getting a softlockup anyway.

Thanks,
Nick
