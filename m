Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4455EAFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIZScO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIZScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:32:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4772AE3A;
        Mon, 26 Sep 2022 11:32:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 30so10240154edw.5;
        Mon, 26 Sep 2022 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sX1lVvtuTDbzf0KBtVl22MP9Nea4UojNFqdTpI0Yf7A=;
        b=QCuiDdZDG1I/RpEo7J0H77rWVtHCDFnHUPEWb1/GE0hbKPXfdM/Bgmx3fg1m+D/wiH
         kNEyoarPneSGOyi8uK5LyEPXSzhxpROMYzWwL0P/vmxWGkCl8pDY9OUMjxO9NsUihq2y
         XjV2Fe5b8TdzQVUeQ2gdbSKyRZMsdhuBvkceWW74D3Zox/ooPZfWd4o8h9zj/+XUr9f0
         Vi8sX75OASWGKUFjfb4XeFUUN0O0FdQSMCYducnFOUE4A22OaqrR/bris4OcxhG76q8w
         Dqr0jgD24zF9h/GLjtbbH+Hj+0wxlMKj8TlCPCFsbrqu2MQ5KtKfT+CWqgERaJV2KFJp
         SimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sX1lVvtuTDbzf0KBtVl22MP9Nea4UojNFqdTpI0Yf7A=;
        b=fdr6qwBDSUmbQbJnYx3XWz4pi6xo6LlFdN0NTVIAyDrezCglEuNkPlUrxK6JNtVs5m
         RaZBkev0QjmrCdwbZZJhZPiKSAEVXpqM2wk/ZBQxOcOdlWWjQXg3g9Swoy13gukXvTQ0
         oB6i7AghpXmKZHRijnkkoj9N6a7aQ0qTofGFRJZGzVj/DQIGBtaThADkH6S3l65OgmMC
         s43lYCqotLwcO+xgNmdYF2cpOmy1IcidFxL/ZyTmHSBD047cqdRDR6l5gYzKpPxsX5+l
         faAwP0nKgfwuVzCCMSTLMR3E4NdGSq0f3MBC7d8fCiLQ9XpDnHUusK9YcEqi0Fjvfsxb
         2s9Q==
X-Gm-Message-State: ACrzQf2jxOuPZoNa7i7t/9ewi0QChT+o95MAZVK3NCcx/6i4sbgrJr9Z
        W2hstHNaRcUTPV1zd/aT7QWa2qY9hI0mtLlv3kI=
X-Google-Smtp-Source: AMsMyM63uEt1/wfHOiCUiYaOU5BS+ySvff5C66dgcPeg0tFAhT9teb73ogxvvMcSUeMtUojW3yaZ0GcHNDZCm/1d6uo=
X-Received: by 2002:a05:6402:3786:b0:451:24da:f8c9 with SMTP id
 et6-20020a056402378600b0045124daf8c9mr24017924edb.250.1664217130041; Mon, 26
 Sep 2022 11:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com> <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com> <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com> <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
 <CAHQ1cqGrfTO9JLgD-k0Akg7+hXNT+WevfjH_YpsVi8wQt6_iBw@mail.gmail.com> <YzF8l7kiS7m496YE@smile.fi.intel.com>
In-Reply-To: <YzF8l7kiS7m496YE@smile.fi.intel.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Sep 2022 11:31:58 -0700
Message-ID: <CAHQ1cqEVXwMiUxp+QGRkHMea-74DxS1Obvc2xwhy=ySwfxhu7w@mail.gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 3:19 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Sep 25, 2022 at 10:43:07PM -0700, Andrey Smirnov wrote:
> > On Sun, Sep 25, 2022 at 12:21 PM Ferry Toth <fntoth@gmail.com> wrote:
>
> ...
>
> > I think we'd want to figure out why the ordering is important if we
> > want to justify the above fix.
>
> At least we all on the same page (I hope) on justification for reverts.

Yes, there's clearly a regression here (multiple ones, really).

>
> ...
>
> > IMHO instead of trying to rush something in it be prudent to revert my
> > patch _and_ address the fact that above patch was lost during the
> > merge (Andy's revert needs to be updated)
>
> I'm not an expert in your fixes for DWC3, so please come up with
> the solution sooner than later, otherwise I will try to get my
> reverts into the final release, because they obviously fix the
> regression.

You don't need to be an expert here. All that's required is that your
revert get the code to look like it looks in

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507

so the last hunk in your patch instead of looking like:

@@ -538,6 +584,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
 {
        int ret, irq;

+       dwc->edev = dwc3_get_extcon(dwc);
+       if (IS_ERR(dwc->edev))
+               return PTR_ERR(dwc->edev);
+
        if (ROLE_SWITCH &&
            device_property_read_bool(dwc->dev, "usb-role-switch"))
                return dwc3_setup_role_switch(dwc);

should look like

@@ -538,6 +584,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
 {
        int ret, irq;

        if (ROLE_SWITCH &&
            device_property_read_bool(dwc->dev, "usb-role-switch"))
                return dwc3_setup_role_switch(dwc);

+       dwc->edev = dwc3_get_extcon(dwc);
+       if (IS_ERR(dwc->edev))
+               return PTR_ERR(dwc->edev);
+

Can you update your series accordingly or do you need me to do that? I
won't have the cycles until the end of the week (Sat).


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
