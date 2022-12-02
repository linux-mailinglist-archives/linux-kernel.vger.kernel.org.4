Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F463FDA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiLBBdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiLBBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:33:25 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BCCF788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:33:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c7so172636pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oregonstate-edu.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coXRMGLEnULR4Px2kIXW9NT/uHpoi7n2zoCrf9vdf78=;
        b=wTlAV1kXsfqE2xmIbJjVCKqEY1ddxhtAC6UP3xApmsb2QY7hJeZwOjoJ8sjp/1ADTv
         q5LwWIP3od3ojw3n/VuoXt8Oxk3q1oTAS4uWaMNegFrGSnWIIbzLEK887fq7+VmOntZk
         udZyr2bK4VRKzOTBuRevRDO/zwSjfjhu8o7SZ18e0Thq6o2VEL30ZkaSrh5L19KF7Uzv
         YFPbeixjF+6LgoqiaWRqyP5eEprIOiknjBg101Q8u+LjdoT52rG/a8NxL5Dwig1UhHQE
         wtqhxUElUpFbRthRdryeJraXGEtbF+aCKs7BUC8vw20vks9mJzsLS8MGkby6hOVwEp3F
         bGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coXRMGLEnULR4Px2kIXW9NT/uHpoi7n2zoCrf9vdf78=;
        b=xH+AvDOAWkUlE2pjgQ6SpzdKKX6QMdr6jlCRKsMAIOZXzBy3RGVlNbRqH5BZ1VeRQD
         7AGxHzm34203oiG7/i4fB1JT0EGGNmO8LSJld4BjfgjkMRo8F4xoe6weUUAxEJeLQ1E7
         ZaG8af5iyL5dQeiFp7/9Q8wF2pzThZSVtD65or6uPpVPquh5p2rNxrnKi2B6+dcCTEeK
         /gDcAtnB60QzmTCJ/WNyyXEG5HRaffrQSbcERxBj4aUgD6xh2gu6iGCpg154I/nngoRL
         y8RjrvrekfeRS9DJlD+SMebgIOBjrvS04M7tDVyJuQXfVNojD9GRCUPxVkMXL/2dmHH/
         pYVg==
X-Gm-Message-State: ANoB5pnPjXyu/NCwWXpRsbNdIXZbPogI5i8n6J8Vc6hIUAy3OpWgmmog
        U2pPE6qSVQWJhIFiu9c5JST8iQsbp8dgtcsf07k=
X-Google-Smtp-Source: AA0mqf737okP2UI9PkpWbPqWCTRqB3u2oaPJpG8WqZLZ9K+my1/OGPvy+nFPzcrFgteV6seCrUAfCA==
X-Received: by 2002:a05:6a02:20a:b0:477:cce0:28f8 with SMTP id bh10-20020a056a02020a00b00477cce028f8mr33832799pgb.89.1669944802839;
        Thu, 01 Dec 2022 17:33:22 -0800 (PST)
Received: from ubu ([76.27.231.73])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902b71200b0018990ba4985sm4270708pls.272.2022.12.01.17.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:33:22 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:33:21 -0800
From:   Jack Schofield <schofija@oregonstate.edu>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: greybus: Cleanups in loopback_test
Message-ID: <20221202013321.GB5097@ubu>
References: <cover.1669872193.git.schofija@oregonstate.edu>
 <Y4hU8oC7H5h6G2ZI@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4hU8oC7H5h6G2ZI@hovoldconsulting.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 08:17:06AM +0100, Johan Hovold wrote:
> On Wed, Nov 30, 2022 at 09:38:49PM -0800, Jack Schofield wrote:
> >   staging: greybus: loopback_test: Add blank line after declaration.
> 
> Nit: no need for a full stop in the commit summary.
> 
> Other than that, all of these look good to me:
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

Thank you for the review. I've realized I've left off maintainers and
will revise and resend, with correct maintainers and the correction you
suggest.

Jack Schofield
