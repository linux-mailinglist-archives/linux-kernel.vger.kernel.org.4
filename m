Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578AE6814F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjA3PZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjA3PZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:25:24 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC53347D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:25:22 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id u199so5379747vkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWq5l4TyEr8IR7mmSeMUsAGTq3ylCBFM2oZg8br9OhA=;
        b=UFHiCIIsGs8Y1dofmWtBxUWLG9G4bGklIGTNgM/q7Z0JbVPv0kvnHwyO6hYOLt+V/5
         NNeLsyzgMcXEnX3A2BZMPNgzBv2Ct3akhx3iK80twtV4vxpZkgrrxGco7BKNjn4E5HAs
         eoNRsBW//jq2ghehiAQFnBcocgkqtrxo2DNJC6jBUUxT3ta8Aj0VPqXDpsvmgBx3Zn4G
         9q4GkeLTN7MFnlq2BDuMHm39RGfBY9U3+BLguEJqe31hKRIe1XVV1DOeSQ7HEPivmwqh
         rU7txLTnCU7vJspKbJdxTj4xG2G3dxj6WpMUO1lWiguQrt0rhE4u1dxJDiSELOHlHhGL
         /gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWq5l4TyEr8IR7mmSeMUsAGTq3ylCBFM2oZg8br9OhA=;
        b=tMfo8neMu6vXsF263zNyFihyp3eigqlT4TJHT8JnPcTE52si2yz6buVeagxIla310K
         AozpxVd9Y603EbMzVgTGI3VduIG7HEQQJbopmRtxTlWmnX7sunLNj+qSEomNQ5puqtxL
         QVWcdopRyYZBYQxzzY0z3Q3OtRIftX8Ciq9by7cOSSZfRCfLwWLRv0wnIKfIiGZ4nK00
         6/hLOJYeXFQVSFMS3BgP1C+lQnngbKbYrOkkulj6RgkjHjhgbIMDjT4Hd2V+hiHHqKWU
         WJ0Jq9AOVMSa8ZgGAEIBNkKVqDulj5enp+y4LadZsL7sHEPKSZRnZPaKpydyXKUxKwyk
         +z/w==
X-Gm-Message-State: AFqh2koN6XzC82NqgW4I0MGL8rRxunnvHRMmCRFqHdA264LRzst+GWzM
        sP50jaPV+o4wuCLP+Oet1ai0/JgrDgRb/A1MxaUjQA==
X-Google-Smtp-Source: AMrXdXv4PC6wQP9hoqOOsDo+zisJ9tSxzJa5oPFAdqYJ10Hx4wmMt1IlFQHk7m3XYCJCfuFLsJkFOQKqeiiD5cbbZpk=
X-Received: by 2002:a1f:1b8f:0:b0:3d8:d753:56bb with SMTP id
 b137-20020a1f1b8f000000b003d8d75356bbmr6392583vkb.39.1675092321847; Mon, 30
 Jan 2023 07:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
 <20230126-b4-ltc2945_shunt_resistor-v4-1-bb913470d8da@criticallink.com>
 <20230129201604.GA1583293@roeck-us.net> <CADL8D3ZkGT51FX5UrCQ8afzFxPNGHbi09EdXqE+cQyGRnHR2mw@mail.gmail.com>
In-Reply-To: <CADL8D3ZkGT51FX5UrCQ8afzFxPNGHbi09EdXqE+cQyGRnHR2mw@mail.gmail.com>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Mon, 30 Jan 2023 10:25:10 -0500
Message-ID: <CADL8D3b0QznFarombRPuAH_iR+PJYqK2c-Rp4TDeD7WtvwWgPg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: hwmon: adi,ltc2945: Add binding
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Mon, Jan 30, 2023 at 10:19 AM Jon Cormier <jcormier@criticallink.com> wrote:
>
> On Sun, Jan 29, 2023 at 3:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Thu, Jan 26, 2023 at 05:32:23PM -0500, Jonathan Cormier wrote:
> > > Create initial binding for the LTC2945 I2C power monitor.
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> >
> > Series applied,
> Great
> > after merging patch 4/5 and 5/5 of the series
> > to avoid spurious 32-bit build failures,
> Huh, I split these per request, curious why they'd cause build
> failures when separated...
Nevermind, I see your other response.
> > and after fixing a continuation line alignment.
> >
> > In the future, please run checkpatch --strict on your patches,
> Will do. I didn't know about this option.
> > and please provide change logs.
> This I did do in every cover letter.
> >
> > Thanks,
> > Guenter
>
> --
> Jonathan Cormier
> Software Engineer
>
> Voice:  315.425.4045 x222
>
>
>
> http://www.CriticalLink.com
> 6712 Brooklawn Parkway, Syracuse, NY 13211



-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
