Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664EE6C5E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCWEsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWEsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:48:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06426AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:48:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso390419wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679546896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8bAziUYqnGL4SIQuZNoH0KDLq2Xm3UdJM5/PkVf6UE=;
        b=qJE56KMrmKI7qjly0lf9NSOsiiyf3kVqBeHLdFV/eLjYpCNqg6al3C3wkEhvaQSSqO
         M+zzgVz2iOBy0yRa9ZTxiT9MK4ZmSLNP6kp8xaYE0XvizJkojvKTnAtNtp8HHyT+oqi1
         Sr4sn+DmgzJ5wEgsoyptvnvv8fPcNkrnB2wak87y6xQA2qWKNs6n0ezAciYA5R47t4Gc
         7NKxTrqPbZimMTLlZKeA1hVa8Xzt/FIzkSNtOFgUc/N9IypFLOMp8lKMUMoPln8Vunb+
         3f/blKhUgMuMLk1SNKDgTuBz95mJdYoqsu4C/6jSSQ+/L9nm/IpR0SF7jan1J3HbcbDX
         eQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679546896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8bAziUYqnGL4SIQuZNoH0KDLq2Xm3UdJM5/PkVf6UE=;
        b=IJDWZl9/vSj/ajeFVJDrwJmyvNxVnwafM+vqC+ruTUnJetSyj6oqMOVjBobaWnpiTY
         WPUfBv9H0+an+Ud6AgsyEbuaBnDdGmc1BDqS4uNwl4EYFB6ECD/CqEgVkCi0LysB579a
         y69U8/H9VpcbHPYorxYw/C9nbA3PAjgl73WYFfBGMIbIF5kQ1+liy6nSrINhFuYxIKbE
         QmlFM+pqv60HV2cUA/Z7O+PVP3R6qGZNoWVZt/N4OcErmoNI9AbwI0PfTtI7n6NQ/gvD
         kZnq2bpHuf5EwwZapapVCU7lz46aelKJP6YMzTZdFUHZieJlfGXFrHZm4oZjBOnMTXsn
         KPSw==
X-Gm-Message-State: AO0yUKVDe5C15doNMLoh9LtkPQZwEIcIquTCFtBkLoC9H2surcs7Wuq+
        BtoVdlGANiQQ/pc0rRmNblA=
X-Google-Smtp-Source: AK7set8D+ZzU5TwS+X5n0wOWx0DibgS+2FEk+QFEUdGrYC3Wxf+xI1waIFRQO1FxIkvMHiksZmrUPQ==
X-Received: by 2002:a1c:f013:0:b0:3ee:8442:8189 with SMTP id a19-20020a1cf013000000b003ee84428189mr687204wmb.5.1679546896287;
        Wed, 22 Mar 2023 21:48:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bi20-20020a05600c3d9400b003ee0eb4b45csm653792wmb.24.2023.03.22.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:48:15 -0700 (PDT)
Date:   Thu, 23 Mar 2023 07:48:11 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: fix line ending with '('
Message-ID: <6af8c3d2-de18-4149-a85b-8fb8235f6001@kili.mountain>
References: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
 <8064a4ee-665b-417e-a1e2-7e7dd32ec1f0@kili.mountain>
 <ZBtDj/sRJCiOhsRD@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBtDj/sRJCiOhsRD@khadija-virtual-machine>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:06:07PM +0500, Khadija Kamran wrote:
> On Wed, Mar 22, 2023 at 06:09:50PM +0300, Dan Carpenter wrote:
> > On Wed, Mar 22, 2023 at 08:01:52PM +0500, Khadija Kamran wrote:
> > > Splitting function header to multiple lines because of 80 characters per
> > > line limit, results in ending the function call line with '('.
> > > This leads to CHECK reported by checkpatch.pl
> > > 
> > > Move the function parameters right after the '(' in the function call
> > > line. Align the rest of the parameters to the opening parenthesis.
> > > 
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > > 
> > > Changes in v2:
> > >  - Changed the description
> > > 
> > 
> > No one replied to the v1 of this patch so it's not clear which of the
> > patches should be ignored.
> >
> 
> Hey Dan!
> 
> I created a patch revision without any feedback. My bad. I thought the
> description in the previous patch was misleading, so I wanted to change
> it.

Yeah.  But you have to reply to the other email.  Otherwise how will we
know there was a response to it?

> 
> > Also you have a couple patches with the same subject and that's against
> > the rules.
> >
> 
> I am sorry about that. Kindly guide me here. 
> Both patches are for same driver i.e. staging/most, but for different
> files. Would it be fine to add file names in the subject to
> differentiate them?
> 

I trust you.  Figure out a way.  ;)

regards,
dan carpenter

