Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13C5F0280
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiI3CAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiI3CAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:00:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E9C34C9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:00:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so2943320pjr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4/ab8BYv2AidX31kl8PumGWwMuGpRG2q/otkt7COkmg=;
        b=mU1beNcqiH7b5gUXbFMc5nG0nEKui3AttDV+145oRJ2QDrvvA3dVNlvMR8e99OY70v
         JBOVb/vD7I7WztaJOAaGJ3z50adHGUbh7vYiKBDZ2CzD02ZG6d3cFzPmbIlHzPECwktI
         /WPHiidN0rl2BUgTAXoGdZN1T+tPKIKfFfGXWDzsolQMmRd1Av9DszE93Nx1nlYy0Wjq
         A/aaxJgnTGF4O1rU9D8c5Wp2h2lxal9n3loZ1MRPfc/VE+FAIoc9uftbVk/QrAc55mso
         F+T8xXZc9N3peKkr3lzzXNR8YAdzZ27Kh1ii6sSYsbSAjznCm0s6hyZfv0Tgkq86ajiy
         gK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4/ab8BYv2AidX31kl8PumGWwMuGpRG2q/otkt7COkmg=;
        b=j7T1BATUFLfbNP2BlJDmXHnX/GMwk0jn7idKIuidfxN2as4kVgmJ8QRdh/floEjfPh
         IGIuZ97jYC4x1IMS8qniwjd6CgJk4iswiNMEOxiA+lLV1f0RTgKER5f0wnEydGZvw2i4
         kS5K3w41+GbZDlYWEu6Wk+9YXWlbDXntNZsW/e9+e0RnnnacPQuqVh5vo8T1iH9UDkOS
         GShL8/Wdrk4m/99N2enyzQxWoe1ubujrSkBtrjYqpfHgQCS23X8T9D+KVPvkgsSZ+/Fc
         mn2mJlBYNdzyG55JqQhs7DgETQplf+PNz/Jw7SiirSxUUAPCEIcciUtjNa/qIdKnlVWO
         a1YA==
X-Gm-Message-State: ACrzQf02gJpbAoJfoRBpNjaFN+CU3iGGbJorBj+D5wI/xdy0yKw+7jnA
        FMnW5u7HiVyTFf6dIBmqQqM=
X-Google-Smtp-Source: AMsMyM6jFlIQYSVdLHFBaTTZjNsObnlMFdv+1/xXFszvcj+XbBDLPzVaI5d4kskPdjEs44/raEPTng==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr19765597pjb.167.1664503236535;
        Thu, 29 Sep 2022 19:00:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a7-20020aa794a7000000b0053818255880sm362090pfl.193.2022.09.29.19.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:00:36 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     imbrenda@linux.ibm.com, david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
Subject: Reply:[PATCH 0/3] ksm: fix incorrect count of merged pages when enabling use_zero_pages
Date:   Fri, 30 Sep 2022 02:00:32 +0000
Message-Id: <20220930020032.286941-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929135100.5efe6229@p-imbrenda>
References: <20220929135100.5efe6229@p-imbrenda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> On 29.09.22 12:42, Claudio Imbrenda wrote:
>> > On Thu, 29 Sep 2022 02:52:06 +0000
>> > xu.xin.sc@gmail.com wrote:
>> >   
>> >> From: xu xin <xu.xin16@zte.com.cn>
>> >>
>> >> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
>> >> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
>> >> after enabling use_zero_pages, all empty pages that are merged with
>> >> kernel zero page are not counted in pages_sharing or pages_shared.  
>> > 
>> > that's because those pages are not shared between different processes.  
>> 
>> They are probably the most shared pages between processes in the kernel. 
>
>shared from the kernel, though, not from other processes (that's what I
>meant)
>
>> They are simply not KSM pages, that's what makes accounting tricky here.
>
>exactly. and those pages get shared all the time even without KSM, so
>why care about those now?
>
>does it make a difference why a page is a zero page?

WI's necessary to show these sharing zeros pages. Because:

1) Turning on/off use_zero_pages shouldn't make it so not transparent with the
   sharing zero pages. When administrators enable KSM and turn on use_zero_pages,
   if much memory increases due to zero pages sharing but they don't know the
   reasons compared to turning off use_zero_pages, isn't it confusing?

2) If no need to let users know how many full-zero-filled pages are merged by KSM
   due to use_zero_pages, then also no need to show pages_sharing and pages_shared
   to users. Besides, the description of pages_sharing in Documentation is wrong and
   MISLEADING when enabling use_zero_pages.

3) As David supposes, it also help for estimating memory demands when each and every
   shared page could get unshared.
>
>> 
>> >   
>> >> That is because the rmap_items of these ksm zero pages are not
>> >> appended to The Stable Tree of KSM.
>> >>
>> >> We need to add the count of empty pages to let users know how many empty
>> >> pages are merged with kernel zero page(s).  
>> > 
>> > why?
>> > 
>> > do you need to know how many untouched zero pages a process has?
>> > 
>> > does it make a difference if the zero page is really untouched or if it
>> > was touched in the past but it is now zero?  
>> 
>> I'd also like to understand the rationale. Is it about estimating memory 
>> demands when each and every shared page could get unshared?
>> 
>
