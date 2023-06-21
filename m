Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B95738A24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjFUPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjFUPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:52:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2720185
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:52:16 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3426e9a9c3eso10204365ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687362736; x=1689954736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag26UyDKkHoxQiyV8O/Ldi7kyB/IB6ncqW08quTitXc=;
        b=fdmRdnAhrslppJ5Z82ML7utsOyR69vz7HyZmzKymg8XXor/GEQSJtUw1A1rHW45p5b
         uBWVAbnacuusd6bEIwqtV01XB6X4ejBISp9nHP113D7ylvyAh5y/ITHwvNLwY632IcMQ
         HjcNIyoKukZKtu8hW65xCl1fFDnv96TQb2pqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362736; x=1689954736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag26UyDKkHoxQiyV8O/Ldi7kyB/IB6ncqW08quTitXc=;
        b=Tqw59at84jARZgR6o4NWcr4UhINNcFIJsJH+7xF56NC8WPffaJ+SEVrRfMB80ZZqv9
         J86fyWnMZOHBBKghOX3aGmxuK/HrevFKiZV0luDV52nMZUi7w0WgY6sw3L+V4e4hXOjd
         mSuljs6/S54ygN/IIwIK9L6JnnHhJaYzIvWbwZvHtjO6Qot2K4YCWC3IKdkT3RwMQyxG
         c0mwBbY/TRCk3vvtD6ly9QoNDS7BPCyOQz+E3+I87hVb3r5pE0sB1jIBrZhwROQIdRS8
         G2VepzQi1fEaMWR8q1+Y0dUGnjirCu3I4OgybTTyFc5Xgefiipc6wxC+EtaFIuuFGjtd
         Ek0Q==
X-Gm-Message-State: AC+VfDyxTF4obxxgri7LfDPtPb2j3BOCuvHU4I8kX6G/N4Y9jPeCdf6P
        fnFCOM0P/SGzqujpSWg5WNCLCQ==
X-Google-Smtp-Source: ACHHUZ4e2yjbNJGAZVtzu0Zc1nOkU+tFiE5bwvkTTjEvRBjqhxm1wIGJlaqe3zNlVxolUXe/Gyt+0g==
X-Received: by 2002:a92:c081:0:b0:334:de38:d600 with SMTP id h1-20020a92c081000000b00334de38d600mr10877938ile.3.1687362736246;
        Wed, 21 Jun 2023 08:52:16 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id u2-20020a056e02080200b00342093347d8sm1392332ilm.76.2023.06.21.08.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 08:52:15 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:52:15 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: onboard-hub: support multiple power
 supplies
Message-ID: <ZJMcrwcwx5HVC/DL@google.com>
References: <ZJMPv6Fm3On0ITFi@google.com>
 <20230621154505.2229794-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621154505.2229794-1-bbara93@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:45:05PM +0200, Benjamin Bara wrote:
> Hi,
> 
> thanks for the feedback!
> 
> On Wed, 21 Jun 2023 at 16:57, Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Wed, Jun 21, 2023 at 04:26:27PM +0200, Benjamin Bara wrote:
> > > +     hub->supplies_num = 1;
> > > +     if (hub->pdata->supplies_num > 1)
> > > +             hub->supplies_num = hub->pdata->supplies_num;
> >
> > Please change the above to:
> >
> >         if (hub->pdata->supplies_num != 0)
> >                 hub->supplies_num = hub->pdata->supplies_num;
> >         else
> >                 hub->supplies_num = 1;
> >
> 
> I would even prefer:
> if (hub->pdata->supplies_num)
> 
> if it's fine for you?

Sounds good to me :)
