Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40306743D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjASU7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjASU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:57:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9009C50853
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:56:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso1534782pgs.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zk9KJnE1A7lhWU0C7MvYLc6jOxM08TZgOey6mX4Smzg=;
        b=nZt9DAoZEySVyEixexvzeY38lvyxKBnwTFPIS6nWtSv/gDJqzuRcOmE1P6LbYrR0/9
         sMZh2AlbnvjwttNVqKwF9rbB3NKdBaQdhK23rupYIW7FSZySRmFZxS70/YUb/5DLNuF6
         pclF6GzJuOxf/ZtqzQ5TEnnwgFRf9qJpIa1S37DfeUrm4Jlx8FG6Wswz2JYhQrvuI0XF
         eG7X0nbHKkdsnF89gUHe9qhW2IubGc9N4NsjicAmrOYlNoxpK29tffx3b2eLmHXSwxhy
         j8MuAQ7O/CptGDGXmfX97i7V//eGI0LlAMBS6u1AuFGagyVa4s3wc403tmx2S5QBoVtO
         DICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk9KJnE1A7lhWU0C7MvYLc6jOxM08TZgOey6mX4Smzg=;
        b=7qsWrPlBDO8pKjTaNQciodK7YTE7LSeZXrhoqxGxyj9bgxPvikL4lBswZ/nyLYJVTL
         jQ5rukqY/RY9czLZpBunFAgRBQhgCHmggSOJqVn+V6/yfCNnZg94nX1wCaLgK4iZf5aF
         EnfvuPtDmXX1BojDRupcMoZfqZC0VDQt61tcj5YjgI5v/BNBFxtK57oq7WP9BEmyz2Vl
         vmwJ66wGZPJY7PG2jJyMHW4n7i7ZCziLKc/53bnnICRqMXHptmqjZncfxTWQ1+weo17z
         HHM1pv2tGs5g9zY2K89qHTdreck63itpRrGED95hlDkF2KZ3Z+xsEuXDdbFzkZuqobfh
         mumg==
X-Gm-Message-State: AFqh2kplDdIeK8PO52hWbkGE/4OdPqHNHvDOrvDbACE6eORpOyWHqR8k
        9hP8mgOYkMInqQfB2+i9kyDyMH9+uwM=
X-Google-Smtp-Source: AMrXdXundl4oH8jVJqUdu+8GLuF90NkPKHG4Z3K3JieInSAQW9dS7JqUMEwAjFcydOVRxQjP27p03rJ9uJY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9dc4:0:b0:58d:b0fa:b063 with SMTP id
 g4-20020aa79dc4000000b0058db0fab063mr1102878pfq.73.1674161775011; Thu, 19 Jan
 2023 12:56:15 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:54:06 +0000
In-Reply-To: <20230105100204.6521-1-jiangshanlai@gmail.com>
Mime-Version: 1.0
References: <20230105100204.6521-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167408804665.2363885.5468519542988858072.b4-ty@google.com>
Subject: Re: [PATCH] kvm: x86/mmu: Rename SPTE_TDP_AD_ENABLED_MASK to SPTE_TDP_AD_ENABLED
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023 18:02:03 +0800, Lai Jiangshan wrote:
> SPTE_TDP_AD_ENABLED_MASK, SPTE_TDP_AD_DISABLED_MASK and
> SPTE_TDP_AD_WRPROT_ONLY_MASK are actual value, not mask.
> 
> Remove "MASK" from their names.
> 
> 

Applied to kvm-x86 mmu, thanks!

[1/1] kvm: x86/mmu: Rename SPTE_TDP_AD_ENABLED_MASK to SPTE_TDP_AD_ENABLED
      https://github.com/kvm-x86/linux/commit/6458637fa09a

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
