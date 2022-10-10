Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310FE5FA686
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJJUqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJJUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:46:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E30772846;
        Mon, 10 Oct 2022 13:46:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l1so11343436pld.13;
        Mon, 10 Oct 2022 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gl/r2XlBZtmovVwTwtEi9D/8Ulu8vofHlm05R8t3sQ8=;
        b=pOv3CPXqKos+Pw68meIAmxXp/DHXaEWU2T9TZCY5zosET3hv4COttdn+ktanl1I0mn
         6mLdn56TRj/matP0enlF16iCNO3fcQM61D8tohbgQLKYsqUxhFzs64T8Eywq7ITfz+H7
         Av3NIP/jkIO8fftYOl9iuTfs5EKqX8KTFhts/J95H5G94aAdOEjTSnwsxqWDjLEvRItd
         f+SjpyIEjq/avggn2dG1IM4LrC5iUud4Y4lrM4VRHFW9/HavuTMx9YpXTXSAecH5A1bl
         phkXSxhzsPVcjcxM6zV3EIzTN/tP0i36WVXwMX8wdqk2+Nuot0WwpyHqzQWB4jZPQUqt
         GRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl/r2XlBZtmovVwTwtEi9D/8Ulu8vofHlm05R8t3sQ8=;
        b=TMT1/OzJBjC+MeXNu43eHzw35NIdt4zw/NMpDQJdU0P0oqTcu1a0RVIBexsM4LRegc
         rrfEjmfGumIkitlZ+OK3Wjm8hAslWORGFS/nf/3KN1jamr3BOyT447vYD6tsdL8kTRnC
         9Dxd9bQezWRk8Ei9p5zaL2KbJMaoU9g2TM+HWqRvxk36nNfY+8U30hEu2rmOxGyoekHT
         CEhkmNS2/Za21uqxm4ssAwdCYygsDWBkTpgOYn4wBTl99kKs3t9SEOJJRkfVF6+kbnXv
         5as70+Ina999gkCmun71gR6AIjMFgfZch32WDhXCJLMfRo8txnVKrd3RiPPLAl/WCwOG
         ifqg==
X-Gm-Message-State: ACrzQf0795Fe0mpYC4Grs3Z5gls3JYsOaNNY3Fd61zkelu0P3DmD95Qd
        pr6Q9m5qj0W3cU9eorU7Rl61Gg3FnPwWPzhyCl8=
X-Google-Smtp-Source: AMsMyM57rndDymb+Zd08xP+YZqIzHMNd4xpXeUjxkzXE9wqwVVzVe+XwTi7AnO3WCPardrABeiBficWCJILmvBuWhow=
X-Received: by 2002:a17:902:8549:b0:178:6399:3e0f with SMTP id
 d9-20020a170902854900b0017863993e0fmr21276014plo.35.1665434791984; Mon, 10
 Oct 2022 13:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsMmvxi9kCZ+sUm+Vb_jxaPXE308GAwkUmiduuJXh_o2fg@mail.gmail.com>
 <ad6a722a0caa50c3f369e97b0f03180f62806fa7.camel@sipsolutions.net>
In-Reply-To: <ad6a722a0caa50c3f369e97b0f03180f62806fa7.camel@sipsolutions.net>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 11 Oct 2022 01:46:20 +0500
Message-ID: <CABXGCsOceHUhinSO6CwMEfx4akUXiOFiCpdqf9beNpWH82RXZw@mail.gmail.com>
Subject: Re: [bug][6.1] Enable run-time checking of dynamic memcpy() and
 memmove() lengths causes warning on every boot at net/wireless/wext-core.c:623
 (size 4)
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linville@tuxdriver.com, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:45 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=e3e6e1d16a4cf7b63159ec71774e822194071954

Thanks, the issue is solved.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
