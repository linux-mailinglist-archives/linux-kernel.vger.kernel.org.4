Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A329A74BC67
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGHGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGHGnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:43:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269251FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:43:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-783549ef058so97349239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688798582; x=1691390582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXbxOrtc/7HExwdEy81ap1KW/6Wb6IjSa8/lqjdTN7k=;
        b=bbNkaqu94bD3Z8Q3ops5q4L6MtwCeLvnWqk7bN2rYslLjjWTN77P7FrkdA6+Tf2RS8
         2jupOVYIpsmJFoS9kjbZKQBcIIyY1PBUn+FQcE7QPyjcvo4kMbi32ozLIUHHI5/AREJH
         BR77pXtBNSoLbeOmDsY/xwXGx+R6Ve7TPw8QzuiT2LNae19i05vUpnQ+Ltul4zPIOul/
         dnqrGI0TqoLxXkOhFGaTHfgKVIlzsu8ajkBCmHGFV8n8ZWE5VYp67Mk/Bhmo+lFClVsA
         fVzQMAAUF8cWQDGUPoKTf1UXQK9ITrhL8n5HN5vA00yTgQ1j2dSWFK82uzjGz9NIqtz/
         iD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688798582; x=1691390582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXbxOrtc/7HExwdEy81ap1KW/6Wb6IjSa8/lqjdTN7k=;
        b=kw1/tFAXg/swcrvVmj5cOrZHEC474WG9Q/6GRkMW5CEdBVe4aweFfEfROryhjaVNtf
         2wLMsb63xoa20kf9EFQaZ81JWcmMbi3+ADNS5QFI8jFeLZLSxeNxTQCGul5UoKykCk7t
         Nc0fuSy8Cvenw5xXBQEGu8SU17NyJ+Cx0p/dDX7jYNhFEEhB8K+vtEtk9tCVRWSG4GAg
         tImhyZHZVzTLnBMnld86EcGFwxdCkeUTKPMI5kQQM5y+fVrAoDqXd0VLJ+ZUHhAWLH6p
         HAMSUNtPoPU+jdAefQzzjb4StXtps6fPnLEMRF8m92DIhWb0c6iFLa5wsXKLhD0XPBR8
         a8WQ==
X-Gm-Message-State: ABy/qLbJcQs8u1W6u7VVrjb/oW1eyBr3JZGOsqj42Z79guE8HJ647CYz
        mVZmZTmc4cpvuukOMH71euA=
X-Google-Smtp-Source: APBJJlF9GgTcKPdXZXqu1n+r10Z6nI6NKh+tsarmEYMX+VBnwQEtjev1lE+nuiaEL6y2wlVb0BL+GQ==
X-Received: by 2002:a05:6602:642:b0:786:2498:40f0 with SMTP id d2-20020a056602064200b00786249840f0mr8507275iox.10.1688798582264;
        Fri, 07 Jul 2023 23:43:02 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id g3-20020a632003000000b0053031f7a367sm3736170pgg.85.2023.07.07.23.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 23:43:01 -0700 (PDT)
Date:   Sat, 8 Jul 2023 12:12:56 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: Re: [PATCH 0/4] Trivial code cleanup patches
Message-ID: <ZKkFcMCGFhD5Q1WU@zephyrusG14>
References: <cover.1688299890.git.yogi.kernel@gmail.com>
 <8e53be9b-8b47-597d-1538-95733eb16cac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e53be9b-8b47-597d-1538-95733eb16cac@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 05:30:27PM +0200, Philipp Hortmann wrote:
> On 7/2/23 14:14, Yogesh Hegde wrote:
> > Rename variables in function _rtl92e_dm_check_rate_adaptive
> > to avoid checkpatch complains.
> > 
> > The patches are required to be applied in sequence.
> > 
> > Yogesh Hegde (4):
> >    staging: rtl8192e: Rename variable currentRATR
> >    staging: rtl8192e: Rename variable targetRATR
> >    staging: rtl8192e: Rename variable LowRSSIThreshForRA
> >    staging: rtl8192e: Rename variable HighRSSIThreshForRA
> > 
> >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 38 +++++++++++-----------
> >   1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> 
> Please use the "staging: rtl8192e:" also for the cover letter in the subject
> for the next patch series you are sending.
Ack. Will keep in mind for next patch series. 
> 
> 
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Thanks 
Yogesh 
