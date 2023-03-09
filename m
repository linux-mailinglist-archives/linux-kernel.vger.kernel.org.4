Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938296B2333
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjCILjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjCILjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:39:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805576A9C9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:39:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x11so1614838pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678361940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYsJiKyy+lTF4z1H2mSxKLr6ADWPzBDDBXemJTJ36Ks=;
        b=qrYsSdWwsRhgnb8uDOtCBtoRToUCHBFxclejPIK5uKZNh5GhkUHLsx+shQWLFKnQRb
         lxqZQ7iqj1Rp1ij8OB5I0DCtrrEKznEBMWwEe6u77MBH82sEen6sPY+AK54YhhVv6Zov
         vVErC58toiN46BPkGNds4B1oKmfDQo1P/GuPXKmcewJs6zIMxMm2vzB9g83cmrN9i5As
         3jOPPHhtpAPnN92dBR7TQxAt+FDacKrAzodTNH8J3HQmZbftdnunON5V2OXxGUfugwm2
         fiLZlmKMfYQPp/+CjWQfWUNFi6694qDSqu+QN+UfHSYk0Ofg9B5XTmduB99kk4/x/5ov
         zsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678361940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYsJiKyy+lTF4z1H2mSxKLr6ADWPzBDDBXemJTJ36Ks=;
        b=W/qhkcFk4bBnNiYjyzZPOBR9/FIpVJ4z8tGHtmClNGpygS5N+xskj2QVQa1DJVJwCI
         WX/6VFfXaXGlsMPmKsiMlnEcd7EHv5f5A9lUFsve0sEEKr5bvLzkzebWomxG+NMLrAP5
         EhxBVl/IkVOonJutLqVyk14OifOwu5UZSM950Igw1ujSO86gV/oKfG5scaRtJsru1XER
         36w0oR1LqwzuEMqyYLpOyUFAm7nXW9m6CxLRHiOSPpzsQNlJTsEGO7y6tebBr8Pgpt/a
         Pt0v4i5fylU7l/nUR09ZmKiUygoCrUbGV/0gH5436ei6X1ZFlo/wBuRVwZtD9zyO2P/z
         Sn0A==
X-Gm-Message-State: AO0yUKWciE+wx3/MntWizC06lpdMZgbSnPxJLSQCCZOGm17uxUrh3xb6
        B4gEZz52zdu7KVgsCwY4tofshQ==
X-Google-Smtp-Source: AK7set9BcKzdqEvVwBm1rR1GGtYhrdXP+ByCdfjj8e7gOOwRGmWRyMbWRum5esDB5AWQTC0hTpRL3g==
X-Received: by 2002:a17:90b:4a4c:b0:237:9cc7:28a4 with SMTP id lb12-20020a17090b4a4c00b002379cc728a4mr22842172pjb.14.1678361939798;
        Thu, 09 Mar 2023 03:38:59 -0800 (PST)
Received: from leoy-yangtze.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id mm14-20020a17090b358e00b0023493354f37sm1427084pjb.26.2023.03.09.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:38:59 -0800 (PST)
Date:   Thu, 9 Mar 2023 19:38:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
Message-ID: <20230309113851.GF19253@leoy-yangtze.lan>
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, Mar 08, 2023 at 11:56:38AM -0800, Yang Shi wrote:

[...]

> > Dumping raw events could show the events from the bad data file. But
> > it has zero samples after event collapse.
> >
> > The only difference is --kcore inserted a new text_poke dummy event.
> > It seems coresight also inserted a dummy event with my command but
> > your command didn't. So it seems like the two dummy events confused
> > event collapse.
> >
> > The text_poke dummy event is added by commit
> > f42c0ce573df79d1b8bd169008c994dcdd43585a ("perf record: Always get
> > text_poke events with --kcore option"). If I reverted this commit,
> > then it works. But I'm not sure whether this is the right fix or real
> > root cause or not. Or coresight shouldn't insert its own dummy event?
> 
> It seems like coresight needs to insert the dummy event if
> full_auxtrace is on IIUC. So it sounds like event collapse can't
> handle such a case?

I am struggling to understand the meaning "event collapse" :)

I reviewed your shared dump, the bad and good perf data both contain the
dummy event with 'text_poke = 1'.  Could you confirm the shared dump in
your previous email is correct or not?

> I also tried v5.19 (before "perf record: Always
> get text_poke events with --kcore option", which was merged in v6.0),
> it works. So it seems like a regression.

Yeah, we need to fix it.  I am not sure the Linux kernel for Arm64
supports text poke or not (kernel needs some specific handling when
alter instructions), the kernel change is the prerequisites.

On the other hand, in the current code cs-etm misses to handle the
event PERF_RECORD_TEXT_POKE in the function cs_etm__process_event().
This might be the cause for the failure.

Do you mind to share the bad perf.data file with James and me?

Thanks,
Leo
