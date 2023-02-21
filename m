Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67F69E8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBUUYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBUUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:24:13 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918A813D50
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:24:12 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j67so6796387yba.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wg6wUsUBv3ps1Ea2+HUNQuXrVhFNTJMl9lhHXw/Jvb0=;
        b=nA56w9lJfeCAomLkCbRMPdtRRrjoL4X0I5/+xx38tvWglZ/1guG9JLGO1FSTHHer+j
         sB7x89i6j3LwSZ4OKkd1rsZ56hxUku9uVTV6jqHUnw++a6DDn38RDKeoL5bl9pWDD0sg
         R4B0+cqCnXhTpq2BIas2Hc1LInctGertTcVdq4FiOAN4Agj42vF+3llQrbTslP6NtTsG
         MkEmtwRivZWDkfYTEa3odMGvXNmsBLNUvaF+Ewhg01MvyWrISTw7DGE5BuJS39zSFHT+
         Wj5Ocd4ws9qMmZXvpytzTrWIHo4Af0vDAisGngy9c77I+PKpnX9lp1YAlK2UiB0gqsf4
         zlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg6wUsUBv3ps1Ea2+HUNQuXrVhFNTJMl9lhHXw/Jvb0=;
        b=MoT5KzsI924OvTSGccztk+eI+sxbLA7RA8F5a24oOX4ZmtlCF5nIVRrMhzUtUPYtfn
         4Trn664S6AL/tsbIO1jd8iEOQ+H3Tn8keFbG8B9tlN9SEJGhtpW9wppZ5E6PqTnT7QKZ
         aR9x5Bwf7jE2DburvHYNT2YKXr+4xzyTOQEbg8uv3UE87cz0Pkz8UmjIFn3Ev8Orygnc
         oc+FZ6d2jJlq3SiZRw2a6BBW6FMyd03IwaNXDuBbGl5JeBUsxA9ETAgIVBl/2cZQbEdi
         2v/6+kBtRvHfb9xNyRMlavg7YuLZukX3hsEnikOhfaYg8pCITYd+zu73sQQSxkp6TRIt
         4NYQ==
X-Gm-Message-State: AO0yUKWMOWIpJskum02SpDAsznM5WXSEx7JxeO7ScIRjXitmQjvIRN29
        ZUGQcv7S6wPqxMGqcIBLTWQf0XxNSw+3qnO37Xpegg==
X-Google-Smtp-Source: AK7set8tFfANC5MbpetJA0jL9tHvmdijSpG9DNOn2/nW/KMUbdcI25seKBHNiihBKKS26RpThhHHWCYHrT1gErUzopk=
X-Received: by 2002:a5b:bc5:0:b0:96f:698f:6136 with SMTP id
 c5-20020a5b0bc5000000b0096f698f6136mr586144ybr.91.1677011051617; Tue, 21 Feb
 2023 12:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20230221102605.2007396-1-linus.walleij@linaro.org> <167698731618.2349693.5906822374742470475.robh@kernel.org>
In-Reply-To: <167698731618.2349693.5906822374742470475.robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Feb 2023 21:23:59 +0100
Message-ID: <CACRpkdYqC0nk4J-9QJiTEX-9R9+SOJv-9sfXi32pfABZCTbGvg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: MFD: Convert STMPE to YAML schema
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philippe Schenker <philippe.schenker@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 2:57 PM Rob Herring <robh@kernel.org> wrote:

> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.

These are all expected. The DTSes have to be fixed, mostly
sanitizing node names and removing the pointless "interrupt-controller"
from the base MFD device, the only interrupt provider in this
silicon is the GPIO sub-block.

Yours,
Linus Walleij
