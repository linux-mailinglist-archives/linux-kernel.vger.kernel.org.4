Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC77120B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbjEZHOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbjEZHOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:14:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AEB114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:14:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso3699131fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685085268; x=1687677268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3K/62msDIii3xLYW9Icv9dnXBGx+K8WckoEIc9LcduA=;
        b=H0qkNClkPMIWXXZNXMH5tA2x04zcS0hk+cqhMPZwXHszLan7W5SX1Kws9AaRAuDNGJ
         pgCueACS7YZWv+imegF89fLvEOi7HrfnhEB3ZsyOatvcdcjOVXgutlhZZvtJlp/u2mcY
         Kjh28TkQAxCVGaW17ZI4UiJTEsC00hwKlqpoFJF+sHnZxVlYHrUrt+Xtk+YDe/6ty1zh
         /ShrdoYVV4mmQcIpdSizk8L9Kn4MmHbN6GcI+Hjc3yqkyZqHfsrfpbGh/vAKiRLuv22P
         WExg/oEW3Y5cnzkoaFvd4D4U/67Sv9DLB5TthXCVUUWNFEDmLkpdSruB5EhpfPmhougY
         ViBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085268; x=1687677268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K/62msDIii3xLYW9Icv9dnXBGx+K8WckoEIc9LcduA=;
        b=VH6g7qYm3sVFrfbPBfYvR2D+JcDqgzg/x//Nt96ThHzbYTmtc5pNL/KIyLK0lJ6o/o
         uGV7iExluDmnawDoh6r02Rtr6hJCHDH5G/7XKQZbhCm/eeYP+5nCj6yBuTWcmw7hT2up
         fDId526rAMs1c+WvCpzpJ9Yqhv3MVbqgg3zJ3C7hrixd5g4Y5KfSo9zEp+XmoPJbxZam
         EaXB/DOeKYZA8Bbz9v8HLc+xUS5xwveIVd3HsdfJD8pTIL7AWzTca1R5zkub0WQY/CUJ
         lBPX1+xjLvX2jEuIw6HrsCyLepp4K7695bS2DeOYridf0UCOvtvWF5PJcd+O/EohiHW/
         G9aQ==
X-Gm-Message-State: AC+VfDy7OUbFAvXpTGmoN8KesPQ0QH4Gz6LWwn6/3V9Y9Wd9sDBZ3DI/
        TYh7WL3PzzurTtg1raGxxuH7Ig==
X-Google-Smtp-Source: ACHHUZ65xMv2X15SMYn7/LhjUXnbr6qqdbl8nLCRTsUbx9ec0tlYM2I8fNH80L+MU/pklpilBOqhRg==
X-Received: by 2002:a2e:84c1:0:b0:2ac:8a05:b2c7 with SMTP id q1-20020a2e84c1000000b002ac8a05b2c7mr384572ljh.7.1685085268428;
        Fri, 26 May 2023 00:14:28 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id z4-20020a05651c022400b002aa3cff0529sm586897ljn.74.2023.05.26.00.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:14:27 -0700 (PDT)
Date:   Fri, 26 May 2023 09:14:26 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban.Veerasooran@microchip.com
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Horatiu.Vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 4/6] net: phy: microchip_t1s: fix reset
 complete status handling
Message-ID: <ZHBcUvSbX0taOED3@debian>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-5-Parthiban.Veerasooran@microchip.com>
 <ZG+oOVWuKnwE0IB2@builder>
 <8a46450d-7c6e-68a4-c09d-3b195a935907@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a46450d-7c6e-68a4-c09d-3b195a935907@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 06:00:08AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Ramon,
> >> +     /* Read STS2 register and check for the Reset Complete status to do the
> >> +      * init configuration. If the Reset Complete is not set, wait for 5us
> >> +      * and then read STS2 register again and check for Reset Complete status.
> >> +      * Still if it is failed then declare PHY reset error or else proceed
> >> +      * for the PHY initial register configuration.
> >> +      */
> > 
> > This comment explains exactly what the code does, which is also obvious
> > from reading the code. A meaningful comment would be explaining why the
> > state can change 5us later.
> > 
> As per design, LAN867x reset to be completed by 3us. Just for a safer 
> side it is recommended to use 5us. With the assumption of more than 3us 
> completion, the first read checks for the Reset Complete. If the 
> config_init is more faster, then once again checks for it after 5us.
> 
> As you mentioned, can we remove the existing block comment as it 
> explains the code and add the above comment to explain 5us delay.
> What is your opinion on this proposal?
> 
> Best Regards,
> Parthiban V
> 

I'd suggest the following
/*The chip completes a reset in 3us, we might get here earlier than that,
as an added margin we'll conditionally sleep 5us*/
