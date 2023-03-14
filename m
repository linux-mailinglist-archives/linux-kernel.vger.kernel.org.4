Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B516B86F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCNAgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCNAg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:36:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02082ABC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:36:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y19so7978849pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678754176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlH32Emuag8G8y9Ul5mcocRDTiGSeipNTGU5xstePhI=;
        b=LC9WAk/kiCsVP8DZ63qBj9WES4RNUeUZHz0x915YlHbjaPh1l3J5fJy0NT+ObTGJ08
         sPWmP+WS+kbCjhi1JhXNgK/wc/KZPWlI8vzMvW6uH/HNrHWddbpdOnG/SYvbdAUA0QoC
         EIXxfZpCRb47Gr2HzktVuZIxIh+TNzB3UjGpMVy+N0dnFtRGcXGG7Hgoxp3jVeqECN4Q
         TaorKyjxRuAM8gsKUtzC+GLqU8UXvNLbUGwyi4p1G/SDr/Ay2Ylot98x5f+kclK5y7e8
         2PqekyLXOp6JRzqiMkYMYka9PZJzEN5ibhbksk7TJcb1VQ4L9w9hi6UsdTUlczTwMtAj
         rGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678754176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlH32Emuag8G8y9Ul5mcocRDTiGSeipNTGU5xstePhI=;
        b=YWG30pr4URIzwc4pPXVgpkQ2gqhcp3efw72UgdhapKMHQGLMUdj72Y4FXZ2XBxChtv
         JZVvZkxkOIHatHauuTI+DGWoNjDMkmU6k4MCZuOqcIk4w3AyxbKPoQ3jC3ugGx7TNEdE
         TWmvRT5LAHMA3Jnj/W7DxZ7tnihRMRD9ft9WF175czIHepHQg0CQrBAqyWyHlgS3y9/0
         eAXhOi5bzYIZYm0aGARTKo/qyvSkJ/ksEwwmzKqwUEPo7sQCMtbT0rZdG27Y9Y88LTrC
         tAKGGh+r+PwtoQaYzUK7a5FSEiLBRd921uT00Ryup4t4WkLHSn7gRZJR1gh4sgslIbEp
         K+Wg==
X-Gm-Message-State: AO0yUKXzC1qKNke5w9jxggcm5gK/4VMH9ADVXvgf0wNFtXxmsDtPAMN0
        GyXrpZt13CLts3WxgIRvqt1QCw==
X-Google-Smtp-Source: AK7set+Oh5cn1IYOWU6yauoYsJOvLntjuV2ZQ7CGBQKzeIOFxWwEiay+rHs7xVVYnsJGnaGv7uURFQ==
X-Received: by 2002:a62:8489:0:b0:5a9:bf42:fcc5 with SMTP id k131-20020a628489000000b005a9bf42fcc5mr40513981pfd.0.1678754175989;
        Mon, 13 Mar 2023 17:36:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7828b000000b005ded5d2d571sm271368pfm.185.2023.03.13.17.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:36:15 -0700 (PDT)
Date:   Tue, 14 Mar 2023 08:36:10 +0800
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
Message-ID: <20230314003610.GD2426758@leoy-yangtze.lan>
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan>
 <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan>
 <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:

[...]

> > Just a quick summary, here we have two issues:
> >
> > - With command:
> >   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
> >   -- taskset --cpu-list 1 uname",
> >
> >   perf doesn't enable "text poke" attribution.
> 
> No, it enables "text poke" and perf fails to decode coresight trace
> data too. It doesn't matter whether "--kcore" is after or before "-e
> cs/etm/@tmc_etf63/k".

Understand now.  Thanks for correction, if so we can ignore this one.

Leo
