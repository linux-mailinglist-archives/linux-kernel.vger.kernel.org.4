Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7C656DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiL0RxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiL0RxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:53:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE101C759
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:53:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m3so895383wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZzZ/QJbRn7TOeAAIV3KQRWsgtBtMBco9ePlVLB1l30=;
        b=G8UXRMzdI6ydln3mGp5eem0XqHWVdHRwW/iXOjIoM5j6r9eyCnDILncr+EvVhrmEEe
         6Q0EkbdzDHTryN1W1mPSBOr9nveWhsdd8HjbU3XiQ4IjcamO+RdKgGxjdM4GECyIlXz9
         Op3qGN7AcMiVaiwUo/rn5gyjwRku5PQ9WW2LS4qSO6inBi1EZGOiqNK1z7odKYxYnEuK
         ypsyMUuCbV91nSORVwrdWJHomCACflmlS28ewx4WYXlCwkHH3nkJiXI0qpGGROETOTBg
         PjOTwhcX95CEiWWsyvUWtoqIzPBoHrG63Aq5sCQAEXPs+ZBlrn6/DBK00cFgXyqiK2i3
         OB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZzZ/QJbRn7TOeAAIV3KQRWsgtBtMBco9ePlVLB1l30=;
        b=Qmw3Cg2bqvRamCQ6gKMI0O2u80LYSrueGMdQvWYJyxOyJB5y3apvdcZyftJdK8mbZX
         Fvbvw3Kp+epKENLan1WhCUE3pQGHFB6xJ3MFJ6uPZGTSCC8A0Up5/iWrEFehjwjV3TSR
         vNFwy0vkyX4VJe53VnixteI7Ezembw6AHn1t5PS89eEhk2KYuicmxG0O4A44lbdrH/At
         RvaCm3UhH0OkWxf7OqcYdTZ65uoI/+Oi9Wl4g173z955Sm0PmY+1NyOmO76j7tqP3PC9
         +iK0bvY/3nsS4VXFpPeLFandKh0U2HAIIK3Ji2BuD1rT3jcjuLnMrrk/fgrpSd7tw5tV
         nrcg==
X-Gm-Message-State: AFqh2kpTU3m2RX71Bqw5PjO69jbRESMv0koasVbkhgqjZdpcDS4WEpZP
        EdktgM6m+nohk5hVlKBd+NI=
X-Google-Smtp-Source: AMrXdXvMwHVyXAZfTEVYodAYctJ737yL6wSOJKd5uRm2xai8dA6ZUxa/HfCj3cfFrcQJvmzwpevNxg==
X-Received: by 2002:a05:600c:1e10:b0:3d1:f496:e25f with SMTP id ay16-20020a05600c1e1000b003d1f496e25fmr16801903wmb.16.1672163594291;
        Tue, 27 Dec 2022 09:53:14 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003d1d5a83b2esm23837336wmq.35.2022.12.27.09.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 09:53:13 -0800 (PST)
Date:   Tue, 27 Dec 2022 20:53:10 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, oe-kbuild@lists.linux.dev,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing
 error code? 'ret'
Message-ID: <Y6sxBlhUPLsmBEI5@kadam>
References: <202212222333.vrYfUBqM-lkp@intel.com>
 <20221223154754.GA30339@lst.de>
 <594b768a-9311-da86-1619-5435d3f720f5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594b768a-9311-da86-1619-5435d3f720f5@grimberg.me>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2022 at 12:36:07PM +0200, Sagi Grimberg wrote:
> Although I think that for this specific report, we should do a simple
> fix and then make the code look better.

It turned out the code worked fine as-is.  It just wasn't clear.

regards,
dan carpenter

