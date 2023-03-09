Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8946B2ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCIUne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCIUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:43:28 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B05E4D8C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 12:43:25 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so3288988ybu.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678394604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bP8wODvsz8UVWLAsOZkZWS96n1xXUQs0dqZ1Fl/VY5E=;
        b=eebPd19VjhvYW6McY9UTUB3k12eACqwf0uEQx/fCw3FKJPLiB0QHTT8t7KwC+v5xMV
         DXMVnviGUILzkwBN31wOzBkyuo8INwC5n+J6msO8gpt2dBsoXlzKALPOSgnEnI2wJgjk
         LSlejdd2PzwBBBywm1gDl/TCZ2NJg9/hskNPzRdBGDhgj47EdMApXEF47yWGVySjXDbd
         9u25ry9W5BciHXNGy/2dP087TDfFUug9jZAj1Kml8ghwcaGi2DrqxNvFZrpITgQWqHI8
         /FMxWCUSCbrCenW5k65d5+6+jzv2ImVWvPYzdBOwOIvMntZygD6eO5h/dLqDnDy8+Ksu
         4IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP8wODvsz8UVWLAsOZkZWS96n1xXUQs0dqZ1Fl/VY5E=;
        b=tVGefjXi06Ma9CLcJcJKUohZpihTMc7kBhIoA1jkToAY6uiyLjoBLI3nPZ9wyHLJKr
         ZYo8N1OPz9mtGZmpqSlNJTT2K0iD7b+WTDtjkSFmCqigzsx96hTYovGR3ogZIpkatATk
         ko5obnW8uGwztyCKUDXF4aw8kGioWE2k1Losig9UJN8vO+3sRkLpTUuX9ut+lfx4qTpA
         TkuXugH4T57KlXXKEqzR9SU/lCqFm9JRpYA+U4YZe7vcpLjZCNtwhUXD8faEeDWVS+Sx
         PMHp456lWCnVdDXQ9eQy754dS2jAewpb5YoKm/sAMHQGiT4E0kEkmAuD3MmDHX3+fEIY
         NRGQ==
X-Gm-Message-State: AO0yUKWwMkAvGn7vPHZw2hLcjAUZKkeM03EOO7P36JVs2yTCWmwbABBg
        oAFg5hQ/5q6vMHSnrvdrO7moF3N/+0rk8petOXGKBA==
X-Google-Smtp-Source: AK7set/2msoQtYxMSGDYRhJyyhkKjL53yW5wd65tEHvzSFdXT3B+24kaYeZOAQgW1qQzd4IwNUDN0yqipb4xqVJJMNI=
X-Received: by 2002:a25:9888:0:b0:a88:ba7:59b with SMTP id l8-20020a259888000000b00a880ba7059bmr14234797ybo.9.1678394604682;
 Thu, 09 Mar 2023 12:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com> <20230308221657.GA3935330-robh@kernel.org>
 <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com> <c92a44fe-7057-2d81-41fc-2e84ae60f881@linaro.org>
 <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com> <57b436d2-79f9-a7c1-ab97-0b555beb6468@linaro.org>
 <e20e489b-c033-7a38-9750-24b9abb22a0c@gmail.com>
In-Reply-To: <e20e489b-c033-7a38-9750-24b9abb22a0c@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Mar 2023 22:43:13 +0200
Message-ID: <CAA8EJpr_xqTUE-MmQOC51uqC=_i=SO6qSX1rQEN_tk4LJBh91g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM interface
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 22:34, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 3/9/23 09:19, Dmitry Baryshkov wrote:
> > On 09/03/2023 04:27, Maximilian Luz wrote:
> >> On 3/9/23 02:33, Dmitry Baryshkov wrote:
> >>> On 09/03/2023 00:44, Maximilian Luz wrote:
> >>>> On 3/8/23 23:16, Rob Herring wrote:
> >>>>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
> >>>>>> Add bindings for the Qualcomm Secure Execution Environment interface
> >>>>>> (QSEECOM).
> >>>>>
> >>>>> Pretty sure I already asked, but no answer in the commit message. Why do
> >>>>> we need this? You've already declared the platform supports SCM calls
> >>>>> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
> >>>>> is for non-discoverable h/w we are stuck with.
> >>>>
> >>>> Yes, you've asked this before but I can only repeat what I've written in
> >>>> my last response to your question: I am not aware of any way to properly
> >>>> discover the interface at runtime from software.
> >>>>
> >>>> If it makes you happy, I can put this in the commit message as well...
> >>>>
> >>>>> Why is software made non-discoverable too?
> >>>>
> >>>> Please direct that question at the Qualcomm guys who actually designed
> >>>> that interface. I can't give you an answer to that, and I'm not all that
> >>>> happy about this either.
> >>>>
> >>>> To reiterate: I've reverse engineered this based on the Windows driver.
> >>>> The Windows driver loads on an ACPI HID and it doesn't use any function
> >>>> to check/verify whether the interface is actually present. Adding a DT
> >>>> entry is the straight-forward adaption to having a HID in ACPI.
> >>>>
> >>>>> Nodes with only a compatible string are usually just an abuse of DT to
> >>>>> instantiate some driver.
> >>>>
> >>>> If you or anyone here has any idea on how to discover the presence of
> >>>> this, please feel free to let me know and I'd be happy to implement
> >>>> that. Until then, I unfortunately don't see any other way of dealing
> >>>> with this.
> >>>
> >>> You can probably try requesting QSEECOM version. According to msm-3.18:
> >>>
> >>>          uint32_t feature = 10;
> >>>
> >>>          rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
> >>>                  &resp, sizeof(resp));
> >>>          pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
> >>>          if (rc) {
> >>>                  pr_err("Failed to get QSEE version info %d\n", rc);
> >>>                  goto exit_del_cdev;
> >>>          }
> >>>
> >>
> >> Thanks! I'll give that a try.
> >>
> >> As I can't test this on a device that doesn't have qseecom, it would
> >> probably be a good idea if someone could test this on a device that has
> >> qcom_scm but no qseecom (if those even exist) to make sure this doesn't
> >> misbehave.
> >
> > I could not find a vendor dts which doesn't have the qseecom device (checked the source trees from 3.4 to the latest revisions).
> >
>
> Thanks for checking!
>
> So that only leaves one potential issue: The re-entrant/blocking calls
> not being handled at the moment. If we detect qseecom based on the
> version and then try to query the app ID, we could get some devices that
> use those.
>
> I'm not sure what the consequences there are, i.e. if we're potentially
> blocking something else if one of those calls blocks on such devices. Is
> there any way we can detect this beforehand?

Unfortunately I don't know.

>
> The current proposal isn't very good at handling that either as it
> assumes that this depends on the SoC generation (which it probably
> doesn't). So I guess one possibility is to make the list of app-names to
> be checked SoC specific as well. That at least limits the scope
> somewhat. Maybe you have some other ideas?

As long as it doesn't concern the external interfaces, it sounds fine
with me. Let's get the first implementation in, then we can expand and
extend the details/implementation.


-- 
With best wishes
Dmitry
