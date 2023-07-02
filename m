Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235A744CF3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGBJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC1E4D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 02:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B426009F
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE8AC433C8;
        Sun,  2 Jul 2023 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688289988;
        bh=jDjXLZS4xskhF9xKHlR/TzQY4C2waLuBsRs6CQkcNrQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lOCZjl53b1g0u1GR783HiiD7Y4ezT1GQE0erg+jbTxsX682DX1TJ9y0n2ClNHbdeJ
         SPwtMhfH0hbnI/X0Fdp9gTw63bIC+OPQV4YVTkFNMGyZbYhdGOKbHtUpy5mX8Kuicu
         QxSFfM8DTO289qj6iQrdFjzXqbuMqEkpEChc3GyD/uorC2432psgaRbfQST//5j15r
         snohMXr4a31agoqLjdfcjJBynnhmOYWUdu30Hio5Ef7FJKsxTbTlhax3yza+uSfg5L
         FnzvSK07EtFuh5teuTHYQKl+iCN4vAtcdxAdEVe3vaBzR930ebC9FzI2JmJun/FY+7
         56Gxz4tK0UO4w==
Message-ID: <072ebe3f-7922-1d1d-ea19-2ac75ac4f557@kernel.org>
Date:   Sun, 2 Jul 2023 11:26:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] dt-bindings: perf: marvell: Add YAML schemas for
 Marvell Odyssey LLC-TAD pmu
Content-Language: en-US
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, bbhushan2@marvell.com, gcherian@marvell.com,
        lcherian@marvell.com
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-5-gthiagarajan@marvell.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230630120351.1143773-5-gthiagarajan@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 14:03, Gowthami Thiagarajan wrote:
> Add device tree bindings for Marvell Odyssey LLC-TAD performance
> monitor unit
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

> ---
>  .../bindings/perf/marvell-odyssey-tad.yaml    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml
> new file mode 100644
> index 000000000000..139567166f77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-odyssey-tad.yaml

Filename does not match compatible.



> +examples:
> +  - |
> +
> +    tad {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        tad_pmu@80000000 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "marvell,odyssey-tad-pmu";
> +            reg = <0x87E2 0x2B030000 0x0 0x1000>;

lowercase hex

Best regards,
Krzysztof

