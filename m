Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAB728947
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjFHURp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFHURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:17:42 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AC330FE;
        Thu,  8 Jun 2023 13:17:11 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-777a9d7efabso50907939f.0;
        Thu, 08 Jun 2023 13:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686255430; x=1688847430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2bzye3qdHnsdMOOpdJS17HW2XawEXF4P/SDFSPJSSg=;
        b=iJQPKcH3qIdjrAexZDedFvQ8XMuGh4w2rPC6vb804f7EZi1RbQOPI5T+bNtLjTSx+m
         61k49I5AYGCnwrpP5cncNzXJwqaLoZXCQmsxoj6nSVjX3E/FDN4d0h0KF8Jc3pnUyKK+
         O0/6uVXnW9NaqOvBOhUyj3AZJWvgFG2ZQ7n1b/LOPys9g24m5kNRJ3NuznS5bdITZ/Xl
         +qfpNDju/MPcSkJfreEK3Gq1XpDIcwqsKmg3ah8BeZ6izlYsV+437GftMaS1rVT94eUd
         jQ7b5rM1mD4xAKV/IR7Mknmr946GE8d4t0XRgIb69P4plovtxjR50CM0Z/gXYgW5lVFT
         6B4Q==
X-Gm-Message-State: AC+VfDx9vJsCWR6Py/AmM9F9Y1eI2MNkBg9eJIVSp7DCLxy2+yWeMLIX
        pWhFnD+0f8OlVo59qTJsGg==
X-Google-Smtp-Source: ACHHUZ7lAstS+N8P/f6NVeo18fgD2XEUFYRJ7Q6a0iUpECaeA9h4PL28CMYx1jrmgNwCjR5rWjUmpw==
X-Received: by 2002:a5d:8b42:0:b0:77a:c800:5161 with SMTP id c2-20020a5d8b42000000b0077ac8005161mr4512036iot.4.1686255430520;
        Thu, 08 Jun 2023 13:17:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g3-20020a02c543000000b0040f91a65669sm293961jaj.21.2023.06.08.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:17:09 -0700 (PDT)
Received: (nullmailer pid 3391292 invoked by uid 1000);
        Thu, 08 Jun 2023 20:17:07 -0000
Date:   Thu, 8 Jun 2023 14:17:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Claudiu.Beznea@microchip.com, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        conor+dt@kernel.org, conor@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, sebastian.reichel@collabora.com,
        linux@roeck-us.net
Subject: Re: [PATCH 3/5] dt-bindings: timer: microchip,sam9x60-pit64b:
 convert to yaml
Message-ID: <20230608201707.GA3359628-robh@kernel.org>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-4-claudiu.beznea@microchip.com>
 <20230525-straw-fidgeting-4c1099aa16fe@spud>
 <5edf3d3b-6f59-0af3-6414-940a278962bf@microchip.com>
 <20230526-knickers-aim-e01220e6a7cd@wendy>
 <5a5d25a2-e6b5-fd69-f615-cd3d6ed33b9f@microchip.com>
 <20230526-unsubtle-chowtime-ce329d7e5627@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526-unsubtle-chowtime-ce329d7e5627@wendy>
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

On Fri, May 26, 2023 at 08:55:39AM +0100, Conor Dooley wrote:
> On Fri, May 26, 2023 at 06:41:39AM +0000, Claudiu.Beznea@microchip.com wrote:
> > On 26.05.2023 09:23, Conor Dooley wrote:
> > > On Fri, May 26, 2023 at 04:47:28AM +0000, Claudiu.Beznea@microchip.com wrote:
> > >> On 25.05.2023 20:14, Conor Dooley wrote:
> > >>>> Convert Microchip PIT64B to YAML. Along with it clock-names binding has
> > >>>> been added as the driver needs it to get PIT64B clocks.
> > >>> I don't think both of these PIT things need to have different binding
> > >>> files. 90% of it is the same, just the clock-names/number - so you can
> > >>
> > >> But these are different hardware blocks with different functionalities and
> > >> different drivers.
> > > 
> > > Having different drivers doesn't preclude having them in the same
> > > binding provided the function/description etc are more or less
> > > identical. I was confused by:
> > > 
> > > +description:
> > > +  The 64-bit periodic interval timer provides the operating system scheduler
> > > +  interrupt. It is designed to offer maximum accuracy and efficient management,
> > > +  even for systems with long response times.
> > > 
> > > +description:
> > > +  Atmel periodic interval timer provides the operating system’s scheduler
> > > +  interrupt. It is designed to offer maximum accuracy and efficient management,
> > > +  even for systems with long response time.
> > > 
> > > Those seemed like they do the same thing to me!
> > 
> > They do the same thing, they are timers... But the way they do it (from
> > hardware perspective) is totally different. With this would you still
> > prefer to have them merged?
> 
> Yeah, one binding would be my preference.

I'd probably just leave them separate if they're pretty much unrelated.

Rob
