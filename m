Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37C617F43
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKCOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiKCOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:18:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FAE14D0C;
        Thu,  3 Nov 2022 07:17:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so1038264otb.8;
        Thu, 03 Nov 2022 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EitdsXRzGfmz+XIYSw7ljKU8CMo4715fYNhm2adSG7o=;
        b=qfL+gTMBfj9E6+znXpMuosKwDB/HLPxIByRas7WxKQa1SEf0zb/vRtwfFEi33tuFyy
         RsKOYtLImap/odkSiyZ9dMAUIH8gARsid8XZZDLAZIXG7QYrUnIXuLJC3a1/0KoegZy1
         8OG/CaMpkCdIcCfGkM3xJsZJfotymqavlv2beRkE6Yn2/YQStgI/+YhNOgZ5YPZJcNyc
         26nHz4QnyOr9PEsfUuLc7mK1YCzStX7ClDzR4+tmIq3Jqn+B9FTbFGTdUf7bxMUOUcn8
         bDoQw898KeDv0oJHA/XA3+5tjPdrr8rwIcktKba7+1h3QNrnJi1BPyyRVVnBY809Dtxp
         z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EitdsXRzGfmz+XIYSw7ljKU8CMo4715fYNhm2adSG7o=;
        b=6j66W1Tc5YJfZEUxE+jySvHNTGSnUczy/DEJuBzr18EY0I8gUCnf/muzGSrQcdQ7q+
         4WtcnjokkWrSCOtCjC3qifTtRfLJCpOMSa7D0jPs9MAJO5GqUwr6JKzCDgdzOwD/yd7v
         4fQYT+DSCeystG+vuDgMRXHUfIzMEC5j/x11gWD44vhrF3PM6j9hhJAEug0w7YWMdPyb
         EKdA1xjGdHWkxm0cb+1E3uaN5qCHP2Pj4iuiUvlT4R5oEvTi+yXzWuJ7fjQFvGsCdj5C
         OfRKe1bDxhGrqGEquSpLzMuN0l8FJy2V7PgNhVour5cCtDgM/My7wA1Z0LSKxYCxg8ck
         VsVQ==
X-Gm-Message-State: ACrzQf0j3b2mRtbKryTqNJpzdiwhEt0SiI72RU46FatxCfsX6WSMCSU6
        a13XlZ2pcnssewmu5Nw5IXzUTKF9aoA=
X-Google-Smtp-Source: AMsMyM7Hj5KogDtpD8hw4TzbyJCt0WJ4ECSBmXe8HEJrKKOfU3Cv5Bg2ihpnIjHAJb8pUXqyNrgZqQ==
X-Received: by 2002:a9d:60ca:0:b0:66c:30e4:9297 with SMTP id b10-20020a9d60ca000000b0066c30e49297mr15191196otk.150.1667485050636;
        Thu, 03 Nov 2022 07:17:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q143-20020a4a3395000000b0048fb9b6dd70sm279884ooq.0.2022.11.03.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:17:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Nov 2022 07:17:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     wangkailong@jari.cn, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (amc6821) Fix unsigned expression compared with
 zero
Message-ID: <20221103141727.GA145042@roeck-us.net>
References: <1872639a.89.1843b5106aa.Coremail.wangkailong@jari.cn>
 <f699bbba-69e6-2e62-98ed-0482f4c9a900@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f699bbba-69e6-2e62-98ed-0482f4c9a900@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:59:06PM -0700, Randy Dunlap wrote:
> 
> 
> On 11/2/22 19:27, wangkailong@jari.cn wrote:
> > Fix the following coccicheck warning:
> > 
> > drivers/hwmon/amc6821.c:215: WARNING: Unsigned expression compared
> > with zero: reg > 0
> > drivers/hwmon/amc6821.c:228: WARNING: Unsigned expression compared
> > with zero: reg > 0
> > 
> > Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> 
> Hm. IDGI. What's wrong with comparing an unsigned value to > 0?
> I mean, it could be == 0 or > 0.
> Please explain.

I don't get it either. The real problem with this driver is that error
returns from i2c functions are not checked. However, that problem is not
fixed by this patch. That means the patch would change behavior without
fixing the actual problem.

I wonder what kind of (broken) compiler or analyzer produces above errors.
We'll have to watch out for similar broken "fixes".

Guenter
