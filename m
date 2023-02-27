Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47BF6A4DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjB0WZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjB0WZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:25:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC31ADF7;
        Mon, 27 Feb 2023 14:25:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d30so32114831eda.4;
        Mon, 27 Feb 2023 14:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=weQbce3Nd/hM6xXy3nvlFQno/x9AdFR4oWdiig5I/6A=;
        b=q14oy//aCiLK/UNRMDIwpFjscBsMO6yDoMErR7cy8UfFns4rKPcxrzK8GJM/nCVti/
         Ji03+2jD/2h1yfpaRQ20LwF8wstet9eFax4N4r9jKYTYoYUYoZMlgNxzo4z8bFedN/8h
         0xVO8957bvxnyX/e8MDVyg/l7PAc1VL8Ym7dzkXiDQcWxbisYtIH0UXQ7oTz80K9OjYM
         RKHwJnZZjJjSKur+ZJoDiXHZyCO/KlL24jNTmME0fm+i8SNetTJEP7VBtQcKSzsDZV+H
         C9dxxUjqi2f0bmt7FN7xM8sIA5w5WXpGWjfX4qoyayuyxHcRj+2BMa1dhBWry1wBpHGH
         KX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weQbce3Nd/hM6xXy3nvlFQno/x9AdFR4oWdiig5I/6A=;
        b=8CVvx0UEr++m4/ncPzfn+y7Hy4QS6e2V9aOEZQJFzO5uz7SYbWDHo6QGu5EGa6VzEN
         mowZ10P1GmfC3kxbIDc0Cb7/YUEsa3pcVp37QYPzdIaNeojOtocNcI3XhQKPSPXaem8Y
         UZozAEX0YswFi7F8WauDbllPJHCgCKS0tPQ5RRwAF5dQ7sWNwLnk4pWic5o9g0lotWXl
         hzCCFv3lj1iS4nFBh9JHZ15fXEaZk1mbkv7ReTHaUh/q50qvD/sRL2zhtOyeS48lvg5p
         ESvOf95M0SfOcu1GVIxsMc3KW/AS6o97ObcGZwLkPtLdodsdlvWOSLKH4qMWHZ1QYgev
         sanA==
X-Gm-Message-State: AO0yUKWigV7G15pABdFzzNH6TXwb2GzaAAitaAtE0VdyxPhCR0z+HP18
        8VpZW46yKTUIt/IR2X6Ng76TVG08WhPIV+lgzDY=
X-Google-Smtp-Source: AK7set8/KolOeO5KtwxAKdFVqWdjyZbfi98she0qCRw8+0k5cqzsBRN7japO9oJpd6gDvmZLnjr3sjZ9mecacJi9Inw=
X-Received: by 2002:a17:907:a0e:b0:8f7:f3d4:942c with SMTP id
 bb14-20020a1709070a0e00b008f7f3d4942cmr824625ejc.7.1677536718232; Mon, 27 Feb
 2023 14:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com> <20230227195139.GA677578-robh@kernel.org>
 <CAMT+MTRodB_+sMtoPxv-gP_+sJAwNb36XuLOGo=HvuCQq6h+gQ@mail.gmail.com> <20230227221426.GA1048218-robh@kernel.org>
In-Reply-To: <20230227221426.GA1048218-robh@kernel.org>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Mon, 27 Feb 2023 23:25:06 +0100
Message-ID: <CAMT+MTTH-DC+1wMFUGNwVM3cYm0B+XVK7wL07khdy1hSjyhDGA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
To:     Rob Herring <robh@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 27 Feb 2023 at 23:14, Rob Herring <robh@kernel.org> wrote:
> I know little about libinput, but how would it know about
> 'apple,z2-device-name'?
>
The idea was to forward the contents of this property
into the input device name.
