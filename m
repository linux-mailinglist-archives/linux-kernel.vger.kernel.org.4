Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4FB6F69C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEDLWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DC46B3;
        Thu,  4 May 2023 04:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CFD6335A;
        Thu,  4 May 2023 11:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DBDC433D2;
        Thu,  4 May 2023 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683199336;
        bh=j0s3N3pOy8Gz9fFwjsVc0+tvIbFfB0Jfs9PLpuQlKA0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jF4HeMZSqYgNrg4LyLYgnIBBdpnjLvpAK/7O9WOVHuOAk1BWrFEmayjOyq7/hqwol
         vt/qx12MgutrpkwvKdZF0zVY071B+aDHRS+wkvLb37p7EzjgYQFZMzWBBIBsaww9eV
         vyq0yq6915RrwOxvyPjHDGqdguBUD/1xlMraSedl9EjqI1XhYI8sITCmjzPV/OzC7y
         pHQ/PhrqJZUdZhFHFkFkrsP+f0ImAkj3PcRkt+v8SQesqzUcyyufCSDwCU1IU72wQu
         hRDxSS0CtmI3wfISTeIlyeMDRN0F0+BKC3LxDWvdHbaAPAViNq+GBf3lvYTM83qdPf
         Lrzgk5W4DVN4g==
Message-ID: <0c7e92e8-886f-59bb-4837-560b2db2ecc3@kernel.org>
Date:   Thu, 4 May 2023 13:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 10/18] dt-bindings: reserved-memory: Add
 qcom,ramoops-minidump binding
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-11-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1683133352-10046-11-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 19:02, Mukesh Ojha wrote:
> Qualcomm ramoops minidump logger provide a means of storing the ramoops data
> to some dynamically reserved memory instead of traditionally implemented
> ramoops where the region should be statically fixed ram region.
> 
> Add qcom,ramoops-minidump binding under "/reserved-memory", and is named
> "qcom,ramoops-minidump" and the reason of naming like this is because
> as it is going to contain ramoops frontend data and this content will
> be collected via Qualcomm minidump infrastructure provided from the
> boot firmware.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Without testing that's a NAK. :(

Best regards,
Krzysztof

