Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E1E720AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjFBU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjFBU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:58:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CADE44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:58:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so3680815a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685739522; x=1688331522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lEOehxHolb8X5C6iXhr+EWaD62m3RLxWc7FOFaBtkZ8=;
        b=dHoGUlGb6XDm2/Otv+ZRHMw+mt1C/1deZYgmb1PbQDWcaUrmU2KmSAc2kc2BTjcEz2
         NVc7Xgvx3W/QvWW+44JfAtHoxd1VbKB7KChHIbhaEnSuiSn2NptrvubUZkLhtXF0Z3N/
         pLFeC99wzH7h4avZxAHDNCaTWNG66rdKwJospxaGXQ66eg+eDbMAFnTfW6PhYM5bIhR+
         bFc1eqdXjHS0/bbevi0iBBmuyG5m+Yg1Sjkc5eXPPCP0MIAziQzo5OPzx7bnJLMuPmAH
         C3m7/33P7BTRIEzOnELysCS3xEzRJY7vIPqDf24y+JQiYVE9kG0cs39LHmSxDbcqGFKO
         JWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685739522; x=1688331522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEOehxHolb8X5C6iXhr+EWaD62m3RLxWc7FOFaBtkZ8=;
        b=ZBoBtm9bmN95Gs/B3RQjbQgm3+ZQjPbOcvdhGIHoz/giW3paErdLlbdf/l5HtWyXkF
         LPNKXuiP0WGo9vcZLC7LZ+7Iy0Cr4pYPFa05mdZVcTXnlO4xwQsurH9Yj/PDGiegt/k2
         4+GJCl7G5So4RcP2BMHhlPPbuQCaH5w8PEMVWSA09m1HzkbuxCp2GMqgKX4pjP1uhjDs
         rWiNRrNNKo8hguD3L/VI8AuOpfcovpADd9rAIBcT8ZBoyVKHUDCCEDftjwZSEc+tHPYd
         zGU03u6qpYcnD9LM1xKl/aSAvP+uHJhxMIIYjxX/38LmD0LWWuajHLCEwc71qQI66IH0
         I0Rw==
X-Gm-Message-State: AC+VfDxy4NMPC4d0JElYOO+rVMMixKZx1LXmzFQKZWfiFv0SKx6Pugw2
        PDirVqermBjREJJPX4/QsYcnsS49QJt0mwn1yzCJkQ==
X-Google-Smtp-Source: ACHHUZ6T+VfpFr7aausPLCtKE/YyzZKqrUzoefeK1VCPalyfhekvDguhrF2kEC0Zgzs2X2kV0gHIegw+Vf9hSLzZ6Sk=
X-Received: by 2002:a17:907:9449:b0:96f:608c:5bdf with SMTP id
 dl9-20020a170907944900b0096f608c5bdfmr11859960ejc.64.1685739521701; Fri, 02
 Jun 2023 13:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230602010550.785722-1-seanjc@google.com> <C8324338-FC07-454E-9A5A-1785141FEAB3@nutanix.com>
 <CALMp9eTtkBL3Fb7Dq60go6CL+zGODNn0TTavr436Q-+=mpVFMA@mail.gmail.com>
In-Reply-To: <CALMp9eTtkBL3Fb7Dq60go6CL+zGODNn0TTavr436Q-+=mpVFMA@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Fri, 2 Jun 2023 13:58:05 -0700
Message-ID: <CAL715WKm4t=y_UZZSZkd2=QPwXL8n-KnWzBS4A-ZJLQaWb0RKQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use cpu_feature_enabled() for PKU instead of #ifdef
To:     Jim Mattson <jmattson@google.com>
Cc:     Jon Kohler <jon@nutanix.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> As we move towards enabling PKRU on the host, due to some customer
> requests, I have to wonder if PKRU-disabled is the norm.
>
> In other words, is this a likely() or unlikely() optimization?

I think it should be likely() as PKU was introduced very early in the
Skylake-SP server cores many years ago. Today I think all recent
client CPUs should have PKU on default if I am not mistaken. So yeah,
adding a likely() probably should help prevent the compiler from
evicting this code chunk to the end of function.

Thanks.
-Mingwei
