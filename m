Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9875F7C85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJGRzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJGRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:55:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924F8F264
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:55:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x6so5176891pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eEBookgeGOBqDvX/bHV7TfcV0gaFIzHe2apW4dv9MDI=;
        b=TW/JuK5D/CRO6j+PDcbQs1bESfBEriykbePNsqqL4JMVD7QYyAtYeIQC2ggN7VzCkK
         /LouAvWqt2xMYfZtky+YHsTE7fJF8c2IViM1Y0RHl0SxjcTvRKf4mfxtwlda+Mq/RsAN
         Af6NI/Qh3tbkv+dAgc2/G1UPOZH7tKRJpSXJ2CQF0lVnU182BcBHdtm5v5a8zixvU/zK
         QAu7bw8MGv5Et6128W5xQ6aXfdGkeLlI5dNJVb4CtuM59kD96XxdQyfbc4WU43kQxISd
         UPAQQVN2+4YHE5AhBIgTntAbFkNa4XrtMFkBVxw46cDy2nTTzD/zoSV5FbXC/y5295JA
         TokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEBookgeGOBqDvX/bHV7TfcV0gaFIzHe2apW4dv9MDI=;
        b=vGv402erhKk4HJV2c+ti7+HQeHelBAs93iPJff3yrG7i4xYL351Jz51ZyOHAhALC50
         6e2yBeTbp8IPP9fKhYpOg5MMFLI1ySKZ8ePFJVWFtAJV5G9i+7cOwVsGtxUXrzrbGH8e
         BUf6mH0j6wcsQ4ZXKwiXRm9lgpmVP/VopeQM5Eo6k/0+t2pmq2RRNEh7csUYly78Ydn+
         GRv+GUZ+m243VOkHK8ggJ95s2jljdkPS7TG+SarsunK+Bsc/rFhnQoeLIzeepa1tcL4R
         yDYNXSgfyWONWIdGHEf1fXzoKnS+pEIFOdK4P6RVtpQzS1DSW90ZmYmqg2QiQ/C+gkjR
         9E7A==
X-Gm-Message-State: ACrzQf3t5JOZeQpgrK1V2E0XKK6tLOgXml8nJQYt559Myy78jQZB4N+b
        ppGiVv7/YjSo9JlXv4GRIKInIg==
X-Google-Smtp-Source: AMsMyM5yUe0jEYWCvBhDIwBM0yeEOLJrElZl9OMctn92bS5SREBd4Ii3ixuU7addmf2s6tABsNnQzQ==
X-Received: by 2002:a17:90a:ae01:b0:20c:2630:528a with SMTP id t1-20020a17090aae0100b0020c2630528amr1832298pjq.37.1665165342074;
        Fri, 07 Oct 2022 10:55:42 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b00562b05c9674sm1904794pfb.130.2022.10.07.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 10:55:41 -0700 (PDT)
Date:   Fri, 7 Oct 2022 17:55:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     wangliangzz@126.com
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangliangzz@inspur.com
Subject: Re: [PATCH] kvm_host.h: fix spelling typo in function declaration
Message-ID: <Y0BoGXj8+iBo3xv4@google.com>
References: <20220920060210.4842-1-wangliangzz@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920060210.4842-1-wangliangzz@126.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022, wangliangzz@126.com wrote:
> From: Wang Liang <wangliangzz@inspur.com>
> 
> Make parameters in function declaration consistent with
> those in function definition for better cscope-ability
> 
> Signed-off-by: Wang Liang <wangliangzz@inspur.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
