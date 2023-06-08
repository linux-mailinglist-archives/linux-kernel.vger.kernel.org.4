Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F0728369
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjFHPQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbjFHPP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:15:58 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102012D6D;
        Thu,  8 Jun 2023 08:15:56 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33cb82122c7so2282125ab.1;
        Thu, 08 Jun 2023 08:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686237355; x=1688829355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdr6h3xlT0s10AAMIzoAd0fqH1qnHaQu9PS8cpJiPSU=;
        b=jarnKjIqsYvgxl/IkgdduBmz13z8sxbvRir//061kbroV05hNBBndpX7cpVR07x+bf
         +DGoo5Xq5QyvJV1xkbKsbXYuv5P06JiTkq3pocObfDMrV+3ufNaXlfNoZePgPOWEq12o
         vh7MCnGrZzpE0uoymPBGb7nnahOkyL6zrnEDltp620sq/kYf3nlgWzIZTwHIIVb4U75t
         esuqrOvViseoG40KUD73nmw5RK42SfTLyQUGnHYDEyR88SBcHQfPwqnPQnxaDmDKA7PB
         7U9HPvCm8oFB9Ba3bIXAaYMSGOcV8NPtUldI8yTSkl3dMboUtFM26MvaHRosCs3bbrtK
         q39g==
X-Gm-Message-State: AC+VfDzDjqPwELqJ5w99qV9XMkiRi6EkKijxJrZewWbkFLBIJh4cG3VP
        z4WqulDRqkGaQpGk62pRPA==
X-Google-Smtp-Source: ACHHUZ6c2mDobEqawXg5KuKKk2m3x3XmcmpQemI8k7rhvj+ZPU82e1c5pml2iLfIZD4VQEX7S6da+g==
X-Received: by 2002:a92:c98f:0:b0:331:1f0e:79b8 with SMTP id y15-20020a92c98f000000b003311f0e79b8mr6879652iln.0.1686237355131;
        Thu, 08 Jun 2023 08:15:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p5-20020a92d285000000b00333b5ae4ab7sm439825ilp.87.2023.06.08.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:15:54 -0700 (PDT)
Received: (nullmailer pid 2700534 invoked by uid 1000);
        Thu, 08 Jun 2023 15:15:52 -0000
Date:   Thu, 8 Jun 2023 09:15:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>, jdelvare@suse.com,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, lee@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        corbet@lwn.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Message-ID: <20230608151552.GA2637361-robh@kernel.org>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:23:52PM +0200, Krzysztof Kozlowski wrote:
> On 06/06/2023 16:06, Patrick Williams wrote:
> > On Tue, Jun 06, 2023 at 12:49:04PM +0200, Krzysztof Kozlowski wrote:
> > 
> > Hi Krzysztof,
> > 
> > Thank you for reviewing this from Billy.
> > 
> > The Aspeed chip is heavily used by the OpenBMC community and the 2600
> > has been used in production systems for almost 2 years now.  Many
> > companies are having to carry previous versions of these as patches, and
> > some of the APIs changed since the last revision from Billy.  So, I had
> > asked him to submit the latest patch set with as many revisions as he
> > understood what to change, since the conversation seemed to have died
> > since last time he submitted.  
> > 
> > I don't believe Billy is intentionally ignoring your feedback and he is
> > motivated to get this patch set wrapped up into an acceptable state.
> > 
> >> On 06/06/2023 11:45, Billy Tsai wrote:
> >  
> >> NAK. You got here clear comment. You cannot have simple MFD with
> >> resources. It is not simple anymore.
> >>
> > 
> > In fairness, Billy asked for clarification from you on this point and didn't
> > receive it.
> > 
> > https://lore.kernel.org/lkml/24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F@aspeedtech.com/
> 
> I gave the instruction what Billy should do:
> 
> https://lore.kernel.org/lkml/41500a04-b004-0e2c-20a1-3a3092b90e6d@linaro.org/
> 
> What about other ignored comments? About subject, quotes and more? Even
> if this one was unclear, then why ignoring all the rest?
> 
> > 
> > He felt what he was trying to accomplish met the documented
> > expectations.  Are there some changes that need to be done in mfd.txt to
> > further clarify when to use it and when not to?
> 
> I think mfd.txt clearly states:
> "For more complex devices, when the nexus driver has to
> probe registers to figure out what child devices exist etc, this should
> not be used. In the latter case the child devices will be determined by
> the operating system."
> 
> Also, repeated many times:
> https://lore.kernel.org/all/YXhINE00HG6hbQI4@robh.at.kernel.org/
> https://lore.kernel.org/all/20220701000959.GA3588170-robh@kernel.org/
> https://osseu2022.sched.com/event/15z0W

I've probably said this already, but any 'fan controller' needs to 
define a common fan binding that works for multiple scenarios. There's 
been some attempts in the last year which seems to have stalled out.

Rob
