Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3D691B27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjBJJV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjBJJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:21:55 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034C1F90E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:21:53 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bd6so3941877oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLJ9kUfyKKHaAUOuvBcSKOFNG4PBe8Yek1lAbaYVe84=;
        b=BGtIzqujNvP5ygAUGUtaVYK1ma2XD5w88MoJBEH6cCZ/DwQqtw2pN0KqU9dvfNOcm+
         rhutDRysUEaZCaCquskxooDWSlxf/d1BiIqDg/AT8H7xrrUX3a6Nd4tbiRYWOCewB4Q0
         sScEXP5lFFkvaVdmb+i8hA9XPXH156sm9DYp9axgQjLUnbwPzqQatANIk1HI4lZ3az36
         MNQew1OY9G4r/q+CjLERXzRKwWnoywGmwkaS5P+IBpqlgb7WF5cmSgfoxhLDtM58Welp
         uuBKqcLSfw36MrMG0c7JUGkh0jQvq6FjsGfXafiRiPSruefpMzaDqA0L89tjLVrGV8j+
         PZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLJ9kUfyKKHaAUOuvBcSKOFNG4PBe8Yek1lAbaYVe84=;
        b=rrNeBkcy4bJCwWL2QDIX+g8cE1/RBEkB5IQqrYnlBJlCT2QhXiJHGDkQ2QasQOWQxh
         kSHW/EWi+cnu9AJki6LI+PLfSYzXk2h065E1z+tgqOlg2Ju8XcEjRw0z4yU8t71WsuVS
         3yavD4r358NkGNeOPzd1NY0ajpqvLp5TgVVtIUkZ4fMd2//uXxeGRmxESqCTUcLdhQB8
         uSJkcPOOC6k5iB79Z3KQUJqKfYF5O/hdCBIkJIKwJfG1RkSNwY8QJjtlph6LxfANs6gb
         MhGsKHafODRAneGS8glLQxoKKZC/P5i0UnTnbOmExK+1wKjAaBbfpcPmIPRsJwSsGkaF
         clZg==
X-Gm-Message-State: AO0yUKXu36ogB9vpIVzYjOqT/bv4YoK7ki/LsIaZg7NzAjrVfo37MFZZ
        r7ND3qe6wq15ff9XCQobEKEqPjR9J65jVxrgL0U+5A==
X-Google-Smtp-Source: AK7set8C44utWhn3k0gZ0S4j9LEYnK479SBTtpKBr5/+G6jMC0jVZb7eMcTkoSXOmhB2KvQqikWf1SaF1JQiDYGkWMQ=
X-Received: by 2002:a05:6808:14c8:b0:378:7c48:f8d6 with SMTP id
 f8-20020a05680814c800b003787c48f8d6mr959901oiw.166.1676020912907; Fri, 10 Feb
 2023 01:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20230210055451.72153-1-jordan.chang@ufispace.com>
 <20230210055451.72153-4-jordan.chang@ufispace.com> <4b735136-d9c0-cf01-e453-c8da31754a93@linaro.org>
In-Reply-To: <4b735136-d9c0-cf01-e453-c8da31754a93@linaro.org>
From:   Jordan Chang <jordan.chang@ufispace.com>
Date:   Fri, 10 Feb 2023 17:21:41 +0800
Message-ID: <CAJ3czeSeuPx1L-qkXFVLR+UQDyJHF_G4Z5MdoYSeLaifWNnn=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Feb 10, 2023 at 4:56 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> From where did you get my Ack? I don't recall it.
>

I misunderstood the usage of acked-by, please ignore this email patch.
Apology for the mistakes.
Should I resend an email patch or it still works on the previous v2 email?

Best Regards,
Jordan Chang
