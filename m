Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B2693EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBMHJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:09:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419CEF91
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:09:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ja21so4973760plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xExRi+o63q1HwNgTHv0H7sxvgx9mQNthcMnnTAqoOF4=;
        b=YqvFgU6GDf43Kg75RKS1jkmZO3qJ3rhfbmIWNv1T4J8sHSZflfavHfH0bC0dr6Ev5F
         DRq338PPGtf3DVc6v5JUSagwmi/H/fPAMRs8knyBdH233Htc6JVx6ibmRhMHTQ92dSit
         DwJKv9JzIthPS/lyJIndGp4vjrvgZXktBhaUE0K+Kynj/lrmbU5/J3Yb3Q6Jm7QMSRyw
         Eq5YPOTYAlhlHPpVSaf8VByeXbwTGy05/GvDnsXrouI6Ju5Q2HQBUVlLtKDhU5T8auh/
         oqB09RpLtmaFGMC5eMOEqSjIiqXyV5oYIOYqxJiX+61mL93uAoLmGKpDADXyR74EL8hK
         QWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xExRi+o63q1HwNgTHv0H7sxvgx9mQNthcMnnTAqoOF4=;
        b=mYY5U9fhFcYeUrWiMyx59i3estcDvRav9M/oAH8VYJ2wo9U7Uk006VBf+ClitfgMNn
         4fnurP+9c9nqu6rz3PX8pq/9Di15UXVnvWZDlnoONJ0H9dTHUpRLSee07uu5A8lN/I13
         Ys6J4ZJdw0F953zqJYxZRI1l+kEa4oRo1JAVOUx1mClXpxaNdr82njFVhdpN8ELsBbaQ
         S2BXqwA9ptsqYrHb5Ggdg8SHAmOpFqDh4bLbP+v3Vfcu6LqALRM4lrkJwMBe94q+IZ/G
         L5V0V5Q6KFWNWMKs2v6m66Y3GdihjbsXy7mQlBugIWeq0Ws85Sad+t2jndJiOHlh2aSt
         yxHA==
X-Gm-Message-State: AO0yUKUe1Ws6gs1G+yLxXtKZwJYxTPWLHxCALMH2W9xgfc1gEP0RHpy8
        3nplIQLBzjveoyTCbitlQYAHNdWfhtnHWSo=
X-Google-Smtp-Source: AK7set9XD4sEyJsfcbaSF/yMbmIHsvuckwa03D91G4ufNS3jYa4kTO7bLbBTdl0e6/t15uvVRFl2qw==
X-Received: by 2002:a05:6a20:158b:b0:bf:9198:b683 with SMTP id h11-20020a056a20158b00b000bf9198b683mr30384528pzj.36.1676272159963;
        Sun, 12 Feb 2023 23:09:19 -0800 (PST)
Received: from thinkpad ([117.217.182.252])
        by smtp.gmail.com with ESMTPSA id b187-20020a6334c4000000b004fba03ee681sm1538664pga.13.2023.02.12.23.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:09:19 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:39:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
Subject: Re: [PATCH v4] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <20230213070912.GB4375@thinkpad>
References: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
 <41ade5cb-98c1-e859-be4d-68eb05d0ea44@linaro.org>
 <Y+KcndmBBQw16hfM@google.com>
 <639db6ae-c7de-eec2-de4f-516aba471d47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <639db6ae-c7de-eec2-de4f-516aba471d47@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 09:39:15PM +0100, Krzysztof Kozlowski wrote:
> On 07/02/2023 19:46, Lee Jones wrote:
> > On Tue, 07 Feb 2023, Krzysztof Kozlowski wrote:
> > 
> >> On 29/11/2022 18:49, Manivannan Sadhasivam wrote:
> >>> Document the commonly used LED triggers by the SoCs. Not all triggers
> >>> are documented as some of them are very application specific. Most of the
> >>> triggers documented here are currently used in devicetrees of many SoCs.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>
> >>> Changes in v4:
> >>>
> >>> * Removed the sorting of triggers
> >>> * Removed the "items" as they were not needed
> >>> * Reworded the description
> >>> * Dropped Zhen Lei's tested-by tag as the patch has changed
> >>> * Added kbd-capslock trigger
> >>
> >> Any plans for this patch?
> > 
> > Who are you asking?
> > 
> > This patch is not in my inbox.
> 
> Mani and Pavel. I Cc-ed you just for completeness.
> 
> I would expect Mani to rebase and resend it.
> 

Sorry for the delay, sent now!

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
