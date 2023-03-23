Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7B46C67AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCWMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCWMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:08:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACBB30CA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:08:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so85484107edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ztkH31CIfk39LS0OpJRftIe1GxALxXo0HeUk1ilWpA=;
        b=R+XfAY0cxu69eRIS8w3Brw8MAqi4WrcBKMJIiW3YcEEQcKAZ04vyvNYIPA3PrQuHww
         Sin7gSgTXQ3PxOIBQaubVMfqrFO8ABH2BviUbcTZ1mUBeZab6xsGaXz+RwkCWZzFhh7v
         7MAOxRON6c0U4ciwEtoHaVeNmR77r2EK53qCkKrrtuKFm5IWr6EUQZ+5WEYsyyVpu5RS
         Wr5jrvL9jP8+LwLUt0OnaHKS+pI6bypGJt4jqBJ9uctx2Sk4g+8wVrZAPpq+VFQL7j9o
         1+CFGYSOKglU0aHH/tIjPmp5qTPAHtO1ap8fGzPzIK58+4LUXPnrJ2VENtaOXJyChMW9
         I1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ztkH31CIfk39LS0OpJRftIe1GxALxXo0HeUk1ilWpA=;
        b=JTf57DZqdzMIIHGsGuGe8HPVfM6BGjr1kCLs9241Zdtrd+qKzm7jxC2rVxdBgFW2v/
         mbyXPMhRjvR4zjbHdmza347JMqwJ2SahN2Rk1mJrvtFVwTWeToKJK11m4IfVWf7MujR5
         4OcMLM7DiihmZnKn2SbjnFhcBKuowuWOt377IL60C8bGxMOHvIeWW5pDK1zcx+J0cRbO
         WtH+gjBzQEXhT5e/TOz/JFLqpGvYCty/nhX49Fm1wzL6NFjQkWfyzcY6neNmisAbNlPV
         feOlvR5F0rgqHkkHBRi2FecZufx1858cNiqsMDp6qtjssZdsTDy4yQxKq7UVS8l8il9r
         1/HQ==
X-Gm-Message-State: AO0yUKX+rf/PqZs6THH+yk7wXOENq5daM5y6XFvduv9e9omXG/h9SHAM
        OUwzEdNh7x29Lzd7p6IpgNodGtzC9AY/84UZ
X-Google-Smtp-Source: AK7set/yjnAL+ZjoJJ1xfg3w5pvJOHklYTxPBQV6O3MLaQxRw3habMiwGqeUjv8GgtxOj6JFRpYmZg==
X-Received: by 2002:a17:906:2c07:b0:84d:4e4f:1f85 with SMTP id e7-20020a1709062c0700b0084d4e4f1f85mr10297836ejh.59.1679573294446;
        Thu, 23 Mar 2023 05:08:14 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id k6-20020a50ce46000000b004f0e11e071dsm9123376edj.73.2023.03.23.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:08:14 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:08:11 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: fix line ending with '('
Message-ID: <ZBxBK0lg5p9+XcJ7@khadija-virtual-machine>
References: <ZBsSOlPbaGZcAaSY@khadija-virtual-machine>
 <ZBvbP8ugDFjSoVp/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBvbP8ugDFjSoVp/@kroah.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:53:19AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 22, 2023 at 07:35:38PM +0500, Khadija Kamran wrote:
> > Splitting function header to multiple lines because of 80 characters per
> > line limit, results in ending the function call line with '('.
> > This leads to CHECK reported by checkpatch.pl
> > 
> > Move the first parameter right after the '(' in the function call line.
> > Align the rest of the parameters to the opening parenthesis.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/most/dim2/hal.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> You have 2 patches here with identical subject lines, yet they do
> different things :(
> 
> I've dropped all of your pending patches now for the most driver as I'm
> totally confused.  Please resend them all as a proper patch series with
> updated subject lines.
>

Hey Greg,

Okay understood. Sorry for the inconvenience.

Regards,
Khadija

> thanks,
> 
> greg k-h
