Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA6610081
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiJ0SmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiJ0SmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:42:21 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BADA471;
        Thu, 27 Oct 2022 11:42:20 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CE16072;
        Thu, 27 Oct 2022 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1666896140;
        bh=atr0S58h1yu60GnFfMnKgm2Gs/HQP4tQcyEFa4YPGGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRekmGmtXrT1KQtnaIf/PRMxY0iYm36RJen0a/+c067N3R5vAGFI9Rea3XVFRZJA0
         yZJ8tyVbh0nvTXkgJcpy/6ePnpU9/XnD1LCyhwhbHdXtf2n4d+nQieP04XI0t7tkKL
         O073nwJnsXkjCWM0z/swYomn6MkChKOHk57SAC/o=
Date:   Thu, 27 Oct 2022 11:42:18 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output binding
Message-ID: <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:27:20PM PDT, Zev Weiss wrote:
>On Thu, Sep 29, 2022 at 02:07:14PM PDT, Rob Herring wrote:
>>On Sun, Sep 25, 2022 at 03:03:18PM -0700, Zev Weiss wrote:
>>>This describes a power output supplied by a regulator, such as a
>>>power outlet on a power distribution unit (PDU).
>>>
>>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>---
>>> .../bindings/regulator/regulator-output.yaml  | 47 +++++++++++++++++++
>>> 1 file changed, 47 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>
>>>diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>new file mode 100644
>>>index 000000000000..40953ec48e9e
>>>--- /dev/null
>>>+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>@@ -0,0 +1,47 @@
>>>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>+%YAML 1.2
>>>+---
>>>+
>>>+$id: http://devicetree.org/schemas/regulator/regulator-output.yaml#
>>>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>+
>>>+title: Regulator output connector
>>>+
>>>+maintainers:
>>>+  - Zev Weiss <zev@bewilderbeest.net>
>>>+
>>>+description: |
>>>+  This describes a power output connector supplied by a regulator,
>>>+  such as a power outlet on a power distribution unit (PDU).  The
>>>+  connector may be standalone or merely one channel or set of pins
>>>+  within a ganged physical connector carrying multiple independent
>>>+  power outputs.
>>>+
>>>+properties:
>>>+  compatible:
>>>+    const: regulator-output
>>>+
>>>+  vout-supply:
>>>+    description:
>>>+      Phandle of the regulator supplying the output.
>>>+
>>>+  regulator-leave-on:
>>>+    description: |
>>>+      If the regulator is enabled when software relinquishes control
>>>+      of it (such as when shutting down) it should be left enabled
>>>+      instead of being turned off.
>>>+    type: boolean
>>
>>I'm not too sure about this one as there could be various times when
>>control is relinquished. It is userspace closing its access?
>>driver unbind? module unload? Does a bootloader pay attention to this?
>>
>>Rob
>
>Thanks for the feedback, Rob -- I'll admit I was a bit unsure how to 
>approach that, and this may well not be the right answer.  What I'm 
>really aiming for is an appropriate way to express that regulator 
>on/off state should only ever be changed by explicit (external, e.g. 
>userspace) request, never as any sort of default/automatic action.  
>The two obvious things to guard against there seem to be automatic 
>enablement during initialization and automatic disablement on de-init 
>(shutdown, unbind, etc.).  The former I think can be avoided by simply 
>not setting regulator-boot-on, so I added this as a corresponding 
>property to avoid the latter.
>
>I'm definitely open to suggestions for a better approach though.
>

Ping...

Would something like this be preferable as a more direct description of 
that?

   regulator-manually-controlled:
     description: |
       The regulator should never be enabled or disabled automatically,
       only when explicitly requested by an external actor (e.g.  
       userspace).
     type: boolean

That would leave the question of which property takes priority if both 
regulator-manually-controlled and regulator-boot-on are set -- should 
the binding document the answer to that?  (I personally don't have a 
strong opinion on which it should be.)

Thanks,
Zev

