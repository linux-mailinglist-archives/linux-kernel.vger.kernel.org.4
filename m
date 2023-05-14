Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987907020AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 01:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjENXj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 19:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjENXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 19:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E710E6;
        Sun, 14 May 2023 16:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A4961290;
        Sun, 14 May 2023 23:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE78C433D2;
        Sun, 14 May 2023 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684107562;
        bh=UaKQd7JGnnIhaE2P6Uv9otEEJS3MWlvbWfKVnt8tm50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ym9b1hIewy3LcWK8uerVc+T0edQyUjw6sbk43zg29D8HcMvmRUGaX6jFJhnyPWVDp
         jBmv8+ZsWr58Ou0R5Sj+STSutBJui2B0qRLXZ+7Mpg0RIUbCffx68SgZAtsQh8yBn1
         Ovr832HqjVXTwej0377wJyozx3dY2WQDcrnlfYtJ0asjidOkBpOoFE+rTQug81fmvc
         ElOkNZV+3IhyMNxvW3Edgvmzz/6yYDm5f857izJJGc4dyGJ1obDe4Ecd3Oc6sv4ifi
         ZZMHsj9R2DhG1FMeXbgUxBPyAM0RF3J6TLvVqz1IolAb57gIqjDvwYKzpXrOCzlwqD
         RYczemM5WLzFw==
Date:   Mon, 15 May 2023 07:28:10 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <ZGFuikzSsP81/d23@xhacker>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-4-jszhang@kernel.org>
 <20230514-bust-slam-10c7b9cbe455@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230514-bust-slam-10c7b9cbe455@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 07:17:27PM +0100, Conor Dooley wrote:
> On Mon, May 15, 2023 at 12:56:44AM +0800, Jisheng Zhang wrote:
> 
> > +$id: http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#
> 
> $id: relative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#
> 
> Please test the bindings before submission - even dtbs_check catches
> that one!

Aha, I knew the reason. I did run dt_binding_check and dtbs_check,
but then I read one of comments in v2 which suggests the renaming,
that's to say the dtbs_check is done before the renmaing. Sorry for
confusion

