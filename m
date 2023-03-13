Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E06B7BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCMPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCMPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:18:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64791CAF0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:18:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j11so50155971edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678720705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkKHmqcfbmJH/dgkn01ZifvD9vX4NKoyZbN+sv0bg4g=;
        b=SFCB9GSWjTgriIT2vT1e10gKYkJ42rNvR7IweNASU8StzW8KQpH0KQFUkrnFH0cmpj
         cH8iS83Un5I3Cc63uCV4WQJuOo9sOGO/0FxOFvxwnAMza7htXchBVuZC/fozqb/ksYeO
         TxlW5OsGTea1map2W4LXuIZfh4IWmE4XSQDJ0QuUaEKKjtWW5fIWxhANbBM5OProb3/W
         IL0PbIorMhA8Vmd2fxd/09Fd1seF635Uybmyjss7dHg6k90jeuc+Dvp1jomzo2q5GcCN
         FrU/Z7Wwj9LeQIC9BYGD84JUTB+H+/Z8+qLe0/nhDf8ULTyBMRb275rSDIgLiHyg2P6A
         LnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkKHmqcfbmJH/dgkn01ZifvD9vX4NKoyZbN+sv0bg4g=;
        b=vkMi0vt2OG0+X5Gbs6fPB1Ptw14tOA7lNPXyfiCWNLgylGpiqTkwwP55ZXDjS1b2AO
         BS5FObz9x9X5xQQhO0qkNQ8HMY5VXLnbiT+4Yy6m/35Fiscugc4LTYeEk6kpr/q5nyb3
         hiBYybBHqr9FRVOnZvaxu+CWt48alNnXxY2Ts2hTlKaXuKeB5A3mhuNx1JIOHuxKuJmt
         TWdxlh9xH42GskFHSt8kohscy8kDnZrI3DzAUnjkdZBZxFDQ0tvh30Ku+Kmb5wHfVB/c
         rkAqwpRbKeXPqUNj0f/0mBZI3EAJ4zyKLGT66Cc3DiNGhztp/o0GoNpxnMdqQ4zGJfa1
         m++w==
X-Gm-Message-State: AO0yUKWlIjUKk3am1Kn+6HgErtluSufBp6/fQxkFPVRLO6EmX31DBBr3
        FufIFfMnGGiK7jRXjw/wwyz0jD9MCkX4s+Hh
X-Google-Smtp-Source: AK7set+Awvfu1l6DgJOJxMipMw0IWmFDrqV3siwzDsfGuYnU2syyHJHoky40qbZtpSajQgAxvY1lng==
X-Received: by 2002:a17:906:2d51:b0:8b0:f58c:e87f with SMTP id e17-20020a1709062d5100b008b0f58ce87fmr32879265eji.33.1678720704962;
        Mon, 13 Mar 2023 08:18:24 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id l1-20020a50c101000000b004af5968cb3bsm3384049edf.17.2023.03.13.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:18:24 -0700 (PDT)
Date:   Mon, 13 Mar 2023 20:18:20 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: axis-fifo: initialize read_timeout and
 write_timeout once in probe function
Message-ID: <ZA8+vC0e6EUdm9q/@khadija-virtual-machine>
References: <ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine>
 <9938109.ZD9C4EEAuf@suse>
 <ZA83yzPTq+nQF9Dd@khadija-virtual-machine>
 <f545dc88-717b-4fa0-851a-733dd5fc2eff@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f545dc88-717b-4fa0-851a-733dd5fc2eff@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 06:04:45PM +0300, Dan Carpenter wrote:
> On Mon, Mar 13, 2023 at 07:48:43PM +0500, Khadija Kamran wrote:
> > Also, I had one question. Is it okay to write a long subject as I have
> > used in this patch?
> 
> People say subject should be 50 chars (I forget the exact limit) but
> there is a little bit of flexibility.  This subject is too long though.
> Perhaps I would use something like:
> 
> [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
>

Thanks Dan,
I am going to use this for the next patch  O:)

> regards,
> dan carpenter
> 
