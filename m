Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F9691D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjBJKrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBJKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:47:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D9125A0;
        Fri, 10 Feb 2023 02:47:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so3314999pjk.3;
        Fri, 10 Feb 2023 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvehYTPeuUM5Am2E6/a7muiarf4wb5jQnalQjw+cOcY=;
        b=VXDJTV2Z7zbRz82QDs2SKroei+8LYsA7VvcXZZWCLu0+Iv3SCgo+z9j5ElunCmqzRn
         L3kZ77rG5xA5maWmEFji5A85CjllEjLzFZnsfeRsUo83OHTgwqEsOh5MMnLdrI/XsBsE
         ojVegOa07U93S3yIJw7JqvMvFfg4l7lN6ZfRKrMSWcRuid0dpE4ihYXCeJjl35bL3noc
         fmVHfXTn+wyaNGwaDB7kfr4Gf3aU8FU+ugNrscRKO4x2aYvy5UWWeoHJn+g1RPzYzgQI
         tAkNkuOodEJf2xogymxH0of5WiGc7xW9BtJEYLbyhbdUzhcPKottEAZiGvTZKyiKOvsT
         H0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvehYTPeuUM5Am2E6/a7muiarf4wb5jQnalQjw+cOcY=;
        b=x3s3zwJVZ740t6b66EOBsqn/AhZCki137j/1rdbSQJlZkNQTk687mraxQxP5jhTpzl
         SXy4T+y3IkpN0zocuvSTQDWLMgb16SN1MO/JDwq6hq26utK2o8JSZIj3paF2y3RuuD6K
         yg+k4THBlnAVpt+TmW0vK07FM1BkK4oj/vso/+2GbTpyUHFiDl3tYctWNs6lWDN/+lgd
         /OGGSrJcoqOBmUkbycGyAOHX/qjXxrxtkDB8tSyC/ImFxU24I3pu+pF6GS1EVxdUhRwx
         eXhJZ6cyGVGBYwmtcL+o5Ll98J6NSif+MHJ5kYTC2FiZWRDElgv72icLG3MMK2MGzFjp
         gatw==
X-Gm-Message-State: AO0yUKVfsgv9sKPj1e8YphLO1hqHEJ/qNDk7rB03Qx4DgCbxc/WSXldA
        24/0k+BrBhSDoCinHDjaf3U=
X-Google-Smtp-Source: AK7set81T3BDNBEApadm+EW4Z+NOVcI0V4eQAURICV1NuEohYTsOswJDA31F5HGjw5z9F9nSElV4ug==
X-Received: by 2002:a17:902:e385:b0:199:4d57:639e with SMTP id g5-20020a170902e38500b001994d57639emr6908632ple.50.1676026072018;
        Fri, 10 Feb 2023 02:47:52 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b0019909279001sm3110988plk.79.2023.02.10.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:47:51 -0800 (PST)
Date:   Fri, 10 Feb 2023 21:47:37 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Subject: Re: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel
 Macs
Message-ID: <20230210214737.2ef942c6@redecorated-mbp>
In-Reply-To: <57D52CFB-228D-4071-94CB-D32883BF872A@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
        <CAHp75VcPPDTmpx9jpu3ZoaVH_xBgtaEbDQcJJdqcaXi1J+_q0A@mail.gmail.com>
        <57D52CFB-228D-4071-94CB-D32883BF872A@live.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 10:41:07 +0000
Aditya Garg <gargaditya08@live.com> wrote:

> > 
> > Quick observation. Do you miss the Co-developed-by: tags in the
> > patches?  
> 
> Most of the changes are minor in the 1st and 2nd patch, we haven't
> changed most of the code. The changes were written as per the
> documentation given in
> https://www.kernel.org/doc/html/latest/maintainer/modifying-patches.html
> 
> Do you think a Co-developed-by is still required?
> 
> The third patch was actually written by 2 people, so there is a
> Co-developed-by there.
> 

To add onto this, for patches 1 and 2, as we haven't been able to
contact the original author (Ronald), I think the only ways we are
allowed to make changes are either doing them in separate patches, or
with the [name <email>: changes] tags. For the latter I thought you had
to do a Signed-off-by after it, but given the changes aren't just to
make the patch apply on a newer version, do you think the
Co-developed-by tag is also needed?

> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko  
> 

