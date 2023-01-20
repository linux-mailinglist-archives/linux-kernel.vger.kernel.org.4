Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690F6674F98
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjATIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:39:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9804C79E9E;
        Fri, 20 Jan 2023 00:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52316B820E7;
        Fri, 20 Jan 2023 08:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631B6C433D2;
        Fri, 20 Jan 2023 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674203981;
        bh=PqacJqzWuhZ/sTctph58tZmF4cPXBRe6lvo/FbCrxAo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=oEdv+o/oIiJvbvb2MTwCQPDAFmjW5PM3gz2kaHT6ioZ9JBkZ1WpaAOSaYmlYS2KUo
         S4K5toI4rKITQiKwzwpff28AjM8oibYi/pz+fL2NDO51A5WJbX5hle1CpNjUuJA1zC
         cdychihOdqjDyw/WFT+6fepzZjfIllMN7nL7zFLUVHU8ReI+laGCCeTyK2zd/PohVr
         qiggQ3LurZJ8ukwnNZKy+vCKzbWXDO6ubbdY21cyHC/qs634zTgpf1fX7bpOPFQ/Kx
         0u8nxKvMBSjoqBnphc5duqZyhxGP9/OOP07D3g8B0B23LAjuhlxjZpDcydpuXR2SQt
         EqFm44/gKiLCw==
Message-ID: <f2105f0e-3176-5542-32d0-adcf36eb1c08@kernel.org>
Date:   Fri, 20 Jan 2023 09:39:29 +0100
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
 <f0c5e40e-e59d-152d-31f1-1ad3da0a6d34@kernel.org>
 <9c4d2ce8-11e0-bfbb-7062-078255d1d60b@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <9c4d2ce8-11e0-bfbb-7062-078255d1d60b@quicinc.com>
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

On 20/01/2023 08:36, Srinivasa Rao Mandadapu wrote:
>> Neither commit msg nor this here explains why do you need it and what it
>> really represents. Basically description repeats "platform" name of
>> property - there is no single new information.
> Will modify accordingly and re-spin.
>>
>>> +        type: object
>>> +        properties:
>>> +          sound-dai: true
>> maxItems
> Sorry. why max items required here?

Because we want bindings to be specific.

Best regards,
Krzysztof

