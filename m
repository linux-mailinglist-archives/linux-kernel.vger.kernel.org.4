Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E06E14DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDMTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:09:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921987AB3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:09:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f1ffb8ccfso133542397b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681412986; x=1684004986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxEmfRbaPGBG4xTcOle4NNs8xZaFaj6SUpCI6QcOZE=;
        b=EfJBXjoqWE9fgL6w2LFufKhkyBayJKeI9Eam9TM7bUvYFtgTht80zGAcUXHSvaHJKx
         687CXBkQdSR3umjs/d3rYGJWW4hlH0zfYE3TAokRj6mc9++o9GraXcRPmgQ0p+s6YwUB
         SuddqmnidpgIpg9AdAW8A0Lw2mq0UnrX2jdqI/j18ghl9fcrJSfIrwZrkOpfUQSdqurd
         JH2vs74D4QwwETVLue08hVSX4gIYDb8dxqeR567hO157IsNO/JMoQ/VggQxOsZFzCH0E
         3hWZAmehV5ROf2IvhV/VoOGVXwikbf3ZkN0xHC+1Ih4Yhnl353QNrjuULv/IYD7lSpFS
         S7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681412986; x=1684004986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxEmfRbaPGBG4xTcOle4NNs8xZaFaj6SUpCI6QcOZE=;
        b=g4v9wKzeO8BmcngCG3pnNicUVJ94cVUh6iCrrMC4nG4QbzTOtaPHBjfj2wRtzxRIgl
         8d/RzduBZC6Tn+AlF1iL+TJum4tbP1ACh3mqGrkAYDN4CjXvY3W6ExyDH5J8zWac6HtH
         c/Mf1NZdEPaZP4o/fXqZuQGGX1WbCK6B+NK9IhDW/0A6JnA3quyfblmz+u/JTYB4hgUV
         D04lYjZq9T8CvdrTXosNJ8TKrsr0EcXe5LxXJK+/cGfyoGRUe2sGOjYCHZdhTezAIWTZ
         LSdASRjnzf7TQnU2n9I18B/yyX9Jvj+IOpaD3MCc9BYbK58pX1Aj5Dgdyu+lmmjTKC02
         NtoQ==
X-Gm-Message-State: AAQBX9fYrgmowR5M2agz9vzv7s5ERvrHV76LGqNUMA8PzGOQk8XWWG8f
        kq+SvecH1H2Sk+PGXWbx9+kFOirPHsA=
X-Google-Smtp-Source: AKy350ZUWa/zrIdpGrk3bcqiUdqbJeatjAfoqJF0+bOQmwOBxI0wvdh6ylLbB5QhKoXBwjU3GntOUvGGrvA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:450c:0:b0:54f:96bb:3683 with SMTP id
 s12-20020a81450c000000b0054f96bb3683mr2029655ywa.1.1681412985923; Thu, 13 Apr
 2023 12:09:45 -0700 (PDT)
Date:   Thu, 13 Apr 2023 12:09:44 -0700
In-Reply-To: <ZDg6w+1v4e/uRDfF@google.com>
Mime-Version: 1.0
References: <20230227171751.1211786-1-jpiotrowski@linux.microsoft.com>
 <ZAd2MRNLw1JAXmOf@google.com> <959c5bce-beb5-b463-7158-33fc4a4f910c@linux.microsoft.com>
 <ZDSa9Bbqvh0btgQo@google.com> <ecd3d8de-859b-e5dd-c3bf-ea9c3c0aac60@linux.microsoft.com>
 <ZDWEgXM/UILjPGiG@google.com> <61d131da-7239-6aae-753f-2eb4f1b84c24@linux.microsoft.com>
 <ZDg6w+1v4e/uRDfF@google.com>
Message-ID: <ZDhTeIXRdcXDaD54@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable TDP MMU when running on Hyper-V
From:   Sean Christopherson <seanjc@google.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023, Sean Christopherson wrote:
> Aha!  Idea.  There are _at most_ 4 possible roots the TDP MMU can encounter.
> 4-level non-SMM, 4-level SMM, 5-level non-SMM, and 5-level SMM.  I.e. not keeping
> inactive roots on a per-VM basis is just monumentally stupid.

One correction: there are 6 possible roots:

  1. 4-level !SMM !guest_mode (i.e. not nested)
  2. 4-level SMM !guest_mode
  3. 5-level !SMM !guest_mode
  4. 5-level SMM !guest_mode
  5. 4-level !SMM guest_mode
  6. 5-level !SMM guest_mode

I forgot that KVM still uses the TDP MMU when running L2 if L1 doesn't enable
EPT/TDP, i.e. if L1 is using shadow paging for L2.  But that really doesn't change
anything as each vCPU can already track 4 roots, i.e. userspace can saturate all
6 roots anyways.  And in practice, no sane VMM will create a VM with both 4-level
and 5-level roots (KVM keys off of guest.MAXPHYADDR for the TDP root level).
