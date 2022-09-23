Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA85E828F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiIWT1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIWT1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:27:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810912CC89;
        Fri, 23 Sep 2022 12:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C26B8256E;
        Fri, 23 Sep 2022 19:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0795C433D7;
        Fri, 23 Sep 2022 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663961269;
        bh=cHBC8AI9eDu1w66z2zHQctsP25iT8XiUq9eJQuOGzsI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GuauctvMqggnH/b+MhaZtf0sjt+OJvGYTUqzZ3j875t5ySYbR/HVrNVt1ZfJ7pNV6
         oe0JoreT9bol71iSkCSLN/jDa1LwEQVGVGM/QypM5SbDcFyAjhs6qJpZAhsw1cQgrn
         LSUsXs2qaViiItdIw571ejiI8nFwbbv1roCF9Mwkh02ctPC1y/3yf4HEoKDIaolF8p
         W6sONNh7V9D22i0v0ekYLRHFwnoUxdNr/T/jT1uNjrH1+AIRk8eybN+pbr3/F7VaQV
         JaQAQaNBUJXFJLk+jYMJaK/UmDm2EPiUfD3tiStJqOvyI/65VJ+DzCmDUZd/Bdk0vp
         KXPLveM06GZYQ==
Message-ID: <f09fabec-f5a3-df21-f776-956732d60359@kernel.org>
Date:   Fri, 23 Sep 2022 21:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V13 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <c6b55a5b44a8add13ea9015542522b2562cf8f60.1663642052.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c6b55a5b44a8add13ea9015542522b2562cf8f60.1663642052.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 05:56, Souradeep Chowdhury wrote:
> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Rebase your tree on some current Linux kernel (and use
scripts/get_maintainers.pl).

Best regards,
Krzysztof

