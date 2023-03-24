Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B76C895D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCXXhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjCXXhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:37:20 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2996312CD2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:37:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id m12-20020a62f20c000000b0062612a76a08so1664864pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679701022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+BJi54U0cmiUHoWXHQzl0xPiOaPcA8Tmmek78k7nC0=;
        b=DK9Ah+gQ4AHjZizsWS6hZn22cxoOChaz9yL0sYmaVA8CI/Igw5yKJrin2rJezaSNJC
         4riaqrV7SD/jpl3P0onjeXE9TgkhCZhrcaSQiIPptBaoL9IAIDXGF2+aTp34TrnDKD+e
         ENs+7N9w9qH0hQSZUK7v2ORWv6PePruA841mD5r4YZZzRvZE2kSj1X7nyncVCsw1nrPM
         JoiOe2Q+7IoBnZ526RiaN6JoOvdF1HKT2RvfdFFADB4wvpR8h3UB58GpNxV3bMoLTHye
         VWSAGukLHGGe4Qn8g39NIzM6IBLXglb+eggv1UpdmahS8RvtH9jK2g8XXuJJNZfBQqrh
         w1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+BJi54U0cmiUHoWXHQzl0xPiOaPcA8Tmmek78k7nC0=;
        b=Ecbvy5KbrA8ZnHVGW83xp0UYPw2sNAAGQWTnOxz1xGZ8wf1cEhL7G/jMekIAO56FZu
         osVd8Z5rqKOC8dnOmohlvW9DpobymnfqhaDiRBlzttWalKtpOe7chaalAODDa6+GxmFc
         iaJfnzCyAJ+5y1plV/Nk2x9qm5B7XbnddXdi3zIF8WJ9B43uhEx3x1zx/ps6uRYfKh7b
         7ZTrGC8H0Jo9bvgS8wPkvb1UeGUXSB2hDS2ftWBoRZ8ai7iTa0v2qgzxtZarCHl19XU5
         HvbC0jlg27JLWa7b0gcFuwhIfL0gQv0DX3oW/Itcutt1nrE9d+iCyGv2KOZ+bWFaAkej
         9Eaw==
X-Gm-Message-State: AAQBX9dRRXyENfSoBS7BVMPeTKZjNAYE9v6mxaCzzei0p8JXfaYo9ETl
        hYxk2MF/SYwZbuFa0Mwl9IV+yRrkAqg=
X-Google-Smtp-Source: AKy350ZfgixPvBRUEyfab6W97rcYv6yYxHQUo/MV8CsklYh7JiEmQEicV9gESAGH9hDr+4awxZU7sDoseGw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:bb97:b0:1a1:ffc5:1e8d with SMTP id
 m23-20020a170902bb9700b001a1ffc51e8dmr1453284pls.3.1679701022677; Fri, 24 Mar
 2023 16:37:02 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:35:51 -0700
In-Reply-To: <20230220034910.11024-1-shahuang@redhat.com>
Mime-Version: 1.0
References: <20230220034910.11024-1-shahuang@redhat.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167969119815.2754691.17747317733864412835.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Add the missed title format
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Shaoqin Huang <shahuang@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 11:49:09 +0800, Shaoqin Huang wrote:
> The 7.18 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 now is not a title, make it
> as a title to keep the format consistent.
> 
> 

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Add the missed title format
      https://github.com/kvm-x86/linux/commit/752b8a9b4d98

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
