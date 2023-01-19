Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A229E674B51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjATEvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjATEum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:50:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704BBFF61;
        Thu, 19 Jan 2023 20:43:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45B7EB82292;
        Thu, 19 Jan 2023 12:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFBEC433D2;
        Thu, 19 Jan 2023 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674130436;
        bh=kvNujVetUBnBdfFPtEOg0jtnfsme9rQYGsNTHFLbznY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TWemGiknLSA1++g+P9cbbapukHT6XTqf0dvDktE8ZcG9t+9XuB8sSZwd7psDiMrwZ
         1Si1Kua989poNMTXIIgyi0aEu2///hJzjTTc3aGCxAJzZTb3CwUwrDsQifQ0/t9q2e
         kBUOP3bdoAxBjs2sL9CJJRJUAPOLYL80KPBgiqpclNU9k+VbbeC/hccmboMLms6P4J
         PkLoqqRdprhjqPLeYqxhlQDCT6SoZtYR5Qp/IPiPj0LrVA8Zfd/m9TgL1WuDFGtStO
         0QWhNZ1wYMSVaLsKarUAPKTAVnGuEHdcFfWJiwFSyTYDToz8Yi06PzOxqhU5YHQ2NT
         zGuNOEKl5FKtg==
Message-ID: <f0c5e40e-e59d-152d-31f1-1ad3da0a6d34@kernel.org>
Date:   Thu, 19 Jan 2023 13:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] ASoC: google: dt-bindings: sc7280: Add platform
 property
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
 <1674108674-8392-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1674108674-8392-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 07:11, Srinivasa Rao Mandadapu wrote:
> Update sc7280 machine driver bindings with platform property for
> supporting ADSP based platform's DAI links.

Subject:
ASoC: dt-bindings: google,sc7280-herobrine:

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Ratna Deepthi Kudaravalli <quic_rkudarv@quicinc.com>

This tested tag is a bit unusual. How were they tested? If
dt_bindings_check why this is not the same person as you (submitter)?

> ---
>  .../devicetree/bindings/sound/google,sc7280-herobrine.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> index 869b403..ccf1b1d 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> @@ -75,6 +75,17 @@ patternProperties:
>  
>          additionalProperties: false
>  
> +      platform:
> +        description: Holds subnode which indicates platform dai.

Neither commit msg nor this here explains why do you need it and what it
really represents. Basically description repeats "platform" name of
property - there is no single new information.

> +        type: object
> +        properties:
> +          sound-dai: true

maxItems

> +
> +        required:
> +          - sound-dai
> +
> +        additionalProperties: false
> +
>      required:
>        - link-name
>        - cpu

Best regards,
Krzysztof

