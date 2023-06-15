Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980A731A64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbjFONrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjFONrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:47:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA04193
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:47:39 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75d4dd6f012so324654185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686836858; x=1689428858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HlZJFQHGnnGtL9UMgugLsRODzWb3kDKPZVxr84A3G1U=;
        b=lNWXFDzCR59VgJ5LNZpPBjWbbMoVrpWdSpFbIsODbhVv7+mFtpIr/PQw7VIabqJlPD
         saQI0qmGe3TReDc1TlRpqcR4kiOxQtNqPv9CDsms4JRnWSuAtgFTx+grFiQ1gs8KKLPg
         0h/DgmqrMInZfe/+UXFQSHCktjo7q1PoheThf2rKMvG9RmI+O1SoDhyj6r8EAqF/rrev
         VTw10YDPpzkYISVW4MvqoDv4XFSt8LuJSq5YStzNj8eROq/R56ocLe/8fhfdgQaMHotq
         4W2jvDQ60qXxq28pXPyMgnzllgufXTpZvCDn8rdLqKOq4vm2g4BaTunNxfHi1mn3KO2y
         gEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836858; x=1689428858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlZJFQHGnnGtL9UMgugLsRODzWb3kDKPZVxr84A3G1U=;
        b=It/IqYtwf/xO9Ek+kyLmM7gEN1q4y69cmS6aww4GdZLWCnszqOEnDH3Ok3p2mdg5D2
         BfxlQju98oDT/RHf/HFm5gcjEy9/vV+TI0FKY5X3L3sLTZvfSfNwyvyMDixEQqx1WBOh
         tcMjdJA56HIFpEMQbdkzT8rTvvE1jejtsn89//OQ3U8JHheOq0SmwxM+AD0spR5euumf
         O9mRLWhGslnZWJdN35V1g5Fko315bhbVK5janx0fN9tKQwMHOncaKLcIl177QWkar6n5
         lKJlBd5kz2ItA5ZaDnO9JRD1GniQ+KXlqapzWN20+jMa2TDTJ9GBjS+Nif/ggo8RNO0f
         aMDg==
X-Gm-Message-State: AC+VfDzc4CZdXpASD5fqN9bndgWVGX0T1fo13hWxUY5smDnav9z4h2I8
        sCAivOaf1QuRFfv7/1cSqvYxQmraOvs4ekHEY8/4uw==
X-Google-Smtp-Source: ACHHUZ5L3ZNI4mtuSiaC2uTD2gKYjnuz0pHO5+/2rAu1ZpYEpHnOveGpH3JaKWLKXP+kxxIm8tsTcJtzy0kuRZKwMTM=
X-Received: by 2002:ad4:5d63:0:b0:62f:edd7:3155 with SMTP id
 fn3-20020ad45d63000000b0062fedd73155mr3161258qvb.45.1686836858413; Thu, 15
 Jun 2023 06:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info> <0f6c9dcb-b7f6-fff9-6bed-f4585ea8e487@linaro.org>
 <CAMi1Hd3Cv1i06NhpY6Jqu7OvMpOdzTj6nTEMJNWLrMwMLsugZA@mail.gmail.com>
In-Reply-To: <CAMi1Hd3Cv1i06NhpY6Jqu7OvMpOdzTj6nTEMJNWLrMwMLsugZA@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 15 Jun 2023 19:17:02 +0530
Message-ID: <CAMi1Hd0=KV7k82ARadF45nqX+Cv6zPLCxfDvOyAPeXiFd8jpVA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 at 00:38, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Thu, 15 Jun 2023 at 00:17, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 14/06/2023 20:18, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > On 02.06.23 18:12, Amit Pundir wrote:
> > >> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
> > >> list to workaround a boot regression uncovered by the upstream
> > >> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
> > >> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
> > >>
> > >> Without this fix DB845c fail to boot at times because one of the
> > >> lvs1 or lvs2 regulators fail to turn ON in time.
> > >
> > > /me waves friendly
> > >
> > > FWIW, as it's not obvious: this...
> > >
> > >> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
> > >
> > > ...is a report about a regression. One that we could still solve before
> > > 6.4 is out. One I'll likely will point Linus to, unless a fix comes into
> > > sight.
> > >
> > > When I noticed the reluctant replies to this patch I earlier today asked
> > > in the thread with the report what the plan forward was:
> > > https://lore.kernel.org/all/CAD%3DFV%3DV-h4EUKHCM9UivsFHRsJPY5sAiwXV3a1hUX9DUMkkxdg@mail.gmail.com/
> > >
> > > Dough there replied:
> > >
> > > ```
> > > Of the two proposals made (the revert vs. the reordering of the dts),
> > > the reordering of the dts seems better. It only affects the one buggy
> > > board (rather than preventing us to move to async probe for everyone)
> > > and it also has a chance of actually fixing something (changing the
> > > order that regulators probe in rpmh-regulator might legitimately work
> > > around the problem). That being said, just like the revert the dts
> > > reordering is still just papering over the problem and is fragile /
> > > not guaranteed to work forever.
> > > ```
> > >
> > > Papering over obviously is not good, but has anyone a better idea to fix
> > > this? Or is "not fixing" for some reason an viable option here?
> > >
> >
> > I understand there is a regression, although kernel is not mainline
> > (hash df7443a96851 is unknown) and the only solutions were papering the
> > problem. Reverting commit is a temporary workaround. Moving nodes in DTS
> > is not acceptable because it hides actual problem and only solves this
> > one particular observed problem, while actual issue is still there. It
> > would be nice to be able to reproduce it on real mainline with normal
> > operating system (not AOSP) - with ramdiks/without/whatever. So far no
> > one did it, right?
>
> No, I did not try non-AOSP system yet. I'll try it tomorrow, if that
> helps. With mainline hash.

Hi, here is the crash report on db845c running vanilla v6.4-rc6 with a
debian build https://bugs.linaro.org/attachment.cgi?id=1142

And fwiw here is the db845c crash log with AOSP running vanilla
v6.4-rc6 https://bugs.linaro.org/attachment.cgi?id=1141

Regards,
Amit Pundir

PS: rootfs in this bug report doesn't matter much because I'm loading
all the kernel modules from a ramdisk and in the case of a crash the
UFS doesn't probe anyway.
