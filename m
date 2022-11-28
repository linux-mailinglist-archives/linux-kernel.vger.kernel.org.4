Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFB63AFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiK1Rqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiK1RqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:46:09 -0500
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2092CE3C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:41:26 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id m15so5376696ilq.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbRKAUrPmnBiS6hCHyMw1jh/sJ1aupJyGNs4+wDuBfw=;
        b=ixRtgOMlvI1g4AJnq++RxY8xvVrR15KvgcBuLDrKqmiman4zwM1wFpFtU/7uZjNY88
         K3yXufxR1dpD2CkRFAkb1Welnb+TYMKUsBPPPX9QquFrhAtK3n7Nfn+dIVFLOUYAmNQE
         N5TfTUAY98yp0zh3cuZV4xko67KH26G2BVDskOiwakFRihp7j1WyToeebGchYvvXJoPf
         oZnL6Oby+sHNOUp+oPDZ2gXfXwLPUsL1KmvQHKQLq7HqBWNWZe0XAyWheBJOagv3DyzD
         O53HccT2iOrm21M9T1CHefkT6BeJIa7Xn5Wdls3YMeaI3xIZ14p2PznrhGlD2vZ/6ElU
         4YOw==
X-Gm-Message-State: ANoB5pntzW4dyWaC3K76e2F9HrDv4yX+iJlSXSxZ1kN3u8s53LAONycM
        CHk+2KLaqPsFRcS0xywD4b+oPA==
X-Google-Smtp-Source: AA0mqf506mtbJING1FaQH+qUD+TgZxe8QY5+GImTnpr+oiFjfC0dS6xS3ra4FGl0uBRaZC6gip956g==
X-Received: by 2002:a05:6e02:def:b0:300:c33d:c8a8 with SMTP id m15-20020a056e020def00b00300c33dc8a8mr16478349ilj.166.1669657278190;
        Mon, 28 Nov 2022 09:41:18 -0800 (PST)
Received: from google.com (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with ESMTPSA id r5-20020a92c505000000b00300e6efca96sm4038626ilg.55.2022.11.28.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:41:17 -0800 (PST)
Date:   Mon, 28 Nov 2022 17:41:14 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        =?utf-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Gavin.Lee@ecs.com.tw,
        Darren.Chen@ecs.com.tw, Abner.Yen@ecs.com.tw, Vicy.Lee@ecs.com.tw,
        Jason.Huang@ecs.com.tw
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add zombie
Message-ID: <Y4TyuqPQtZBFChKD@google.com>
References: <20221124115712.v4.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <CAPao8GK93KMrtaXw7mNWOCE60zk=uCENLfBXhNRVxJXEnnaGFg@mail.gmail.com>
 <f58866c8-0164-2e59-4ff3-f9a4f9334e49@linaro.org>
 <CAPao8GKbdK79Z7w91x0T6JW9v6VFoeYSaXGGAuzB_=ukR9g0_w@mail.gmail.com>
 <b54cd0a4-7ee8-e8c0-ceda-18b29588d535@linaro.org>
 <CAD=FV=X9C8nLDrEpZE2tLtq6Brn9cd-15+1JWFOL4cPYdJs5Dg@mail.gmail.com>
 <f92ce2ed-80b5-eb26-36a4-2384a7a8510f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f92ce2ed-80b5-eb26-36a4-2384a7a8510f@linaro.org>
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:22:39PM +0100, Krzysztof Kozlowski wrote:
> On 28/11/2022 16:56, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Nov 24, 2022 at 3:27 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/11/2022 12:20, 楊宗翰 wrote:
> >>> Hi Krzysztof, Matthias,
> >>>
> >>> How to use "get_maintainers.pl"?
> >>>
> >>> I find this script in path "<MyCodebase>/kernel/v5.15/script", and output
> >>
> >> This looks like v5.15 kernel which is heavily outdated. Please never
> >> work on such kernels when interacting with upstream. The rule is you
> >> work on either last mainline kernel (v6.1-rc6), maintainers for-next
> >> branch (you should know who is the maintainer of subsystem you submit
> >> to, get_maintainers.pl gives this information) or on moderately recent
> >> linux-next. For bigger patchsets there might be exceptions for these
> >> rules, but it's not the case here.
> > 
> > Just to add context here, it's a fairly standard workflow for ChromeOS
> > kernel engineers to work in a "versioned" kernel directory but still
> > checkout and work with the upstream kernel. I'm sure it's confusing to
> > anyone not used to working with the ChromeOS source tree and build
> > system. Sorry! :( So the fact that Owen is in a directory called
> > "v5.15" doesn't mean that he's actually working with the v5.15 kernel.
> > The fact that Bjorn's address is correct in his CC list implies to me
> > that he's actually got a proper upstream kernel.
> > 
> > I had previously [0] instructed Owen to send against Bjorn's tree, so
> > hopefully it's correct.
> 
> If it was on Bjorn's tree, get_maintainers.pl would not produce such result:
> 
> ---
> Series-to: LKML <linux-kernel@vger.kernel.org>
> Series-cc: Douglas Anderson <dianders@chromium.org>
> Series-cc: Bob Moragues <moragues@chromium.org>
> Series-cc: Harvey <hunge@google.com>
> Series-cc: Stephen Boyd <swboyd@chromium.org>
> Series-cc: Matthias Kaehlcke <mka@chromium.org>
> Series-cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

These look like manual entries for patman

> or this:
> 
> ---
> owen@buildsvr-HP-ProDesk-600-G4-MT:~/chromebook_zombie_os/src/third_party/kernel/v5.15$
> perl scripts/get_maintainer.pl -f MAINTAINERS --email
> linux-kernel@vger.kernel.org (open list)
> ---
> 
> as Owen indicated earlier. They are either incomplete or not correct.
> 
> Of course I don't know whether the base tree is the problem or usage of
> get_maintainers.pl...

That looks like an operator error, the above command produces the same result with
an upstream tree.

Issue one is the use of '-f' which seems to expect a file with a list of e-mail
addresses, which MAINTAINERS is not. The second issue is that no patch file or
directory is specified.
