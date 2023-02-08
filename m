Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05E268E5E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBHCKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBHCKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:10:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65642BD9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:10:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso16067578ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 18:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcaYRjJfjlH4GHL6h+tH7cqyQSp0ZVtpl/r40PnMKx4=;
        b=TRet/9e/XZz+xsvVeAyV6Gfdtr2jutVkiSa8eZh6iS1I/agy50iqq0ZIbFIIJAKD3W
         qAPOw7t60aRvnAEilm/LDBfDxjyP7XZqoukMll0ma/k/9bR4OSDEXxVKAvlQ2NCx9WsK
         VRKexJSExXD7vKXLpB6p2Qgt7uDSBB3rhipiHMzxGNYTDPeQpvX+gc7kI4tZY3mGMSdd
         ThUOXU7BJgB6PBKc8PJe9VT/EpdmnDpKKjuNlPfz5GqJdzrtMw3aFF4/BxSl0ScCO8AR
         Ew/JxkR2CKMlp/PfTrARqv4JeJHlhLvf2QmkhIqAYXEOLgxD8M4ZOBCoLGyk3KYfumZL
         dEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcaYRjJfjlH4GHL6h+tH7cqyQSp0ZVtpl/r40PnMKx4=;
        b=Q7w2cyrTmc8hrAbrlWjk0C73lD+B6pmJ7DoHlcvCbIy3kyO5ttZC3k8NjTwPqFszD/
         BbEed0Khq0YpA5Is0hf/sX7RDk1idNtL2xkl+OO0vU2cH1fu7QCg5OfJlYtRNKMT+089
         uW8wd1eiUYD/mDulHICdvsKUBaM6MQqbnnr3qK4MRmxefDN5Izeb71p8o4rV3dCe4fX9
         K4+s8fFLp7X5rzD2s8KrXk/3tD0mvDzZwb8KpNsbSmlIWswvnkvlOkFDr1KIrvTvtXWf
         ulWm1u9zg5XKd0OfGeuf9v8dTMgGeQ6zfgwz247WHWfRyjMG/8lb8rSApHTvkLr+in15
         mdMg==
X-Gm-Message-State: AO0yUKUO9ds6bmPCFz0y69/nOwjTfs4OiehSm+Z1UAYVFX5+KKoPLNee
        lTRLRfuHAHsVnGqKvXYfaIAzZdWMZDE=
X-Google-Smtp-Source: AK7set/gLJTh7CidVWnVGmjZJiiL7KbkqKT9k6GyZSCQGCTAeRQYAACXHuSbNt8p74mGDoSicbc6XFkwpZw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8343:0:b0:527:9e24:acc4 with SMTP id
 t64-20020a818343000000b005279e24acc4mr695902ywf.187.1675822210791; Tue, 07
 Feb 2023 18:10:10 -0800 (PST)
Date:   Wed,  8 Feb 2023 02:07:30 +0000
In-Reply-To: <20230202025716.216323-1-shahuang@redhat.com>
Mime-Version: 1.0
References: <20230202025716.216323-1-shahuang@redhat.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <167582135972.455074.6960378545703076467.b4-ty@google.com>
Subject: Re: [PATCH v2] selftests: KVM: Replace optarg with arg in guest_modes_cmdline
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        shahuang@redhat.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023 10:57:15 +0800, shahuang@redhat.com wrote:
> The parameter arg in guest_modes_cmdline not being used now, and the
> optarg should be replaced with arg in guest_modes_cmdline.
> 
> And this is the chance to change strtoul() to atoi_non_negative(), since
> guest mode ID will never be negative.
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] selftests: KVM: Replace optarg with arg in guest_modes_cmdline
      https://github.com/kvm-x86/linux/commit/62f86202d76d

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
