Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A9609366
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJWNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJWNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:13:22 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1307846D89;
        Sun, 23 Oct 2022 06:13:11 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i65so5880866ioa.0;
        Sun, 23 Oct 2022 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJKXGk0azY0SqdocKhNJE0WI0RFBqPoXtE91YOXKTl0=;
        b=iOd89QwiDSRc9r8YPdX8kwGCZ48MO4N8PxQM0y+tnnyOrxvAM/bPSv7NxxAUFuHDBc
         oKBXfgH+wcz6iSxgz/UJiR1h2SHFhyO6w4+wF7px3ywA5YVIjjffOXcO8oY/+aTfRN5a
         qB699xT3zNlQJAd5t7ObwA+GNwSyFql+uQos1wzbSG1+sRhMZ1wz597epGI+oSMmxJEf
         EuuiBSKhJWWOLq46vwGr7orkAelmu/IMD3Lfa9eN+VpDJDzoRYMcOZLnaXOl0CGtPONp
         ki1T9U2EErJA5hZZrq4pTph09za2x2nd2p2YrSOrJHU7e0QVQNnTcTiiAfnQbpABdJmn
         p6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJKXGk0azY0SqdocKhNJE0WI0RFBqPoXtE91YOXKTl0=;
        b=vor4HfShrZ5l7VzFbgAtjHdSJxXqLuLInRo+8tLtwF2nSJbxhpq4P5f7SFC6Qlrs2G
         Lu+tvj6ag2FnLRVEY1FPhYb+LtiOiy4lBvCIEDwCIyrVylqL4i3KHUJCvFwnL8J17ek0
         60wXGvcedfjO+cgpoLnraYwNnzKFOe9qiSkxZYXj0+WgXMbU8oaL0flRYCJ5cOhKWi73
         lDrbddbVNGVhIOXch93OSJVS8z6o1s7n4Tysv23htJDQWhOsXHKDgHuvxDjygR1UvR5V
         2VKtzsfcETTpByK/+tY6XeBUiif9P7zu1oc45R6JgnB3pIdUSiWACX8waciRVBekv5fx
         eC4w==
X-Gm-Message-State: ACrzQf1PTVAs2tGrmX5wGl30kbXAbNbwB6ygndZCegULRitniwVN/Fzg
        k/hdIOJkNf9aSwrEoO2pT4RjBsmw0REitHN70npRPQ8lsJkg+w==
X-Google-Smtp-Source: AMsMyM4+xZ4IOdcYlaAZqjhOvUwnNCrT9TKr62CrF8IynI8APUJ5F09Q7Gecr7LzBUhIMq3Fu6/LpjATydmudoog6EM=
X-Received: by 2002:a02:a519:0:b0:363:b5c6:564e with SMTP id
 e25-20020a02a519000000b00363b5c6564emr19204782jam.253.1666530751953; Sun, 23
 Oct 2022 06:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221023123944.4103876-1-lis8215@gmail.com> <20221023123944.4103876-2-lis8215@gmail.com>
 <652809f4-caf8-cb01-3d79-530f4288b00a@linaro.org>
In-Reply-To: <652809f4-caf8-cb01-3d79-530f4288b00a@linaro.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 23 Oct 2022 16:12:20 +0300
Message-ID: <CAKNVLfZ9NnKu7A8adZf2e9iQURT_bhUmjba-e66pqj7K8QprOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: ingenic: Add support for the JZ4755 CGU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=81, 23 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 15:42, Krzysztof K=
ozlowski
<krzysztof.kozlowski@linaro.org>:
>  maybe you just forgot to apply it.

Exactly,  especially when returning back to that once a week.
Sorry for flooding.
