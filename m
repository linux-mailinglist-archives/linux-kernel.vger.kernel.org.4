Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB36771D1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjAVTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjAVTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:23:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AEAEB76;
        Sun, 22 Jan 2023 11:23:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso7721163wmn.5;
        Sun, 22 Jan 2023 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZgTOtPGSgMuzF9eyGe3uxsgqZaDBr73xoLKIKQ8qoI=;
        b=liGewbzhxNIGOH9gaCRbraWIDKYPXaa2hrJABewuTnToA4H3wA274NDzoza54G8OkN
         5YbPzCgXypzAOhGWXQ7Hx/TXgx98rUVFzk8iqyK5b98asK0/fWMBfGtLrrGHzWJ4vOvO
         XGSpvZVqcOBHjL9ElNVHKKH0UbDJqncQ79IMGbXNkd30twBh2Rx4U0RxnqLmUhkKRwt9
         axNIhDXLnB7iL39uvKQrIML+JZOJsC7aUE2uep8BFbnE0RMZoHkhkxU53ClA2/VQYXrP
         XdWXA3BUslp3EANFIu9SY5ez3j+pBBxCfSUBc22U+LFssA3QmKDh/IznnVLDWU5aWAQP
         AOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZgTOtPGSgMuzF9eyGe3uxsgqZaDBr73xoLKIKQ8qoI=;
        b=AYDVZD9LFf77yVDsfEkebLa1yNhGNhAV9IlOfjb+AkraTde7CKqwEScfRMReZjG+LD
         /Mn4u19B1sMoU6lLXomAyl6yEFdALyj/ZwXMEYSOC1Z0ZbNy3vVna7w4RXiNNC5ANBIb
         GD1YulYYVfMk9ar6kZv0xrpkAujmAOyAUeu0oC9iqEyPkVTqA7T4/LAOb0b3MdE20bN9
         l2TF8M7Qthqp+PCTUeg9vNFVHx6Us2Jtym3TJA7BVuanWMsQEclayX1HzfzreYzYScWe
         r0AZieMyuhOX/3/AjNdy4eqWhC0JwRVbS1vCkJ3TD0W/O/FjLEeWwEjy7P30Ky4MULIM
         hbAg==
X-Gm-Message-State: AFqh2kqPRCdJWai7vlHhLkkKBnQ1ww8994ftXru7+tTg2M2ovs4/CKpz
        1/yHh392xz6z6iDFtx4aQghDoUauKqg=
X-Google-Smtp-Source: AMrXdXtHvhbVur0MasjroXyjBuzK+NXpk6IFLI1QuE5dN3LM74XAv/dXjl5LRZ0myNF9fevLI23wcg==
X-Received: by 2002:a05:600c:1712:b0:3d9:a145:91a with SMTP id c18-20020a05600c171200b003d9a145091amr21406767wmn.28.1674415384960;
        Sun, 22 Jan 2023 11:23:04 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c188f00b003db122d5ac2sm8327493wmp.15.2023.01.22.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 11:23:04 -0800 (PST)
Message-ID: <63cd8d18.050a0220.85c72.4142@mx.google.com>
X-Google-Original-Message-ID: <Y82MXvxczUljsmWM@Ansuel-xps.>
Date:   Sun, 22 Jan 2023 20:19:58 +0100
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
 <63cd7cda.050a0220.53454.5a1b@mx.google.com>
 <CAA8EJppFKDXJtt5zyM4mhEJ=BQwHUCVJcJKeH2GjkzAvwbfCBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppFKDXJtt5zyM4mhEJ=BQwHUCVJcJKeH2GjkzAvwbfCBw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 09:15:53PM +0200, Dmitry Baryshkov wrote:
> On Sun, 22 Jan 2023 at 20:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Sun, Jan 22, 2023 at 07:59:42PM +0200, Dmitry Baryshkov wrote:
> > > On Sun, 22 Jan 2023 at 19:46, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > Enlarge opp-supported-hw maximum value. In recent SoC we started
> > > > matching more bit and we currently match mask of 112. The old maximum of
> > > > 7 was good for old SoC that didn't had complex id, but now this is
> > > > limiting and we need to enlarge it to support more variants.
> > > >
> > > > Document all the various mask that can be used and limit them to only
> > > > reasonable values instead of using a generic maximum limit.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 20 +++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > > > index b4947b326773..908cb0d7695a 100644
> > > > --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > > > +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > > > @@ -50,12 +50,28 @@ patternProperties:
> > > >        opp-supported-hw:
> > > >          description: |
> > > >            A single 32 bit bitmap value, representing compatible HW.
> > > > -          Bitmap:
> > > > +          Bitmap for MSM8996 format:
> > > >            0:  MSM8996, speedbin 0
> > > >            1:  MSM8996, speedbin 1
> > > >            2:  MSM8996, speedbin 2
> > > >            3-31:  unused
> > > > -        maximum: 0x7
> > > > +
> > > > +          Bitmap for MSM8996 later revision format:
> > > > +          0:  MSM8996, speedbin 0
> > > > +          1:  MSM8996, speedbin 1
> > > > +          2:  MSM8996, speedbin 2
> > > > +          3:  always set
> > >
> > > This is used for speedbin 3
> > >
> >
> > Is it right that 4 bit speedbin is only introduced later? Cause looking
> > at the current opp-supported-hw for MSM8996SG and MSM8996 originally
> > (and based on what this Documentation say) there were only 3 bit and
> > then they started using a 4th bit. Just asking if it's ok to keep the
> > bitmap split or i should just merge it.
> 
> I don't think I got the question, please excuse me. Historically
> msm8996.dtsi used 0xff as 'all possible platforms' value for the GPU
> tables. Lately I fixed the CPU tables, added support for speed-bin 3.
> However I left these 0xff in GPU opp table intact. I don't remember if
> there was any reason behind that. Anyway this bit isn't always set, it
> is set only for the entries which should be selected for MSM8996 speed
> bin 3.
>

Question is: Should I merge the 2 format to something like?

          A single 32 bit bitmap value, representing compatible HW.
          Bitmap for MSM8996 format:
          0:  MSM8996, speedbin 0
          1:  MSM8996, speedbin 1
          2:  MSM8996, speedbin 2
          3:  MSM8996, speedbin 3
          4-31:  unused

          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
          0-3:  unused
          4:  MSM8996SG, speedbin 0
          5:  MSM8996SG, speedbin 1
          6:  MSM8996SG, speedbin 2
          7-31:  unused

Or just replace the 'Always set' to speedbin 3?

(by the looks of it seems they started blowing speedbin 3 only in later
revision and initialy there were only 3 speedbin bit)

> >
> > > > +          4-31:  unused
> > > > +
> > > > +          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
> > > > +          0-3:  unused
> > > > +          4:  MSM8996SG, speedbin 0
> > > > +          5:  MSM8996SG, speedbin 1
> > > > +          6:  MSM8996SG, speedbin 2
> > > > +          7-31:  unused
> > > > +        enum: [0x1, 0x2, 0x3, 0x4, 0x7,
> > > > +               0x9, 0xd, 0xe, 0xf,
> > > > +               0x10, 0x20, 0x30, 0x70]
> > > >
> > > >        clock-latency-ns: true
> > > >
> > > > --
> > > > 2.38.1
> > > >
> >
> > --
> >         Ansuel
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
