Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458516BBF97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCOWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCOWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:07:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B59B2F6;
        Wed, 15 Mar 2023 15:07:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so3708291pjt.5;
        Wed, 15 Mar 2023 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678918048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRZfNvRJH2R9venvB1Ewk+3QqCpqEvBKToRomyaeMIY=;
        b=Jq8eXCLFPj7waxli1wSRcLqa0vHgD7q64CBtVK4S+LqvzH40rCjXl0GCtAh4uXDWHR
         xpYvMe7nZZc/LYtZmybJNU9mi4kPiLa+3kctOrpL1yRaRuMf0ZvPQ1QZ9ZTky7pG4kWW
         QN2g3xe5kNS1p6ocJPTkXQptlLPW90DCB6knTuJpm6PCOWIRypIIW8jJNJO3fivn/1H/
         vvgt7C/oapqU+WyYshVz3vi51fnxp7xGk9yfnLnDSnVvDgnqYFSH7ryO5up9Rp89nObW
         u2T0QyE1nHS5O/o9PwxLHP4IdYnkahmZ4aywk3HvwalC645r1TVck/8UNf6GAcwnH5h0
         VSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678918048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRZfNvRJH2R9venvB1Ewk+3QqCpqEvBKToRomyaeMIY=;
        b=DZZPLo/pYEsHqeGyqWz8qoD2wdKHFw34kQGa8saXH9dszYNvAXQ8fZdrGsPXELfUkp
         ulBqWZfHH/71fEEsq09tYt9cbvQQNrusgnmVxv+Cjui5Qjj+2aIyvLwFq2e5yDPl5Xfh
         YfJLMRExh+NrCsHtrW5hgCmVbjV7P24PxCMzqkFJFcQ8rUv142uctuMuiXp8bswuHRDy
         TLXwjViH+6258pGgiomB/IoEa/zU8zQQrIQS47tylAqapxSX6eq6s4koQXzw4OzUwRjB
         SpTDxj5TxGY7rbM49N8q4uOTZaQV1prliDQfVE344I4EOhReEliyzo31Jyi1WCCI7Ekv
         xGFA==
X-Gm-Message-State: AO0yUKVxT5piGIUqPMPYe25kiu6HWK8agz0FsWCqKwVt7EbO1vwtjGLL
        k6i4oI9v7GMbJPMum3fjqTw=
X-Google-Smtp-Source: AK7set+t30uUNq2SziUU5pNyzzPIbKC3+13zl2U4XwREnFntqtYn1OSmt2jjdQd5zgMCvxKgpJ98xA==
X-Received: by 2002:a17:90b:1bc4:b0:23b:bd09:7f0b with SMTP id oa4-20020a17090b1bc400b0023bbd097f0bmr1302332pjb.30.1678918047710;
        Wed, 15 Mar 2023 15:07:27 -0700 (PDT)
Received: from kazuki-mac ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id a18-20020a63cd52000000b00502ea3898a7sm3864100pgj.31.2023.03.15.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:07:27 -0700 (PDT)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Thu, 16 Mar 2023 07:07:22 +0900
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: s2idle: Don't allow s2idle when cpuidle isn't
 supported
Message-ID: <20230315220722.cyw4smvxlb5c5got@kazuki-mac>
References: <20230214215003.70683-1-kazukih0205@gmail.com>
 <CAJZ5v0gVi3U2K-Sj-W0QtBbbEw+HOd3FDSAyL-ugbhuxLeLZUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gVi3U2K-Sj-W0QtBbbEw+HOd3FDSAyL-ugbhuxLeLZUA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 04:40:01PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 14, 2023 at 11:04 PM Kazuki Hashimoto <kazukih0205@gmail.com> wrote:
> >
> > s2idle isn't supported on platforms that don't support cpuidle as of
> > 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
> > too"), so update the suspend framework to reflect this in order to avoid
> > breakages.
> 
Hello, apologies for the late reply.
> Hmm.  Doesn't the cpuidle_not_available() check in cpuidle_idle_call()
> trigger then?
> 
> The commit mentioned above hasn't changed that AFAICS.
Yes it does, but there's nothing in enter_state() that's preventing the
system from entering s2idle. Both the suspend and cpuidle subsystems
need to be aware that the system is entering s2idle, otherwise it'll
result in breakges.

Thanks,
Kazuki
