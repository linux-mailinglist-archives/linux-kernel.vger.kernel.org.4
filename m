Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1016C6999
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCWNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjCWNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:34:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC528D04
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:34:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso1111553wmo.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679578489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo6P5WDnhoMfi3lKTlvIX6M6cZHaujHpVvQIbrEWH0Y=;
        b=j9Fm4p2c81n9IIu0neqEAPqcST5ZuZprU3xOybNhBR5T3b1LoR0wrL01Y9VHUJJjWy
         2tR59ZZ4TiorD7up6HQ+SFtDPdfM2n3dd3bGhrqRo7YCE1RK3b8lSmOQXmjuybSjAHfm
         K2fsgq1i5r1Kx32/gCMmBQE5klSMRbT1Kp+/SuG6jHzeixlwIMdMGhMKi0pL3pqsFTqx
         maniGPfFSvW6IeNOWXHLWu3o4Bkj0PcP25+Dw3MWkZcbvHALl7njDrwA+bO2SBinGPh5
         asxt7PbSXJkWp7RL1kshG2CLGV01QS9HfkO60sqIbQXQaEfyzyesod5qvshbxkqu0INP
         SMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679578489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo6P5WDnhoMfi3lKTlvIX6M6cZHaujHpVvQIbrEWH0Y=;
        b=WYLdaPZbSJeWn37kjLFZ/luGBZCu5p7pak5TPOu1utMShWbLcr8SSkIWs89Q+UmpZ5
         uimCdb/0vih5veTMVyWV2emQCglFdXby7V5bqmKIC6CT8KVzKWh0kAZ2hvylDpzIz/Wn
         QHw/e2fCfxjyJaeElsRpkzn/ed6zKxC98sQI0s3ZMSWIL6FXWQFq29rqJjlb9gCspXcN
         i2/Ob4GCXoyCWcYW28GkQHxXChFIXCSJdy/QGiCVK43QTi4iqcztU8w9NqdsFZ+M0bQx
         5PBCPPV/t/ELisxPa+E7Rpiul0ccEarCA48nT7D6IWm4ohVycwdsuW93IeNMiaANo0wy
         Da5w==
X-Gm-Message-State: AO0yUKXwwor2kqSaZKDDZ3X+jpjjVdbmQQBizR+sL4QFJSHe1d/Sh7Vx
        /ctvHvjS75M90ii0B4sMNZ4=
X-Google-Smtp-Source: AK7set9alsrOQ0GuGSNJ+hEsgcjZ26COmLBvvu3y32blCStZkGuBrJLqaf/DpmpQy5hOatwdZzCMTw==
X-Received: by 2002:a05:600c:c85:b0:3ea:f883:53ea with SMTP id fj5-20020a05600c0c8500b003eaf88353eamr2485491wmb.7.1679578489513;
        Thu, 23 Mar 2023 06:34:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003ed243222adsm1853621wmi.42.2023.03.23.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:34:49 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:34:43 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
Message-ID: <090ee842-46d0-4f35-bf00-68a3e1393b72@kili.mountain>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com>
 <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
 <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:08:58PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 23 Mar 2023, Julia Lawall wrote:
> 
> >
> >
> > On Thu, 23 Mar 2023, Khadija Kamran wrote:
> >
> > > Fix several cleanup issues reported by checkpatch.pl in module
> > > staging/rtl8192e in file rtllib_rx.c
> >
> > Why is it resent?
> 
> OK, I see, sorry for the noise.

I'm still confused...  :P

regards,
dan carpenter

