Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310AC68C4EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBFRdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBFRdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:33:49 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBB13530;
        Mon,  6 Feb 2023 09:33:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E066E37A;
        Mon,  6 Feb 2023 17:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E066E37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675704824; bh=bxpMIQTulRiHIjzFDn4/o6sccRJtixJZ1itZAedrBJQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dffvk4W92W7ZELTcA5xilampJZcxb2kUoF3Jqvvr4K/xIOSDLwd9sza7Zl9maWzws
         crVsDzO4aIK4DZnu5hkCIAeMx2STRjM/B7Hv+RY/L2J4AI7x19sgtklzJcoY67LQo+
         y9IeTQP/kqnggiXfb2E3C4as4QwuSJ/BHCuaLTxe+yYrP/GCRzOAuhjZPK1Ct7Q9Ob
         Wr//PcEXlH4t74/FWRIunkXNo5BgAFau3+ij0h6g1CjGfMygeg2PyFo3+IalAVKWJA
         bag6dksG/0dwd46+Yf/dNSoVyul0BByHwGTLNfeRMPRwEIee41KfNw9VezAmRhd7Rz
         2/LQenAzRW2pg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, andersson@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH] Documentation: leds: Fix warning from leds-qcom-lpg
In-Reply-To: <1675700261-25531-1-git-send-email-quic_jhugo@quicinc.com>
References: <1675700261-25531-1-git-send-email-quic_jhugo@quicinc.com>
Date:   Mon, 06 Feb 2023 10:33:42 -0700
Message-ID: <87y1par955.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> "make htmldocs" generates a warning about leds-qcom-lpg -
> "Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included
> in any toctree"
>
> Add leds-qcom-lpg to the leds index to fix this warning.
>
> Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  Documentation/leds/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
> index e5d63b9..014e009 100644
> --- a/Documentation/leds/index.rst
> +++ b/Documentation/leds/index.rst
> @@ -25,4 +25,5 @@ LEDs
>     leds-lp5562
>     leds-lp55xx
>     leds-mlxcpld
> +   leds-qcom-lpg
>     leds-sc27xx

Already fixed in docs-next.

Thanks,

jon
