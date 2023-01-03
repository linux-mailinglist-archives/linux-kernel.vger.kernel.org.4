Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4065C06B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbjACNFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjACNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:05:42 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36F9FD1C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:05:41 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id s23so1841685uac.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBoUROWjuf5ZUYCNjG/g+PT7H00JAGubfmWIHqWiFno=;
        b=LG3dcwLKf5tAGbI5rt2aIWy2XkdGAxgvDX2u5W/cT0Rlwxk26JkI53ckg0EjFBfTKU
         eAZhu4Pj1OMx0WJlfThaU2UnC0+rke06pkTwZcGduzSbZf3xH+hqKVVFUTiobql5eAWf
         7OMyMi0B3paezljyGecRMQLwxYlUfRQtXlpX99OldXISEccoys1Twr9A6ukSf/WFPPOE
         34oc6+7wrCSUZbFEheBkjjabWGNxkLp8f/o7dLjWpHbXi8O1eDHEmjjGiSJCUakYXrwZ
         Wih1WTikjtgPpkPZWZtqPX75mAcnAV2bopj7xZ8cqgencYHUBQ0aIR15CKzagVD3c/Bt
         md5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBoUROWjuf5ZUYCNjG/g+PT7H00JAGubfmWIHqWiFno=;
        b=KuQleLm5Efmu9uEFva8yajp9J8Xpl2CXwlioSiSm8Tl1cjKqCHgjY5nJGtUAebpFu3
         jItkjEKoL213qq3CXCPWLwfq+Ej+fb7e4320jyIYxsuM3HsomR4Si946rG2JbGCECs/j
         L2wu868HJDK+EhUvznLd719uJv5Ejez+CO9G3S4gz9nNSVvVCgx637VULtqbf/tF6v/8
         qVEFNI5D5ifIXhWHZ2VdICx45qPcwboH8RTfIzxe8Ui28zJ97M//J5BcBb9XEHAxHbx6
         IsPYrLCTU0dESqSj766diB1jnAMEJ3OrCLV9S0h5hGgHyNc43BN3dI/x+RKPHw2QaOXD
         CrLA==
X-Gm-Message-State: AFqh2kqqDA/aETuDaYVL7UyelxoQR6+Q50enytQxV4fy3LZMwrBUbFNF
        SmIL/kHC6UF3KC2ZlbfjUD9896vShf7yBLFS4x43RwhTjMTihQ==
X-Google-Smtp-Source: AMrXdXsabU1gefvs88vYs+DmLmfV8mbDiegq1CGFp4srFkNfmOlOQsYh7UqXWCshayJ3xlbOoVtJxKRC/g/O0jtAdJ0=
X-Received: by 2002:ab0:64ca:0:b0:478:b785:affb with SMTP id
 j10-20020ab064ca000000b00478b785affbmr3920179uaq.52.1672751140736; Tue, 03
 Jan 2023 05:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com> <Y3EQ4JU7uGbIMGiW@spud>
 <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com> <082eb006-75b8-dead-c014-9ba41a697e50@linaro.org>
In-Reply-To: <082eb006-75b8-dead-c014-9ba41a697e50@linaro.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 3 Jan 2023 18:35:28 +0530
Message-ID: <CAK9=C2XnYVtEPqPoLw=+n6Ys_jm8Ndx7fDScDAOM4iNMEj-H0g@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Anup Patel <anup@brainfault.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 2:29 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/01/2023 17:50, Anup Patel wrote:
> > On Sun, Nov 13, 2022 at 9:14 PM Conor Dooley <conor@kernel.org> wrote:
> >>
> >> Hey Anup,
> >>
> >> Ditto the $subject nit here.
> >
> > Adding "interrupt-controller:" to subject makes it longer than 80 characters.
>
> Because you added redundant double "bindings". Subject line is precious,
> so do not add useless words.

Okay, I will update the patch subject based on your suggestion.

Regards,
Anup
