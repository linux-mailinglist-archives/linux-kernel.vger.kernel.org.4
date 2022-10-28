Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7358610FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJ1La2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJ1LaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:30:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901A85B70A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:30:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso4205621pjc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu+lIBqvdWX/8opgIO5TCCOvdjg6GfRL6HZjYwfiOzc=;
        b=KFdR4DrR4ZOHgalVT1ZZZrYTnZc2T3Qy3ciD2uuPVHkcSjQ4oL1D4Rf1eiub+pAGWC
         /tWIGLcYkwUahSp514zz4CKbcYhV98oOhJntKtlyKlJmpoUDovKaNz4QMOhTx9CO7PY5
         TLMjcqafDfsimAbPNjrOdsQhllqBzDHZ4t4cZAvxCUQQ2H+bUar16qV/ywySARZwQhtk
         5BchDQZs2qbzLZ/mCpBaXyIn78Hli9583C+G5VXTLrr65bnIjXteahFNbjemB2dxgfrr
         AlsvXwG0w0dTKu/1u6w+ZVCmwBrEaW22ysWCzY+3chrun+iIZ7XfFSrqPR6vu394uNmG
         HgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yu+lIBqvdWX/8opgIO5TCCOvdjg6GfRL6HZjYwfiOzc=;
        b=fe1VAjD3xsivZ2KHdtl1nAQQJ+MdhgcjuYzXxkmEYQ9QnvY0788U6H/PO5YwxQGp5d
         gji2tqMPy53rXA1gGzohihNLggBIr/RZaC3SIJb/qL2mWgXBOc8BR6PWo9uy42WFEkN8
         wotQY1ouy55Mu4TVzmf7ih148SFLZsGKjfYZQ3bVXEm7ONXvFqXO8D/AkhAXo3oBQReT
         aanaKe90FcWMoHQhwC+/+BYDftUuUowYQpp1yEZi/CS56ls+g+wyCEEVeEapopa47s4S
         dEXd+QYoWXX4VQ6ipEf0+E71/wHSwYLL0d8SMo3W1AwgkV43nCek70vMJpSVZa9oyFH/
         pZfA==
X-Gm-Message-State: ACrzQf3ueDHduCO40jPDqVFR6LfUUIe8rmYLgYT3BE1TG1ixjWeYQQH1
        z3wRIdgla6vFbT3TTdONgU2g40ch/+Ui4BSJor0=
X-Google-Smtp-Source: AMsMyM78SSAtnLdbtKdor8s7MCj57w7asd8Oeq+/c/3nSYohGh3Pn5ZGCN3s5zFgegQ4JpI3LtufmA==
X-Received: by 2002:a17:90b:1e4d:b0:212:c6f4:2cff with SMTP id pi13-20020a17090b1e4d00b00212c6f42cffmr16010896pjb.240.1666956619278;
        Fri, 28 Oct 2022 04:30:19 -0700 (PDT)
Received: from [10.54.24.49] ([143.92.118.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b00186b1bfbe79sm2832282pln.66.2022.10.28.04.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:30:18 -0700 (PDT)
Message-ID: <adb7418c-39a2-6202-970a-a039ad8201dd@shopee.com>
Date:   Fri, 28 Oct 2022 19:29:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup: Simplify code in css_set_move_task
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221020074701.84326-1-haifeng.xu@shopee.com>
 <20221027080558.GA23269@blackbody.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20221027080558.GA23269@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/27 16:05, Michal Koutný wrote:
> Hello.
> 
> On Thu, Oct 20, 2022 at 07:47:01AM +0000, "haifeng.xu" <haifeng.xu@shopee.com> wrote:
>> -	lockdep_assert_held(&css_set_lock);
>> +	if (!cset || cset is either getting the first task or losing the last(cset))
>> +		return;
> 
> 1) the guard should be css_set_populated() ^ populated (when unsetting
> the populated trait)
> 
> 2) I'd keep the lockdep_assert_held() after it anyway.
> 
> Also the commit message should explain what's the reason to move
> css_set_populated() after css_set_move_task().
> 
> 
> Thanks,
> Michal
Hi, Michal.

1) If calls 'css_set_update_populated' , the cset is either getting the
first task or losing the last. There is a need to update the populated
state of the cset only when 'css_set_populated' returns false.
In other words, the last has been deleted from from_cset and the first
hasn't been added to to_cset yet.

2) Thanks for your suggestion. I'll keep 'lockdep_assert_held'.

3) In order to update the populated state of to_cset the same way
from_cset does, 'css_set_update_populated' is also invoked during the
process of moving a task to to_cset.

Thanks,
Haifeng
