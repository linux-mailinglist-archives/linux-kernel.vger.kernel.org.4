Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68279712B84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjEZRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjEZRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:13:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55B9E55;
        Fri, 26 May 2023 10:13:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53063897412so895232a12.0;
        Fri, 26 May 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685121195; x=1687713195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlQHkKnfhl85SPjjrArwZ6AQVNhnLN/Xet9CRnwYrw0=;
        b=A3Lh+N6fJO0IkjxwSqXx7EAW/qC9140wcOLmB3/aiO24+t5FtzDfFse4NueeariLTI
         WJPzAS/1qFrbRR0T8+J9w2diOuCZMgPBSxi/FA+c2ceI9a53XnyIUbsiTNH/kJbD9J6E
         2JqnHb+BX/gWS94rsRSYkqsghnNilSDYiiSvjbmgRn+D98CRl2sR4kgSS3WqReag53cX
         AFMbdMAt1xjwYP0wI+Ri+GuqFt+2VbXyaojKkSzDcvzysSR/8ZxF1C0BhE56A43BJXKs
         jMEYQ8QAkGGUiJmXYUfQh1HfGzdsUFx3vU/lNv05AG6fQdt2Nr22iwp9csmda84/k548
         IR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121195; x=1687713195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlQHkKnfhl85SPjjrArwZ6AQVNhnLN/Xet9CRnwYrw0=;
        b=VoWCe0v6eGcn+e2klM/J1m9qngwVCHDgVjnfy1IdzZV4O4KolhmBXKdYgV6hNXPjKk
         gp565uhiO1rAxRQiR3nQEYNgxhXcX+DjSLDJg7R9LzWjDaaIBeYQfBza5p92qmmWOfsp
         Of6RivO6f1/dJ8ii/Uj+IcPOj/cDFg/WhWqx7CX3RKZaVlHTNghdYChEYtR4I1il75e8
         K3NiVs2upnhbGAEww6SVQsB/Ya/VVRzFuBSDWXP0nIARkCqEg55h7Kj0kiowDuFAlwKH
         hoGjkLUP+fp0hBK30iQK8LvjnzZenqginIwi2RqVGZOo9MS6ewnQ4TOQ2E4fmWf6ZJdq
         LLYw==
X-Gm-Message-State: AC+VfDzL/uVPMS35pmd0eoNUheK51zfR6F+uddTV3zq4NKkkKPefKLFv
        xEZDbWpZGNhqKNHsatJiF0s=
X-Google-Smtp-Source: ACHHUZ6z6YWhk46iYE/hP6ucChzj5Ph/02XwIeeQgx1zna6CPOkm/MJbWgn5imibuH81foXcpOhvHw==
X-Received: by 2002:a17:903:228a:b0:1ae:536c:3d9c with SMTP id b10-20020a170903228a00b001ae536c3d9cmr3777231plh.37.1685121194707;
        Fri, 26 May 2023 10:13:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001afccb29d69sm3491115plc.303.2023.05.26.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:13:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 26 May 2023 10:13:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Noah Wang <noahwang.wang@outlook.com>
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: mp2891: add MP2891 driver
Message-ID: <c22c8d90-b26a-44db-9930-25f9d4a180fe@roeck-us.net>
References: <TYZPR03MB7130A7F41D61BFB611DDF0C7FA479@TYZPR03MB7130.apcprd03.prod.outlook.com>
 <44cf26ec-172d-41a8-a700-4b1e3307200b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44cf26ec-172d-41a8-a700-4b1e3307200b@roeck-us.net>
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

On Fri, May 26, 2023 at 09:23:12AM -0700, Guenter Roeck wrote:
[ ... ]
> 
> The above functions really do not make any sense whatsoever, meaning I do
> not trust that any of the remaining functions are needed either. Please
> only provide necessary private functions. For each function which is
> actually needed please explain why the core function can not be used.
> 
> Note that access to the datasheet would help me to determine which of
> those functions are really needed. Requiring me to create an account
> just to read a non-descriptive one-page "datasheet" doesn't help at all
> (and, FWIW, is really pointless).
> 

Adding to that: An internal source with access to the datasheet stated
that almost all registers/command would be standard, and that only VID
handling would be special. Even for that I am not sure if that is really
correct, and that the VID stepping is so far out of standard VID coding
that it can't be modeled as standard VID stepping. As such, I am not
inclined to accept a driver which re-implements pretty much all telemetry
registers without some very specific and confirmable information that
and why this is really needed. A vague reference to the datasheet won't
help, sorry.

Guenter
