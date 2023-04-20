Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5E6E9089
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjDTKmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjDTKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:42:28 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B535B1;
        Thu, 20 Apr 2023 03:41:31 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-172-149.tukw.qwest.net [174.21.172.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 4A381218;
        Thu, 20 Apr 2023 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1681987291;
        bh=f9ffG5vWNAAbE4hPrsuUtVJ8N7z1fDEHnFJSi3q7da0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIg0kgLbi9KGz3X9zys2Ipug8r4gGEeF0Z+5uGtOMt+bFeEBE0YK2RPlD2Lq3X48x
         hi9Wkx2OvAFUYJhfeFX0kcFInEO7fmKcAkcRgaxmpRsWhiP1Q5wIIOqXxxL2BY3bnm
         ZgSnnL8GkTcoPvsdnu46wfOeDYOnG7C24sqbzkYc=
Date:   Thu, 20 Apr 2023 03:41:30 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add dt property
Message-ID: <048bf9f4-92ee-4aca-a46f-dbe512129ffe@hatter.bewilderbeest.net>
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
 <0da2b301-8780-48c0-a5dc-326474011e8d@hatter.bewilderbeest.net>
 <9f425205-c395-648a-3f42-a776c7580a8f@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f425205-c395-648a-3f42-a776c7580a8f@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 01:22:30AM PDT, Naresh Solanki wrote:
>Hi Zev,
>
>On 20-04-2023 05:31 am, Zev Weiss wrote:
>>On Tue, Apr 18, 2023 at 07:50:50AM PDT, Naresh Solanki wrote:
>>>Add DT property regulator-supplies.
>>>This enables us to couple one or more regulator output to gether. This
>>>is use in case of Single connector having 2 or more supplies.
>>>
>>>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>---
>>>.../bindings/regulator/regulator-output.yaml         | 12 +++++++++---
>>>1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>>diff --git 
>>>a/Documentation/devicetree/bindings/regulator/regulator-output.yaml 
>>>b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>index 078b37a1a71a..17f683d3c1f3 100644
>>>--- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>+++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>@@ -21,13 +21,19 @@ properties:
>>>  compatible:
>>>    const: regulator-output
>>>
>>>-  vout-supply:
>>>+  regulator-supplies:
>>>    description:
>>>-      Phandle of the regulator supplying the output.
>>>+      Specifies the name of the output supply provided by the regulator.
>>>+      Defaults to "vout".
>>>+    default: "vout"
>>>+
>>
>>Was this meant to be specified as a string-array to allow providing 
>>multiple names?
>Yes. This is string-array.

Okay -- in that case I think it should include

   $ref: /schemas/types.yaml#/definitions/string-array

>>
>>>+patternProperties:
>>>+  ".*-supply":
>>>+    description:
>>>+      Specified the phandle for various supplies
>>>
>>>required:
>>>  - compatible
>>>-  - vout-supply
>>>
>>>additionalProperties: false
>>>
>>>
>>
>>I think it would be nice to also update the examples to show what a 
>>multi-supply instance would look like.
>Ack. Will do that.
>>
>>A slightly more descriptive subject line would also be good -- "Add 
>>dt property" is a bit vague.
>Suggestion ?
>How about like 'Allow multiple supplies' or 'Add support for multiple 
>supplies'

Sure, both of those sound fine to me.

>>
>>>base-commit: c55470f8b0616b0adb758077dbae9b19c5aac005
>>>-- 
>>>2.39.1
>>>
>Regards,
>Naresh
