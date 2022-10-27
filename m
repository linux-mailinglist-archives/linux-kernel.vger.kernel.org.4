Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69860FD10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiJ0Q27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiJ0Q2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:28:55 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF5386B7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:28:54 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-36a4b86a0abso20476157b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/twLMWw16uAE+n6BRsXXihWMHHuPUSy05Q/il/C7lHk=;
        b=EtMfw7YoKHuJZm/wHL9s/OzTtTAPLgngkqz/eQFP2+h274lhVyRMh2abXnQvTdO4GY
         VCMtYDVT70Q+lJi5lcFkVuY/1X4O0F1O/t8BU14MV0c06ReZ+P7hJIb4Ujv2xO7T30ps
         KWeDXRhFJT6QUOwvEhzwfFC4kYUgnw9+Sp2qFgfAIFBaf36NwvNYnQIi941EOn9mwPSo
         WUwv5d6O2ycvayl+vlEDAXVx5VlvzgO+MGGh4NIdAkbr4DWkn+9udzfQIYx24aCL3l1g
         2RXiXmwNjN3IduQzypNgvkW7K14Xzr1a541+GVbEjMI5oN6MjT+46iEEsDpHQM39FC73
         BZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/twLMWw16uAE+n6BRsXXihWMHHuPUSy05Q/il/C7lHk=;
        b=A4+3IaXK/XaigsDFn5rNIb9rgmHFBFkS229v50vrTmEQMyQ5uCDSRP0vaPpXjfv1De
         EMkEZKY1uD3eQ9bPvySUxhapChFCKlPE4Hy6mBVaxyra9j8jakMJ7MVlEbWyAqL8xAs+
         K3HAxnGgfBX+DFeyvsO30GvzH9AnY6JfBeguf84FnsMB75aG6BmCR6cpyWy1gGLpqs5O
         bWnMX4CX7Nup24ePEPCXRl5pbxkZUdhLPgvsEtm3uIHYHQmxftvVFQoDykrzfNp0JtIp
         pOelTc7QJKw2mN9LB6XnjYS99wk0FCKU5E0SmDrIJYy0GKct/nr03ZJUetJhkrvpzwKi
         uYwA==
X-Gm-Message-State: ACrzQf1piI93nSIBFU5b2Yt96a8D8TEm8PB+RtB1AJLkTzhgOe9FS+uy
        UHfrL52YP2aPnsF21yAOLEXuKMPN9kqAC+HRapJFjg==
X-Google-Smtp-Source: AMsMyM67mvVRzQAcDIhH1GuVnNabzz1YBbDtdPr57xgs6+J2jg0eMPdUFQms3czCKEOQcKCYIIifsCQ/2jUAGTzNhHk=
X-Received: by 2002:a81:ad09:0:b0:370:5b7:bef2 with SMTP id
 l9-20020a81ad09000000b0037005b7bef2mr2515251ywh.47.1666888133447; Thu, 27 Oct
 2022 09:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220902141715.1038615-1-imagedong@tencent.com>
 <CANn89iK7Mm4aPpr1-VM5OgicuHrHjo9nm9P9bYgOKKH9yczFzg@mail.gmail.com>
 <20220905103808.434f6909@gandalf.local.home> <CANn89i+qp=gmhx_1b+=hEiHA7yNGkfh46YPKhUc9GFbtNYBZrA@mail.gmail.com>
 <20221027114407.6429a809@gandalf.local.home>
In-Reply-To: <20221027114407.6429a809@gandalf.local.home>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Oct 2022 09:28:42 -0700
Message-ID: <CANn89iL7EvdBhZGtxDOATeznLUwVaFm2gf4XCYeMPXE5CR=BTw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: skb: export skb drop reaons to user by TRACE_DEFINE_ENUM
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ian Rogers <irogers@google.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Hao Peng <flyingpeng@tencent.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, robh@kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Oct 27, 2022 at 8:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 27 Oct 2022 08:32:02 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>
> > This seems broken again (tried on latest net-next tree)
> >
> > perf script
>
> Do you also have the latest perf and the latest libtraceevent installed?
>

I tried a more recent perf binary we have, but it is also not right.

I guess I will have to request a new perf binary at Google :/

perf5 script
         swapper     0 [030]  4147.704606: skb:kfree_skb: [UNKNOWN EVENT]
 kworker/30:1-ev   308 [030]  4147.704615: skb:kfree_skb: [UNKNOWN EVENT]
         swapper     0 [030]  4148.048173: skb:kfree_skb: [UNKNOWN EVENT]
 kworker/30:1-ev   308 [030]  4148.048179: skb:kfree_skb: [UNKNOWN EVENT]
         swapper     0 [008]  4148.048773: skb:kfree_skb: [UNKNOWN EVENT]
         swapper     0 [030]  4148.112271: skb:kfree_skb: [UNKNOWN EVENT]
 kworker/30:1-ev   308 [030]  4148.112280: skb:kfree_skb: [UNKNOWN EVENT]
         swapper     0 [030]  4148.720149: skb:kfree_skb: [UNKNOWN EVENT]
 kworker/30:1-ev   308 [030]  4148.720155: skb:kfree_skb: [UNKNOWN EVENT]
         swapper     0 [030]  4149.072141: skb:kfree_skb: [UNKNOWN EVENT]
 kworker/30:1-ev   308 [030]  4149.072149: skb:kfree_skb: [UNKNOWN EVENT]
