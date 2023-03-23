Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850C6C67A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWMHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCWMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:06:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABE9E3B0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:06:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i5so38514931eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0b1o3tcjjGCunc9G0qk/bdAz77AhUyucu+7MQcBhgJ8=;
        b=W1P0fQzSHbA9QOxmv9Zxb90U0FzlyXGoACDg5S+tEl0k6Hsi6iFLosZaunmuuJwCEG
         jhJr9PrPPXRD74/VJ435sEz6RBmx1KUTolZ56T0BPuYSMNsF+IqnyrioLdv3puxb43jg
         ZoTU/AuYqnrlN0BSy4/t7nSv8WhkwzqhfpDyBI3IbfrR/S85VDBwwB6gnXARM2SGdmmY
         NofjaSdrckReFjOux+XyHAA8Nm4TLXi/AQW0xyTx+/pZ6qYGIXA0EAcYGg/5jDVwCLzp
         2+ZPzYlYVeLI9KIZxmykmLK727B9ylEW+tXEavRwymgzpwrBL94G79e6c8AfBTs6XtAE
         ZswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b1o3tcjjGCunc9G0qk/bdAz77AhUyucu+7MQcBhgJ8=;
        b=gI3cE7J83/YtoTXdDFd6owf4+5vSlYhlfqatwCRMr8hwawfl1NDG2NAZHxtgEkA+Qh
         1DV19dM4iA1c90sZM73W3VBADO0EZhowBoBAvwD39ZIOYNciEFFBMCO3RoNUIwkp9II0
         T2Xc5TPIqkgFNO+6ij3C9dwHkeyIsqF3vHioG3kMXuVqmoJwkHICJvCkuq432vUIlMma
         NXLvuTJS7w6vSO0Ah581sKNuo5DQr2Oa13lS4ZJx/tnYG6WKyuCloSDPZOufS5n8SiFc
         //U6P235QLWxTW+HM9zhOwcesF+lKGTH1tLWpd2hjwxkH87TLp3w+7Sr//XDglfYHWyr
         TBGA==
X-Gm-Message-State: AO0yUKUVa0/zeYOaNShq5OIaar7YWgfc4yCLcvzPEvaRkVtLpFfaSO/W
        /L39u7GBKedoAiT0UYtYERl/jOJ4eq1aNjTw
X-Google-Smtp-Source: AK7set+QnsaEuAOcDuMjvIifg6pOFxEpoLtu5/trQDMYnKdIgx0Z7J6OFvtYho30UBFyUOirstM0JA==
X-Received: by 2002:a05:6402:187:b0:4fb:5a36:1539 with SMTP id r7-20020a056402018700b004fb5a361539mr9268263edv.25.1679573168505;
        Thu, 23 Mar 2023 05:06:08 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906079300b00932ed432475sm7398322ejc.124.2023.03.23.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:06:08 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:06:06 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: fix line ending with '('
Message-ID: <ZBxArn/4kun1An+m@khadija-virtual-machine>
References: <ZBsYYAc1Ue/JnUAm@khadija-virtual-machine>
 <8064a4ee-665b-417e-a1e2-7e7dd32ec1f0@kili.mountain>
 <ZBtDj/sRJCiOhsRD@khadija-virtual-machine>
 <6af8c3d2-de18-4149-a85b-8fb8235f6001@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af8c3d2-de18-4149-a85b-8fb8235f6001@kili.mountain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:48:11AM +0300, Dan Carpenter wrote:
> On Wed, Mar 22, 2023 at 11:06:07PM +0500, Khadija Kamran wrote:
> > On Wed, Mar 22, 2023 at 06:09:50PM +0300, Dan Carpenter wrote:
> > > On Wed, Mar 22, 2023 at 08:01:52PM +0500, Khadija Kamran wrote:
> > > > Splitting function header to multiple lines because of 80 characters per
> > > > line limit, results in ending the function call line with '('.
> > > > This leads to CHECK reported by checkpatch.pl
> > > > 
> > > > Move the function parameters right after the '(' in the function call
> > > > line. Align the rest of the parameters to the opening parenthesis.
> > > > 
> > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > ---
> > > > 
> > > > Changes in v2:
> > > >  - Changed the description
> > > > 
> > > 
> > > No one replied to the v1 of this patch so it's not clear which of the
> > > patches should be ignored.
> > >
> > 
> > Hey Dan!
> > 
> > I created a patch revision without any feedback. My bad. I thought the
> > description in the previous patch was misleading, so I wanted to change
> > it.
> 
> Yeah.  But you have to reply to the other email.  Otherwise how will we
> know there was a response to it?
>

Hey Dan,

I will keep that in mind next time.
Sorry about this.

Regards,
Khadija

> > 
> > > Also you have a couple patches with the same subject and that's against
> > > the rules.
> > >
> > 
> > I am sorry about that. Kindly guide me here. 
> > Both patches are for same driver i.e. staging/most, but for different
> > files. Would it be fine to add file names in the subject to
> > differentiate them?
> > 
> 
> I trust you.  Figure out a way.  ;)
> 
> regards,
> dan carpenter
> 
