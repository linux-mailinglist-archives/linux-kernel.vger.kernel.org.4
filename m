Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8F6DAEE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbjDGOhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDGOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:37:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E07A6EB7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:37:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id c2-20020a170903234200b001a0aecba4e1so24412987plh.16
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680878272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EwAMOSvWuuwRSNJO5ZSdr/2f2DfQGzc1eG+hKypIp4=;
        b=WjN4KNyY0Wp7LdDdLA6dLmhjkc6qQZflpUdRC+sLqOT1ejDVl/h0ZB6Tmz22bWSoyd
         SQFGBIBVhTTMArZmaUaaTOo8+EAq1bu1KIDQJFABQQ1bRlhURlz1jASWJyLLKysSDRI8
         nuATGhfSVn7QSTW5n+zd3MihWaxCTp31Vm3oT3iMSEaxh2w2HoOr5StPSMGO1lE9mzFd
         s7kebEBG+cVzTnHvsldADj+aN94oV6sPqdwVnE46exttGjGTsDRPZeB5WN8cu+dkrap+
         8D3To06woowy82vMmR0lTyS82Elin9JJuMDsb+1Kq1cqLlssJJP9uZL9JT3bKADgCQyf
         a7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680878272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EwAMOSvWuuwRSNJO5ZSdr/2f2DfQGzc1eG+hKypIp4=;
        b=RkyH3p2+D0VWOoE9kqvTG8J/Z6vn0vpQMRCi63mmnXxwT5FxaPlWfPQfdf6NOHB7Wg
         /ahwVg4GQfUQEqthQQOM7zc56m6Z1dbtvbYil/r2/AC2AdOaIIqKRG7/nYEJmBtAue80
         Hofyx8FSodPFEdNwnVuA2/v716jhTmx6symbe3DjMQtgTpe9SxW+T7WTKWLqHyRwT5Zc
         yr6sPJ7K3WBu3i3RsRdi74Po0sCUwE+JMAKWUt2eemSUhkW7WbW96gn/P/U6U6ycN7hb
         INc+o1Xo8ewruL0avKCyDhC9CuRq1HxSUp+WPH5Rsuy9N/kZN9vwxgDbHHGn4QSjFE0D
         kQPw==
X-Gm-Message-State: AAQBX9cnQ3Y2OgK76Nvkf9F2zauSwcBZW9Jem6xMlAMH3xDHebqrFp6p
        BOccfunKzypQs9vacLRyNmwjklsz/NU=
X-Google-Smtp-Source: AKy350a/8THxQSb2D0BIt2HszEXg8D/pIxoaIL3MPoOkRezNC4zYbJoii46ZiQblx+HPftOhwMrSzr3GeLY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2cb:b0:1a2:401f:6dae with SMTP id
 n11-20020a170902d2cb00b001a2401f6daemr920418plc.4.1680878271830; Fri, 07 Apr
 2023 07:37:51 -0700 (PDT)
Date:   Fri, 7 Apr 2023 07:37:50 -0700
In-Reply-To: <7c57fa4e-de52-867f-6ad9-1afa705245cc@gmail.com>
Mime-Version: 1.0
References: <20230310113349.31799-1-likexu@tencent.com> <7c57fa4e-de52-867f-6ad9-1afa705245cc@gmail.com>
Message-ID: <ZDAqvvH/Ag8TBIhR@google.com>
Subject: Re: [PATCH v2] KVM: x86/pmu/misc: Fix a typo on kvm_pmu_request_counter_reprogam()
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023, Like Xu wrote:
> Sean, would you pick this up ?

Heh, ya, this one and Aaron's series are sitting in my local tree, just didn't
quite get to 'em yesterday.
