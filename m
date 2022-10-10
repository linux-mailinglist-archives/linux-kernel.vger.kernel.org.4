Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7755FA3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJJTKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:10:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB305A8BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:10:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f140so11563486pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5BpwJeooaNqLb0o57KkHofFKyfb+8Mur+oZp67XkDo=;
        b=Wrj2Hh11MKBW6vnDlZKz+Wjo2Lf7S9XTYS+JIfUB/BIOR2jY1eywKt5ne37CyMo7p4
         wSqp6hUGuB5ZWXriuNdgQTmx778C16S9e94qZLfM8WczxsUkk4t+qEWJamh0+cjRHDqG
         oGxbsc/7bFb4pHdQn+pmASw7Ix2z3YkHLEw1cKjXcS1qXuGob7o4Ay+7morkaYqCJYC5
         +6KzTMXR0AKFNFitgGveCz5JXbOM2mYuyfnQNpElb2lcKbmaXI4DBo/u904IrpLQnEMt
         in5fKTS1NJlcWTTU1zVNFiqiytrv8JeSUrO6l9NpnfXT8jE0GcIad7+4dHzKArsKm/Te
         F3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5BpwJeooaNqLb0o57KkHofFKyfb+8Mur+oZp67XkDo=;
        b=n+/CZH1YUyYSsyex64QSeGkGHPjHC5R7tzfOpqAZ3OYbGQuby1EGGM63Qv+Pz3Kwt9
         K9madPHjawq/d5MANudViJHz/d6AmoDI2wYjtbimr7pFzJ8w/FQH5Mj2eWeMitFnhz0C
         upK60f5Vz/+CKByjgQG31YzTt6QP7qB0J1MpCC2Fc5RryEgoBIgdaBvqV++RClEI//UY
         MsNyI67BvpTvlPXRnn3+uCXJ30hziXLJrnXjdFffqlF/dLBM6E6s9NySJ2g9JIUE85Ic
         SF9DhqoH0gkhv5VMrSWiChCPUsPgIig0mxd9s6ERewucYIIXSm6euDt1BOi9CWRcSWxX
         UETQ==
X-Gm-Message-State: ACrzQf0D9uhU3+1NcSgdnvH77L8CUEjYQRObg7AxOnlXfDB1wOkTeo85
        Vjh3kYCzPdtR3HRjD/p2wt1bkA==
X-Google-Smtp-Source: AMsMyM50uZVscSHU6tPxPPEAG+/ig4eDnOeNl640kaomo5gFOjwQytA9YTk58OIjZ5UYi+jOftnFIw==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr20817517pfb.43.1665429015045;
        Mon, 10 Oct 2022 12:10:15 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b00176683cde9bsm6989045pls.294.2022.10.10.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:10:14 -0700 (PDT)
Date:   Mon, 10 Oct 2022 19:10:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jun Miao <jun.miao@intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: Align two spacebar after period key in annotation
Message-ID: <Y0RuE2fDAkjVpZE1@google.com>
References: <20221010074052.72197-1-jun.miao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010074052.72197-1-jun.miao@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022, Jun Miao wrote:
> After you hit the period key, you'd hit the spacebar twice in a line.
> A little change in annotation does not affect code.

I'm a firm believer in two spaces after a period and think one-spacers are
misguided heathens, but I'd prefer not to fix up existing comments.  IMO the potential
for unnecessary conflicts with in-flight development isn't worth the almost negligible
benefits.  And unless checkpatch complains about using a single space, which it
currently does not, there's zero chance we'll be able to enforce this the preferred
KVM style.
