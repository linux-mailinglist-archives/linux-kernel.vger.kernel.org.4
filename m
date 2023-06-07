Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27472634A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjFGOuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbjFGOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964C71BF3;
        Wed,  7 Jun 2023 07:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E546402C;
        Wed,  7 Jun 2023 14:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBE0C433EF;
        Wed,  7 Jun 2023 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686149381;
        bh=UZXWmyrdgPrq2KVSeFy+H+GEAHfry3pcDwYgm6TYohA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o7wQukWrtH47OJFIQHX8NdIWqXZmAaQ81SHn4hOcRBv1jgsTf3Sc91pX2znhks/wK
         lQofQpY/jkk7Xy7DZ+hGL/SkmqMBc0YK4WfqdN7HuiYmwP7+gKqsEdeX0r5FnEanBF
         TLAKLRmNAjnMxbme1d708XaRy+l3VbU9olEzIFocbk0G8JKLnpmp4EDTkwMNLnwDQu
         /0hTsQ6R6b9OAXZ7BSmCoKGwU6+ceAbksusCPPzTL7DjewH0EYQaokxI1gTMHYGprZ
         gUIhk+IKZAsXHsBVBgkra05278/C9Vt1hjrcvZePQSFuyepPJbujWX+6Im8UT22Rg/
         99HcFiZ7pnTfA==
Message-ID: <6ffa4d1b-0015-effc-2b7a-4426eadea84b@kernel.org>
Date:   Wed, 7 Jun 2023 16:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc group IDs
 property
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
References: <1686138864-17136-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686138864-17136-2-git-send-email-quic_ekangupt@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1686138864-17136-2-git-send-email-quic_ekangupt@quicinc.com>
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

On 07/06/2023 13:54, Ekansh Gupta wrote:
> Add "qcom,fastrpc-gids" property to the list of optional properties.
> This property contains the list of privileged group IDs which is
> used to offload process to remote subsystem with increased privileges.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Best regards,
Krzysztof

