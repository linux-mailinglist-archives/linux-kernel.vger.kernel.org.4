Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB43711A28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbjEYW3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEYW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:29:04 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4319E199;
        Thu, 25 May 2023 15:28:53 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-783dd1c02c9so33288241.2;
        Thu, 25 May 2023 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685053732; x=1687645732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2+pNdKsdIkwOKJVF/7IutZds8UJqg2pcbBLY+CSG6w=;
        b=hD/7NbRkx9CFn+Xe3ZE+FEZ9Ckl9d0ydsGTtMqKWeoT6lRj1EBwgrlMAvLcFOWQQJa
         pYl2XB8VrP60mHtXHvcjJvgfdvwiWK9iBGDcweap4ygve6RwY2UdKBNjqVql2vvCL193
         CXXC+bzYrgLfz08KtlDxwtBgU6f8CX8J7xxq/CJ8/UXr/r6wK2n8L/pybYLYT7Tm/hOs
         2qpUpws7BUlCQ8UvBXg5msATCGX6/6rNVp9SPeXnMYsGsTid9dJnYjJbACErsYIHn6Qs
         IW7X8U6oLhXKrxiajOh13LYYJLlKmtUWl9WfrZK+l9dYpAzrWAfoUZsOCi3XKAQLfk+A
         btLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685053732; x=1687645732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2+pNdKsdIkwOKJVF/7IutZds8UJqg2pcbBLY+CSG6w=;
        b=WZ9e/4JLJI5Kw1mBTYenqnAjLKk9Leil8j3/b7QMh17bkkDj+tLgKoHi23bu7iSacI
         0DYaOUqkNCa2UNxAPAJPtS85LHNSbVjgVzrdD/tB0LK3Fl1+PYs6enINJfH1viXqHACH
         xSlNPjyir7bRf35pOsQKc856VegCHhv7U0Lm4A+yiHraazovIifZK/tk2zZUAyk6zHwC
         MCcdHvkLwD/Q4jAQJ+fBQXN/rOpvzs/SFCvc7TDVaroNBhtzy8EEpj8AK5i3V/V8yjs0
         OUw+Bd/46NtJKlZLAEQlyJgEihfwNbiKTUmOLLMQE7NNXFtTtO0LXZ2UBQl5iTeUXjZL
         akSA==
X-Gm-Message-State: AC+VfDzA0VlxEEPxpplKyAB4cIxzkklf2iqxGBK4NRlN8TbdPjHr2f3u
        bxOHzaD7jw4IVQ2wwIaTPc2UW26LZWAfwto6llE=
X-Google-Smtp-Source: ACHHUZ7M9g/HHxRkPVJWdOU429ZFIBnrenMLgwyDLCuemgNwCBteaRvcwYR01nMs0c1HRBv4dxd+Y7jRyF4n0wFG9BE=
X-Received: by 2002:a67:bb1a:0:b0:42e:2b9f:f8f0 with SMTP id
 m26-20020a67bb1a000000b0042e2b9ff8f0mr6655355vsn.30.1685053732253; Thu, 25
 May 2023 15:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230525211346.718562-1-Kenny.Ho@amd.com> <223250.1685052554@warthog.procyon.org.uk>
In-Reply-To: <223250.1685052554@warthog.procyon.org.uk>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 25 May 2023 18:28:41 -0400
Message-ID: <CAOWid-c2_atz6oQspoQq4MQQ=DQWfJ=-JgbV2QFY8PveC+Sb8Q@mail.gmail.com>
Subject: Re: [PATCH] Truncate UTS_RELEASE for rxrpc version
To:     David Howells <dhowells@redhat.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>,
        David Laight <David.Laight@aculab.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 6:09=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> There's also no need to reprint it every time; just once during module in=
it
> will do.  How about the attached patch instead?

This makes sense and looks fine to me.  I don't know the proper
etiquette here, but
Acked-by: Kenny Ho <Kenny.Ho@amd.com>

Kenny
