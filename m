Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAE69FB78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBVSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjBVSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:51:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B10F3C18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:51:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a545bfbaso102690837b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqEECA7T14uUEIASP+IpGDgg85ZCOvdRmhNcjI3Iles=;
        b=qFu2nZFTrTIDgiui6Mnc8nAfWXy3MGuClnECitY08YuGQQb9v6QJj0VhQlA1Hne1PX
         jwbFjOAh23hL3XupWMXZLLCXKP4THYXpwTr42U1/q1g/QQfC4G2UWmMJyoEBLapf31zr
         9fMEjCBZJjzx/JmpivZXbiOKlQHgUAMx6sN9r3/FCL+Jj7XJGZLGZQ97FlgwMMVBEVNM
         9fIitAEtjpeHnK+4ww/FLrj3EscM62WsIQie3jEK2g6DQO1Xip7pL3Yng35IBOv/bAxe
         x4u6XdkQANWQh3E7/i3BPLdBdEkQDUHrPuK+JE1eZA6241r6sMUD9BLBydK2LBAn6kE5
         6Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqEECA7T14uUEIASP+IpGDgg85ZCOvdRmhNcjI3Iles=;
        b=EdPCd1AsqXWGUvdQ8zTcGRJsrPJjkL3DpVja2faw1y/BXLHORME2yzB9Yrh8JjjA0w
         4DlvP0TmJejcr673YXDOSAMAkCSeLL4b4QbsoZ0QU/X/2vbEOBPTFC/YW+Yn496+QlAp
         ilTB+FnpGr35c+IR8DQIT/+3JfWw0i1gxuQc9a9hOlTwVh0uUaCiX3aa2woiXFvRH4F2
         c2zUKZUO+csvx5d5ONzbzB03fXIHmoJfSoXKMKCdj18o3AKBfCZyCllqTpRP94kepada
         MsHcYcQkO7igRkgaouX+sKDxAKFFkQVuYMvTzGiVENGyaJO5kEr4kHiu4lBDeZCWGAbz
         9Wvg==
X-Gm-Message-State: AO0yUKUD/THWVn9pBIoC87CsVgMpj/c3xW7o/EfQswJgCDosqrKVCPZb
        8iqmkuW7RtRYGj0fs028vS/3KqQIaRM=
X-Google-Smtp-Source: AK7set+8IP+LPPuvRfdebQR1ad4tDs9Va9qipjTvwoCKkZH0ygi5W3DkzGpQdJCQHMTdaByTbpW1nzgLFfc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1:b0:a27:40c4:e12c with SMTP id
 l1-20020a056902000100b00a2740c4e12cmr54899ybh.2.1677091898129; Wed, 22 Feb
 2023 10:51:38 -0800 (PST)
Date:   Wed, 22 Feb 2023 10:51:36 -0800
In-Reply-To: <20230220034910.11024-1-shahuang@redhat.com>
Mime-Version: 1.0
References: <20230220034910.11024-1-shahuang@redhat.com>
Message-ID: <Y/ZkOFL0O5szHsYP@google.com>
Subject: Re: [PATCH] KVM: Add the missed title format
From:   Sean Christopherson <seanjc@google.com>
To:     Shaoqin Huang <shahuang@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 20, 2023, Shaoqin Huang wrote:
> The 7.18 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 now is not a title, make it
> as a title to keep the format consistent.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

Looks like it simply got missed by the ReST conversion.

Fixes: 106ee47dc633 ("docs: kvm: Convert api.txt to ReST format")
Reviewed-by: Sean Christopherson <seanjc@google.com>
