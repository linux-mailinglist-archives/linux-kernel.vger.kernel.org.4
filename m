Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9C16056C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJTF2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJTF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:28:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA8192BBD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:28:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so19297266pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idaemZJ4csdYQSk5DNwSXmcpzySUvaL6oGtY2A/pmHc=;
        b=bPyjIzfP8NR+KGkFgJtIYT2TRbQoO0X5uDTBkC6qKpQa+6t+BPqZCc6IrFdzL3TM8D
         3voGE7l/kHaG2qYIZxfW0ixOKDyFLYrbKV/YvIA7IfXxXZfShZqRscZ/4+xSdQ9OEoex
         lo5HMIQZtXxUVX9VoUG8SOlajoZ5TajJNjClnfJBWQIGusHVhWUIY9NSzqtBtQ4TJXSN
         ChybBcVm9jNL/MEJrt/ZS5iLKnUdAV/q3Z1px+7iHHL7+cO1KfxLDFDLXrzn3xtFz0uY
         1tKYKxRq/OCN0V7Cmg+y2UYvTpOW1w1iOlELao/FdHCsbUXwPkpDKqzkNr8IAAeZx3sp
         rc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idaemZJ4csdYQSk5DNwSXmcpzySUvaL6oGtY2A/pmHc=;
        b=Etj2TPQLR1zxRxv4GbkXYuAOuu+GMfH7PgkbnrtGxjD0HE1GI0uZMplA1pp+8QWofg
         M4srh5T2s15odyc1D6XWuPzXvmP7Qn70lY4VyfrP0BQFlx7W9CoPQWZTuYFBVWPnQ4LR
         bb0q6h226bjqdSEnVBF0cLmFHim1cGBQ2/arPOdX0170rmESa1TGONSibzoODjKBtbJq
         SvhQp+w41Cy5BX+WgBR9tP1qK0eACHSF4DoFi5p2rJ08opC9eRbnUyVP2XQfVQ6isEHV
         yBrSipqEZkocoAHw2U7CLGRmtiyQ4HtQ6wUKuCBRZeZRL9kYELT3BiaJvgK7LaCoAk8F
         gcFA==
X-Gm-Message-State: ACrzQf3tYyvDBwEDPhwHEE//RqvQceJ3ceTgU030F5ZVaKavLCuiGAb0
        ZEGH/+CVlReRD6lddRjQT94=
X-Google-Smtp-Source: AMsMyM7Ghg0TLaHKU8+0sdAQTVXNr1b0AdUrotXbCxjXB3blG78Ufy8peRucdlv0AdNoEKKqVCIxWA==
X-Received: by 2002:a17:90b:33d0:b0:20d:5edf:8b92 with SMTP id lk16-20020a17090b33d000b0020d5edf8b92mr13865210pjb.117.1666243724769;
        Wed, 19 Oct 2022 22:28:44 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b0017c19d7c89bsm11796630plg.269.2022.10.19.22.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 22:28:44 -0700 (PDT)
Date:   Wed, 19 Oct 2022 22:28:42 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
Message-ID: <Y1DcimyMZwkSDm+C@marshmallow>
References: <cover.1666230736.git.eperi1024@gmail.com>
 <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
 <Y1DVH+UatalfjDN5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1DVH+UatalfjDN5@kroah.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:57:03AM +0200, Greg KH wrote:
> On Wed, Oct 19, 2022 at 07:10:51PM -0700, Emily Peri wrote:
> > Fix the following checkpatch warnings in rtw_ioctl_set:
> > 1) Add missing blankline after declaration
> > 2) Replace spaces used for indent with tab
> > 3) Remove space before tab
> 
> When you have to list the different things you do, you should really
> break that up into individual patches.  This should be 3.
> 
> thanks,
> 
> greg k-h

Thanks greg for the feedback! I got the idea to put them all in the same
patch from the PatchPhilosophy guide, which suggested combining a bunch
of white space corrections into one commit. But, it sounds like I
misinterpreted what the guide was saying. Maybe if there are identical
warnings, such as "trailing white space" in the driver code, could those
corrections go together in a single patch?
