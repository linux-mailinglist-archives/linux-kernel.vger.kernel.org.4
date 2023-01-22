Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779E6676DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjAVOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAVOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:35:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4361A487;
        Sun, 22 Jan 2023 06:35:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b7so8663253wrt.3;
        Sun, 22 Jan 2023 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yrVZNgRV6FceaMBoO7b1bSNI7OZRej+dPjOag/ZFF98=;
        b=ggJNpzEbwqFoTTGTS56yie1K6sXXzCVKs+Hbecvxe/tzyGWFIW8de+/p+RQVy8m9sl
         0DLUvTVpYGot6Gjpja9HGRMWm/Mz19S5V4+kQFGwCMkmrJZGQUk/D5AmfJpj5NixsHHl
         EL5E52YEBshcbKilgPS7lv9bRdMKGTnrGd1L7gyc4o56uoBFjeaxmRN5B6XeddGn5lyM
         wCHEk3RSDC5pdXpFcHYWgjDFhPxFZmvyr0iuAJc8yN3KDEkIiz5knIFn3CSIqUSI9tMG
         t3rEFodI7dJ1RAk90FaTZR8bl8aY8QRgyRBs0gTWbyR3hfM6jwjY8QKW3BldzmvVSGSd
         W4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrVZNgRV6FceaMBoO7b1bSNI7OZRej+dPjOag/ZFF98=;
        b=Gx/PBM5w+xq4/qoO3XFK9HWzM/s87iojZQT/RIN3lRSElBS8h0CBtRWVFuKhbwOz5L
         I4tUfBUtHjyGO60tOQyD9nhl9kQ/K6C0oItpMa53JDRc6u7O9FjskVPQNEQhnjlfDauB
         o6bDouoWEAX7ITmnS6IfB/QP7BmQQafmeb6esTU/Mu0BgSt+Xd0Qke9t9YIBjj0EmYMs
         yStsEtWqc99pttpGSvxqtjddwmjqNbv9BH5HU3O+RP6pHpMk3Wu+w6CXT82HblvKI1NH
         DKxUj73EXByE7FUclEi0selnwbK7fvnVp1sJvfkubQser7XcF5smQBec7UvjrfZazqtz
         U8fw==
X-Gm-Message-State: AFqh2koU1ur6Rpt1cbwWdeGeJghw4Pb/AV2112nuEXtaMaYJoPFmIpV+
        NdCDZUBUVAddhRZug636Phs=
X-Google-Smtp-Source: AMrXdXugCAQB5A1GcSxE6l3N14LJg6WCrpJHJ2DpbyIBTuNUm+B9/qigiR4NQLs1zxAqCpKaAzJVyQ==
X-Received: by 2002:a05:6000:11c6:b0:2bd:bf72:76f2 with SMTP id i6-20020a05600011c600b002bdbf7276f2mr16813899wrx.14.1674398150854;
        Sun, 22 Jan 2023 06:35:50 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d526e000000b0028e55b44a99sm22612060wrc.17.2023.01.22.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 06:35:50 -0800 (PST)
Message-ID: <63cd49c6.5d0a0220.d6391.519b@mx.google.com>
X-Google-Original-Message-ID: <Y81JxNxaMPjV6l1U@Ansuel-xps.>
Date:   Sun, 22 Jan 2023 15:35:48 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: opp: opp-v2-kryo-cpu: add opp-microvolt
 nvmem based
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <20230121000146.7809-2-ansuelsmth@gmail.com>
 <4b58dcf1-df8a-048f-ba6f-ea170479751b@linaro.org>
 <63cd44e6.050a0220.ed90.635a@mx.google.com>
 <c5888e27-18e7-24da-f177-4651fc875269@linaro.org>
 <63cd4674.5d0a0220.57633.fef5@mx.google.com>
 <8ba708ad-5635-e840-f21c-ad3ab105fb5f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba708ad-5635-e840-f21c-ad3ab105fb5f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 03:31:14PM +0100, Krzysztof Kozlowski wrote:
> On 22/01/2023 15:21, Christian Marangi wrote:
> > On Sun, Jan 22, 2023 at 03:17:54PM +0100, Krzysztof Kozlowski wrote:
> >> On 22/01/2023 15:15, Christian Marangi wrote:
> >>> On Sun, Jan 22, 2023 at 03:00:22PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 21/01/2023 01:01, Christian Marangi wrote:
> >>>>> The operating-points-v2-kryo-cpu driver supports defining multiple
> >>>>> opp-microvolt based on the blown efuses in the soc. It consist of 3
> >>>>> values that are parsed: speedbin, psv and version. They are all
> >>>>> appended to the opp-microvolt name and selected by the nvmem driver and
> >>>>> loaded dynamically at runtime.
> >>>>>
> >>>>> Example:
> >>>>>
> >>>>> opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
> >>>>> opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
> >>>>> opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
> >>>>> opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
> >>>>>
> >>>>> Add support for this and reject these special binding if we don't have a
> >>>>> nvmem-cell to read data from.
> >>>>>
> >>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>>> ---
> >>>>>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 16 ++++++++++++++++
> >>>>>  1 file changed, 16 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> >>>>> index b4947b326773..cea932339faf 100644
> >>>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> >>>>> @@ -61,6 +61,17 @@ patternProperties:
> >>>>>  
> >>>>>        required-opps: true
> >>>>>  
> >>>>> +    patternProperties:
> >>>>> +      '^opp-microvolt-speed[0-9]-pvs[0-9]-v[0-9]$':
> >>>>
> >>>> This does not end with correct unit suffix. Should be
> >>>> opp-speed-.....-microvolt
> >>>>
> >>>
> >>> I think I didn't understand this?
> >>>
> >>> From opp-v2-base and from what we are using downstream, the named
> >>> opp-micrvolt works correctly.
> >>>
> >>> (speed[0-9]-pvs[0-9]-v[0-9] is the entire name of the named
> >>> opp-microvolt- binding)
> >>>
> >>> This is the reference I always used for the pattern. [1]
> >>> Here the pattern used by the driver. [2]
> >>>
> >>> [1] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/opp/opp-v2-base.yaml#L209
> >>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/qcom-cpufreq-nvmem.c#L238
> >>
> >> Are you documenting existing property or adding new? Commit msg suggests
> >> you add new property, so what do you reference here? How is it related?
> >>
> > 
> > It should have been added from the start when the schema was submitted
> > but I get what you mean with the other question.
> > 
> >>>
> >>>>> +        description: |
> >>>>> +          Assign a microvolt value to the opp hz based on the efuses value from
> >>>>> +          speedbin, pvs and vers
> >>>>
> >>>> Where is the DTS change?
> >>>
> >>> You mean an additional example that use this additional binding? This
> >>> may be difficult to add since the current example in this schema is a
> >>> root one and I can't put multiple root example.
> >>
> >> No, I mean, you DTS using it. We do not want empty (unused) bindings...
> >>
> > 
> > Ok, will drop this and make it part of the ipq8064 opp series that will use
> > this binding.
> 
> You can also link the DTS changes, it's also fine.
> 

There are some required changes to do on the driver so the opp series
still have to be submitted so I guess dropping this is the only way
currently. But it's not a problem the real important patch in the series
is the first one.

-- 
	Ansuel
