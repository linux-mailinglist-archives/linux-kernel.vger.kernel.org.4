Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750975EFEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiI2UiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2UiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:38:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B1133CB4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:38:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w10so2206612pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZS0vHZ8U5uCLBA4MsBJEK0RLj/l0e90kCXMVhqCQPgc=;
        b=sWVMLeZAa/KXbx4kKJTYzU5K84r9LicA64dUzPnBfYn1inl6oBvvcSjcGZTwXvknIk
         avA7aJRKG4yJQdluQ11Im/oR37eOlVBUhdcGHGyflKZPStedZRchonMYff/C73l/p2h2
         hzvjwyFLpDfOShH+HXzAXRjzGkb8HAhlwAMsWSLkcSXuZwbb7ST1Dhmz+fH88o+KWoAr
         b9aivegH+vaNPMtyPzTQz9d1TWKXc4Oaq59vCv355oCSu6dtBNmiL/KqPgHzLoznsJbK
         CZ4kc9YOIK7uj/cxCRnTTNryq5dAT/kGIfoxjdcxFch8HK/uB2wU0FirKKvRFSO3JNsb
         odgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZS0vHZ8U5uCLBA4MsBJEK0RLj/l0e90kCXMVhqCQPgc=;
        b=wEduslzSICV/xSSA4uiFcG0BHoYfeXp4KsArhGXi2byqF4XUNzgO9yEHKY8jh/T1Su
         BDCznrnT+d7cHf1ppxMIcM2BXhSr3uMb3gLiP8V5hvLrPGY4Jf83hNcVDNrJYtGKWvma
         OTJq+Y1aqPZ0TPvQEfLq+yEShuZ6EKsaXhHPtVTZwinDGyoFPiqDFbbAhe5GJ1pW7MVT
         Tr7AufT8vj/DHgT+1qQZiF4G1jMX99WnUz230+OJwYEApOu3Tdin6UEDygd7OfS37CF0
         UXTka32OBQzynFMePXcb5FzB4secSlOgX+zh+MVuzUi/MQe/157g4yZi5GOWURnTZgHw
         CFtQ==
X-Gm-Message-State: ACrzQf0LylqJdDtMYFMHbu7oWUISXRpVwwI1HTPUsuKYhvc9Y9EytxEm
        PT0TUATHz4G+n1MaVQqAnyQ70JeGTPLtMg==
X-Google-Smtp-Source: AMsMyM6yfTJEVrtlyioBYA8suGN9nd/K7HnbiYQE4Mygy7+6UuM6H0eV/WOiUkTbUobhasS0QgM4Ew==
X-Received: by 2002:a17:902:f550:b0:178:5b6a:3a1c with SMTP id h16-20020a170902f55000b001785b6a3a1cmr5180601plf.36.1664483891034;
        Thu, 29 Sep 2022 13:38:11 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902a71200b00172cb8b97a8sm343960plq.5.2022.09.29.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:38:10 -0700 (PDT)
Date:   Thu, 29 Sep 2022 20:38:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: allow compiling out SMM support
Message-ID: <YzYCL9bvqDeg4HLP@google.com>
References: <20220927152241.194900-1-pbonzini@redhat.com>
 <bd4d7463-a960-3c49-9c56-a8bd5c1ea7f0@maciej.szmigiero.name>
 <56a125ab-f113-56f7-f8cb-de05127c92b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a125ab-f113-56f7-f8cb-de05127c92b7@redhat.com>
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

On Thu, Sep 29, 2022, Paolo Bonzini wrote:
> The two Kconfig entries for SMM and XEN are more for things that you want to
> remove to reduce attack surface than for testing.

Yep, we want to disable SMM to reduce KVM's attack/bug surface.  Any performance
benefits are bonus side effects.
