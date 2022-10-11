Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0E5FBA18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJKSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:05:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1CBFE6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:04:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r17so33141803eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETa5U6KaROJwkg59mQUai3oA9ltBPunhs0v0qUZxk8I=;
        b=dqGJODTRAdmT8j3Vpo4S9bC4XSgILD+3IpfmMRQNm1gJjsS6OqjV8MnUkRP+qcnx3n
         Pr75Ta5VAVHZffbnZHS4aK1lCnkw/XahdQt30Ac7t8AoU2NaH/hOE6V2+h+hWRRGvveR
         6G/vqe0ouAkngeA2cSM4afQyWtgSJv/mLMbTHviJDU6SNlsSXRoT/4N1vFnd4fZR+gJv
         /n7vg8IjOu6kTZBMBI3cQBIAcGBDTVHcCuli+BKYnlZnZFDedHLVBrKCD04J1ZEqhYYu
         chqun1uQJHve0E9qiHhYEfSSGzKNGAfccmwwyd+AUpz13TPBBwALt42K2giSsDWEyvyp
         OjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETa5U6KaROJwkg59mQUai3oA9ltBPunhs0v0qUZxk8I=;
        b=T+BSeolKrokrBzvw2hBUrCDed6JhOH7N23zHVmcAKI30IERsZubxq7R5jbDxn7pI2e
         3BXCqkh2KwwMHy/9FMCOw6ExSTkvUZMeXjzpGCA0UCiN0jQ7T1yXufGwOI0qWDdnqo98
         Qt3Be+JfDVWZJoec5qHJZMDHtY7fTwdgfAA6sC54obILHh1USyTONEKRLJRUO7tkNqRT
         EbSCok6zyUV3P7XqTCS/NTGrjotS9GssHQyZEr+Nzi4+ejwNOpmv0w7q4/l73DZJSHHH
         WdlMuTu0z6zGjhge+0FQw7642aNuJ7Ou0veimp7OKHuEyxqByDCmU+N8nrQB73vjvoFs
         zCWA==
X-Gm-Message-State: ACrzQf1ttQVZLNCPalbE3OHuqJSGNPUtrSPgYOuDt6cXaCspVYSZaLVY
        B3eC94zmddYd2tLXTgUeXBjBMg==
X-Google-Smtp-Source: AMsMyM7UrKWs6iLL7RoQLqvH3qbD5dRbe4B9w+o648Kf3nU4zEo5wnYTzuW6AUC1beHNqj7NCpk+Pw==
X-Received: by 2002:a17:906:8461:b0:78d:dd76:5695 with SMTP id hx1-20020a170906846100b0078ddd765695mr3314638ejc.583.1665511483750;
        Tue, 11 Oct 2022 11:04:43 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id la6-20020a170907780600b007030c97ae62sm28932ejc.191.2022.10.11.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:04:43 -0700 (PDT)
Date:   Tue, 11 Oct 2022 20:04:42 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, lkp@lists.01.org,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [oliver.sang@intel.com: [cpumask] b9a7ecc71f:
 WARNING:at_include/linux/cpumask.h:#__is_kernel_percpu_address]
Message-ID: <20221011180442.cwjtcvjioias3qt6@kamzik>
References: <YzeclACdH9JmaRza@yury-laptop>
 <CAHk-=wiK5wyj58x3uvt+otsO9=79N13OO6Nf57DFVYO=QX==ig@mail.gmail.com>
 <Yzh19JhBMzkMr4+L@yury-laptop>
 <20221011170949.upxk3tcfcwnkytwm@kamzik>
 <Y0Wk0WD6CL4aFEIi@yury-laptop>
 <Y0Wmj+XnyD/c6XM3@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0Wmj+XnyD/c6XM3@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:23:27AM -0700, Yury Norov wrote:
> On Tue, Oct 11, 2022 at 10:16:03AM -0700, Yury Norov wrote:
> > > Hi Yury,
> > > 
> > > I just wanted to report that the warning fires when doing
> > > 'cat /proc/cpuinfo' on at least x86 and riscv. I don't think
> > > those are false positives. I'm guessing a patch should be
> > > something like the following diff. If you haven't already
> > > addressed this and I'm not off in left field, then I guess
> > > we should integrate it into your series.
> > > 
> > > Thanks,
> > > drew
> >  
> > Hi Andrew,
> > 
> > Can you please send it as a patch with a description?
> 
> Also, can you describe why we'd silence the warning this way?
> If the cpu number greater than nr_cpu_ids comes from upper layer,
> we quite probably should investigate what happens there...

Darn, I fired off the patches before reading this. I didn't try to
completely digest seq_read_iter(), but on a quick look I think the
reason is that it implements something like

  p = start();
  while (1) {
     p = next();
     if (!p)
         break;
     show();
  }
  stop();

where cpuinfo's operators are

 start()
 {
    *pos = cpumask_next(*pos - 1, cpu_online_mask);
    if (*pos < nr_cpu_ids)
        return ...;
    return NULL;
 }

 next()
 {
   (*pos)++;
   return start(..., pos);
 }

So the justification for the patches the way I've written them is
that I think we just need to return NULL from start / next when
we've gone too far, before we first warn and then return NULL.

Thanks,
drew
