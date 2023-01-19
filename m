Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7073674406
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjASVKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjASVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C43A1038
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:02:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso3571496ybq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=scpZoOFWPDXUVrlHPKgK5QZ1SbAZUb5y22SB5Of5htE=;
        b=W6sWGyehGPZsspIZx2IM5SMylimpyKjrgNPTzzEoSl3NUzlfZH9FSJeFXrln2mUPph
         CJEZMcp3Vbx3zx0i7aqbTjei/I4rV+kCUJJwQQRUpShtslHOxlTsLW9E0l/ohVtp+2qV
         9siwTLYvZ2Vzb/T5ujr3AiPU9a4gKd8GHX72+TjU8xH1Kjaj/Gx8KXRrjyOXp0iDeNU7
         cREeSZ6AQYADhL6rvL3nv+QjSbyNtOwBywztxzUAd10O9ny3v5Mj8LisX5kiDLd6p8Pw
         DO6Ic8pO2q2QgCGEJJxX7khKFDswKyptsogbEJoCtR/w6WpMhq8mpeae4FQ9edfLKR2K
         1Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scpZoOFWPDXUVrlHPKgK5QZ1SbAZUb5y22SB5Of5htE=;
        b=uz8BtMNHQ7ws4JuubgacsHL89l5hgHAPm60TaoS5B8LKPhO91oJmdqJhf3zfJ+OVrG
         QGOd0X8uPfF9bw0sytIHAYxezs5twsBLTkAFx9fpVEyzctXpSsPQ4M9J274Z0pMCRtmT
         R3WV9n5rKhOgAT57Uw0zOHgdyoIodfVV2iwk9HTRg+K7/bHOPNnvKpUio6Klo38MFJwu
         Yl9HSfFyPfXYCYkCcJVlxcEkDls84V3zlqWsPZmYiK3dzCNqRqTux9ZJadtm/oP+5ZfK
         QKpoojZHomdJVWq51xbP71CfC2HGaxyTxBKrHnlzl0jhZLGEhupGdU19rLw0eJ8ThGmB
         fAPQ==
X-Gm-Message-State: AFqh2koMxDEZiCl90shbcVuVRZAIpHGUaHizuHrmH24S2SDhq/75kU83
        zht9sKz1LD+fyrCPxmef8b5/8ETLQ5o=
X-Google-Smtp-Source: AMrXdXsE32CWcwVxtHXXLXVs0hIW1J0kAMsXcmb72zVb8TZvSzCoV2nQAMqH0gfE4ILu2Nv8as3dQ5QULdA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c183:0:b0:7b9:3ca:612f with SMTP id
 r125-20020a25c183000000b007b903ca612fmr1026905ybf.23.1674162176229; Thu, 19
 Jan 2023 13:02:56 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:01:27 +0000
In-Reply-To: <202212191432274558936@zte.com.cn>
Mime-Version: 1.0
References: <202212191432274558936@zte.com.cn>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167409107087.2376475.13987745798229035037.b4-ty@google.com>
Subject: Re: [PATCH linux-next] KVM: x86/xen: Remove unneeded semicolon
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        zhang.songyi@zte.com.cn
Cc:     shuah@kernel.org, dwmw@amazon.co.uk, paul@xen.org,
        like.xu.linux@gmail.com, coltonlewis@google.com, mhal@rbox.co,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 19 Dec 2022 14:32:27 +0800, zhang.songyi@zte.com.cn wrote:
> The semicolon after the "}" is unneeded.
> 
> 

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: x86/xen: Remove unneeded semicolon
      https://github.com/kvm-x86/linux/commit/c3d538f9145c

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
