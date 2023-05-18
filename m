Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13D70849B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjERPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjERPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4E19A4;
        Thu, 18 May 2023 08:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526A664FF0;
        Thu, 18 May 2023 15:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22884C433D2;
        Thu, 18 May 2023 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684422278;
        bh=//lGLwIqPEaxoLeWrhrhRFKbAqznv6eIaluNu4Isfmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVaxkX0WJIjb15JkFHGXh9q2lkYsefn+v3jl/UPFKzEYpWEKqQCQC73nAbnyqReq2
         j0nFadIu3hjk7HH9F6o/vPbTLRM9guvg0DCn1vB+qehdic9X9BUbUeKQFV83yP2x1i
         1To7KG10KH0cIycr6MI3ShDRwpXNipIksrukbGT7qTZLvCbpFsK8XXynWqyACBUM+p
         Nxg7/jCx8A3StSRSbDILQz45qSg8CItgEBUFFdmp0jFiy/GKBCBmGl58QcTllb67QT
         Q3nYQc9kqKitQ8LC5vpcYPcz1wCtiSC/G9hWk6e3ZFL1ixluHmL7untJ/RgUXNRGOB
         vatfNGssTIyPA==
Date:   Thu, 18 May 2023 16:04:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mfd: add bindings for AXP192 MFD
 device
Message-ID: <20230518150433.GM404509@google.com>
References: <20230511092609.76183-1-aidanmacdonald.0x0@gmail.com>
 <20230511092609.76183-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511092609.76183-2-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Aidan MacDonald wrote:

> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
> regulators, additional GPIOs, and a different IRQ register layout,
> so it needs a new compatible string.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> v1->v2: Update commit message
>         https://lore.kernel.org/all/20230510151542.312588-2-aidanmacdonald.0x0@gmail.com/
> 
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
