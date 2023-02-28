Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CA6A519E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjB1DGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1DGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:06:03 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F7234CF;
        Mon, 27 Feb 2023 19:06:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EE7D13FA55;
        Tue, 28 Feb 2023 03:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1677553560; bh=wVcS342cqA0YYWvmacgIf9QEQsqALNiDVlYfNtFDUa0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=WesZhbidz5NnlzU1ruhs6kqvMrgw9FR6q5ZpOXhEMZCiKGClK70ct+JWPWIvdK9JI
         btsNOSeFIEUGtUFzUahNNEcvEYb1kDbtK9hQRU02Dztg12zTetnsknyIBmShVl+5Ck
         CPR2kpdchCvo/phvemqAKmRhnRmjAlSp5wYEyRUfLZ62HyiIbL89K0M+hK7gKE5KgU
         XkyaGM18wDKWxutqMLllXS3LVKS3SLzOnZdhXDqPYIKwVTiERct6CBkv/jneealFu3
         fHG5/1heaHvKVMHp96rG8Ul/LBKmwEUx6U7spU6FCBr2gKSERqTJnCdKyz/z1PhA6n
         VXyAu6qfmPOuQ==
Message-ID: <bb82ed53-3c90-69d2-1c92-d8a6f735fc5f@marcan.st>
Date:   Tue, 28 Feb 2023 12:05:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
 <20230227195139.GA677578-robh@kernel.org>
 <CAMT+MTRodB_+sMtoPxv-gP_+sJAwNb36XuLOGo=HvuCQq6h+gQ@mail.gmail.com>
 <20230227221426.GA1048218-robh@kernel.org>
 <CAMT+MTTH-DC+1wMFUGNwVM3cYm0B+XVK7wL07khdy1hSjyhDGA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
In-Reply-To: <CAMT+MTTH-DC+1wMFUGNwVM3cYm0B+XVK7wL07khdy1hSjyhDGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 07.25, Sasha Finkelstein wrote:
> On Mon, 27 Feb 2023 at 23:14, Rob Herring <robh@kernel.org> wrote:
>> I know little about libinput, but how would it know about
>> 'apple,z2-device-name'?
>>
> The idea was to forward the contents of this property
> into the input device name.

Then you want "label", as Rob said.

But I also agree with Rob that we want per-device compatibles, even if
we don't use them upfront in the driver. That's what we do everywhere
else, and it has served us well. I suggest this hierarchy:

compatible = "apple,j293-touchbar", "apple,z2-touchbar",
"apple,z2-multitouch";
label = "Apple J293 Touch Bar";

Then let's say a hypothetical touchscreen + touchbar MacBook comes out,
we end up with:

compatible = "apple,j789-touchbar", "apple,z2-touchbar",
"apple,z2-multitouch";
label = "Apple J789 Touch Bar";

compatible = "apple,j789-touchscreen", "apple,z2-touchscreen",
"apple,z2-multitouch";
label = "Apple J789 Touchscreen";

And it all is nicely future-proof. If libinput needs a hint other than
the device name to figure out what should be treated as a touchscreen or
not, the driver can use the "apple,z2-touchbar" vs
"apple,z2-touchscreen" distinction level for that. And if per-device
quirks are never necessary, we just ignore the model number compatible,
which is already what we do all over the place in other drivers (but the
day it becomes necessary, it's ready for us). And if it turns out we
don't need any of this for a while, the driver can just bind to
"apple,z2-multitouch" and call it a day.

- Hector
