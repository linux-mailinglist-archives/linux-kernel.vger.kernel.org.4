Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438687399C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjFVIbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjFVIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC21BF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08421617A3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7445C433C9;
        Thu, 22 Jun 2023 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687422689;
        bh=r5F0B/wadeXYMh3pjoY+Vo4P4ka7GMiVE6/63i1qPhg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=U4xC1sLdaRqDdf5i0BR1XC5YIEkPEr3jagCugO4YZd3S69A6b57C/0fL9a88FQiiI
         MnCZcirbPsIdYve9cjVwLVHGCpEvk06gB6Sa8Uwthn1n/MzrBUpXvr0bmB5Mf7hs7F
         /QJzSOuT22cZaUWEGRwKWIwGZElKI0uB2k6AVrCKGOKfrxtEM5KsfmyBN95XXDXjQ8
         /axwFhN7g+9sFEBUyZD7W28Xs6hQPFTBqTMSyzaaVxLY4uuVub/knNarbsDxKXCpt9
         lWloy798n8eVOdpCA4P90G0hADL67eTj1rR19KNOs+COf+5iMqQ6dFFZN3ijYaUT1S
         Xcj06aI/DXV5Q==
Message-ID: <e66f1431-a4fd-07f8-6d34-5f6a358a361a@kernel.org>
Date:   Thu, 22 Jun 2023 10:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] dt-bindings: qcom: Document new msm8916-samsung
 devices
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
 <20230622000254.48260-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230622000254.48260-1-linmengbo0689@protonmail.com>
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

On 22/06/2023 02:03, Lin, Meng-Bo wrote:
> Document the new following device tree bindings used in their
> device trees:
> 
> - samsung,fortuna3g
> - samsung,fortunaltezt
> - samsung,gprimeltecan
> - samsung,grandprimelte
> - samsung,heatqlte
> - samsung,rossa

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

You just ignored maintainers entirely... It's not even about testing but
no one would apply it.

Best regards,
Krzysztof

