Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B55F04C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiI3GZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI3GZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:25:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23931005D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:25:27 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1893941470
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664519124;
        bh=mIFcZhK8ZUBJ0g/1ZYnXxPqzkbqqbN8zmRF4D0To6pA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AGAXy5RlLePs+XcFb6qHDvACgG8NYYl8nN6ERQn7cAzYyYHxPqJO/QnScbv9nRzfk
         dXFwzgtkzxIAmEZihMjxdp0j5jleejYGBlymOlKcpLvHdZnNznp7G+rkHHdSVs0fEp
         HONf5vYcafc630xPAC/G73TPRosBRF4BEqMcYr9B4pVvGhFHRAXm6o2TLMbGxIzhHS
         ikp46HRgiGzQzgw+IohWxkK2+LVfdGWEaOqVJnLD8TQRI33LC6jNm8bWuC4lSVYOCl
         Yg03lDVrwzbJG8J3agvHpsonSkm5bgbz7igv0Imb1sEHU/9jaGgoBR5c14hqeLY68y
         4a+iMdRuxu3hA==
Received: by mail-pf1-f200.google.com with SMTP id c74-20020a621c4d000000b0055253d86f63so2241084pfc.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mIFcZhK8ZUBJ0g/1ZYnXxPqzkbqqbN8zmRF4D0To6pA=;
        b=7ksj4CW2Ocm6K5bHhaKA4+QGhamqK5SGCaPiNpk56zNI0D55NSS7z9hf932gP/dKxD
         0A4/iqfGxhkB4ofVauCy4/TdzM5gztNX4c8vzoBu8P6YGWHOaqlPexMt6Wvb/ZPgpfd+
         X5bgv/I2Ox0q2TJW0X2aggwaDfB7LCT084VQroomJh1ac2R6Cyfp+CfwJLD/u1YE0tnl
         0UTwfnepIUQ9f9oCxoj1xFRXZfOoXQAJ32OabiUudouhjCtQiU6Nyc8UT4gAsAiyE2D7
         Q6NjNvY8UgW+in0eB07zv8NyJYVkXkQiCBrlhsywHgUdmsHriJg2iMkaQ4RgMESqxOMJ
         XLIw==
X-Gm-Message-State: ACrzQf0S5dB1XVwl/M0t2Rqh9RJZt3uRA4tFv71yw/xcTWP8BSSEDKQd
        l5WuFpQ7WTfT2kemWdLF9WMtKT3hZvKQOcDdaqEsRGC8VnT7foogW7HqppugKfl7mY9Herpule4
        gYP5t2WIMUtpYfMHhj4LBDD3iCm4IbX19hrcR/VrZbCGMXBvF50lLd0wnjA==
X-Received: by 2002:a05:6a00:c91:b0:540:f165:b049 with SMTP id a17-20020a056a000c9100b00540f165b049mr7309733pfv.76.1664519122752;
        Thu, 29 Sep 2022 23:25:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5viB0fw/TcC4CcBv6b+cvcUaw/MgPAfU0zY+JZCa9EzRQJr7cH0UsTUFmK1jF2LRBJSGPpiigqfIpYQpxC8us=
X-Received: by 2002:a05:6a00:c91:b0:540:f165:b049 with SMTP id
 a17-20020a056a000c9100b00540f165b049mr7309716pfv.76.1664519122476; Thu, 29
 Sep 2022 23:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor> <YzXRbBvv+2MGE6Eq@matsya>
 <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
 <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com> <20220930055619.ntgr2yobc5euzz6y@cantor>
In-Reply-To: <20220930055619.ntgr2yobc5euzz6y@cantor>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 30 Sep 2022 14:25:11 +0800
Message-ID: <CAJB-X+X2k_TCvocoiFsPr=ehSMOHZkBkOv_P540q=_jmxXgYTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more incorrectly.
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 1:56 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Fri, Sep 30, 2022 at 12:44:22PM +0800, Koba Ko wrote:
> > On Fri, Sep 30, 2022 at 1:26 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
> > >
> > > On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> > > > On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > > > > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
> > > >
> > > > >
> > > > > Hi Vinod,
> > > > >
> > > > > Any thoughts on this patch? We recently came across this issue as
> > > > > well.
> > > >
> > > > I have only patch 3, where is the rest of the series... ?
> > > >
> > >
> > > I never found anything else when I looked at this earlier.
> > > The one thing I can think of is perhaps Koba was seeing multiple
> > > issues at time when he found this, like:
> > >
> > > https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canonical.com/
> > >
> > > That was also being seen by an engineer here that was looking
> > > at client_count code.
> > >
> > > Koba, was this meant to be part of a series, or by itself?
> > >
> >
> > Jerry, you're right, it's a part of the series.
>
> Hi Koba,
>
> If it is meant to be part of a series, where are patches 1 and 2?
> The ccp patch has already been applied by the crypto maintainers if that
> was meant to be part of a series with this patch.
>
> Regards,
> Jerry

Sorry, I misunderstood. actually, there's a mistake on the [3/3] part.
I created patches for the mainline kernel before sending them to the upstream.
Then I found the first has existed on the patchwork, so removed the
[2/3] part for ccp patch and forgot to modify for this.
Should I fix this and re-submit v2(also add those review-by)?

>
> >
> > >
> > > Regards,
> > > Jerry
> > >
>
