Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312247098BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjESNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjESNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:51:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD3AA;
        Fri, 19 May 2023 06:51:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d247a023aso1258275b3a.2;
        Fri, 19 May 2023 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684504283; x=1687096283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JirfnVW2dTWOvcnPY33ZgtCH0wIw4sqn6ZM8GQJVvM=;
        b=MUKbXhrdvcAgbWTxU3rWEonCZcrkRI1yh2VV58PXCHrDBmdTMv8uiP3I1DXxiXcBYG
         xRwU2OTzCcHyqrSetYHINshFs/zzbDhW272pBENQPXJ8tF42f3J4OJaNdSXcwa1Pfswu
         3F4lygVHUUAkeykmWsvRy53i6oqx8nbf4sc9YjsAmClXn0WIEeiE54L6nCSbNp7dyolR
         ZvFNFiXli/IvBQ2Ym9co3jb3Ls5V2gRLnDp/9enpTq8ROMZJAauPXxGYkzXdOue1y+vt
         6BdbuKqE0uZCFvvhMM4csyONhpUaKNb9gguaZQ8Jhn+O/iqHnh/dmJU8X7ksk9AHExni
         3VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504283; x=1687096283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JirfnVW2dTWOvcnPY33ZgtCH0wIw4sqn6ZM8GQJVvM=;
        b=b/BXHU+0UT89uvKhQJL10wBXKkyPvJ/cej1xmhngeuJDSegDGOjRcC3ls8hTXaBf+N
         mDijkRgqCEw+eQwqcc2GP6DFkDy8b3c6FDd3/NT9AZ0gWpl6SZjflyBVz7DMay7jbtFd
         gbn2rbITzQsP3x5Epkt3qtLqxRZ8bdPpZ5EKo+zvQdxo619aOdMNZzwrtVU18VOvYGrY
         4NfBj6mT/Bo2bGR1VAHOqoj4E8my4Ce92GcXaPMyD6PMIfmxi6zCzNrx41sAvGB7OTDw
         B0yh7XVxu2pSnoh8rouvxtYDCggB3uRkk0UJB8J+XfidHtdJM7Lda37NcjYThu+GMfyX
         R1oQ==
X-Gm-Message-State: AC+VfDyhljkOafmcY8zZq5IEHCrTk58S/6EGB+pJfqUJQ4l8NcEbaGt5
        O2eHdfEnnFBW6Zjb9mq0/vw=
X-Google-Smtp-Source: ACHHUZ6aMAeEb6qxdd4T44b+xX8D3II76yLaxqP1I0eqrW7ZeNkS6+TR8rrU5fvgdpfR9OGxbA/Wgw==
X-Received: by 2002:a05:6a20:394b:b0:103:d538:5e94 with SMTP id r11-20020a056a20394b00b00103d5385e94mr2531091pzg.12.1684504283434;
        Fri, 19 May 2023 06:51:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z4-20020aa791c4000000b0064caa2b06e9sm3025186pfa.167.2023.05.19.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:51:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 May 2023 06:51:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     llyyr <llyyr.public@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Message-ID: <ca6da82a-c535-4d31-9657-01c6327c870a@roeck-us.net>
References: <20230517042025.16942-1-llyyr.public@gmail.com>
 <f7b24380-cbb1-410b-9507-006c142c41b0@roeck-us.net>
 <bac9f57b-7a4e-40a2-5006-9074109a50d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac9f57b-7a4e-40a2-5006-9074109a50d0@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 07:16:53PM +0530, llyyr wrote:
> On 5/19/23 18:23, Guenter Roeck wrote:
> > On Wed, May 17, 2023 at 09:50:25AM +0530, Gopal Prasad wrote:
> > > From: llyyr <llyyr.public@gmail.com>
> > > 
> > 
> > The above is still wrong. Never mind, I fixed that.
> 
> I wasn't sure about it, but I checked and I'm pretty sure pseudonyms are
> allowed [1]. Is the problem here that my online handle not have a first name
> and a last name part?
> 
> * https://www.kernel.org/doc/html/v6.3/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> 

"... using a known identity (sorry, no anonymous contributions.) "
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Are you making that up ?

Guenter
