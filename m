Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9C7120B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242110AbjEZHKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbjEZHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:10:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F61125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:10:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b5881734so411737e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685085015; x=1687677015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdSg9NNrGreQrCE+41nuiJXywFlMg6bfSTzQTeA3s0E=;
        b=wV8hXAlTqXUsZbsSvOPXVKDD77Yds5Wc2nhgmK1XKx78K0YXTvRb7ImCIYu6fGBP1C
         4ZGOG5EXz679whvOJcZVf9ayuTYDJkWfhJfGXZ1TTRlC12IFhRRJCudrcyocrGM8JsC7
         gjApEvzwSGNhqtgBfYJikC7tHmBa/e1gRpecvurPwqj/N2DXnpienBYmThZ5EXymO7+S
         qxqTg9udNGx1qMwuegqMdG4MtLTriQF/spcMcne+uAIaxTLAXYRZq9OyUvYnY8TcZg+r
         fLRibuiWSK8ZbORI0XzQP9xpGZ372n4tO+ADw1Qkep36caoRbfOv2WwGk4hZ+KDY5MmL
         PmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085015; x=1687677015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdSg9NNrGreQrCE+41nuiJXywFlMg6bfSTzQTeA3s0E=;
        b=HS1ie7+TJlIxiscEA1BxgCay6XBY2jDrmrz9HD2k2YlsHJPQ6ni5YfMonrFXMInMpk
         CxW20UYuFOprenZifFX6FreDL1fjTOBFMpZgvbrZZ/682ERq3iiUUfrTwdq1aMS7iMRo
         5CdMq8CPHP5BEaGaEqJY+h/a8fHBS2/bpkeDnDdoR3Pw56ZAHTN5QpyZ6Jiyt5u1frRE
         u6kFC+LMj+rmtNwgbrD0d46g38Mih3hIE2QI4046C8nA2bX7axZZqSuU3vYY8xmBjsqi
         674N70CIgOnTuseBvo5Oj/KMlu5YGLPDiPpncbUK6f1kNqTEpnH7f7yFFgSsrBIOkaos
         /KpQ==
X-Gm-Message-State: AC+VfDz6iJI495ip2f6f4bU7C0thXHr5iDIMeNvdDWTBp6bAO4h3RNK4
        /3Pn45GjE4bT+xURyjbWZbGAkw==
X-Google-Smtp-Source: ACHHUZ7+mkpIO2s9Sgs7OSiBzlir4Snu1p566KlcrNwvuimRXpNtoLOjtVD7HEOHgLF77AZ+hLTZkw==
X-Received: by 2002:a05:6512:15d:b0:4ec:7b87:931a with SMTP id m29-20020a056512015d00b004ec7b87931amr359152lfo.13.1685085015190;
        Fri, 26 May 2023 00:10:15 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id b27-20020a056512025b00b004f121c8beddsm501833lfo.124.2023.05.26.00.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:10:14 -0700 (PDT)
Date:   Fri, 26 May 2023 09:10:12 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban.Veerasooran@microchip.com
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Horatiu.Vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 2/6] net: phy: microchip_t1s: replace
 read-modify-write code with phy_modify_mmd
Message-ID: <ZHBbVNWeKK2di73h@debian>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
 <ZG9599nfDnkcw8er@debian>
 <f81c80cb-fbe8-0c7e-f0f9-14509f47c653@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81c80cb-fbe8-0c7e-f0f9-14509f47c653@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 05:48:25AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Ramon,
> > Nitpick, I think this block comment can be reduced to:
> > /* The following block deviates from AN1699 which states that a values
> >   * should be written back, even if unmodified.
> >   * Which is not necessary, so it's safe to use phy_modify_mmd here.*/
> > 
> >   The comment I added was intended to describe why I was doing weird
> >   things, but now I think it's more interesting to describe why we're
> >   deviating from the AN.
> > 
> >   Or the block comment could be dropped all togheter, I'm guessing no one
> >   is going to consult the AN if things 'just work'
> > 
> By consolidating all your comments in the other emails as well on this 
> 2nd patch, do you agree for my below proposal?
> 
> We will remove all block comments and simply put AN1699 reference as we 
> did for lan865x_revb0_config_init with a small addition on top of 
> phy_modify_mmd for loop? so the comment will look like below,
> 
> /* Reference to AN1699
>   * 
> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
>   * AN1699 says Read, Modify, Write, but the Write is not required if 
> the  register already has the required value. So it is safe to use 
> phy_modify_mmd here.
>   */
> 
> So in future, if someone wants to know about this configuration they can 
> simply refer the AN1699.
> 
> What do you think?
> 

I'm not sure about the link, resources have a tendency to move.
Otherwise LGTM

> Best Regards,
> Parthiban V
