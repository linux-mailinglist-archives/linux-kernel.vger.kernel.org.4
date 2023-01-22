Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF4677161
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjAVSNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjAVSNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:13:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FA10250;
        Sun, 22 Jan 2023 10:13:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so9143738wma.1;
        Sun, 22 Jan 2023 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JNsij2VFxSG0TAAcykHV5+wT2P/0sSyKQHCTmwixahU=;
        b=KLxbbBkfH3FNlyp6Sp6ctNB3AeTuOpIn75rV7PiL4VuW17VDm/Eg8MwEZ63uGrcyjL
         9JarMhWrwudo/pjj4+a109yRaqeGZcNQ+D2070N5Z63FP6EP52RNaP0ZHOwcq9hXLlSa
         wkP5CIu9pPIV+DrPvAuJ7sDhhhF1zikFDznm6ZqKc6RUG9a0DoiS7bAPj17TY7Gku6q3
         b4ZPqjpyQPqexTM1YGXldvjtIYR3TfXkvCUqbxVgPWABMbWGkLWYsoGaRIqufKNXW9cu
         WcQLxRzgyhnV/ANWT6KCjFKCcUwdCJDlxwwFe0R+lBcX136srAxBwq8lxaKfZ+iMRmPp
         6thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNsij2VFxSG0TAAcykHV5+wT2P/0sSyKQHCTmwixahU=;
        b=0bT2JG/szAJ9lzBWPrYDNmobnWjD8Dqnttku56O+9LnGXtTiWOmCDyp7gFCZJjrIcF
         JvVEv/C5Eqw9HSIxTGTrTJ1sCoLNtVs1zAVXYTLGI8ipJlAuE3ovdlpHeNdshyLVPLs2
         WIArj6q774LRdfd7jcR/BGzVkR9R/ObBndVTk+XwNGulPNok8kCHecVwENViDsrNonIF
         1FSp7wxSBsdIU87e11syZEN6FC6tu0wK34dJhbFB9xxH5cKzb+3YynylsVLRivQO26aS
         tSyYts5MZwXkzaqLU+IxhWl/KoZEP2akyOEa2T1pRV4/Y3Ium9wCGwhN5SUHAcMNCYt8
         cjuw==
X-Gm-Message-State: AFqh2koQxOOxeCgv1z3qpdX7A5USCL9/k2GdVa8OlAvt21AIAoefI0WS
        ETu/HUgbcXzuNcGSeF2cFvQ=
X-Google-Smtp-Source: AMrXdXs+BHGEe/KJgAenjDov479KXfVzdxlgth4FplSj/xMGlr5KAwhCD9Qkiri7p3UcDcnS0WxF/Q==
X-Received: by 2002:a05:600c:1712:b0:3d9:a145:91a with SMTP id c18-20020a05600c171200b003d9a145091amr21254406wmn.28.1674411226422;
        Sun, 22 Jan 2023 10:13:46 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b003a3442f1229sm9056261wmo.29.2023.01.22.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 10:13:46 -0800 (PST)
Message-ID: <63cd7cda.050a0220.53454.5a1b@mx.google.com>
X-Google-Original-Message-ID: <Y816xWC29nG4bwAH@Ansuel-xps.>
Date:   Sun, 22 Jan 2023 19:04:53 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge
 opp-supported-hw maximum
References: <20230122174548.13758-1-ansuelsmth@gmail.com>
 <20230122174548.13758-2-ansuelsmth@gmail.com>
 <CAA8EJpp1c=sC0d_G1eSuOzJbjusW86zHezfwY3JRH=EBp7tNmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp1c=sC0d_G1eSuOzJbjusW86zHezfwY3JRH=EBp7tNmA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 07:59:42PM +0200, Dmitry Baryshkov wrote:
> On Sun, 22 Jan 2023 at 19:46, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Enlarge opp-supported-hw maximum value. In recent SoC we started
> > matching more bit and we currently match mask of 112. The old maximum of
> > 7 was good for old SoC that didn't had complex id, but now this is
> > limiting and we need to enlarge it to support more variants.
> >
> > Document all the various mask that can be used and limit them to only
> > reasonable values instead of using a generic maximum limit.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 20 +++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > index b4947b326773..908cb0d7695a 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > @@ -50,12 +50,28 @@ patternProperties:
> >        opp-supported-hw:
> >          description: |
> >            A single 32 bit bitmap value, representing compatible HW.
> > -          Bitmap:
> > +          Bitmap for MSM8996 format:
> >            0:  MSM8996, speedbin 0
> >            1:  MSM8996, speedbin 1
> >            2:  MSM8996, speedbin 2
> >            3-31:  unused
> > -        maximum: 0x7
> > +
> > +          Bitmap for MSM8996 later revision format:
> > +          0:  MSM8996, speedbin 0
> > +          1:  MSM8996, speedbin 1
> > +          2:  MSM8996, speedbin 2
> > +          3:  always set
> 
> This is used for speedbin 3
>

Is it right that 4 bit speedbin is only introduced later? Cause looking
at the current opp-supported-hw for MSM8996SG and MSM8996 originally
(and based on what this Documentation say) there were only 3 bit and
then they started using a 4th bit. Just asking if it's ok to keep the
bitmap split or i should just merge it.

> > +          4-31:  unused
> > +
> > +          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
> > +          0-3:  unused
> > +          4:  MSM8996SG, speedbin 0
> > +          5:  MSM8996SG, speedbin 1
> > +          6:  MSM8996SG, speedbin 2
> > +          7-31:  unused
> > +        enum: [0x1, 0x2, 0x3, 0x4, 0x7,
> > +               0x9, 0xd, 0xe, 0xf,
> > +               0x10, 0x20, 0x30, 0x70]
> >
> >        clock-latency-ns: true
> >
> > --
> > 2.38.1
> >

-- 
	Ansuel
