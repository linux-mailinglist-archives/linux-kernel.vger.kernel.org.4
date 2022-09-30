Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210D35F0807
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiI3Jw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiI3Jwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:52:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A312888B;
        Fri, 30 Sep 2022 02:52:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q17so4228336lji.11;
        Fri, 30 Sep 2022 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5e++Bq8byiSeO9h99CYt5V1LItyqEPo3VTEHQk8BylQ=;
        b=HwxvMPTlOzXP1QfP3zDzS7IbqRifPUtcnIIb0LaVXEe1n8584HeeBV8pTDgaEoqFFP
         LawrtsDaBnla4Y9Nh0y6H6BypJloBhWDZ6FLzwUYBdbmj1l50NGkzyULniykfbiaw8Sj
         E+NDJQ1izK3UOlHhKpxSvb6uRs0xUL7i/rX0a2V6a99AJw79LQYkFEKFIoXIf6pHtxTf
         wRqtb+F4+9MAoZp56CAnTtFpaAaWP4AWMM7LaZyQzVBq94EsnvH7hhHOqJR4O3GiBGS7
         qtb04qii52P1uk1QTF6QvtZbJRzlGOhCHqAOWTw9M6zzzx7k8ZmKcUvP86vHMW7WPnqz
         aA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5e++Bq8byiSeO9h99CYt5V1LItyqEPo3VTEHQk8BylQ=;
        b=i+pjiBvtElZU25pXdcbutEI9LTpvIpT0M+cmT2wIKd1qF+IK0O8JBEsc1Dc+fHeLcO
         JZXFfAHw4tYG2shrduozfAXh0WDrtgP9UK6L7j5QmCTKANuJAyrPh4OL41F5GELpyo7t
         HLzvFQYpb7aGMllUnBu7wvQt4AlSW8o/91cMWKbx0BqWOQ7FWpkuR03qDiNP2rmO5xt8
         blklvFo4+VDLghoQS5I7n454YFWOmenEJt4sIZatzW7Jml0o0aDnVstf/jbDy4YJ92lL
         4+AQ2X+zYpSOnExkKK357D59YYHG0DcOgyx0hGoVP6o75yDV0XVGM6jwjF4APX32qf9S
         e+tg==
X-Gm-Message-State: ACrzQf2hZveKdq2J1rOdU7L7YWbyz6Yee5AyBwQrDz8q5ume0l61xCEE
        fcp3Ug3RsFJxm6WAB+NVtLO8w6euOuySkA==
X-Google-Smtp-Source: AMsMyM5W3qggiqHyrqng78Ar+doOtQG5XPfZcA7kWDg4EtlNDKjdeRjPyWaF128cmsRAZ/ILfiIL2Q==
X-Received: by 2002:a05:651c:2205:b0:26c:622e:afef with SMTP id y5-20020a05651c220500b0026c622eafefmr2879674ljq.242.1664531570503;
        Fri, 30 Sep 2022 02:52:50 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id c17-20020a056512105100b004a1e592837esm242979lfb.140.2022.09.30.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:52:49 -0700 (PDT)
Date:   Fri, 30 Sep 2022 12:52:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <20220930095247.vqtdc53rr66uaiwv@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:53:43PM -0600, Keith Busch wrote:
> On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> > Inability to allocate a buffer is a critical error which shouldn't be
> > tolerated since most likely the rest of the driver won't work correctly.
> > Thus instead of returning the zero status let's return the -ENOMEM error
> > if the nvme_hwmon_data structure instance couldn't be created.
> 

> Nak for this one. The hwmon is not necessary for the rest of the driver to
> function, so having the driver detach from the device seems a bit harsh.

Even if it is as you say, neither the method semantic nor the way it's
called imply that. Any failures except the allocation one are
perceived as erroneous.

> The
> driver can participate in memory reclaim, so failing on a low memory condition
> can make matters worse.

Yes it can, so can many other places in the driver utilizing kmalloc
with just GFP_KERNEL flag passed including on the same path as the
nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
either finished or executed in background anyway in all cases. Don't
really see why memory allocation failure is less worse in this case
than in many others in the same driver especially seeing as I said
above the method semantic doesn't imply the optional feature
detection. Moreover the allocated structure isn't huge at all. So
failing to allocate that would indeed mean problems with the memory
resource.

> 
> The rest looks good, though.

but you ok with kmalloc in the next line. Seems like contradicting.

@Christoph, what do you think about this?

-Sergey

> 
> > @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
> >  
> >  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > -		return 0;
> > +		return -ENOMEM;
> >  
> >  	data->ctrl = ctrl;
> >  	mutex_init(&data->read_lock);
> > -- 
