Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE137278EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjFHHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjFHHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:38:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CDA1BDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:38:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b18474cbb6so1015785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686209931; x=1688801931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4c10xINaZk3zkvGR2qh4gks80MlmOsa3Cftwgec9Mk=;
        b=IFqs2V6jVzqst1fg75pvcNNdwOM+CQLePTiaSPr9y7U+i518QlsGxYBHaONZtdhwql
         IAmzimfKOucyw42Kq6aoWhWEeBmvPPKneMrVxIo3go2Sl/Y+MjrkndQ2Ryb/PurF3u+r
         XRzkM+A+PtEbEX2XtZI9Hj+fWFzEc6kzEmgBYdC3YcmI2wFZ+NKUpZL15ZgFW+NUfVRb
         kgVJml+/pOZoGB+NwdsrFQwk5cdnpVVykbV3ZnbhsnSVFKAijlgcHf0/ll+5fIhj5l70
         l3WQQ8eEUn4qznYg8NanhirB4Xx51epDwFoi7yYYwvhzxiHEUSB046VlAxaxRDI9qGqP
         b8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686209931; x=1688801931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t4c10xINaZk3zkvGR2qh4gks80MlmOsa3Cftwgec9Mk=;
        b=UT1ADThd4LdvWXD7Vhnr4PIKFM6qlf8kGiktqUB2zQu1KTkoqqGZJSviT5sPbqEQCH
         7/TTPXgX9EptQ4CF9cqNePtUR3puhaUPy2YVwv6YeOsiWJ1toKVxG43+u4pK1TQO9ig6
         WSb9gWAd2ioy2xwSxDFqSP2qRepIDV0GYitybik1TOnd9mIJSP0yiUiWNd8eiz77olZj
         EkLPNt5jJrcX4airgC2EqUCW0jZUp9QJwZxgUY21e4GuhO/ryWXTSFzucQNzi9zQfWQk
         T15GXeeRJDfX5oQh2fgRU48NQObtMO2dU2gD6qiewrvBxWEnKnEUeoDm6xpIULh61u7m
         CYpQ==
X-Gm-Message-State: AC+VfDzmbCFbdUtaLgBniJ7s2TAlDoywgewoCoVv9+T6pDxSkd09UtK/
        /OtLpQHb7ENQVY34x3Uc+MXqqUoedAM8R3DVJBE/iw==
X-Google-Smtp-Source: ACHHUZ4eZ2clfiTJ4i6Erls5cwly7HgZSvTWAjOgDhPPs+vxBT8O5brwPV1eHfWs4gxpNV+tHA/kcQ==
X-Received: by 2002:a17:903:11d1:b0:1b2:49f6:6cdb with SMTP id q17-20020a17090311d100b001b249f66cdbmr4051465plh.37.1686209931239;
        Thu, 08 Jun 2023 00:38:51 -0700 (PDT)
Received: from [10.54.24.10] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001b176ba9f17sm749831plg.149.2023.06.08.00.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:38:50 -0700 (PDT)
Message-ID: <34f32148-24c3-09a3-8bec-9515139e15b1@shopee.com>
Date:   Thu, 8 Jun 2023 15:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
 <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
 <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/7 18:22, David Hildenbrand wrote:
> On 07.06.23 12:16, Michal Hocko wrote:
>> On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
>>> If freesize is less than dma_reserve, print warning message to report
>>> this case.
>>
>> Why?
> 
> I'd like to second that question, and add
> 
> a) Did you run into that scenario?
> b) What can an admin do in that case with that error messages?

In theory，dma_reserve shouldn't exceed freesize, so the error messages can remind us
to verify whether the configuration of reserved memory is correct.

> 
> If it reveals a buggy situation, maybe a WARN_ON_ONCE() is warranted ... but maybe only if anybody actually ran into that issue.
> 
