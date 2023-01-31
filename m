Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360CC68350A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAaST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:19:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C13D0A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:18:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id dr8so22624477ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2SQFNshp+niAV6ZWs0KnsP1NDdpFWrEbjuiVeSvzcaU=;
        b=RIrWdl9tEMcArKzyN+RgfkJBfsJOzolJQ6xJotRxrMAP77835kNylEL8XOMhCUGmva
         hBSZzgy3CMPyn1zbiWCe+lDLe9jx9SiU41CzSZmeART5OH4/jzdXAKkQvebO0Qu8HSoB
         GEN4UaiHWiQvJG6zHoXxggNXEm2u/dhHLTzDa50t/th+tDkoDQ3IcxpCi/HI4aU508pb
         exf+HQ1XQMiEE/GOz6raOHd37V8TwambRGkQ+NnFCPWk+B5PLgVxjH8Zk1gijEsMRdSa
         rbFeMBUbhqEW+hQHR/WkGQCxGPQH0pQcgSKPjpmAosepKc8fY5bcJ5b6zk4JCoRYZ9KG
         POKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SQFNshp+niAV6ZWs0KnsP1NDdpFWrEbjuiVeSvzcaU=;
        b=eV/bxlHcu4s/ZL+KifaRHxb+UxKxj2NAiPYLM3LWBYjE9ItJDbrN6JQlyVpHoGEfEs
         GAV2ZQchXajIxayq9KUC/iXv2f2mxWOVzJ9tKwKnaEk/pgK2Jm3GO0tFGA0CfHlk60Ly
         Hv22jfE+o2NnKVF9Z5gfMCBY/2JQM8ZabFLAK38TVuIgFbWEj72aWbt0MflMGCU29jTj
         49lvjCrQE/5y4KNo3G6CcYgGpW484g0Bnr/LfIXhgl+waAqaM6cZI8un3ewH2wEWXeD4
         8lSqnViH+oXqHeKUmITOsBk3L5po+rIjj55i4YumK339vzPtnW1CdiKcHFyTODC79+ro
         48UA==
X-Gm-Message-State: AO0yUKWnrMSI44Asc4ED8PjzBdemjj5usi70OK4HLBwDErnkMg0AjXl4
        kIIB/lOuR5Z2pbYVviuR7G8=
X-Google-Smtp-Source: AK7set91ZIDRCD70YQC3RlYcXitaYcuYNmN9kgoIQ50Yt8skiHE+1SAtE8yAqG3jy0D+X//XykcIKw==
X-Received: by 2002:a17:906:31d1:b0:879:2a5:dc40 with SMTP id f17-20020a17090631d100b0087902a5dc40mr17140250ejf.76.1675189134022;
        Tue, 31 Jan 2023 10:18:54 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (gw.combine.ideon.se. [85.235.7.115])
        by smtp.gmail.com with ESMTPSA id jz6-20020a17090775e600b00880dbd4b6d4sm6174613ejc.136.2023.01.31.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:18:53 -0800 (PST)
Date:   Tue, 31 Jan 2023 19:18:51 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9lbi8TGLmVXudjG@combine-ThinkPad-S1-Yoga>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com>
 <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
 <Y9jwcdYcFQ9f8+mR@kroah.com>
 <Y9jy+f5JpD1NrbZn@combine-ThinkPad-S1-Yoga>
 <Y9j4BI3/ybsaLCfw@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9j4BI3/ybsaLCfw@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:14:12PM +0300, Dan Carpenter wrote:
> On Tue, Jan 31, 2023 at 11:52:41AM +0100, Guru Mehar Rachaputi wrote:
> 
> > I would like to know, if it is mentioned in the TODO, why is it
> > so?
> > 
> 
> If it were as simple as just changing the type, they would have done
> that instead of adding it to the TODO.  :P
> 
> But in fairness the TODO entry is sort of vague and useless.  It should
> say that this configuration stuff needs to be moved to sysfs instead of
> being done through an IOCTL.  The we would need to port the userspace
> tools to use sysfs instead of the IOCTL.  Then we would delete the
> IOCTL.
> 
> https://lore.kernel.org/all/20220118135902.GH1951@kadam/
> 
> If you want to send a patch to update the TODO then you can do that.
> 
> regards,
> dan carpenter
> 
Thanks for your mail.

I have now updated TODO file and submitted as a patch.

-- 
Thanks & Regards,
Guru
