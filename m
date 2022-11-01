Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A695D6155AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKAXC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiKAXCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:02:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D32C2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:02:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f5so19364249ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1GdaZsbTBZ1IzvfiXwZ441nhI4PYcYDBPSYLuFmf1M=;
        b=hP5w4fPR/AIxrYr95PtHsP/y05FHCT08b+LGW99CRwW/9K16UMWMHOUauArDwljvm6
         pxx61Lc79LAv3++pWDLO2KWNApV8fkFgRfvI7syV9AA3zhKHUyQvsVOFzD07omjcfrPt
         GhNV71QZ9vTlw6Nd0jt1Hv8MmPnwli7J+Zq0LwD3ID9FEhRNcAd898+9s250zhbMWceO
         12Plq6iYEaRsPTZPCBpBqWxcpLpY2efHUSvTA35K5zvw3+yh4NWXpuoDSBXoqVoFoEu9
         5KzUS0jBNCwQpToXE7nAFtDYH8bvogF2Utr2JNFDwPu6M4Dm7yzHQfCTOEEyWayoIDN2
         TQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1GdaZsbTBZ1IzvfiXwZ441nhI4PYcYDBPSYLuFmf1M=;
        b=4RD3b0VN8+H+D0ePLsMM6SIKOkJxTaQxU7lrl+KC67N7pHQhgLLeksKmhNjdeurt9K
         4dcls4Tr4pwn1JVGuCzre9VfSfbzym1KDqldr/rvGCx3yGuYvWnpj78HavhOocBgcaxX
         DfHrmTHhDe9JGIt3Tb8LsyfiSFSrtz64cMv5fJCFK8QI5rZ1UegRS3ktH3jHiSz9CfOf
         xHBsKcT0Ukp73+fUpq8OvqxLJDXCZARj3hhd/6obfPpzWGLgbPxkMtZ4q19EVHiAeSHu
         H58kHCdHIkBS0eKWtzKU85mvxLuLO2lz/UvOqXfqLPsaLJhy37rX0lFUwuPfDgYOU184
         83Iw==
X-Gm-Message-State: ACrzQf1Ei41jN34aFWecUchuLDTwizYzkgUuedk+aowO/qPA/A9gc+97
        ZZhZmeHpu+aJIGRniSHYW1S2/g+exxBRljH1sUXaFUYfe+bz5w==
X-Google-Smtp-Source: AMsMyM5f0kQ1Gv1cj0tuNeepRB2Dai1Ejxn1AJ72L8VOI0YzfIy1vhFqT/JU0CHXx2cWPjut934y0Bgxu9efYWzb8uk=
X-Received: by 2002:a17:906:99c1:b0:6fe:b01d:134 with SMTP id
 s1-20020a17090699c100b006feb01d0134mr20262535ejn.598.1667343772538; Tue, 01
 Nov 2022 16:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com>
 <20221031121314.1381472-3-kajetan.puchalski@arm.com> <CAAYoRsUDxsbexq5KmNTk60Ki7V4q-LxHeCzJmm9DEB6O49ks2w@mail.gmail.com>
In-Reply-To: <CAAYoRsUDxsbexq5KmNTk60Ki7V4q-LxHeCzJmm9DEB6O49ks2w@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 1 Nov 2022 16:02:42 -0700
Message-ID: <CAAYoRsUgm6KyJCDowGKFVuMwJepnVN8NFEenjd3O-FN7+BETSw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:24 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Kajetan,
>
> On Mon, Oct 31, 2022 at 5:14 AM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
>
> ... [delete some]...
>
> >  /**
> >   * teo_update - Update CPU metrics after wakeup.
> >   * @drv: cpuidle driver containing state data.
> > @@ -303,7 +359,9 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >         int i;
> >
> >         if (dev->last_state_idx >= 0) {
> > -               teo_update(drv, dev);
> > +               /* don't update metrics if the cpu was utilized during the last sleep */
> > +               if (!cpu_data->utilized)
> > +                       teo_update(drv, dev);
> >                 dev->last_state_idx = -1;
> >         }
>
> Ignoring the metrics is not the correct thing to do.
> Depending on the workflow, it can severely bias the idle states deeper
> than they should be because most of the needed information to select
> the appropriate shallow state is tossed out.
>
> Example 1:
> 2 pairs of ping pongs = 4 threads
> Parameters chosen such that idle state 2 would be a most used state.

Sorry, typo, I meant idle state 1 would be most used.

> CPU frequency governor: Schedutil.
> CPU frequency scaling driver: intel_cpufreq.
> HWP: Disabled
> Processor: i5-10600K (6 cores 12 cpus).
> Kernel: 6.1-rc3
> Run length: 1e8 cycles
> Idle governor:
> teo: 11.73 uSecs/loop ; idle state 1 ~3.5e6 exits/sec
> menu: 12.1 uSecs/loop ; idle state 1 ~3.3e6 exits/sec
> util-v3: 15.2 uSecs/loop ; idle state 1 ~200 exits/sec
> util-v4: 11.63 uSecs/loop ; idle state 1 ~3.5e6 exits/sec
>
> Where util-v4 is the same as this patch (util-v3) with the above code reverted.
>
> Note: less time per loop is better.
>
> Example 2: Same but parameters selected such that idle state 0 would
> be a most used idle state.
> Run Length: 4e8 cycles
> Idle governor:
> teo: 3.1 uSecs/loop ; idle state 0 ~1.2e6 exits/sec
> menu:  3.1 uSecs/loop ; idle state 0 ~1.3e6 exits/sec
> util-v3: 5.1 uSecs/loop ; idle state 0 ~4 exits/sec
> util-v4: ? uSecs/loop ; idle state 0 ~1.2e6 exits/sec (partial result)

util-v4: 3.15 uSecs/loop ; idle state 0 ~1.2e6 exits/sec

For the above tests we do not expect teo-util to have much impact.

For completeness:

Test 3: Same but parameters selected such that idle states 2 and 3
would be used the most.
Run Length: 3.42e5 cycles
CPU frequency scaling governor: schedutil.
CPU frequency scaling driver: intel_cpufreq.
Idle governor:
teo: 4005 uSecs/loop ; IS 2: 1917 IS 3: 107.4 exits/sec
menu: 3113 uSecs/loop ;  IS 2: 1020 IS 3: 1576 exits/sec
util-v3: 3457 uSecs/loop ;  IS 2: 1139 IS 3: 1000 exits/sec
util-v4: 3526 uSecs/loop ;  IS 2: 2029 IS 3: 109 exits/sec

Now, things are very noisy with the schedutil governor, so...

Test 4: Same as test 3 except for frequency scaling governor.
Run Length: 3.42e5 cycles
CPU frequency scaling governor: performance.
CPU frequency scaling driver: intel_pstate.
Idle governor:
teo: 2688 uSecs/loop ; IS 2: 2489 IS 3: 16 exits/sec
menu: 2596 uSecs/loop ;  IS 2: 865 IS 3: 2005 exits/sec
util-v3: 2766 uSecs/loop ;  IS 2: 1049 IS 3: 1394 exits/sec
util-v4: 2756 uSecs/loop ;  IS 2: 2440 IS 3: 24 exits/sec

... Doug
