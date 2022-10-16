Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB216002D6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJPSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJPSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:21:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E5118392;
        Sun, 16 Oct 2022 11:21:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h203so7577066iof.1;
        Sun, 16 Oct 2022 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNtSAftWKRCBzivZiSHl1o3Clg9CAG5ufkQWS1xM5dk=;
        b=qr0E08OvIG/JOQcJDRt4eYasa75SB8F2qfi6jpcqCTRVXWxD2WYpeP2srg5xT0hmjr
         qNKRP9Elbb1imaPiFVyk5R7l7Pp9MYJPXEKGtgwWMhd/GU5sfd9f0wVs3ArU5rtPca1X
         t77icbnKIa0jy0WAnYh2uvXmTkX9CbHbOfmxrVXNAreAZiOmAN7HTkjs7oLcDPtHjUJE
         QlMAAYrHfO7Y+zUseBlbmck2jQ1cbjXk/xgtAQJ/5xmZcS6E8jivyhZzixBRFKBb9x5P
         A9LTDgGX2GzgIumCShiUgkHqazhvr0hjbq0yowb4NVj606yriuBjthJFafjPUeAJ58Lr
         GxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNtSAftWKRCBzivZiSHl1o3Clg9CAG5ufkQWS1xM5dk=;
        b=JNyzZkbYzMTSkLs/RN516c7Bq9/wI8jqFKxhcgabAAt4POMt9ok/+zk1bW0OipTKQY
         fsMkQl8dF4zj7MEDVHWYjPKtOD0w+mwJIOPyaQbTxJyqPodv0V7oAC0bEEG5NBCsh9eZ
         EXuy80X3xPlRg06mPiDkuSiOqktmVBBS1Q/db+OQXoREhKcOqqQJ0wjO6oo4+GBX3sIV
         5dndfv06mdX3DnmMY3OGEEm6deolQLEjbH1L0GrbAb6GTsFyG3Q8/SE6sbVm46M+Ji5T
         8CDpNzbv+9wxnlHU+BM9e/jvZoc6cHXIKX7LS72IsrKCQrzxZ7KJ9yS72iwnrIUqy/k6
         aiqw==
X-Gm-Message-State: ACrzQf1I1cxIQoyCjCw/8BvnbNj5PTxWCp2SDpnVmMf28z1dm9O77Np/
        t+I5g0L6B8o4G2aYiCcBpQP2B4CQ8pdtUzFp1Zak92kExMeUag==
X-Google-Smtp-Source: AMsMyM6YIAti+v0ycr+3MN2bvHwrODOtkVqs4HLOZAmOnKV1+BI1nRMrvsqDj4+GM/mWhShmxsd3rDqSUX6G5qzqagQ=
X-Received: by 2002:a6b:6716:0:b0:6bc:113c:22a2 with SMTP id
 b22-20020a6b6716000000b006bc113c22a2mr3001409ioc.12.1665944489899; Sun, 16
 Oct 2022 11:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221016150110.3020451-1-lis8215@gmail.com> <20221016150110.3020451-4-lis8215@gmail.com>
 <c2accc8b-f4eb-47ca-333f-eeb98da6a363@linaro.org>
In-Reply-To: <c2accc8b-f4eb-47ca-333f-eeb98da6a363@linaro.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 16 Oct 2022 21:21:18 +0300
Message-ID: <CAKNVLfZ8qi4MS6ineF4M5xnSmHW+=P5mdgifmr74g4kOSK2wGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add Ingenic JZ4755 CGU header
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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

=D0=B2=D1=81, 16 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 18:32, Krzysztof K=
ozlowski
<krzysztof.kozlowski@linaro.org>:

> Why did you choose 2.0+?

It's the first time that I need to choose a license, so it's a bit
confusing what
side effects they have, especially in that particular case.

What do you recommend?

BR,
Siarhei
